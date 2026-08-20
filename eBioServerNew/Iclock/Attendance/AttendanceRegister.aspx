<%@ page language="VB" autoeventwireup="false" inherits="Attendance_AttendanceRegister, App_Web_haagzrto" enableEventValidation="false" %>

<%@ Register TagPrefix="uctrl" Src="~/Header.ascx" TagName="header" %>

<%@ Register TagPrefix="obout" Namespace="Obout.Grid" Assembly="obout_Grid_NET" %>
<%@ Register TagPrefix="obout" Namespace="OboutInc.Flyout2" Assembly="obout_Flyout2_NET" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" >
<script type="text/javascript">
    // Client-Side Events for Delete
    function OnInsert(record) {
        document.getElementById("<%=Lbl_InvalidError.ClientID %>").innerHTML = record.Error;
        document.getElementById("btn_Save").disabled = false;


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
                Attendance Register
            </td>
            <td align="right">

                
            </td>
        </tr>
        <tr style="background-color: lightsteelblue;">
                <td colspan="2" style="text-align: right;font-weight: normal; font-size: 11px; ">
                    <hr />
                    <asp:Label ID="lblError" runat="server" Width="300px" ForeColor="Red"></asp:Label>
                
                 Location
                 <asp:DropDownList ID="drpLocation"  Width="130px" runat="server">
                                    </asp:DropDownList>
                
                 Attendance Day 

                    
                 
                    
                    <asp:DropDownList runat="server" ID="ddlDays" Width="40px">
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
                                            <asp:DropDownList runat="server" ID="ddlMonths" Width="50px">
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
                                            -   <asp:DropDownList ID="ddlYears" runat="server" AutoPostBack="false" Width="70px">
                        
                    </asp:DropDownList>
                    &nbsp;
                    <asp:Button ID="btlReset" runat="server"  OnClientClick="SetSource(this.id)"  Text="Filter" /> 
                    &nbsp;
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
                <obout:Grid ID="Dg_Employee" runat="server" ShowLoadingMessage="true" EnableRecordHover="true"
                    AllowFiltering="true" CallbackMode="true" Serialize="false" KeepSelectedRecords="true"
                    AutoGenerateColumns="false" AllowAddingRecords="true" FolderStyle="~/styles/grid/styles/premiere_blue"
                    Width="907px" OnInsertCommand="InsertRecord" >
                    <ClientSideEvents OnClientInsert="OnInsert"  />
                    <TemplateSettings NewRecord_TemplateId="tplAddBtn" />
                    <Columns>
                        <obout:Column ID="Id" DataField="EmployeeId" Visible="False" Width="100" ReadOnly="True"
                            HeaderText="EmployeeId" ConvertEmptyStringToNull="False" Index="0" />
                        <obout:Column ID="AttendanceDate" DataField="AttendanceDate" Width="120" Visible=false HeaderText="Attendance Date"
                            ConvertEmptyStringToNull="False" DataFormatString="{0:dd MMM yyyy}"  Index="1" />
                        <obout:Column ID="Column1" DataField="EmployeeCode" Width="90" HeaderText="Code"
                            ConvertEmptyStringToNull="False" Index="2" />
                        <obout:Column ID="EmployeeName" DataField="EmployeeName" Width="110" HeaderText="Name"
                            ConvertEmptyStringToNull="False" Index="3" />
                        <obout:Column ID="Column4" DataField="Location" Width="80" HeaderText="Location"
                            ConvertEmptyStringToNull="False" Index="4" />
                        <obout:Column ID="Column2" DataField="Shift" Width="120" HeaderText="Shift"
                            ConvertEmptyStringToNull="False" Index="5">
                        </obout:Column>
                        <obout:Column ID="Column3" DataField="InTime" Width="80" HeaderText="In Time" ConvertEmptyStringToNull="False"
                            Index="6">
                        </obout:Column>

                        <obout:Column ConvertEmptyStringToNull="False" DataField="OutTime" HeaderText="Out Time"
                            Index="7" Width="80">
                        </obout:Column>

                        
                        <obout:Column ConvertEmptyStringToNull="False" DataField="LateBy" HeaderText="Late By"
                            Index="8" Width="80">
                        </obout:Column>


                        <obout:Column ConvertEmptyStringToNull="False" DataField="EarlyBy" HeaderText="Early By"
                            Index="9" Width="80">
                        </obout:Column>


                        <obout:Column ConvertEmptyStringToNull="False" DataField="Duration" HeaderText="Duration"
                            Index="10" Width="80">
                        </obout:Column>

                        <obout:Column ConvertEmptyStringToNull="False" DataField="OverTime" HeaderText="OverTime"
                            Index="11" Width="80">
                        </obout:Column>

                        
                        <obout:Column Visible=true ConvertEmptyStringToNull="False" DataField="ApprovedDuration" HeaderText="Approved Duration"
                            Index="12" Width="140">
                        </obout:Column>


                        <obout:Column Visible=true ConvertEmptyStringToNull="False" DataField="ApprovedOverTime" HeaderText="Approved OverTime"
                            Index="13" Width="140">
                        </obout:Column>

                        <obout:Column ConvertEmptyStringToNull="False" DataField="Status" HeaderText="Final Status"
                            Index="14" Width="100">
                        </obout:Column>
                        
                        <obout:Column HeaderText="Edit" Width="80" AllowEdit="True" AllowDelete="True" ConvertEmptyStringToNull="False"
                            Index="15" TemplateId="tplEditBtn">
                            <TemplateSettings TemplateId="tplEditBtn" />
                        </obout:Column>

                         <obout:Column ConvertEmptyStringToNull="False" DataField="Punches" HeaderText="Punches" Width="300"
                            Visible="false" Index="16">
                        </obout:Column>

                    </Columns>
                    <Templates>
                        <obout:GridTemplate runat="server" ID="tplEditBtn" ControlID="" ControlPropertyName="">
                            <Template>
                                <a href="javascript: //" id="grid_link_<%# Container.PageRecordIndex %>" onclick="attachFlyoutToLink(this,'Update')"
                                    class="ob_gAL">Edit</a>
                            </Template>
                        </obout:GridTemplate>
                        <obout:GridTemplate runat="server" ID="tplAddBtn" ControlID="" ControlPropertyName="">
                            <Template>
                                <a href="javascript: //" id="btAdd" onclick="attachFlyoutToLink(this,'Add')" class="ob_gAL">
                                    <%#CheckPermissions("Add", "AddEmployees")%>
                                </a>
                            </Template>
                        </obout:GridTemplate>
                        <obout:GridTemplate runat="server" ID="tplViewEmployeeLeaveLimitsBtn" ControlID=""
                            ControlPropertyName="">
                            <Template>
                                <asp:HyperLink runat="server" CssClass="ob_gAL" Style="cursor: hand;" Text='<%# CheckPermissions("Leave Limits","EmployeeLeaveLimits")%>'
                                    NavigateUrl='<%# CheckPermissions("~/Attendance/EmployeeLeaveLimits.aspx?Id=" + URLEncode("EmployeeId=" + Container.DataItem.Item("EmployeeId")+"&EmployeeName=" + Container.DataItem.Item("EmployeeName")),"EmployeeLeaveLimits")%>'
                                    ID="AA1" />
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
                        <legend>Employee Details</legend>
                        <table>
                            <tr>
                                <td align="right" style="font-weight: bold;">
                                    Employee&nbsp;Code
                                </td>
                                <td>
                                    <asp:TextBox ID="txt_Employeecode" runat="server" CssClass="WebControls" Width="175px"></asp:TextBox>
                                </td>
                                <td align="right" style="font-weight: bold;">
                                    Employee&nbsp;Name
                                </td>
                                <td>
                                    <asp:TextBox ID="txt_employeeName"  Enabled=false runat="server" CssClass="WebControls" Width="175px"></asp:TextBox>
                                </td>
                            </tr>
                            

                            <tr>
                                <td align="right"  style="font-weight: bold;">
                                  Punch&nbsp;Records
                                </td>
                                <td colspan="3">
                                     <asp:TextBox TextMode=MultiLine Rows=3 Enabled=false ID="txt_Punches" runat="server" CssClass="WebControls"
                                        Width="465px"></asp:TextBox> 
                                </td>


                                

                            </tr>

                             <tr>
                                <td align="right" >
                                   Approved&nbsp;Duration
                                </td>
                                <td colspan=3 >
                                      <asp:TextBox ID="txt_ApprovedDuration" runat="server" CssClass="WebControls" Width="75px"></asp:TextBox>&nbsp;Minutes.&nbsp;<font style="color:Blue;">Note: Leave <b>blank</b> for Actuals.</font>
                                </td>
                                

                                
                                </tr>
                                <tr>
                          
                            <td align="right" >
                                     Approved&nbsp;OverTime
                                </td>
                                <td colspan=3>
                                    <asp:TextBox ID="txt_ApprovedOverTime" runat="server" CssClass="WebControls" Width="75px"></asp:TextBox>&nbsp;Minutes.&nbsp;<font style="color:Blue;">Note: Leave <b>blank</b> for Actuals.</font>
                                </td>

                            </tr>



                        </table>
                    </fieldset>
                </td>
            </tr>
            <tr>
            
             <td align="right">

                                 <asp:HiddenField ID="Hdn_EmployeeId" runat="server" />
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
		    
		    
		     function btn_Save_onclick() {

                document.getElementById("btn_Save").disabled  = true;

                document.getElementById("<%=Lbl_InvalidError.ClientID %>").innerHTML = "Please wait while System is updating the records.";
		        var oRecord = new Object();
		        oRecord.EmployeeId =document.getElementById("<%=Hdn_EmployeeId.ClientID %>").value ;
		        oRecord.Error='';
		        
		        Dg_Employee.executeInsert(oRecord);
		    }
		    
		     function clearFlyout_Details() 
            {
              
                document.getElementById("<%=Lbl_InvalidError.ClientID %>").innerHTML='';

               }

           
         
		    
		     function populateEditControls(iRecordIndex) 
		    {	
		        document.getElementById("<%=Hdn_EmployeeId.ClientID %>").value = Dg_Employee.Rows[iRecordIndex].Cells[0].Value;
		        document.getElementById("<%=txt_Employeecode.ClientID %>").value = Dg_Employee.Rows[iRecordIndex].Cells[2].Value;
		        document.getElementById("<%=txt_employeeName.ClientID %>").value = Dg_Employee.Rows[iRecordIndex].Cells[3].Value;                                
                document.getElementById("<%=txt_Punches.ClientID %>").value = Dg_Employee.Rows[iRecordIndex].Cells[16].Value;                                
                document.getElementById("<%=txt_ApprovedDuration.ClientID %>").value = Dg_Employee.Rows[iRecordIndex].Cells[12].Value;                                
                document.getElementById("<%=txt_ApprovedOverTime.ClientID %>").value = Dg_Employee.Rows[iRecordIndex].Cells[13].Value;                                
                 
                document.getElementById("<%=txt_Employeecode.ClientID %>").disabled = true;
		                  


		   }


           

		    
		   
    </script>
</body>
</html>
