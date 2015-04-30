<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Rebates.aspx.cs" Inherits="Rebates" %>

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
            <h1>Rebates</h1>
            
            <br />
            <asp:Label ID="Label1" runat="server" Text="Member No"></asp:Label>
            <asp:TextBox ID="MemberNo" runat="server"></asp:TextBox>
            <br />
            <asp:RangeValidator ID="rangeMemberno" runat="server" 
                ErrorMessage="Member Number not a number." ControlToValidate="MemberNo" 
                MaximumValue="99999999" MinimumValue="1" ValidationGroup="V"></asp:RangeValidator>
            &nbsp;<br />
            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" 
                ControlToValidate="MemberNo" ErrorMessage="Member No not specified" 
                ValidationGroup="V"></asp:RequiredFieldValidator>
            <br />
            <asp:Button ID="btnGetRebates" runat="server" Text="Get Rebates" 
                onclick="btnGetRebates_Click" ValidationGroup="V" />
            <p>
                <asp:ListView ID="ListView1" runat="server" DataSourceID="RebateDisplay">
                    <AlternatingItemTemplate>
                        <tr style="background-color: #FAFAD2;color: #284775;">
                            <td>
                                <asp:Label ID="transactionidLabel" runat="server" 
                                    Text='<%# Eval("transactionid") %>' />
                            </td>
                            <td>
                                <asp:Label ID="membershipidLabel" runat="server" 
                                    Text='<%# Eval("membershipid") %>' />
                            </td>
                            <td>
                                <asp:Label ID="first_nameLabel" runat="server" 
                                    Text='<%# Eval("first_name") %>' />
                            </td>
                            <td>
                                <asp:Label ID="last_nameLabel" runat="server" Text='<%# Eval("last_name") %>' />
                            </td>
                            <td>
                                <asp:Label ID="startdateLabel" runat="server" Text='<%# Eval("startdate") %>' />
                            </td>
                            <td>
                                <asp:Label ID="rebateLabel" runat="server" Text='<%# Eval("rebate") %>' />
                            </td>
                        </tr>
                    </AlternatingItemTemplate>
                    <EditItemTemplate>
                        <tr style="background-color: #FFCC66;color: #000080;">
                            <td>
                                <asp:Button ID="UpdateButton" runat="server" CommandName="Update" 
                                    Text="Update" />
                                <asp:Button ID="CancelButton" runat="server" CommandName="Cancel" 
                                    Text="Cancel" />
                            </td>
                            <td>
                                <asp:Label ID="transactionidLabel1" runat="server" 
                                    Text='<%# Eval("transactionid") %>' />
                            </td>
                            <td>
                                <asp:TextBox ID="membershipidTextBox" runat="server" 
                                    Text='<%# Bind("membershipid") %>' />
                            </td>
                            <td>
                                <asp:TextBox ID="first_nameTextBox" runat="server" 
                                    Text='<%# Bind("first_name") %>' />
                            </td>
                            <td>
                                <asp:TextBox ID="last_nameTextBox" runat="server" 
                                    Text='<%# Bind("last_name") %>' />
                            </td>
                            <td>
                                <asp:TextBox ID="startdateTextBox" runat="server" 
                                    Text='<%# Bind("startdate") %>' />
                            </td>
                            <td>
                                <asp:TextBox ID="rebateTextBox" runat="server" Text='<%# Bind("rebate") %>' />
                            </td>
                        </tr>
                    </EditItemTemplate>
                    <EmptyDataTemplate>
                        <table runat="server" 
                            style="background-color: #FFFFFF;border-collapse: collapse;border-color: #999999;border-style:none;border-width:1px;">
                            <tr>
                                <td>
                                    This member has never received a rebate.</td>
                            </tr>
                        </table>
                    </EmptyDataTemplate>
                    <InsertItemTemplate>
                        <tr style="">
                            <td>
                                <asp:Button ID="InsertButton" runat="server" CommandName="Insert" 
                                    Text="Insert" />
                                <asp:Button ID="CancelButton" runat="server" CommandName="Cancel" 
                                    Text="Clear" />
                            </td>
                            <td>
                                &nbsp;</td>
                            <td>
                                <asp:TextBox ID="membershipidTextBox" runat="server" 
                                    Text='<%# Bind("membershipid") %>' />
                            </td>
                            <td>
                                <asp:TextBox ID="first_nameTextBox" runat="server" 
                                    Text='<%# Bind("first_name") %>' />
                            </td>
                            <td>
                                <asp:TextBox ID="last_nameTextBox" runat="server" 
                                    Text='<%# Bind("last_name") %>' />
                            </td>
                            <td>
                                <asp:TextBox ID="startdateTextBox" runat="server" 
                                    Text='<%# Bind("startdate") %>' />
                            </td>
                            <td>
                                <asp:TextBox ID="rebateTextBox" runat="server" Text='<%# Bind("rebate") %>' />
                            </td>
                        </tr>
                    </InsertItemTemplate>
                    <ItemTemplate>
                        <tr style="background-color: #FFFBD6;color: #333333;">
                            <td>
                                <asp:Label ID="transactionidLabel" runat="server" 
                                    Text='<%# Eval("transactionid") %>' />
                            </td>
                            <td>
                                <asp:Label ID="membershipidLabel" runat="server" 
                                    Text='<%# Eval("membershipid") %>' />
                            </td>
                            <td>
                                <asp:Label ID="first_nameLabel" runat="server" 
                                    Text='<%# Eval("first_name") %>' />
                            </td>
                            <td>
                                <asp:Label ID="last_nameLabel" runat="server" Text='<%# Eval("last_name") %>' />
                            </td>
                            <td>
                                <asp:Label ID="startdateLabel" runat="server" Text='<%# Eval("startdate") %>' />
                            </td>
                            <td>
                                <asp:Label ID="rebateLabel" runat="server" Text='<%# Eval("rebate") %>' />
                            </td>
                        </tr>
                    </ItemTemplate>
                    <LayoutTemplate>
                        <table runat="server">
                            <tr runat="server">
                                <td runat="server">
                                    <table ID="itemPlaceholderContainer" runat="server" border="1" 
                                        style="background-color: #FFFFFF;border-collapse: collapse;border-color: #999999;border-style:none;border-width:1px;font-family: Verdana, Arial, Helvetica, sans-serif;">
                                        <tr runat="server" style="background-color: #FFFBD6;color: #333333;">
                                            <th runat="server">
                                                Tranasction Number</th>
                                            <th runat="server">
                                                Membership</th>
                                            <th runat="server">
                                                First Name</th>
                                            <th runat="server">
                                                Last Name</th>
                                            <th runat="server">
                                                Delivery date</th>
                                            <th runat="server">
                                                Rebate Amount</th>
                                        </tr>
                                        <tr ID="itemPlaceholder" runat="server">
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr runat="server">
                                <td runat="server" 
                                    style="text-align: center;background-color: #FFCC66;font-family: Verdana, Arial, Helvetica, sans-serif;color: #333333;">
                                    <asp:DataPager ID="DataPager1" runat="server">
                                        <Fields>
                                            <asp:NextPreviousPagerField ButtonType="Button" ShowFirstPageButton="True" 
                                                ShowLastPageButton="True" />
                                        </Fields>
                                    </asp:DataPager>
                                </td>
                            </tr>
                        </table>
                    </LayoutTemplate>
                    <SelectedItemTemplate>
                        <tr style="background-color: #FFCC66;font-weight: bold;color: #000080;">
                            <td>
                                <asp:Label ID="transactionidLabel" runat="server" 
                                    Text='<%# Eval("transactionid") %>' />
                            </td>
                            <td>
                                <asp:Label ID="membershipidLabel" runat="server" 
                                    Text='<%# Eval("membershipid") %>' />
                            </td>
                            <td>
                                <asp:Label ID="first_nameLabel" runat="server" 
                                    Text='<%# Eval("first_name") %>' />
                            </td>
                            <td>
                                <asp:Label ID="last_nameLabel" runat="server" Text='<%# Eval("last_name") %>' />
                            </td>
                            <td>
                                <asp:Label ID="startdateLabel" runat="server" Text='<%# Eval("startdate") %>' />
                            </td>
                            <td>
                                <asp:Label ID="rebateLabel" runat="server" Text='<%# Eval("rebate") %>' />
                            </td>
                        </tr>
                    </SelectedItemTemplate>
                </asp:ListView>
                <asp:SqlDataSource ID="RebateDisplay" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:connSilverMembers %>" 
                    
                    SelectCommand="SELECT [transactionid], [membershipid], [first_name], [last_name], [startdate], [rebate] FROM [transactionlog] WHERE [rebate]>0" 
                    onselecting="RebateDisplay_Selecting">
                </asp:SqlDataSource>
            &nbsp;</p>

            

            </form>
    	</div>
	</div>
	
	<div id="footer">
		<p>Copyright &copy; <a href="Default.aspx">Designed by Yousef Al-Harbi</a></p>
	</div>
</body>
</html>