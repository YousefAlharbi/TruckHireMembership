using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data.SqlClient;

/// <summary>
/// Summary description for DatabaseController 
/// </summary>
public class DatabaseController
{
	public DatabaseController()
	{
        
	}

    public static MemberEntity getMember(int MembershipId)
    {
        MemberEntity newEntity=null;

        try
        {
            SqlConnection connection = new SqlConnection();
            SqlCommand command;
            SqlDataReader reader;
            connection.ConnectionString = @"Data Source=.\SQLEXPRESS;AttachDbFilename=|DataDirectory|\M_DB.mdf;Integrated Security=True;User Instance=True";
            connection.Open();

            String member_sql="select * from membership where membershipid=" + MembershipId;
            command = new SqlCommand(member_sql, connection);
            reader = command.ExecuteReader();

            while(reader.Read())
            {
                newEntity = new MemberEntity(reader.GetInt32(0), "", reader.GetString(2).Trim(), reader.GetString(3).Trim(), reader.GetString(4).Trim(), "");
            }

            reader.Close();

            return newEntity;
        }
        catch(Exception)
        {
            return newEntity;
        }        
    }

    // check how many bookings have been made by member
    // the discount and rebate is calculated based on past bookings
    // the rules ar

    // Regular members will receive $200 credit for each booking.
    // Silver members will receive 15% discount for every $5,000 spent (excluding GST).
    // Gold members will receive $300 credit for every booking and 20% discount for every $5,000 spent (excluding GST).

    public static int getBookingCount(int MembershipId)
    {
        int bcount = 0;

        try
        {
            SqlConnection connection = new SqlConnection();
            SqlCommand command;
            SqlDataReader reader;
            connection.ConnectionString = @"Data Source=.\SQLEXPRESS;AttachDbFilename=|DataDirectory|\M_DB.mdf;Integrated Security=True;User Instance=True";
            connection.Open();

            String member_sql = "select * from transactionlog where membershipid=" + MembershipId;
            command = new SqlCommand(member_sql, connection);
            reader = command.ExecuteReader();

            while (reader.Read())
            {
                bcount++;
            }

            reader.Close();

            return bcount;
        }
        catch (Exception)
        {
            return 0;
        }
    }

}