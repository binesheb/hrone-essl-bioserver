<%@ page language="VB" autoeventwireup="false" inherits="Attendance_Company, App_Web_haagzrto" enableEventValidation="false" %>


<%@ Register Assembly="obout_Window_NET" Namespace="OboutInc.Window" TagPrefix="owd" %>
<%@ Register TagPrefix="uctrl" Src="~/Header.ascx" TagName="header" %>
<%@ Register TagPrefix="owd" Namespace="OboutInc.Window" Assembly="obout_Window_NET" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Untitled Page</title>
    <link href="../StyleSheet.css" rel="stylesheet" type="text/css" />

    

</head>
<body onload="IsFixedShift_OnChange();">
    <form id="form1" runat="server"> 

    

        <div>
            <uctrl:header ID="MyHeader" runat="server" />
            <owd:Window ID="CompanySettings" runat="server" IsModal="true" Height="380" Width="450"
                StyleFolder="~/Styles/mainwindow/blue" Title="Company Settings"
                ShowCloseButton="true" ShowStatusBar="False" Left="150" Top="20" >
              <table width="100%" cellpadding="1" class="Table" style="border-top-style: none; border-right-style: none; border-left-style: none; border-bottom-style: none;">
                    <tr>
                        <td>
                            <fieldset>
                                <legend>Company Settings</legend>
                                <table>
                                    <tr>
                                        <td align="left">
                                            Company&nbsp;Logo&nbsp;(600X240&nbsp;px)
                                        </td>
                                        <td>
                                            <asp:Image ID="imgLogo"  runat="server" Width="150px" Height="60px" />
                                        </td>
                                        <td align="left" style="width:100%;">
                                            <input type="button" value="Browse"  onclick="JavaScript:document.getElementById('<%=fileUploadImg.ClientID%>').click();return (false);"  style="width:60px;" />
                                           
                                            <br />
                                            <asp:Button ID="btnClear" runat="server" Text="Clear"  Width="60px"/>

                                            <asp:Button ID="btnBrowse" runat="server"  style="visibility:hidden;width:0px;height:0px;"></asp:Button> 
                                             <asp:FileUpload ID="fileUploadImg" accept=".bmp" runat="server" style="visibility:hidden;width:0px;height:0px;" OnChange='uploadimg();'  />

                                             <script type="text/javascript">

                                                 function uploadimg() {

                                                     var button = document.getElementById('<%=btnBrowse.ClientID%>');                                                    
                                                     button.click();

                                                     
                                                 }
                                             </script>
                                           
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="left">
                                            Company&nbsp;Name
                                        </td>
                                        <td align="left" colspan="2">
                                            <asp:TextBox ID="txtName" Width="211px" runat="server"></asp:TextBox>
                                        </td>
                                       
                                    </tr>

                                    <tr>
                                        <td>
                                            Attendence&nbsp;Year&nbsp;Start&nbsp;Day</td>
                                        <td align="left" colspan="2">
                                           

                                           <asp:DropDownList runat="server" ID="drpAttendanceDay" Width="70px">
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
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            Attendence&nbsp;Year&nbsp;Start&nbsp;Month</td>
                                        <td align="left" colspan="2">
                                            <asp:DropDownList runat="server" ID="drpAttendanceMonth" Width="70px">
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
                                        </td>
                                    </tr>

                                    <tr>
                                        <td >
                                        Default&nbsp;Work&nbsp;Begin&nbsp;Time
                                        </td>
                                        <td colspan="2">
                                            <asp:TextBox ID="txtBeginTime" Width="70px" runat="server">09:30</asp:TextBox>&nbsp;HH:MM 24 hour format</td>
                                            
                                        </td>
                                    </tr>


                                     <tr>
                                        <td >
                                        Default&nbsp;Punch&nbsp;Begin&nbsp;Before
                                        </td>
                                        <td colspan="2">
                                            <asp:TextBox ID="txtPunchBeginBefore" Width="70px" runat="server">120</asp:TextBox>&nbsp;Minutes</td>
                                            
                                        </td>
                                    </tr>

                                    
                                    <tr>
                                        <td >
                                        Default&nbsp;Work&nbsp;End&nbsp;Time
                                        </td>
                                        <td colspan="2">
                                            <asp:TextBox ID="txtEndTime" Width="70px" runat="server">18:30</asp:TextBox>&nbsp;HH:MM 24 hour format</td>
                                            
                                        </td>
                                    </tr>
                                    

                                     <tr>
                                        <td >
                                        Default&nbsp;Punch&nbsp;End&nbsp;After
                                        </td>
                                        <td colspan="2">
                                            <asp:TextBox ID="txtPunchEndAfter" Width="70px" runat="server">480</asp:TextBox>&nbsp;Minutes</td>
                                            
                                        </td>
                                    </tr>

                                     <tr>
                                        <td >
                                        Default&nbsp;Full&nbsp;Day&nbsp;Duration
                                        </td>
                                        <td colspan="2">
                                            <asp:TextBox ID="txtFullDayDuration" Width="70px" runat="server">480</asp:TextBox>&nbsp;Minutes</td>
                                            
                                        </td>
                                    </tr>

                                    
                                    <tr>
                                        <td >
                                        Min&nbsp;Punch&nbsp;Difference&nbsp;(Duplicate)
                                        </td>
                                        <td colspan="2">
                                            <asp:TextBox ID="txtDuplicatePunchDuration" Width="70px" runat="server">60</asp:TextBox>&nbsp;Seconds</td>
                                            
                                        </td>
                                    </tr>
                                                                       
                                </table>
                            </fieldset>
                        </td>
                    </tr>
                    <tr>
                        <td align="right">
                            <asp:Label ID="Lbl_Error" runat="server" EnableViewState="False" ForeColor="Red"></asp:Label>&nbsp;<asp:Button ID="Btn_Save" runat="server" Text="Save" Width="60px"  />
                            &nbsp;<input id="btn_Cancel" type="button" value="Close" onclick="javascript:closeWindow();" /><asp:HiddenField ID="hdn_FixedShift" runat="server" />
                                
                        </td>
                    </tr>
                    <tr>
                        <td>
                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        </td>
                    </tr>
                    
                    
                    
                </table>
            </owd:Window>
        </div>
  
    </form>

    <script type="text/javascript">
        function closeWindow() {
            try {

                CompanySettings.Close();
            }
            catch (ex) {
                alert(ex.message);
            }
        }

        function Btn_SaveOnClientClick() {
           
                return true;
        }

        function IsFixedShift_OnChange() {
           
        }
    </script>
</body>
</html>

