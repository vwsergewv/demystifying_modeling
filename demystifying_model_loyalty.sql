{{
  config(
    materialized = "table",
    post_hook=[
      "alter table {{this}} add  CONSTRAINT PK_127 PRIMARY KEY ( L_LOYALTYKEY )", 
      "alter table {{this}} add  CONSTRAINT  FK_135 FOREIGN KEY ( L_CUSTKEY ) REFERENCES SFLK_DATA.CUSTOMER ( C_CUSTKEY )"
    ]           
  )
}}

with cust as (

    select
        c_custkey,
        c_name,
        c_address,
        c_nationkey,
        c_phone,
        c_acctbal,
        c_mktsegment,
        c_comment
    from {{ source('sflk_data', 'customer') }}

)

, ord as (

  select 
        o_orderkey,
        o_custkey,
        o_orderstatus,
        o_totalprice,
        o_orderdate,
        o_orderpriority,
        o_clerk,
        o_shippriority,
        o_comment
   from {{ source('sflk_data', 'orders') }}
)

, cust_ord as ( 

    select o_custkey, sum(o_totalprice) as o_totalprice from (
            select  o.*, c.*
            from ord o 
            inner join cust c 
            on o.o_custkey = c_custkey
            where true 
            and c_acctbal > 0 --no deadbeats 
            and c_nationkey != 22 -- Excluding Russia from loyalty program will send strong message to Putin
    )
    group by 1
)

, business_logic as (
    select *

    , dense_rank() OVER  ( order by o_totalprice desc ) as cust_level 
    
    , case 
        when   cust_level between 1 and 20 then 'gold'
        when   cust_level between 21 and 100 then 'silver'
        when   cust_level between 101 and 400 then 'bronze'
               end as loyalty_level

    from cust_ord
    where true 
    qualify cust_level <= 400
    order by cust_level asc
)  

, early_supporters as (

-- the first five customers who believed in us
    select column1 as o_custkey from values (349642), (896215) , (350965) , (404707), (509986)
)


, all_loyalty as (

select
left(loyalty_level, 1 ) ||  '|' || o_custkey as l_loyaltykey
, o_custkey
, loyalty_level
, 'rule-based' as l_type
from business_logic 

union all 

select 
'g|' || o_custkey as l_loyaltykey
, o_custkey
, 'gold' as loyalty_level
, 'supporter' as l_type
from early_supporters
)

, rename as (

select 
  l_loyaltykey
, o_custkey as l_custkey
, loyalty_level as l_name 
, l_type
, '' as l_comments

 from all_loyalty

)

select * from rename 
where true 