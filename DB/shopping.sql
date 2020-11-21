DROP SCHEMA IF EXISTS shopping;

CREATE DATABASE shopping;

USE shopping;

DROM TABLE IF EXISTS Addresses;
CREATE TABLE Addresses
(
    id                INT  auto_increment,
    addressLine1      VARCHAR (1024) NOT NULL ,
    addressLine2      VARCHAR (1024) NULL ,
    pinCode           INT           NULL ,
    latLngCoordinates point         NULL ,
    createdByUserId   INT           NOT NULL ,
    createdDate       datetime      NOT NULL ,
    modifiedByUserId  INT           NOT NULL ,
    modifiedDate      datetime      NOT NULL ,
    statusId          INT           NOT NULL 
    PRIMARY KEY (id)
);


DROP TABLE IF EXISTS Users;
CREATE TABLE Users
(
    id               INT(11)                  NOT NULL AUTO_INCREMENT,
    firstName        varchar(128)             NOT NULL,
    lastName         VARCHAR(128)             NOT NULL,
    username         varchar(128)             NOT NULL,
    password         varchar(128)             NOT NULL,
    email            VARCHAR(128)                      DEFAULT NULL,
    phoneNumber      INT(16),
    role             enum ('Admin','Regular') NOT NULL DEFAULT 'Regular',
    addressId        INT       DEFAULT        NULL,
    createdByUserId  INT(11)                  NOT NULL,
    createdDate      datetime                 NOT NULL,
    modifiedByUserId INT(11)                  NOT NULL,
    modifiedDate     datetime                 NOT NULL,
    statusId         INT(11)                  NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (addressId) REFERENCES Addresses(id),
    UNIQUE KEY (username)
);

DROP TABLE IF EXISTS Products;
CREATE TABLE Products
(
    id               INT AUTO_INCREMENT,
    productName      varchar(128) NOT NULL UNIQUE,
    productBrand     varchar(128) NULL,
    productBarcode   INT          NULL,
    productDetails   varchar(128) NULL,
    imageUrl         VARCHAR(128)   DEFAULT NULL,
    price            FLOAT DEFAULT NULL ,
    createdByUserId  INT          NOT NULL,
    createdDate      datetime     NOT NULL,
    modifiedByUserId INT          NOT NULL,
    modifiedDate     datetime     NOT NULL,
    statusId         INT          NOT NULL,
    PRIMARY KEY (id)
);


DROP TABLE IF EXISTS Carts;
create table Carts
(
    id               INT AUTO_INCREMENT,
    itemId        INT      NOT NULL,
    userId           INT      NOT NULL,
    total            INT      NOT NULL,
    createdByUserId  INT      NOT NULL,
    createdDate      datetime NOT NULL,
    modifiedByUserId INT      NOT NULL,
    modifiedDate     datetime NOT NULL,
    statusId         INT      NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (itemId) REFERENCES Items (id),
    FOREIGN KEY (userId) REFERENCES Users (id)
);

DROP TABLE IF EXISTS Orders;
create table Orders
(
    id               INT AUTO_INCREMENT,
    itemId        INT      NOT NULL,
    userId           INT      NOT NULL,
    cartId           INT      NOT NULL,
    total            INT      NOT NULL,
    createdByUserId  INT      NOT NULL,
    createdDate      datetime NOT NULL,
    modifiedByUserId INT      NOT NULL,
    modifiedDate     datetime NOT NULL,
    statusId         INT      NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (itemId) REFERENCES Items (id),
    FOREIGN KEY (userId) REFERENCES Users (id),
    FOREIGN KEY (cartId) REFERENCES Carts (id)
);

DROP TABLE IF EXISTS Items;
create table Items
(
    id               INT AUTO_INCREMENT,
    productId        INT      NOT NULL,
    quantity         INT      NOT NULL,
    total            INT      NOT NULL,
    createdByUserId  INT      NOT NULL,
    createdDate      datetime NOT NULL,
    modifiedByUserId INT      NOT NULL,
    modifiedDate     datetime NOT NULL,
    statusId         INT      NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (productId) REFERENCES Products (id)
);
