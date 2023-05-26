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