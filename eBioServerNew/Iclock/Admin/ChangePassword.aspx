<%@ page language="VB" autoeventwireup="false" inherits="Admin_ChangePassword, App_Web_euao2wv0" enableEventValidation="false" %>
<%@ Register Assembly="obout_Window_NET" Namespace="OboutInc.Window" TagPrefix="owd" %>
<%@ Register TagPrefix="uctrl" Src="~/Header.ascx" TagName="header" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" >

<html  >
<head runat="server">
    <title>Untitled Page</title>
    <link href="../StyleSheet.css" rel="stylesheet" type="text/css" />
    
</head>
   <uctrl:header ID="Header1" runat="server" />
<body>
    <form id="form1" runat="server">
    <div>
            <uctrl:header ID="MyHeader" runat="server" />
        <owd:Window ID="ChangePassword" runat="server" IsModal="true" Height="195"
            Width="405" StyleFolder="~/Styles/mainwindow/blue" Title="Change Password"
            VisibleOnLoad="true" ShowCloseButton="false" 
            ShowStatusBar="False" Left="350" Top="155">
            <table width="100%" height="100%" cellpadding="1" class="Table" style="border-top-style: none; border-right-style: none; border-left-style: none; border-bottom-style: none;">
                <tr>
                    <td>
                        <fieldset>
                            <legend>Change Password</legend>
                            <table>

                            <tr>
                            <td style="font-weight: bold;">Old Password</td>
                            <td><asp:TextBox ID="txt_OldPassword" runat="server" TextMode="Password" Width="230px"></asp:TextBox></td>
                            </tr>

                            <tr>
                            <td style="font-weight: bold;">New Password</td>
                            <td><asp:TextBox ID="txt_NewPassword" runat="server" TextMode="Password" Width="230px"></asp:TextBox></td>
                            </tr>
                            
                            <tr>
                            <td style="font-weight: bold;">Confirm Password</td>
                            <td><asp:TextBox ID="txt_ConfirmPassword" runat="server" TextMode="Password" Width="230px"></asp:TextBox></td>
                            </tr>
                                
                            </table>
                        </fieldset>
                    </td>
                    <tr>
                        <td align="right">
                            <asp:Button
                                ID="Btn_Save" runat="server" Text="Save" Width="60px"  />
                            &nbsp;&nbsp;&nbsp;<input id="btn_Cancel" type="button" value="Close" OnClick="return closeWindow();" />
                        </td>
                    </tr>
                <tr>
                    <td>
                        <asp:Label ID="Lbl_Error" runat="server" EnableViewState="False" Text="&nbsp;" ForeColor="Red"></asp:Label>
                           <br /> <br />
                    </td>
                </tr>
            </table>
        </owd:Window>
    
    </div>
    </form>
    
    <script type="text/javascript">
        function closeWindow()
        {
         try
		         {
		        
		        ChangePassword.Close();
		         }
		         catch(ex)
		         {
		            alert(ex.message);
		         }
        
        }
        
     
    </script>
</body>
</html>
