using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// This file creates a rate controller
/// 
/// </summary> 
public class RateController
{
	public RateController()
	{

	}

    // get the total cost
    public decimal getTotalCost(String departState, String arrivalState, DateTime departDate, DateTime arrivalDate, int departTime, int arrivalTime)
    {
        RateController rc=new RateController();
        decimal perHourRate;
        decimal departRate, arrivalRate;
        decimal totalCost = 0;
        DateTime temp;

        // starting from the hour of departure, add one hour and move towards the time of arrival
        for (temp = departDate.AddHours(departTime); temp < arrivalDate.AddHours(arrivalTime); temp = temp.AddHours(1))
        {
            // apply the lower rate between two states
            departRate = rc.getRate(departState, temp.Date, temp.Hour);
            arrivalRate = rc.getRate(arrivalState, temp.Date, temp.Hour);

            // now check the lower
            if (departRate < arrivalRate)
                perHourRate = departRate;
            else
                perHourRate = arrivalRate;

            totalCost += perHourRate;
        }

        return totalCost;
    }

    // get the rate for given state, date and time
    public decimal getRate(String state, DateTime date, int t)
    {
        DateController dc=new DateController();
        state=state.ToUpper();
        switch(state)
        {
            case "ACT":
                switch (dc.getDateType(date))
                {
                    case DateType.Publicholiday:
                        if (t <= 16 && t >= 5) return 400;
                        else return 480;
                    case DateType.Weekend:
                        if (t <= 16 && t >= 5) return 325;
                        else return 360;
                    case DateType.Weekday:
                        if (t <= 16 && t >= 5) return 325;
                        else return 360;
                }
                break;
            case "NSW":
                switch (dc.getDateType(date))
                {
                    case DateType.Publicholiday:
                        if (t <= 16 && t >= 5) return 390;
                        else return 465;
                    case DateType.Weekend:
                        if (t <= 16 && t >= 5) return 315;
                        else return 350;
                    case DateType.Weekday:
                        if (t <= 16 && t >= 5) return 195;
                        else return 245;
                }
                break;
            case "VIC":
                switch (dc.getDateType(date))
                {
                    case DateType.Publicholiday:
                        if (t <= 17 && t >=6) return 410;
                        else return 410;
                    case DateType.Weekend:
                        if (t <= 17 && t >= 6) return 330;
                        else return 348;
                    case DateType.Weekday:
                        if (t <= 17 && t >= 6) return 194;
                        else return 244;
                }
                break;
            case "SA":
                switch (dc.getDateType(date))
                {
                    case DateType.Publicholiday:
                        if (t <= 17 && t >= 6) return 420;
                        else return 500;
                    case DateType.Weekend:
                        if (t <= 17 && t >= 6) return 390;
                        else return 410;
                    case DateType.Weekday:
                        if (t <= 17 && t >= 6) return 195;
                        else return 270;
                }
                break;
            case "QLD":
                switch (dc.getDateType(date))
                {
                    case DateType.Publicholiday:
                        if (t <= 17 && t >= 6) return 385;
                        else return 405;
                    case DateType.Weekend:
                        if (t <= 17 && t >= 6) return 195;
                        else return 280;
                    case DateType.Weekday:
                        if (t <= 17 && t >= 6) return 175;
                        else return 225;
                }
                break;
            case "NT":
                switch (dc.getDateType(date))
                {
                    case DateType.Publicholiday:
                        if (t <= 18 && t >= 7) return 235;
                        else return 270;
                    case DateType.Weekend:
                        if (t <= 18 && t >= 7) return 225;
                        else return 260;
                    case DateType.Weekday:
                        if (t <= 18 && t >= 7) return 150;
                        else return 180;
                }
                break;
            case "TAS":
                switch (dc.getDateType(date))
                {
                    case DateType.Publicholiday:
                        if (t <= 18 && t >= 7) return 225;
                        else return 269;
                    case DateType.Weekend:
                        if (t <= 18 && t >= 7) return 225;
                        else return 269;
                    case DateType.Weekday:
                        if (t <= 18 && t >= 7) return 178;
                        else return 215;
                }
                break;
            default: return 0;
        }
        return 0;
    }
}