<%@ page language="VB" autoeventwireup="false" inherits="Main, App_Web_ryzztc04" enableEventValidation="false" %>
<%@ Register Assembly="obout_Splitter2_Net" Namespace="OboutInc.Splitter2" TagPrefix="obspl" %>
<%@ Register TagPrefix="oajax" Namespace="OboutInc" Assembly="obout_AJAXPage" %>
<%@ Register TagPrefix="oem" Namespace="OboutInc.EasyMenu_Pro" Assembly="obout_EasyMenu_Pro" %>
<%@ Register TagPrefix="owd" Namespace="OboutInc.Window" Assembly="obout_Window_NET" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" >
<html >
<head id="Head1" runat="server">
    <title>eBio Server Online</title>
    <link href="StyleSheet.css" rel="stylesheet" type="text/css" />
</head>
<body onload="javascript:SelectMenuItem('Dashboard.aspx');" style="margin: 0; padding: 0;
    height: 100%; width: 100%; overflow: hidden;">
    <form id="form1" runat="server">
        <table cellpadding="0" cellspacing="0" style="">
            <tr style="font-size: 0;">
                <td style="width: 403px; height: 85px;">
                    <img alt="Logo" src="images/logo.gif" border="0" />
                </td>
                <td align="right" width="100%">
                    <img alt="Top Header Image" src="images/tophimg.gif" border="0" />
                </td>
            </tr>
            <tr style="background-image: url(Images/mid.gif); background-repeat: repeat-x;">
                <td colspan="2" style="height: 13px">
                    <oem:EasyMenu ID="EasymenuMain" IconsFolder="MenuIcons" UseIcons="true" runat="server"
                        ShowEvent="Always" StyleFolder="styles/EasyMenu/Styles/horizontal1" Position="Horizontal"
                        CSSMenu="ParentMenu" CSSMenuItemContainer="ParentItemContainer" IconsPosition="Left">
                        <CSSClassesCollection>
                            <oem:CSSClasses ObjectType="OboutInc.EasyMenu_Pro.MenuItem" ComponentSubMenuCellOver="ParentItemSubMenuCellOver"
                                ComponentContentCell="ParentItemContentCell" Component="ParentItem" ComponentSubMenuCell="ParentItemSubMenuCell"
                                ComponentIconCellOver="ParentItemIconCellOver" ComponentIconCell="ParentItemIconCell"
                                ComponentOver="ParentItemOver" ComponentContentCellOver="ParentItemContentCellOver">
                            </oem:CSSClasses>
                            <oem:CSSClasses ObjectType="OboutInc.EasyMenu_Pro.MenuSeparator" ComponentSubMenuCellOver="ParentSeparatorSubMenuCellOver"
                                ComponentContentCell="ParentSeparatorContentCell" Component="ParentSeparator"
                                ComponentSubMenuCell="ParentSeparatorSubMenuCell" ComponentIconCellOver="ParentSeparatorIconCellOver"
                                ComponentIconCell="ParentSeparatorIconCell" ComponentOver="ParentSeparatorOver"
                                ComponentContentCellOver="ParentSeparatorContentCellOver"></oem:CSSClasses>
                        </CSSClassesCollection>
                        <Components>
                             <oem:MenuItem OnClientClick="javascript:SelectMenuItem('Dashboard.aspx');"
                                InnerHtml="&nbsp;Dashboard&nbsp;" ID="MenuItem4">
                            </oem:MenuItem>
                            <oem:MenuSeparator InnerHtml="|" ID="MenuSeparator4">
                            </oem:MenuSeparator>
                          
                            <oem:MenuItem InnerHtml="&nbsp;Access&nbsp;Control&nbsp;" ID="DeviceManagement">
                            </oem:MenuItem>

                            
                            <oem:MenuSeparator Visible=true  InnerHtml="|" ID="MenuSeparatorAttendance1">
                            </oem:MenuSeparator>
                          

                            <oem:MenuItem Visible=true InnerHtml="&nbsp;Attendance&nbsp;" ID="MenuAttendanceManagement">
                            </oem:MenuItem>

                              <oem:MenuSeparator Visible=true  InnerHtml="|" ID="MenuSeparator8">
                            </oem:MenuSeparator>
                          

                            <oem:MenuItem Visible=true InnerHtml="&nbsp;Payroll&nbsp;" ID="MenuPayrollManagement">
                            </oem:MenuItem>

                            <oem:MenuSeparator Visible=true  InnerHtml="|" ID="MenuSeparator7">
                            </oem:MenuSeparator>
                          

                            <oem:MenuItem Visible=true InnerHtml="&nbsp;Vistor&nbsp;" ID="MenuVisitorManagement">
                            </oem:MenuItem>
                           

                            <oem:MenuSeparator InnerHtml="|" ID="MenuSeparatorAttendance2">
                            </oem:MenuSeparator>
                           
                           <oem:MenuItem InnerHtml="&nbsp;Reports&nbsp;" ID="MenuReports">
                            </oem:MenuItem>

                            <oem:MenuSeparator InnerHtml="|" ID="MenuSeparator2">
                            </oem:MenuSeparator>
                           
                           <oem:MenuItem InnerHtml="&nbsp;Utilities&nbsp;" ID="Utilities">
                            </oem:MenuItem>

                             <oem:MenuSeparator InnerHtml="|" ID="MenuSeparator6">
                            </oem:MenuSeparator>

                           <oem:MenuItem InnerHtml="&nbsp;Admin&nbsp;" ID="MenuAdmin">
                            </oem:MenuItem>



                            <oem:MenuSeparator InnerHtml="|" ID="MenuSeparator27">
                            </oem:MenuSeparator>
                            
                            <oem:MenuItem OnClientClick="javascript:SelectMenuItem('Admin/ChangePassword.aspx');"
                                InnerHtml="&nbsp;Change Password&nbsp;" ID="Admin_ChangePassword">
                            </oem:MenuItem>
                            <oem:MenuSeparator InnerHtml="|" ID="MenuSeparator1">
                            </oem:MenuSeparator>

                             <oem:MenuItem OnClientClick="javascript:SelectMenuItem('AboutUs.aspx');"
                                InnerHtml="&nbsp;License&nbsp;" ID="MenuItem3">
                            </oem:MenuItem>


                            


                            <oem:MenuSeparator InnerHtml="|" ID="MenuSeparator5">
                            </oem:MenuSeparator>

                            <oem:MenuItem OnClientClick="window.parent.location.href='LogOut.aspx'" InnerHtml="&nbsp;Log Off&nbsp;&nbsp;&nbsp;"
                                ID="LogOff1">
                            </oem:MenuItem>
                            <oem:MenuSeparator InnerHtml="|" ID="MenuSeparator3">
                            </oem:MenuSeparator>


                        </Components>
                    </oem:EasyMenu>
                    <!--// The menus //-->
                    <oem:EasyMenu ID="Easymenu4" runat="server" ShowEvent="MouseOver" AttachTo="DeviceManagement"
                        UseIcons="true" IconsFolder="MenuIcons" IconsPosition="Left" Align="Under" OffsetVertical="-2"
                        Width="223" StyleFolder="styles/horizontal1">
                        <Components>
                            <oem:MenuItem OnClientClick="javascript:SelectMenuItem('Manage/Locations.aspx');"
                               InnerHtml="Location List" ID="MenuItem40" Icon="a_c.gif">
                            </oem:MenuItem>

                            <oem:MenuItem OnClientClick="javascript:SelectMenuItem('Manage/Employees.aspx');"
                                InnerHtml="Employee List" ID="MenuItem2" Icon="deviceOpLog.gif">
                            </oem:MenuItem>
                            <oem:MenuItem OnClientClick="javascript:SelectMenuItem('Manage/Devices.aspx');" InnerHtml="Device List"
                                ID="MenuItem17" Icon="Device.gif">
                            </oem:MenuItem>
                            <oem:MenuItem OnClientClick="javascript:SelectMenuItem('Manage/DeviceCommands.aspx');"
                                InnerHtml="Device Commands" ID="MenuItem74" Icon="deviceOpLog.gif">
                            </oem:MenuItem>
                            <oem:MenuItem OnClientClick="javascript:SelectMenuItem('Manage/DeviceLogs.aspx');"
                                InnerHtml="Device Logs" ID="MenuItem19" Icon="logs.gif">
                            </oem:MenuItem>
                            <oem:MenuItem OnClientClick="javascript:SelectMenuItem('Manage/DeviceLogsillegal.aspx');"
                                InnerHtml="Device Logs (illegal)" ID="MenuItem7" Icon="logs.gif">
                            </oem:MenuItem>
                            <oem:MenuItem OnClientClick="javascript:SelectMenuItem('Manage/DeviceOPLogs.aspx');"
                                InnerHtml="Device OP Logs" ID="MenuItem46" Icon="report.gif">
                            </oem:MenuItem>


                            
                            
                            <%--  
                         
                          <oem:MenuItem OnClientClick="javascript:SelectMenuItem('Manage/EmployeeDeviceLogs.aspx');"
                                InnerHtml="Employee Device Logs" ID="MenuItem19" Icon="logs.gif">
                            </oem:MenuItem>
                          
                            <oem:MenuItem OnClientClick="javascript:SelectMenuItem('Manage/DeviceLogList1.aspx');"
                                InnerHtml="Device Log List1" ID="MenuItem96" Icon="deviceOpLog.gif">
                            </oem:MenuItem>--%>
                            <%--<oem:MenuItem OnClientClick="javascript:SelectMenuItem('Manage/DeviceGreetings.aspx');"
                                InnerHtml="Device Greetings" ID="MenuItem83" Icon="deviceOpLog.gif">
                            </oem:MenuItem>--%>
                        </Components>
                    </oem:EasyMenu>


                     <oem:EasyMenu Visible="true" ID="EasymenuAttendance" runat="server" ShowEvent="MouseOver" AttachTo="MenuAttendanceManagement"
                        UseIcons="true" IconsFolder="MenuIcons" IconsPosition="Left" Align="Under" OffsetVertical="-2"
                        Width="223" StyleFolder="styles/horizontal1">
                        <Components>
                            <oem:MenuItem OnClientClick="javascript:SelectMenuItem('Attendance/Company.aspx');"
                                InnerHtml="Company Settings" ID="MenuItem8" Icon="a_c.gif">
                            </oem:MenuItem>

                             <oem:MenuItem OnClientClick="javascript:SelectMenuItem('Attendance/Employees.aspx');"
                                InnerHtml="Employees" ID="MenuItem18" Icon="a_b.gif">
                            </oem:MenuItem>
                           

                             <oem:MenuItem OnClientClick="javascript:SelectMenuItem('Attendance/Holidays.aspx');"
                                InnerHtml="Holidays" ID="MenuItem10" Icon="b_g.gif">
                            </oem:MenuItem>
                             <oem:MenuItem OnClientClick="javascript:SelectMenuItem('Attendance/LeaveTypes.aspx');"
                                InnerHtml="Leave Types" ID="MenuItem11" Icon="b_d.gif">
                            </oem:MenuItem>

                             <oem:MenuItem OnClientClick="javascript:SelectMenuItem('Attendance/ShiftTypes.aspx');"
                                InnerHtml="Shift Types" ID="MenuItem12" Icon="b_c.gif">
                            </oem:MenuItem>
                             <oem:MenuItem OnClientClick="javascript:SelectMenuItem('Attendance/ShiftSchedule.aspx');"
                                InnerHtml="Shift Schedule" ID="MenuItem13" Icon="c_b.gif">
                            </oem:MenuItem>


                            
                             <oem:MenuItem OnClientClick="javascript:SelectMenuItem('Attendance/PeriodSettings.aspx');"
                                InnerHtml="Period Settings" ID="MenuItem38" Icon="oTasks.gif">
                            </oem:MenuItem>

                             <oem:MenuItem OnClientClick="javascript:SelectMenuItem('Attendance/Leaves.aspx');"
                                InnerHtml="Leave Records" ID="MenuItem14" Icon="leave.gif">
                            </oem:MenuItem>
                             <oem:MenuItem OnClientClick="javascript:SelectMenuItem('Attendance/OutDuties.aspx');"
                                InnerHtml="Out Duty Records" ID="MenuItem15" Icon="c_c.gif">
                            </oem:MenuItem>
                            <oem:MenuItem OnClientClick="javascript:SelectMenuItem('Attendance/CompOffs.aspx');"
                                InnerHtml="Comp Off Records" ID="MenuItem27" Icon="holiday.gif">
                            </oem:MenuItem>

                            
                             <oem:MenuItem OnClientClick="javascript:SelectMenuItem('Attendance/SelectLocation.aspx?Page=AttendanceRegister');"
                                InnerHtml="Attendance Register" ID="MenuItem9" Icon="attregister.gif">
                            </oem:MenuItem>
                           
                            
                          
                        </Components>
                    </oem:EasyMenu>

              
                    <oem:EasyMenu ID="Easymenu5" runat="server" ShowEvent="MouseOver" AttachTo="Utilities"
                        UseIcons="true" IconsFolder="MenuIcons" IconsPosition="Left" Align="Under" OffsetVertical="-2"
                        Width="250" StyleFolder="styles/horizontal1">
                        <Components>
                            <oem:MenuItem OnClientClick="javascript:SelectMenuItem('Utilities/ImportEmployees.aspx');"
                                InnerHtml="Import Employees (Access Control)" ID="MenuItem20" Icon="import.gif">
                            </oem:MenuItem>
                            <oem:MenuItem OnClientClick="javascript:SelectMenuItem('Utilities/ExportEmployees.aspx');"
                                InnerHtml="Export Employees (Access Control)" ID="MenuItem22" Icon="export.gif">
                            </oem:MenuItem>
                            <oem:MenuItem OnClientClick="javascript:SelectMenuItem('Utilities/ImportAttendanceEmployees.aspx');"
                                InnerHtml="Import Employees (Attendance)" ID="MenuItem32" Icon="import.gif">
                            </oem:MenuItem>
                            <oem:MenuItem OnClientClick="javascript:SelectMenuItem('Utilities/ExportAttendanceEmployees.aspx');"
                                InnerHtml="Export Employees (Attendance)" ID="MenuItem33" Icon="export.gif">
                            </oem:MenuItem>
                            
                            <oem:MenuItem OnClientClick="javascript:SelectMenuItem('Utilities/ImportEmployeesShiftSchedule.aspx');"
                                InnerHtml="Import Employees Shift Schedule" ID="MenuItem34" Icon="import.gif">
                            </oem:MenuItem>
                            <oem:MenuItem OnClientClick="javascript:SelectMenuItem('Utilities/ExportEmployeesShiftSchedule.aspx');"
                                InnerHtml="Export Employees Shift Schedule" ID="MenuItem35" Icon="export.gif">
                            </oem:MenuItem>

                            <oem:MenuItem OnClientClick="javascript:SelectMenuItem('Utilities/ImportLeaveLimits.aspx');"
                                InnerHtml="Import Leave Limits" ID="MenuItem37" Icon="export.gif">
                            </oem:MenuItem>

                            <oem:MenuItem OnClientClick="javascript:SelectMenuItem('Utilities/ExportLeaveLimits.aspx');"
                                InnerHtml="Export Leave Limits" ID="MenuItem36" Icon="import.gif">
                            </oem:MenuItem>


                            <oem:MenuItem OnClientClick="javascript:SelectMenuItem('Utilities/ImportDevices.aspx');"
                                InnerHtml="Import Devices" ID="MenuItem25" Icon="import.gif">
                            </oem:MenuItem>

                            <oem:MenuItem OnClientClick="javascript:SelectMenuItem('Utilities/ExportDevices.aspx');"
                                InnerHtml="Export Devices" ID="MenuItem5" Icon="export.gif">
                            </oem:MenuItem>

                             <oem:MenuItem OnClientClick="javascript:SelectMenuItem('Utilities/ExportLogs.aspx');"
                                InnerHtml="Export Logs" ID="MenuItem6" Icon="export.gif">
                            </oem:MenuItem>

                            <oem:MenuItem OnClientClick="javascript:SelectMenuItem('Utilities/ParallelDataExport.aspx');"
                                InnerHtml="Parallel Logs Export" ID="MenuItem77" Icon="export.gif">
                            </oem:MenuItem>

                             <oem:MenuItem OnClientClick="javascript:SelectMenuItem('Utilities/Webhook.aspx');"
                                InnerHtml="Webhook (Push Logs)" ID="MenuItem41" Icon="export.gif">
                            </oem:MenuItem>

                        </Components>
                    </oem:EasyMenu>

                     


                     
                    <oem:EasyMenu ID="EasymenuReports" runat="server" ShowEvent="MouseOver" AttachTo="MenuReports"
                        UseIcons="true" IconsFolder="MenuIcons" IconsPosition="Left" Align="Under" OffsetVertical="-2"
                        Width="250" StyleFolder="styles/horizontal1">
                        <Components>
                            <oem:MenuItem OnClientClick="javascript:SelectMenuItem('Reports/DailyAttendance.aspx');"
                                InnerHtml="Daily Attendance Report" ID="MenuItem16" Icon="report.gif">
                            </oem:MenuItem>
                            <oem:MenuItem OnClientClick="javascript:SelectMenuItem('Reports/MonthlyAttendance.aspx');"
                                InnerHtml="Monthly Attendance Report" ID="MenuItem21" Icon="report.gif">
                            </oem:MenuItem>

                            <oem:MenuItem OnClientClick="javascript:SelectMenuItem('Reports/LeaveSummary.aspx');"
                                InnerHtml="Leave Summary Report" ID="MenuItem23" Icon="report.gif">
                            </oem:MenuItem>

                            <oem:MenuItem OnClientClick="javascript:SelectMenuItem('Reports/PunchRecord.aspx');"
                                InnerHtml="Punch Record Report" ID="MenuItem24" Icon="report.gif">
                            </oem:MenuItem>

                            <oem:MenuItem OnClientClick="javascript:SelectMenuItem('Reports/LeaveRecord.aspx');"
                                InnerHtml="Leave Record Report" ID="MenuItem28" Icon="report.gif">
                            </oem:MenuItem>

                            <oem:MenuItem OnClientClick="javascript:SelectMenuItem('Reports/OutDutyRecord.aspx');"
                                InnerHtml="Out Duty Record Report" ID="MenuItem29" Icon="report.gif">
                            </oem:MenuItem>
                            
                            <oem:MenuItem OnClientClick="javascript:SelectMenuItem('Reports/CompOffRecord.aspx');"
                                InnerHtml="Comp Off Record Report" ID="MenuItem30" Icon="report.gif">
                            </oem:MenuItem>

                            <oem:MenuItem OnClientClick="javascript:SelectMenuItem('Reports/PeriodWise.aspx');"
                                InnerHtml="Period Wise Report" ID="MenuItem39" Icon="report.gif">
                            </oem:MenuItem>

                            <oem:MenuItem OnClientClick="javascript:SelectMenuItem('Reports/AttendanceRegister.aspx');"
                              InnerHtml="Attendance Register Report" ID="MenuItem31" Icon="report.gif">
                            </oem:MenuItem>


                           
                        </Components>
                    </oem:EasyMenu>


                      
                    <oem:EasyMenu ID="Easymenu1" runat="server" ShowEvent="MouseOver" AttachTo="MenuAdmin"
                        UseIcons="true" IconsFolder="MenuIcons" IconsPosition="Left" Align="Under" OffsetVertical="-2"
                        Width="250" StyleFolder="styles/horizontal1">
                        <Components>
                            <oem:MenuItem OnClientClick="javascript:SelectMenuItem('Admin/Users.aspx');"
                                InnerHtml="System Users" ID="MenuItem42" Icon="a_a.gif">
                            </oem:MenuItem>
                            <oem:MenuItem OnClientClick="javascript:SelectMenuItem('Admin/DatabaseSettings.aspx');"
                                InnerHtml="Database Settings" ID="MenuItem43" Icon="DeviceSync.gif">
                            </oem:MenuItem>

                            <oem:MenuItem OnClientClick="javascript:SelectMenuItem('Admin/APISettings.aspx');"
                                InnerHtml="API Settings" ID="MenuItem44" Icon="import.gif">
                           </oem:MenuItem>
                        </Components>
                    </oem:EasyMenu>

                      <oem:EasyMenu ID="Easymenu3" runat="server" ShowEvent="MouseOver" AttachTo="MenuPayrollManagement"
                        UseIcons="true" IconsFolder="MenuIcons" IconsPosition="Left" Align="Under" OffsetVertical="-2"
                        Width="250" StyleFolder="styles/horizontal1">
                        <Components>
                            <oem:MenuItem OnClientClick="javascript:SelectMenuItem('Payroll/PayComponents.aspx');"
                                InnerHtml="Pay Components" ID="MenuItem47" Icon="oTasks.gif">
                            </oem:MenuItem>

                            
                             <oem:MenuItem OnClientClick="javascript:SelectMenuItem('Payroll/SalaryStructures.aspx');"
                                InnerHtml="Salary Structures" ID="MenuItem52" Icon="employee.gif">
                            </oem:MenuItem>


                             <oem:MenuItem OnClientClick="javascript:SelectMenuItem('Payroll/Loans.aspx');"
                                InnerHtml="Loans" ID="MenuItem49" Icon="c_c.gif">
                            </oem:MenuItem>

                             <oem:MenuItem OnClientClick="javascript:SelectMenuItem('Payroll/Reimbursements.aspx');"
                                InnerHtml="Reimbursements" ID="MenuItem50" Icon="database.gif">
                            </oem:MenuItem>

                             <oem:MenuItem OnClientClick="javascript:SelectMenuItem('Payroll/Bonus.aspx');"
                                InnerHtml="Bonus" ID="MenuItem51" Icon="attregister.gif">
                            </oem:MenuItem>

                            <oem:MenuItem OnClientClick="javascript:SelectMenuItem('Payroll/PayCycles.aspx');"
                                InnerHtml="Pay Cycles" ID="MenuItem48" Icon="b_c.gif">
                           </oem:MenuItem>

                           

                        </Components>
                    </oem:EasyMenu>
                         
                    <oem:EasyMenu ID="Easymenu2" runat="server" ShowEvent="MouseOver" AttachTo="MenuVisitorManagement"
                        UseIcons="true" IconsFolder="MenuIcons" IconsPosition="Left" Align="Under" OffsetVertical="-2"
                        Width="250" StyleFolder="styles/horizontal1">
                        <Components>
                            <oem:MenuItem OnClientClick="javascript:SelectMenuItem('Visitor/VisitorLogs.aspx');"
                                InnerHtml="Visitor Logs" ID="MenuItem1" Icon="employee.gif">
                            </oem:MenuItem>

                            <oem:MenuItem OnClientClick="javascript:SelectMenuItem('Visitor/VisitorCards.aspx');"
                                InnerHtml="Visitor Cards" ID="MenuItem45" Icon="a_d.gif">
                           </oem:MenuItem>

                            <oem:MenuItem OnClientClick="javascript:SelectMenuItem('Visitor/VisitorDesks.aspx');"
                                InnerHtml="Visitor Desks" ID="MenuItem26" Icon="a_a.gif">
                            </oem:MenuItem>

                        </Components>
                    </oem:EasyMenu>


                </td>
            </tr>
            <%--For Tool Box Items--%>
            <tr style="background-image: url(Images/mid.gif); background-repeat: repeat-x">
                <td colspan="2">
                    <oem:EasyMenu ID="Easymenu9" IconsFolder="MenuIcons" UseIcons="true" runat="server"
                        ShowEvent="Always" StyleFolder="styles/EasyMenu/Styles/horizontal1" Position="Horizontal"
                        CSSMenu="ParentMenu" CSSMenuItemContainer="ParentItemContainer" IconsPosition="Left">
                        <CSSClassesCollection>
                            <oem:CSSClasses ObjectType="OboutInc.EasyMenu_Pro.MenuItem" ComponentSubMenuCellOver="ParentItemSubMenuCellOver"
                                ComponentContentCell="ParentItemContentCell" Component="ParentItem" ComponentSubMenuCell="ParentItemSubMenuCell"
                                ComponentIconCellOver="ParentItemIconCellOver" ComponentIconCell="ParentItemIconCell"
                                ComponentOver="ParentItemOver" ComponentContentCellOver="ParentItemContentCellOver">
                            </oem:CSSClasses>
                            <oem:CSSClasses ObjectType="OboutInc.EasyMenu_Pro.MenuSeparator" ComponentSubMenuCellOver="ParentSeparatorSubMenuCellOver"
                                ComponentContentCell="ParentSeparatorContentCell" Component="ParentSeparator"
                                ComponentSubMenuCell="ParentSeparatorSubMenuCell" ComponentIconCellOver="ParentSeparatorIconCellOver"
                                ComponentIconCell="ParentSeparatorIconCell" ComponentOver="ParentSeparatorOver"
                                ComponentContentCellOver="ParentSeparatorContentCellOver"></oem:CSSClasses>
                        </CSSClassesCollection>
                    </oem:EasyMenu>
                </td>
            </tr>
        </table>
        <div id="Div_IFrame" style="width: 100%; height: 100%; position: absolute; border: none;
            overflow: hidden;">
            <iframe id="tabIframe" style="width: 100%; height: 100%; border: none;"></iframe>
        </div>
        <owd:Window ID="mySessionTimeOutWindow" runat="server" Left="580" Top="320" Height="80"
            Width="250" VisibleOnLoad="false" StyleFolder="~/Styles/mainwindow/blue" Title="Session Time Out"
            IsModal="True" ShowStatusBar="False" ShowCloseButton="false" OnClientOpen="mySessionTimeOutWindow.screenCenter();">
            <table>
                <tr>
                    <td align="left">
                        <asp:Label ID="lblSession" runat="server" Text="Session Timed Out. System will re-login."
                            Font-Size="11px" ForeColor="Black" Font-Names="Verdana"></asp:Label></td>
                </tr>
                <tr>
                    <td align="right">
                        <input id="btnSessionOk" type="button" value="OK" onclick="SessionTimeOutCloseWindow()" /></td>
                </tr>
            </table>
        </owd:Window>
    </form>

    <script type="text/javascript">
    
   function lnk_LogOff_OnClientClick()
    {
        window.parent.location.href='LogOut.aspx';
        return false;
    }
    
  function SessionTimeOutCloseWindow()
    {
        window.parent.location.href='LogOut.aspx';
    }
    
   function LoadMainPage(cId)
		{
           	window.parent.splMain.loadPage('RightContent', cId + '.aspx' );
		}
			
	function LoadMainPageWithQueryString(cId)
	{
		window.parent.splMain.loadPage('RightContent', cId);
	}
    
//    function SelectMenuItem(itemID)
//    {
//    var WindowHeight=window.screen.height;
//    switch (WindowHeight)
//        {
//            case 768:
//              document.getElementById('Div_IFrame').style.height='80.7%'
//              break;
//            case 864:
//              document.getElementById('Div_IFrame').style.height='83.4%'
//              break;
//            case 900:
//              document.getElementById('Div_IFrame').style.height='84%'
//              break;
//              case 960:
//              document.getElementById('Div_IFrame').style.height='85.3%'
//              break;
//            default:
//              document.getElementById('Div_IFrame').style.height='84.2%'
//        }
//	    window.frames['tabIframe'].location.replace(itemID);
//    }


function SelectMenuItem(itemID)
    {
    var WindowHeight=window.screen.height;
    switch (WindowHeight)
        {
            case 768:
              document.getElementById('Div_IFrame').style.height='76.7%'
              break;
            case 864:
              document.getElementById('Div_IFrame').style.height='79.4%'
              break;
            case 900:
              document.getElementById('Div_IFrame').style.height='80%'
              break;
              case 960:
              document.getElementById('Div_IFrame').style.height='81.3%'
              break;
            default:
              document.getElementById('Div_IFrame').style.height='80.2%'
        }
        
	   document.getElementById('tabIframe').src= itemID;
    }
    
    </script>

</body>
</html>
