CREATE DATABASE GestionStock
GO

USE GestionStock
GO

CREATE TABLE Category(
	CategoryID INT PRIMARY KEY IDENTITY(1, 1),
	[Name] VARCHAR(60)
)
GO

CREATE TABLE Product(
	ProductID int PRIMARY KEY IDENTITY(1, 1),
	[Name] VARCHAR(60),
	Prix DECIMAL,
	FK_CategoryID INT FOREIGN KEY REFERENCES Category(CategoryID)
	ON UPDATE CASCADE 
	ON DELETE CASCADE
)
GO

CREATE TABLE Achat(
	AchatID INT PRIMARY KEY IDENTITY(1, 1),
	FK_ProductID INT FOREIGN KEY REFERENCES Product(ProductID),
	DateAchat DATE
)
GO

CREATE TABLE Stock(
	StockID INT PRIMARY KEY IDENTITY(1, 1),
	FK_ProductID INT UNIQUE FOREIGN KEY REFERENCES Product(ProductID),
	amount INT NOT NULL
)
GO


GO
INSERT INTO Category([Name]) VALUES ('Food'), ('Stuff'), ('Substances')
GO
INSERT INTO Product ([Name], Prix, FK_CategoryID) VALUES ('Bread', 2.40, 1), ('Tuna', 5.67, 1), ('Lard', 2.60, 1),
														 ('Towel', 5.67, 2), ('Shit', 50, 3), ('Marzipan', 101.3, 1),
														 ('Piska', 1000, 2), ('2C-B', 40, 3), ('Pillow', 31.4, 2)
GO
INSERT INTO Achat (FK_ProductID, DateAchat) VALUES (1, '2019-11-11'), (4, '2019-10-25'), (8, '2020-01-12'),
                                                   (3, '2019-03-29'), (7, '2020-02-15'), (3, '2020-01-25'),
												   (3, '2019-08-30'), (4, '2019-10-11'), (9, '2019-05-02'),
												   (8, '2019-11-10'), (2, '2019-02-11'), (3, '2019-02-11'),
												   (9, '2020-01-11'), (4, '2019-04-11'), (6, '2019-02-17'),
												   (2, '2020-01-23'), (7, '2019-04-11'), (9, '2019-07-18')

GO
INSERT INTO Stock(FK_ProductID, amount) VALUES (1, 100), (3, 76), (4, 200), (5, 0), (6, 2), (8, 234), (9, 567) 

SELECT cat.Name AS Category, SUM(amount) AS Current_stocks
FROM Stock
INNER JOIN Product AS p ON p.ProductID = Stock.FK_ProductID
INNER JOIN Category AS cat ON cat.CategoryID = p.FK_CategoryID
GROUP BY cat.Name
GO

