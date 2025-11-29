/*
 * 04_eletroshop_updates_deletes.sql
 * Exemplos de UPDATE e DELETE respeitando integridade referencial
 */

USE eletroshop;

-- ===============================
-- UPDATEs
-- ===============================

-- 1) Reajustar em +5% o preço dos produtos da categoria "Acessórios"
UPDATE PRODUTO p
JOIN CATEGORIA c ON p.id_categoria = c.id_categoria
SET p.preco = p.preco * 1.05
WHERE c.nome = 'Acessórios';

-- 2) Atualizar o status de pedidos com pagamento APROVADO para 'PAGO'
UPDATE PEDIDO pe
JOIN PAGAMENTO pa ON pa.id_pedido = pe.id_pedido
SET pe.status_pedido = 'PAGO'
WHERE pa.status_pagamento = 'APROVADO';

-- 3) Marcar como INATIVO os clientes que não possuem nenhum pedido
UPDATE CLIENTE c
LEFT JOIN PEDIDO p ON c.id_cliente = p.id_cliente
SET c.status = 'INATIVO'
WHERE p.id_pedido IS NULL
  AND c.status <> 'INATIVO';

-- ===============================
-- DELETEs
-- ===============================

-- 1) Apagar os itens de pedidos CANCELADOS
DELETE ip
FROM ITEM_PEDIDO ip
JOIN PEDIDO pe ON ip.id_pedido = pe.id_pedido
WHERE pe.status_pedido = 'CANCELADO';

-- 2) Remover pagamentos RECUSADOS de pedidos CANCELADOS
DELETE pa
FROM PAGAMENTO pa
JOIN PEDIDO pe ON pa.id_pedido = pe.id_pedido
WHERE pe.status_pedido = 'CANCELADO'
  AND pa.status_pagamento = 'RECUSADO';

-- 3) Excluir clientes INATIVOS que nunca fizeram pedidos
DELETE c
FROM CLIENTE c
LEFT JOIN PEDIDO p ON c.id_cliente = p.id_cliente
WHERE c.status = 'INATIVO'
  AND p.id_pedido IS NULL;
