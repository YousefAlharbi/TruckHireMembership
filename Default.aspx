<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Default" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Invoice System</title>
    <link rel="stylesheet" href="css/style.css" type="text/css" media="screen" />
    <script type="text/javascript">
        // function to validate an email address 
        function validateEmail(emailadd) {
            var atpos = emailadd.indexOf("@");
            var dotpos = emailadd.lastIndexOf(".");
            if (atpos < 1 || dotpos < atpos + 2 || dotpos + 2 >= emailadd.length) {
                return false;
            } else {
                return true;
            }
        }

        // Enforce the javascript validations
        function ValidateForm() {
            // check customer name is entered
            var customer_name_first = document.getElementById("<%=txtCustomerFirstName.ClientID%>");
            if (customer_name_first.value == "") {
                alert('The customer name is not entered by you');
                return false;
            }

            var customer_name_last = document.getElementById("<%=txtCustomerLastName.ClientID%>");
            if (customer_name_last.value == "") {
                alert('The customer name is not entered by you');
                return false;
            }

            // check customer email is entered
            var customer_email = document.getElementById("<%=txtCustomerEmail.ClientID%>");
            if (customer_email.value == "") {
                alert('The customer email is not entered by you');
                return false;
            }
            else if (!validateEmail(customer_email.value)) {
                alert('The customer email is not valid');
                return false;
            }

            // check truck count is entered and is a valid number (1 to 50)
            var truck_count = document.getElementById("<%=txtTruckCount.ClientID%>");
            if (truck_count.value == "") {
                alert('The truck count is not entered by you');
                return false;
            }
            else if (isNaN(parseInt(truck_count.value))) {
                alert('The truck count is not a number');
                return false;
            }
            else if (parseInt(truck_count.value) < 1 || parseInt(truck_count.value) > 50) {
                alert('The truck count is not a number between 1-50');
                return false;
            }

            // now check that both delivery times are entered between 0 to 24
            var delivery_start_time = document.getElementById("<%=txtStartTime.ClientID%>");
            if (delivery_start_time.value == "") {
                alert('The delivery start time is not entered by you');
                return false;
            }
            else if (isNaN(parseInt(delivery_start_time.value))) {
                alert('The delivery start time is not a number');
                return false;
            }
            else if (parseInt(delivery_start_time.value) < 0 || parseInt(delivery_start_time.value) > 24) {
                alert('The delivery start time is not a number between 0-24');
                return false;
            }

            // check that the starting postcode has been entered
            var start_post_code = document.getElementById("<%=txtStartPostcode.ClientID%>");
            var start_city = document.getElementById("<%=lblStartCity.ClientID%>");
            if (start_post_code.value == "") {
                alert('The starting post code is not entered by you');
                return false;
            }
            else if (isNaN(parseInt(start_post_code.value))) {
                alert('The starting post code is not a number');
                return false;
            }
            else if(start_city.value=="") {
                alert('The starting post code entered by you is not valid');
                return false;
            }

            // start date must be entered
            var start_date = document.getElementById("<%=txtStartDate.ClientID%>");
            if (start_date.value == "") {
                alert('The start date is not entered by you');
                return false;
            }

            // now check that both delivery times are entered between 0 to 24
            var delivery_arrival_time = document.getElementById("<%=txtArrivalTime.ClientID%>");
            if (delivery_arrival_time.value == "") {
                alert('The delivery arrival time is not entered by you');
                return false;
            }
            else if (isNaN(parseInt(delivery_arrival_time.value))) {
                alert('The delivery arrival time is not a number');
                return false;
            }
            else if (parseInt(delivery_arrival_time.value) < 0 || parseInt(delivery_arrival_time.value) > 24) {
                alert('The delivery arrival time is not a number between 0-24');
                return false;
            }

            // check that the arrival postcode has been entered
            var arrival_post_code = document.getElementById("<%=txtArrivalPostCode.ClientID%>");
            var arrival_city = document.getElementById("<%=lblArrivalCity.ClientID%>");
            if (arrival_post_code.value == "") {
                alert('The arrival post code is not entered by you');
                return false;
            }
            else if (isNaN(parseInt(arrival_post_code.value))) {
                alert('The arrival post code is not a number');
                return false;
            }
            else if (arrival_city.value == "") {
                alert('The arrival post code entered by you is not valid');
                return false;
            }

            // arrival date must be entered
            var arrival_date = document.getElementById("<%=txtArrivalDate.ClientID%>");
            if (arrival_date.value == "") {
                alert('The arrival date is not entered by you');
                return false;
            }

            // everything is ok
            return true; 
        }
    </script>
</head>

<body>
	<div id="header">
		<h1>SIT322 Content Management System</h1>
		<h2>Invoice Generation..</h2>
	</div>
	<div id="navigation">
		<ul>
			<li><a href="Default.aspx" class="active">Home</a></li>
            <li><a href="AddMember.aspx" class="active">Add Member</a></li>
            <li><a href="Regular.aspx" class="active">Regular</a></li>
            <li><a href="Gold.aspx" class="active">Gold</a></li>
            <li><a href="Silver.aspx" class="active">Silver</a></li>
            <li><a href="Invoices.aspx" class="active">Invoices</a></li>
            <li><a href="Rebates.aspx" class="active">Rebates</a></li>
		</ul>
	</div>
	<div id="content">
			
        <div id="stylized" class="myform">
		    <form id="form" name="form" runat="server">
            <h1>Create Invoice</h1>
            <p>Please enter details to create an invoice.</p>

            <div>
                <label>Member No
                <span class="small"></span>
                </label>
                <asp:TextBox ID="txtMemberNo" runat="server"></asp:TextBox>
                <asp:TextBox ID="txtClass" runat="server" Enabled="false">Member Class shown here.</asp:TextBox>
                <asp:Button ID="ButtonGetMember" runat="server" Text="Get Member" 
                    onclick="ButtonGetMember_Click" />
            </div>

            <div class="spacer"><br /><br /></div>

            <div>
                <label>Invoice Number
                <span class="small">(Generated Automatically)</span>
                </label>
                <asp:Label ID="lblInvoiceNumber" runat="server" Text=""></asp:Label>
            </div>

            <div class="spacer"><br /><br /></div>

            <div>
                <label>Customer First Name
                <span class="small">Please enter customer first name</span>
                </label>
                <asp:TextBox ID="txtCustomerFirstName" runat="server" Enabled="False"></asp:TextBox>                   
            </div>
            <div class="spacer"></div>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" 
            ErrorMessage="You must enter customer first name" ControlToValidate="txtCustomerFirstName" 
            ValidationGroup="InvoiceValidation" ForeColor="#660066"></asp:RequiredFieldValidator>


            <div>
                <label>Customer Last Name
                <span class="small">Please enter customer last name</span>
                </label>
                <asp:TextBox ID="txtCustomerLastName" runat="server" Enabled="False"></asp:TextBox>                   
            </div>
            <div class="spacer"></div>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" 
            ErrorMessage="You must enter customer last name" ControlToValidate="txtCustomerLastName" 
            ValidationGroup="InvoiceValidation" ForeColor="#660066"></asp:RequiredFieldValidator>      
            <div class="spacer"></div>


            <div>
                <label>Customer Email
                <span class="small">Please enter customer email</span>
                </label>
                <asp:TextBox ID="txtCustomerEmail" runat="server"></asp:TextBox>
            </div>
        
            <div class="spacer"></div>
            <asp:RequiredFieldValidator ID="checkCustomerEmailRequired" runat="server" 
            ErrorMessage="You must enter customer email" ControlToValidate="txtCustomerEmail" 
            ValidationGroup="InvoiceValidation" ForeColor="#660066"></asp:RequiredFieldValidator>

            <asp:RegularExpressionValidator ID="checkCustomerEmailValid" runat="server" 
                ErrorMessage="The email address format is invalid." 
                ControlToValidate="txtCustomerEmail" ForeColor="#660066" 
                ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" 
                ValidationGroup="InvoiceValidation"></asp:RegularExpressionValidator>

                  
            <div class="spacer"></div>

            <div>
                <label>Trucks
                <span class="small">How many trucks?</span></label>
                <asp:TextBox ID="txtTruckCount" runat="server"></asp:TextBox>
            </div>

            <div class="spacer">
                
            </div>
            <asp:RequiredFieldValidator ID="checkTruckCountRequired" runat="server" 
            ErrorMessage="You must enter truck count" ControlToValidate="txtTruckCount" 
            ValidationGroup="InvoiceValidation" ForeColor="#660066"></asp:RequiredFieldValidator>
            <asp:RangeValidator ID="rangeTruckCount" runat="server" type="Integer" ControlToValidate="txtTruckCount" 
                    ErrorMessage="The number of trucks must be 1 to 50" 
                ForeColor="#660066" ValidationGroup="InvoiceValidation" MaximumValue="50" MinimumValue="1"></asp:RangeValidator>

            <div class="spacer"></div>

            <div class="spacer"></div>

            <h2>Delivery Start?</h2>

            <div>
                <label>Start Date
                <span class="small">What is the start date (dd/mm/yyyy)?</span></label>
                <asp:TextBox ID="txtStartDate" runat="server" 
                    ontextchanged="txtStartDate_TextChanged" Enabled="False"></asp:TextBox>
            </div>
            <asp:Calendar ID="Calendar1" runat="server" 
                onselectionchanged="Calendar1_SelectionChanged"></asp:Calendar>

            <div class="spacer"></div>
            <asp:RequiredFieldValidator ID="checkStartDateRequired" runat="server" 
            ErrorMessage="You must select a start date from the calendar" ControlToValidate="txtStartDate" 
            ValidationGroup="InvoiceValidation" ForeColor="#660066"></asp:RequiredFieldValidator>
            <div class="spacer"></div>

            <div>
                <label>Start Time
                <span class="small">(0-24 full hours only)</span></label>
                <asp:TextBox ID="txtStartTime" runat="server"></asp:TextBox><br /><br />
            </div>

            <div class="spacer"></div>
            <asp:RequiredFieldValidator ID="checkStartTimeRequired" runat="server" 
            ErrorMessage="You must enter a start time" ControlToValidate="txtStartTime" 
            ValidationGroup="InvoiceValidation" ForeColor="#660066"></asp:RequiredFieldValidator>
            
            <asp:RangeValidator type="Integer" ID="checkRangeTime" runat="server" 
                    ErrorMessage="The start time must be 0 to 24"  ControlToValidate="txtStartTime" 
                ForeColor="#660066" ValidationGroup="InvoiceValidation" MaximumValue="24" MinimumValue="0"></asp:RangeValidator>

            <div class="spacer"></div>

            <div>
                <label>Start Postcode
                <span class="small">What is the starting postcode?</span></label>
                <asp:TextBox ID="txtStartPostcode" runat="server" AutoPostBack="True" 
                    ontextchanged="txtStartPostcode_TextChanged"></asp:TextBox>
            </div>

            <div class="spacer"></div>
            <asp:RequiredFieldValidator ID="checkStartPostcodeRequired" runat="server" 
            ErrorMessage="You must enter a start post code" ControlToValidate="txtStartPostcode" 
            ValidationGroup="InvoiceValidation" ForeColor="#660066"></asp:RequiredFieldValidator>
            <div class="spacer"></div>

            <div>
                <label>Start City
                <span class="small">(Displayed Automatically)</span>
                </label>
                &nbsp;&nbsp;&nbsp;<asp:TextBox 
                    ID="lblStartCity" runat="server" Enabled="False"></asp:TextBox>
            </div>

            <div class="spacer"></div>

            <div>
                <label>Start State
                <span class="small">(Displayed Automatically)</span>
                </label>
                &nbsp;&nbsp;&nbsp;<asp:Label ID="lblStartState" runat="server" Text=""></asp:Label>
            </div>

            <div class="spacer"></div>
            <div class="spacer"></div>

            <h2>Delivery Destination?</h2>

            <div>
                <label>Arrival Date
                <span class="small">What is the arrival date (dd/mm/yyyy)</span></label>
                <asp:TextBox ID="txtArrivalDate" runat="server" Enabled="False"></asp:TextBox>
            </div>
            <asp:Calendar ID="Calendar2" runat="server" 
                onselectionchanged="Calendar2_SelectionChanged"></asp:Calendar>

            <div class="spacer"></div>
            <asp:RequiredFieldValidator ID="checkRequiredArrivalDate" runat="server" 
            ErrorMessage="You must select a valid arrival date" ControlToValidate="txtArrivalDate" 
            ValidationGroup="InvoiceValidation" ForeColor="#660066"></asp:RequiredFieldValidator>
            <div class="spacer"></div>

            <div>
                <label>Arrival Time
                <span class="small">(0-24 full hours only)</span></label>
                <asp:TextBox ID="txtArrivalTime" runat="server"></asp:TextBox><br /><br />
            </div>

            <div class="spacer"></div>
            <asp:RequiredFieldValidator ID="checkRequiredArrivalTime" runat="server" 
            ErrorMessage="You must select a valid arrival time" ControlToValidate="txtArrivalTime" 
            ValidationGroup="InvoiceValidation" ForeColor="#660066"></asp:RequiredFieldValidator>
            
            <asp:RangeValidator ID="checkRangeArrivalTime" type="Integer" runat="server" 
                    ErrorMessage="The arrival time must be 0 to 24"  ControlToValidate="txtArrivalTime" 
                ForeColor="#660066" ValidationGroup="InvoiceValidation" MaximumValue="24" MinimumValue="0"></asp:RangeValidator>

            <div class="spacer"></div>

            <div>
                <label>Arrival Postcode
                <span class="small">What is the arrival postcode?</span></label>
                <asp:TextBox ID="txtArrivalPostCode" runat="server" AutoPostBack="True" 
                    ontextchanged="lblArrivalPostcode_TextChanged"></asp:TextBox>
            </div>

            <div class="spacer"></div>
            <asp:RequiredFieldValidator ID="checkRequiredArrivalPostcode" runat="server" 
            ErrorMessage="You must select a valid arrival post code" ControlToValidate="txtArrivalPostCode" 
            ValidationGroup="InvoiceValidation" ForeColor="#660066"></asp:RequiredFieldValidator>
            <div class="spacer"></div>

            <div>
                <label>Arrival City
                <span class="small">(Displayed Automatically)</span>
                </label>
                &nbsp;&nbsp;&nbsp;<asp:TextBox 
                    ID="lblArrivalCity" runat="server" Enabled="False"></asp:TextBox>
            </div>

            <div class="spacer"></div>

            <div>
                <label>Arrival State
                <span class="small">(Displayed Automatically)</span>
                </label>
                &nbsp;&nbsp;&nbsp;<asp:Label ID="lblArrivalState" runat="server" Text=""></asp:Label>
            </div>

            <div class="spacer"></div>

            <br />
            <div>
            <asp:Button ID="btnCreateInvoice" runat="server" Text="Create Invoice" 
                    onclick="btnCreateInvoice_Click" OnClientClick="ValidateForm()" 
                    ValidationGroup="InvoiceValidation"/>
            <asp:Button ID="btnReset" runat="server" Text="Clear details" 
                    onclick="btnReset_Click" />
            </div>
            </form>
    	</div>
	</div>
	
	<div id="footer">
		<p>Copyright &copy; <a href="Default.aspx">Designed by Yousef</a></p>
	</div>
</body>
</html>