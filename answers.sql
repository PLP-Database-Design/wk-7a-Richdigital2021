-- =============================================
-- Question 1: Achieving 1NF (First Normal Form)
-- =============================================


-- Creating ProductDetail table

CREATE TABLE ProductDetail (
    OrderID INT,
    CustomerName VARCHAR(100),
    Products VARCHAR(100)
);

-- Inserting data into ProductDetail table to achieve 1NF
-- Each product in a separate row, even if it belongs to the same order and customer

INSERT INTO ProductDetail(OrderID, CustomerName, Products)
VALUES
(101, 'John Doe', 'Laptop'),
(101, 'John Doe', 'Mouse'),
(102, 'Jane Smith', 'Tablet'),
(102, 'Jane Smith', 'Keyboard'),
(102, 'Jane Smith', 'Mouse'),
(103, 'Emily Clark', 'Phone');


    

-- ==============================================
-- Question 2: Achieving 2NF (Second Normal Form)
-- ==============================================

-- Creating Orders table

CREATE TABLE Orders(
    OrderID INT,
    CustomerName VARCHAR(100),
);

-- Inserting data into Orders table to achieve 2NF
-- Each order with its customer name, ensuring no partial dependency
INSERT INTO Orders VALUES
(101, 'John Doe'),
(101, 'John Doe'),
(102, 'Jane Smith'),
(102, 'Jane Smith'),
(102, 'Jane Smith'),
(103, 'Emily Clark');

-- Creating Product table

CREATE TABLE Product (
    OrderID INT,
    Product VARCHAR(100),
    Quantity INT,
    PRIMARY KEY (OrderID, Product),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);

-- Inserting data into Product table to achieve 2NF
-- Each product with its quantity, ensuring no partial dependency

INSERT INTO Product (OrderID, Product, Quantity)
VALUES
(101, 'Laptop', 2),
(101, 'Mouse', 1),
(102, 'Tablet', 3),
(102, 'Keyboard', 1),
(102, 'Mouse', 2),
(103, 'Phone', 1);