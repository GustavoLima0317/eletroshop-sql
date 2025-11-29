/*
 * 03_eletroshop_selects.sql
 * Consultas SELECT de exemplo (WHERE, ORDER BY, LIMIT, JOIN etc.)
 */

USE eletroshop;

-- 1) Listar todos os produtos com categoria e estoque
SELECT
    p.id_produto,
    p.nome        AS produto,
    c.nome        AS categoria,
    p.preco,
    p.quantidade_estoque
FROM PRODUTO p
JOIN CATEGORIA c ON p.id_categoria = c.id_categoria
ORDER BY c.nome, p.nome;

-- 2) Pedidos com nome do cliente e valor total
--    mostrando apenas pedidos PAGO ou ENVIADO
SELECT
    pe.id_pedido,
    pe.data_pedido,
    pe.status_pedido,
    pe.valor_total,
    cl.nome AS cliente
FROM PEDIDO pe
JOIN CLIENTE cl ON pe.id_cliente = cl.id_cliente
WHERE pe.status_pedido IN ('PAGO', 'ENVIADO')
ORDER BY pe.data_pedido DESC;

-- 3) Top 3 produtos mais vendidos (por quantidade)
SELECT
    p.id_produto,
    p.nome,
    SUM(ip.quantidade) AS total_unidades
FROM ITEM_PEDIDO ip
JOIN PRODUTO p ON ip.id_produto = p.id_produto
GROUP BY p.id_produto, p.nome
ORDER BY total_unidades DESC
LIMIT 3;

-- 4) Clientes que ainda não fizeram nenhum pedido
SELECT
    c.id_cliente,
    c.nome,
    c.email
FROM CLIENTE c
LEFT JOIN PEDIDO p ON c.id_cliente = p.id_cliente
WHERE p.id_pedido IS NULL;

-- 5) Relatório de pedidos com transportadora e status de pagamento
SELECT
    pe.id_pedido,
    cl.nome             AS cliente,
    t.nome              AS transportadora,
    pa.metodo_pagamento,
    pa.status_pagamento,
    pe.status_pedido,
    pe.valor_total
FROM PEDIDO pe
JOIN CLIENTE        cl ON pe.id_cliente        = cl.id_cliente
JOIN TRANSPORTADORA t  ON pe.id_transportadora = t.id_transportadora
LEFT JOIN PAGAMENTO pa ON pa.id_pedido         = pe.id_pedido
ORDER BY pe.id_pedido;
