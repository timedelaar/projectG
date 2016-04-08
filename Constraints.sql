USE OutdoorParadise;

UPDATE dbo.Employee SET manager_id = NULL WHERE emp_id = 1868;

INSERT INTO dbo.Warehouse(warehouse_id) VALUES (1);

DELETE FROM dbo.Campaign WHERE product_id = 116;

ALTER TABLE dbo.Supplier
	ADD CONSTRAINT fk_Supplier_Country
	FOREIGN KEY(country_id)
	REFERENCES dbo.Country(country_code);

ALTER TABLE dbo.Retailer
	ADD CONSTRAINT fk_Retailer_Retailer_type
	FOREIGN KEY(retailer_type_code)
	REFERENCES dbo.Retailer_type(retailer_type_code);
	
ALTER TABLE dbo.Retailer_site
	ADD CONSTRAINT fk_Retailer_site_Retailer
	FOREIGN KEY(retailer_code)
	REFERENCES dbo.Retailer(retailer_id);
	
ALTER TABLE dbo.Retailer_site
	ADD CONSTRAINT fk_Retailer_site_Country
	FOREIGN KEY(country_code)
	REFERENCES dbo.Country(country_code);
	
ALTER TABLE dbo.Employee
	ADD CONSTRAINT fk_Employee_manager
	FOREIGN KEY(manager_id)
	REFERENCES dbo.Employee(emp_id);
	
ALTER TABLE dbo.Employee
	ADD CONSTRAINT fk_Employee_Branch
	FOREIGN KEY(branch_id)
	REFERENCES dbo.Branch(branch_id);
	
ALTER TABLE dbo.Employee
	ADD CONSTRAINT fk_Employee_Job
	FOREIGN KEY(job_id)
	REFERENCES dbo.Job(job_number);
	
ALTER TABLE dbo.Training
	ADD CONSTRAINT fk_Training_Employee
	FOREIGN KEY(employee_id)
	REFERENCES dbo.Employee(emp_id);
	
ALTER TABLE dbo.Training
	ADD CONSTRAINT fk_Training_Course
	FOREIGN KEY(course_id)
	REFERENCES dbo.Course(course_id);
	
ALTER TABLE dbo.Branch
	ADD CONSTRAINT fk_Branch_Employee
	FOREIGN KEY(branch_head_id)
	REFERENCES dbo.Employee(emp_id);

ALTER TABLE dbo.Branch
	ADD CONSTRAINT fk_Branch_Country
	FOREIGN KEY(country_code)
	REFERENCES dbo.Country(country_code);

ALTER TABLE dbo.Supplier_order
	ADD CONSTRAINT fk_Supplier_order_Supplier
	FOREIGN KEY(supplier_id)
	REFERENCES dbo.Supplier(supplier_id);
	
ALTER TABLE dbo.Supplier_order
	ADD CONSTRAINT fk_Supplier_order_Employee
	FOREIGN KEY(emp_id)
	REFERENCES dbo.Employee(emp_id);

ALTER TABLE dbo.Supplier_order
	ADD CONSTRAINT fk_Supplier_order_Warehouse
	FOREIGN KEY(warehouse_id)
	REFERENCES dbo.Warehouse(warehouse_id);
	
ALTER TABLE dbo.Supplier_orderline
	ADD CONSTRAINT fk_Supplier_orderline_Supplier_order
	FOREIGN KEY(order_id)
	REFERENCES dbo.Supplier_order(order_id);
	
ALTER TABLE dbo.Supplier_orderline
	ADD CONSTRAINT fk_Supplier_orderline_Product
	FOREIGN KEY(product_id)
	REFERENCES dbo.Product(product_id);
	
ALTER TABLE dbo.Returned_item
	ADD CONSTRAINT fk_Returned_item_Orderline
	FOREIGN KEY(orderline_code)
	REFERENCES dbo.Orderline(orderline_code);
	
ALTER TABLE dbo.Returned_item
	ADD CONSTRAINT fk_Returned_item_Return_reason
	FOREIGN KEY(return_reason)
	REFERENCES dbo.Return_reason(return_reason_code);
	
ALTER TABLE dbo.Inventory_level
	ADD CONSTRAINT fk_Inventory_level_Warehouse
	FOREIGN KEY(warehouse_id)
	REFERENCES dbo.Warehouse(warehouse_id);
	
ALTER TABLE dbo.Inventory_level
	ADD CONSTRAINT fk_Inventory_level_Product
	FOREIGN KEY(product_id)
	REFERENCES dbo.Product(product_id);
	
ALTER TABLE dbo.Inventory_history
	ADD CONSTRAINT fk_Inventory_history_Inventory_level
	FOREIGN KEY(warehouse_id, product_id)
	REFERENCES dbo.Inventory_level(warehouse_id, product_id);
	
ALTER TABLE dbo.Customer_order
	ADD CONSTRAINT fk_Customer_order_Retailer_site
	FOREIGN KEY(retailer_site_code)
	REFERENCES dbo.Retailer_site(retailer_site_code);
	
ALTER TABLE dbo.Customer_order
	ADD CONSTRAINT fk_Customer_order_Fin_code
	FOREIGN KEY(fin_code)
	REFERENCES dbo.Fin_code(code);

ALTER TABLE dbo.Customer_order
	ADD CONSTRAINT fk_Customer_order_Employee
	FOREIGN KEY(sales_rep)
	REFERENCES dbo.Employee(emp_id);

ALTER TABLE dbo.Customer_order
	ADD CONSTRAINT fk_Customer_order_Order_method
	FOREIGN KEY(order_method_code)
	REFERENCES dbo.Order_method(order_method_code);

ALTER TABLE dbo.Customer_order
	ADD CONSTRAINT fk_Customer_order_Warehouse
	FOREIGN KEY(warehouse_code)
	REFERENCES dbo.Warehouse(warehouse_id);
	
ALTER TABLE dbo.Orderline
	ADD CONSTRAINT fk_Orderline_Sales_item
	FOREIGN KEY(sales_item_id)
	REFERENCES dbo.Sales_item(sales_item_id);
	
ALTER TABLE dbo.Orderline
	ADD CONSTRAINT fk_Orderline_Customer_order
	FOREIGN KEY(order_id)
	REFERENCES dbo.Customer_order(order_id);

ALTER TABLE dbo.Product
	ADD CONSTRAINT fk_Product_Sales_item
	FOREIGN KEY(product_id)
	REFERENCES dbo.Sales_item(sales_item_id);
	
ALTER TABLE dbo.Product
	ADD CONSTRAINT fk_Product_Product_type
	FOREIGN KEY(product_type_code)
	REFERENCES dbo.Product_type(product_type_code);
	
ALTER TABLE dbo.Product_forecast
	ADD CONSTRAINT fk_Product_forecast_Product
	FOREIGN KEY(product_number)
	REFERENCES dbo.Product(product_id);
	
ALTER TABLE dbo.Product_type
	ADD CONSTRAINT fk_Product_type_Product_line
	FOREIGN KEY(product_line_code)
	REFERENCES dbo.Product_line(product_line_code);
	
ALTER TABLE dbo.Campaign
	ADD CONSTRAINT fk_Campaign_Product
	FOREIGN KEY(product_id)
	REFERENCES dbo.Product(product_id);
	
ALTER TABLE dbo.Campaign
	ADD CONSTRAINT fk_Campaign_Promotion
	FOREIGN KEY(promotion_id)
	REFERENCES dbo.Promotion(promotion_id);
	
ALTER TABLE dbo.Salestarget
	ADD CONSTRAINT fk_Salestarget_Product
	FOREIGN KEY(product_id)
	REFERENCES dbo.Product(product_id);
	
ALTER TABLE dbo.Salestarget
	ADD CONSTRAINT fk_Salestarget_Employee
	FOREIGN KEY(employee_id)
	REFERENCES dbo.Employee(emp_id);

ALTER TABLE dbo.Trip
	ADD CONSTRAINT fk_Trip_Sales_item
	FOREIGN KEY(trip_id)
	REFERENCES dbo.Sales_item(sales_item_id);
	
ALTER TABLE dbo.Trip
	ADD CONSTRAINT fk_Trip_Booker_Promotion
	FOREIGN KEY(promotion_id)
	REFERENCES dbo.Promotion(promotion_id);

ALTER TABLE dbo.Booking
	ADD CONSTRAINT fk_Booking_Trip
	FOREIGN KEY(trip_id)
	REFERENCES dbo.Trip(trip_id);

ALTER TABLE dbo.Booking
	ADD CONSTRAINT fk_Booking_Booker_detail
	FOREIGN KEY(booker_id)
	REFERENCES dbo.Booker_detail(booker_detail_id);
	
ALTER TABLE dbo.Cotraveller
	ADD CONSTRAINT fk_Cotraveller_Trip
	FOREIGN KEY(trip_id)
	REFERENCES dbo.Trip(trip_id);

ALTER TABLE dbo.Employee
	ADD CONSTRAINT chk_Employee_manager_salary
	CHECK (dbo.f_checkManagerSalary(salary, manager_id) = 1);

ALTER TABLE dbo.Customer_order
	ADD CONSTRAINT chk_Order_Region
	CHECK (dbo.checkRegion(retailer_site_code, sales_rep) = 1);

/*ALTER TABLE dbo.Employee
	ADD CONSTRAINT chk_Employee_Manager_overload
	CHECK (dbo.f_getNumSubordinates(manager_id) <= 12);*/
	
/*
ALTER TABLE dbo.Employee
	ADD CONSTRAINT chk_Employee_salary
	CHECK (dbo.f_checkSalary(job_id, salary) = 1);
*/