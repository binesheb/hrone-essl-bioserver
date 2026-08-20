<%@ page language="VB" autoeventwireup="false" inherits="AboutUs, App_Web_ryzztc04" enableeventvalidation="false" %>


<%@ Register Assembly="obout_Window_NET" Namespace="OboutInc.Window" TagPrefix="owd" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" >
<html >
<head id="Head1" runat="server">
    <title>Untitled Page</title>
    <link href="StyleSheet.css" rel="stylesheet" type="text/css" />
     <script type="text/javascript">
        function close_handle()
        {
            var Exp = '<%= Session("IsExpired") %>';
            if(Exp=="11")
            {
               top.location.href="logout.aspx"
            }
        }
    </script>
    
</head>
  
<body>
    <form id="form1" runat="server">
       
        <owd:Window ID="AboutUsDialog" runat="server" OnClientClose="close_handle()"  StyleFolder="~/Styles/mainwindow/blue"
            Title="eBioServer License" VisibleOnLoad="true" Width="390" Height="180"
            ShowCloseButton="true" Left="50" Top="50" ShowStatusBar="false">
            <table width="100%" height="100%" class="Table" style="border-top-style: none; border-right-style: none; border-left-style: none;
                border-bottom-style: none;">
                <tr>
                    <td>
                        <fieldset>
                            <legend></legend>
                            <table>
                                 <tr>
                                    <td>
                                        Software&nbsp;Version:</td>
                                    <td>
                                        <asp:TextBox ID="txt_Version" runat="server" BorderStyle="None"
                                            BorderWidth="0px"  Enabled="False" Width="230px"></asp:TextBox></td>
                                </tr>

                                 <tr>
                                    <td>
                                        Attendance&nbsp;Module:</td>
                                    <td>
                                        
                                        <asp:DropDownList ID="drpEnableAttendance" runat="server">
                                        <asp:ListItem Text="Enabled" Value="Yes"></asp:ListItem>
                                        <asp:ListItem Text="Disabled" Value="No"></asp:ListItem>
                                        </asp:DropDownList>
                                        </td>
                                </tr>

                                <tr>
                                    <td>
                                        Activation&nbsp;Code:</td>
                                    <td>
                                        <asp:TextBox ID="lbl_ActivationCode" runat="server" Enabled="False" BorderStyle="None"
                                            BorderWidth="0px" Width="230px"></asp:TextBox></td>
                                </tr>

                                <tr>
                                    <td>
                                        License Key:</td>
                                    <td>
                                        <asp:TextBox ID="txt_LicenceKey" runat="server" Width="230px"></asp:TextBox></td>
                                </tr>
                                 
                                <tr>
                                    
                                    <td colspan="2" align="right">
                                        <asp:Label ID="lbl_Noofemployee" Text="2000" runat="server"></asp:Label>&nbsp;<asp:Label
                                            ID="lbl_NoofDevice" Text="2000" runat="server"></asp:Label>
                                    </td>
                                </tr>

                                

                            </table>
                        </fieldset>
                    </td>
                </tr>
                <tr>
                    <td align="right">
                        <asp:Label runat="server" ID="lbl_Message" ForeColor="Red" EnableViewState="False"></asp:Label>&nbsp;&nbsp;&nbsp;<input
                            type="button" id="lnk_EditLicense" runat="server" onserverclick="lnk_EditLicense_onServerClick"
                            value="Save" />&nbsp;&nbsp;<input
                            type="button" id="Button1" runat="server"  onclick="AboutUsDialog.Close();"
                            value="Close" />
                    </td>
                </tr>
            </table>
        </owd:Window>
    </form>
</body>
</html>
