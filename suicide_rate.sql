CREATE DATABASE IF NOT EXISTS suicide;

CREATE TABLE IF NOT EXISTS suicide(
country       VARCHAR(40)    NOT NULL   PRIMARY KEY,
gdp_capita    INT        NOT NULL,
suicide_rate   DECIMAL(3,1)   NOT NULL
);

CREATE TABLE IF NOT EXISTS   lifeexp(
country    VARCHAR(40)    NOT NULL   PRIMARY KEY,
life_expectancy_men    DECIMAL(3,1)    NOT NULL,
life_expectancy_women  DECIMAL(3,1)   NOT NULL,
happiness_score       DECIMAL(4,3)    NOT NULL,
fertility_rate        DECIMAL(2,1)   NOT NULL
);
-------- MY GOAL IS TO REVEAL CERTAIN FACTORS OF SUICIDE AND SEE WHY SOME COUNTRIES MAY HAVE HIGHER SUICIDE RATES THAN OTHERS. DOES HAPPINESS PLAY A ROLE? HOW ABOUT FERTILITY RATE?-------------------
-------- GENERIC QUESTIONS ---------------------
-- How many countries are we comparing?
SELECT COUNT(*) FROM suicide;

-- What is the average life expectancy for men?
SELECT AVG(life_expectancy_men) FROM lifeexp;

-- 72.23

-- What is the average life expectancy for women?
SELECT AVG(life_expectancy_women)  FROM lifeexp;

-- 77.14

-- What is the overall average fertility rate between countries?

-- 2.72
-- Which country has the highest fertility rate?
SELECT fertility_rate, country
FROM lifeexp
ORDER BY fertility_rate DESC;

-- Which country has the lowest fertility rate?
SELECT fertility_rate, country
FROM lifeexp
ORDER BY fertility_rate;

-- Which country has the highest GDP per capita?
SELECT gdp_capita, country
FROM suicide
ORDER BY gdp_capita DESC;

-- Which country has the highest happiness score?
SELECT happiness_score, country
FROM lifeexp
ORDER BY happiness_score DESC;

-- Which country has the lowest happiness score?
SELECT happiness_score, country
FROM lifeexp
ORDER BY happiness_score;

-- Which country has the highest suicide rate?
SELECT suicide_rate, country
FROM suicide
ORDER BY suicide_rate DESC;

-- Which country has the lowest suicide rate?
SELECT suicide_rate, country
FROM suicide
ORDER BY suicide_rate;

---------------------- Life expectancy and Suicide rates---------------------------------------------------------
-- What is the average suicide rate per country?
SELECT ROUND(AVG(suicide_rate),2)
FROM suicide;

-- 15.98

-- Which country has the highest suicide rate for men? Do they have a low life expectancy?
SELECT suicide_rate, life_expectancy_men, suicide.country
FROM lifeexp, suicide
WHERE lifeexp.country = suicide.country
ORDER BY suicide_rate DESC;

-- Armenia. Meets with average life expectancy.

-- Is women's life expectancy close to the average as well?
SELECT suicide_rate, life_expectancy_women, suicide.country
FROM lifeexp, suicide
WHERE lifeexp.country = suicide.country
ORDER BY suicide_rate DESC;

-- Slightly over the average life exp for women.

-- What country has the lowest suicide rate? How do they rank in life expectancy for women?
SELECT suicide_rate, life_expectancy_women, suicide.country
FROM lifeexp, suicide
WHERE lifeexp.country = suicide.country
ORDER BY suicide_rate;

-- Pakistan. Life expectancy is below average.

---------------------- Suicide Rate with GDP per capita-----------------------------------
-- Do countries that exhibit higher levels of GDP have less suicide rates?
SELECT ROUND(AVG(gdp_capita),2) FROM suicide;

-- 15978.80

SELECT ROUND(AVG(suicide_rate),2)
FROM suicide
WHERE gdp_capita > 15978;

-- 15.09

SELECT ROUND(AVG(suicide_rate),2)
FROM suicide
WHERE gdp_capita < 15978;

-- 16.32. Seems like there is a slight increase with countries under the avg gdp_capita.

-- Compare the country with the highest suicide rate to the lowest with gdp per capita.
SELECT gdp_capita, country, suicide_rate
FROM suicide
ORDER BY gdp_capita DESC;

SELECT gdp_capita, country, suicide_rate
FROM suicide
ORDER BY gdp_capita;

-- Suicide rate is about the same.

------------------------- Suicide Rate with Fertility Rate---------------------------------------------------
-- Which country has the highest fertility rate?
SELECT fertility_rate, country
FROM lifeexp
ORDER BY fertility_rate DESC;

-- Niger

-- Which country has the lowest fertility rate?
SELECT fertility_rate, country
FROM lifeexp
ORDER BY fertility_rate;

-- Korea Rep.

-- What is Nigers suicide rate?
SELECT suicide_rate, country
FROM suicide
WHERE country = 'Niger';

-- 12.7

---------------------- Happiness Score with Suicide------------------------------------------------------------------
-- What is the average happiness score?
SELECT AVG(happiness_score) FROM lifeexp;

-- 5.59

-- What is the country's, who has the lowest happiness score, suicide rate?
SELECT happiness_score, suicide_rate, suicide.country
FROM lifeexp, suicide
WHERE lifeexp.country = suicide.country
ORDER BY happiness_score;

-- Centrak African Republic.. suicide rate is 14.5.

-- -- What is the country's, who has the highest happiness score, suicide rate?
SELECT happiness_score, suicide_rate, suicide.country
FROM lifeexp, suicide
WHERE lifeexp.country = suicide.country
ORDER BY happiness_score DESC;

-- Finland.. 16.6