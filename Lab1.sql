--1) Write a query that returns the number of customers in New York state.
USE Guitar_Shop
SELECT COUNT(*) AS TotalCustomers
FROM tblCUSTOMER
WHERE CustState LIKE 'New York%';

--2) Write a query that returns the name of the products that are listed as Accessories or Electric Guitars.
SELECT p.ProductName
FROM tblPRODUCT p
	JOIN tblPRODUCT_TYPE pt
		ON p.ProductTypeID = pt.ProductTypeID
WHERE pt.ProductTypeName = 'Accessories' OR pt.ProductTypeName = 'Electric Guitar';

--3) Write a query that returns the name of any product that is a Book or Amplifier as well the company name that supplies them.
SELECT p.ProductName, v.VendorName, pt.ProductTypeName
FROM tblPRODUCT p
	JOIN tblPRODUCT_TYPE pt
		ON p.ProductTypeID = pt.ProductTypeID
	JOIN tblPRODUCT_VENDOR pv
		ON p.ProductID = pv.ProductID
	JOIN tblVendor v
		ON pv.VendorID = v.VendorID
WHERE pt.ProductTypeName = 'Book' OR pt.ProductTypeName like '%Amplifier';

--4) Write a query that returns the number of Orders placed in Oregon, New Mexico and Montana (broken out by State) between May 2001 and July 2005 (inclusive).
SELECT c.CustState, COUNT(o.OrderID) AS totalOrders
FROM tblOrder o
	JOIN tblCUSTOMER c
		ON c.CustID = o.CustID
WHERE 
	o.OrderDate BETWEEN '2001-05-01' and '2005-07-31' AND
		(c.CustState LIKE 'Oregon%' OR
		c.CustState LIKE 'New Mexico%' OR
		c.CustState LIKE 'Montana%')
GROUP BY c.custState;

--5) Write a query that returns the Top 25 customers from Texas based on lifetime dollars spent with GuitarShop. (hint: this includes a GROUP BY as well as an ORDER BY)
SELECT TOP 25 c.CustFname, c.CustLname, SUM(li.Qty * pv.Price) AS TotalSpent
FROM tblCUSTOMER c
	JOIN tblORDER o
		ON c.CustID = o.CustID
	JOIN tblLINE_ITEM li
		ON o.OrderID = li.OrderID
	JOIN tblPRODUCT_VENDOR pv
		ON li.ProductVendorID = pv.ProductVendorID
WHERE c.CustState LIKE 'Texas%'
GROUP BY c.CustID, c.CustFname, c.CustLname
ORDER BY SUM(li.Qty * pv.Price) DESC, c.CustLname, c.CustFname;