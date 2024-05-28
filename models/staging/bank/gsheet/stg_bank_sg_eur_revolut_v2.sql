with
    source as (select * from {{ source("google_sheets", "sg_eur_revolut_v2") }}),
    renamed as (
        select
            'revolut-eur' as source,
            date(
                parse_datetime('%d/%m/%Y %H:%M', {{ adapter.quote("started_date") }})
            ) as local_date,
            'EUR' as local_currency,
            safe_cast({{ adapter.quote("amount") }} as float64) as local_amount,
            {{ adapter.quote("category") }} as category,
            {{ adapter.quote("description") }} as description
        from source
    )
select *
from renamed
