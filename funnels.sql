WITH top_countries -- canculating perc drop per each event/country
AS 
(
        WITH 
      unique_events AS -- calculating count of events for TOP 3 countries and 5 events only
        (
          WITH 
        distinct_events AS -- identifying only one distinct event per user id
            (
              SELECT 
              user_pseudo_id,
              event_name,
            MIN (event_timestamp) AS event_timestamp,

            FROM tc-da-1.turing_data_analytics.raw_events 

            GROUP BY 1,2
            )

        SELECT 
          re.event_name,
          re.event_timestamp,
          re.event_date,
          re.event_value_in_usd,
          re.user_id,
          de.user_pseudo_id,
          re.user_first_touch_timestamp,
          re.category,
          re.mobile_model_name,
          re.mobile_brand_name,
          re.operating_system,
          re.language,
          re.is_limited_ad_tracking,
          re.browser,
          re.browser_version,
          re.country,
          re.medium,
          re.name,
          re.traffic_source,
          re.platform,
          re.total_item_quantity,
          re.purchase_revenue_in_usd,
          re.refund_value_in_usd,
          re.shipping_value_in_usd,
          re.tax_value_in_usd,
          re.transaction_id,
          re.page_title,
          re.page_location,
          re.source,
          re.page_referrer,
          re.campaign

        FROM 
        tc-da-1.turing_data_analytics.raw_events AS re
          INNER JOIN distinct_events AS de
            ON re.user_pseudo_id = de.user_pseudo_id AND re.event_name = de.event_name AND re.event_timestamp = de.event_timestamp

        /*WHERE de.user_pseudo_id = '28922323.3516501120' */
        )

      SELECT 
      ROW_NUMBER() OVER () AS event_order,
      event_name,
      SUM (CASE WHEN country = 'United States' THEN 1 ELSE 0 END) AS US_events,
      SUM (CASE WHEN country = 'India' THEN 1 ELSE 0 END) AS India_events,
      SUM (CASE WHEN country = 'Canada' THEN 1 ELSE 0 END) AS Canada_events,
      ((SUM (CASE WHEN country = 'United States' THEN 1 ELSE 0 END)) + (SUM (CASE WHEN country = 'India' THEN 1 ELSE 0 END)) + (SUM (CASE WHEN country = 'Canada' THEN 1 ELSE 0 END))) AS Total,
        LEAD (((SUM (CASE WHEN country = 'United States' THEN 1 ELSE 0 END)) + (SUM (CASE WHEN country = 'India' THEN 1 ELSE 0 END)) + (SUM (CASE WHEN country = 'Canada' THEN 1 ELSE 0 END)))) OVER (ORDER BY ((SUM (CASE WHEN country = 'United States' THEN 1 ELSE 0 END)) + (SUM (CASE WHEN country = 'India' THEN 1 ELSE 0 END)) + (SUM (CASE WHEN country = 'Canada' THEN 1 ELSE 0 END)))) AS sum_before, -- long version of LEAD (Total) OVER (ORDER BY Total) AS sum_before
        LEAD (SUM (CASE WHEN country = 'United States' THEN 1 ELSE 0 END)) OVER (ORDER BY SUM (CASE WHEN country = 'United States' THEN 1 ELSE 0 END)) AS US_previous_value, -- long version of LEAD (US_events) OVER (ORDER BY US_events)
        LEAD (SUM (CASE WHEN country = 'India' THEN 1 ELSE 0 END)) OVER (ORDER BY SUM (CASE WHEN country = 'India' THEN 1 ELSE 0 END)) AS India_previous_value, -- long version of LEAD (India_events) OVER (ORDER BY India_events)
        LEAD (SUM (CASE WHEN country = 'Canada' THEN 1 ELSE 0 END)) OVER (ORDER BY SUM (CASE WHEN country = 'Canada' THEN 1 ELSE 0 END)) AS Canada_previous_value -- long version of LEAD (Canada_events) OVER (ORDER BY Canada_events)

      FROM unique_events

      WHERE 
      event_name IN ('session_start','view_item' , 'add_to_cart' , 'begin_checkout' , 'purchase')

      GROUP BY 
      event_name

      ORDER BY
      US_events DESC
)

SELECT 
  event_order,
  event_name,
  US_events,
  India_events,
  Canada_events,
  CASE WHEN round (Total/sum_before,4) IS NOT NULL THEN round (Total/sum_before,4) ELSE 1 END AS Full_perc, -- not vice verca due to the sum_before column showing value from previous row. Taip turetu buti atvirksciai, kad procentus gautum teisingus.
  CASE WHEN round (US_events/US_previous_value,4) IS NOT NULL THEN round (US_events/US_previous_value,4) ELSE 1 END AS US_perc_drop,
  CASE WHEN round (India_events/India_previous_value,4) IS NOT NULL THEN round (India_events/India_previous_value,4) ELSE 1 END AS India_perc_drop,
  CASE WHEN round (Canada_events/Canada_previous_value,4) IS NOT NULL THEN round (Canada_events/Canada_previous_value,4) ELSE 1 END AS Canada_perc_drop

FROM top_countries

ORDER BY
US_events DESC
