/*
 * 01_eletroshop_create_tables.sql
 * Criação do banco de dados e das tabelas da EletroShop Online
 * SGBD-alvo: MySQL (Workbench)
 */

-- Cria o banco, se ainda não existir
CREATE DATABASE IF NOT EXISTS eletroshop;
USE eletroshop;

-- ==========================
-- TABELA: CLIENTE
-- ==========================
CREATE TABLE IF NOT EXISTS CLIENTE (
    id_cliente       INT AUTO_INCREMENT PRIMARY KEY,
    nome             VARCHAR(100) NOT NULL,
    email            VARCHAR(100) NOT NULL UNIQUE,
    telefone         VARCHAR(20),
    cpf_cnpj         VARCHAR(20),
    data_nascimento  DATE,
    status           VARCHAR(20) DEFAULT 'ATIVO'
);

-- ==========================
-- TABELA: ENDERECO
-- ==========================
CREATE TABLE IF NOT EXISTS ENDERECO (
    id_endereco      INT AUTO_INCREMENT PRIMARY KEY,
    logradouro       VARCHAR(120) NOT NULL,
    numero           VARCHAR(10)  NOT NULL,
    bairro           VARCHAR(60),
    cidade           VARCHAR(60)  NOT NULL,
    estado           CHAR(2)      NOT NULL,
    cep              VARCHAR(10),
    tipo_endereco    VARCHAR(20)  NOT NULL,
    id_cliente       INT          NOT NULL,
    CONSTRAINT fk_endereco_cliente
        FOREIGN KEY (id_cliente) REFERENCES CLIENTE(id_cliente)
);

-- ==========================
-- TABELA: CATEGORIA
-- ==========================
CREATE TABLE IF NOT EXISTS CATEGORIA (
    id_categoria INT AUTO_INCREMENT PRIMARY KEY,
    nome         VARCHAR(50) NOT NULL UNIQUE,
    descricao    TEXT
);

-- ==========================
-- TABELA: PRODUTO
-- ==========================
CREATE TABLE IF NOT EXISTS PRODUTO (
    id_produto         INT AUTO_INCREMENT PRIMARY KEY,
    nome               VARCHAR(100) NOT NULL,
    descricao          TEXT,
    preco              DECIMAL(10,2) NOT NULL,
    quantidade_estoque INT NOT NULL DEFAULT 0,
    id_categoria       INT,
    CONSTRAINT fk_produto_categoria
        FOREIGN KEY (id_categoria) REFERENCES CATEGORIA(id_categoria)
);

-- ==========================
-- TABELA: TRANSPORTADORA
-- ==========================
CREATE TABLE IF NOT EXISTS TRANSPORTADORA (
    id_transportadora INT AUTO_INCREMENT PRIMARY KEY,
    nome              VARCHAR(100) NOT NULL,
    cnpj              VARCHAR(20),
    telefone          VARCHAR(20)
);

-- ==========================
-- TABELA: PEDIDO
-- ==========================
CREATE TABLE IF NOT EXISTS PEDIDO (
    id_pedido           INT AUTO_INCREMENT PRIMARY KEY,
    data_pedido         DATE        NOT NULL,
    status_pedido       VARCHAR(20) NOT NULL,
    valor_total         DECIMAL(10,2),
    id_cliente          INT         NOT NULL,
    id_endereco_entrega INT         NOT NULL,
    id_transportadora   INT,
    CONSTRAINT fk_pedido_cliente
        FOREIGN KEY (id_cliente)          REFERENCES CLIENTE(id_cliente),
    CONSTRAINT fk_pedido_endereco
        FOREIGN KEY (id_endereco_entrega) REFERENCES ENDERECO(id_endereco),
    CONSTRAINT fk_pedido_transportadora
        FOREIGN KEY (id_transportadora)   REFERENCES TRANSPORTADORA(id_transportadora)
);

-- ==========================
-- TABELA: ITEM_PEDIDO
-- ==========================
CREATE TABLE IF NOT EXISTS ITEM_PEDIDO (
    id_pedido     INT NOT NULL,
    id_produto    INT NOT NULL,
    quantidade    INT NOT NULL,
    preco_unitario DECIMAL(10,2) NOT NULL,
    PRIMARY KEY (id_pedido, id_produto),
    CONSTRAINT fk_item_pedido_pedido
        FOREIGN KEY (id_pedido)  REFERENCES PEDIDO(id_pedido),
    CONSTRAINT fk_item_pedido_produto
        FOREIGN KEY (id_produto) REFERENCES PRODUTO(id_produto)
);

-- ==========================
-- TABELA: PAGAMENTO
-- ==========================
CREATE TABLE IF NOT EXISTS PAGAMENTO (
    id_pagamento     INT AUTO_INCREMENT PRIMARY KEY,
    data_pagamento   DATE,
    valor_pago       DECIMAL(10,2),
    metodo_pagamento VARCHAR(20),
    status_pagamento VARCHAR(20),
    id_pedido        INT UNIQUE,   -- 1:1 com PEDIDO
    CONSTRAINT fk_pagamento_pedido
        FOREIGN KEY (id_pedido) REFERENCES PEDIDO(id_pedido)
);
