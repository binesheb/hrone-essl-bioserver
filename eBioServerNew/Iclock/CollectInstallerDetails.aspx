<%@ page language="VB" autoeventwireup="false" inherits="CollectInstallerDetails, App_Web_0iwe3y3l" enableEventValidation="false" %>

<%@ Register Assembly="obout_Window_NET" Namespace="OboutInc.Window" TagPrefix="owd" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" >
<html >
<head id="Head1" runat="server">
    <title>Untitled Page</title>
    <link href="StyleSheet.css" rel="stylesheet" type="text/css" />
</head>
   
<body background="../Images/bck1.gif" style="background-repeat: no-repeat; background-position-x: right;
    background-position-y: top;">
    <form id="form1" runat="server">
    <div>
       
        <owd:Window ID="wnd_AddUpdate" runat="server" Height="80" StyleFolder="~/Styles/mainwindow/blue"
            Title="Enable Attendance" Width="300" IsResizable="true" ShowStatusBar="false"
            Left="350" Top="110" >
            <table width="100%" cellpadding="1" class="Table" style="border-top-style: none;
                border-right-style: none; border-left-style: none; border-bottom-style: solid;">
                <tr>
                    <td>
                        <fieldset style="width: 270px;">
                            <legend></legend>
                            <table>
                               
                                
                                <tr>
                                    <td>
                                        Enable&nbsp;Attendance&nbsp;Module?&nbsp;
                                    </td>
                                    <td>
                                        <asp:DropDownList ID="drpIsAttendanceEnabled" runat="server">
                                            <asp:ListItem Value="Yes" Selected>Yes</asp:ListItem>
                                            <asp:ListItem Value="No" >No</asp:ListItem>

                                        </asp:DropDownList>&nbsp;<asp:Button ID="btnOK" runat="server" Text="Save" />
                                    </td>
                                </tr>
                              
                            </table>
                        </fieldset>
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
