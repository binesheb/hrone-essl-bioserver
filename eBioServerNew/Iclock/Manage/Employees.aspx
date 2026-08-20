<%@ page language="VB" autoeventwireup="false" inherits="Manage_Employees, App_Web_v2kwzk4v" enableEventValidation="false" %>
<%@ Register TagPrefix="uctrl" Src="~/Header.ascx" TagName="header" %>

<%@ Register TagPrefix="obout" Namespace="Obout.Grid" Assembly="obout_Grid_NET" %>
<%@ Register TagPrefix="obout" Namespace="OboutInc.Flyout2" Assembly="obout_Flyout2_NET" %>
<%@ Register Assembly="obout_Window_NET" Namespace="OboutInc.Window" TagPrefix="owd" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" >
<script type="text/javascript">
    // Client-Side Events for Delete
    function OnInsert(record) {
        document.getElementById("<%=Lbl_InvalidError.ClientID %>").innerHTML = record.Error;
        document.getElementById("<%=Lbl_InvalidError1.ClientID %>").innerHTML = record.Error;
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
                <asp:Label ID="lblError" runat="server" Width="300px" ForeColor="Red"></asp:Label>
                Select Location
                 <asp:DropDownList ID="drpLocation"  Width="175px" runat="server">
                                    </asp:DropDownList> 
                                    <asp:Button ID="btnGo" runat="server" Text="Refresh" OnClientClick="SetSource(this.id)" />

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
                    Width="907px" OnInsertCommand="InsertRecord" OnDeleteCommand="DeleteRecord">
                    <ClientSideEvents OnClientInsert="OnInsert" OnBeforeClientDelete="OnBeforeDelete"
                        OnClientDelete="OnDelete" />
                    <TemplateSettings NewRecord_TemplateId="tplAddBtn" />
                    <Columns>
                        <obout:Column ID="Id" DataField="EmployeeId" Visible="False" Width="100" ReadOnly="True"
                            HeaderText="EmployeeId" ConvertEmptyStringToNull="False" Index="0" />
                        <obout:Column ID="EmployeeCode" DataField="EmployeeCode" Width="160" HeaderText="Employee Code"
                            ConvertEmptyStringToNull="False" Index="1" />
                        <obout:Column ID="EmployeeName" DataField="EmployeeName" Width="160" HeaderText="Employee Name"
                            ConvertEmptyStringToNull="False" Index="2" />
                        <obout:Column ID="Column2" DataField="AttendanceLocation" Width="100" HeaderText="Base Location"
                            ConvertEmptyStringToNull="False" Index="3">
                        </obout:Column>
                        <obout:Column ID="Column1"  Width="150" HeaderText="Access Locations"  TemplateId="tplLocations"
                            ConvertEmptyStringToNull="False" Index="4">
                             <TemplateSettings TemplateId="tplLocations" />
                        </obout:Column>
                        <obout:Column ID="Column3" DataField="Role" Width="100" HeaderText="Role" ConvertEmptyStringToNull="False"
                            Index="5">
                        </obout:Column>
                        <obout:Column ConvertEmptyStringToNull="False" DataField="EmployeeRFIDNumber" HeaderText="Card Number"
                            Index="6" Width="100">
                        </obout:Column>
                        <obout:Column ConvertEmptyStringToNull="False" DataField="VerificationType" HeaderText="VerificationType"
                            Visible="false" Index="7">
                        </obout:Column>
                        <obout:Column ConvertEmptyStringToNull="False" DataField="VerificationTypeName" Width="200"
                            HeaderText="Verification Type" Visible="True" Index="8">
                        </obout:Column>

                        <obout:Column Width="80" ConvertEmptyStringToNull="False" Index="9" TemplateId="tplViewEmployeeTimePeriodsBtn">
                            <TemplateSettings TemplateId="tplViewEmployeeTimePeriodsBtn" />
                        </obout:Column>


                        <obout:Column Width="80" ConvertEmptyStringToNull="False" Index="10" TemplateId="tplViewEmployeeBiometricsBtn">
                            <TemplateSettings TemplateId="tplViewEmployeeBiometricsBtn" />
                        </obout:Column>

                        <obout:Column Width="60" ConvertEmptyStringToNull="False" Index="11" TemplateId="tplViewQR">
                            <TemplateSettings TemplateId="tplViewQR" />
                        </obout:Column>

                        
                        <obout:Column HeaderText="Edit" Width="70" AllowEdit="True" AllowDelete="True" ConvertEmptyStringToNull="False"
                            Index="12" TemplateId="tplEditBtn">
                            <TemplateSettings TemplateId="tplEditBtn" />
                        </obout:Column>
                        <obout:Column HeaderText="Delete" Width="70" AllowDelete="True" ConvertEmptyStringToNull="False"
                            Index="13" />
                        <obout:Column ConvertEmptyStringToNull="False" DataField="ExpiryFrom" HeaderText="ExpiryFrom"
                            Visible="false" Index="14">
                        </obout:Column>
                        <obout:Column ConvertEmptyStringToNull="False" DataField="ExpiryTo" HeaderText="ExpiryTo"
                            Visible="false" Index="15">
                        </obout:Column>
                           <obout:Column ConvertEmptyStringToNull="False" DataField="GroupId" HeaderText="GroupId"
                            Visible="false" Index="16">
                        </obout:Column>
                           <obout:Column ConvertEmptyStringToNull="False" DataField="AttendanceLocationId" HeaderText="AttendanceLocationId"
                            Visible="false" Index="17">
                        </obout:Column>
                        
                          <obout:Column ConvertEmptyStringToNull="False" DataField="Location" HeaderText="Location"
                            Visible="false" Index="18">
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
                                    <%#CheckPermissions("Add", "AddEmployeesAC")%>
                                </a>
                            </Template>
                        </obout:GridTemplate>
                        <obout:GridTemplate runat="server" ID="tplViewEmployeeBiometricsBtn" ControlID=""
                            ControlPropertyName="">
                            <Template>
                                <asp:HyperLink runat="server" CssClass="ob_gAL" Style="cursor: hand;" Text='<%# CheckPermissions("Biometrics","EmployeeBiometrics")%>'
                                    NavigateUrl='<%# CheckPermissions("~/Manage/EmployeeBiometrics.aspx?Id=" + URLEncode("EmployeeCode=" + Container.DataItem.Item("EmployeeCode")+"&EmployeeName=" + Container.DataItem.Item("EmployeeName")),"EmployeeBiometrics")%>'
                                    ID="AA1" />
                            </Template>
                        </obout:GridTemplate>

                        <obout:GridTemplate runat="server" ID="tplViewEmployeeTimePeriodsBtn" ControlID=""
                            ControlPropertyName="">
                            <Template>
                                <asp:HyperLink runat="server" CssClass="ob_gAL" Style="cursor: hand;" Text='<%# CheckPermissions("Time Periods","EmployeeTimePeriods")%>'
                                    NavigateUrl='<%# CheckPermissions("~/Manage/EmployeeTimePeriods.aspx?Id=" + URLEncode("EmployeeId=" + Container.DataItem.Item("EmployeeId")+"&EmployeeName=" + Container.DataItem.Item("EmployeeName")),"EmployeeTimePeriods")%>'
                                    ID="AA1" />
                            </Template>
                        </obout:GridTemplate>


                        

                        <obout:GridTemplate runat="server" ID="tplViewQR" ControlID=""
                            ControlPropertyName="">
                            <Template>

                            <a href="javascript: //" id="QRCode" class="ob_gAL" onclick="OpenPopUpWindow('<%# "EmployeeQR.aspx?Id=" + URLEncode("EmployeeRFIDNumber=" + Container.DataItem.Item("EmployeeRFIDNumber"))%>')">QR Code</a>
                            </Template>
                        </obout:GridTemplate>


                        
                        <obout:GridTemplate runat="server" ID="tplLocations" ControlID=""
                            ControlPropertyName="">
                            <Template>

                            <a href="javascript: //" id="grid_Loc_link_<%# Container.PageRecordIndex %>"  onclick="attachWindowToLink(this)" class="ob_gAL">
                                    <%# CheckPermissions((Container.DataItem.Item("Location").ToString() & "....................").Substring(0,15),"EditEmployeesAC")%> 
                                </a>

                            
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
                                    Employee Code
                                </td>
                                <td>
                                    <asp:TextBox ID="txt_Employeecode" runat="server" CssClass="WebControls" Width="175px"></asp:TextBox>
                                </td>
                                <td align="right" style="font-weight: bold;">
                                    Employee Name
                                </td>
                                <td>
                                    <asp:TextBox ID="txt_employeeName" runat="server" CssClass="WebControls" Width="175px"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td align="right" style="font-weight: bold;">
                                   Base Location
                                </td>
                                <td>
                                    <asp:DropDownList ID="drpBaseLocation" runat="server"  CssClass="WebControls" Width="175px" >
                                    </asp:DropDownList>
                                   
                                </td>
                                <td align="right" style="font-weight: bold;">
                                    Card Number
                                </td>
                                <td>
                                    <asp:TextBox ID="txt_CardNumber" runat="server" CssClass="WebControls" Width="175px"></asp:TextBox>
                                </td>
                            </tr>

                            <tr>
                            <td align="right" style="font-weight: bold;">
                                   Access Locations
                                </td>

                            <td colspan=3> <asp:TextBox ID="txt_Location" runat="server"  CssClass="WebControls" Width="275px" ></asp:TextBox>&nbsp;Comma seperated Location Codes</td>
                            </tr>
                            <tr>
                                <td align="right" style="font-weight: bold;">
                                    Emp.Device Password
                                </td>
                                <td>
                                    <asp:TextBox ID="txt_EmpDevicePassword" TextMode="Password" runat="server" CssClass="WebControls"
                                        Width="175px"></asp:TextBox>
                                </td>
                                <td align="right" style="font-weight: bold;">
                                    Device Role
                                </td>
                                <td align="left" style="font-weight: bold;">
                                    <asp:DropDownList ID="drp_Role" runat="server" Width="175px">
                                        <asp:ListItem Text="Normal User" Value="Normal User" Selected></asp:ListItem>
                                        <asp:ListItem Text="Admin User" Value="Admin User"></asp:ListItem>
                                    </asp:DropDownList>
                                </td>
                            </tr>
                            <tr>
                                <td align="right" style="font-weight: bold;">
                                    Verification Type
                                </td>
                                <td>
                                    <asp:DropDownList ID="drp_VerificationType" runat="server" Width="175px">
                                        <asp:ListItem Value="0" Selected Text="Finger or Face or Card or Password"></asp:ListItem>
                                        <asp:ListItem Value="1" Text="Finger"></asp:ListItem>
                                        <asp:ListItem Value="2" Text="User ID"></asp:ListItem>
                                        <asp:ListItem Value="3" Text="Password"></asp:ListItem>
                                        <asp:ListItem Value="4" Text="Card"></asp:ListItem>
                                        <asp:ListItem Value="5" Text="Finger or Password"></asp:ListItem>
                                        <asp:ListItem Value="6" Text="Finger or Card"></asp:ListItem>
                                        <asp:ListItem Value="7" Text="Card or Password"></asp:ListItem>
                                        <asp:ListItem Value="8" Text="User ID and Finger"></asp:ListItem>
                                        <asp:ListItem Value="9" Text="Finger and Password"></asp:ListItem>
                                        <asp:ListItem Value="10" Text="Card and Finger"></asp:ListItem>
                                        <asp:ListItem Value="11" Text="Card and Password"></asp:ListItem>
                                        <asp:ListItem Value="12" Text="Finger and Card and Password"></asp:ListItem>
                                        <asp:ListItem Value="13" Text="User ID and Finger and Password"></asp:ListItem>
                                        <asp:ListItem Value="14" Text="User ID and Finger or Card and Finger"></asp:ListItem>
                                        <asp:ListItem Value="15" Text="Face"></asp:ListItem>
                                        <asp:ListItem Value="16" Text="Face and Finger"></asp:ListItem>
                                        <asp:ListItem Value="17" Text="Face and Password"></asp:ListItem>
                                        <asp:ListItem Value="18" Text="Face and Card"></asp:ListItem>
                                        <asp:ListItem Value="19" Text="Face and Finger and Card"></asp:ListItem>
                                        <asp:ListItem Value="20" Text="Face and Finger and Password"></asp:ListItem>
                                        <asp:ListItem Value="25" Text="Palm"></asp:ListItem>
                                        <asp:ListItem Value="26" Text="Palm and Card"></asp:ListItem>
                                        <asp:ListItem Value="27" Text="Palm and Face"></asp:ListItem>
                                        <asp:ListItem Value="28" Text="Palm and Finger"></asp:ListItem>
                                        <asp:ListItem Value="29" Text="Palm and Finger and Face"></asp:ListItem>
                                        <asp:ListItem Value="200" Text="Other"></asp:ListItem>
                                        <asp:ListItem Value="-1" Text="Apply Group Mode"></asp:ListItem>
                                    </asp:DropDownList>
                                </td>
                                <td align="right" style="font-weight: bold;">GroupId
                                </td>
                                <td >
                                <asp:TextBox ID="Txt_GroupId"  runat="server" CssClass="WebControls"
                                        Width="175px"></asp:TextBox>
                                </td>
                            </tr>

                             <tr>
                                <td align="right" style="font-weight: bold;" valign=top>
                                    Expiry From
                                </td>
                                <td>
                                    <asp:TextBox ID="txt_ExpiryFrom" runat="server"  CssClass="WebControls" Width="175px" ></asp:TextBox><br />&nbsp;&nbsp;yyyy-MM-dd&nbsp;HH:mm:ss
                                </td>
                                <td align="right" style="font-weight: bold;" valign=top>
                                    Expiry To
                                </td>
                                <td>
                                    <asp:TextBox ID="txt_ExpiryTo" runat="server" CssClass="WebControls" Width="175px"></asp:TextBox><br />&nbsp;&nbsp;yyyy-MM-dd&nbsp;HH:mm:ss
                                </td>
                            </tr>
                           
                        </table>
                    </fieldset>
                </td>
                <tr>
                
                 
                                <td align="right" >
                                 <asp:HiddenField ID="Hdn_EmployeeId" runat="server" />
                                 <asp:HiddenField ID="Hdn_SaveOption" runat="server" />
                                    <asp:Label runat="server" ForeColor="red" EnableViewState="false" Text="&nbsp;&nbsp;&nbsp;&nbsp;"
                                        ID="Lbl_InvalidError"></asp:Label>
                                    <input id="btn_Save" type="button" value="Save" onclick="javascript:btn_Save_onclick('Employee');" />&nbsp;&nbsp;<input
                                        id="btn_Cancel" type="button" value="Close" onclick="javascript:closeFlyout_Details();" />
                                </td>
                            </tr>
                          
            </tr>
        </table>
    </obout:Flyout>


        <owd:Window ID="wnd_LocationsDeatils" runat="server" VisibleOnLoad="false"
                     Left="350" Top="155" Height="240"  Width="580"
                    StyleFolder="~/Styles/mainwindow/blue"  Title="Access Locations" IsModal="True" ShowStatusBar="False" ShowCloseButton="true" >               
                <table width="100%" height="100%" cellpadding="1" cellspacing="0" class="rowEditTable" style="border-top-style: none;
                    border-right-style: none; border-left-style: none; border-bottom-style: none;">
                    <tr>
                        <td>
                            <fieldset>
                               
                                <table width="100%" height="100%" >
                                    <tr>
                                        <td style="font-weight: bold;" align="right">
                                            Employee&nbsp;Code
                                        </td>
                                        <td>
                                            <asp:Label ID="lblCode" runat="server" ></asp:Label>
                                        </td>
                                        <td style="font-weight: bold;">
                                            Employee&nbsp;Name</td>
                                        <td>
                                           <asp:Label ID="lblName" runat="server" ></asp:Label>
                                        </td>
                                    </tr>
                                    <tr><td colspan=4>&nbsp;</td></tr>
                                    <tr>
                                        <td>
                                            Access Locations
                                        </td>
                                        <td>
                                            <asp:ListBox ID="lst_AvailableLocations" runat="server" CssClass="WebControls" BorderStyle="Solid"
                                                BorderWidth="1px" SelectionMode="Multiple" Width="130px" Height="131px"></asp:ListBox>
                                        </td>
                                        <td>
                                            <table cellpadding="1">
                                                <tr>
                                                    <td align="center">
                                                        <input type="button" id="btn_next" runat="server" value=">" style="font-size: 11px;
                                                            font-family: Verdana; height: 20px; width: 50px" onclick="btn_next_onclick();" />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td align="center">
                                                        <input type="button" id="btn_NextAll" runat="server" value=">>" style="font-size: 11px;
                                                            font-family: Verdana; height: 20px; width: 50px" onclick="NextAll();" />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td align="center">
                                                        <input type="button" id="btn_Previous" runat="server" value="<" style="font-size: 11px;
                                                            font-family: Verdana; height: 20px; width: 50px" onclick="btn_previous_onclick();" />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td align="center">
                                                        <input type="button" id="btn_PreviousAll" runat="server" value="<<" style="font-size: 11px;
                                                            font-family: Verdana; height: 20px; width: 50px" onclick="PreviousAll();" />
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td>
                                            <asp:ListBox ID="lst_AllowedLocations" runat="server" CssClass="WebControls" BorderStyle="Solid"
                                                BorderWidth="1px" SelectionMode="Multiple" Width="130px" Height="131px"></asp:ListBox>
                                        </td>
                                    </tr>
                                </table>
                            </fieldset>
                        </td>
                    </tr>
                    <tr>
                        <td align="right">
                        <asp:Label runat="server" ForeColor="red" EnableViewState="false" Text="&nbsp;&nbsp;&nbsp;&nbsp;"
                                        ID="Lbl_InvalidError1"></asp:Label>
                            <input id="btn_OK" type="button" value="Save" onclick="javascript:btn_Save_onclick('Locations');" />
                            &nbsp;&nbsp;
                            <input id="Button1" type="button" value="Close" onclick="wnd_LocationsDeatils.Close();"
                                class="WebControls" /></td>
                    </tr>
                    <tr><td>&nbsp;<asp:HiddenField ID="Hdn_Locations" runat="server" />
                    <asp:HiddenField ID="Hdn_SelectedLocations" runat="server" />
                    </td></tr>
                    
                    
                   
                </table>
            </owd:Window>

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


                  function attachWindowToLink(oLink)
		        {	
                  

                    var iRecordIndex = oLink.id.toString().replace("grid_Loc_link_", "");
                    
                    wnd_LocationsDeatils.Open();
                    wnd_LocationsDeatils.screenCenter();
                    document.getElementById("<%=Hdn_EmployeeId.ClientID %>").value = Dg_Employee.Rows[iRecordIndex].Cells[0].Value;
                    document.getElementById("<%=lblCode.ClientID %>").innerHTML  = Dg_Employee.Rows[iRecordIndex].Cells[1].Value;
		            document.getElementById("<%=lblName.ClientID %>").innerHTML  = Dg_Employee.Rows[iRecordIndex].Cells[2].Value;
		            document.getElementById("<%=Lbl_InvalidError1.ClientID %>").innerHTML='';

                    var AllLocationsArray =  document.getElementById("<%=Hdn_Locations.ClientID %>").value.split(",");
                    var LocationsArray =  Dg_Employee.Rows[iRecordIndex].Cells[18].Value.split(",");

                    var lst_AvailableLocations=document.getElementById("<%=lst_AvailableLocations.ClientID %>");
                    var lst_AllowedLocations=document.getElementById("<%=lst_AllowedLocations.ClientID %>");
                   
                   removeAllOption(lst_AllowedLocations);
                   removeAllOption(lst_AvailableLocations);


                   for(var i = 0; i < AllLocationsArray.length; i++) {
                        if (AllLocationsArray[i] != "")
                            lst_AvailableLocations.add(new Option(AllLocationsArray[i],AllLocationsArray[i]));
                   }
                   
                   

                    for(var i = 0; i < LocationsArray.length; i++) {
                      
                       if (LocationsArray[i] != "")
                       {
                            lst_AllowedLocations.add(new Option(LocationsArray[i],LocationsArray[i]));

                            for (var j=0; j<lst_AvailableLocations.length; j++) {
                                

                                if (lst_AvailableLocations.options[j].value.toLowerCase() == LocationsArray[i].toLowerCase())
                                {                           
                                    lst_AvailableLocations.remove(j);
                                }
                                   
                            }
                       }
                       
                    }

                    return;
	                
	                
	              
	                
		        }



                // REMOVE SELECTED OPTIONS         
            
            function removeOptionSelected(object)
                {
                  var k;
                  for (k = object.length - 1; k>=0; k--) {
                    if (object.options[k].selected) {
                      object.remove(k);
                    }
                  }
                }
                
     //REMOVE ALL OPTIONS           
                function removeAllOption(object)
                {
                  var k;
                  for (k = object.length - 1; k>=0; k--) {
                      object.remove(k);
                  }
                }


        function btn_next_onclick()
        
        {
        
        var ListViewObject=document.getElementById("<%=lst_AvailableLocations.ClientID %>");
        var ListExportObject=document.getElementById("<%=lst_AllowedLocations.ClientID %>");
        var i=0
        for(var j=0;j<ListViewObject.options.length;j++)
            {
            if (ListViewObject.options[j].selected)
            {
            var Options=document.createElement("OPTION");
                    ListExportObject.add(new Option(ListViewObject.options[j].text,ListViewObject.options[j].value));
                    i=i+1
              }
            }
            removeOptionSelected(ListViewObject)
            }
            
            
  // NEXT ALL BUTTON ONCLICK      
      
            function NextAll()
            {
          
                var ListViewObject=document.getElementById("<%=lst_AvailableLocations.ClientID %>");
                var ListExportObject=document.getElementById("<%=lst_AllowedLocations.ClientID %>");
                
                 for(var j=0;j<ListViewObject.options.length;j++)
                 {
                       
                     ListExportObject.add(new Option(ListViewObject.options[j].text,ListViewObject.options[j].value));
                 }
                removeAllOption(ListViewObject);
                
               
            }
            

            function btn_previous_onclick()
        
        {
        
        var ListViewObject=document.getElementById("<%=lst_AvailableLocations.ClientID %>");
        var ListExportObject=document.getElementById("<%=lst_AllowedLocations.ClientID %>");
        var i=0
        for(var j=0;j<ListExportObject.options.length;j++)
            {
            if (ListExportObject.options[j].selected)
            {
                ListViewObject.add(new Option(ListExportObject.options[j].text,ListExportObject.options[j].value));
            i=i+1
              }
            }
            removeOptionSelected(ListExportObject)
           
            }
            
            
            
            // PREVIOUS ALL BUTTON ONCLICK      
      
            function PreviousAll()
            {            
                var ListViewObject=document.getElementById("<%=lst_AvailableLocations.ClientID %>");
                var ListExportObject=document.getElementById("<%=lst_AllowedLocations.ClientID %>");
                
                 for(var j=0;j<ListExportObject.options.length;j++)
                 {
                     ListViewObject.add(new Option(ListExportObject.options[j].text,ListExportObject.options[j].value));
                 }
                removeAllOption(ListExportObject);
            }



             function GetSelectedItem()
            {
                document.getElementById("<%=Hdn_SelectedLocations.ClientID %>").value='';
                var ListExportObject=document.getElementById("<%=lst_AllowedLocations.ClientID %>");
                              
                
                for(var j=0;j<ListExportObject.options.length;j++)
                 {
                       document.getElementById("<%=Hdn_SelectedLocations.ClientID %>").value=document.getElementById("<%=Hdn_SelectedLocations.ClientID %>").value+ListExportObject.options[j].text+',';
                 }
            }
            

	        function closeFlyout_Details() 
		    {
		        <%=Flyout1.getClientID()%>.Close();
		    }
		    
		    
		     function btn_Save_onclick(action)
		     {

                document.getElementById("<%=Hdn_SaveOption.ClientID %>").value=action;
                GetSelectedItem();
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
		        document.getElementById("<%=txt_CardNumber.ClientID %>").value = '';
		        document.getElementById("<%=drp_Role.ClientID %>").value = 'Normal User';
                document.getElementById("<%=drp_VerificationType.ClientID %>").value = '0';

                document.getElementById("<%=txt_ExpiryFrom.ClientID %>").value = '2000-01-01';
		        document.getElementById("<%=txt_ExpiryTo.ClientID %>").value = '3000-01-01';
		        
                document.getElementById("<%=txt_EmpDevicePassword.ClientID %>").value = '';
                document.getElementById("<%=txt_GroupId.ClientID %>").value = '1';

                document.getElementById("<%=drpBaseLocation.ClientID %>").value = '0';

		        document.getElementById("<%=Lbl_InvalidError.ClientID %>").innerHTML='';

                document.getElementById("<%=txt_Employeecode.ClientID %>").disabled = false;
               }

           
         
		    
		     function populateEditControls(iRecordIndex) 
		    {	
                
                
		        document.getElementById("<%=Hdn_EmployeeId.ClientID %>").value = Dg_Employee.Rows[iRecordIndex].Cells[0].Value;
		        document.getElementById("<%=txt_Employeecode.ClientID %>").value = Dg_Employee.Rows[iRecordIndex].Cells[1].Value;
		        document.getElementById("<%=txt_employeeName.ClientID %>").value = Dg_Employee.Rows[iRecordIndex].Cells[2].Value;
		        document.getElementById("<%=drpBaseLocation.ClientID %>").value = Dg_Employee.Rows[iRecordIndex].Cells[17].Value;
                document.getElementById("<%=txt_Location.ClientID %>").value = Dg_Employee.Rows[iRecordIndex].Cells[18].Value;
                document.getElementById("<%=drp_Role.ClientID %>").value = Dg_Employee.Rows[iRecordIndex].Cells[5].Value;
		        document.getElementById("<%=txt_CardNumber.ClientID %>").value = Dg_Employee.Rows[iRecordIndex].Cells[6].Value;
                document.getElementById("<%=drp_VerificationType.ClientID %>").value = Dg_Employee.Rows[iRecordIndex].Cells[7].Value;
                document.getElementById("<%=txt_ExpiryFrom.ClientID %>").value = Dg_Employee.Rows[iRecordIndex].Cells[14].Value.replace("T", " ");
                document.getElementById("<%=txt_ExpiryTo.ClientID %>").value = Dg_Employee.Rows[iRecordIndex].Cells[15].Value.replace("T", " ");
                document.getElementById("<%=txt_GroupId.ClientID %>").value = Dg_Employee.Rows[iRecordIndex].Cells[16].Value;
                                
                document.getElementById("<%=txt_Employeecode.ClientID %>").disabled = true;
		                  


		   }


           

		    
		   
    </script>


    <script type="text/javascript">
        function OpenPopUpWindow(url) {
            var iMyWidth;
            var iMyHeight;
            iMyWidth = (window.screen.width / 2) - (75 + 10);
            iMyHeight = (window.screen.height / 2) - (100 + 50);
            window.open(url, "PopupChild", "status=no,height=250,width=300,resizable=yes,left=" + iMyWidth + ",top=" + iMyHeight + ",screenX=" + iMyWidth + ",screenY=" + iMyHeight + ",toolbar=no,menubar=no,scrollbars=no,location=no,directories=no");
        }

        function ReloadGrid() {
            window.grid_SystemUsers.refresh();

        }  
    </script>

</body>
</html>
