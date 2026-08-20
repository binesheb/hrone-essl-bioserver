<%@ page language="VB" autoeventwireup="false" inherits="Admin_APISettings, App_Web_euao2wv0" enableEventValidation="false" %>
<%@ Register TagPrefix="uctrl" Src="~/Header.ascx" TagName="header" %>

<%@ Register TagPrefix="owd" Namespace="OboutInc.window" Assembly="obout_Window_NET" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" >
<html >
<head id="Head1" runat="server">
    <title></title>
    <link href="../StyleSheet.css" rel="stylesheet" type="text/css" />
</head>
   <uctrl:header ID="MyHeader" runat="server" />
<body background="../Images/bck1.gif"
    style="background-repeat: no-repeat; background-position-x: right; background-position-y: top;">
    <form id="form1" runat="server">
        &nbsp;<owd:Window ID="APISettingsDialog" runat="server" IsModal="true" Height="170" 
            Width="400" StyleFolder="~/Styles/mainwindow/blue" Title="eBioServer API Settings"
             ShowCloseButton="false" ShowStatusBar="False" Left="50"  
            Top="50" Visible="False" VisibleOnLoad="False">
            <table width="100%" cellpadding="1" class="Table" style="border-top-style: none;
                border-right-style: none; border-left-style: none; border-bottom-style: none;">
                <tr>
                    <td>
                        <fieldset style="width: 360px;">
                            <legend>API Settings</legend>
                            <table>
                               
                                
                                <tr align="center">
                                    <td style="width: 169px" align="left">
                                        <asp:Label ID="Lbl_DatabaseUserName" runat="server" Text="User Name" Width="126px"></asp:Label>
                                    </td>
                                    <td style="width: 170px">
                                        <asp:TextBox ID="Txt_APIUserName" runat="server" Width="175px"></asp:TextBox></td>
                                </tr>
                                <tr align="center">
                                    <td style="width: 169px" align="left">
                                        <asp:Label ID="Lbl_DatabaseCode" runat="server" Text="Password" Width="128px"></asp:Label>
                                    </td>
                                    <td style="width: 170px">
                                        <asp:TextBox ID="Txt_APICode" runat="server" Width="175px" TextMode="Password"></asp:TextBox></td>
                                </tr>
                            </table>
                        </fieldset>
                    </td>
                    <tr>
                        <td>
                            <table>
                                <tr>
                                    
                                    <td>
                                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<asp:Button
                                            ID="Btn_Save" runat="server" Text="Save" OnClientClick="return Btn_SaveOnClientClick();" />
                                        <input id="btn_Cancel" type="button" value="Close" onclick="APISettingsDialog.Close();" />
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

        function Btn_SaveOnClientClick() {

            return confirm('Are you Sure You wants to change the Settings.');


        }

        function Btn_OracleSaveOnClientClick() {

            return confirm('Are you Sure You wants to change the Settings.');


        }
		    
		    
		        
		       
		        
		        
		    
           
    </script>

</body>
</html>
