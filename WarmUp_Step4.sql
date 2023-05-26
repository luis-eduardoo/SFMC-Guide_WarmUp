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
    NOT EXISTS
        (SELECT '' FROM [Your_Data_Extension_GMAIL] G WHERE G.[COLUMN_PRIMARYKEY] = DE.[COLUMN_PRIMARYKEY]) 
    NOT EXISTS
        (SELECT '' FROM [Your_Data_Extension_HOTMAIL] H WHERE H.[COLUMN_PRIMARYKEY] = DE.[COLUMN_PRIMARYKEY])
    NOT EXISTS
        (SELECT '' FROM [Your_Data_Extension_YAHOO] Y WHERE Y.[COLUMN_PRIMARYKEY] = DE.[COLUMN_PRIMARYKEY]) --> Data extension Destination [Your_Data_Extension_OTHERS] - Overwrite

/*
STEP 3
[BR]
   NOTA:
    - Query para separar a quantidade de envios por dia automaticamente baseado na sua estratégia. Se quiser pode quebrar o union por step na Automação, assim não precisa rodar um código tão extenso.(a partir do step 2, colocar como UPDATE na Data Extension de destino) - IMPORTANTE: O CÓDIGO SÓ RODA NO AUTOMATION STUDIO
[US]
    NOTE:
    - Query to return the number of submissions per day automatically based on your strategy. If you want you can break the union by step in Automation, so you don't have to run such extensive code. (from step 2, put as UPDATE in the destination Data Extension) - IMPORTANT: THE CODE ONLY RUNS IN AUTOMATION STUDIO
*/

SELECT TOP (
    CASE 
        WHEN DATEPART(DAY,GETDATE()) = [NUMBER_DAY1] and DATEPART(MONTH,GETDATE()) = [NUMBER_MONTH] THEN [NUMBER_SEND_DAY] --> ex. WHEN DATEPART(DAY,GETDATE()) = 25 and DATEPART(MONTH,GETDATE()) = 5 THEN 1000
        WHEN DATEPART(DAY,GETDATE()) = [NUMBER_DAY2] and DATEPART(MONTH,GETDATE()) = [NUMBER_MONTH] THEN [NUMBER_SEND_DAY]
        WHEN DATEPART(DAY,GETDATE()) = [NUMBER_DAY3] and DATEPART(MONTH,GETDATE()) = [NUMBER_MONTH] THEN [NUMBER_SEND_DAY]
        WHEN DATEPART(DAY,GETDATE()) = [NUMBER_DAY4] and DATEPART(MONTH,GETDATE()) = [NUMBER_MONTH] THEN [NUMBER_SEND_DAY]
        WHEN DATEPART(DAY,GETDATE()) = [NUMBER_DAY5] and DATEPART(MONTH,GETDATE()) = [NUMBER_MONTH] THEN [NUMBER_SEND_DAY]
        WHEN DATEPART(DAY,GETDATE()) = [NUMBER_DAY6] and DATEPART(MONTH,GETDATE()) = [NUMBER_MONTH] THEN [NUMBER_SEND_DAY]
        WHEN DATEPART(DAY,GETDATE()) = [NUMBER_DAY7] and DATEPART(MONTH,GETDATE()) = [NUMBER_MONTH] THEN [NUMBER_SEND_DAY]
     else 0 END)
    G.[COLUMN_SUBSCRIBERKEY],
    G.[COLUMN_EMAIL]
 FROM
   [Your_Data_Extension_GMAIL] G
WHERE NOT EXISTS
    (SELECT '' FROM [Your_Data_Extension_History] H WHERE H.[COLUMN_PRIMARYKEY] = G.[COLUMN_PRIMARYKEY])
UNION
SELECT TOP (
    CASE 
        WHEN DATEPART(DAY,GETDATE()) = [NUMBER_DAY1] and DATEPART(MONTH,GETDATE()) = [NUMBER_MONTH] THEN [NUMBER_SEND_DAY]
        WHEN DATEPART(DAY,GETDATE()) = [NUMBER_DAY2] and DATEPART(MONTH,GETDATE()) = [NUMBER_MONTH] THEN [NUMBER_SEND_DAY] --> ex. WHEN DATEPART(DAY,GETDATE()) = 26 and DATEPART(MONTH,GETDATE()) = 5 THEN 1150
        WHEN DATEPART(DAY,GETDATE()) = [NUMBER_DAY3] and DATEPART(MONTH,GETDATE()) = [NUMBER_MONTH] THEN [NUMBER_SEND_DAY]
        WHEN DATEPART(DAY,GETDATE()) = [NUMBER_DAY4] and DATEPART(MONTH,GETDATE()) = [NUMBER_MONTH] THEN [NUMBER_SEND_DAY]
        WHEN DATEPART(DAY,GETDATE()) = [NUMBER_DAY5] and DATEPART(MONTH,GETDATE()) = [NUMBER_MONTH] THEN [NUMBER_SEND_DAY]
        WHEN DATEPART(DAY,GETDATE()) = [NUMBER_DAY6] and DATEPART(MONTH,GETDATE()) = [NUMBER_MONTH] THEN [NUMBER_SEND_DAY]
        WHEN DATEPART(DAY,GETDATE()) = [NUMBER_DAY7] and DATEPART(MONTH,GETDATE()) = [NUMBER_MONTH] THEN [NUMBER_SEND_DAY]
     else 0 END)
    G.[COLUMN_SUBSCRIBERKEY],
    G.[COLUMN_EMAIL]
 FROM
   [Your_Data_Extension_HOTMAIL] HT
WHERE NOT EXISTS
    (SELECT '' FROM [Your_Data_Extension_History] H WHERE H.[COLUMN_PRIMARYKEY] = HT.[COLUMN_PRIMARYKEY])
UNION
SELECT TOP (
    CASE 
        WHEN DATEPART(DAY,GETDATE()) = [NUMBER_DAY1] and DATEPART(MONTH,GETDATE()) = [NUMBER_MONTH] THEN [NUMBER_SEND_DAY]
        WHEN DATEPART(DAY,GETDATE()) = [NUMBER_DAY2] and DATEPART(MONTH,GETDATE()) = [NUMBER_MONTH] THEN [NUMBER_SEND_DAY]
        WHEN DATEPART(DAY,GETDATE()) = [NUMBER_DAY3] and DATEPART(MONTH,GETDATE()) = [NUMBER_MONTH] THEN [NUMBER_SEND_DAY]--> ex. WHEN DATEPART(DAY,GETDATE()) = 27 and DATEPART(MONTH,GETDATE()) = 5 THEN 1470
        WHEN DATEPART(DAY,GETDATE()) = [NUMBER_DAY4] and DATEPART(MONTH,GETDATE()) = [NUMBER_MONTH] THEN [NUMBER_SEND_DAY]
        WHEN DATEPART(DAY,GETDATE()) = [NUMBER_DAY5] and DATEPART(MONTH,GETDATE()) = [NUMBER_MONTH] THEN [NUMBER_SEND_DAY]
        WHEN DATEPART(DAY,GETDATE()) = [NUMBER_DAY6] and DATEPART(MONTH,GETDATE()) = [NUMBER_MONTH] THEN [NUMBER_SEND_DAY]
        WHEN DATEPART(DAY,GETDATE()) = [NUMBER_DAY7] and DATEPART(MONTH,GETDATE()) = [NUMBER_MONTH] THEN [NUMBER_SEND_DAY]
     else 0 END)
    G.[COLUMN_SUBSCRIBERKEY],
    G.[COLUMN_EMAIL]
 FROM
   [Your_Data_Extension_YAHOO] Y
WHERE NOT EXISTS
    (SELECT '' FROM [Your_Data_Extension_History] H WHERE H.[COLUMN_PRIMARYKEY] = Y.[COLUMN_PRIMARYKEY])
UNION
SELECT TOP (
    CASE 
        WHEN DATEPART(DAY,GETDATE()) = [NUMBER_DAY1] and DATEPART(MONTH,GETDATE()) = [NUMBER_MONTH] THEN [NUMBER_SEND_DAY]
        WHEN DATEPART(DAY,GETDATE()) = [NUMBER_DAY2] and DATEPART(MONTH,GETDATE()) = [NUMBER_MONTH] THEN [NUMBER_SEND_DAY]
        WHEN DATEPART(DAY,GETDATE()) = [NUMBER_DAY3] and DATEPART(MONTH,GETDATE()) = [NUMBER_MONTH] THEN [NUMBER_SEND_DAY]
        WHEN DATEPART(DAY,GETDATE()) = [NUMBER_DAY4] and DATEPART(MONTH,GETDATE()) = [NUMBER_MONTH] THEN [NUMBER_SEND_DAY]--> ex. WHEN DATEPART(DAY,GETDATE()) = 28 and DATEPART(MONTH,GETDATE()) = 5 THEN 1620
        WHEN DATEPART(DAY,GETDATE()) = [NUMBER_DAY5] and DATEPART(MONTH,GETDATE()) = [NUMBER_MONTH] THEN [NUMBER_SEND_DAY]
        WHEN DATEPART(DAY,GETDATE()) = [NUMBER_DAY6] and DATEPART(MONTH,GETDATE()) = [NUMBER_MONTH] THEN [NUMBER_SEND_DAY]
        WHEN DATEPART(DAY,GETDATE()) = [NUMBER_DAY7] and DATEPART(MONTH,GETDATE()) = [NUMBER_MONTH] THEN [NUMBER_SEND_DAY]
     else 0 END)
    G.[COLUMN_SUBSCRIBERKEY],
    G.[COLUMN_EMAIL]
 FROM
   [Your_Data_Extension_OTHERS] O
WHERE NOT EXISTS
    (SELECT '' FROM [Your_Data_Extension_History] H WHERE H.[COLUMN_PRIMARYKEY] = O.[COLUMN_PRIMARYKEY])

/*

[BR]
    LEGENDA:
        [NUMBER_DAY1]: Dia (numérico) que você vai realizar o primeiro disparo.
        [NUMBER_MONTH]: Mês (numérico) que os disparos vão acontecer.
        [NUMBER_SEND_DAY]: Número de contatos que vão ser selecionados daquele domínio (IMPORTANTE: NÃO COLOCAR PONTO NO NÚMERO --> ex. 1.450)
    DATA EXTENSION DESTINATION:
        [YOUR_DATA_EXTENSION_SEND] -> Data Extension para envio diário
[US]
    LEGEND:
        [NUMBER_DAY1]: Day (numeric) that you will perform the first shot.
        [NUMBER_MONTH]: Month (numeric) that the shots will take place.
        [NUMBER_SEND_DAY]: Number of contacts that are going to be selected from that domain (IMPORTANT: DO NOT DOT IN THE NUMBER --> ex. 1.450).
    DATA EXTENSION DESTINATION:
        [YOUR_DATA_EXTENSION_SEND] -> Date Extension for daily sending
*/

/*
STEP 4
[BR]
   NOTA:
    - Query para armazenar todos contatos que receberam envios na semana do WarmUp, conforme sua estratégia
[US]
    NOTE:
    - Query to store all the contacts that received mailings during the week of WarmUp, according to your strategy
*/

SELECT
    S.[COLUMN_SUBSCRIBERKEY],
    S.[COLUMN_EMAIL]
 FROM
    [YOUR_DATA_EXTENSION_SEND] S
--> ATENÇÃO: Definir a extensão da data para que cada contato seja eliminado da base histórico após 7 dias
--> ATTENTION: Set Date Extension for each contact to be deleted from the history base after 7 days