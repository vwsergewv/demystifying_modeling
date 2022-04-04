# snowflake sample data demo

  - name: sflk_data

    tables:
      - name: customer
        columns:
          - name: c_custkey
            description: ""
          - name: c_name
            description: ""
          - name: c_address
            description: ""
          - name: c_nationkey
            description: ""
          - name: c_phone
            description: ""
          - name: c_acctbal
            description: ""
          - name: c_mktsegment
            description: ""
          - name: c_comment
            description: ""


      - name: orders
        columns:
          - name: o_orderkey
            description: ""
          - name: o_custkey
            description: ""
          - name: o_orderstatus
            description: ""
          - name: o_totalprice
            description: ""
          - name: o_orderdate
            description: ""
          - name: o_orderpriority
            description: ""
          - name: o_clerk
            description: ""
          - name: o_shippriority
            description: ""
          - name: o_comment
            description: ""

      - name: part
        columns:
          - name: p_partkey
            description: ""
          - name: p_name
            description: ""
          - name: p_mfgr
            description: ""
          - name: p_brand
            description: ""
          - name: p_type
            description: ""
          - name: p_size
            description: ""
          - name: p_container
            description: ""
          - name: p_retailprice
            description: ""
          - name: p_comment
            description: ""

      - name: partsupp
        columns:
          - name: ps_partkey
            description: ""
          - name: ps_suppkey
            description: ""
          - name: ps_availqty
            description: ""
          - name: ps_supplycost
            description: ""
          - name: ps_comment
            description: ""


      - name: supplier
        columns:
          - name: s_suppkey
            description: ""
          - name: s_name
            description: ""
          - name: s_address
            description: ""
          - name: s_nationkey
            description: ""
          - name: s_phone
            description: ""
          - name: s_acctbal
            description: ""
          - name: s_comment
            description: ""       