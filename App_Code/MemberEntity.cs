using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for MemberEntity 
/// </summary>
public class MemberEntity
{
    private int membershipid;
    private String empNo;
    private String fName;
    private String lName;
    private String mClass;
    private String vCode;

	public MemberEntity()
	{

	}

    public MemberEntity(int membershipid, String empNo, String fName, String lName, String mClass, String vCode)
    {
        this.membershipid = membershipid;
        this.empNo = empNo;
        this.fName = fName;
        this.lName = lName;
        this.vCode = vCode;
        this.mClass = mClass;
    }

    public int Membershipid
    {
        get { return membershipid; }
        set { membershipid = value; }
    }

    public String EmpNo
    {
        get { return empNo; }
        set { empNo = value; }
    }

    public String FName
    {
        get { return fName; }
        set { fName = value; }
    }

    public String LName
    {
        get { return lName; }
        set { lName = value; }
    }

    public String MClass
    {
        get { return mClass; }
        set { mClass = value; }
    }

    public String VCode
    {
        get { return vCode; }
        set { vCode = value; }
    }
       
}