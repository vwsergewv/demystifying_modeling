{{
  config(
    materialized = "table",
    post_hook=[
      "alter table {{this}} add  CONSTRAINT PK_PSATTR PRIMARY KEY ( PS_PARTKEY, PS_SUPPKEY )", 
      "alter table {{this}} add  CONSTRAINT  FK_PSATTR_P  FOREIGN KEY ( PS_PARTKEY ) REFERENCES {{ source('sflk_data', 'part') }} ( P_PARTKEY )",
      "alter table {{this}} add  CONSTRAINT  FK_PSATTR_S  FOREIGN KEY ( PS_SUPPKEY ) REFERENCES  {{ source('sflk_data', 'supplier') }}  ( S_SUPPKEY )",
      "alter table {{this}} add  CONSTRAINT  FK_PSATTR_PS FOREIGN KEY ( PS_PARTKEY, PS_SUPPKEY ) REFERENCES  {{ source('sflk_data', 'partsupp') }}  ( PS_PARTKEY, PS_SUPPKEY )"
    ]           
  )
}}


select
--ps-- 
PS_PARTKEY, PS_SUPPKEY, PS_AVAILQTY, PS_SUPPLYCOST, PS_COMMENT
--p--
P_NAME, P_MFGR, P_BRAND, P_TYPE, P_SIZE, P_CONTAINER, P_RETAILPRICE, P_COMMENT
--s--
S_NAME, S_ADDRESS, S_NATIONKEY, S_PHONE, S_ACCTBAL, S_COMMENT
from    {{ source('sflk_data', 'partsupp') }} ps 
inner join {{ source('sflk_data', 'part') }} p  
on p.P_PARTKEY = ps.PS_PARTKEY 
INNER JOIN  {{ source('sflk_data', 'supplier') }} s 
ON ps.PS_SUPPKEY = s.S_SUPPKEY 
