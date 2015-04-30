using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// This file checks for weekday, weekend, public holiday etc.
/// The public holidays checked are only easter holidays for 2014 and 2015 
/// 
/// </summary>
public class DateController
{                     

	public DateController()
	{
	    
	}

    // check if public holiday
    public PublicHolidayType isPublicHoliday(DateTime date)
    {
        DateTime eFriday2014 = new DateTime(2014, 3,29); // 29 march to 2 april
        DateTime eSaturday2014 = new DateTime(2014,3,30);
        DateTime eSunday2014 = new DateTime(2014,3,31);
        DateTime eMonday2014 = new DateTime(2014,4,1);
        DateTime eTuesday2014 = new DateTime(2014,4,2);
        DateTime eFriday2015 = new DateTime(2014, 4, 18); // 18 april to 22 april
        DateTime eSaturday2015 = new DateTime(2014, 4, 19);
        DateTime eSunday2015 = new DateTime(2014, 4, 20);
        DateTime eMonday2015 = new DateTime(2014, 4, 21);
        DateTime eTuesday2015 = new DateTime(2014, 4, 22);

        // Business Logic: It is not considered as to what happens if certain days do or don't fall on the weekend
        // all five days will be always public holidays
        if (date == eFriday2014) { return PublicHolidayType.EasterFriday2014; }
        if (date == eSaturday2014) { return PublicHolidayType.EasterSaturday2014; }
        if (date == eSunday2014) { return PublicHolidayType.EasterSunday2014; }
        if (date == eMonday2014) { return PublicHolidayType.EasterMonday2014; }
        if (date == eTuesday2014) { return PublicHolidayType.EasterTuesday2014; }
        if (date == eFriday2015) { return PublicHolidayType.EasterFriday2015; }
        if (date == eSaturday2015) { return PublicHolidayType.EasterSaturday2015; }
        if (date == eSunday2015) { return PublicHolidayType.EasterSunday2015; }
        if (date == eMonday2015) { return PublicHolidayType.EasterMonday2015; }
        if (date == eTuesday2015) { return PublicHolidayType.EasterTuesday2015; }

        return PublicHolidayType.None;

    }

    // get type of date
    public DateType getDateType(DateTime date)
    {
        // Public Holiday takes preference over weekend
        if (isPublicHoliday(date) != PublicHolidayType.None)
            return DateType.Publicholiday;
        else if (date.DayOfWeek == DayOfWeek.Saturday || date.DayOfWeek == DayOfWeek.Sunday)
            return DateType.Weekend;
        else
            return DateType.Weekday;
    }
}