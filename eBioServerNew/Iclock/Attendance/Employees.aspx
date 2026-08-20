<%@ page language="VB" autoeventwireup="false" inherits="Attendance_Employees, App_Web_haagzrto" enableEventValidation="false" %>

<%@ Register TagPrefix="uctrl" Src="~/Header.ascx" TagName="header" %>

<%@ Register TagPrefix="obout" Namespace="Obout.Grid" Assembly="obout_Grid_NET" %>
<%@ Register TagPrefix="obout" Namespace="OboutInc.Flyout2" Assembly="obout_Flyout2_NET" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" >
<script type="text/javascript">
    // Client-Side Events for Delete
    function OnInsert(record) {
        document.getElementById("<%=Lbl_InvalidError.ClientID %>").innerHTML = record.Error;
    }

    function OnBeforeDelete(record) {
        record.Error = '';
        document.getElementById("<%=Hdn_EmployeeId.ClientID %>").value = record.EmployeeId;
        if (confirm("Are you sure you want to delete? "))
            return true;
        else
            return false;
    }

    function OnDelete(record) {
        alert(record.Error);
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
                Employee List
            </td>
            <td align="right">
             Select Location
                 <asp:DropDownList ID="drpLocation"  Width="175px" runat="server">
                                    </asp:DropDownList> 
                                  

                 Status 
                    <asp:DropDownList ID="ddlStatus" runat="server" AutoPostBack="false" Width="100px">
                        <asp:ListItem Text="Working" Value="w" Selected></asp:ListItem>
                        <asp:ListItem Text="Resigned" Value="r"></asp:ListItem>
                    </asp:DropDownList>
                    &nbsp;
                    <asp:Button ID="btlReset" runat="server" Text="Filter"  OnClientClick="SetSource(this.id)"   /> 
                    &nbsp;<asp:HiddenField ID="hidSourceID" runat="server" />
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
                    Width="907px" OnInsertCommand="InsertRecord" OnDeleteCommand="DeleteRecord">
                    <ClientSideEvents OnClientInsert="OnInsert" OnBeforeClientDelete="OnBeforeDelete"
                        OnClientDelete="OnDelete" />
                    <TemplateSettings NewRecord_TemplateId="tplAddBtn" />
                    <Columns>
                        <obout:Column ID="Id" DataField="EmployeeId" Visible="False" Width="100" ReadOnly="True"
                            HeaderText="EmployeeId" ConvertEmptyStringToNull="False" Index="0" />
                        <obout:Column ID="EmployeeCode" DataField="EmployeeCode" Width="180" HeaderText="Employee Code"
                            ConvertEmptyStringToNull="False" Index="1" />
                        <obout:Column ID="EmployeeName" DataField="EmployeeName" Width="180" HeaderText="Employee Name"
                            ConvertEmptyStringToNull="False" Index="2" />
                        <obout:Column ID="Column2" DataField="AttendanceLocation" Width="150" HeaderText="Base Location"
                            ConvertEmptyStringToNull="False" Index="3">
                        </obout:Column>
                        <obout:Column ID="Column3" DataField="Department" Width="180" HeaderText="Department" ConvertEmptyStringToNull="False"
                            Index="4">
                        </obout:Column>
                        <obout:Column ConvertEmptyStringToNull="False" DataField="Designation" HeaderText="Designation"
                            Index="5" Width="180">
                        </obout:Column>

                        <obout:Column ConvertEmptyStringToNull="False" DataField="DefaultShiftCode" HeaderText="Default Shift"
                            Index="6" Width="100">
                        </obout:Column>


                        <obout:Column Width="100" ConvertEmptyStringToNull="False" Index="7" TemplateId="tplViewEmployeeLeaveLimitsBtn">
                            <TemplateSettings TemplateId="tplViewEmployeeLeaveLimitsBtn" />
                        </obout:Column>
                        <obout:Column HeaderText="Edit" Width="70" AllowEdit="True" AllowDelete="True" ConvertEmptyStringToNull="False"
                            Index="8" TemplateId="tplEditBtn">
                            <TemplateSettings TemplateId="tplEditBtn" />
                        </obout:Column>
                         <obout:Column HeaderText="Delete" Width="70" AllowDelete="True" ConvertEmptyStringToNull="False"
                            Index="9" />
                        <obout:Column ConvertEmptyStringToNull="False" DataField="ReportingTo" HeaderText="ReportingTo"
                            Visible="false" Index="10">
                        </obout:Column>
                           <obout:Column ConvertEmptyStringToNull="False" DataField="WeeklyOff1" HeaderText="WeeklyOff1"
                            Visible="false" Index="11">
                        </obout:Column>

                         
                         <obout:Column ConvertEmptyStringToNull="False" DataField="WeeklyOff2" HeaderText="WeeklyOff2"
                            Visible="false" Index="12">
                        </obout:Column>
                         <obout:Column ConvertEmptyStringToNull="False" DataField="WeeklyOffDays" HeaderText="WeeklyOffDays"
                            Visible="false" Index="13">
                        </obout:Column>
                         <obout:Column ConvertEmptyStringToNull="False" DataField="AllPunchConsideration" HeaderText="AllPunchConsideration"
                            Visible="false" Index="14">
                        </obout:Column>

                          <obout:Column ConvertEmptyStringToNull="False" DataField="WorkStatus" HeaderText="WorkStatus"
                            Visible="false" Index="15">
                        </obout:Column>
                        <obout:Column ConvertEmptyStringToNull="False" DataField="OverTimeApplicable" HeaderText="WorkStatus"
                            Visible="false" Index="16">
                        </obout:Column>

                         <obout:Column ConvertEmptyStringToNull="False" DataField="AttendanceLocationId" HeaderText="AttendanceLocationId"
                            Visible="false" Index="17">
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
                                    <%#CheckPermissions("Add", "AddEmployeesAT")%>
                                </a>
                            </Template>
                        </obout:GridTemplate>
                        <obout:GridTemplate runat="server" ID="tplViewEmployeeLeaveLimitsBtn" ControlID=""
                            ControlPropertyName="">
                            <Template>
                                <asp:HyperLink runat="server" CssClass="ob_gAL" Style="cursor: hand;" Text='<%# CheckPermissions("Leave Limits","LeaveLimits")%>'
                                    NavigateUrl='<%# CheckPermissions("~/Attendance/EmployeeLeaveLimits.aspx?Id=" + URLEncode("EmployeeId=" + Container.DataItem.Item("EmployeeId")+"&EmployeeName=" + Container.DataItem.Item("EmployeeName")),"LeaveLimits")%>'
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
                                    <asp:TextBox ID="txt_employeeName" runat="server" CssClass="WebControls" Width="175px"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td align="right" style="font-weight: bold;">
                                    Base&nbsp;Location
                                </td>
                                <td>
                                <asp:DropDownList ID="drpBaseLocation" runat="server"  CssClass="WebControls" Width="175px" >
                                    </asp:DropDownList>
                                </td>
                                <td align="right" style="font-weight: bold;">
                                    Department
                                </td>
                                <td>
                                    <asp:TextBox ID="txt_Department" runat="server" CssClass="WebControls" Width="175px"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td align="right" style="font-weight: bold;">
                                    Designation
                                </td>
                                <td>
                                    <asp:TextBox ID="txt_Designation"  runat="server" CssClass="WebControls"
                                        Width="175px"></asp:TextBox>
                                </td>
                                <td align="right" >
                                    Default&nbsp;Shift&nbsp;Code
                                </td>
                                <td align="left" style="font-weight: bold;">
                                   <asp:TextBox ID="txt_DefaultShiftCode"  runat="server" CssClass="WebControls"
                                        Width="175px"></asp:TextBox>
                                </td>
                            </tr>
                           



                             <tr>
                               
                                <td align="right" >
                                    WeeklyOff&nbsp;1
                                </td>

                                <td>
                                
                                <asp:DropDownList ID="drp_WeeklyOff1" runat="server"  Width="170px">
                                   

                                     <asp:ListItem  value="" selected Text="None"></asp:ListItem>
                                    <asp:ListItem  value="0"  Text="Sunday"></asp:ListItem>
                                    <asp:ListItem  value="1" Text="Monday"></asp:ListItem>
                                    <asp:ListItem  value="2" Text="Tuesday"></asp:ListItem>
                                    <asp:ListItem  value="3" Text="Wednesday"></asp:ListItem>
                                    <asp:ListItem  value="4" Text="Thursday"></asp:ListItem>
                                    <asp:ListItem  value="5" Text="Friday"></asp:ListItem>
                                    <asp:ListItem  value="6" Text="Saturday"></asp:ListItem>

                                    </asp:DropDownList>
                                </td>

                                <td align="right" >
                                   Attendance&nbsp;Punch
                                </td>
                                <td>
                                    <asp:DropDownList ID="drp_AttendancePunch" runat="server"  Width="175px">
                                   


                                    <asp:ListItem  value="" selected Text="First and Last Punch"></asp:ListItem>
                                    <asp:ListItem  value="1"  Text="All Punches"></asp:ListItem>

                                    </asp:DropDownList>
                                </td>


                               
                            </tr>


                             <tr>
                                <td align="right" >
                                    WeeklyOff&nbsp;2
                                </td>
                                <td colspan="3">
                                     

                                    

                                    <asp:DropDownList ID="drp_WeeklyOff2" runat="server"  Width="170px">
                                   


                                    <asp:ListItem  value="" selected Text="None"></asp:ListItem>
                                    <asp:ListItem  value="0"  Text="Sunday"></asp:ListItem>
                                    <asp:ListItem  value="1" Text="Monday"></asp:ListItem>
                                    <asp:ListItem  value="2" Text="Tuesday"></asp:ListItem>
                                    <asp:ListItem  value="3" Text="Wednesday"></asp:ListItem>
                                    <asp:ListItem  value="4" Text="Thursday"></asp:ListItem>
                                    <asp:ListItem  value="5" Text="Friday"></asp:ListItem>
                                    <asp:ListItem  value="6" Text="Saturday"></asp:ListItem>

                                    </asp:DropDownList>
                                    <asp:CheckBox ID="chkFirst"  runat="server" Text="1st" />
                                    <asp:CheckBox ID="chkSecond"  runat="server" Text="2nd" />
                                    <asp:CheckBox ID="chkThird"  runat="server" Text="3rd" />
                                    <asp:CheckBox ID="chkFourth"  runat="server" Text="4th" />
                                    <asp:CheckBox ID="chkFifth" runat="server" Text="5th" />

                                </td>

                                

                                
                            </tr>

                            <tr>
                                <td align="right" >
                                   Reporting&nbsp;To
                                </td>
                                <td colspan="3">
                                     <asp:TextBox ID="txt_ReportingTo" runat="server" CssClass="WebControls"
                                        Width="275px"></asp:TextBox> Comma seperated Employee Codes
                                </td>


                                

                            </tr>

                             <tr>
                                <td align="right" >
                                   Work Status
                                </td>
                                <td >
                                      <asp:DropDownList ID="drpStatus" runat="server" AutoPostBack="false" Width="170px">
                        <asp:ListItem Text="Working" Value="w" Selected></asp:ListItem>
                        <asp:ListItem Text="Resigned" Value="r"></asp:ListItem>
                    </asp:DropDownList>
                                </td>
                                <td align="right" >
                                     Is&nbsp;OverTime&nbsp;Applicable
                                </td>
                                <td >
                                     <asp:DropDownList ID="drpOTApplicable" runat="server" AutoPostBack="false" Width="170px">
                        <asp:ListItem Text="No" Value="" Selected></asp:ListItem>
                        <asp:ListItem Text="Yes" Value="1"></asp:ListItem>
                    </asp:DropDownList>
                                </td>


                                

                            </tr>

                            <tr>
                                
                                <td align="right" >
                                     Password
                                </td>
                                <td colspan=3 >
                                      <asp:TextBox ID="txt_Password"  TextMode=Password runat="server" CssClass="WebControls"
                                        Width="170px"></asp:TextBox>&nbsp;Leave&nbsp;blank(for&nbsp;no&nbsp;change)
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
		        oRecord.EmployeeId =document.getElementById("<%=Hdn_EmployeeId.ClientID %>").value ;
		        oRecord.Error='';
		        
		        Dg_Employee.executeInsert(oRecord);
		    }
		    
		     function clearFlyout_Details() 
            {
                document.getElementById("<%=Hdn_EmployeeId.ClientID %>").value = '0';
		        document.getElementById("<%=txt_Employeecode.ClientID %>").value = '';
		        document.getElementById("<%=txt_employeeName.ClientID %>").value = '';
		        document.getElementById("<%=txt_Department.ClientID %>").value = '';
		        document.getElementById("<%=txt_Designation.ClientID %>").value = '';
		        document.getElementById("<%=txt_DefaultShiftCode.ClientID %>").value = '';
		        document.getElementById("<%=drp_WeeklyOff1.ClientID %>").value = '0';
		        document.getElementById("<%=drp_AttendancePunch.ClientID %>").value = '';
		        document.getElementById("<%=drp_WeeklyOff2.ClientID %>").value = '';
		        document.getElementById("<%=chkFirst.ClientID %>").checked  = true;
		        document.getElementById("<%=chkSecond.ClientID %>").checked  = true;
		        document.getElementById("<%=chkThird.ClientID %>").checked  = true;
		        document.getElementById("<%=chkFourth.ClientID %>").checked  = true;
		        document.getElementById("<%=chkFifth.ClientID %>").checked  = true;
		        document.getElementById("<%=txt_ReportingTo.ClientID %>").value = '';
		        document.getElementById("<%=txt_Password.ClientID %>").value = '';
		        document.getElementById("<%=drpStatus.ClientID %>").value = 'w';
		        document.getElementById("<%=drpBaseLocation.ClientID %>").value = '0';
		       
                  
                document.getElementById("<%=txt_Employeecode.ClientID %>").disabled = false;
                document.getElementById("<%=Lbl_InvalidError.ClientID %>").innerHTML='';

               }

           
         
		    
		     function populateEditControls(iRecordIndex) 
		    {	
		        document.getElementById("<%=Hdn_EmployeeId.ClientID %>").value = Dg_Employee.Rows[iRecordIndex].Cells[0].Value;
		        document.getElementById("<%=txt_Employeecode.ClientID %>").value = Dg_Employee.Rows[iRecordIndex].Cells[1].Value;
		        document.getElementById("<%=txt_employeeName.ClientID %>").value = Dg_Employee.Rows[iRecordIndex].Cells[2].Value;                                
                document.getElementById("<%=drpBaseLocation.ClientID %>").value = Dg_Employee.Rows[iRecordIndex].Cells[17].Value;                                
                document.getElementById("<%=txt_Department.ClientID %>").value = Dg_Employee.Rows[iRecordIndex].Cells[4].Value;                                
                document.getElementById("<%=txt_Designation.ClientID %>").value = Dg_Employee.Rows[iRecordIndex].Cells[5].Value;                                
                document.getElementById("<%=txt_DefaultShiftCode.ClientID %>").value = Dg_Employee.Rows[iRecordIndex].Cells[6].Value;                                
                document.getElementById("<%=drp_WeeklyOff1.ClientID %>").value = Dg_Employee.Rows[iRecordIndex].Cells[11].Value;                                
                document.getElementById("<%=drp_AttendancePunch.ClientID %>").value = Dg_Employee.Rows[iRecordIndex].Cells[14].Value;                                
                document.getElementById("<%=txt_ReportingTo.ClientID %>").value = Dg_Employee.Rows[iRecordIndex].Cells[10].Value;                                
                document.getElementById("<%=drp_WeeklyOff2.ClientID %>").value = Dg_Employee.Rows[iRecordIndex].Cells[12].Value;                                
                 document.getElementById("<%=drpStatus.ClientID %>").value = Dg_Employee.Rows[iRecordIndex].Cells[15].Value;  
                 document.getElementById("<%=drpOTApplicable.ClientID %>").value = Dg_Employee.Rows[iRecordIndex].Cells[16].Value;  
                

                document.getElementById("<%=chkFirst.ClientID %>").checked = Dg_Employee.Rows[iRecordIndex].Cells[13].Value.includes("1");                                
                document.getElementById("<%=chkSecond.ClientID %>").checked = Dg_Employee.Rows[iRecordIndex].Cells[13].Value.includes("2");                                
                document.getElementById("<%=chkThird.ClientID %>").checked = Dg_Employee.Rows[iRecordIndex].Cells[13].Value.includes("3");                                
                document.getElementById("<%=chkFourth.ClientID %>").checked = Dg_Employee.Rows[iRecordIndex].Cells[13].Value.includes("4");                                
                document.getElementById("<%=chkFifth.ClientID %>").checked = Dg_Employee.Rows[iRecordIndex].Cells[13].Value.includes("5");                                


                document.getElementById("<%=txt_Employeecode.ClientID %>").disabled = true;
		                  


		   }


           

		    
		   
    </script>
</body>
</html>
