<%@ page language="VB" autoeventwireup="false" inherits="Admin_DBSettings, App_Web_euao2wv0" enableEventValidation="false" %>


<%@ Register TagPrefix="owd" Namespace="OboutInc.window" Assembly="obout_Window_NET" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" >
<html >
<head id="Head1" runat="server">
    <title></title>
    <link href="../StyleSheet.css" rel="stylesheet" type="text/css" />
</head>
   

<body background="../Images/bck1.gif"
    style="background-repeat: no-repeat; background-position-x: right; background-position-y: top;">
    <form id="form1" runat="server">
        &nbsp;<owd:Window ID="DatabaseSettingsDialog" runat="server" IsModal="true" Height="285" 
            Width="380" StyleFolder="~/Styles/mainwindow/blue" Title="eTimeTrackServer Database Settings"
             ShowCloseButton="false" ShowStatusBar="False" Left="50"  
            Top="50" Visible="False" VisibleOnLoad="False">
            <table width="100%" cellpadding="1" class="Table" style="border-top-style: none;
                border-right-style: none; border-left-style: none; border-bottom-style: none;">
                <tr>
                    <td>
                        <fieldset style="width: 360px;">
                            <legend>MS SQL Server Database Settings</legend>
                            <table>
                                <tr align="center">
                                    <td style="width: 169px; height: 24px;" align="left">
                                        <asp:Label ID="Lbl_ProviderName" runat="server" Text="Database Type" Width="129px"></asp:Label>
                                    </td>
                                    <td style="width: 170px; height: 24px">
                                        <asp:DropDownList ID="Drp_SqlDatabaseType" AutoPostBack=true runat="server" Width="180px"  >
                                        <asp:ListItem Value="MS SQL Server" Selected="True">MS SQL Server</asp:ListItem>
                                        <asp:ListItem Value="MS SQL Server (TLS)" >MS SQL Server (TLS)</asp:ListItem>
                                        <asp:ListItem Value="MY SQL" >MY SQL</asp:ListItem>
                                        
                                        </asp:DropDownList>
                                    </td>
                                </tr>
                                <tr align="center">
                                    <td style="width: 169px" align="left">
                                        <asp:Label ID="lbl_DatabaseServer" runat="server" Text="Database Server" Width="129px"></asp:Label>
                                    </td>
                                    <td style="width: 170px">
                                        <asp:TextBox ID="Txt_DatabaseServer" runat="server" Width="175px"></asp:TextBox></td>
                                </tr>
                                <tr align="center">
                                    <td style="width: 169px" align="left">
                                        <asp:Label ID="Lbl_DatabaseName" runat="server" Text="Database Name" Width="129px"></asp:Label></td>
                                    <td style="width: 170px">
                                        <asp:TextBox ID="Txt_DatabaseName" runat="server" Width="175px"></asp:TextBox></td>
                                </tr>
                                <tr align="center"  id="trAuth" runat="server">
                                    <td style="width: 169px" align="left">
                                        <asp:Label ID="Lbl_AuthenticationType" runat="server" Text="Authentication Type"
                                            Width="128px"></asp:Label></td>
                                    <td style="width: 170px">
                                        <asp:DropDownList ID="Drp_AuthenticationType" runat="server" Width="180px" AutoPostBack="True">
                                        </asp:DropDownList></td>
                                </tr>

                                 <tr align="center" id="trPortNumber" runat="server" visible=false>
                                    <td style="width: 169px" align="left">
                                        <asp:Label ID="Label1" runat="server" Text="Port Number" Width="126px"></asp:Label>
                                    </td>
                                    <td style="width: 170px">
                                        <asp:TextBox ID="Txt_PortNumber" runat="server" Width="175px"></asp:TextBox></td>
                                </tr>

                                <tr align="center" >
                                    <td style="width: 169px" align="left">
                                        <asp:Label ID="Lbl_DatabaseUserName" runat="server" Text="User Name" Width="126px"></asp:Label>
                                    </td>
                                    <td style="width: 170px">
                                        <asp:TextBox ID="Txt_DatabaseUserName" runat="server" Width="175px"></asp:TextBox></td>
                                </tr>
                                <tr align="center">
                                    <td style="width: 169px" align="left">
                                        <asp:Label ID="Lbl_DatabaseCode" runat="server" Text="Password" Width="128px"></asp:Label>
                                    </td>
                                    <td style="width: 170px">
                                        <asp:TextBox ID="Txt_DatabaseCode" runat="server" Width="175px" TextMode="Password"></asp:TextBox></td>
                                </tr>
                            </table>
                        </fieldset>
                    </td>
                    <tr>
                        <td>
                            <table>
                                <tr>
                                    <td>
                                        <asp:Button ID="btn_TestDB" runat="server" Text="Test Connection" />
                                    </td>
                                    <td>
                                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<asp:Button
                                            ID="Btn_Save" runat="server" Text="Save" OnClientClick="return Btn_SaveOnClientClick();" />
                                        <input id="btn_Cancel" type="button" value="Close" onclick="DatabaseSettingsDialog.Close();" />
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr style="background-color: #EEEEEE;">
                        <td style="background-color: #EEEEEE;">
                            <asp:Label ID="Lbl_Error" runat="server" Style="background-color: #EEEEEE;" Visible="False"
                                EnableViewState="False" ForeColor="Red"></asp:Label><br /><br />
                        </td>
                    </tr>
                    
            </table>
        </owd:Window>
        
        
    </form>

    <script type="text/javascript">
    
           function Btn_SaveOnClientClick()
           {
           
           return confirm('Are you Sure You wants to change the Settings.Application Will Relogin');
            
           
           }
           
          
		    
		        
		       
		        
		        
		    
           
    </script>

</body>
</html>
