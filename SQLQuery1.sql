Select * 
From [Travel Analysis SWVL]..swvl


-- 1 A) the count of captains got paid more than the average payout

Select COUNT(COGs)
From [Travel Analysis SWVL]..swvl
where COGs > (select AVG(COGS)
From [Travel Analysis SWVL]..swvl)


-- 1 B) Week Begin - Captain - Weekly Captain's Fulfillment – Overall Weekly Fulfillment for all Captains

Select DATEPART(week, Date)AS Week, DATEADD(day, DATEDIFF(day, 0, Date) /7*7-1, 0) AS WeekBegin, Captain, 
        SUM(
			CONVERT(
                FLOAT,
                CASE WHEN RideStatus = 'completed' THEN 1 
                     ELSE 0 
                     END
			)
        )
        /COUNT(RideStatus) * 100  AS Fulfillment 
From [Travel Analysis SWVL]..swvl
Where Captain is not null
Group By  Date, Captain
Order By  WeekBegin, Fulfillment;


----------------------------------------------------
-- 2) Average KMs per Category

Select Category, AVG(Distance)
From [Travel Analysis SWVL]..swvl
Where Distance is not null
Group By Category


-- 4) How many cancelled rides do we have daily? 

Select Date, COUNT(RideStatus) as Cancelled
From [Travel Analysis SWVL]..swvl
Where RideStatus like 'cancelled'
Group By Date
Order By Cancelled DESC;


-- 4) at which hour do we have the highest cancellation? How would you work on improving the completion

Select Time, COUNT(RideStatus) as Cancelled
From [Travel Analysis SWVL]..swvl
Where RideStatus like 'cancelled'
Group By Time
Order By Cancelled DESC;

/* my thought on improving the compeltion of trips is by investigating the reason behind the cancelation of these trips and decrease the trips in this time slots
and try to reschedule the time slots to the lowest cancellation hours trips
*/

-- 5) For low utilized routes (Routes who have low number of bookings compared to number of seats), what are your thoughts on how to improve their utilization

Select Bookings/Capacity as UTL
From [Travel Analysis SWVL]..swvl
Where Bookings is not NULL
Order By UTL;



-- 6) Low Performing Captains

Select Captain, 
        SUM(
			CONVERT(
                FLOAT,
                CASE WHEN RideStatus = 'cancelled' THEN 1 
                     ELSE 0 
                     END
			)
        )
        /COUNT(RideStatus) * 100
	AS 'Percent Fail' 
From [Travel Analysis SWVL]..swvl
Where Captain is not null
Group By Captain
Order By 'Percent Fail' Desc;

