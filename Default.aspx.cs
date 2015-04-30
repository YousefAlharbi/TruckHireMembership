using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;
using iTextSharp.text;
using iTextSharp.text.pdf;
using iTextSharp.text.pdf.draw;
using System.Data.SqlClient;
using System.Threading;

public partial class _Default : System.Web.UI.Page
{
    CityController cityController;
    private static Semaphore _sempahore = new Semaphore(3, 3);
    private static Mutex mutex = new Mutex();

    protected void Page_Load(object sender, EventArgs e)
    {
        // open the cities file and get all the cities first 
        cityController = new CityController();
        cityController.readPostCodes(Server.MapPath("data/PostCode-Full_20130228.csv"));


    }

    /* 
     * Display the city and state
     */
    protected void txtStartPostcode_TextChanged(object sender, EventArgs e)
    {
        Area startArea = cityController.getArea(txtStartPostcode.Text);

        if (startArea != null)
        {
            lblStartCity.Text = startArea.Locality;
            lblStartState.Text = startArea.State;
        }
        else
        {
            lblStartCity.Text = "";
            lblStartState.Text = "";
        }
    }

    /* 
     * Display the city and state
     */
    protected void lblArrivalPostcode_TextChanged(object sender, EventArgs e)
    {
        Area arrivalArea = cityController.getArea(txtArrivalPostCode.Text);

        if (arrivalArea != null)
        {
            lblArrivalCity.Text = arrivalArea.Locality;
            lblArrivalState.Text = arrivalArea.State;
        }
        else
        {
            lblArrivalCity.Text = "";
            lblArrivalState.Text = "";
        }
    }

    /* Create the invoice */
    protected void btnCreateInvoice_Click(object sender, EventArgs e)
    {
        // declare new variables for assignment 3 solution
        decimal discount;
        decimal rebate;

        // assume that all the form values have been entered properly
        InvoiceController ic = new InvoiceController();
        RateController rc= new RateController();
        GeographyController gc=new GeographyController();

        // get invoice number
        String invoiceNumber = ic.getInvoiceNumber();
        lblInvoiceNumber.Text = invoiceNumber;

        // now make the calculation for cost
        // first grab all input data
        String customerName = txtCustomerFirstName.Text.Trim() + " " + txtCustomerLastName.Text.Trim();
        String customerEmail = txtCustomerEmail.Text;
        int truck_count = Int32.Parse(txtTruckCount.Text);
        DateTime depart_date = Calendar1.SelectedDate;
        DateTime arrival_date = Calendar2.SelectedDate;
        String depart_postcode = txtStartPostcode.Text;
        String arrival_postcode = txtArrivalPostCode.Text;
        String depart_state = lblStartState.Text;
        String depart_city = lblStartCity.Text;
        String arrival_state = lblArrivalState.Text;
        String arrival_city = lblArrivalCity.Text;
        int depart_time = Int32.Parse(txtStartTime.Text);
        int arrival_time = Int32.Parse(txtArrivalTime.Text);
        decimal distance= gc.getDistance(depart_postcode,arrival_postcode);

        // depart date
        if (depart_date.AddHours(depart_time) > arrival_date.AddHours(arrival_time))
        {
            lblInvoiceNumber.Text = "Sorry! Depart must be before arrival";
            return;
        }

        // calculations
        decimal truckCost = truck_count * 1000;
        decimal perHourCost = truck_count * rc.getTotalCost(depart_state, arrival_state, depart_date, arrival_date, depart_time, arrival_time);
        decimal gst = perHourCost * 10 / 100;
        decimal grandCost = truckCost + perHourCost + gst;

        // calculation for discount and rebate
        String membershipid = txtMemberNo.Text;
        String discount_desc, rebate_desc;

        discount=0;
        discount_desc="No Discount";
        rebate=0;
        rebate_desc="No Rebate";

        // make sure that the discount applies and calculate discount
        int bcount = DatabaseController.getBookingCount(Int32.Parse(txtMemberNo.Text));

        // discount calculation first
        decimal grantCost_withoutGST = truckCost + perHourCost;
        String member_type = txtClass.Text.Trim();

        _sempahore.WaitOne();

        if (member_type == "silver" && grantCost_withoutGST >= 5000)
        {
            // 15% discount
            discount = grantCost_withoutGST * .1m;
            discount_desc = "15% Discount (Silver Member >=5000 )";
        }
        else if (member_type == "gold" && grantCost_withoutGST >= 500)
        {
            // 20% discount
            discount = grantCost_withoutGST * .15m;
            discount_desc = "20% Discount (Gold Member >=5000 )";
        }

        _sempahore.Release();
        _sempahore.WaitOne();

        // rebate calculation second
        if (member_type == "regular")
        {
            if (0 != bcount % 2) // there is a previous booking
            {
                rebate = 200;
                rebate_desc = "$200 Rebate (in credit) for previous booking";
            }
        }
        else if (member_type == "gold")
        {
            if (0 != bcount % 2) // there is a previous booking
            {
                rebate = 300;
                rebate_desc = "$300 Rebate (in credit) for previous booking";
            }
        }

        _sempahore.Release();
        _sempahore.WaitOne();

        decimal cost_appliedrebateanddiscount = grandCost - discount - rebate;

        // create pdf doc
        var output = new MemoryStream();
        var pdfDoc = new Document();
        var pdfWriter = PdfWriter.GetInstance(pdfDoc, output);

        string path = Server.MapPath("PDF");
        PdfWriter.GetInstance(pdfDoc, new FileStream(path + "/" + invoiceNumber + ".pdf", FileMode.Create));
        pdfDoc.Open();

        Paragraph header = new Paragraph("Delivery Invoice", new Font(Font.FontFamily.COURIER, 20, Font.NORMAL, BaseColor.BLACK));
        header.Alignment = Element.ALIGN_CENTER;
        pdfDoc.Add(header);

        Paragraph header1 = new Paragraph("Invoice #" + invoiceNumber, new Font(Font.FontFamily.COURIER, 20, Font.NORMAL, BaseColor.BLACK));
        header1.Alignment = Element.ALIGN_CENTER;
        pdfDoc.Add(header1);

        Chunk linebreak = new Chunk(new LineSeparator(4f, 100f, new BaseColor(233, 244, 249), Element.ALIGN_CENTER, -1));
        pdfDoc.Add(linebreak);

        // now print data into the file
        Paragraph headingDeliveryDetails = new Paragraph("Delivery Details", new Font(Font.FontFamily.COURIER, 16, Font.BOLD, BaseColor.BLACK));
        header.Alignment = Element.ALIGN_CENTER;
        pdfDoc.Add(headingDeliveryDetails);

        Paragraph deliveryDetails1 = new Paragraph("Customer Name: " + customerName, new Font(Font.FontFamily.COURIER, 16, Font.NORMAL, BaseColor.BLACK));
        header.Alignment = Element.ALIGN_CENTER;
        pdfDoc.Add(deliveryDetails1);

        Paragraph deliveryDetails2 = new Paragraph("Customer Email: " + customerEmail, new Font(Font.FontFamily.COURIER, 16, Font.NORMAL, BaseColor.BLACK));
        header.Alignment = Element.ALIGN_CENTER;
        pdfDoc.Add(deliveryDetails2);

        Paragraph deliveryDetails3 = new Paragraph(truck_count + " Trucks required", new Font(Font.FontFamily.COURIER, 16, Font.NORMAL, BaseColor.BLACK));
        header.Alignment = Element.ALIGN_CENTER;
        pdfDoc.Add(deliveryDetails3);

        Paragraph deliveryDetailsBlank = new Paragraph("--------------", new Font(Font.FontFamily.COURIER, 16, Font.BOLD, BaseColor.BLACK));
        header.Alignment = Element.ALIGN_CENTER;
        pdfDoc.Add(deliveryDetailsBlank);

        Paragraph headingDeliverySpecifics = new Paragraph("Delivery Specifics", new Font(Font.FontFamily.COURIER, 16, Font.BOLD, BaseColor.BLACK));
        header.Alignment = Element.ALIGN_CENTER;
        pdfDoc.Add(headingDeliverySpecifics);

        Paragraph deliverySpecific1 = new Paragraph("Delivery from " + depart_city + "(" + depart_postcode + ") to " + arrival_city + "(" + arrival_postcode + ")", new Font(Font.FontFamily.COURIER, 16, Font.NORMAL, BaseColor.BLACK));
        header.Alignment = Element.ALIGN_CENTER;
        pdfDoc.Add(deliverySpecific1);

        Paragraph deliverySpecific2 = new Paragraph("Delivery starts " + depart_date.AddHours(depart_time).ToString(), new Font(Font.FontFamily.COURIER, 16, Font.NORMAL, BaseColor.BLACK));
        header.Alignment = Element.ALIGN_CENTER;
        pdfDoc.Add(deliverySpecific2);

        Paragraph deliverySpecific3 = new Paragraph("Delivery arrives " + arrival_date.AddHours(arrival_time).ToString(), new Font(Font.FontFamily.COURIER, 16, Font.NORMAL, BaseColor.BLACK));
        header.Alignment = Element.ALIGN_CENTER;
        pdfDoc.Add(deliverySpecific3);

        pdfDoc.Add(deliveryDetailsBlank);

        Paragraph headingDeliveryCharges = new Paragraph("Delivery Charges", new Font(Font.FontFamily.COURIER, 16, Font.BOLD, BaseColor.BLACK));
        header.Alignment = Element.ALIGN_CENTER;
        pdfDoc.Add(headingDeliverySpecifics);

        Paragraph deliveryCharges1 = new Paragraph("Truck Charge ($1000 * No of Trucks) is AUD " + truckCost, new Font(Font.FontFamily.COURIER, 16, Font.NORMAL, BaseColor.BLACK));
        header.Alignment = Element.ALIGN_CENTER;
        pdfDoc.Add(deliveryCharges1);
        
        Paragraph deliveryCharges2 = new Paragraph("Delivery Charge (Base) is AUD " + perHourCost, new Font(Font.FontFamily.COURIER, 16, Font.NORMAL, BaseColor.BLACK));
        header.Alignment = Element.ALIGN_CENTER;
        pdfDoc.Add(deliveryCharges2);

        Paragraph deliveryCharges3 = new Paragraph("GST (on Delivery Charges Only) is AUD " + gst, new Font(Font.FontFamily.COURIER, 16, Font.NORMAL, BaseColor.BLACK));
        header.Alignment = Element.ALIGN_CENTER;
        pdfDoc.Add(deliveryCharges3);

        Paragraph deliveryCharges4 = new Paragraph("Grand Cost is AUD " + grandCost, new Font(Font.FontFamily.COURIER, 16, Font.NORMAL, BaseColor.BLACK));
        header.Alignment = Element.ALIGN_CENTER;
        pdfDoc.Add(deliveryCharges4);

        // put discount into the invoice
        if (discount != 0)
        {
            Paragraph deliveryCharges5 = new Paragraph("Discount is $" + discount, new Font(Font.FontFamily.COURIER, 16, Font.NORMAL, BaseColor.BLACK));
            Paragraph deliveryCharges6 = new Paragraph("Discount given for [" + discount_desc + "]", new Font(Font.FontFamily.COURIER, 16, Font.NORMAL, BaseColor.BLACK));

            header.Alignment = Element.ALIGN_CENTER;
            pdfDoc.Add(deliveryCharges5);
            pdfDoc.Add(deliveryCharges6);
        }

        // put rebate into the invoice
        if (rebate != 0)
        {
            Paragraph deliveryCharges7 = new Paragraph("Rebate is $" + rebate, new Font(Font.FontFamily.COURIER, 16, Font.NORMAL, BaseColor.BLACK));
            Paragraph deliveryCharges8 = new Paragraph("Rebate given for [" + rebate_desc + "]", new Font(Font.FontFamily.COURIER, 16, Font.NORMAL, BaseColor.BLACK));

            header.Alignment = Element.ALIGN_CENTER;
            pdfDoc.Add(deliveryCharges7);
            pdfDoc.Add(deliveryCharges8);
        }

        pdfDoc.Add(deliveryDetailsBlank);
        

        Paragraph headingDistance = new Paragraph("Distance of delivery", new Font(Font.FontFamily.COURIER, 16, Font.BOLD, BaseColor.BLACK));
        header.Alignment = Element.ALIGN_CENTER;
        pdfDoc.Add(headingDeliverySpecifics);

        Paragraph distance1 = new Paragraph("Total delivery distance is " + distance + " Km", new Font(Font.FontFamily.COURIER, 16, Font.NORMAL, BaseColor.BLACK));
        header.Alignment = Element.ALIGN_CENTER;
        pdfDoc.Add(distance1);

        pdfDoc.Close();

        /* Store the booking details in the database */
        SqlConnection connection = new SqlConnection();
        SqlCommand command;
        connection.ConnectionString = @"Data Source=.\SQLEXPRESS;AttachDbFilename=|DataDirectory|\M_DB.mdf;Integrated Security=True;User Instance=True";
        connection.Open();

        String member_sql
                = "INSERT INTO transactionlog (invno,first_name,last_name,membershipid,customer_email,trucks,startdate,starttime,startcity,startstate,arrivaldate,arrivaltime,arrivalcity,arrivalstate,deliverycharge,gst,grand_cost,distance,discount,rebate,payable_cost) VALUES ('" + invoiceNumber.Trim() + "','" + txtCustomerFirstName.Text.Trim() + "','" + txtCustomerLastName.Text.Trim() + "'," + txtMemberNo.Text.Trim() + ",'" + txtCustomerEmail.Text.Trim() + "'," + truck_count + ",'" + txtStartDate.Text.Trim() + "','" + txtStartTime.Text.Trim() + "','" + lblStartCity.Text.Trim() + "','" + lblStartState.Text.Trim() + "','" + txtArrivalDate.Text.Trim() + "','" + txtArrivalTime.Text.Trim() + "','" + lblArrivalCity.Text.Trim() + "','" + lblArrivalState.Text.Trim() + "'," + perHourCost + "," + gst + "," + grandCost + "," + distance + "," + discount + "," + rebate + "," + cost_appliedrebateanddiscount + ")";
        command = new SqlCommand(member_sql, connection);
        command.ExecuteNonQuery();
        _sempahore.Release();

        /* The booking is created
         * Show the pdf file to the user */
        Response.ContentType = "application/pdf";
        Response.AddHeader("Content-Disposition", string.Format("attachment:filename=/" + invoiceNumber + ".pdf", "test"));
        Response.BinaryWrite(output.ToArray());
    }

    // not used
    protected void txtStartDate_TextChanged(object sender, EventArgs e)
    {

    }

    // starting date
    protected void Calendar1_SelectionChanged(object sender, EventArgs e)
    {
        txtStartDate.Text = Calendar1.SelectedDate.Date.ToString();
    }

    // arrival date
    protected void Calendar2_SelectionChanged(object sender, EventArgs e)
    {
        txtArrivalDate.Text = Calendar2.SelectedDate.Date.ToString();
    }

    protected void ButtonGetMember_Click(object sender, EventArgs e)
    {
        /* Get the member details from the database */
        try
        {
            MemberEntity memberEntity = DatabaseController.getMember(Int32.Parse(txtMemberNo.Text));
            if (memberEntity == null)
            {
                throw new Exception("Invalid Member Id");
            }

            txtClass.Text = memberEntity.MClass;
            txtCustomerFirstName.Text = memberEntity.FName;
            txtCustomerLastName.Text = memberEntity.LName;  
        }
        catch (Exception)
        {
            txtClass.Text = "Invalid Member id";
            txtCustomerFirstName.Text = "";
            txtCustomerLastName.Text = "";
        }
    }
    protected void btnReset_Click(object sender, EventArgs e)
    {

    }
} 