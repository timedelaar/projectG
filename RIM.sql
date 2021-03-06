USE OutdoorParadise;

DECLARE @sql NVARCHAR(MAX);
SET @sql = N'';

SELECT @sql = @sql + N'
  ALTER TABLE ' + QUOTENAME(s.name) + N'.'
  + QUOTENAME(t.name) + N' DROP CONSTRAINT '
  + QUOTENAME(c.name) + ';'
FROM sys.objects AS c
INNER JOIN sys.tables AS t
ON c.parent_object_id = t.[object_id]
INNER JOIN sys.schemas AS s 
ON t.[schema_id] = s.[schema_id]
WHERE c.[type] IN ('D','C','F','PK','UQ')
ORDER BY c.[type];

--PRINT @sql;
EXEC sys.sp_executesql @sql;

USE [OutdoorParadise];

IF OBJECT_ID('dbo.Supplier', 'U') IS NOT NULL
	DROP TABLE dbo.Supplier;

CREATE TABLE dbo.Supplier(
supplier_id     	INT				NOT NULL,
company_name        NVARCHAR(50) 	NOT NULL,
contact_name        NVARCHAR(50) 	NOT NULL,
contact_title       NVARCHAR(50) 	NOT NULL,
address             NVARCHAR(50) 	NOT NULL,
city                NVARCHAR(50) 	NOT NULL,
postalcode     	    INT         	NOT NULL,
country_id          INT         	NOT NULL,
phone               NVARCHAR(50) 	NOT NULL,
region              NVARCHAR(10)	NULL,
fax                 NVARCHAR(50)	NULL,
CONSTRAINT pk_Supplier
	PRIMARY KEY (supplier_id)
);

IF OBJECT_ID('dbo.Retailer', 'U') IS NOT NULL
	DROP TABLE dbo.Retailer;

CREATE TABLE dbo.Retailer(
retailer_id			INT				NOT NULL,
company_name		NVARCHAR(255)	NULL,
type				NVARCHAR(1)	NULL CHECK(type = 'b' OR type = 's'),
discount			INT				NULL,
max_quantity_order	INT				NULL,
retailer_type_code	INT				NULL,
CONSTRAINT pk_Retailer
	PRIMARY KEY (retailer_id)
);

IF OBJECT_ID('dbo.Retailer_type', 'U') IS NOT NULL
	DROP TABLE dbo.Retailer_type;

CREATE TABLE dbo.Retailer_type(
retailer_type_code	INT				NOT NULL,
type_name_en		NVARCHAR(25)	NOT NULL,
CONSTRAINT pk_Retailer_type
	PRIMARY KEY (retailer_type_code)
);

IF OBJECT_ID('dbo.Retailer_site', 'U') IS NOT NULL
	DROP TABLE dbo.Retailer_site;

CREATE TABLE dbo.Retailer_site(
retailer_site_code	INT				NOT NULL,
retailer_code		INT				NOT NULL,
first_name			NVARCHAR(255)	NULL,
last_name			NVARCHAR(255)	NULL,
address1			NVARCHAR(50)	NOT NULL,
address2			NVARCHAR(50)	NULL,
city				NVARCHAR(40)	NULL,	
phone               NVARCHAR(50)    NULL,		
region				NVARCHAR(50)	NULL,
postal_zone			NVARCHAR(10)	NULL,
country_code		INT				NOT NULL,
active_indicator	Bit				NOT NULL,
CONSTRAINT pk_Retailer_site
	PRIMARY KEY (retailer_site_code)
);

IF OBJECT_ID('dbo.Employee', 'U') IS NOT NULL
	DROP TABLE dbo.Employee;

CREATE TABLE dbo.Employee(
emp_id				INT				NOT NULL,
manager_id			INT				NULL,
emp_fname			NVARCHAR(255)	NULL,
emp_lname			NVARCHAR(255)	NULL,
branch_id			INT				NULL,			
street				NVARCHAR(255)	NULL,
city				NVARCHAR(255)	NULL,
region				NVARCHAR(255)	NULL,
postal_code			NVARCHAR(255)	NULL,
phone				NVARCHAR(255)	NULL,
fax			     	NVARCHAR(255)	NULL,
email				NVARCHAR(255)	NULL,
status				NVARCHAR(5)		NULL,
ss_number			NVARCHAR(255)	NULL,
salary				DECIMAL(15,2)	NULL,
job_id				INT				NULL,
extension			NVARCHAR(6)		NULL,
start_date			DATE			NULL,
termination_date	DATE			NULL,
birth_date			DATE			NULL,
bene_health_ins		NVARCHAR(1)		NULL CHECK(bene_health_ins = 'Y' OR bene_health_ins = 'N'),
bene_life_ins		NVARCHAR(1)		NULL CHECK(bene_life_ins = 'Y' OR bene_life_ins = 'N'),
bene_day_care		NVARCHAR(1)		NULL CHECK(bene_day_care = 'Y' OR bene_day_care = 'N'),
sex					NVARCHAR(1)		NULL CHECK(sex = 'M' OR sex = 'F'),
cv					NVARCHAR(50)	NULL,
CONSTRAINT pk_Employee
	PRIMARY KEY (emp_id)
);

IF OBJECT_ID('dbo.Job', 'U') IS NOT NULL
	DROP TABLE dbo.Job;

CREATE TABLE dbo.Job(
job_number			INT				NOT NULL,
job_id				NVARCHAR(10)	NULL,
job_title			NVARCHAR(50)	NULL,
min_salary			DECIMAL(15,2)	NULL,
max_salary			DECIMAL(15,2)	NULL,
CONSTRAINT pk_Job
	PRIMARY KEY (job_number)
);

IF OBJECT_ID('dbo.Country', 'U') IS NOT NULL
	DROP TABLE dbo.Country;

CREATE TABLE dbo.Country(
country_code		INT				NOT NULL,
country				NVARCHAR(50)	NOT NULL,
language			NVARCHAR(2)		NOT NULL,
currency_name		NVARCHAR(50)	NULL,
CONSTRAINT pk_Country
	PRIMARY KEY (country_code)
);

IF OBJECT_ID('dbo.Branch', 'U') IS NOT NULL
	DROP TABLE dbo.Branch;

CREATE TABLE dbo.Branch(
branch_id			INT				NOT NULL,
branch_name			NVARCHAR(255)	NULL,
branch_head_id		INT				NULL,
address1			NVARCHAR(50)	NOT NULL,
address2			NVARCHAR(50)	NULL,
city				NVARCHAR(40)	NULL,			
region				NVARCHAR(50)	NULL,
postal_zone			NVARCHAR(10)	NULL,
country_code		INT				NOT NULL,
sales_region		NVARCHAR(50)	NULL,
CONSTRAINT pk_Branch
	PRIMARY KEY (branch_id)
);

IF OBJECT_ID('dbo.Training', 'U') IS NOT NULL
	DROP TABLE dbo.Training;

CREATE TABLE dbo.Training(
employee_id			INT				NOT NULL,
course_id			INT				NOT NULL,
year				INT				NOT NULL,
CONSTRAINT pk_Training
	PRIMARY KEY (employee_id, course_id)
);

IF OBJECT_ID('dbo.Course', 'U') IS NOT NULL
	DROP TABLE dbo.Course;

CREATE TABLE dbo.Course(
course_id			INT				NOT NULL,
course_name			NVARCHAR(50)	NOT NULL,
CONSTRAINT pk_Course
	PRIMARY KEY (course_id)
);

IF OBJECT_ID('dbo.Performance_review', 'U') IS NOT NULL
	DROP TABLE dbo.Performance_review;

CREATE TABLE dbo.Performance_review(
emp_id				INT				NOT NULL,
review_date			DATE			NOT NULL,
bonus_amount		DECIMAL(15,5)	NOT NULL,
bonus_awarded		NVARCHAR(1)		NOT NULL,
CONSTRAINT pk_Bonus
	PRIMARY KEY (emp_id, review_date, bonus_amount)
);

IF OBJECT_ID('dbo.Supplier_order', 'U') IS NOT NULL
	DROP TABLE dbo.Supplier_order;

CREATE TABLE dbo.Supplier_order(
order_id			INT				NOT NULL,
supplier_id			INT				NULL,
emp_id				INT				NOT NULL,
order_date			DATE			NOT NULL,
required_date		DATE			NOT NULL,
shipped_date		DATE			NULL,
warehouse_id		INT				NOT NULL
CONSTRAINT pk_Supplier_order
	PRIMARY KEY (order_id)
);

IF OBJECT_ID('dbo.Supplier_orderline', 'U') IS NOT NULL
	DROP TABLE dbo.Supplier_orderline;

CREATE TABLE dbo.Supplier_orderline(
order_id			INT				NOT NULL,
line_id				INT				NOT NULL,
product_id			INT				NOT NULL,
quantity			INT				NOT NULL,
unit_price			DECIMAL(10,2)	NOT NULL,
discount			DECIMAL(3,3)	NOT NULL,
CONSTRAINT pk_Supplier_orderline
	PRIMARY KEY (order_id, line_id)
);

IF OBJECT_ID('dbo.Returned_item', 'U') IS NOT NULL
	DROP TABLE dbo.Returned_item;

CREATE TABLE dbo.Returned_item(
return_code			INT				NOT NULL,
return_date			DATE			NOT NULL,
orderline_code		INT			 	NOT NULL,
return_reason		INT				NOT NULL,
return_quantity		INT				NOT NULL,
CONSTRAINT pk_Returned_item
	PRIMARY KEY (return_code)
);

IF OBJECT_ID('dbo.Return_reason', 'U') IS NOT NULL
	DROP TABLE dbo.Return_reason;

CREATE TABLE dbo.Return_reason(
return_reason_code		INT				NOT NULL,
return_description_en	NVARCHAR(50)	NOT NULL,
CONSTRAINT pk_Return_reason
	PRIMARY KEY (return_reason_code)
);

IF OBJECT_ID('dbo.Warehouse', 'U') IS NOT NULL
	DROP TABLE dbo.Warehouse;

CREATE TABLE dbo.Warehouse(
warehouse_id		INT				NOT NULL,
address				NVARCHAR(50)	NULL,
surface             NVARCHAR(15)    NULL,
city				NVARCHAR(30)	NULL,
region				NVARCHAR(30)	NULL,
postal_code			NVARCHAR(10)	NULL,
phone				NVARCHAR(20)	NULL,
CONSTRAINT pk_Warehouse
	PRIMARY KEY (warehouse_id)
);

IF OBJECT_ID('dbo.Inventory_level', 'U') IS NOT NULL
	DROP TABLE dbo.Inventory_level;

CREATE TABLE dbo.Inventory_level(
warehouse_id		INT				NOT NULL,
product_id			INT				NOT NULL,
inventory_count		INT				NULL,
CONSTRAINT pk_Inventory_level
	PRIMARY KEY (warehouse_id, product_id)
);

IF OBJECT_ID('dbo.Inventory_history', 'U') IS NOT NULL
	DROP TABLE dbo.Inventory_history;

CREATE TABLE Inventory_history(
warehouse_id		INT				NOT NULL,
product_id			INT				NOT NULL,
year				INT				NOT NULL,
month				INT				NOT NULL,
count				INT				NULL,
CONSTRAINT pk_Inventory_history
	PRIMARY KEY (warehouse_id, product_id, year, month)
);

IF OBJECT_ID('dbo.Customer_order', 'U') IS NOT NULL
	DROP TABLE dbo.Customer_order;

CREATE TABLE dbo.Customer_order(
order_id			INT				NOT NULL,
retailer_site_code	INT				NOT NULL,
order_date			DATE		 	NULL,
fin_code			NVARCHAR(10)	NULL,
region				NVARCHAR(255)	NULL,
sales_rep			INT				NOT NULL,
order_method_code	INT				NULL,
warehouse_code		INT				NULL,
order_status		NVARCHAR(25)	NULL CHECK(order_status = 'ontvangen' OR order_status = 'wordt samengesteld' OR order_status = 'verzonden'),
CONSTRAINT pk_Customer_order
	PRIMARY KEY (order_id)
);

IF OBJECT_ID('dbo.Processed_customer_order', 'U') IS NOT NULL
	DROP TABLE dbo.Processed_customer_order;
CREATE TABLE dbo.Processed_customer_order(
order_id			INT				NOT NULL,
retailer_site_code	INT				NOT NULL,
order_date			DATE		 	NULL,
fin_code			NVARCHAR(10)	NULL,
region				NVARCHAR(255)	NULL,
sales_rep			INT				NOT NULL,
order_method_code	INT				NULL,
warehouse_code		INT				NULL,
order_status		NVARCHAR(50)	NULL,
CONSTRAINT pk_Processed_customer_order
	PRIMARY KEY (order_id)
);

IF OBJECT_ID('dbo.Orderline', 'U') IS NOT NULL
	DROP TABLE dbo.Orderline;

CREATE TABLE dbo.Orderline(
orderline_code		INT				NOT NULL,
quantity			INT				NOT NULL,
unit_cost			DECIMAL(10,2)	NOT NULL,
unit_price			DECIMAL(10,2)	NOT NULL,
unit_sale_price		DECIMAL(10,2)	NOT NULL,
ship_date			DATE			NULL,
sales_item_id		INT				NULL,
order_id			INT				NOT NULL,
CONSTRAINT pk_Orderline
	PRIMARY KEY (orderline_code)
);

IF OBJECT_ID('dbo.Fin_code', 'U') IS NOT NULL
	DROP TABLE dbo.Fin_code;

CREATE TABLE dbo.Fin_code(
code				NVARCHAR(10)	NOT NULL,
type				NVARCHAR(50)	NULL,
description			NVARCHAR(255)	NULL,
CONSTRAINT pk_Fin_code
	PRIMARY KEY (code)
);

IF OBJECT_ID('dbo.Order_method', 'U') IS NOT NULL
	DROP TABLE dbo.Order_method;

CREATE TABLE dbo.Order_method(
order_method_code	INT				NOT NULL,
order_method_en		NVARCHAR(50)	NOT NULL,
CONSTRAINT pk_Order_method
	PRIMARY KEY (order_method_code)
);

IF OBJECT_ID('dbo.Sales_item', 'U') IS NOT NULL
	DROP TABLE dbo.Sales_item;

CREATE TABLE dbo.Sales_item(
sales_item_id		INT				NOT NULL,
sales_item_name		NVARCHAR(255)	NULL,
CONSTRAINT pk_Sales_item
	PRIMARY KEY (sales_item_id)
);

IF OBJECT_ID('dbo.Product', 'U') IS NOT NULL
	DROP TABLE dbo.Product;

CREATE TABLE dbo.Product(
product_id			INT				NOT NULL,
description			NVARCHAR(255)	NULL,
prod_size			NVARCHAR(25)	NULL,
color				NVARCHAR(30)	NULL,
picture_name		NVARCHAR(50)	NULL,
introduction_date	DATE			NOT NULL DEFAULT GETDATE(),
margin				DECIMAL(3,2)	NOT NULL,
production_cost		DECIMAL(15,5)	NOT NULL,
product_type_code	INT				NOT NULL,
CONSTRAINT pk_Product
	PRIMARY KEY (product_id)
);

IF OBJECT_ID('dbo.Product_forecast', 'U') IS NOT NULL
	DROP TABLE dbo.Product_forecast;

CREATE TABLE dbo.Product_forecast(
product_number		INT				NOT NULL,
year				INT				NOT NULL,
month				INT				NOT NULL,
expected_volume		INT				NOT NULL
CONSTRAINT pk_Product_forecast
	PRIMARY KEY (product_number, year, month)
);

IF OBJECT_ID('dbo.Product_line', 'U') IS NOT NULL
	DROP TABLE dbo.Product_line;

CREATE TABLE dbo.Product_line(
product_line_code	INT				NOT NULL,
product_line_en		NVARCHAR(40)	NOT NULL,
category			NVARCHAR(1)		NULL,
CONSTRAINT pk_Product_line
	PRIMARY KEY (product_line_code)
);

IF OBJECT_ID('dbo.Product_type', 'U') IS NOT NULL
	DROP TABLE dbo.Product_type;

CREATE TABLE dbo.Product_type(
product_type_code	INT				NOT NULL,
product_line_code	INT				NULL,
product_type_en		NVARCHAR(50)	NOT NULL,
inventory_minimum	INT				NULL,
CONSTRAINT pk_Product_type
	PRIMARY KEY (product_type_code)
);

IF OBJECT_ID('dbo.Promotion', 'U') IS NOT NULL
	DROP TABLE dbo.Promotion;

CREATE TABLE dbo.Promotion(
promotion_id		INT				NOT NULL,
promotion_name		NVARCHAR(50)	NOT NULL,
start_date			DATE			NOT NULL,
end_date			DATE			NOT NULL,
CONSTRAINT pk_Promotion
	PRIMARY KEY (promotion_id)
);

IF OBJECT_ID('dbo.Campaign', 'U') IS NOT NULL
	DROP TABLE dbo.Campaign;

CREATE TABLE dbo.Campaign(
product_id			INT				NOT NULL,
promotion_id		INT				NOT NULL,
discount			DECIMAL(3,2)	NOT NULL,
CONSTRAINT pk_Campaign
	PRIMARY KEY (product_id, promotion_id)
);

IF OBJECT_ID('dbo.Salestarget', 'U') IS NOT NULL
	DROP TABLE dbo.Salestarget;

CREATE TABLE dbo.Salestarget(
product_id			INT				NOT NULL,
employee_id			INT				NOT NULL,
sales_target		INT				NOT NULL,
sales_year			INT		     	NOT NULL,
sales_period		INT		     	NOT NULL,
target_achieved		NVARCHAR(1)		NULL CHECK(target_achieved = 'Y' OR target_achieved = 'N'),
CONSTRAINT pk_Salestarget
	PRIMARY KEY (product_id, employee_id, sales_year, sales_period)
);

IF OBJECT_ID('dbo.Trip', 'U') IS NOT NULL
	DROP TABLE dbo.Trip;

CREATE TABLE dbo.Trip(
trip_id				INT				NOT NULL,
min_participants	INT				NOT NULL,
max_participants	INT				NOT NULL,
promotion_id		INT				NULL,
children			BIT				NOT NULL,
trip_price			DECIMAL(10,2)	NOT NULL,
CONSTRAINT pk_Trip
	PRIMARY KEY (trip_id)
);

IF OBJECT_ID('dbo.Booking', 'U') IS NOT NULL
	DROP TABLE dbo.Booking;

CREATE TABLE dbo.Booking(
trip_id				INT				NOT NULL,
booker_id			INT				NOT NULL,
date				DATE			NOT NULL,
CONSTRAINT pk_Booking
	PRIMARY KEY(trip_id, booker_id, date)
);

IF OBJECT_ID('dbo.Cotraveller', 'U') IS NOT NULL
	DROP TABLE dbo.Cotraveller;

CREATE TABLE dbo.Cotraveller(
cotraveller_id		INT				NOT NULL,
sex					INT				NOT NULL,
name				INT				NOT NULL,
birthdate			INT				NOT NULL,
trip_id				INT				NOT NULL,
CONSTRAINT pk_Cotraveller
	PRIMARY KEY (cotraveller_id)
);

IF OBJECT_ID('dbo.Booker_detail', 'U') IS NOT NULL
	DROP TABLE dbo.Booker_detail;

CREATE TABLE dbo.Booker_detail(
booker_detail_id	INT				NOT NULL,
booker_name			Nvarchar		NOT NULL,
address				Nvarchar		NOT NULL,
IBAN			   	Nvarchar		NOT NULL,
birthdate			DATE			NOT NULL,
sex					Nvarchar		NOT NULL,
CONSTRAINT pk_Booker_detail
	PRIMARY KEY (booker_detail_id)
);

IF OBJECT_ID('dbo.Excursion', 'U') IS NOT NULL
	DROP TABLE dbo.Excursion;

CREATE TABLE dbo.Excursion(
excursion_id		INT				NOT NULL,
price				DECIMAL(15,5)	NOT NULL,
guide				BIT				NULL,
CONSTRAINT pk_Excursion
	PRIMARY KEY (excursion_id)
);

GO

IF OBJECT_ID('dbo.sp_addProduct', 'P') IS NOT NULL
	DROP PROC dbo.sp_addProduct;

GO

CREATE PROCEDURE dbo.sp_addProduct
	@id AS INT,
	@name AS NVARCHAR(255),
	@description AS NVARCHAR(255),
	@size AS NVARCHAR(255),
	@color AS NVARCHAR(255),
	@picture_name AS NVARCHAR(255),
	@introduction_date AS DATE,
	@margin AS DECIMAL(3,2),
	@production_cost AS DECIMAL(15,2),
	@product_type_code AS INT
AS
BEGIN
	SET NOCOUNT ON;
	INSERT INTO dbo.Sales_item VALUES (@id, @name);
	INSERT INTO dbo.Product VALUES (@id, @description, @size, @color, @picture_name, @introduction_date, @margin, @production_cost, @product_type_code);
END
GO

IF OBJECT_ID('dbo.sp_addTrip', 'P') IS NOT NULL
	DROP PROC dbo.sp_addTrip;

GO

CREATE PROCEDURE dbo.sp_addTrip
	@id AS INT,
	@name AS NVARCHAR(255),
	@min_participants AS INT,
	@max_participants AS INT,
	@promotion_id AS INT,
	@children AS BIT,
	@trip_price AS DECIMAL(10,2)
AS
BEGIN
	SET NOCOUNT ON;
	INSERT INTO dbo.Sales_item VALUES (@id, @name);
	INSERT INTO dbo.Trip VALUES (@id, @min_participants, @max_participants, @promotion_id, @children, @trip_price);
END
GO

USE [OutdoorParadise];

IF OBJECT_ID('dbo.f_getNumSubordinates', 'FN') IS NOT NULL
	DROP FUNCTION dbo.f_getNumSubordinates;

GO

CREATE FUNCTION dbo.f_getNumSubordinates(@manager_id INT)
RETURNS INT
AS BEGIN
	DECLARE @amount INT;
	SELECT @amount = COUNT(emp_id) FROM dbo.Employee
	WHERE manager_id = @manager_id;

	RETURN @amount;
END
GO

USE [OutdoorParadise];

IF OBJECT_ID('dbo.f_checkSalary', 'FN') IS NOT NULL
	DROP FUNCTION dbo.f_checkSalary;

GO

CREATE FUNCTION dbo.f_checkSalary(@job_number INT, @salary DECIMAL(15,2))
RETURNS INT
AS BEGIN
	DECLARE @min DECIMAL(15,2);
	DECLARE @max DECIMAL(15,2);
	IF (@salary IS NULL AND @job_number IS NULL)
		RETURN 1;

	SELECT @min = min_salary, @max = max_salary
	FROM dbo.Job
	WHERE job_number = @job_number;

	IF (@salary/12 >= @min AND @salary/12 <= @max)
		RETURN 1;
	RETURN 0;
END

GO

USE OutdoorParadise;

IF OBJECT_ID('dbo.f_checkManagerSalary', 'FN') IS NOT NULL
	DROP FUNCTION dbo.f_checkManagerSalary;

GO

CREATE FUNCTION dbo.f_checkManagerSalary(@salary DECIMAL(15,2), @manager_id INT)
RETURNS INT
AS BEGIN
	IF (@salary IS NULL OR @manager_id IS NULL)
		RETURN 1;
	
	DECLARE @manager_salary AS DECIMAL(15,2);
	SELECT @manager_salary = salary
	FROM Employee
	WHERE emp_id = @manager_id;

	IF (@salary <= @manager_salary)
		RETURN 1;
	RETURN 0;
END

GO

USE OutdoorParadise;

IF OBJECT_ID('dbo.checkRegion', 'FN') IS NOT NULL
	DROP FUNCTION dbo.checkRegion;
GO

CREATE FUNCTION dbo.checkRegion(@retailer_site_code INT, @sales_rep INT)
RETURNS INT
AS BEGIN
	DECLARE @region_rs NVARCHAR(50);
	DECLARE @region_branch NVARCHAR(50);

	SELECT @region_branch = B.sales_region
	FROM dbo.Branch B JOIN dbo.Employee E on E.branch_id = B.branch_id 
	WHERE emp_id = @sales_rep;	
	
	SELECT @region_rs = region 
	FROM dbo.Retailer_site
	WHERE retailer_site_code = @retailer_site_code;

	IF (@region_branch = @region_rs OR @region_branch IS NULL OR @region_rs IS NULL)
		RETURN 1;
	RETURN 0;
END
GO


CREATE TRIGGER trg_Orderline_Inventory ON dbo.Orderline AFTER INSERT
AS
	DECLARE @warehouse_id INT;
	DECLARE @product_id INT;
	DECLARE @current_inventory INT;
	DECLARE @quantity INT;
	SELECT @warehouse_id = warehouse_code FROM Customer_order c WHERE c.order_id = (SELECT order_id FROM inserted);
	SELECT @product_id = sales_item_id FROM inserted;
	SELECT @current_inventory = inventory_count FROM dbo.Inventory_level WHERE warehouse_id = @warehouse_id AND product_id = @product_id;
	SELECT @quantity = quantity FROM inserted;

	IF @warehouse_id IS NULL
		RETURN;

	IF (SELECT COUNT(product_id) FROM dbo.Product WHERE product_id = @product_id) = 0
		RETURN;

	IF (@quantity > @current_inventory) OR (@current_inventory IS NULL)
	BEGIN
		ROLLBACK TRAN;
		RETURN;
	END;

	UPDATE dbo.Inventory_level
	SET inventory_count = (@current_inventory - @quantity)
	WHERE warehouse_id = @warehouse_id AND product_id = @product_id;
GO

CREATE TRIGGER trg_Branch_manager ON dbo.Branch AFTER INSERT, UPDATE
AS
UPDATE dbo.Employee
SET job_id = (SELECT job_number FROM dbo.Job WHERE job_title LIKE '%Manager%')
WHERE emp_id = (SELECT branch_head_id FROM inserted);

GO

CREATE TRIGGER trg_Customer_order_status ON dbo.Customer_order AFTER UPDATE
AS
DECLARE @old_status NVARCHAR(50);
DECLARE @new_status NVARCHAR(50);
SELECT @old_status = order_status FROM deleted;
SELECT @new_status = order_status FROM inserted;

IF @old_status = @new_status
	RETURN;

IF @old_status IS NULL AND @new_status != 'ontvangen'
	ROLLBACK TRAN;

IF @new_status = 'wordt samengesteld' AND @old_status != 'ontvangen'
	ROLLBACK TRAN;

IF @new_status = 'verzonden' AND @old_status != 'wordt samengesteld'
	ROLLBACK TRAN;
GO

CREATE TRIGGER trg_order_status ON dbo.Customer_order AFTER INSERT, UPDATE
AS

INSERT INTO dbo.Processed_customer_order SELECT * FROM Customer_order WHERE order_status ='verwerkt' AND order_id NOT IN (SELECT order_id FROM Processed_customer_order) ;

GO

CREATE TRIGGER trg_Bonus_Target ON dbo.Salestarget AFTER INSERT, UPDATE
AS
	DECLARE @employee_id INT;
	DECLARE @target_achieved NVARCHAR(50);
	DECLARE @amount NVARCHAR(50);

	SELECT @employee_id = employee_id FROM inserted;
	SELECT @target_achieved = target_achieved FROM inserted;

	SELECT @amount = COUNT(target_achieved) FROM dbo.Salestarget 
			WHERE employee_id = @employee_id AND target_achieved = 'N';

	IF (@amount >= 6)
	BEGIN
		PRINT 'You failed more than six targets!';
		ROLLBACK TRAN;
		RETURN;
	END;
GO

ALTER TABLE dbo.Retailer
	ADD CONSTRAINT chk_Retailer_type
	CHECK ((type = 'b' AND discount IS NOT NULL AND max_quantity_order IS NULL) OR (type = 's' AND discount IS NULL AND max_quantity_order IS NOT NULL));

ALTER TABLE dbo.Employee
	ADD CONSTRAINT chk_Employee_start_date
	CHECK (start_date > birth_date);

ALTER TABLE dbo.Employee
	ADD CONSTRAINT chk_Employee_termination_date
	CHECK (termination_date > start_date);
	
ALTER TABLE dbo.Retailer
    ADD CONSTRAINT chk_Retailer_Discount
	CHECK (discount <= 8);

ALTER TABLE dbo.Promotion
    ADD CONSTRAINT chk_Promotion_ValidDate
	CHECK (end_date >= start_date);

ALTER TABLE dbo.Employee
    ADD CONSTRAINT chk_Min_Wage
	CHECK (Salary >= 2616);


GO

IF OBJECT_ID('dbo.sp_CHK_MAX_QTY_SCUST', 'P') IS NOT NULL
	DROP PROCEDURE dbo.sp_CHK_MAX_QTY_SCUST;

GO

CREATE PROCEDURE dbo.sp_CHK_MAX_QTY_SCUST
@retailer_id AS INT, 
@quantity AS INT OUTPUT

AS 
SELECT @quantity = max_quantity_order
FROM Retailer
WHERE retailer_id = @retailer_id;

GO

CREATE UNIQUE INDEX FindEmpName
ON Employee (emp_fname, emp_lname)

CREATE INDEX FindRetailerSiteAdress
ON Retailer_site (address1)

CREATE NONCLUSTERED INDEX FindProductSize
ON Product (prod_size)
WHERE prod_size IS NOT NULL; 

CREATE NONCLUSTERED INDEX FindNewOrders
ON Customer_order (order_status)
WHERE order_status ='ontvangen';