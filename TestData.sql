use [Outdoor Paradise];

INSERT INTO dbo.Country(country_code, country, language, currency_name) values (1, 'Nederland', 'NL', 'Euro');

INSERT INTO dbo.Retailer_type(retailer_type_code, type_name_en) values (1, 'Test shop');

INSERT INTO dbo.Retailer values (1, 'Big test', 'b', 5, NULL, 1);

INSERT INTO dbo.Retailer values (2, 'Small test', 's', NULL, 15, 1);

INSERT INTO dbo.Retailer_site(retailer_site_code, retailer_code, address1, country_code, active_indicator) values (1, 1, 'Teststr. 13', 1, 1);

INSERT INTO dbo.Retailer_site(retailer_site_code, retailer_code, address1, country_code, active_indicator) values (2, 2, 'Testlane 13', 1, 1);

INSERT INTO dbo.Job(job_number, min_salary, max_salary) values (1, 0, 5000); 

INSERT INTO dbo.Employee(emp_id, emp_fname, emp_lname, salary, job_id) values (1, 'Johnny', 'Test', 4000, 1);

INSERT INTO dbo.Employee(emp_id, manager_id, emp_fname, emp_lname, salary, job_id) values (2, 1, 'Johnny jr.', 'Test', 4000, 1);

INSERT INTO dbo.Warehouse(warehouse_id) values (1);

INSERT INTO dbo.Product_type(product_type_code, product_line_code, product_type_en, inventory_minimum) values (1, NULL, 'Test items', 50);

INSERT INTO dbo.Sales_item(sales_item_id, sales_item_name) values (1, 'Test item');

INSERT INTO dbo.Product(product_id, introduction_date, production_cost, margin, product_type_code) values (1, CURRENT_TIMESTAMP, 10.00, 0.3, 1);

INSERT INTO dbo.Inventory_level(warehouse_id, product_id, inventory_count) values (1, 1, 50);

INSERT INTO dbo.Customer_order(order_id, retailer_site_code, sales_rep, warehouse_code, order_status) values(1, 2, 1, 1, NULL);

INSERT INTO dbo.Orderline values (1, 10, 10, 13, 12.50, NULL, 1, 1);


--insert into dbo.Orderline values (2, 10, 10, 13, 12.50, NULL, NULL, 1);

