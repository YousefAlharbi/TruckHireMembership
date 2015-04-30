using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// This is the geography (distance) calculator
///  
/// </summary>
public class GeographyController
{
	public GeographyController()
	{
		
	}

    // this is the stub method for a web service call to be implemented later
    public decimal getDistance(String depart_postcode, String arrival_postcode)
    {
        return Int32.Parse(depart_postcode[0]+"") * 150 + Int32.Parse(arrival_postcode[0]+"") * 200;
    }
}