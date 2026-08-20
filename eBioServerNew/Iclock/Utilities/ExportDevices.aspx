<%@ page language="VB" autoeventwireup="false" inherits="Utilities_ExportDevices, App_Web_h00j2pts" enableEventValidation="false" %>


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
    background-position-y: top;" >
    <form id="form1" runat="server">
    <div>
        <uctrl:header ID="MyHeader" runat="server" />
        <owd:Window ID="wnd_AddUpdate" runat="server" Height="110" StyleFolder="~/Styles/mainwindow/blue"
            Title="Export Devices List" Width="280" IsResizable="true" ShowStatusBar="false"
            Left="350" Top="155" >
            <table width="100%" cellpadding="1" class="Table" style="border-top-style: none;
                border-right-style: none; border-left-style: none; border-bottom-style: solid;">
                <tr>
                    <td>
                        <fieldset style="width: 200px;">
                            <legend>Enter Location</legend>
                            <table>
                               
                                <tr>
                                    <td>
                                        &nbsp;Location&nbsp;&nbsp;&nbsp;
                                    </td>
                                    <td>
                                        <asp:DropDownList ID="drpLocation"  Width="175px" runat="server">
                                    </asp:DropDownList>
                                        
                                    </td>
                                </tr>
                            </table>
                        </fieldset>
                    </td>
                </tr>
                <tr>
                    <td align="right" style="padding-right:5px;">
                        <asp:Button ID="btn_OK" runat="server" Text="Export" 
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
