<%@ page language="VB" autoeventwireup="false" inherits="Attendance_ShiftSchedule, App_Web_haagzrto" enableEventValidation="false" %>



<%@ Register TagPrefix="uctrl" Src="~/Header.ascx" TagName="header" %>

<%@ Register TagPrefix="obout" Namespace="Obout.Grid" Assembly="obout_Grid_NET" %>
<%@ Register TagPrefix="obout" Namespace="OboutInc.Flyout2" Assembly="obout_Flyout2_NET" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" >
<script type="text/javascript">
    // Client-Side Events for Delete

    // Client-Side Events for Delete
    function OnInsert(record) {
        document.getElementById("<%=Lbl_InvalidError.ClientID %>").innerHTML = record.Error;
    }

</script>
<html >
<head id="Head1" runat="server">
    <title>Untitled Page</title>
    <link href="../StyleSheet.css" rel="stylesheet" type="text/css" />
</head>

        <uctrl:header ID="MyHeader" runat="server" />

<body>
    <form id="form1" runat="server">
    <table cellpadding="0" cellspacing="0" style="border-right: gray 1px solid; border-top: gray 1px solid;
        border-left: gray 1px solid; border-bottom: gray 1px solid;">
        <tr style="font-weight: bold; font-size: 14px; background-color: lightsteelblue;
            padding-left: 5px; padding-top: 3px; padding-bottom: 3px; color: white;">
            <td style="font-weight: bold; font-size: 14px; background-color: lightsteelblue;
                padding: 5px; color: white;">
                Shift Schedule
            </td>
            <td align="right">
                <asp:Label ID="lblError" runat="server" Width="300px" ForeColor="Red"></asp:Label>
                &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;
            </td>
        </tr>
        
          <tr style="background-color: lightsteelblue;">
                <td colspan="2" style="text-align: right;font-weight: normal; font-size: 11px; ">
                    <hr />
Location
 <asp:DropDownList ID="drpLocation"  Width="130px" runat="server">
                                    </asp:DropDownList> 
                   Select Month
                    <asp:DropDownList runat="server" ID="ddlMonth" Width="70px">
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
                   Select Year 
                    <asp:DropDownList ID="ddlYears" runat="server" AutoPostBack="false" Width="70px">
                        
                    </asp:DropDownList>
                    &nbsp;
                    <asp:Button ID="btlReset" runat="server" Text="Filter"  OnClientClick="SetSource(this.id)"  />  &nbsp;
                    
                    <asp:HiddenField ID="hidSourceID" runat="server" />
                  <script type="text/javascript">
                      function SetSource(SourceID) {
                          var hidSourceID = document.getElementById("<%=hidSourceID.ClientID%>");
                          hidSourceID.value = SourceID;
                      }
                  </script>
                </td>
            </tr>


        <tr>
            <td colspan="2">
                <obout:Grid ID="Dg_Shifts" runat="server" ShowLoadingMessage="true" EnableRecordHover="true"
                    AllowFiltering="true" CallbackMode="true" Serialize="false" KeepSelectedRecords="true"
                    AutoGenerateColumns="false" AllowAddingRecords="false"  FolderStyle="~/styles/grid/styles/premiere_blue"
                    Width="2000px" OnInsertCommand="InsertRecord"      AllowSorting=false >
                    
                    <ClientSideEvents OnClientInsert="OnInsert"   />
                    <Columns>
                        <obout:Column ID="EmployeeId" DataField="EmployeeId1" Visible="False" Width="100" ReadOnly="True"
                            HeaderText="EmployeeId" ConvertEmptyStringToNull="False" Index="0" />
                        <obout:Column ID="EmployeeCode" DataField="EmployeeCode" Width="120" HeaderText="Employee Code"
                            ConvertEmptyStringToNull="False" DataFormatString="{0:dd MMM yyyy}" Index="1" />
                        <obout:Column ID="EmployeeName" DataField="EmployeeName" Width="130" HeaderText="Name"
                            ConvertEmptyStringToNull="False" Index="2" />
                        <obout:Column ID="Location" DataField="AttendanceLocation" Width="90" HeaderText="Location"
                            ConvertEmptyStringToNull="False" Index="3">
                        </obout:Column>

                        <obout:Column ID="Column32" DataField="Date" Visible="False" Width="100" ReadOnly="True"
                            HeaderText="Date" ConvertEmptyStringToNull="False" Index="4" />
                        <obout:Column ID="Column33" DataField="Id" Visible="False" Width="100" ReadOnly="True"
                            HeaderText="Id" ConvertEmptyStringToNull="False" Index="5" />

                        <obout:Column ID="Column1" DataField="Day1" Width="26" HeaderText="01"
                            ConvertEmptyStringToNull="False" Index="6" AllowFilter=false >
                        </obout:Column>

                        <obout:Column ID="Column3" DataField="Day2" Width="26" HeaderText="02"
                            ConvertEmptyStringToNull="False" Index="7" AllowFilter=false  SortPriority="0" >
                        </obout:Column>

                        <obout:Column ID="Column4" DataField="Day3" Width="26" HeaderText="03"
                            ConvertEmptyStringToNull="False" Index="8" AllowFilter=false  SortPriority="0" >
                        </obout:Column>

                        <obout:Column ID="Column5" DataField="Day4" Width="26" HeaderText="04"
                            ConvertEmptyStringToNull="False" Index="9" AllowFilter=false  SortPriority="0" >
                        </obout:Column>

                        <obout:Column ID="Column6" DataField="Day5" Width="26" HeaderText="05"
                            ConvertEmptyStringToNull="False" Index="10" AllowFilter=false  SortPriority="0" >
                        </obout:Column>

                        <obout:Column ID="Column7" DataField="Day6" Width="26" HeaderText="06"
                            ConvertEmptyStringToNull="False" Index="11" AllowFilter=false  SortPriority="0" >
                        </obout:Column>

                        <obout:Column ID="Column8" DataField="Day7" Width="26" HeaderText="07"
                            ConvertEmptyStringToNull="False" Index="12" AllowFilter=false  SortPriority="0" >
                        </obout:Column>

                        <obout:Column ID="Column9" DataField="Day8" Width="26" HeaderText="08"
                            ConvertEmptyStringToNull="False" Index="13" AllowFilter=false  SortPriority="0" >
                        </obout:Column>

                        <obout:Column ID="Column10" DataField="Day9" Width="26" HeaderText="09"
                            ConvertEmptyStringToNull="False" Index="14" AllowFilter=false  SortPriority="0" >
                        </obout:Column>

                        <obout:Column ID="Column11" DataField="Day10" Width="26" HeaderText="10"
                            ConvertEmptyStringToNull="False" Index="15" AllowFilter=false  SortPriority="0" >
                        </obout:Column>

                        <obout:Column ID="Column12" DataField="Day11" Width="26" HeaderText="11"
                            ConvertEmptyStringToNull="False" Index="16" AllowFilter=false  SortPriority="0" >
                        </obout:Column>

                        <obout:Column ID="Column13" DataField="Day12" Width="26" HeaderText="12"
                            ConvertEmptyStringToNull="False" Index="17" AllowFilter=false  SortPriority="0" >
                        </obout:Column>

                        <obout:Column ID="Column14" DataField="Day13" Width="26" HeaderText="13"
                            ConvertEmptyStringToNull="False" Index="18" AllowFilter=false  SortPriority="0" >
                        </obout:Column>

                        <obout:Column ID="Column15" DataField="Day14" Width="26" HeaderText="14"
                            ConvertEmptyStringToNull="False" Index="19" AllowFilter=false  SortPriority="0" >
                        </obout:Column>

                        <obout:Column ID="Column16" DataField="Day15" Width="26" HeaderText="15"
                            ConvertEmptyStringToNull="False" Index="20" AllowFilter=false  SortPriority="0" >
                        </obout:Column>

                        <obout:Column ID="Column17" DataField="Day16" Width="26" HeaderText="16"
                            ConvertEmptyStringToNull="False" Index="21" AllowFilter=false  SortPriority="0" >
                        </obout:Column>

                        <obout:Column ID="Column18" DataField="Day17" Width="26" HeaderText="17"
                            ConvertEmptyStringToNull="False" Index="22" AllowFilter=false  SortPriority="0" >
                        </obout:Column>

                        <obout:Column ID="Column19" DataField="Day18" Width="26" HeaderText="18"
                            ConvertEmptyStringToNull="False" Index="23" AllowFilter=false  SortPriority="0" >
                        </obout:Column>

                        <obout:Column ID="Column20" DataField="Day19" Width="26" HeaderText="19"
                            ConvertEmptyStringToNull="False" Index="24" AllowFilter=false  SortPriority="0" >
                        </obout:Column>

                        <obout:Column ID="Column21" DataField="Day20" Width="26" HeaderText="20"
                            ConvertEmptyStringToNull="False" Index="25" AllowFilter=false  SortPriority="0" >
                        </obout:Column>

                        <obout:Column ID="Column22" DataField="Day21" Width="26" HeaderText="21"
                            ConvertEmptyStringToNull="False" Index="26" AllowFilter=false  SortPriority="0" >
                        </obout:Column>

                        <obout:Column ID="Column23" DataField="Day22" Width="26" HeaderText="22"
                            ConvertEmptyStringToNull="False" Index="27" AllowFilter=false  SortPriority="0" >
                        </obout:Column>

                        <obout:Column ID="Column24" DataField="Day23" Width="26" HeaderText="23"
                            ConvertEmptyStringToNull="False" Index="28" AllowFilter=false  SortPriority="0" >
                        </obout:Column>

                        <obout:Column ID="Column25" DataField="Day24" Width="26" HeaderText="24"
                            ConvertEmptyStringToNull="False" Index="29" AllowFilter=false  SortPriority="0" >
                        </obout:Column>

                        <obout:Column ID="Column26" DataField="Day25" Width="26" HeaderText="25"
                            ConvertEmptyStringToNull="False" Index="30" AllowFilter=false  SortPriority="0" >
                        </obout:Column>

                        <obout:Column ID="Column27" DataField="Day26" Width="26" HeaderText="26"
                            ConvertEmptyStringToNull="False" Index="31" AllowFilter=false  SortPriority="0" >
                        </obout:Column>

                        <obout:Column ID="Column28" DataField="Day27" Width="26" HeaderText="27"
                            ConvertEmptyStringToNull="False" Index="32" AllowFilter=false  SortPriority="0" >
                        </obout:Column>

                        <obout:Column ID="Column29" DataField="Day28" Width="26" HeaderText="28"
                            ConvertEmptyStringToNull="False" Index="33" AllowFilter=false  SortPriority="0" >
                        </obout:Column>

                        <obout:Column ID="Day29" DataField="Day29" Width="26" HeaderText="29"
                            ConvertEmptyStringToNull="False" Index="34" AllowFilter=false  SortPriority="0" >
                        </obout:Column>

                        <obout:Column ID="Day30" DataField="Day30" Width="26" HeaderText="30"
                            ConvertEmptyStringToNull="False" Index="35" AllowFilter=false  SortPriority="0" >
                        </obout:Column>

                        <obout:Column ID="Day31" DataField="Day31" Width="26" HeaderText="31"
                            ConvertEmptyStringToNull="False" Index="36" AllowFilter=false  SortPriority="0" >
                        </obout:Column>

                        <obout:Column HeaderText="Edit" Width="130" AllowEdit="True" AllowDelete="True" ConvertEmptyStringToNull="False"
                            Index="37" TemplateId="tplEditBtn">
                            <TemplateSettings TemplateId="tplEditBtn" />
                        </obout:Column>
                       
                       
                       
                    </Columns>
                    <Templates>
                        <obout:GridTemplate runat="server" ID="tplEditBtn" ControlID="" ControlPropertyName="">
                            <Template>
                                <a href="javascript: //" id="grid_link_<%# Container.PageRecordIndex %>" onclick="attachFlyoutToLink(this,'Update')"
                                    class="ob_gAL">Edit</a>
                            </Template>
                        </obout:GridTemplate>
                       
                     
                    </Templates>
                </obout:Grid>
            </td>
        </tr>
    </table>
    <obout:Flyout runat="server" ID="Flyout1" Align="left" Position="BOTTOM_LEFT" CloseEvent="NONE"
        OpenEvent="NONE" DelayTime="500">
        <table class="rowEditTable">
            <tr>
                <td>
                    <fieldset>
                        <legend>Shift Schedule Details</legend>
                        <table>
                            
                            <tr><td>01</td><td>02</td><td>03</td><td>04</td><td>05</td><td>06</td><td>07</td></tr>
                            <tr>
                                <td><asp:TextBox ID="txt_Day1" runat="server" CssClass="WebControls" Width="26px"></asp:TextBox>
                                </td>
                                <td><asp:TextBox ID="txt_Day2" runat="server" CssClass="WebControls" Width="26px"></asp:TextBox>
                                </td>
                                <td><asp:TextBox ID="txt_Day3" runat="server" CssClass="WebControls" Width="26px"></asp:TextBox>
                                </td>
                                <td><asp:TextBox ID="txt_Day4" runat="server" CssClass="WebControls" Width="26px"></asp:TextBox>
                                </td>
                                <td><asp:TextBox ID="txt_Day5" runat="server" CssClass="WebControls" Width="26px"></asp:TextBox>
                                </td>
                                 <td><asp:TextBox ID="txt_Day6" runat="server" CssClass="WebControls" Width="26px"></asp:TextBox>
                                </td>
                                <td><asp:TextBox ID="txt_Day7" runat="server" CssClass="WebControls" Width="26px"></asp:TextBox>
                                </td>
                            </tr>

                              <tr><td>08</td><td>09</td><td>10</td><td>11</td><td>12</td><td>13</td><td>14</td></tr>
                            <tr>
                               
                                <td><asp:TextBox ID="txt_Day8" runat="server" CssClass="WebControls" Width="26px"></asp:TextBox>
                                </td>
                                <td><asp:TextBox ID="txt_Day9" runat="server" CssClass="WebControls" Width="26px"></asp:TextBox>
                                </td>
                                <td><asp:TextBox ID="txt_Day10" runat="server" CssClass="WebControls" Width="26px"></asp:TextBox>
                                </td>
                                <td><asp:TextBox ID="txt_Day11" runat="server" CssClass="WebControls" Width="26px"></asp:TextBox>
                                </td>
                                <td><asp:TextBox ID="txt_Day12" runat="server" CssClass="WebControls" Width="26px"></asp:TextBox>
                                </td>
                                <td><asp:TextBox ID="txt_Day13" runat="server" CssClass="WebControls" Width="26px"></asp:TextBox>
                                </td>
                                <td><asp:TextBox ID="txt_Day14" runat="server" CssClass="WebControls" Width="26px"></asp:TextBox>
                                </td>
                            </tr>

                              <tr><td>15</td><td>16</td><td>17</td><td>18</td><td>19</td><td>20</td><td>21</td></tr>
                            <tr>
                               
                                <td><asp:TextBox ID="txt_Day15" runat="server" CssClass="WebControls" Width="26px"></asp:TextBox>
                                </td>
                                <td><asp:TextBox ID="txt_Day16" runat="server" CssClass="WebControls" Width="26px"></asp:TextBox>
                                </td>
                                <td><asp:TextBox ID="txt_Day17" runat="server" CssClass="WebControls" Width="26px"></asp:TextBox>
                                </td>
                                <td><asp:TextBox ID="txt_Day18" runat="server" CssClass="WebControls" Width="26px"></asp:TextBox>
                                </td>
                                <td><asp:TextBox ID="txt_Day19" runat="server" CssClass="WebControls" Width="26px"></asp:TextBox>
                                </td>
                                <td><asp:TextBox ID="txt_Day20" runat="server" CssClass="WebControls" Width="26px"></asp:TextBox>
                                </td>
                                <td><asp:TextBox ID="txt_Day21" runat="server" CssClass="WebControls" Width="26px"></asp:TextBox>
                                </td>
                            </tr>

                              <tr><td>22</td><td>23</td><td>24</td><td>25</td><td>26</td><td>27</td><td>28</td></tr>
                            <tr>
                               
                                <td><asp:TextBox ID="txt_Day22" runat="server" CssClass="WebControls" Width="26px"></asp:TextBox>
                                </td>
                                <td><asp:TextBox ID="txt_Day23" runat="server" CssClass="WebControls" Width="26px"></asp:TextBox>
                                </td>
                                <td><asp:TextBox ID="txt_Day24" runat="server" CssClass="WebControls" Width="26px"></asp:TextBox>
                                </td>
                                <td><asp:TextBox ID="txt_Day25" runat="server" CssClass="WebControls" Width="26px"></asp:TextBox>
                                </td>
                                <td><asp:TextBox ID="txt_Day26" runat="server" CssClass="WebControls" Width="26px"></asp:TextBox>
                                </td>
                                <td><asp:TextBox ID="txt_Day27" runat="server" CssClass="WebControls" Width="26px"></asp:TextBox>
                                </td>
                                <td><asp:TextBox ID="txt_Day28" runat="server" CssClass="WebControls" Width="26px"></asp:TextBox>
                                </td>
                            </tr>

                              <tr><td id="td_Day29" runat="server">29</td><td id="td_Day30" runat="server">30</td><td id="td_Day31" runat="server">31</td><td></td><td></td><td></td><td></td></tr>
                            <tr>
                               
                                <td><asp:TextBox ID="txt_Day29" runat="server" CssClass="WebControls" Width="26px"></asp:TextBox>
                                </td>
                                <td><asp:TextBox ID="txt_Day30" runat="server" CssClass="WebControls" Width="26px"></asp:TextBox>
                                </td>
                                <td><asp:TextBox ID="txt_Day31" runat="server" CssClass="WebControls" Width="26px"></asp:TextBox>
                                </td>
                                <td colspan="4" style="text-align: right;font-weight: bold;">
                                *Note: WO = Weekly Off
                                </td>
                            </tr>

                             

                        </table>
                    </fieldset>
                </td>
            </tr>
            <tr>
           <td align="right" colspan="2"><asp:HiddenField ID="Hdn_Id" runat="server" />
                                    <asp:Label runat="server" ForeColor="red" EnableViewState="false" Text="&nbsp;&nbsp;&nbsp;&nbsp;"
                                        ID="Lbl_InvalidError"></asp:Label>
                                    <input id="btn_Save" type="button" value="Save" onclick="javascript:btn_Save_onclick();" />&nbsp;&nbsp;<input
                                        id="btn_Cancel" type="button" value="Close" onclick="javascript:closeFlyout_Details();" />
                                </td>
            </tr>
        </table>
    </obout:Flyout>
    </form>
    <script runat="server">
        Function CheckPermissions(ByVal Action As String, ByVal Permission As String) As String
            
            Return Action
            
            If Not Session.Item("LoginUser") Is Nothing Then
            
                If CType(Session("LoginUser"), eBioServerLibrary.Data.Admin.User).PermissionList.Contains(Permission) Then
                    Return Action
                End If
                Return ""
            End If
        End Function
        
        Function GetDataItemValue(ByVal fieldname As String, ByVal Container As Obout.Grid.TemplateContainer) As String
            If Container.DataItem(fieldname) Is Nothing Then
                Return Container.DataItem(fieldname.ToUpper)
            End If
            Return Container.DataItem(fieldname)
        End Function
        
        Function ParseDateTime(ByVal DateValue As String) As String
            Try
                Return CDate(DateValue).ToString("yyyy-MM-dd")
            Catch ex As Exception
                Return ""
            End Try
            
        End Function
        
        Function URLEncode(ByVal url) As String
            url = url + "&sessionid=" + Session.SessionID
            Return eBioServerLibrary.Utilities.URLEncodeDecode.Encode(url)
            
        End Function
          
    </script>
    <script type="text/javascript">
		        
 	            function attachFlyoutToLink(oLink,Action)
		        {	
	                <%=Flyout1.getClientID()%>.AttachTo(oLink.id);		            		            
	                <%=Flyout1.getClientID()%>.Open();
	                clearFlyout_Details();
	                if(Action=='Update')
	                {
	                    populateEditControls(oLink.id.toString().replace("grid_link_", ""));
	                }
		        }
	        function closeFlyout_Details() 
		    {
		        <%=Flyout1.getClientID()%>.Close();
		    }
		    
		    
		     function btn_Save_onclick()
		     {
		        var oRecord = new Object();
		        oRecord.Id =document.getElementById("<%=Hdn_Id.ClientID %>").value ;
		        oRecord.Error='';

		        Dg_Shifts.executeInsert(oRecord);
		    }
		    
		     function clearFlyout_Details() 
            {
                document.getElementById("<%=Hdn_Id.ClientID %>").value = '0';
		       

               }

           
         
		    
		     function populateEditControls(iRecordIndex) 
		    {	
		        document.getElementById("<%=Hdn_Id.ClientID %>").value = Dg_Shifts.Rows[iRecordIndex].Cells[0].Value;
             
		        
                document.getElementById("<%=txt_Day1.ClientID %>").value = Dg_Shifts.Rows[iRecordIndex].Cells[6].Value;
                document.getElementById("<%=txt_Day2.ClientID %>").value = Dg_Shifts.Rows[iRecordIndex].Cells[7].Value;
                document.getElementById("<%=txt_Day3.ClientID %>").value = Dg_Shifts.Rows[iRecordIndex].Cells[8].Value;
                document.getElementById("<%=txt_Day4.ClientID %>").value = Dg_Shifts.Rows[iRecordIndex].Cells[9].Value;
                document.getElementById("<%=txt_Day5.ClientID %>").value = Dg_Shifts.Rows[iRecordIndex].Cells[10].Value;
                document.getElementById("<%=txt_Day6.ClientID %>").value = Dg_Shifts.Rows[iRecordIndex].Cells[11].Value;
                document.getElementById("<%=txt_Day7.ClientID %>").value = Dg_Shifts.Rows[iRecordIndex].Cells[12].Value;
                document.getElementById("<%=txt_Day8.ClientID %>").value = Dg_Shifts.Rows[iRecordIndex].Cells[13].Value;
                document.getElementById("<%=txt_Day9.ClientID %>").value = Dg_Shifts.Rows[iRecordIndex].Cells[14].Value;
                document.getElementById("<%=txt_Day10.ClientID %>").value = Dg_Shifts.Rows[iRecordIndex].Cells[15].Value;
                document.getElementById("<%=txt_Day11.ClientID %>").value = Dg_Shifts.Rows[iRecordIndex].Cells[16].Value;
                document.getElementById("<%=txt_Day12.ClientID %>").value = Dg_Shifts.Rows[iRecordIndex].Cells[17].Value;
                document.getElementById("<%=txt_Day13.ClientID %>").value = Dg_Shifts.Rows[iRecordIndex].Cells[18].Value;
                document.getElementById("<%=txt_Day14.ClientID %>").value = Dg_Shifts.Rows[iRecordIndex].Cells[19].Value;
                document.getElementById("<%=txt_Day15.ClientID %>").value = Dg_Shifts.Rows[iRecordIndex].Cells[20].Value;
                document.getElementById("<%=txt_Day16.ClientID %>").value = Dg_Shifts.Rows[iRecordIndex].Cells[21].Value;
                document.getElementById("<%=txt_Day17.ClientID %>").value = Dg_Shifts.Rows[iRecordIndex].Cells[22].Value;
                document.getElementById("<%=txt_Day18.ClientID %>").value = Dg_Shifts.Rows[iRecordIndex].Cells[23].Value;
                document.getElementById("<%=txt_Day19.ClientID %>").value = Dg_Shifts.Rows[iRecordIndex].Cells[24].Value;
                document.getElementById("<%=txt_Day20.ClientID %>").value = Dg_Shifts.Rows[iRecordIndex].Cells[25].Value;
                document.getElementById("<%=txt_Day21.ClientID %>").value = Dg_Shifts.Rows[iRecordIndex].Cells[26].Value;
                document.getElementById("<%=txt_Day22.ClientID %>").value = Dg_Shifts.Rows[iRecordIndex].Cells[27].Value;
                document.getElementById("<%=txt_Day23.ClientID %>").value = Dg_Shifts.Rows[iRecordIndex].Cells[28].Value;
                document.getElementById("<%=txt_Day24.ClientID %>").value = Dg_Shifts.Rows[iRecordIndex].Cells[29].Value;
                document.getElementById("<%=txt_Day25.ClientID %>").value = Dg_Shifts.Rows[iRecordIndex].Cells[30].Value;
                document.getElementById("<%=txt_Day26.ClientID %>").value = Dg_Shifts.Rows[iRecordIndex].Cells[31].Value;
                document.getElementById("<%=txt_Day27.ClientID %>").value = Dg_Shifts.Rows[iRecordIndex].Cells[32].Value;
                document.getElementById("<%=txt_Day28.ClientID %>").value = Dg_Shifts.Rows[iRecordIndex].Cells[33].Value;
                document.getElementById("<%=txt_Day29.ClientID %>").value = Dg_Shifts.Rows[iRecordIndex].Cells[34].Value;
                document.getElementById("<%=txt_Day30.ClientID %>").value = Dg_Shifts.Rows[iRecordIndex].Cells[35].Value;
                document.getElementById("<%=txt_Day31.ClientID %>").value = Dg_Shifts.Rows[iRecordIndex].Cells[36].Value;

		                  


		   }


           

		    
		   
    </script>
</body>
</html>
