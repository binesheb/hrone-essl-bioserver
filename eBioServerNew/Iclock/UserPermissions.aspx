<%@ page language="VB" autoeventwireup="false" inherits="UserPermissions, App_Web_fjgmw3bh" enableEventValidation="false" %>
<%@ Register TagPrefix="owd" Namespace="OboutInc.Window" Assembly="obout_Window_NET" %>
<%@ Register TagPrefix="uctrl" Src="~/Header.ascx" TagName="header" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" >

<html  >
<head runat="server">
    <title>Untitled Page</title>
</head>
   <uctrl:header ID="MyHeader" runat="server" />
<body>
    <form id="form1" runat="server">
    <div>
    
    <owd:Window ID="UserPermissionsWindow" runat="server" 
                    Left="400" Top="200" Height="80"  Width="280" 
                    StyleFolder="~/Styles/mainwindow/blue" Title="Permission Not Allowed" IsModal="True" ShowStatusBar="False"  >            
 <center>
         <table >
    <tr>
        <td align="left" ><asp:Label ID="lblPermission" runat="server" Text="You don't have permission to see this page." Font-Size="11px" ForeColor="Black" Font-Names="Verdana"></asp:Label></td>
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
