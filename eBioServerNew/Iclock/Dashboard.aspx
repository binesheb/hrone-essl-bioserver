<%@ page language="VB" autoeventwireup="false" inherits="Dashboard, App_Web_fjgmw3bh" enableEventValidation="false" %>
<%@ Register TagPrefix="uctrl" Src="~/Header.ascx" TagName="header" %>

<%@ Register TagPrefix="obout" Namespace="Obout.Grid" Assembly="obout_Grid_NET" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" >
<html >
<head id="Head1" runat="server">
    <title>Untitled Page</title>
    <link href="StyleSheet.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript">
        function LoadMainPage(cId) {
            window.parent.splMain.loadPage('RightContent', cId + '.aspx');
        }

        function LoadMainPageWithQueryString(cId) {
            window.parent.splMain.loadPage('RightContent', cId);
        }
    </script>
    <script type="text/javascript">
        var specialKeys = new Array();
        specialKeys.push(8); //Backspace
        function IsNumeric(e) {
            var keyCode = e.which ? e.which : e.keyCode
            var ret = ((keyCode >= 48 && keyCode <= 57) || specialKeys.indexOf(keyCode) != -1);
            return ret;
        }

        function RefreshDataGrid() {
            grid_Devices.refresh();
        }

        
    </script>
    </head>

            <uctrl:header ID="MyHeader" runat="server" />


<body>
    
    <form id="form1" runat="server">
    <div>
        
            <table cellpadding="0" cellspacing="0" style="width: 1000px">
                <tr>
                    <td style="border-bottom: lightgrey thin solid; padding:3px; width:100%; background-color: #e7edf2;">
                        <h1>
                            &nbsp; <span style="font-family: Bell MT"><span style="font-size: 18pt; color: black">
                                Dashboard</span> <small><span style="font-size: 11pt; color: silver">Day&nbsp;<asp:DropDownList
                                    ID="drpday" runat="server">
                                    <asp:ListItem value="01">1</asp:ListItem>
                                    <asp:ListItem value="02">2</asp:ListItem>
                                    <asp:ListItem value="03">3</asp:ListItem>
                                    <asp:ListItem value="04">4</asp:ListItem>
                                    <asp:ListItem value="05">5</asp:ListItem>
                                    <asp:ListItem value="06">6</asp:ListItem>
                                    <asp:ListItem value="07">7</asp:ListItem>
                                    <asp:ListItem value="08">8</asp:ListItem>
                                    <asp:ListItem value="09">9</asp:ListItem>
                                    <asp:ListItem value="10">10</asp:ListItem>
                                    <asp:ListItem value="11">11</asp:ListItem>
                                    <asp:ListItem value="12">12</asp:ListItem>
                                    <asp:ListItem value="13">13</asp:ListItem>
                                    <asp:ListItem value="14">14</asp:ListItem>
                                    <asp:ListItem value="15">15</asp:ListItem>
                                    <asp:ListItem value="16">16</asp:ListItem>
                                    <asp:ListItem value="17">17</asp:ListItem>
                                    <asp:ListItem value="18">18</asp:ListItem>
                                    <asp:ListItem value="19">19</asp:ListItem>
                                    <asp:ListItem value="20">20</asp:ListItem>
                                    <asp:ListItem value="21">21</asp:ListItem>
                                    <asp:ListItem value="22">22</asp:ListItem>
                                    <asp:ListItem value="23">23</asp:ListItem>
                                    <asp:ListItem value="24">24</asp:ListItem>
                                    <asp:ListItem value="25">25</asp:ListItem>
                                    <asp:ListItem value="26">26</asp:ListItem>
                                    <asp:ListItem value="27">27</asp:ListItem>
                                    <asp:ListItem value="28">28</asp:ListItem>
                                    <asp:ListItem value="29">29</asp:ListItem>
                                    <asp:ListItem value="30">30</asp:ListItem>
                                    <asp:ListItem value="31">31</asp:ListItem>
                                </asp:DropDownList>&nbsp;Month&nbsp;<asp:DropDownList
                                    ID="drpMonth" runat="server">
                                      <asp:ListItem value="01">Jan</asp:ListItem>
                                    <asp:ListItem value="02">Feb</asp:ListItem>
                                    <asp:ListItem value="03">Mar</asp:ListItem>
                                    <asp:ListItem value="04">Apr</asp:ListItem>
                                    <asp:ListItem value="05">May</asp:ListItem>
                                    <asp:ListItem value="06">Jun</asp:ListItem>
                                    <asp:ListItem value="07">Jul</asp:ListItem>
                                    <asp:ListItem value="08">Aug</asp:ListItem>
                                    <asp:ListItem value="09">Sep</asp:ListItem>
                                    <asp:ListItem value="10">Oct</asp:ListItem>
                                    <asp:ListItem value="11">Nov</asp:ListItem>
                                    <asp:ListItem value="12">Dec</asp:ListItem>
                                </asp:DropDownList>&nbsp;Year&nbsp;<asp:DropDownList
                                    ID="drpYear" runat="server">
                                </asp:DropDownList>
                                    &nbsp;Location&nbsp;
                                    <asp:DropDownList ID="drpLocation"  Width="140px" runat="server">
                                    </asp:DropDownList>
                                    <asp:Button ID="Button1" runat="server"
                                        Text="Refresh"  OnClientClick="SetSource(this.id)" /></span></small> </span> <asp:Label ID="lblError" runat="server" Text="" ForeColor="Red" Font-Size=Medium></asp:Label>
                    
                        </h1>
                        <asp:HiddenField ID="hidSourceID" runat="server" />

                         <script type="text/javascript">
                             function SetSource(SourceID) {
                                 var hidSourceID = document.getElementById("<%=hidSourceID.ClientID%>");
                                 hidSourceID.value = SourceID;
                             }
                  </script>

                       </td>
                </tr>
                <tr style="">
                    <td  style="vertical-align: middle; border-bottom: lightgrey thin solid;
                        background-color: ghostwhite; text-align: center; border-bottom-color: #0099CC;padding-top:5px;">
                        <table style="padding-left: 11px; width: 96%">
                            <tr>

                            <td style="vertical-align: middle; width: 20%; text-align: center;">
                                    <div style="width: 98%; height: 97%; ">
                                        <!-- small box -->
                                        <div style="width: 100%;">
                                            <div style="background-color: #a1c436;padding:2px;border-radius: 13px;">
                                                <h3 style="text-align: left;padding-left:15px;color:White;">
                                                  
                                                        <asp:Label ID="lblPresent" runat="server" style="font-size: 16px; color:White "  Text="0"></asp:Label>
                                                </h3>
                                                <p  style="font-size: 16px; text-align: left;padding-left:15px;color:White;">
                                                    <asp:LinkButton ID="LinkButtonPresent"  style="font-size: 16px; color:White " runat="server">Present Employees</asp:LinkButton>
                                                </p>
                                            </div>
                                            <div style="width: 1%">
                                            </div>
                                        </div>
                                    </div>
                                </td>

                                <td style="vertical-align: middle; width: 20%; text-align: center">
                                    <div style="width: 98%; height: 97%;>
                                        <!-- small box -->
                                        <div style="width: 100%">
                                            <div style="background-color: #ff851b;padding:2px;border-radius: 13px;">
                                                <h3 style="text-align: left;padding-left:15px; color:White;color:White;">
                                                    
                                                        <asp:Label ID="lblAbsent" style="font-size: 16px; color:White "  runat="server" Text="0"></asp:Label>
                                                </h3>
                                                <p  style="font-size: 16px; text-align: left;padding-left:15px;color:White;">
                                                    <asp:LinkButton ID="LinkButtonAbsent" style="font-size: 16px; color:White " runat="server">Absent Employees</asp:LinkButton>
                                                </p>
                                            </div>
                                            <div style="width: 1%">
                                            </div>
                                        </div>
                                    </div>
                                </td>
                            
                                
                                <td style="vertical-align: middle; width: 20%; text-align: center">
                                    <div style="width: 98%; height: 97%; >
                                        <!-- small box -->
                                        <div style="width: 100%">
                                            <div style="background-color: #2394bc;padding:2px;border-radius: 13px;">
                                                <h3 style="text-align: left;padding-left:15px;color:White;">
                                                    
                                                        <asp:Label ID="lblOnline" style="font-size: 16px; color:White "  runat="server" Text="0"></asp:Label>
                                                </h3>
                                                <p  style="font-size: 16px; text-align: left;padding-left:15px;color:White;">
                                                    <asp:LinkButton ID="LinkOnline"  style="font-size: 16px; color:White " runat="server">Online Devices</asp:LinkButton>
                                                </p>
                                            </div>
                                            <div style="width: 1%">
                                            </div>
                                        </div>
                                    </div>
                                </td>
                                <td style="vertical-align: middle; width: 20%; text-align: center">
                                    <div style="width: 98%; height: 97%; >
                                        <!-- small box -->
                                        <div style="width: 100%">
                                            <div style="background-color: #CC0000;padding:2px;border-radius: 13px;">
                                                <h3 style="text-align: left;padding-left:15px;color:White;">
                                                  
                                                        <asp:Label ID="lblOffline" style="font-size: 16px; color:White "  runat="server" Text="0"></asp:Label>
                                                </h3>
                                                <p style="font-size: 16px; text-align: left;padding-left:15px;color:White;">
                                                    <asp:LinkButton ID="LinkButtonOffline" style="font-size: 16px; color:White "  runat="server">Offline Devices</asp:LinkButton>
                                                </p>
                                            </div>
                                            <div style="width: 1%">
                                            </div>
                                        </div>
                                    </div>
                                </td>
                            </tr>
                           
                           <tr id="EmployeesRow" runat="server">
                           <td colspan=4 style="vertical-align: middle; width: 100%; text-align: left">
                            <br /><br />

                            <table cellpadding="0" cellspacing="0" style="border-right: gray 1px solid; border-top: gray 1px solid;
        border-left: gray 1px solid; border-bottom: gray 1px solid;">
        <tr style="font-weight: bold; font-size: 14px; background-color: lightsteelblue;
            padding-left: 5px; padding-top: 3px; padding-bottom: 3px; color: white;">
            <td style="font-weight: bold; font-size: 14px; background-color: lightsteelblue;
                padding: 5px; color: white;">
                <asp:Label ID="lblEmployeeStatus" runat="server" Text="Label"></asp:Label>&nbsp;Employees List
            </td>
           
        </tr>
        <tr>
            <td >
           
                <obout:Grid ID="Dg_Employee" runat="server" ShowLoadingMessage="true" EnableRecordHover="true"
                    AllowFiltering="true" CallbackMode="true" Serialize="false" KeepSelectedRecords="true"
                    AutoGenerateColumns="false" AllowAddingRecords="false" FolderStyle="~/styles/grid/styles/premiere_blue"
                    Width="100%" >
                    <Columns>
                        <obout:Column ID="Id" DataField="EmployeeId" Visible="False" Width="150" ReadOnly="True"
                            HeaderText="EmployeeId" ConvertEmptyStringToNull="False" Index="0" />
                        <obout:Column ID="EmployeeCode" DataField="EmployeeCode" Width="150" HeaderText="Employee Code"
                            ConvertEmptyStringToNull="False" Index="1" />
                        <obout:Column ID="EmployeeName" DataField="EmployeeName" Width="180" HeaderText="Employee Name"
                            ConvertEmptyStringToNull="False" Index="2" />
                        <obout:Column ID="Column2" DataField="Location" Width="150" HeaderText="Base Location"
                            ConvertEmptyStringToNull="False" Index="3">
                        </obout:Column>
                        <obout:Column ID="Column3" DataField="LastPunch"  DataFormatString="{0:dd MMM yyyy HH:mm:ss}"  Width="170" HeaderText="Last Punch" ConvertEmptyStringToNull="False"
                            Index="4">
                        </obout:Column>
                        <obout:Column ConvertEmptyStringToNull="False" DataField="DeviceName" HeaderText="Last Punch Device"
                            Index="5" Width="150">
                        </obout:Column>
                        <obout:Column ConvertEmptyStringToNull="False" DataField="DeviceLocation" HeaderText="Last Punch Location"
                           Width="150"  Index="6">
                        </obout:Column>   

                        <obout:Column Width="150" HeaderText="Last Punch Direction" ConvertEmptyStringToNull="False"
                            Index="7" TemplateId="tplDirection">
                            <TemplateSettings TemplateId="tplDirection" />
                        </obout:Column>

                       
                        
                    </Columns>
                   <Templates>
                       
                        <obout:GridTemplate runat="server" ID="tplDirection">
                            <Template>
                                <%# ParseDirection(Container.DataItem.Item("LastPunchDirection"), Container.DataItem.Item("DeviceDirection"))%>
                                
                            </Template>
                        </obout:GridTemplate>
                    </Templates>
                </obout:Grid>

                 <script runat="server">
        
        Function ParseDirection(ByVal Direction As String, ByVal DeviceDirection As String)
            
            Try
                If DeviceDirection = "DEVICE" Then
                    Return Direction
                Else
                    Return DeviceDirection
                End If
            Catch ex As Exception
                Return ""
            End Try
            
        End Function
        
        
    </script>

            </td>
        </tr>
    </table>
                           
                           
                           </td>
                           </tr>


                           <tr id="DevicesRow" runat="server">
                           <td colspan=4 style="vertical-align: middle; width: 100%; text-align: left">
                            <br /><br />

                            <table cellpadding="0" cellspacing="0" style="border-right: gray 1px solid; border-top: gray 1px solid;
        border-left: gray 1px solid; border-bottom: gray 1px solid;">
        <tr style="font-weight: bold; font-size: 14px; background-color: lightsteelblue;
            padding-left: 5px; padding-top: 3px; padding-bottom: 3px; color: white;">
            <td style="font-weight: bold; font-size: 14px; background-color: lightsteelblue;
                padding: 5px; color: white;">
                <asp:Label ID="lblDeviceStatus" runat="server" Text="Label"></asp:Label>&nbsp;Devices List
            </td>
           
        </tr>
        <tr>
            <td >
           
                <obout:Grid ID="Dg_Devices" runat="server" ShowLoadingMessage="true" EnableRecordHover="true"
                    AllowFiltering="true" CallbackMode="true" Serialize="false" KeepSelectedRecords="true"
                    AutoGenerateColumns="false" AllowAddingRecords="false" FolderStyle="~/styles/grid/styles/premiere_blue"
                    Width="100%" >
                    <Columns>
                      
                        <obout:Column ID="Column4" DataField="DeviceName" Width="170" HeaderText="Device Name"
                            ConvertEmptyStringToNull="False" Index="0" />
                        <obout:Column ID="Column5" DataField="SerialNumber" Width="200" HeaderText="Serial Number"
                            ConvertEmptyStringToNull="False" Index="1" />
                        <obout:Column ID="Column6" DataField="Location" Width="200" HeaderText="Location"
                            ConvertEmptyStringToNull="False" Index="2">
                        </obout:Column>
                        <obout:Column ID="Column7" DataField="LastPing" Width="170" DataFormatString="{0:dd MMM yyyy HH:mm:ss}"  HeaderText="Last Ping" ConvertEmptyStringToNull="False"
                            Index="3">
                        </obout:Column>
                        <obout:Column ConvertEmptyStringToNull="False" DataField="LastReset" HeaderText="Last Reset"
                            Index="4" Width="170">
                        </obout:Column>
                       
                       <obout:Column ID="Column22"  Width="150" HeaderText="Activation Status" TemplateId="tplValidateActivation"
                                    ConvertEmptyStringToNull="False" Index="5" >
                                    <TemplateSettings TemplateId="tplValidateActivation" />
                         </obout:Column>
                    </Columns>
                    <Templates>
                    
                     <obout:GridTemplate runat="server" ID="tplValidateActivation">
                                    <Template>
                                            
                                            <%# ValidateActivation(Container.DataItem.Item("ActivationCode"))%>
                                    </Template>
                                </obout:GridTemplate>
                    </Templates>
                   
                </obout:Grid>
            </td>
        </tr>
    </table>
            
      <script runat="server">
        
        Function ValidateActivation(ByVal ActivationCode As String) As String
            If ActivationCode = "" Or ActivationCode = "0" Then
                Return "Not Active"
            Else
                Return "Active"
            End If
        End Function
        </script>               
                           
                           </td>
                           </tr>
                        </table>
                        <span style="font-size: 10pt">&nbsp;&nbsp; </span>
                    </td>
                </tr>
     

  
            
            </table>
       
    </div>
    </form>
    <script runat="server">
           
        Function ParseLastPing(ByVal LastCheckDate As String) As String
            Try
                If CDate(LastCheckDate) < CDate("1910-01-01") Then
                    Return ""
                Else
                    Return CDate(LastCheckDate).ToString("dd-MMM-yyyy HH:mm")
                End If
            Catch ex As Exception
                Return ""
            End Try
            Return ""
        End Function
        
      
           
           
    </script>



     

</body>
</html>
