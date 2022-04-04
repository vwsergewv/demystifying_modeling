create or replace TRANSIENT TABLE SFLK_DATA.LOYALTY (
	L_LOYALTYKEY VARCHAR(16777216) COMMENT 'unique loyalty id consisting of first letter of status and customer id',
	L_CUSTKEY NUMBER(38,0) COMMENT 'unique customer key from table customers',
	L_NAME VARCHAR(16777216) COMMENT 'customer full name',
	L_TYPE VARCHAR(10) COMMENT 'loyalty tier: bronze, silver, or gold',
	L_COMMENTS VARCHAR(1) COMMENT 'extra info',
	constraint PK_127 primary key (L_LOYALTYKEY),
	constraint FK_135 foreign key (L_CUSTKEY) references SQLDBM_DEMO.SFLK_DATA.CUSTOMER(C_CUSTKEY)
)COMMENT='client loyalty program with gold, silver, bronze status'
;

create or replace TRANSIENT TABLE EDW.PARTS_SUPPLIER (
	PS_PARTKEY NUMBER(38,0) COMMENT 'part of unique identifier with ps_suppkey ',
	PS_SUPPKEY NUMBER(38,0) COMMENT 'part of unique identifier with ps_partkey ',
	PS_AVAILQTY NUMBER(38,0) COMMENT 'number of parts available for sale',
	PS_SUPPLYCOST NUMBER(12,2) COMMENT 'original cost paid to supplier',
	P_NAME VARCHAR(199) COMMENT 'part full name',
	P_MFGR VARCHAR(25) COMMENT 'part manufacturer',
	P_BRAND VARCHAR(10) COMMENT 'part brand',
	P_TYPE VARCHAR(25),
	P_SIZE NUMBER(38,0),
	P_CONTAINER VARCHAR(10),
	P_RETAILPRICE NUMBER(12,2),
	S_NAME VARCHAR(23) COMMENT 'supplier full name',
	S_ADDRESS VARCHAR(40),
	S_NATIONKEY NUMBER(38,0) COMMENT 'supplier nation id, join with nation table for name',
	S_PHONE VARCHAR(15),
	S_ACCTBAL NUMBER(12,2) COMMENT 'supplier account balance',
	S_COMMENT VARCHAR(101),
	constraint PK_PSATTR primary key (PS_PARTKEY, PS_SUPPKEY),
	constraint FK_PSATTR_P foreign key (PS_PARTKEY) references SQLDBM_DEMO.SFLK_DATA.PART(P_PARTKEY),
	constraint FK_PSATTR_S foreign key (PS_SUPPKEY) references SQLDBM_DEMO.SFLK_DATA.SUPPLIER(S_SUPPKEY),
	constraint FK_PSATTR_PS foreign key (PS_PARTKEY, PS_SUPPKEY) references SQLDBM_DEMO.SFLK_DATA.PARTSUPP(PS_PARTKEY,PS_SUPPKEY)
)COMMENT='denormalize table consisting of part_supp transactional, and part and supp master data '
;
