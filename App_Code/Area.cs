using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// 
/// 
/// </summary>
public class Area
{
    private String pcode;
    private String locality;
    private String state;

	public Area()
	{
        pcode = "";
        locality = "";
        state = "";
	}

    public Area(String pcode, String locality, String state)
    {
        this.pcode = pcode;
        this.locality = locality;
        this.state = state;
    }

    public String PCode
    {
        get { return pcode; }
        set { pcode = value; }
    }

    public String Locality
    {
        get { return locality; }
        set { locality = value; }
    }

    public String State
    {
        get { return state; }
        set { state = value; }
    }

}