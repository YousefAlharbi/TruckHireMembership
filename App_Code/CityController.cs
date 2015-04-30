using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.IO;

/// <summary>
/// This file reads all the postcodes from the file 
/// 
/// </summary>
public class CityController
{
    List<Area> lstAreas;

	public CityController()
	{
        lstAreas = new List<Area>();	
	}

    /* Read the PostCode file */
    public void readPostCodes(String fileName)
    {
        Area area;

        FileInfo fileIn = new FileInfo(fileName);

        StreamReader reader = fileIn.OpenText();    
        string[] lineIn;

        while (!reader.EndOfStream)
        {
            area = new Area();

            lineIn = reader.ReadLine().Split(',');

            area.PCode=lineIn[0].Replace("\"","").Replace("\'","");
            area.Locality=lineIn[1].Replace("\"","").Replace("\'","");
            area.State = lineIn[2].Replace("\"", "").Replace("\'", "");

            lstAreas.Add(area);
        }

        reader.Close();
    }

    /* Get an area given the postcode */
    public Area getArea(String postcode)
    {
        foreach(Area area in lstAreas)
        {
            if (area.PCode.ToUpper() == postcode.ToUpper())
                return area;
        }
        return null;
    }
}