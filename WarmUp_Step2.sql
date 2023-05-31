/*
STEP 2
[BR]
   NOTA:
    - Query para separar os domínios em Data Extensions
[US]
    NOTE:
    - Query to separate domains into Data Extensions
*/

--------------> GMAIL 

SELECT 
    [COLUMN_SUBSCRIBERKEY],
    [COLUMN_EMAIL]
FROM 
    [Your_Data_Extension]
WHERE
    (
    SUBSTRING([COLUMN_EMAIL], CHARINDEX('@',[COLUMN_EMAIL]) + 1, LEN([COLUMN_EMAIL])) LIKE '%gmail.com%' 
    OR SUBSTRING([COLUMN_EMAIL], CHARINDEX('@',[COLUMN_EMAIL]) + 1, LEN([COLUMN_EMAIL]))  LIKE '%googlemail%') --> Data extension Destination [Your_Data_Extension_GMAIL] - Overwrite

 --------------> HOTMAIL

SELECT 
    [COLUMN_SUBSCRIBERKEY],
    [COLUMN_EMAIL]
FROM 
    [Your_Data_Extension]
WHERE
    (
    SUBSTRING([COLUMN_EMAIL], CHARINDEX('@',[COLUMN_EMAIL]) + 1, LEN([COLUMN_EMAIL])) LIKE '%hotmail.com%' 
    OR SUBSTRING([COLUMN_EMAIL], CHARINDEX('@',[COLUMN_EMAIL]) + 1, LEN([COLUMN_EMAIL]))  LIKE '%outlook.com%'
    OR SUBSTRING([COLUMN_EMAIL], CHARINDEX('@',[COLUMN_EMAIL]) + 1, LEN([COLUMN_EMAIL]))  LIKE '%live%'
    OR SUBSTRING([COLUMN_EMAIL], CHARINDEX('@',[COLUMN_EMAIL]) + 1, LEN([COLUMN_EMAIL]))  LIKE '%msn%'
    OR SUBSTRING([COLUMN_EMAIL], CHARINDEX('@',[COLUMN_EMAIL]) + 1, LEN([COLUMN_EMAIL]))  LIKE '%windowslive%') --> Data extension Destination [Your_Data_Extension_HOTMAIL] - Overwrite

 --------------> YAHOO

SELECT 
    [COLUMN_SUBSCRIBERKEY],
    [COLUMN_EMAIL]
FROM 
    [Your_Data_Extension]
WHERE
    (
    SUBSTRING([COLUMN_EMAIL], CHARINDEX('@',[COLUMN_EMAIL]) + 1, LEN([COLUMN_EMAIL])) LIKE '%yahoo.com%' 
    OR SUBSTRING([COLUMN_EMAIL], CHARINDEX('@',[COLUMN_EMAIL]) + 1, LEN([COLUMN_EMAIL]))  LIKE '%yahoo.com.br%'
    OR SUBSTRING([COLUMN_EMAIL], CHARINDEX('@',[COLUMN_EMAIL]) + 1, LEN([COLUMN_EMAIL]))  LIKE '%ymail%'
    OR SUBSTRING([COLUMN_EMAIL], CHARINDEX('@',[COLUMN_EMAIL]) + 1, LEN([COLUMN_EMAIL]))  LIKE '%verizon%'
    OR SUBSTRING([COLUMN_EMAIL], CHARINDEX('@',[COLUMN_EMAIL]) + 1, LEN([COLUMN_EMAIL]))  LIKE '%netscape%'
    OR SUBSTRING([COLUMN_EMAIL], CHARINDEX('@',[COLUMN_EMAIL]) + 1, LEN([COLUMN_EMAIL]))  LIKE '%rogers%'
    OR SUBSTRING([COLUMN_EMAIL], CHARINDEX('@',[COLUMN_EMAIL]) + 1, LEN([COLUMN_EMAIL]))  LIKE '%sky%'
    OR SUBSTRING([COLUMN_EMAIL], CHARINDEX('@',[COLUMN_EMAIL]) + 1, LEN([COLUMN_EMAIL]))  LIKE '%aol%'
    OR SUBSTRING([COLUMN_EMAIL], CHARINDEX('@',[COLUMN_EMAIL]) + 1, LEN([COLUMN_EMAIL]))  LIKE '%rocketmail%'
    OR SUBSTRING([COLUMN_EMAIL], CHARINDEX('@',[COLUMN_EMAIL]) + 1, LEN([COLUMN_EMAIL]))  LIKE '%btinternet%'
    OR SUBSTRING([COLUMN_EMAIL], CHARINDEX('@',[COLUMN_EMAIL]) + 1, LEN([COLUMN_EMAIL]))  LIKE '%talk21%') --> Data extension Destination [Your_Data_Extension_YAHOO] - Overwrite

 --------------> OTHERS
 
SELECT 
    DE.[COLUMN_SUBSCRIBERKEY],
    DE.[COLUMN_EMAIL]
FROM 
    [Your_Data_Extension] DE
WHERE
    NOT EXISTS
        (SELECT '' FROM [Your_Data_Extension_GMAIL] G WHERE G.[COLUMN_PRIMARYKEY] = DE.[COLUMN_PRIMARYKEY]) 
   OR NOT EXISTS
        (SELECT '' FROM [Your_Data_Extension_HOTMAIL] H WHERE H.[COLUMN_PRIMARYKEY] = DE.[COLUMN_PRIMARYKEY])
   OR NOT EXISTS
        (SELECT '' FROM [Your_Data_Extension_YAHOO] Y WHERE Y.[COLUMN_PRIMARYKEY] = DE.[COLUMN_PRIMARYKEY]) --> Data extension Destination [Your_Data_Extension_OTHERS] - Overwrite
