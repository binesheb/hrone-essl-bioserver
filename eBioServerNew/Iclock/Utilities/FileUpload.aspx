<%@ page language="VB" autoeventwireup="false" inherits="Utilities_FileUpload, App_Web_h00j2pts" enableEventValidation="false" %>


<%@ Register Assembly="obout_Window_NET" Namespace="OboutInc.Window" TagPrefix="owd" %>
<%@ Register TagPrefix="uctrl" Src="~/Header.ascx" TagName="header" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" >
<html >
<head id="Head1" runat="server">
    <title>Untitled Page</title>
    <link href="../StyleSheet.css" rel="stylesheet" type="text/css" />
</head>
   <uctrl:header ID="Header1" runat="server" />
<body >
    <form id="form1" runat="server">
        <div>
            <uctrl:header ID="MyHeader" runat="server" />
            <owd:Window ID="Wnd_FileUpload" runat="server" Height="240" Width="470"
                StyleFolder="~/Styles/mainwindow/blue" Title="FTP/WebDav Punch Logs Upload" ShowCloseButton="false"
                ShowStatusBar="False" Left="250" Top="25">
                <table class="rowEditTable" width="100%" cellpadding="1" style="border-top-style: none;
                    border-right-style: none; border-left-style: none; border-bottom-style: none;
                    height: 100%">
                    <tr>
                        <td>
                            <fieldset>
                                <legend>
                                    <asp:CheckBox ID="chk_FileUpload" 
                                        Text=" Enable FTP/WebDav Upload" runat="server" /></legend>
                                <table >

                                    <tr>
                                    <td  style="font-weight: bold;">Upload To</td>
<td>
    <asp:RadioButtonList ID="rdlType" RepeatDirection=Horizontal runat="server">
    <asp:ListItem Text="FTP" Value="FTP" Selected />
    <asp:ListItem Text="WebDav" Value="WebDav" />
    </asp:RadioButtonList>  </td>
<td>File Name</td>
<td>
    <asp:DropDownList Width="142px" ID="drpFileFormat" runat="server">
    <asp:ListItem Text="dd_MM_yyyy.csv" Value="dd_MM_yyyy.csv" Selected />
    </asp:DropDownList>
</td>

                                    </tr>
                                    <tr>
                                        <td style="font-weight: bold;">
                                            Host&nbsp;Address</td>
                                        <td style="">
                                            <asp:TextBox ID="txt_Host" runat="server" Width="142px"></asp:TextBox>
                                        </td>
                                        <td style="">
                                            Port</td>
                                        <td style="">
                                            <asp:TextBox ID="txt_Port" runat="server" Width="142px"></asp:TextBox></td>
                                       
                                    </tr>
                                    <tr>
                                        <td style="font-weight: bold;">
                                            User Name</td>
                                        <td>
                                            <asp:TextBox ID="txt_UserName" runat="server" Width="142px"></asp:TextBox>
                                        </td>
                                        <td  style="font-weight: bold;">
                                           Password
                                            
                                        </td>
                                        <td ><asp:TextBox ID="txt_Password" TextMode="Password" runat="server" Width="142px"></asp:TextBox>
                                        <asp:TextBox ID="txt_Password1" runat="server" Width="0px" Visible=false></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                           Directory</td>
                                        <td>
                                            <asp:TextBox ID="txt_Directory" runat="server" Width="142px"></asp:TextBox>
                                        </td>
                                        <td >
                                            Run At
                                            </td>
                                        <td >                                        
                                            <asp:DropDownList ID="drpHour" Width="45px" runat="server">
                                            </asp:DropDownList>
                                            <asp:DropDownList ID="drpMinute"  Width="45px"  runat="server">
                                            </asp:DropDownList>
                                            (HH:MM)
                                        </td>
                                    </tr>
                                   
                                   

                                    <tr>
                                    <td colspan="4"><b>Last Sync Log Date</b> (yyyy-MM-dd)&nbsp;<asp:TextBox ID="txt_LastSyncDate" runat="server" Width="142px"></asp:TextBox>&nbsp;<asp:Button
                                        ID="Btn_Reset" Width="50px" runat="server" Text="Reset" /></td>
                                    </tr>

                                </table>
                            </fieldset>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <table style="width:100%;">
                                <tr>
                                    <td align="left" style="width: 220px">
                                        <asp:Button ID="btn_TestConnection" runat="server" Text="Test Connection" />
                                    </td>
                                    <td align="right" style="text-align: right;">
                                        <asp:Button ID="Btn_Save" runat="server" Text="Save" />&nbsp;&nbsp;
                                        <input id="btn_Cancel" type="button" value="Close" onclick="Wnd_FileUpload.Close();" />&nbsp;&nbsp;
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="Lbl_Error" runat="server" EnableViewState="False" Text="&nbsp;" ForeColor="Red"></asp:Label>
                        </td>
                    </tr>
                    <tr><td><br /><br /><br /></td></tr>
                </table>
            </owd:Window>
        </div>
    </form>

 

</body>
</html>

