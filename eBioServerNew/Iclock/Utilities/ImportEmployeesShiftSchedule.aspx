<%@ page language="VB" autoeventwireup="false" inherits="Utilities_ImportEmployeesShiftSchedule, App_Web_h00j2pts" enableEventValidation="false" %>


<%@ Register Assembly="obout_Window_NET" Namespace="OboutInc.Window" TagPrefix="owd" %>
<%@ Register TagPrefix="uctrl" Src="~/Header.ascx" TagName="header" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" >
<html >
<head id="Head1" runat="server">
    <title>Untitled Page</title>
    <link href="../StyleSheet.css" rel="stylesheet" type="text/css" />
</head>
   <uctrl:header ID="Header1" runat="server" />
<body background="../Images/bck1.gif" style="background-repeat: no-repeat; background-position-x: right;
    background-position-y: top;">
    <form id="form1" runat="server">
    <div>
        <uctrl:header ID="MyHeader" runat="server" />
        <owd:Window ID="wnd_AddUpdate" runat="server" Height="120" StyleFolder="~/Styles/mainwindow/blue"
            Title="Import Employees Shift Schedule" Width="425" IsResizable="true" ShowStatusBar="false"
            Left="350" Top="155" >
            <table width="100%" cellpadding="1" class="Table" style="border-top-style: none;
                border-right-style: none; border-left-style: none; border-bottom-style: solid;">
                <tr>
                    <td>
                        <fieldset style="width: 395px;">
                            <legend></legend>
                            <table>
                             <tr>
                                    <td>
                                        
                                        &nbsp;Select&nbsp;Month&nbsp;
                                    </td>
                                    <td colspan=2>
                                        <asp:DropDownList runat="server" ID="ddlMonth" Width="70px">
                                            <asp:ListItem Text="Jan" Value="01"></asp:ListItem>
                                            <asp:ListItem Text="Feb" Value="02"></asp:ListItem>
                                            <asp:ListItem Text="Mar" Value="03"></asp:ListItem>
                                            <asp:ListItem Text="Apr" Value="04"></asp:ListItem>
                                            <asp:ListItem Text="May" Value="05"></asp:ListItem>
                                            <asp:ListItem Text="Jun" Value="06"></asp:ListItem>
                                            <asp:ListItem Text="Jul" Value="07"></asp:ListItem>
                                            <asp:ListItem Text="Aug" Value="08"></asp:ListItem>
                                            <asp:ListItem Text="Sep" Value="09"></asp:ListItem>
                                            <asp:ListItem Text="Oct" Value="10"></asp:ListItem>
                                            <asp:ListItem Text="Nov" Value="11"></asp:ListItem>
                                            <asp:ListItem Text="Dec" Value="12"></asp:ListItem>
                                        </asp:DropDownList>
                                        - <asp:DropDownList ID="ddlYears" runat="server" AutoPostBack="false" Width="70px" />
                                    </td>
                                </tr>
                               
                                <tr>
                                    <td>
                                        &nbsp;Select&nbsp;File&nbsp;
                                    </td>
                                    <td>
                                        <asp:FileUpload ID="fleup_Employee" runat="server" Width="190px" CssClass="WebControls" />
                                    </td>
                                    <td><a target=_blank href="ShiftScedule.csv">sample&nbsp;format</a></td>
                                </tr>
                            </table>
                        </fieldset>
                    </td>
                </tr>
                <tr>
                    <td align="right" style="padding-right:5px;">

                        <asp:Label ID="lblSuccess" runat="server" Visible=false ForeColor="Green" Text="Label"></asp:Label>
                                         <asp:Literal ID="ltlMessage" runat="server"></asp:Literal> 

                        <asp:Button ID="btn_OK" runat="server" Text="Import" 
                            CssClass="WebControls" />&nbsp;&nbsp;
                        <input id="btn_Cancel" type="button" value="Close" onclick="closeWindow();" class="WebControls" />
                    </td>
                </tr>
            </table>
          
        </owd:Window>
    
    </div>
    </form>
    <script type="text/javascript">
        function closeWindow() {
            try {

                wnd_AddUpdate.Close();
            }
            catch (ex) {
                alert(ex.message);
            }
        }
		    
		  
		    
		    
		    
		    
    </script>
</body>
</html>
