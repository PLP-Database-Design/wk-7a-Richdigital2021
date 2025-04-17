-- =============================================
-- Question 1: Achieving 1NF (First Normal Form)
-- =============================================
-- Transform multi-valued Products into atomic values (1 product per row)

-- Simulate original ProductDetail table
DROP TEMPORARY TABLE IF EXISTS ProductDetail;
CREATE TEMPORARY TABLE ProductDetail (
    OrderID INT,
    CustomerName VARCHAR(100),
    Products VARCHAR(255)
);

INSERT INTO ProductDetail VALUES
(101, 'John Doe', 'Laptop, Mouse'),
(102, 'Jane Smith', 'Tablet, Keyboard, Mouse'),
(103, 'Emily Clark', 'Phone');

-- Create helper numbers table (for splitting strings)
DROP TEMPORARY TABLE IF EXISTS numbers;
CREATE TEMPORARY TABLE numbers (n INT);
INSERT INTO numbers VALUES (1), (2), (3), (4), (5);

-- Use SUBSTRING_INDEX to split products into rows
SELECT 
    pd.OrderID,
    pd.CustomerName,
    TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(pd.Products, ',', n.n), ',', -1)) AS Product
FROM 
    ProductDetail pd
JOIN 
    numbers n ON n.n <= 1 + LENGTH(pd.Products) - LENGTH(REPLACE(pd.Products, ',', ''))
WHERE 
    TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(pd.Products, ',', n.n), ',', -1)) <> '';
    

-- ==============================================
-- Question 2: Achieving 2NF (Second Normal Form)
-- ==============================================
-- Remove partial dependency: CustomerName depends on OrderID (not full key)

-- Simulate original OrderDetails table
DROP TEMPORARY TABLE IF EXISTS OrderDetails;
CREATE TEMPORARY TABLE OrderDetails (
    OrderID INT,
    CustomerName VARCHAR(100),
    Product VARCHAR(100),
    Quantity INT
);

INSERT INTO OrderDetails VALUES
(101, 'John Doe', 'Laptop', 2),
(101, 'John Doe', 'Mouse', 1),
(102, 'Jane Smith', 'Tablet', 3),
(102, 'Jane Smith', 'Keyboard', 1),
(102, 'Jane Smith', 'Mouse', 2),
(103, 'Emily Clark', 'Phone', 1);

-- Step 1: CustomerOrder table (each order’s customer info)
SELECT DISTINCT OrderID, CustomerName
FROM OrderDetails;

-- Step 2: OrderItems table (each product in each order)
SELECT OrderID, Product, Quantity
FROM OrderDetails;


