WITH standardized_date AS (
	SELECT
		CAST(
			CASE
				WHEN order_date LIKE '% %' THEN
					REGEXP_REPLACE(
						SPLIT_PART(order_date, ' ', 1),
						'(\d{4})-(\d{2})-(\d{2})',
						'\2-\3-\1',
						'g'
					)
				ELSE
					REGEXP_REPLACE(
						order_date,
						'(\d{1,2})/(\d{2})/(\d{4})',
						'\2-\1-\3',
						'g'
					)
			END AS DATE
		) AS order_date,
		category,
		sales,
		quantity,
		discount,
		profit
	FROM
		data.superstore
),

cleaned_data AS (
	SELECT
		order_date,
		EXTRACT(YEAR FROM order_date) AS order_year,
		TRIM(TO_CHAR(order_date, 'Month')) AS order_month,
		EXTRACT(MONTH FROM order_date) AS month_number,
		category,
		sales,
		quantity,
		discount * 100 AS discount,
		profit
	FROM
		standardized_date
)

SELECT
	*
FROM
	cleaned_data
WHERE
	order_year = 2017
;