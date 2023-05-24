/*
STEP 1
[BR]
   NOTA:
    - Query para retornar o total de cada domínio da sua principal Data Extension para ajudar a determinar o número de semanas para um aquecimento completo.
[US]
    NOTE:
    - Query to return the total for each domain in your Master Data Extension to help determine the number of weeks for a full warm-up.
*/

SELECT 
    SUBSTRING([COLUMN_EMAIL], CHARINDEX('@',[COLUMN_EMAIL]) + 1, LEN([COLUMN_EMAIL])) AS DOMINIO, 
    COUNT(*) AS TOTAL
FROM 
    [Your_Data_Extension]
GROUP BY SUBSTRING([COLUMN_EMAIL], CHARINDEX('@',[COLUMN_EMAIL]) + 1, LEN([COLUMN_EMAIL]))
ORDER BY Subscribers DESC OFFSET 0 ROWS
