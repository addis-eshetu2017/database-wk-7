-- Question 1: Transform table to 1NF by splitting multi-valued Products column
-- Step 1: Create normalized table structure
CREATE TABLE OrderDetails_1NF (
    OrderID INT,
    CustomerName VARCHAR(100),
    Product VARCHAR(50)
);

-- Step 2: Insert data with individual products (simulating the transformation)
-- For Order 101
INSERT INTO OrderDetails_1NF (OrderID, CustomerName, Product) 
VALUES 
(101, 'John Doe', 'Laptop'),
(101, 'John Doe', 'Mouse');

-- For Order 102  
INSERT INTO OrderDetails_1NF (OrderID, CustomerName, Product)
VALUES
(102, 'Jane Smith', 'Tablet'),
(102, 'Jane Smith', 'Keyboard'),
(102, 'Jane Smith', 'Mouse');

-- For Order 103
INSERT INTO OrderDetails_1NF (OrderID, CustomerName, Product)
VALUES
(103, 'Emily Clark', 'Phone');

-- Verify 1NF transformation
SELECT * FROM OrderDetails_1NF ORDER BY OrderID, Product;

-- Question 2: Transform 1NF table to 2NF by removing partial dependencies
-- Step 1: Create Orders table to store order-level information
CREATE TABLE Orders_2NF (
    OrderID INT PRIMARY KEY,
    CustomerName VARCHAR(100)
);

-- Step 2: Create OrderItems table to store product-level information
CREATE TABLE OrderItems_2NF (
    OrderItemID INT AUTO_INCREMENT PRIMARY KEY,
    OrderID INT,
    Product VARCHAR(50),
    Quantity INT,
    FOREIGN KEY (OrderID) REFERENCES Orders_2NF(OrderID)
);

-- Step 3: Insert data into Orders table (removing duplicate order information)
INSERT INTO Orders_2NF (OrderID, CustomerName)
SELECT DISTINCT OrderID, CustomerName 
FROM OrderDetails;

-- Step 4: Insert data into OrderItems table (keeping product details)
INSERT INTO OrderItems_2NF (OrderID, Product, Quantity)
SELECT OrderID, Product, Quantity
FROM OrderDetails;

-- Verify 2NF transformation
SELECT 'Orders Table:' AS Verification;
SELECT * FROM Orders_2NF ORDER BY OrderID;

SELECT 'OrderItems Table:' AS Verification;  
SELECT * FROM OrderItems_2NF ORDER BY OrderID, Product;
