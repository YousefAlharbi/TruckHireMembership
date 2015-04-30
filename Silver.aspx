<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Silver.aspx.cs" Inherits="Silver" %>

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
            <h1>Silver Members</h1>
            
            <p>
            </p>

            <asp:ListView ID="ListView1" runat="server" DataSourceID="SilverMembers">
                <AlternatingItemTemplate>
                    <tr style="">
                        <td>
                            <asp:Label ID="membershipidLabel" runat="server" 
                                Text='<%# Eval("membershipid") %>' />
                        </td>
                        <td>
                            <asp:Label ID="emp_noLabel" runat="server" Text='<%# Eval("emp_no") %>' />
                        </td>
                        <td>
                            <asp:Label ID="first_nameLabel" runat="server" 
                                Text='<%# Eval("first_name") %>' />
                        </td>
                        <td>
                            <asp:Label ID="last_nameLabel" runat="server" Text='<%# Eval("last_name") %>' />
                        </td>
                        <td>
                            <asp:Label ID="membership_classLabel" runat="server" 
                                Text='<%# Eval("membership_class") %>' />
                        </td>
                    </tr>
                </AlternatingItemTemplate>
                <EditItemTemplate>
                    <tr style="">
                        <td>
                            <asp:Button ID="UpdateButton" runat="server" CommandName="Update" 
                                Text="Update" />
                            <asp:Button ID="CancelButton" runat="server" CommandName="Cancel" 
                                Text="Cancel" />
                        </td>
                        <td>
                            <asp:Label ID="membershipidLabel1" runat="server" 
                                Text='<%# Eval("membershipid") %>' />
                        </td>
                        <td>
                            <asp:TextBox ID="emp_noTextBox" runat="server" Text='<%# Bind("emp_no") %>' />
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
                            <asp:TextBox ID="membership_classTextBox" runat="server" 
                                Text='<%# Bind("membership_class") %>' />
                        </td>
                    </tr>
                </EditItemTemplate>
                <EmptyDataTemplate>
                    <table runat="server" style="">
                        <tr>
                            <td>
                                No data was returned.</td>
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
                            <asp:TextBox ID="emp_noTextBox" runat="server" Text='<%# Bind("emp_no") %>' />
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
                            <asp:TextBox ID="membership_classTextBox" runat="server" 
                                Text='<%# Bind("membership_class") %>' />
                        </td>
                    </tr>
                </InsertItemTemplate>
                <ItemTemplate>
                    <tr style="">
                        <td>
                            <asp:Label ID="membershipidLabel" runat="server" 
                                Text='<%# Eval("membershipid") %>' />
                        </td>
                        <td>
                            <asp:Label ID="emp_noLabel" runat="server" Text='<%# Eval("emp_no") %>' />
                        </td>
                        <td>
                            <asp:Label ID="first_nameLabel" runat="server" 
                                Text='<%# Eval("first_name") %>' />
                        </td>
                        <td>
                            <asp:Label ID="last_nameLabel" runat="server" Text='<%# Eval("last_name") %>' />
                        </td>
                        <td>
                            <asp:Label ID="membership_classLabel" runat="server" 
                                Text='<%# Eval("membership_class") %>' />
                        </td>
                    </tr>
                </ItemTemplate>
                <LayoutTemplate>
                    <table runat="server">
                        <tr runat="server">
                            <td runat="server">
                                <table ID="itemPlaceholderContainer" runat="server" border="0" style="">
                                    <tr runat="server" style="">
                                        <th runat="server">
                                            Membership Id</th>
                                        <th runat="server">
                                            Employee Id</th>
                                        <th runat="server">
                                            First Name</th>
                                        <th runat="server">
                                            Last Name</th>
                                        <th runat="server">
                                            Class</th>
                                    </tr>
                                    <tr ID="itemPlaceholder" runat="server">
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr runat="server">
                            <td runat="server" style="">
                                <asp:DataPager ID="DataPager1" runat="server">
                                    <Fields>
                                        <asp:NextPreviousPagerField ButtonType="Button" ShowFirstPageButton="True" 
                                            ShowNextPageButton="False" ShowPreviousPageButton="False" />
                                        <asp:NumericPagerField />
                                        <asp:NextPreviousPagerField ButtonType="Button" ShowLastPageButton="True" 
                                            ShowNextPageButton="False" ShowPreviousPageButton="False" />
                                    </Fields>
                                </asp:DataPager>
                            </td>
                        </tr>
                    </table>
                </LayoutTemplate>
                <SelectedItemTemplate>
                    <tr style="">
                        <td>
                            <asp:Label ID="membershipidLabel" runat="server" 
                                Text='<%# Eval("membershipid") %>' />
                        </td>
                        <td>
                            <asp:Label ID="emp_noLabel" runat="server" Text='<%# Eval("emp_no") %>' />
                        </td>
                        <td>
                            <asp:Label ID="first_nameLabel" runat="server" 
                                Text='<%# Eval("first_name") %>' />
                        </td>
                        <td>
                            <asp:Label ID="last_nameLabel" runat="server" Text='<%# Eval("last_name") %>' />
                        </td>
                        <td>
                            <asp:Label ID="membership_classLabel" runat="server" 
                                Text='<%# Eval("membership_class") %>' />
                        </td>
                    </tr>
                </SelectedItemTemplate>
            </asp:ListView>

            <asp:SqlDataSource ID="SilverMembers" runat="server" 
                ConnectionString="<%$ ConnectionStrings:connSilverMembers %>" 
                SelectCommand="SELECT [membershipid], [emp_no], [first_name], [last_name], [membership_class] FROM [membership] WHERE [membership_class]='silver'">
            </asp:SqlDataSource>

            </form>
    	</div>
	</div>
	
	<div id="footer">
		<p>Copyright &copy; <a href="Default.aspx">Designed by Yousef Al-Harbi</a></p>
	</div>
</body>
</html>