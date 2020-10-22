DROP SCHEMA IF EXISTS shopping;

CREATE DATABASE shopping;

USE shopping;

DROP TABLE IF EXISTS Users;
CREATE TABLE Users
(
    id               int(11)                  NOT NULL AUTO_INCREMENT,
    firstName        varchar(128)             NOT NULL,
    lastName         VARCHAR(128)             NOT NULL,
    username         varchar(128)             NOT NULL,
    password         varchar(128)             NOT NULL,
    email            VARCHAR(128)             NULL,
    phoneNumber      INT(16),
    role             enum ('Admin','Regular') NOT NULL DEFAULT 'Regular',
    createdByUserId  int(11)                  NOT NULL,
    createdDate      datetime                 NOT NULL,
    modifiedByUserId int(11)                  NOT NULL,
    modifiedDate     datetime                 NOT NULL,
    statusId         int(11)                  NOT NULL,
    PRIMARY KEY (id),
    UNIQUE KEY (username)
);

DROP TABLE IF EXISTS Products;
create table Products
(
    id               int AUTO_INCREMENT,
    productName      varchar(128) not null UNIQUE,
    productBrand     varchar(128) null,
    productBarcode   int          null,
    productDetails   varchar(128) null,
    createdByUserId  int          not null,
    createdDate      datetime     not null,
    modifiedByUserId int          not null,
    modifiedDate     datetime     not null,
    statusId         int          not null,
    PRIMARY KEY (id)
);

DROP TABLE IF EXISTS Carts;
create table Carts
(
    id               int AUTO_INCREMENT,
    productId        INT      NOT NULL,
    userId           INT      NOT NULL,
    total            INT      NOT NULL,
    createdByUserId  int      not null,
    createdDate      datetime not null,
    modifiedByUserId int      not null,
    modifiedDate     datetime not null,
    statusId         int      not null,
    PRIMARY KEY (id),
    FOREIGN KEY (productId) REFERENCES Products (id),
    FOREIGN KEY (userId) REFERENCES Users (id)
);

DROP TABLE IF EXISTS Orders;
create table Orders
(
    id               int AUTO_INCREMENT,
    productId        INT      NOT NULL,
    userId           INT      NOT NULL,
    cartId           INT      NOT NULL,
    total            INT      NOT NULL,
    createdByUserId  int      not null,
    createdDate      datetime not null,
    modifiedByUserId int      not null,
    modifiedDate     datetime not null,
    statusId         int      not null,
    PRIMARY KEY (id),
    FOREIGN KEY (productId) REFERENCES Products (id),
    FOREIGN KEY (userId) REFERENCES Users (id),
    FOREIGN KEY (cartId) REFERENCES Carts (id)
);
