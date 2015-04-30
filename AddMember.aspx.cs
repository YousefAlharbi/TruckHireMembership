using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;

public partial class AddMember : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    /* Add the member into membership database */ 
    protected void btnCreateInvoice_Click(object sender, EventArgs e)
    {
        SqlConnection connection = new SqlConnection();
        SqlCommand command;

        connection.ConnectionString = @"Data Source=.\SQLEXPRESS;AttachDbFilename=|DataDirectory|\M_DB.mdf;Integrated Security=True;User Instance=True";
        connection.Open();

        String sql = "insert into membership(first_name,last_name,membership_class) OUTPUT INSERTED.membershipid values ('" + txtCustomerFirstName.Text + "','" + txtCustomerLastName.Text + "','regular')";

        command = new SqlCommand(sql, connection);
        int membershpiid = (Int32)command.ExecuteScalar();

        lblInvoiceNumber.Text = membershpiid.ToString();
    }
}