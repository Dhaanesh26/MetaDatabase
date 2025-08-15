/*******************************************************
 *                                                     *
 *        🍋 Meta Certification Practice - SQL         
 *        🎯 Focus Area: Database Engineering          
 *                                                    
 * 📁 Section: Customer & Booking Table Setup         
 * 📌 Purpose:                                        
 *     - Create and populate the `Customers` table    
 *     - Create and populate the `Bookings` table     
 *     - Explore various SQL joins (INNER, LEFT, etc.)
 *                                                    
 * 🔍 Highlights:                                     
 *     ✔️ Referential integrity using FOREIGN KEYs     
 *     ✔️ Constraints: NOT NULL, UNIQUE, CHECK         
 *     ✔️ Real-world queries for business insights     
 *                                                    
 * Author: Dhaanesh 🛠️                  
 * Certification Track: Meta Database Engineer    
 *                                                    *
 *******************************************************/



-- create customers table and insert columns
CREATE TABLE Customers(CustomerID INT NOT NULL PRIMARY KEY, FullName VARCHAR(100) NOT NULL, PhoneNumber INT NOT NULL UNIQUE);
INSERT INTO Customers(CustomerID, FullName, PhoneNumber) VALUES (1, 'Vanessa McCarthy', 0757536378), (2, 'Marcos Romero', 0757536379), (3, 'Hiroki Yamane', 0757536376), (4, 'Anna Iversen', 0757536375), (5, 'Diana Pinto', 0757536374);

-- create bookings table and insert columns 
CREATE TABLE Bookings (BookingID INT NOT NULL PRIMARY KEY,  BookingDate DATE NOT NULL,  TableNumber INT NOT NULL, NumberOfGuests INT NOT NULL CHECK (NumberOfGuests <= 8), CustomerID INT NOT NULL, FOREIGN KEY (CustomerID) REFERENCES Customers (CustomerID) ON DELETE CASCADE ON UPDATE CASCADE); 
INSERT INTO Bookings (BookingID, BookingDate, TableNumber, NumberOfGuests, CustomerID) VALUES (10, '2021-11-11', 7, 5, 1), (11, '2021-11-10', 5, 2, 2), (12, '2021-11-10', 3, 2, 4);

/* LEFT JOIN */

-- left join merges every data from left table and only the matched column from right
SELECT 
    c.CustomerID AS 'Customer ID', c.FullName AS 'Full Name', b.BookingID AS 'Booking ID', b.BookingID AS 'Booking ID', b.NumberOfGuests AS 'No of Guests'
FROM 
    Customers AS c LEFT JOIN Bookings AS b
ON
    c.CustomerID = b.CustomerID;


/* RIGHT JOIN */

-- right join merges every data from right table and only the matched column from left
SELECT 
    c.CustomerID AS 'Customer ID', c.FullName AS 'Full Name', b.BookingID AS 'Booking ID', b.NumberOfGuests AS 'No of Guests'
FROM 
    Customers AS c RIGHT JOIN Bookings AS b 
ON 
    c.CustomerID = b.CustomerID

/* SELF JOIN */

-- creates a join between same table to extract particular information
CREATE TABLE Employees(EmployeeID INT, FullName VARCHAR(100), JobTitle VARCHAR(1000), Country VARCHAR(100), LineManagerID INT);
INSERT INTO Employees(EmployeeID, FullName, JobTitle, Country, LineManagerID)
VALUES (1, 'Jonathan Moore', 'English Lit', 'United Kingdom', 351),
       (2, 'Paul Mark', 'Software Engineer', 'Portugal', 352),
       (3, 'Robin Wood', 'Quality Analyst', 'United States', 353),
       (4, 'Marko Jansen', 'Software Engineer', 'Monaco', 354),
       (5, 'Greta galkana', 'English Lit', 'Monaco', 355);


-- self join to query which line manager manages which employee
SELECT 
    e1.FullName AS 'Line Manager', e2.FullName AS 'Employee'
FROM 
    Employees AS e1 INNER JOIN Employees AS e2
ON 
    e1.EmployeeID = e2.LineManagerID;


/* Task 1: Meta want a list of all customers who have made bookings. Write an INNER JOIN SQL statement to combine 
    the full name and the phone number of each customer from the Customers table with the related booking date and 'number of guests' 
    from the Bookings table */ 

SELECT
    c.FullName AS 'Full Name', c.PhoneNumber AS 'Phone Number', b.BookingDate AS 'Booking Date', b.NumberOfGuests
FROM 
    Customers AS c INNER JOIN Bookings as b
ON 
    c.CustomerID = b.CustomerID;

/* Task 2: Little Lemon want to view information about all existing customers with bookings that have been made so far. 
    This data must include customers who haven’t made any booking yet. Write a LEFT JOIN SQL statement to view the customer id 
    from Customers table and the related booking id from the Bookings table. */

SELECT 
    c.CustomerID AS 'Customer ID', b.BookingID AS 'Booking ID'
FROM 
    Customers AS c LEFT JOIN Bookings as b
ON 
    c.CustomerID = b.CustomerID
ORDER BY 
    [Customer ID] DESC;
