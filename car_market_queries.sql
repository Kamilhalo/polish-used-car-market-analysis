-- Filtrowanie i standaryzacja danych

-- Sprawdzenie poprawnego wczytania danych 

SELECT *
FROM Car_sale_ads
LIMIT 20;

-- Sprawdzenie anomalii cenowych 

SELECT MIN(price), MAX(price)
FROM Car_sale_ads;

-- Sprawdzenie pustych wartości

SELECT COUNT(*)
FROM Car_sale_ads
WHERE Production_year IS NULL OR Mileage_km IS NULL;

-- Bazowe zapytanie filtrujące śmieciowe dane i samochody zabytkowe

SELECT * 
FROM Car_sale_ads
WHERE price > 5000 AND price < 500000
	AND Production_year IS NOT NULL
	AND Mileage_km IS NOT NULL
	AND Production_year >= 2000;

--Sprawdzenie najpopularniejszych marek

SELECT Vehicle_brand, COUNT(*) AS Liczba_ofert
FROM Car_sale_ads
WHERE price > 5000 AND price < 500000
	AND Production_year IS NOT NULL
	AND Mileage_km IS NOT NULL
	AND Production_year >= 2000
GROUP BY Vehicle_brand 
ORDER BY liczba_aut DESC;


-- ==========================================
-- EKSPLORACYJNA ANALIZA DANYCH (EDA)
-- ==========================================

-- Segmentacja rynku według przebiegu i analiza wpływu na cenę

SELECT 
	CASE
		WHEN Mileage_km < 100000 THEN '1. Niski przebieg (do 100 tys.)'
		WHEN Mileage_km <= 200000 THEN '2. Średni przebieg (do 200 tys.)'
		ELSE '3. Wysoki przebieg (powyżej 200tys.)'
	END AS Kategoria_przebiegu,
	COUNT(*) AS Liczba_ofert,
	ROUND(AVG(price), 0) AS Srednia_cena
FROM Car_sale_ads
WHERE price > 5000 AND price < 500000
	AND Production_year IS NOT NULL
	AND Mileage_km IS NOT NULL
	AND Production_year >= 2000
GROUP BY Kategoria_przebiegu
ORDER BY Kategoria_przebiegu ASC;

-- Analiza utraty wartości w zależności od rocznika

SELECT 
	Production_year,
	COUNT(*) AS Liczba_ofert,
	ROUND(AVG(price),0) AS Srednia_cena
FROM Car_sale_ads
WHERE price > 5000 AND price < 500000
	AND Production_year IS NOT NULL
	AND Mileage_km IS NOT NULL
	AND Production_year >= 2000
GROUP BY Production_year
ORDER BY Production_year DESC;

-- Analiza 5 najpopularniejszych marek

SELECT 
	Vehicle_brand,
	COUNT(*) AS Liczba_ofert,
	ROUND(AVG(price),0) AS Srednia_cena
FROM Car_sale_ads
WHERE price > 5000 AND price < 500000
	AND Production_year IS NOT NULL
	AND Mileage_km IS NOT NULL
	AND Production_year >= 2000
GROUP BY Vehicle_brand
ORDER BY Liczba_ofert DESC
LIMIT 5;

