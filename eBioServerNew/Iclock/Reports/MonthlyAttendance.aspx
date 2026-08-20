<%@ page language="VB" autoeventwireup="false" inherits="Reports_MonthlyAttendance, App_Web_jj0rp3ex" enableEventValidation="false" %>


<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
    Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>
<%@ Register Assembly="obout_Window_NET" Namespace="OboutInc.Window" TagPrefix="owd" %>
<%@ Register TagPrefix="uctrl" Src="~/Header.ascx" TagName="header" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" >
<html>
<head id="Head1" runat="server">
    <title>Untitled Page</title>
    <link href="../StyleSheet.css" rel="stylesheet" type="text/css" />
</head>
<uctrl:header ID="Header1" runat="server" />
<body background="../Images/bck1.gif" style="background-repeat: no-repeat; background-position-x: right;
    background-position-y: top;">
    <form id="form1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <asp:UpdatePanel ID="UpdatePanel3" UpdateMode="Always" runat="server">
        <ContentTemplate>
            <table cellpadding="0" cellspacing="0" style="border-right: gray 1px solid; border-top: gray 1px solid;
                border-left: gray 1px solid; border-bottom: gray 1px solid;" runat="server" id="tblReport">
                <tr id="trHeader" style="font-weight: bold; font-size: 14px; background-color: lightsteelblue;
                    padding-left: 5px; padding-top: 3px; padding-bottom: 3px; color: white;">
                    <td style="font-weight: bold; font-size: 14px; background-color: lightsteelblue;
                        padding: 5px; color: white;">
                        Monthly Attendance Report
                    </td>
                    <td align="right">
                        <input id="btnDisplayReportForm" type="button" onclick="DisplayReportForm();" value="Regenerate Report" />&nbsp;
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <div style="">
                            <rsweb:ReportViewer ID="ReportViewer1" runat="server" BorderColor="Black" BackColor="White"
                                Font-Names="Verdana" Font-Size="8pt" InteractiveDeviceInfos="(Collection)" WaitMessageFont-Names="Verdana"
                                WaitMessageFont-Size="14pt" Width="100%" Height="100%" AsyncRendering="true"
                                SizeToReportContent="true">
                            </rsweb:ReportViewer>
                        </div>
                    </td>
                </tr>
            </table>

             <owd:Window ID="WndCommand0" runat="server" IsModal="true" Height="215" Width="350"
            StyleFolder="~/Styles/mainwindow/blue" Title="Monthly Attendance Report" VisibleOnLoad="true"
            ShowCloseButton="true" Left="350" Top="100" ShowStatusBar="False">

            
                <table class="rowEditTable" style="width:100%;" height="100%">
                    <tr>
                        <td>
                            <fieldset>
                                <table style="width:100%;">
                                    <tr>
                                        <td>
                                           From&nbsp;Date
                                        </td>
                                        <td width="100%" align="left">
                                        
                    
                                    <asp:DropDownList runat="server" ID="ddlFromDays" Width="40px">
                                            <asp:ListItem Value="01">1</asp:ListItem>
                                            <asp:ListItem Value="02">2</asp:ListItem>
                                            <asp:ListItem Value="03">3</asp:ListItem>
                                            <asp:ListItem Value="04">4</asp:ListItem>
                                            <asp:ListItem Value="05">5</asp:ListItem>
                                            <asp:ListItem Value="06">6</asp:ListItem>
                                            <asp:ListItem Value="07">7</asp:ListItem>
                                            <asp:ListItem Value="08">8</asp:ListItem>
                                            <asp:ListItem Value="09">9</asp:ListItem>
                                            <asp:ListItem Value="10">10</asp:ListItem>
                                            <asp:ListItem Value="11">11</asp:ListItem>
                                            <asp:ListItem Value="12">12</asp:ListItem>
                                            <asp:ListItem Value="13">13</asp:ListItem>
                                            <asp:ListItem Value="14">14</asp:ListItem>
                                            <asp:ListItem Value="15">15</asp:ListItem>
                                            <asp:ListItem Value="16">16</asp:ListItem>
                                            <asp:ListItem Value="17">17</asp:ListItem>
                                            <asp:ListItem Value="18">18</asp:ListItem>
                                            <asp:ListItem Value="19">19</asp:ListItem>
                                            <asp:ListItem Value="20">20</asp:ListItem>
                                            <asp:ListItem Value="21">21</asp:ListItem>
                                            <asp:ListItem Value="22">22</asp:ListItem>
                                            <asp:ListItem Value="23">23</asp:ListItem>
                                            <asp:ListItem Value="24">24</asp:ListItem>
                                            <asp:ListItem Value="25">25</asp:ListItem>
                                            <asp:ListItem Value="26">26</asp:ListItem>
                                            <asp:ListItem Value="27">27</asp:ListItem>
                                            <asp:ListItem Value="28">28</asp:ListItem>
                                            <asp:ListItem Value="29">29</asp:ListItem>
                                            <asp:ListItem Value="30">30</asp:ListItem>
                                            <asp:ListItem Value="31">31</asp:ListItem>
                                            </asp:DropDownList>
                                            -
                                            <asp:DropDownList runat="server" ID="ddlFromMonths" Width="50px">
                                            <asp:ListItem Text="Jan" Value="01"></asp:ListItem>
                                            <asp:ListItem Text="Feb" Value="02"></asp:ListItem>
                                            <asp:ListItem Text="Mar" Value="03"></asp:ListItem>
                                            <asp:ListItem Text="Apr" Value="04"></asp:ListItem>
                                            <asp:ListItem Text="May" Value="05"></asp:ListItem>
                                            <asp:ListItem Text="Jun" Value="06"></asp:ListItem>
                                            <asp:ListItem Text="Jul" Value="07"></asp:ListItem>
                                            <asp:ListItem Text="Aug" Value="08"></asp:ListItem>
                                            <asp:ListItem Text="Sep" Value="09"></asp:ListItem>
                                            <asp:ListItem Text="Oct" Value="10"></asp:ListItem>
                                            <asp:ListItem Text="Nov" Value="11"></asp:ListItem>
                                            <asp:ListItem Text="Dec" Value="12"></asp:ListItem>

                                            </asp:DropDownList>
                                            -   <asp:DropDownList ID="ddlFromYears" runat="server" AutoPostBack="false" Width="70px">
                        
                    </asp:DropDownList>
                                        </td>
                                    </tr>


                                     <tr>
                                        <td>
                                           To&nbsp;Date
                                        </td>
                                        <td width="100%" align="left">
                                        
                    
                                    <asp:DropDownList runat="server" ID="ddlToDays" Width="40px">
                                            <asp:ListItem Value="01">1</asp:ListItem>
                                            <asp:ListItem Value="02">2</asp:ListItem>
                                            <asp:ListItem Value="03">3</asp:ListItem>
                                            <asp:ListItem Value="04">4</asp:ListItem>
                                            <asp:ListItem Value="05">5</asp:ListItem>
                                            <asp:ListItem Value="06">6</asp:ListItem>
                                            <asp:ListItem Value="07">7</asp:ListItem>
                                            <asp:ListItem Value="08">8</asp:ListItem>
                                            <asp:ListItem Value="09">9</asp:ListItem>
                                            <asp:ListItem Value="10">10</asp:ListItem>
                                            <asp:ListItem Value="11">11</asp:ListItem>
                                            <asp:ListItem Value="12">12</asp:ListItem>
                                            <asp:ListItem Value="13">13</asp:ListItem>
                                            <asp:ListItem Value="14">14</asp:ListItem>
                                            <asp:ListItem Value="15">15</asp:ListItem>
                                            <asp:ListItem Value="16">16</asp:ListItem>
                                            <asp:ListItem Value="17">17</asp:ListItem>
                                            <asp:ListItem Value="18">18</asp:ListItem>
                                            <asp:ListItem Value="19">19</asp:ListItem>
                                            <asp:ListItem Value="20">20</asp:ListItem>
                                            <asp:ListItem Value="21">21</asp:ListItem>
                                            <asp:ListItem Value="22">22</asp:ListItem>
                                            <asp:ListItem Value="23">23</asp:ListItem>
                                            <asp:ListItem Value="24">24</asp:ListItem>
                                            <asp:ListItem Value="25">25</asp:ListItem>
                                            <asp:ListItem Value="26">26</asp:ListItem>
                                            <asp:ListItem Value="27">27</asp:ListItem>
                                            <asp:ListItem Value="28">28</asp:ListItem>
                                            <asp:ListItem Value="29">29</asp:ListItem>
                                            <asp:ListItem Value="30">30</asp:ListItem>
                                            <asp:ListItem Value="31">31</asp:ListItem>
                                            </asp:DropDownList>
                                            -
                                            <asp:DropDownList runat="server" ID="ddlToMonths" Width="50px">
                                            <asp:ListItem Text="Jan" Value="01"></asp:ListItem>
                                            <asp:ListItem Text="Feb" Value="02"></asp:ListItem>
                                            <asp:ListItem Text="Mar" Value="03"></asp:ListItem>
                                            <asp:ListItem Text="Apr" Value="04"></asp:ListItem>
                                            <asp:ListItem Text="May" Value="05"></asp:ListItem>
                                            <asp:ListItem Text="Jun" Value="06"></asp:ListItem>
                                            <asp:ListItem Text="Jul" Value="07"></asp:ListItem>
                                            <asp:ListItem Text="Aug" Value="08"></asp:ListItem>
                                            <asp:ListItem Text="Sep" Value="09"></asp:ListItem>
                                            <asp:ListItem Text="Oct" Value="10"></asp:ListItem>
                                            <asp:ListItem Text="Nov" Value="11"></asp:ListItem>
                                            <asp:ListItem Text="Dec" Value="12"></asp:ListItem>

                                            </asp:DropDownList>
                                            -   <asp:DropDownList ID="ddlToYears" runat="server" AutoPostBack="false" Width="70px">
                        
                    </asp:DropDownList>
                                        </td>
                                    </tr>


                                    <tr>
                                    <td>Attendance&nbsp;Location</td>
                                    <td align=left>
                                     <asp:DropDownList ID="drpLocation"  Width="175px" runat="server">
                                    </asp:DropDownList>
                                    </td>
                                    </tr>
                                     <tr>
                                    <td>Employee&nbsp;Code</td>
                                    <td align=left><asp:TextBox ID="txt_Employeecode" runat="server" CssClass="WebControls" Width="175px"></asp:TextBox></td>
                                    </tr>
<tr>
                                    <td>Report&nbsp;Type</td>
                                    <td align=left>
                                    
                                     <asp:DropDownList runat="server" ID="drpReportType" Width="185px">
                                            <asp:ListItem Text="Monthly Basic Attendance" Value="Daily Basic Attendance"></asp:ListItem>
                                            <asp:ListItem Text="Monthly Detailed Attendance" Value="Daily Detailed Attendance"></asp:ListItem>
                                            </asp:DropDownList>
                                    </td>
                                    </tr>
<tr>
                                    <td>Group&nbsp;By</td>
                                    <td align=left>
                                     <asp:DropDownList runat="server" ID="drpGroupBy" Width="175px">
                                            <asp:ListItem Text="Department" Value="Department"></asp:ListItem>
                                            <asp:ListItem Text="Designation" Value="Designation"></asp:ListItem>
                                            </asp:DropDownList>
                                    </td>
                                    </tr>

                                </table>
                            </fieldset>
                        </td>
                    </tr>
                    <tr>
                        <td align="right">
                            <asp:Label ID="hiddenThreadId" Visible="false" runat="server" Text=""></asp:Label>
                            <asp:Timer ID="Timer1" OnTick="Timer1_Tick" runat="server" Enabled="false" /> 
                           <asp:Label runat="server" ForeColor="red" EnableViewState="false" Text=""
                                        ID="Lbl_InvalidError"></asp:Label><asp:Label ID="Label1" runat="server" Text=""></asp:Label>
                            <asp:Button ID="btnOk" runat="server" Text="Generate Report" />&nbsp;
                        </td>
                    </tr>
                    
                </table>
                 
            </owd:Window>
        </ContentTemplate>
    </asp:UpdatePanel>
    </form>
    <script type="text/javascript">


        function DisplayReportForm() {

            try {
                WndCommand0.Open();
            }
            catch (ex) {
                alert(ex);
            }


        }   

    </script>
</body>
</html>
