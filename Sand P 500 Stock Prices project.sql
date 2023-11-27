CREATE TABLE IF NOT EXISTS stock_data(
	symbol VARCHAR,
	date DATE,
	open NUMERIC,
	high NUMERIC,
	low NUMERIC,
	close NUMERIC,
	volume INT);
	
	
----import your file into the table


select * from stock_data

--QUESTION1 i
--Which date in the sample saw the largest overall trading volume? On that date, 
--which two stocks were traded most?
SELECT 
	date,SUM(volume) AS total_volume
FROM
	stock_data
GROUP BY 
	date
ORDER BY total_volume DESC
LIMIT 1;

SELECT
 date
 FROM(SELECT 
	date,SUM(volume) AS total_volume
FROM
	stock_data
GROUP BY 
	date
ORDER BY total_volume DESC
LIMIT 1)trading_volume;

--QUESTION 1 ii
SELECT
	symbol, date, volume
FROM 
	stock_data
WHERE date =(SELECT
 date
 FROM(SELECT 
	date,SUM(volume) AS total_volume
FROM
	stock_data
GROUP BY 
	date
ORDER BY total_volume DESC
LIMIT 1)trading_volume)
ORDER BY symbol DESC
LIMIT 2;


--QUESTION 2
--On which day of the week does volume tend to be highest? Lowest?
--usning the TO_CHAR function


---highest
SELECT
	 to_char(date,'day') AS day_of_week , SUM(volume) AS total_volume
FROM
	stock_data
GROUP BY 
	day_of_week
ORDER BY
	total_volume DESC
LIMIT 1;

--lowest

SELECT
	 to_char(date,'day') AS day_of_week , SUM(volume) AS total_volume
FROM
	stock_data
GROUP BY 
	day_of_week
ORDER BY
	total_volume ASC
LIMIT 1;

--QUESTION 3
--On which date did Amazon (AMZN) see the most volatility, 
--measured by the difference between the high and low price?
SELECT
	symbol,date,(high-low) AS difference
FROM
	stock_data
WHERE symbol = 'AMZN'
ORDER BY difference DESC
LIMIT 1;

-- QUESTION 4
--If you could go back in time and invest in one stock from 1/2/2014 - 12/29/2017, 
--which would you choose? What % gain would you realize?
--N:B
--opening price is seling price,closing price is purchase price 
--% gain = ((close-open)/open)*100

SELECT
	symbol, date, ((close-open)/open)*100 AS percentage_gain
FROM 
	stock_data
ORDER BY percentage_gain DESC


SELECT
	*
FROM
	(SELECT
	symbol, date, ((close-open)/open)*100 AS percentage_gain
FROM 
	stock_data
ORDER BY percentage_gain DESC)best_stock
WHERE percentage_gain IS NOT NULL
LIMIT 1;

	
	
	
