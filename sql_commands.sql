##SQL commands

CREATE TABLE "Company" (
	"Name"	varchar(20) NOT NULL,
	"CompanyID"	INTEGER NOT NULL,
	CONSTRAINT PRIMARY KEY("CompanyID")
		ON UPDATE CASCADE
		ON DELETE SET DEFAULT
);

CREATE TABLE "Warehouse" (
	"WarehouseID"	INTEGER NOT NULL,
	"Size"	INTEGER,
	"CompanyID"	INTEGER,
	CONSTRAINT FOREIGN KEY("CompanyID") REFERENCES "Company"
		ON UPDATE CASCADE
		ON DELETE SET DEFAULT,
	CONSTRAINT PRIMARY KEY("WarehouseID")
		ON UPDATE CASCADE
		ON DELETE SET DEFAULT
);


CREATE TABLE "Products" (
	"ProductID"	INTEGER NOT NULL,
	"WarehouseID"	INTEGER NOT NULL,
	"Price"	INTEGER NOT NULL,
	"Name" varchar(20),
	CONSTRAINT FOREIGN KEY("WarehouseID") REFERENCES "Warehouse"
		ON UPDATE CASCADE
		ON DELETE SET DEFAULT,
	CONSTRAINT PRIMARY KEY("ProductID")
		ON UPDATE CASCADE
		ON DELETE SET DEFAULT
);


CREATE TABLE "Orders" (
	"OrderID"	INTEGER NOT NULL,
	"ProductID"	INTEGER NOT NULL,
	CONSTRAINT FOREIGN KEY("ProductID") REFERENCES "Products"
		ON UPDATE CASCADE
		ON DELETE SET DEFAULT,
	CONSTRAINT PRIMARY KEY("OrderID")
		ON UPDATE CASCADE
		ON DELETE SET DEFAULT
);


CREATE TABLE "Payment" (
	"PaymentID"	INTEGER NOT NULL,
	"OrderID"	INTEGER NOT NULL,
	"Duedate"	varchar(20) NOT NULL,
	"Sum"	INTEGER NOT NULL,
	CONSTRAINT FOREIGN KEY("OrderID") REFERENCES "Orders"
		ON UPDATE CASCADE
		ON DELETE SET DEFAULT,
	CONSTRAINT PRIMARY KEY("PaymentID")
		ON UPDATE CASCADE
		ON DELETE SET DEFAULT
);


CREATE TABLE "User" (
	"Username"	varchar(20) NOT NULL,
	"OrderID"	INTEGER NOT NULL,
	CONSTRAINT FOREIGN KEY("OrderID") REFERENCES "Orders"
		ON UPDATE CASCADE
		ON DELETE SET DEFAULT,
	CONSTRAINT PRIMARY KEY("Username")
		ON UPDATE CASCADE
		ON DELETE SET DEFAULT
);


INSERT INTO Company VALUES ('Zara', 1);

INSERT INTO Warehouse VALUES
	(1, 100, 1),
	(2, 150, 1);

INSERT INTO Products VALUES
	(1, 1, 12, "Black T-shit"),
	(2, 1, 8, "Flower shirt"),
	(3, 1, 10, "Green tights"),
	(4, 2, 11, "White collage"),
	(5, 2, 5, "Stripe socks"),
	(6, 2, 3, "Olive hat"),
	(7, 2, 7, "Classic gloves");

INSERT INTO Orders VALUES
	(1, 2),
	(2, 2),
	(3, 5),
	(4, 7),
	(5, 6),
	(6, 1),
	(7, 3),
	(8, 4),
	(9, 4),
	(10, 2),
	(11, 5),
	(12, 1);

INSERT INTO User VALUES
	("Matti", 2),
	("Sanna", 3),
	("Saara", 5),
	("Juho", 8),
	("Mika", 1),
	("Anna", 12),
	("Minna", 6),
	("Liisa", 7),
	("Martta", 4),
	("Alisa", 9),
	("Nanna", 11),
	("Lauri", 10);

INSERT INTO Payment VALUES
	(1, 2, "10/03/22", 8),
	(2, 3, "07/03/22", 5),
	(3, 5, "22/04/22", 3),
	(4, 8, "15/03/22", 11),
	(5, 1, "03/04/22", 8),
	(6, 12, "10/04/22", 12),
	(7, 6, "09/03/22", 12),
	(8, 7, "04/03/22", 10),
	(9, 4, "31/3/22", 7),
	(10, 9, "28/02/22", 11),
	(11, 11, "14/02/22", 5),
	(12, 10, "01/04/22", 8);

