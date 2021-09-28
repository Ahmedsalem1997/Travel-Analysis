Select * 
From [Travel Analysis SWVL]..swvl


-- 1 A) the count of captains got paid more than the average payout

Select Count(COGs)
From [Travel Analysis SWVL]..swvl
where COGs > (select AVG(COGS)
From [Travel Analysis SWVL]..swvl)


-- 1 B) Week Begin - Captain - Weekly Captain's Fulfillment – Overall Weekly Fulfillment for all Captains???????????

Select Captain, Date, SUM(COGs)
From [Travel Analysis SWVL]..swvl
group by Captain


-- 2) Average KMs per Category

Select Category, AVG(Distance)
From [Travel Analysis SWVL]..swvl
Where Distance is not null
Group By Category


-- 4) How many cancelled rides do we have daily? 

Select Date, Count(RideStatus) as Cancelled
From [Travel Analysis SWVL]..swvl
Where RideStatus like 'cancelled'
Group By Date
order by Cancelled DESC;


-- 4) at which hour do we have the highest cancellation? How would you work on improving the completion %?

Select Time, Count(RideStatus) as Cancelled
From [Travel Analysis SWVL]..swvl
Where RideStatus like 'cancelled'
Group By Time
order by Cancelled DESC;


-- 5) For low utilized routes (Routes who have low number of bookings compared to number of seats), what are your thoughts on how to improve their utilization?

Select Bookings/Capacity as UTL
From [Travel Analysis SWVL]..swvl
Where Bookings is not NULL
Order By UTL;


-- 6) Low Performing Captains???????????????/

Select Captain, (Select COUNT(RideStatus) From [Travel Analysis SWVL]..swvl Where RideStatus like 'cancelled')/COUNT(RideStatus) as Percantage
From [Travel Analysis SWVL]..swvl
Where Captain is not null
Group By Captain
Order By Percantage;


