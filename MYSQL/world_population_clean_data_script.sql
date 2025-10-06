
-- DATA CLEANING -------------------------------------------------------------------------------------
-- DELETING UNNECESSARY COLUMNS 
-- DELETING UNNECESSARY ROWS 
-- REMOVING COMMA AND ANY OTHER CHARACTERS 
-- STANDARDIZE DATA
-- EDIT SOME DATA NAME (REF_AREA_NAME) 
-- EDIT ROWS(NAME) FROM SEX_ID COLUMNS TO  MANIPULATE EASILY
-- LOOK FOR NULL OR BLANK VALUES IN POPULATION TABLE
-- LOOK FOR DUPLICATES 

CREATE DATABASE world_population;

-- IMPORT DATA WORLD POPULATION --

SELECT *
FROM raw_worldpopulation;

-- CREATE ANOTHER TABLE FOR raw_worldpopulation table  called population (2ND COPY)  to SAVE THE RaW DATA

CREATE TABLE population
LIKE raw_worldpopulation;  -- it will copy all the column from layoffs table

INSERT population
SELECT *
FROM raw_worldpopulation;

SELECT *
FROM population;


/* -- NO NEED 
-- RENAMING MY TABLE 
-- ALTER TABLE population
-- RENAME TO world_population; 
*/

-- SELECTING ALL TO CHECK ALL DATA THAT NEEDS TO FIX ETC..
SELECT * 
FROM population;

-- UPDATES AND DELETE WILL NOT PRODUCE ERROR NEED TO SET
SET SQL_SAFE_UPDATES = 0; 
-- ----------------------------------------------------------------------------------------
-- DELETING UNNECESSARY COLUMNS  
ALTER TABLE population
DROP FREQ_ID,
DROP FREQ_NAME,
DROP INDICATOR_ID,
DROP INDICATOR_NAME,
DROP DATABASE_ID_ID,
DROP DATABASE_ID_NAME,
DROP UNIT_MULT_ID,
DROP UNIT_MULT_NAME,
DROP OBS_STATUS_ID,
DROP OBS_STATUS_NAME,
DROP OBS_CONF_ID,
DROP OBS_CONF_NAME;

ALTER TABLE population
DROP UNIT_MEASURE_ID,
DROP UNIT_MEASURE_NAME;

-- DELETING UNNECESSARY ROWS  
DELETE 
FROM population
WHERE REF_AREA_NAME = 'Heavily indebted poor countries (HIPC)'
OR REF_AREA_NAME = 'High income'
OR REF_AREA_NAME = 'IDA & IBRD total'
OR REF_AREA_NAME = 'Late-demographic dividend'
OR REF_AREA_NAME = 'Least developed countries: UN classification'
OR REF_AREA_NAME = 'Low & middle income'
OR REF_AREA_NAME = 'Low income'
OR REF_AREA_NAME = 'Lower middle income'
OR REF_AREA_NAME = 'Middle East & North Africa (excluding high income)'
OR REF_AREA_NAME = 'Middle income'
OR REF_AREA_NAME = 'North America'
OR REF_AREA_NAME = 'OECD members'
OR REF_AREA_NAME = 'Other small states'
OR REF_AREA_NAME = 'Pacific island small states'
OR REF_AREA_NAME = 'Post-demographic dividend'
OR REF_AREA_NAME = 'Pre-demographic dividend'
OR REF_AREA_NAME = 'Small states'
OR REF_AREA_NAME = 'South Asia'
OR REF_AREA_NAME = 'Sub-Saharan Africa'
OR REF_AREA_NAME = 'Upper middle income'
OR REF_AREA_NAME = 'West Bank and Gaza'
OR REF_AREA_NAME = 'Latin America & Caribbean (excluding high income)'
OR REF_AREA_NAME = 'Latin America & Caribbean (IDA & IBRD)'
OR REF_AREA_NAME = 'Middle East & North Africa (IDA & IBRD)'
OR REF_AREA_NAME = 'Middle East and North Africa'
OR REF_AREA_NAME = 'South Asia (IDA & IBRD)'
OR REF_AREA_NAME = 'Sub-Saharan Africa (excluding high income)'
OR REF_AREA_NAME = 'Sub-Saharan Africa (IDA & IBRD)'
OR REF_AREA_NAME = 'Northern Mariana Islands'
OR REF_AREA_NAME = 'Turks and Caicos Islands'
OR REF_AREA_NAME = 'Isle of Man';

DELETE 
FROM population
WHERE REF_AREA_NAME = 'Africa Eastern and Southern'
OR REF_AREA_NAME = 'Africa Western and Central'
OR REF_AREA_NAME = 'Arab World'
OR REF_AREA_NAME = 'British Virgin Islands'
OR REF_AREA_NAME = 'Caribbean small states'
OR REF_AREA_NAME = 'Cayman Islands'
OR REF_AREA_NAME = 'Central African Republic'
OR REF_AREA_NAME = 'Central Electricity Board (CEB)'
OR REF_AREA_NAME = 'Channel Islands'
OR REF_AREA_NAME = 'Early-demographic dividend'
OR REF_AREA_NAME = 'East Asia & Pacific'
OR REF_AREA_NAME = 'East Asia & Pacific (excluding high income)'
OR REF_AREA_NAME = 'East Asia & Pacific (IDA & IBRD)'
OR REF_AREA_NAME = 'Euro area'
OR REF_AREA_NAME = 'Europe & Central Asia'
OR REF_AREA_NAME = 'Europe & Central Asia (excluding high income)'
OR REF_AREA_NAME = 'Europe & Central Asia (IDA & IBRD)'
OR REF_AREA_NAME = 'European Union'
OR REF_AREA_NAME = 'Faroe Islands'
OR REF_AREA_NAME = 'Fragile and conflict affected situations'
OR REF_AREA_NAME = 'French Polynesia'
OR REF_AREA_NAME = 'Latin America & Caribbean';

-- DOUBLE CHECK 
SELECT *
FROM population
WHERE REF_AREA_NAME = 'Fragile and conflict affected situations';

SELECT DISTINCT REF_AREA_NAME -- RECHECKING
FROM population
ORDER BY REF_AREA_NAME;
-- --------------------------------------------------------------------------------------------

/*
WAYS TO REMOVE COMMA OR ANY CHARACTERS:

SELECT REGEXP_REPLACE(your_field, '[",\']', '') AS cleaned_string FROM your_table;

SELECT REPLACE(TABLE NAME, ',', '') AS cleaned_description FROM your_table WHERE id = 1;
-- multiple selection
SELECT REPLACE(REPLACE(your_string, '"', ''), ',', '') AS cleaned_string FROM your_table;
*/
-- REMOVE COMMA AND ANY OTHER CHARACTERS 

SELECT REGEXP_REPLACE(REF_AREA_NAME, '[,()]', '')
FROM population;

Update population
SET REF_AREA_NAME  = REGEXP_REPLACE(REF_AREA_NAME, '[,()]', '');

SELECT DISTINCT REF_AREA_NAME -- RECHECKING
FROM population
ORDER BY REF_AREA_NAME;

-- -----------------------------------------------------------------------------------------
-- EDIT SOME DATA NAME (REF_AREA_NAME) / STANDARDIZE
SELECT *
FROM population;

/*SELECT 
    REPLACE(REF_AREA_NAME, 'Bahamas The', 'Bahamas') 
FROM population; */

SELECT REF_AREA_NAME,
 REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REF_AREA_NAME,
	'Bahamas The', 'Bahamas'),
	'Egypt Arab Rep.', 'Egypt'),
	'Gambia The', 'Gambia'),
    'Hong Kong SAR China', 'Hong Kong'),
	'Iran Islamic Rep.', 'Iran'),
	'Korea Dem. Peoples Rep.', 'North Korea'),
	'Korea Rep.', 'South Korea'),
	'Lao PDR', 'Lao'),
    'Macao SAR China', 'Macao'),
	'Micronesia Fed. Sts.', 'Micronesia'),
    'Sint Maarten Dutch part', 'Sint Maarten'),
	'St. Martin French part', 'St. Martin'),
    'Venezuela RB','Venezuela'),
	'Yemen Rep.', 'Yemen'),
     'Brunei Darussalam', 'Brunei'),
    'Kyrgyz Republic','Kyrgyzstan'),
	'Russian Federation', 'Russia') -- AS updated_REF_AREA_NAME
FROM population;

Update population
SET REF_AREA_NAME  =  REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REF_AREA_NAME,
	'Bahamas The', 'Bahamas'),
	'Egypt Arab Rep.', 'Egypt'),
	'Gambia The', 'Gambia'),
    'Hong Kong SAR China', 'Hong Kong'),
	'Iran Islamic Rep.', 'Iran'),
	"Korea Dem. People's Rep.", 'North Korea'),
	'Korea Rep.', 'South Korea'),
	'Lao PDR', 'Lao'),
    'Macao SAR China', 'Macao'),
	'Micronesia Fed. Sts.', 'Micronesia'),
    'Sint Maarten Dutch part', 'Sint Maarten'),
	'St. Martin French part', 'St. Martin'),
    'Venezuela RB','Venezuela'),
	'Yemen Rep.', 'Yemen'),
    'Brunei Darussalam', 'Brunei'),
    'Kyrgyz Republic','Kyrgyzstan'),
	'Russian Federation', 'Russia');

SELECT DISTINCT REF_AREA_NAME -- RECHECKING
FROM population
ORDER BY REF_AREA_NAME;
-- ---------------------------------------------------------------------------------------------------------

-- SHOWING ALL COLUMNS THAT WILL USE LATER IN  SELECTING ALL COLUMNS EXCEPT FEW COLUMNS
SELECT *
FROM information_schema.columns
WHERE table_name = 'population';

-- TWO METHODS IN SELECTING ALL COLUMN EXCEPT FEW COLUMNS

-- IST METHOD IN SELECTING ALL COLUMN EXCEPT FEW COLUMNS
-- right click on the table - copy to clipboard - select statement - paste
-- removing backtick - click edit - find -find and replace - in the search box enter the backtick - click replace all

SELECT 1960,1961,1962,1963,1964,1965,1966,1967,1968,1969,1970,1971,1972,1973,1974,1975,1976,1977,1978,1979,
	   1980,1981,1982,1983,1984,1985,1986,1987,1988,1989,1990,1991,1992,1993,1994,1995,1996,1997,1998,1999,
       2000,2001,2002,2003,2004,2005,2006,2007,2008,2009,2010,2011,2012,2013,2014,2015,2016,2017,2018,2019,
       2020,2021,2022,2023
FROM world_population.population;

/*
-- 2ND METHOD IN SELECTING ALL COLUMN EXCEPT FEW COLUMNS
SELECT CONCAT(column_name, ',')
FROM information_schema.columns
WHERE table_name = 'population';
-- click on the result and press ctrl a - select copy row unquoted - then paste - add select and from
*/

-- ---------------------------------------------------------------------------------------------------
-- EDIT ROWS (NAME) FROM SEX_ID COLUMNS TO  MANIPULATE EASILY

UPDATE population
SET SEX_ID = replace(SEX_ID,'F','F_T')
WHERE AGE_ID = '_T';

UPDATE population
SET SEX_ID = replace(SEX_ID,'M','M_T')
WHERE AGE_ID = '_T';

UPDATE population
SET SEX_ID = replace(SEX_ID,'_T','RUR_T')
WHERE URBANISATION_ID = 'RUR';

UPDATE population
SET SEX_ID = replace(SEX_ID,'_T','URB_T')
WHERE URBANISATION_ID = 'URB';

UPDATE population
SET SEX_ID = replace(SEX_ID,'_T','ALL_T')
WHERE SEX_ID = '_T' AND AGE_ID = '_T' AND URBANISATION_ID = '_T';

-- -----------------------------------------------------------------------------------------------------
-- LOOK FOR NULL OR BLANK VALUES IN POPULATION TABLE

SELECT *
FROM population
WHERE REF_AREA_ID IS NULL
OR REF_AREA_NAME IS NULL
OR SEX_ID IS NULL
OR SEX_NAME IS NULL
OR AGE_ID IS NULL 
OR AGE_NAME IS NULL
OR URBANISATION_ID IS NULL
OR URBANISATION_NAME IS NULL;  

-- shortcut in selecting all columns when columns more than 10
SELECT CONCAT('OR', ' ', column_name,' ',  'IS NULL') -- use concat to add extra details for slected columns
FROM information_schema.columns
WHERE table_name = 'population'; 
    
SELECT * -- In select statement year should have a backtick
FROM population
WHERE 1960 IS NULL   -- Either with quotes or no need a  backtick here for the year
OR 1961 IS NULL
OR 1962 IS NULL
OR 1963 IS NULL
OR 1964 IS NULL
OR 1965 IS NULL
OR 1966 IS NULL
OR 1967 IS NULL
OR 1968 IS NULL
OR 1969 IS NULL
OR 1970 IS NULL
OR 1971 IS NULL
OR 1972 IS NULL
OR 1973 IS NULL
OR 1974 IS NULL
OR 1975 IS NULL
OR 1976 IS NULL
OR 1977 IS NULL
OR 1978 IS NULL
OR 1979 IS NULL
OR 1980 IS NULL
OR 1981 IS NULL
OR 1982 IS NULL
OR 1983 IS NULL
OR 1984 IS NULL
OR 1985 IS NULL
OR 1986 IS NULL
OR 1987 IS NULL
OR 1988 IS NULL
OR 1989 IS NULL
OR 1990 IS NULL
OR 1991 IS NULL
OR 1992 IS NULL
OR 1993 IS NULL
OR 1994 IS NULL
OR 1995 IS NULL
OR 1996 IS NULL
OR 1997 IS NULL
OR 1998 IS NULL
OR 1999 IS NULL
OR 2000 IS NULL
OR 2001 IS NULL
OR 2002 IS NULL
OR 2003 IS NULL
OR 2004 IS NULL
OR 2005 IS NULL
OR 2006 IS NULL
OR 2007 IS NULL
OR 2008 IS NULL
OR 2009 IS NULL
OR 2010 IS NULL
OR 2011 IS NULL
OR 2012 IS NULL
OR 2013 IS NULL
OR 2014 IS NULL
OR 2015 IS NULL
OR 2016 IS NULL
OR 2017 IS NULL
OR 2018 IS NULL
OR 2019 IS NULL
OR 2020 IS NULL
OR 2021 IS NULL
OR 2022 IS NULL
OR 2023 IS NULL ;    

SELECT COUNT(*)
FROM population
WHERE 'REF_AREA_ID' is null and '1960' IS NULL;   

-- LOOK FOR NULL IN WORLD_COUNT TABLE
SELECT *
FROM world_count;

SELECT CONCAT('OR', ' ', "'", column_name,"'",' ',  'IS NULL') -- use concat to add extra details for slected columns
FROM information_schema.columns
WHERE table_name = 'world_count'; 

SELECT * 
FROM world_count
WHERE 'REF_AREA_ID' IS NULL
OR 'SEX_ID' IS NULL
OR 'SEX_NAME' IS NULL
OR 'AGE_ID' IS NULL
OR 'AGE_NAME' IS NULL
OR 'URBANISATION_ID' IS NULL
OR 'URBANISATION_NAME' IS NULL
OR '1960' IS NULL
OR '1961' IS NULL
OR '1962' IS NULL
OR '1963' IS NULL
OR '1964' IS NULL
OR '1965' IS NULL
OR '1966' IS NULL
OR '1967' IS NULL
OR '1968' IS NULL
OR '1969' IS NULL
OR '1970' IS NULL
OR '1971' IS NULL
OR '1972' IS NULL
OR '1973' IS NULL
OR '1974' IS NULL
OR '1975' IS NULL
OR '1976' IS NULL
OR '1977' IS NULL
OR '1978' IS NULL
OR '1979' IS NULL
OR '1980' IS NULL
OR '1981' IS NULL
OR '1982' IS NULL
OR '1983' IS NULL
OR '1984' IS NULL
OR '1985' IS NULL
OR '1986' IS NULL
OR '1987' IS NULL
OR '1988' IS NULL
OR '1989' IS NULL
OR '1990' IS NULL
OR '1991' IS NULL
OR '1992' IS NULL
OR '1993' IS NULL
OR '1994' IS NULL
OR '1995' IS NULL
OR '1996' IS NULL
OR '1997' IS NULL
OR '1998' IS NULL
OR '1999' IS NULL
OR '2000' IS NULL
OR '2001' IS NULL
OR '2002' IS NULL
OR '2003' IS NULL
OR '2004' IS NULL
OR '2005' IS NULL
OR '2006' IS NULL
OR '2007' IS NULL
OR '2008' IS NULL
OR '2009' IS NULL
OR '2010' IS NULL
OR '2011' IS NULL
OR '2012' IS NULL
OR '2013' IS NULL
OR '2014' IS NULL
OR '2015' IS NULL
OR '2016' IS NULL
OR '2017' IS NULL
OR '2018' IS NULL
OR '2019' IS NULL
OR '2020' IS NULL
OR '2021' IS NULL
OR '2022' IS NULL
OR '2023' IS NULL;

 -- ---------------------------------------------------------------------------------------
-- LOOK FOR DUPLICATES 

SELECT REF_AREA_ID,REF_AREA_NAME,SEX_ID, SEX_NAME,AGE_ID,AGE_NAME, URBANISATION_ID,URBANISATION_NAME,COUNT(REF_AREA_ID)
FROM population
GROUP BY  REF_AREA_ID,REF_AREA_NAME,SEX_ID, SEX_NAME,AGE_ID,AGE_NAME, URBANISATION_ID,URBANISATION_NAME
HAVING  COUNT(*) >1;

SELECT REF_AREA_ID,REF_AREA_NAME,SEX_ID, SEX_NAME,AGE_ID,AGE_NAME, URBANISATION_ID,URBANISATION_NAME,COUNT(REF_AREA_ID) AS CNT
FROM population
GROUP BY  REF_AREA_ID,REF_AREA_NAME,SEX_ID, SEX_NAME,AGE_ID,AGE_NAME, URBANISATION_ID,URBANISATION_NAME
HAVING  CNT >1;

SELECT CONCAT('`', column_name,'`',',',' ', 'COUNT(', '`',column_name,'`),')
FROM information_schema.columns
WHERE table_name = 'population'; 

SELECT REF_AREA_ID,REF_AREA_NAME,SEX_ID, SEX_NAME,AGE_ID,AGE_NAME, URBANISATION_ID,URBANISATION_NAME,
	`1960`, COUNT(`1960`),
	`1961`, COUNT(`1961`),
	`1962`, COUNT(`1962`),
	`1963`, COUNT(`1963`),
	`1964`, COUNT(`1964`),
	`1965`, COUNT(`1965`),
	`1966`, COUNT(`1966`),
	`1967`, COUNT(`1967`),
	`1968`, COUNT(`1968`),
	`1969`, COUNT(`1969`),
	`1970`, COUNT(`1970`),
	`1971`, COUNT(`1971`),
	`1972`, COUNT(`1972`),
	`1973`, COUNT(`1973`),
	`1974`, COUNT(`1974`),
	`1975`, COUNT(`1975`),
	`1976`, COUNT(`1976`),
	`1977`, COUNT(`1977`),
	`1978`, COUNT(`1978`),
	`1979`, COUNT(`1979`),
	`1980`, COUNT(`1980`),
	`1981`, COUNT(`1981`),
	`1982`, COUNT(`1982`),
	`1983`, COUNT(`1983`),
	`1984`, COUNT(`1984`),
	`1985`, COUNT(`1985`),
	`1986`, COUNT(`1986`),
	`1987`, COUNT(`1987`),
	`1988`, COUNT(`1988`),
	`1989`, COUNT(`1989`),
	`1990`, COUNT(`1990`),
	`1991`, COUNT(`1991`),
	`1992`, COUNT(`1992`),
	`1993`, COUNT(`1993`),
	`1994`, COUNT(`1994`),
	`1995`, COUNT(`1995`),
	`1996`, COUNT(`1996`),
	`1997`, COUNT(`1997`),
	`1998`, COUNT(`1998`),
	`1999`, COUNT(`1999`),
	`2000`, COUNT(`2000`),
	`2001`, COUNT(`2001`),
	`2002`, COUNT(`2002`),
	`2003`, COUNT(`2003`),
	`2004`, COUNT(`2004`),
	`2005`, COUNT(`2005`),
	`2006`, COUNT(`2006`),
	`2007`, COUNT(`2007`),
	`2008`, COUNT(`2008`),
	`2009`, COUNT(`2009`),
	`2010`, COUNT(`2010`),
	`2011`, COUNT(`2011`),
	`2012`, COUNT(`2012`),
	`2013`, COUNT(`2013`),
	`2014`, COUNT(`2014`),
	`2015`, COUNT(`2015`),
	`2016`, COUNT(`2016`),
	`2017`, COUNT(`2017`),
	`2018`, COUNT(`2018`),
	`2019`, COUNT(`2019`),
	`2020`, COUNT(`2020`),
	`2021`, COUNT(`2021`),
	`2022`, COUNT(`2022`),
	`2023`, COUNT(`2023`)
FROM population
GROUP BY  -- SHORT CUT COPLY TO CLIPBOARD - SELECT ALL STATEMENT - REPLACE ALL  
	REF_AREA_ID,REF_AREA_NAME,SEX_ID, SEX_NAME,AGE_ID,AGE_NAME, URBANISATION_ID,URBANISATION_NAME,
	`1960`,
    `1961`,
    `1962`,
    `1963`,
    `1964`,
    `1965`,
    `1966`,
    `1967`,
    `1968`,
    `1969`,
    `1970`,
    `1971`,
    `1972`,
    `1973`,
    `1974`,
    `1975`,
    `1976`,
    `1977`,
    `1978`,
    `1979`,
    `1980`,
    `1981`,
    `1982`,
    `1983`,
    `1984`,
    `1985`,
    `1986`,
    `1987`,
    `1988`,
    `1989`,
    `1990`,
    `1991`,
    `1992`,
    `1993`,
    `1994`,
    `1995`,
    `1996`,
    `1997`,
    `1998`,
    `1999`,
    `2000`,
    `2001`,
    `2002`,
    `2003`,
    `2004`,
    `2005`,
    `2006`,
    `2007`,
    `2008`,
    `2009`,
    `2010`,
    `2011`,
    `2012`,
    `2013`,
    `2014`,
    `2015`,
    `2016`,
    `2017`,
    `2018`,
    `2019`,
    `2020`,
    `2021`,
    `2022`,
    `2023`
HAVING  COUNT(*) > 1;


/*
-- NO DUPLICATE , ONLY 6 ROWS 
SELECT *
FROM world_count; 
*/
-- ----------------------------------------------------------------------------------------------
-- COUNTING ID BY GROUP 

SELECT REF_AREA_ID, Count(REF_AREA_ID)
FROM population
GROUP BY REF_AREA_ID; 
-- RESULT ALL COUNT 14 EXCEPT REF_AREA_ID = 'XKX'AND 'MAF' ONLY 12 BECAUSE IT HAS NO RURAL AND URBAN TOTAL COUNT 

-- CHECKING REF_AREA_ID = 'XKX' AND 'MAF'
SELECT *
FROM population
WHERE REF_AREA_ID = 'XKX' OR REF_AREA_ID = 'MAF'; -- IT HAS NO RURAL AND URBAN TOTAL COUNT

-- .....................................THANK YOU..........................................










