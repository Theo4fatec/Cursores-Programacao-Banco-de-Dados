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