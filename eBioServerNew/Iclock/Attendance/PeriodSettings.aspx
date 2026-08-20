<%@ page language="VB" autoeventwireup="false" inherits="Attendance_PeriodSettings, App_Web_haagzrto" enableEventValidation="false" %>

    <%@ Register TagPrefix="uctrl" Src="~/Header.ascx" TagName="header" %>

<%@ Register TagPrefix="owd" Namespace="OboutInc.window" Assembly="obout_Window_NET" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" >
<html >
<head id="Head1" runat="server">
    <title></title>
    <link href="../StyleSheet.css" rel="stylesheet" type="text/css" />
</head>

         <uctrl:header ID="Header1" runat="server" />

<body background="../Images/bck1.gif"
    style="background-repeat: no-repeat; background-position-x: right; background-position-y: top;">
    
    <form id="form1" runat="server">
        &nbsp;<owd:Window ID="PeriodSettingsDialog" runat="server" IsModal="true" Height="315" 
            Width="800" StyleFolder="~/Styles/mainwindow/blue" Title="Period Settings"
             ShowCloseButton="false" ShowStatusBar="False" Left="50"  
            Top="50" Visible="False" VisibleOnLoad="False">

      <uctrl:header ID="MyHeader" runat="server" />

            <table width="100%" cellpadding="1" class="Table" style="border-top-style: none;
                border-right-style: none; border-left-style: none; border-bottom-style: none;">
                <tr>
                    <td>
                        <fieldset style="width: 760px;">
                            <legend>Period 1 Settings</legend>
                            <table style="width:100%;">
                                <tr>
                                    <td style="width: 80px;" align="left">
                                        Period&nbsp;1&nbsp;Name
                                    </td>
                                    <td colspan=5>
                                        <asp:TextBox ID="txtPeriod1Name" Width="175px" runat="server"></asp:TextBox>
                                        <asp:CheckBox ID="chkPeriod1Enabled" Text="Enabled" Checked runat="server" />
                                    </td>
                                </tr>

                                <tr>
                                    <td style="width: 80px;" align="left">
                                        Period&nbsp;1&nbsp;Begins&nbsp;At&nbsp;
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtPeriod1BeginTime" Width="50px" runat="server"></asp:TextBox>&nbsp;(HH:mm)&nbsp;
                                    </td>

                                    <td style="width: 80px;" align="left">
                                        Period&nbsp;1&nbsp;Ends&nbsp;At&nbsp;
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtPeriod1EndTime" Width="50px" runat="server"></asp:TextBox>&nbsp;(HH:mm)&nbsp;
                                    </td>

                                    
                                    <td style="width: 80px;" align="left">
                                        Period&nbsp;1&nbsp;Duration&nbsp;
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtPeriod1Duration" Width="50px" runat="server"></asp:TextBox>&nbsp;(Minutes)
                                    </td>


                                </tr>


                               
                            </table>
                        </fieldset>
                    </td>
                </tr>


                
 <tr>
                    <td>
                        <fieldset style="width: 760px;">
                            <legend>Period 2 Settings</legend>
                            <table style="width:100%;">
                                <tr>
                                    <td style="width: 80px;" align="left">
                                        Period&nbsp;2&nbsp;Name
                                    </td>
                                    <td colspan=5>
                                        <asp:TextBox ID="txtPeriod2Name" Width="175px" runat="server"></asp:TextBox>
                                        <asp:CheckBox ID="chkPeriod2Enabled" Text="Enabled" Checked runat="server" />
                                    </td>
                                </tr>

                                <tr>
                                    <td style="width: 80px;" align="left">
                                        Period&nbsp;2&nbsp;Begins&nbsp;At&nbsp;
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtPeriod2BeginTime" Width="50px" runat="server"></asp:TextBox>&nbsp;(HH:mm)&nbsp;
                                    </td>

                                    <td style="width: 80px;" align="left">
                                        Period&nbsp;2&nbsp;Ends&nbsp;At&nbsp;
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtPeriod2EndTime" Width="50px" runat="server"></asp:TextBox>&nbsp;(HH:mm)&nbsp;
                                    </td>

                                    
                                    <td style="width: 80px;" align="left">
                                        Period&nbsp;2&nbsp;Duration&nbsp;
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtPeriod2Duration" Width="50px" runat="server"></asp:TextBox>&nbsp;(Minutes)
                                    </td>


                                </tr>


                               
                            </table>
                        </fieldset>
                    </td>
                </tr>


 <tr>
                    <td>
                        <fieldset style="width: 760px;">
                            <legend>Period 3 Settings</legend>
                            <table style="width:100%;">
                                <tr>
                                    <td style="width: 80px;" align="left">
                                        Period&nbsp;3&nbsp;Name
                                    </td>
                                    <td colspan=5>
                                        <asp:TextBox ID="txtPeriod3Name" Width="175px" runat="server"></asp:TextBox>
                                        <asp:CheckBox ID="chkPeriod3Enabled" Text="Enabled" Checked runat="server" />
                                    </td>
                                </tr>

                                <tr>
                                    <td style="width: 80px;" align="left">
                                        Period&nbsp;3&nbsp;Begins&nbsp;At&nbsp;
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtPeriod3BeginTime" Width="50px" runat="server"></asp:TextBox>&nbsp;(HH:mm)&nbsp;
                                    </td>

                                    <td style="width: 80px;" align="left">
                                        Period&nbsp;3&nbsp;Ends&nbsp;At&nbsp;
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtPeriod3EndTime" Width="50px" runat="server"></asp:TextBox>&nbsp;(HH:mm)&nbsp;
                                    </td>

                                    
                                    <td style="width: 80px;" align="left">
                                        Period&nbsp;3&nbsp;Duration&nbsp;
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtPeriod3Duration" Width="50px" runat="server"></asp:TextBox>&nbsp;(Minutes)
                                    </td>


                                </tr>


                               
                            </table>
                        </fieldset>
                    </td>
                </tr>

                    <tr>                                                      
                                    <td align=right><asp:Label ID="Lbl_Error" runat="server" Style="background-color: #EEEEEE;" Visible="False"
                                EnableViewState="False" ForeColor="Red"></asp:Label>
                                       <asp:Button ID="Btn_Save" runat="server" Text="Save"  />
                                        <input id="btn_Cancel" type="button" value="Close" onclick="PeriodSettingsDialog.Close();" />&nbsp;&nbsp;
                        </td>
                    </tr>
                    
            </table>
        </owd:Window>
        
       
    </form>


</body>
</html>
