-- Active: 1727015344955@@127.0.0.1@5432@20242_fatec_ipi_pbdi_theo@public

--Exercicio 1.1
DO
$$
DECLARE
    v_contagem_videos INT := 1000;
    v_categoria_1 TEXT := 'Music';
    v_categoria_2 TEXT := 'Sports';
    v_youtuber VARCHAR(300);
    v_rank INT;
    --1. declaração do cursor
   cursor_video_count_category CURSOR(contagem_videos INT, categoria_1 TEXT, categoria_2 TEXT) FOR SELECT youtuber, rank FROM tb_top_youtubers WHERE video_count >= v_contagem_videos AND (category = categoria_1 OR category = categoria_2);
BEGIN
    --2. abertura do cursor
    OPEN cursor_video_count_category(v_contagem_videos, v_categoria_1, v_categoria_2);
    LOOP
        --3. recuperação de dados
        FETCH cursor_video_count_category INTO v_youtuber, v_rank;
        EXIT WHEN NOT FOUND;
        RAISE NOTICE '% - %',v_rank , v_youtuber;
    END LOOP;
    --4. fechamento do cursor
    CLOSE cursor_video_count_category;
END;
$$

--Exercicio 1.2
DO
$$
DECLARE
    v_youtuber VARCHAR(300);
    --1. declaração do cursor
    cursor_nomes_ordem_reversa CURSOR FOR SELECT youtuber FROM tb_top_youtubers;
BEGIN
    --2. abertura do cursor
    OPEN cursor_nomes_ordem_reversa;
    
    MOVE LAST FROM cursor_nomes_ordem_reversa;

    LOOP
    --3. recuperação de dados
        FETCH BACKWARD FROM cursor_nomes_ordem_reversa INTO v_youtuber;
        EXIT WHEN NOT FOUND;
        RAISE NOTICE '%', v_youtuber;
    END LOOP;
    --4. fechamento do cursor
    CLOSE cursor_nomes_ordem_reversa;
END;
$$

--Exercicio 1.3
/* 
Anti-pattern - RBAR(Row By Agonizing Row) é uma forma de processamento de dados, os dados são manipulados linha por linha, cada linha é processada exclusivamente. O RBAR é diferente do que operações embasadas em conjuntos, que o processamento de dados manipula todas as linhas uma vez só. O RBAR causa mais custos de performance para a máquina, ampliando o consumo do processador e memória, pois concede várias ações com o banco de dados. Dependendo do caso que for aplicado o código, é interessante usar o RBAR, é recomendado usar em códigos que precisem de interações em cada linha, e que o programa não seja tão grande, e utilizando o RBAR é mais fácil encontrar erros, porque como cada linha é processada de forma exclusiva, fica mais acessível de encontrar falhas.

https://www.red-gate.com/simple-talk/databases/sql-server/t-sql-programming-sql-server/rbar-row-by-agonizing-row/

https://nolongerset.com/under-100-rbar/

https://www.sqlservercentral.com/articles/hidden-rbar-triangular-joins

*/
