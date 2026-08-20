<%@ page language="VB" autoeventwireup="false" inherits="Utilities_Webhook, App_Web_h00j2pts" enableEventValidation="false" %>

<%@ Register Assembly="obout_Window_NET" Namespace="OboutInc.Window" TagPrefix="owd" %>
<%@ Register TagPrefix="uctrl" Src="~/Header.ascx" TagName="header" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" >
<html >
<head id="Head1" runat="server">
    <title>Untitled Page</title>
    <link href="../StyleSheet.css" rel="stylesheet" type="text/css" />
</head>
   <uctrl:header ID="Header1" runat="server" />
<body>
    <form id="form1" runat="server">
        <div>
            <uctrl:header ID="MyHeader" runat="server" />
            <owd:Window ID="Wnd_Webhook" runat="server" Height="240" Width="430"
                StyleFolder="~/Styles/mainwindow/blue" Title="Webhook (Post Logs)" ShowCloseButton="false"
                ShowStatusBar="False" Left="250" Top="25">
                <table class="rowEditTable" width="100%" cellpadding="1" style="border-top-style: none;
                    border-right-style: none; border-left-style: none; border-bottom-style: none;
                    height: 100%">
                    <tr>
                        <td>
                            <fieldset>
                                <legend>
                                    <asp:CheckBox ID="chk_IsWebhookEnabled" 
                                        Text=" Enable Webhook" runat="server" /></legend>
                                <table >
                                    
                                    
                                    <tr>
                                        <td style="font-weight: bold;">
                                            Webhook Type</td>
                                        <td>
                                            <asp:DropDownList ID="drpWebhookType" runat="server" AutoPostBack="true">
                                                <asp:ListItem Text="Default" Value="Default" Selected="True" />
                                                <asp:ListItem Text="Bayzat" Value="Bayzat" />


                                            </asp:DropDownList>
                                        </td>
                                        
                                    </tr>

                                    <tr>
                                        <td style="font-weight: bold;">
                                            Webhook Post URL</td>
                                        <td>
                                            <asp:TextBox ID="txt_URL" runat="server" Width="250px"></asp:TextBox>
                                        </td>
                                        
                                    </tr>
                                   
                                    <tr runat="server" id="trResponse">
                                        <td style="font-weight: bold;">
                                            Webhook Response</td>
                                        <td>
                                            <asp:TextBox ID="txtWebhookResponse" runat="server" Width="250px"></asp:TextBox>
                                        </td>
                                        
                                    </tr>
                                   
                                     <tr runat="server" id="trAPIKey">
                                        <td style="font-weight: bold;">
                                            Webhook API Key</td>
                                        <td>
                                            <asp:TextBox ID="txtWebhookAPIKey" runat="server" Width="250px"></asp:TextBox>
                                        </td>
                                        
                                    </tr>
                                   
                                    <tr  runat="server" id="trEncryption">
                                        <td >
                                            Enable&nbsp;Encryption
                                            </td>
                                        <td >
                                            <asp:DropDownList ID="drpEnableEncryption" Width="100px" runat="server">
                                                <asp:ListItem Text="Yes" Value="1" />
                                                <asp:ListItem Text="No" Value="0" />

                                            </asp:DropDownList>
                                            Password
                                            <asp:TextBox ID="txt_Password" TextMode="Password" runat="server" Width="90px"></asp:TextBox>
                                        </td>
                                    </tr>


                                    <tr>
                                        <td style="font-weight: bold;">
                                            No.&nbsp;of&nbsp;Logs</td>
                                        <td colspan="5">
                                            <asp:TextBox ID="txt_BatchSize" runat="server" Width="100px">100</asp:TextBox>&nbsp;Batch&nbsp;size&nbsp;per&nbspPost
                                        </td>
                                    </tr>
                              

                                    <tr>
                                    <td colspan="2"><b>Last Sync Log Date</b> (yyyy-MM-dd)&nbsp;<asp:TextBox ID="txt_LastSyncDate" runat="server" Width="142px"></asp:TextBox>&nbsp;<asp:Button
                                        ID="Btn_Reset" Width="50px" runat="server" Text="Reset" /></td>
                                    </tr>

                                </table>
                            </fieldset>
                        </td>
                        </tr>
                        <tr>
                         <td align="right"><asp:Label ID="Lbl_Error" runat="server" EnableViewState="False" Text="&nbsp;" ForeColor="Red"></asp:Label>
                                        <asp:Button ID="Btn_Save" runat="server" Text="Save" />&nbsp;
                                        <input id="btn_Cancel" type="button" value="Close" onclick="Wnd_Webhook.Close();" />&nbsp;&nbsp;
                                    </td>
                    </tr>
                    
                   
                </table>
            </owd:Window>
        </div>
    </form>

     

</body>
</html>

