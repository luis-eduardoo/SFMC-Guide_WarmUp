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
--> ATENÇÃO: Definir Data Retention  para que cada contato seja eliminado da base histórico após 7 dias
--> ATTENTION: Set Data Retention for each contact to be deleted from the history base after 7 days
