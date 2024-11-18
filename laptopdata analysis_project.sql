create database analysis_project;
use analysis_project;

select * from laptopdata;

#data cleaning
set sql_safe_updates=0;
update laptopdata set Ram=substring_index(Ram,"G",1);#removed the GB from it
update laptopdata set Weight=substring_index(Weight,"k",1);#kg removed
alter table laptopdata modify Price int;# removed the float
delete from laptopdata where Weight="?";
delete from laptopdata where Weight=0.0002;
alter table laptopdata modify Weight int;


#what all types of laptops are available in the market
Select TypeName,count(*) as Count,avg(Price) as Avg_Price
From laptopdata
group by TypeName
order by Count desc;
#by looking this  the business people can target the different segments in the market

desc laptopdata;


#1.firstly we need to check which is the top selling company 
#in the list so that we can understand which is the one many are opting
Select Company,count(*) as Sales_Count
from laptopdata
group by Company
order by Sales_Count desc
limit 10;

#2.then we need to understand the avg price according to each company
#so that we can compare the  average prices aof the companies.
#by this we could understand how the company have priced their 
#products so that we can easily categorise then to budget,mid range and luxe range.
select Company,avg(Price) as Average_Price
from laptopdata
group by Company
order by Average_Price desc;


#3.then we can analyse which is the screen resolution that is mostly prefered by the people 
#by taking the coun t of that we can will get to know which is prefered
#so by looing that the company can provide or make that screen more reliable
#or can add more features for that specififc resolution

SELECT ScreenResolution,count(*) as Top_sales, 
AVG(Price) AS Average_Price from laptopdata group by ScreenResolution order by Top_sales desc;
#4.Avg price based on the screen resolution 
#so by looking that we can understand how the price is distributed according to the resolution
#which is the costly one or mid range or budget level
SELECT ScreenResolution, AVG(Price) AS Average_Price
FROM laptopdata
GROUP BY ScreenResolution
ORDER BY Average_Price DESC;
#by looking this we can understand that the 4k is the premium category and then ips lcd then 
#touch screen also in the budget level it does have ips lcd more but with lower resoultion

#5.next the impoprtant factor that when a user consider while buying the lap is Ram
#so while checking the avg price of ram we can understand how ram size will be
#impacting the price of the laptop
select Ram, avg(Price) as Average_Price
from laptopdata
group by Ram
order by Average_Price desc;
#thus its shows that when the ram is more then the price is also  
#more then by looking at price we can categorise then in to separate categories


#8.on a laptop cpu is an important factor and it helps to categorise the lap
#as then higher the performance there will be higher the price so it justify
#the higher price and set the category
select Cpu, max(Price) as Max_Price
from laptopdata
group by Cpu
order by Max_Price desc limit 40 ;


#9.most common storage capacity by looking that the company could meet the demand of the 
#customers effectievly
select Memory, count(*) as Sales_Count
from laptopdata
group by Memory
order by Sales_Count desc;
#in this 256gb is mostly prefered by the people followed by 1tb and 500gb
#as these storage is customizable by the user the company can store more 
#in inventory for future demand

#10analyzing according to the price of gpu with price
#like cpu gpu is also a importnt factor for performnce, so increase in gpu 
#may result in increasing the price and it will be mostly used in gaming or 
select Gpu, max(Price) as max_Price
from laptopdata
group by Gpu
order by max_Price desc limit 50;
select * from laptopdata where gpu ="Nvidia Quadro M2200M";


#11.most used operating system
SELECT OpSys, COUNT(*) AS Sales_Count
FROM laptopdata
GROUP BY OpSys
ORDER BY Sales_Count DESC;
# Guides OS oriented marketing  startergies and helps to
#customize the  product offerings according to OS preference.


#12.operating systems avh price
SELECT OpSys, AVG(Price) AS Average_Price
FROM laptopdata
GROUP BY OpSys
ORDER BY Average_Price DESC;
#this shows that the most highly priced os system is macos 


#13.which is most screen sizes that people have purchased mostly
select Inches, count(*) as Sales_Count
from laptopdata
group by Inches
order by Sales_Count desc;
select  Typename from laptopdata where Inches=15.6;
#thus it give that 15.6 inch is mostly sold so it may conclude that notebooks 
#laps size is mostly prefered by people and 15.6 is the size that used by laptops for general purpose 
#so it concludes that most buying people is for generic use only
select Typename,count(*) as total_sales
from laptopdata
group by Typename
order by total_sales desc limit 5; #it shows that the most people bought laps are of type "notebook"


#top 3 companies that provide lightest laptop in the market
select Company, min(Weight) as Lightest_Laptop
from laptopdata
group by Company
order by Lightest_Laptop asc
limit 3;


#Find the top configurations for each company based on 
#price and key features, such as RAM, screen resolution, and CPU type.
select Company, TypeName, Inches, ScreenResolution, Cpu, Ram, Memory, Gpu, OpSys, Weight, Price
fromlaptopdata where(Company, Price)in(select Company,max(Price)
from laptopdata
group by Company)
order by Price desc limit 17;

alter table laptopdata drop column `Unnamed: 0`;
desc laptopdata;
select distinct(Company) from laptopdata order by  company desc;
select * from laptopdata where Company like "L%";

select Company, TypeName, Inches, ScreenResolution, Cpu, Ram, Memory, Gpu, OpSys, Weight, Price
from laptopdata where (Company, Price)in(select Company,max(Price)
from laptopdata
group by Company)
order by Price desc limit 20;











 





