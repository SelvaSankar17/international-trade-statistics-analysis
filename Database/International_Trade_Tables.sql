create database international_trade_statistic;

use international_trade_statistic;



CREATE TABLE Trade_Regions (
    Region_ID INT PRIMARY KEY,
    Region_Name VARCHAR(50) UNIQUE
);
select * from Trade_Regions;


CREATE TABLE Currencies (
    Currency_ID INT PRIMARY KEY,
    Currency_Name VARCHAR(50),
    Currency_Code VARCHAR(3) UNIQUE
);
select * from Currencies;
 

CREATE TABLE Countries (
    Country_ID INT PRIMARY KEY,
    Country_Name VARCHAR(100) UNIQUE,
    ISO_Code VARCHAR(2) UNIQUE,
    Region_ID INT,
    Currency_ID INT,
    Capital VARCHAR(100),
    Population BIGINT,
    Status VARCHAR(10),
    FOREIGN KEY (Region_ID) REFERENCES Trade_Regions(Region_ID),
    FOREIGN KEY (Currency_ID) REFERENCES Currencies(Currency_ID)
);
select * from Countries;


CREATE TABLE Product_Categories (
    Category_ID INT PRIMARY KEY,
    Category_Name VARCHAR(50) UNIQUE
);
select * from Product_Categories;


CREATE TABLE Products (
    Product_ID INT PRIMARY KEY,
    Category_ID INT,
    Product_Name VARCHAR(150),
    HS_Code VARCHAR(10),
    Unit_Price DECIMAL(12,2),
    Weight DECIMAL(10,2),
    Status VARCHAR(10),
    FOREIGN KEY (Category_ID) REFERENCES Product_Categories(Category_ID)
);
select * from Products;


CREATE TABLE Ports (
    Port_ID INT PRIMARY KEY,
    Port_Name VARCHAR(150) UNIQUE,
    Country_ID INT,
    Port_Type VARCHAR(20),
    Capacity BIGINT,
    FOREIGN KEY (Country_ID) REFERENCES Countries(Country_ID)
);
select * from Ports;


CREATE TABLE Shipping_Companies (
    Shipping_Company_ID INT PRIMARY KEY,
    Company_Name VARCHAR(100) UNIQUE,
    Country_ID INT,
    Contact_Email VARCHAR(100),
    Phone VARCHAR(20),
    FOREIGN KEY (Country_ID) REFERENCES Countries(Country_ID)
);
select * from Shipping_Companies;


CREATE TABLE Export_Companies (
    Exporter_ID INT PRIMARY KEY,
    Company_Name VARCHAR(150) UNIQUE,
    Country_ID INT,
    License_No VARCHAR(20) UNIQUE,
    Email VARCHAR(100),
    Phone VARCHAR(20),
    FOREIGN KEY (Country_ID) REFERENCES Countries(Country_ID)
);
select * from Export_Companies;


CREATE TABLE Import_Companies (
    Importer_ID INT PRIMARY KEY,
    Company_Name VARCHAR(150) UNIQUE,
    Country_ID INT,
    License_No VARCHAR(20) UNIQUE,
    Email VARCHAR(100),
    Phone VARCHAR(20),
    FOREIGN KEY (Country_ID) REFERENCES Countries(Country_ID)
);
select * from Import_Companies;


CREATE TABLE Warehouses (
    Warehouse_ID INT PRIMARY KEY,
    Warehouse_Name VARCHAR(150) UNIQUE,
    Country_ID INT,
    Capacity BIGINT,
    FOREIGN KEY (Country_ID) REFERENCES Countries(Country_ID)
);
select * from Warehouses;


CREATE TABLE Customs_Officers (
    Officer_ID INT PRIMARY KEY,
    Officer_Name VARCHAR(100) UNIQUE,
    Country_ID INT,
    Designation VARCHAR(50),
    FOREIGN KEY (Country_ID) REFERENCES Countries(Country_ID)
);
select * from Customs_Officers;


CREATE TABLE Tariffs (
    Tariff_ID INT PRIMARY KEY,
    Product_ID INT,
    Country_ID INT,
    Tariff_Percentage DECIMAL(5,2),
    FOREIGN KEY (Product_ID) REFERENCES Products(Product_ID),
    FOREIGN KEY (Country_ID) REFERENCES Countries(Country_ID)
);
select * from Tariffs;


CREATE TABLE Shipments (
    Shipment_ID INT PRIMARY KEY,
    Exporter_ID INT,
    Importer_ID INT,
    Shipping_Company_ID INT,
    Origin_Port_ID INT,
    Destination_Port_ID INT,
    Shipment_Date DATE,
    Expected_Arrival DATE,
    Shipment_Status VARCHAR(20),
    Total_Value DECIMAL(14,2),
    FOREIGN KEY (Exporter_ID) REFERENCES Export_Companies(Exporter_ID),
    FOREIGN KEY (Importer_ID) REFERENCES Import_Companies(Importer_ID),
    FOREIGN KEY (Shipping_Company_ID) REFERENCES Shipping_Companies(Shipping_Company_ID),
    FOREIGN KEY (Origin_Port_ID) REFERENCES Ports(Port_ID),
    FOREIGN KEY (Destination_Port_ID) REFERENCES Ports(Port_ID)
);
select * from Shipments;


CREATE TABLE Shipment_Items (
    Shipment_Item_ID INT PRIMARY KEY,
    Shipment_ID INT,
    Product_ID INT,
    Quantity INT,
    Unit_Price DECIMAL(12,2),
    Total_Amount DECIMAL(14,2),
    FOREIGN KEY (Shipment_ID) REFERENCES Shipments(Shipment_ID),
    FOREIGN KEY (Product_ID) REFERENCES Products(Product_ID)
);
select * from Shipment_Items;


CREATE TABLE Customs_Clearance (
    Clearance_ID INT PRIMARY KEY,
    Shipment_ID INT,
    Officer_ID INT,
    Clearance_Date DATE,
    Status VARCHAR(20),
    Remarks VARCHAR(255),
    FOREIGN KEY (Shipment_ID) REFERENCES Shipments(Shipment_ID),
    FOREIGN KEY (Officer_ID) REFERENCES Customs_Officers(Officer_ID)
);
select * from Customs_Clearance;


CREATE TABLE Payments (
    Payment_ID INT PRIMARY KEY,
    Shipment_ID INT,
    Amount DECIMAL(14,2),
    Payment_Date DATE,
    Payment_Method VARCHAR(30),
    Payment_Status VARCHAR(20),
    FOREIGN KEY (Shipment_ID) REFERENCES Shipments(Shipment_ID)
);
select * from Payments;


CREATE TABLE Taxes (
    Tax_ID INT PRIMARY KEY,
    Shipment_ID INT,
    Tax_Type VARCHAR(30),
    Tax_Amount DECIMAL(14,2),
    FOREIGN KEY (Shipment_ID) REFERENCES Shipments(Shipment_ID)
);
select * from Taxes;


CREATE TABLE Trade_Agreements (
    Agreement_ID INT PRIMARY KEY,
    Country1_ID INT,
    Country2_ID INT,
    Agreement_Name VARCHAR(150) UNIQUE,
    Start_Date DATE,
    FOREIGN KEY (Country1_ID) REFERENCES Countries(Country_ID),
    FOREIGN KEY (Country2_ID) REFERENCES Countries(Country_ID)
);
select * from Trade_Agreements;


CREATE TABLE Delivery_Status (
    Delivery_ID INT PRIMARY KEY,
    Shipment_ID INT,
    Current_Status VARCHAR(20),
    Delivered_Date DATE NULL,
    FOREIGN KEY (Shipment_ID) REFERENCES Shipments(Shipment_ID)
);
select * from Delivery_Status;


CREATE TABLE Trade_Statistics (
    Statistic_ID INT PRIMARY KEY,
    Country_ID INT,
    Year INT,
    Total_Export DECIMAL(18,2),
    Total_Import DECIMAL(18,2),
    Trade_Balance DECIMAL(18,2),
    FOREIGN KEY (Country_ID) REFERENCES Countries(Country_ID)
);
select * from Trade_Statistics;

