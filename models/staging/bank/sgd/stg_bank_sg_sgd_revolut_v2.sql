with
    source as (select * from {{ source("bank", "sg_sgd_revolut_v2") }}),
    renamed as (
        select
            date(
                parse_datetime('%d/%m/%Y %H:%M', {{ adapter.quote("started_date") }})
            ) as local_date,
            'SGD' as local_currency,
            {{ adapter.quote("amount") }} as local_amount,
            {{ adapter.quote("category") }} as category,
            {{ adapter.quote("description") }} as description
        from source
    )
select *
from renamed