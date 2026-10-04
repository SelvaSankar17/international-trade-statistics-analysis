use international_trade_statistic;

-- 1.Display all active countries along with their capital and population.
select country_name,capital,population from Countries 
where status="Active";


-- 2.List all currencies along with their currency code in alphabetical order.
select * from Currencies 
order by currency_code asc;


-- 3.Display all products whose unit price is greater than 1000.
select product_name,Unit_Price from products
where Unit_Price > 1000;


-- 4.Find all ports whose capacity is greater than 1,000,000.
select port_name,Capacity from ports
where Capacity > 1000000;


-- 5.Display all exporter companies from a specific country.
select e.company_name,c.country_name
from Export_Companies as e
join countries as c
on e.country_id=c.country_id
where c.country_name="India";


-- 6.Find all shipments whose status is **Delivered**.
select * from shipments
where shipment_status= "Delivered";


-- 7.Display all customs officers whose designation is **Senior Officer**.
select * from Customs_officers
where designation="Senior Officer";


-- 8.Find all warehouses with capacity greater than 500000.
select Warehouse_Name from warehouses
where capacity > 500000;


-- 9.Display all trade agreements signed after the year 2020.
select agreement_name from Trade_Agreements
where start_date like "2020%";


-- 10.Find all pending payments.
select Payment_ID,Payment_Status from payments
where Payment_Status = "Pending";


-- 11.Display all countries whose population is greater than the average population.
select * from Countries
where Population > (
select avg(Population) from Countries);


-- 12.Find products whose name starts with **A**.
select * from Products
where Product_Name like "A%";


-- 13.Find products whose HS Code ends with **01**.
select Product_Name from products
where HS_Code like "%01";


-- 14.Display shipments whose total value is between **50,000** - **200,000**.
select * from Shipments 
where Total_Value between 50000 and 200000;


-- 15.Find countries whose name contains the word **United**.
select Country_Name from Countries 
where Country_Name like "%United%";


-- 16.Display products that belong to a specific category.
select p.product_name,pc.Category_Name
from products as p
join Product_Categories as pc
on p.Category_ID=pc.Category_ID
where pc.Category_ID=1;


-- 17.Find shipments expected to arrive within the next **7 days**.
select * from shipments
where Expected_Arrival >= date_add(Shipment_Date,interval 7 day);


-- 18.Display tariffs greater than **15%**.
select * from Tariffs
where Tariff_Percentage > 15;


-- 19.Find all companies whose email belongs to the **gmail.com** domain.
select * from Shipping_Companies as a
join Import_Companies as b
on a.Country_ID=b.Country_ID
join Export_Companies as c
on a.Country_ID=c.Country_ID
where c.Email like "%gmail.com";


-- 20.Display the top **10 most expensive products**.
select * from products 
order by Unit_Price desc
limit 10;


-- 21.Display each country along with its trade region.
select c.country_name as Country,t.region_name as Region
from Countries as c
join Trade_Regions as t
on c.region_id=t.region_id;


-- 22.Display each country along with its currency name.
select country_name as Country,Currency_Name
from countries as c
join currencies as cs
on c.currency_id=cs.currency_id;


-- 23.Display every product with its category name.
select p.Product_ID,p.Category_ID,p.Product_name,pc.Category_name,p.unit_price
from products as p
join Product_Categories as pc
on pc.category_id=p.category_id
order by p.product_id asc;


-- 24.Display every port with its country name.
select port_id,port_name,country_name as Country
from ports as p
join countries as c
on c.country_id=p.country_id
order by port_id asc;


-- 25.Display exporter company name along with its country name.
select Exporter_ID,company_name as Company,country_name as Country
from countries as c
join Export_Companies as e
on c.country_id=e.country_id;


-- 26.Display importer company name along with its country name.
select Importer_ID,company_name as Company,country_name as Country
from countries as c
join Import_Companies as i
on c.country_id=i.country_id;


-- 27.Display shipment details along with exporter company name and importer company name.
select s.Shipment_ID,
       s.Shipment_Date,
       s.Expected_Arrival,
       s.Shipment_Status,
       s.Total_Value,e.company_name as "Exporter Company",
       i.company_name as "Importer Company"
from shipments as s
join export_companies as e
on s.exporter_id=e.exporter_id
join import_companies as i
on s.importer_id=i.importer_id;


-- 28.Display shipment details with origin port name and destination port name.
select shipment_id,shipment_date,Expected_arrival,total_value,
p1.port_name as "Orgin Port",
p2.port_name as "Destination Port"
from shipments as s
join ports as p1
on s.origin_port_id=p1.port_id
join ports as p2
on s.destination_port_id=p2.port_id;


-- 29.Display customs clearance details along with customs officer name.
select Clearance_ID,Shipment_ID,Officer_Name,Clearance_date,Status
from customs_clearance as c
join customs_officers as o
on c.officer_id=o.officer_id;


-- 30.Display shipment payment details along with payment status.
select s.shipment_ID,p.Payment_ID,p.Amount,p.Payment_Date,p.Payment_Method,p.Payment_Status
from Payments as p
join Shipments as s
on s.Shipment_ID=p.Shipment_ID;


-- 31.Find the total number of countries in each trade region.
select t.Region_ID,t.Region_Name,count(c.country_id) as "Number of Countries"
from trade_regions as t
join countries as c
on c.region_ID=t.region_id
group by(t.Region_ID);


-- 32.Find the total number of products in each product category.
select category_name as Category,count(p.product_id) "Number of Products"
from products as p
join product_categories as pc
on p.category_id=pc.category_id
group by category_name;


-- 33.Find the average unit price of products in each category.
select category_name as "Category",avg(unit_price)
from products as p
join product_categories as pc
on p.category_id=pc.category_id
group by category_name;


-- 34.Display the highest-priced product in every category.
select category_name,product_name,unit_price
from products as p
join product_categories as pc
on p.category_id=pc.category_id
where p.unit_price=(
select max(p2.unit_price) from products as p2
where p.category_id=p2.category_id);


-- 35.Calculate the total shipment value handled by each shipping company.
select company_name,sum(total_value) as "Total Value"
from shipments as s
join shipping_companies as sc
on s.shipping_company_id=sc.shipping_company_id
group by s.shipping_company_id;


-- 36.Calculate the total export shipment value handled by each exporter company.
select e.company_name,coalesce(sum(s.total_value),0)
from export_companies as e
left join shipments as s
on s.exporter_id=e.exporter_id
group by e.exporter_id,e.company_name;


-- 37.Calculate the total import shipment value handled by each importer company.
select company_name as Company,(select sum(total_value)
from shipments as s where i.importer_id=s.importer_id) as "Total Value" 
from import_companies as i;


-- 38.Calculate the total tax collected for each shipment.
select Shipment_ID,(select sum(Tax_amount) 
from Taxes as t where s.shipment_id=t.shipment_id ) as "Total Tax"
from shipments as s;

select Shipment_ID,sum(tax_amount) as "Total Tax"
from taxes group by shipment_id;


-- 39.Calculate the total payment received for each shipment.
select Shipment_ID,sum(amount) as "Total Payment"
from payments group by shipment_id;


-- 40.Display the yearly export, import, and trade balance of each country.
select country_name as "Country",Year,Total_Export,Total_Import,Trade_Balance
from trade_statistics as t
join countries as c
on c.country_id=t.country_id;


-- 41.Find the **Top 10 countries** based on total export value.
select c.country_name as Country,sum(t.total_export) as "Total Export Value" 
from countries as c
join trade_statistics as t
on t.country_id=c.country_id
group by c.country_name,c.country_id
order by sum(t.total_export) desc 
limit 10;


-- 42.Find the **Top 10 countries** based on total import value.
select c.country_name as Country,sum(t.total_import) as "Total Import Value"
from countries as c
join trade_statistics as t
on c.country_id=t.country_id
group by c.country_id,c.country_name
order by sum(total_import) desc
limit 10;


-- 43.Identify the **Top 10 products** based on total quantity exported.
select p.product_name as Products,sum(s.quantity) as "Total Quantity"
from products as p
join shipment_items as s
on p.product_id=s.product_id
group by p.product_name,p.product_id
order by sum(s.quantity) desc
limit 10;


-- 44.Display the **Top 5 exporter companies** based on total shipment value.
select company_name as Company,sum(total_value) as "Total Shipment Value"
from shipments as s
join export_companies as e
on s.exporter_id=e.exporter_id
group by e.company_name,s.exporter_id
order by "Total Shipment Value" desc
limit 5;


-- 45.Display the **Top 5 importer companies** based on total shipment value.
select i.company_name as Company,sum(s.total_value) as "Total Shipment value"
from shipments as s
join import_companies as i
on s.importer_id=i.importer_id
group by i.importer_id,i.company_name
order by "Total Shipment Value" desc;


-- 46.Find shipments whose **payment is pending** but **customs clearance is approved**.
select s.shipment_id,s.Exporter_ID,s.Importer_ID,s.Shipping_Company_ID,s.Origin_Port_ID,s.Destination_Port_ID
from shipments as s
join payments as p
on s.shipment_id=p.shipment_id
join Customs_Clearance as c
on c.shipment_id=s.shipment_id
where p.Payment_Status="Pending" and c.status="Approved";


-- 47.Find shipments that have **cleared customs** but are **not yet delivered**.
select s.shipment_id,s.Exporter_ID,s.Importer_ID,s.Shipping_Company_ID,s.Origin_Port_ID,s.Destination_Port_ID
from shipments as s
join customs_clearance as c
on s.shipment_id=c.shipment_id
join delivery_status as d
on s.shipment_id=d.shipment_id
where c.status = "Approved" and d.current_status!="Delivered";


-- 48.Identify the **most frequently used origin port** based on shipment count.
select Origin_Port_ID,count(*) as "Number Of times Visiter"
from shipments 
group by Origin_Port_Id
order by count(*) desc limit 1;


-- 49.Find countries where **Total Import > Total Export** using the `Trade_Statistics` table.
select Country_Name as "Countries"
from countries as c
join Trade_Statistics as t
on c.country_id=t.country_id
where t.total_import > t.total_export;


-- 50. Find the top 5 products generating the highest total shipment value.
select product_name as "Products",sum(s.total_amount) as Total_Value
from products as p
join Shipment_Items as s
on s.product_id=p.product_id
group by s.product_id
order by sum(s.total_amount) desc limit 5;


-- 51. Find shipping companies that handled more than 1,000 shipments.
select company_name as "Company Name",count(shipment_id) as "Shipment Counts"
from shipments as s 
join Shipping_Companies as sc 
on s.Shipping_Company_ID=sc.Shipping_Company_ID
group by s.shipping_company_id,sc.company_name
having count(shipment_id) > 1000;


-- 52. Calculate the average shipment value for each exporter company.
select s.exporter_id,e.company_name,avg(total_value) "Average Shipment Value"
from shipments as s
join export_companies as e
on s.exporter_id=e.exporter_id
group by s.exporter_id,e.company_name;


-- 53. Find countries having both exporters and importers registered.
select distinct c.country_id,c.country_name as "Countries"
from countries as c
join export_companies as e
on c.country_id=e.country_id
join import_companies as i
on c.country_id=i.country_id;


-- 54. Find the most frequently shipped product category.
select category_name as "Product Category",count(s.shipment_id)
from product_categories as pc
join products as p
on p.category_id=pc.category_id
join shipment_items as s
on p.Product_ID=s.Product_ID
group by pc.Category_ID
order by count(s.shipment_id) desc limit 1;


-- 55. Find the top 5 origin ports based on total shipment value.
select s.origin_port_id,p.port_name,sum(total_value) as "Total Shipment Value"
from shipments as s
join ports as p
on p.port_id=s.origin_port_id
group by origin_port_id,port_name
order by sum(total_value) desc limit 5;


-- 56. Calculate the average delivery time for delivered shipments.
select avg(datediff(d.delivered_date,s.shipment_date)) as "Average Delivery Time"
from shipments as s
join delivery_status as d
on s.shipment_id=d.shipment_id
where current_status="Delivered";


-- 57. Find shipments where the actual delivery date was later than the expected arrival date.
select * from shipments as s
join delivery_status as d
on s.shipment_id=d.shipment_id
where d.delivered_date > s.expected_arrival;


-- 58. Find exporters whose total shipment value is greater than the average exporter shipment value.
with Total_Shipment as
(select exporter_id,sum(total_value) as sum_total
from shipments
group by exporter_id),

Average_Value as
(select avg(sum_total) as avg_value
from Total_shipment)

select e.exporter_id,e.company_name,e.license_no,e.email,e.phone,ts.sum_total
from Total_Shipment as ts
join Average_Value as av
on 1 = 1
join Export_Companies as e
on e.exporter_id=ts.exporter_id
where ts.sum_total > av.avg_value;


-- 59. Find countries whose trade balance was negative for more than one year.
select c.country_id,c.country_name,count(case when t.trade_balance < 0 then t.year end) as year_count
from trade_statistics as t
join countries as c
on c.country_id=t.country_id
group by c.country_id,c.country_name
having year_count > 1;


-- 60.Rank products based on their unit price.
select *,
rank() over(order by unit_price desc) as "Products Rank"
from products;


-- 61. Find the top 3 most expensive products in each product category.
with products_order as
(select p.product_id,p.product_name,pc.category_name,
rank() over(partition by pc.category_id order by p.unit_price desc) as Product_Order
from products as p 
join product_categories as pc
on p.category_id=pc.category_id)

select Product_ID,Product_Name,Category_Name,Product_Order
from products_order
where product_order < 4;


-- 62. Rank exporter companies based on their total shipment value.
with total_shipment as
(select exporter_id,sum(total_value) as Total_shipment_value
from shipments
group by exporter_id)

select ts.Exporter_ID,ec.Company_Name,ts.Total_Shipment_Value,
rank() over(order by Total_shipment_value desc) as Companies_rank
from total_shipment as ts
join export_companies as ec
on ts.exporter_id=ec.exporter_id;


-- 63. Find the top 3 exporters within each country.
with total_exporters as
(select c.country_name,ec.country_id,ec.exporter_id,ec.company_name,sum(s.total_value) as Sum_Total
from shipments as s
join export_companies as ec
on s.exporter_id=ec.exporter_id
join countries as c
on ec.country_id=c.country_id
group by country_id,country_name,exporter_id,company_name),

exporters_rank as
(select country_id,country_name,exporter_id,company_name,
rank() over(partition by country_name order by sum_total desc) as export_rank
from total_exporters)

select country_id,country_name,exporter_id,company_name,export_rank
from exporters_rank
where export_rank < 4;


-- 64. Calculate the running total of shipment value by shipment date.
select *,
sum(total_value) over(order by shipment_date,shipment_id
rows between unbounded preceding and current row) as "Running Total"
from shipments;


-- 65. Calculate the running total of export value for each country year by year.
select t.Country_id,c.Country_Name,t.Year,t.Total_Export,
sum(total_export) over(partition by t.country_id order by t.year) as "Running Total"
from Trade_Statistics as t
join countries as c
on c.country_id=t.country_id;
