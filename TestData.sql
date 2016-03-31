use [Outdoor Paradise];

INSERT INTO dbo.Country values (1, 'Nederland', 'NL', 'Euro');

INSERT INTO dbo.Retailer_type values (1, 'Test shop');

INSERT INTO dbo.Retailer values (1, 'Big test', 'b', 20, NULL, 1);

INSERT INTO dbo.Retailer values (2, 'Small test', 's', NULL, 15, 1);

INSERT INTO dbo.Retailer_site(retailer_site_code, retailer_code, address1, country_code, active_indicator) values (1, 1, 'Teststr. 13', 1, 1);

INSERT INTO dbo.Retailer_site(retailer_site_code, retailer_code, address1, country_code, active_indicator) values (2, 2, 'Testlane 13', 1, 1);

INSERT INTO dbo.Employee(emp_id, emp_fname, emp_lname) values (1, 'Johnny', 'Test');

INSERT INTO dbo.Customer_order(order_id, retailer_site_code, sales_rep) values(1, 2, 1);

INSERT INTO dbo.Sales_item values (1, 'Test item');

INSERT INTO dbo.Product_type values (1, NULL, 'Test items', 50);

INSERT INTO dbo.Product(product_id, introduction_DATE, production_cost, margin, product_type_code) values (1, CURRENT_TIMESTAMP, 10.00, 0.3, 1);

INSERT INTO dbo.Orderline values (1, 10, 10, 13, 12.50, NULL, NULL, 1);


--insert into dbo.Orderline values (2, 10, 10, 13, 12.50, NULL, NULL, 1);

