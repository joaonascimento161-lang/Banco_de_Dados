CREATE DATABASE cinema;
USE cinema;

CREATE TABLE cliente (
    id_cliente INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    cpf VARCHAR(11) NOT NULL UNIQUE,
    email VARCHAR(100) UNIQUE,
    status ENUM('ativo', 'inativo') DEFAULT 'ativo'
);

CREATE TABLE categoria (
    id_categoria INT AUTO_INCREMENT PRIMARY KEY,
    descricao VARCHAR(50) NOT NULL
);

CREATE TABLE filme (
    id_filme INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    faixa_etaria INT CHECK (faixa_etaria >= 0),
    duracao INT,
    id_categoria INT NOT NULL,
    status ENUM('em_cartaz', 'fora_cartaz') DEFAULT 'em_cartaz',
    FOREIGN KEY (id_categoria)
        REFERENCES categoria (id_categoria)
);

CREATE TABLE sala (
    id_sala INT AUTO_INCREMENT PRIMARY KEY,
    descricao VARCHAR(100),
    tipo ENUM('2D', '3D', 'IMAX') DEFAULT '2D',
    capacidade INT NOT NULL CHECK (capacidade > 0),
    vip BOOLEAN DEFAULT FALSE
);

CREATE TABLE sessao (
    id_sessao INT AUTO_INCREMENT PRIMARY KEY,
    data_hora DATETIME NOT NULL,
    id_sala INT NOT NULL,
    id_filme INT NOT NULL,
    status ENUM('aberta', 'encerrada', 'cancelada') DEFAULT 'aberta',
    UNIQUE (data_hora , id_sala),
    FOREIGN KEY (id_sala)
        REFERENCES sala (id_sala),
    FOREIGN KEY (id_filme)
        REFERENCES filme (id_filme)
);

CREATE TABLE assento (
    id_assento INT AUTO_INCREMENT PRIMARY KEY,
    id_sala INT NOT NULL,
    fila VARCHAR(5),
    numero INT,
    UNIQUE (id_sala , fila , numero),
    FOREIGN KEY (id_sala)
        REFERENCES sala (id_sala)
);

CREATE TABLE pedido (
    id_pedido INT AUTO_INCREMENT PRIMARY KEY,
    data_hora DATETIME DEFAULT CURRENT_TIMESTAMP,
    id_cliente INT,
    status ENUM('aberto', 'pago', 'cancelado') DEFAULT 'aberto',
    FOREIGN KEY (id_cliente)
        REFERENCES cliente (id_cliente)
);

CREATE TABLE ingresso (
    id_ingresso INT AUTO_INCREMENT PRIMARY KEY,
    id_pedido INT NOT NULL,
    id_sessao INT NOT NULL,
    id_assento INT NOT NULL,
    id_tipo INT NOT NULL,
    valor_pago DECIMAL(10 , 2 ) NOT NULL,
    status ENUM('reservado', 'pago', 'cancelado') DEFAULT 'reservado',
    UNIQUE (id_sessao , id_assento),
    FOREIGN KEY (id_pedido)
        REFERENCES pedido (id_pedido),
    FOREIGN KEY (id_sessao)
        REFERENCES sessao (id_sessao),
    FOREIGN KEY (id_assento)
        REFERENCES assento (id_assento),
    FOREIGN KEY (id_tipo)
        REFERENCES tipo_ingresso (id_tipo)
);

SELECT * FROM cliente;
select * from categoria;
select * from filme;
select * from sala;
select * from sessao;
select * from assento;
select * from pedido;
select * from ingresso;