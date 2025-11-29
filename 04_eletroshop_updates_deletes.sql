/*
 * 02_eletroshop_inserts.sql
 * Inserts iniciais para povoar as tabelas principais
 */

USE eletroshop;

-- === CATEGORIA ===
INSERT INTO CATEGORIA (id_categoria, nome, descricao) VALUES
  (1, 'Smartphones', 'Celulares e smartphones'),
  (2, 'Notebooks',   'Notebooks e ultrabooks'),
  (3, 'Acessórios',  'Fones, cabos e periféricos');

-- === PRODUTO ===
INSERT INTO PRODUTO (id_produto, nome, descricao, preco, quantidade_estoque, id_categoria) VALUES
  (1, 'Smartphone X10',   'Smartphone 128GB, 6GB RAM',         1999.90,  30, 1),
  (2, 'Smartphone Y20',   'Smartphone 256GB, 8GB RAM',         2799.90,  15, 1),
  (3, 'Notebook Pro 14',  'Notebook i5, 16GB RAM, 512GB SSD',  4299.00,  10, 2),
  (4, 'Fone Bluetooth Z', 'Fone de ouvido sem fio',             199.90, 100, 3),
  (5, 'Cabo USB-C 1,5m',  'Cabo de dados e carregamento',        39.90, 200, 3);

-- === CLIENTE ===
INSERT INTO CLIENTE (id_cliente, nome, email, telefone, cpf_cnpj, data_nascimento, status) VALUES
  (1, 'Ana Souza',   'ana.souza@example.com',   '(11) 90000-0001', '123.456.789-01', '1995-03-10', 'ATIVO'),
  (2, 'Bruno Lima',  'bruno.lima@example.com',  '(11) 90000-0002', '987.654.321-00', '1990-07-22', 'ATIVO'),
  (3, 'Carla Mendes','carla.mendes@example.com','(11) 90000-0003', '321.654.987-99', '1988-11-05', 'ATIVO'),
  (4, 'Diego Costa', 'diego.costa@example.com', '(11) 90000-0004', '159.753.486-20', '2000-01-15', 'INATIVO');

-- === ENDERECO ===
INSERT INTO ENDERECO (id_endereco, logradouro, numero, bairro, cidade, estado, cep, tipo_endereco, id_cliente) VALUES
  (1, 'Rua das Flores',      '100', 'Centro',     'Bragança Paulista', 'SP', '12900-000', 'Residencial', 1),
  (2, 'Av. Paulista',        '1500','Paulista',   'São Paulo',         'SP', '01310-200', 'Residencial', 2),
  (3, 'Rua das Laranjeiras', '50',  'Vila Verde', 'Atibaia',           'SP', '12940-000', 'Residencial', 3),
  (4, 'Rua das Palmeiras',   '200', 'Centro',     'Bragança Paulista', 'SP', '12900-010', 'Cobrança',    1);

-- === TRANSPORTADORA ===
INSERT INTO TRANSPORTADORA (id_transportadora, nome, cnpj, telefone) VALUES
  (1, 'TransRápida', '12.345.678/0001-01', '(11) 4000-0001'),
  (2, 'EntregaJá',   '98.765.432/0001-99', '(11) 4000-0002');

-- === PEDIDO ===
INSERT INTO PEDIDO (id_pedido, data_pedido, status_pedido, valor_total,
                    id_cliente, id_endereco_entrega, id_transportadora) VALUES
  (1, '2025-06-01', 'PAGO',      239.80, 1, 1, 1),
  (2, '2025-06-02', 'ENVIADO',  4498.90, 2, 2, 1),
  (3, '2025-06-03', 'PAGO',      199.90, 3, 3, 2),
  (4, '2025-06-04', 'CANCELADO',  39.90, 4, 2, 2);

-- === ITEM_PEDIDO ===
INSERT INTO ITEM_PEDIDO (id_pedido, id_produto, quantidade, preco_unitario) VALUES
  (1, 4, 1, 199.90),   -- Ana comprou 1 Fone
  (1, 5, 1,  39.90),   -- Ana comprou 1 Cabo
  (2, 3, 1, 4299.00),  -- Bruno comprou 1 Notebook
  (2, 5, 5,  39.90),   -- Bruno comprou 5 cabos
  (3, 4, 1, 199.90),   -- Carla comprou 1 Fone
  (4, 5, 1,  39.90);   -- Pedido cancelado

-- === PAGAMENTO ===
INSERT INTO PAGAMENTO (id_pagamento, data_pagamento, valor_pago,
                       metodo_pagamento, status_pagamento, id_pedido) VALUES
  (1, '2025-06-01',  239.80, 'CARTAO_CREDITO', 'APROVADO', 1),
  (2, '2025-06-02', 4498.90, 'PIX',            'APROVADO', 2),
  (3, '2025-06-03',  199.90, 'BOLETO',         'APROVADO', 3),
  (4, '2025-06-04',   39.90, 'CARTAO_CREDITO', 'RECUSADO', 4);
