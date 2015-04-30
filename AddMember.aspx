<%@ Page Language="C#" AutoEventWireup="true" CodeFile="AddMember.aspx.cs" Inherits="AddMember" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Invoice System</title>
    <link rel="stylesheet" href="css/style.css" type="text/css" media="screen" />
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
            <h1>Add New Member</h1>
            <p>The new members are added in regular age. The age defaults to 62.</p>

            <div>
                <label>Membership Number
                <span class="small">(Generated Automatically)</span>
                </label>
                <asp:Label ID="lblInvoiceNumber" runat="server" Text=""></asp:Label>
            </div>

            <div class="spacer"><br /><br /></div>
            <div class="spacer"><br /><br /></div>
             
            <div>
                <label>Membership Class
                <span class="small"></span>
                </label>
                <asp:Label ID="lblMebmerClass" runat="server" Text="Regular"></asp:Label>
            </div>

            <div class="spacer"><br /><br /></div>

            <div>
                <label>Customer First Name
                <span class="small">Please enter first name</span>
                </label>
                <asp:TextBox ID="txtCustomerFirstName" runat="server"></asp:TextBox>                   
            &nbsp;<asp:RequiredFieldValidator ID="rqFirstName" runat="server" 
                    ControlToValidate="txtCustomerFirstName" 
                    ErrorMessage="The first name is required" ValidationGroup="VG1"></asp:RequiredFieldValidator>
            </div>
            <div class="spacer"></div>
              
            <div>
                <label>Customer Last Name
                <span class="small">Please enter first name</span>
                </label>
                <asp:TextBox ID="txtCustomerLastName" runat="server"></asp:TextBox>                   
                <asp:RequiredFieldValidator ID="rqLastName" runat="server" 
                    ControlToValidate="txtCustomerLastName" 
                    ErrorMessage="The last name is required" ValidationGroup="VG2"></asp:RequiredFieldValidator>
            </div>

            <div class="spacer"></div>

            <div>
                <label>Customer Email
                <span class="small">Please enter customer email</span>
                </label>
                <asp:TextBox ID="txtCustomerEmail" runat="server"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rqEmail" runat="server" 
                    ControlToValidate="txtCustomerEmail" ErrorMessage="The email is required" 
                    ValidationGroup="VG3"></asp:RequiredFieldValidator>
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

            <br />
            <div>
            <asp:Button ID="btnCreateInvoice" runat="server" Text="Create Member" 
                    ValidationGroup="VG1VG1" onclick="btnCreateInvoice_Click"/>
            </div>
            </form>
    	</div>
	</div>
	
	<div id="footer">
		<p>Copyright &copy; <a href="Default.aspx">Designed by Yousef</a></p>
	</div>
</body>
</html>