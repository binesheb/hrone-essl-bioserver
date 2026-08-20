<%@ page language="VB" autoeventwireup="false" inherits="LicenseKeyViolation, App_Web_0iwe3y3l" enableEventValidation="false" %>
<%@ Register TagPrefix="owd" Namespace="OboutInc.Window" Assembly="obout_Window_NET" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" >

<html  >
<head runat="server">
    <title>Untitled Page</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
    <owd:Window ID="UserPermissionsWindow" runat="server" 
                    Left="400" Top="200" Height="90"  Width="300" 
                    StyleFolder="~/Styles/mainwindow/blue" Title="License Key Violation" IsModal="True" ShowStatusBar="False"  >            
 <center>
         <table >
    <tr>
        <td align="left" ><asp:Label ID="lblPermission" runat="server" Text="Either total allowed limit of employees or hardware exceed. Please update your license key" Font-Size="11px" ForeColor="Black" Font-Names="Verdana"></asp:Label></td>
    </tr>
    
    <tr>
        <td align="right" ><input id="btnOk" type="button" value="Close" onclick="UserPermissionsWindow.Close();" /></td>
    </tr>
             
    
</table>  
 </center> 
  </owd:Window>
    
    </div>
    </form>
</body>
</html>
