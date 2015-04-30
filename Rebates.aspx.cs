using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Rebates : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    } 
    
    protected void btnGetRebates_Click(object sender, EventArgs e)
    {
        RebateDisplay.FilterExpression = "MembershipId=" + MemberNo.Text;
    }
    protected void RebateDisplay_Selecting(object sender, SqlDataSourceSelectingEventArgs e)
    {

    }
}