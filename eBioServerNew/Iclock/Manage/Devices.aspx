<%@ page language="VB" autoeventwireup="false" inherits="Manage_DeviceList, App_Web_v2kwzk4v" enableEventValidation="false" %>

<%@ Register TagPrefix="obout" Namespace="Obout.Grid" Assembly="obout_Grid_NET" %>
<%@ Register TagPrefix="obout" Namespace="OboutInc.Flyout2" Assembly="obout_Flyout2_NET" %>
<%@ Register TagPrefix="uctrl" Src="~/Header.ascx" TagName="header" %>
<%@ Register TagPrefix="owd" Namespace="OboutInc.Window" Assembly="obout_Window_NET" %>
<%@ Register TagPrefix="obout" Namespace="OboutInc.Combobox" Assembly="obout_Combobox_Net" %>
<%@ Register Assembly="obout_Calendar2_Net" Namespace="OboutInc.Calendar2" TagPrefix="obout" %>

<script type="text/javascript">
    // Client-Side Events for Delete
    function OnBeforeDelete(record) {
        record.Error = '';
        document.getElementById("<%=Hdn_DeviceId.ClientID %>").value = record.DeviceId;
        document.getElementById("<%=Hdn_DeviceName.ClientID %>").value = record.DeviceSName;
        if (confirm("Are you sure you want to delete? "))
            return true;
        else
            return false;
    }

    function OnDelete(record) {
        alert(record.Error);
    }

    function OnInsert(record) {
        document.getElementById("<%=Lbl_InvalidError.ClientID %>").innerHTML = record.Error;
    }

    function isNumberKey(evt) {
        var charCode = (evt.which) ? evt.which : event.keyCode
        if (charCode > 31 && (charCode < 48 || charCode > 57))
            return false;

        return true;
    }
	
</script>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" >
<html >
<head id="Head1" runat="server">
    <title>Untitled Page</title>
    <link href="../StyleSheet.css" rel="stylesheet" type="text/css" />

        <script type="text/javascript">
            function SelectDeselect(oCheckbox) {


                var oElement = oCheckbox.parentNode;
                while (oElement != null && oElement.nodeName != "TR") {
                    oElement = oElement.parentNode;
                }

                if (oElement != null) {
                    // oElement represents the row where the clicked      
                    // checkbox reside
                    var oContainer = oElement.parentNode;
                    var iRecordIndex = -1;
                    for (var i = 0; i < oContainer.childNodes.length; i++) {
                        if (oContainer.childNodes[i] == oElement) {
                            iRecordIndex = i;

                            break;
                        }
                    }

                    if (iRecordIndex != -1) {
                        if (oCheckbox.checked == true) {
                            // select the record
                            grid_Devices.selectRecord(iRecordIndex);
                        } else {
                            // deselect the record
                            grid_Devices.deselectRecord(iRecordIndex);
                        }
                    }
                }
            }

            function stopEventPropagation(e) {
                if (!e) { e = window.event; }
                if (!e) { return false; }
                e.cancelBubble = true;
                if (e.stopPropagation) { e.stopPropagation(); }
            }


            function assignEventsToCheckboxes() {

                var sRecordsIds = grid_Devices.getRecordsIds();

                if (sRecordsIds != null && sRecordsIds.length > 0) {

                    var arrRecordsIds = sRecordsIds.split(",");
                    for (var i = 0; i < arrRecordsIds.length; i++) {
                        var oRecord = document.getElementById(arrRecordsIds[i]);
                        oRecord.onmousedown = function (e) { stopEventPropagation(e); };
                        oRecord.onclick = function (e) { stopEventPropagation(e); };
                    }

                    // populate the previously checked checkboxes
                    var arrPageSelectedRecords = grid_Devices.PageSelectedRecords;

                    for (var i = 0; i < arrPageSelectedRecords.length; i++) {
                        var oCheckbox = document.getElementById("chk_grid_" + arrPageSelectedRecords[i].DeviceId);
                        oCheckbox.checked = true;
                    }

                    // enable the record selection feature by selecting the checkboxes
                    var arrCheckboxes = document.getElementsByTagName("INPUT");
                    for (var i = 0; i < arrCheckboxes.length; i++) {
                        if (arrCheckboxes[i].type == "checkbox" && arrCheckboxes[i].id.indexOf("chk_grid_") == 0) {
                            arrCheckboxes[i].onmousedown = function (e) { stopEventPropagation(e); };
                            arrCheckboxes[i].onclick = function (e) { SelectDeselect(this); stopEventPropagation(e); };
                        }
                    }
                }

            }

    </script>




</head>

   <uctrl:header ID="Header1" runat="server" />

<body >
    <form id="form1" runat="server">
    <div>
        <uctrl:header ID="MyHeader" runat="server" />
          <table cellpadding="0" cellspacing="0" style="border-right: gray 1px solid; border-top: gray 1px solid;
        border-left: gray 1px solid; border-bottom: gray 1px solid;">
        <tr style="font-weight: bold; font-size: 14px; background-color: lightsteelblue;
            padding-left: 5px; padding-top: 3px; padding-bottom: 3px; color: white;">
                <td style="font-weight: bold; font-size: 14px; background-color: lightsteelblue;
                    padding: 5px; color: white; height: 27px;">
                    Device List
                </td>
                <td align="right">
                    
                </td>
            </tr>
            <tr style="background-color: lightsteelblue;">
                <td colspan="2" style="text-align: right;font-weight: normal; font-size: 11px; ">
                    <hr />

                    Auto Refresh Grid
                    <asp:DropDownList ID="ddlAutoRefresh" runat="server" AutoPostBack="false">
                        <asp:ListItem Value="10000">10</asp:ListItem>
                        <asp:ListItem Value="20000">20</asp:ListItem>
                        <asp:ListItem Value="30000">30</asp:ListItem>
                        <asp:ListItem Value="40000">40</asp:ListItem>
                        <asp:ListItem Value="50000">50</asp:ListItem>
                        <asp:ListItem Value="60000">60</asp:ListItem>
                    </asp:DropDownList>
                    &nbsp;<span style="font-size: x-small;">in&nbsp;Seconds&nbsp;</span>&nbsp;                    &nbsp; Page Size
                    <asp:TextBox ID="txtPageSize" runat="server" Onkeypress="return isNumberKey(event)"
                        Width="40" Text="100" />
                    &nbsp;
                    <input type="button" class="tdText" value="Refresh" onclick="grid_Devices.refresh()"
                        id="btn_Refresh" />
                    &nbsp; Select Command
                    <asp:DropDownList ID="ddlCommand" runat="server" Width="200">
                        <asp:ListItem>--Select--</asp:ListItem>
                        <asp:ListItem>Reset Transaction Stamp</asp:ListItem>
                        <asp:ListItem>Reset Operation Stamp</asp:ListItem>
                        <asp:ListItem>Get Device Logs By Date Time</asp:ListItem>
                        <asp:ListItem>Block User</asp:ListItem>
                        <asp:ListItem>UnBlock User</asp:ListItem>
                        <asp:ListItem>Enroll User Fingerprint</asp:ListItem>
                        <asp:ListItem>Enroll User Face</asp:ListItem>
                        <asp:ListItem>Enroll User Face Ex</asp:ListItem>
                        <asp:ListItem>Clear Logs from Device</asp:ListItem>
                        <asp:ListItem>Change Webserver Address</asp:ListItem>
                        <asp:ListItem>Change Webserver Port</asp:ListItem>
                        <asp:ListItem>Unlock Door</asp:ListItem>
                        <asp:ListItem>Reboot Device</asp:ListItem>

                        
                    </asp:DropDownList>
                    <input id="btnExecuteCommand" type="button" onclick="ExecuteCommands();" value="Execute"
                        />
                </td>
            </tr>
            <tr>
                <td colspan="2">
                    <div id="div_Employees">
                        <obout:Grid ID="grid_Devices" runat="server" CallbackMode="true" EnableRecordHover="true" AllowRecordSelection="true"
                            AllowMultiRecordSelection="True" KeepSelectedRecords="true" Serialize="true"
                            AllowPageSizeSelection="true" AllowFiltering="true" AutoGenerateColumns="false" FolderStyle="~/styles/grid/styles/premiere_blue"
                            AllowAddingRecords="true" ShowLoadingMessage="false" OnRebind="RebindGrid"  OnInsertCommand="InsertRecord"
                            OnDeleteCommand="DeleteRecord" GenerateRecordIds="true" AllowSorting=true>
                            <ClientSideEvents OnClientInsert="OnInsert" OnBeforeClientDelete="OnBeforeDelete"
                                OnClientDelete="OnDelete" OnClientCallback="assignEventsToCheckboxes"  />
                            <TemplateSettings NewRecord_TemplateId="tplAddBtn" />
                            <Columns>
                                <obout:Column ID="Column2" DataField="DeviceId" Visible="False" Width="300" HeaderText="DeviceId"
                                    ConvertEmptyStringToNull="False" Index="0" />
                                <obout:Column ID="Column44" DataField="SerialNumber1" ReadOnly="True" HeaderText="."
                                    Width="40" ShowHeader="false"   ConvertEmptyStringToNull="False" Index="1" TemplateId="TemplateWithCheckbox">
                                    <TemplateSettings TemplateId="TemplateWithCheckbox"  />
                                </obout:Column>
                                <obout:Column ID="Column1" DataField="DeviceName" SortOrder="Asc" Width="110" HeaderText="Device Name"
                                    ConvertEmptyStringToNull="False" Index="2" />
                                <obout:Column ID="Column7" DataField="SerialNumber" Width="100" HeaderText="Serial No."
                                    ConvertEmptyStringToNull="False" Index="3" />
                                <obout:Column ID="Column8" DataField="DeviceDirection" Width="70" HeaderText="Direction"
                                    ConvertEmptyStringToNull="False" Index="4" />
                                <obout:Column ID="Column13" DataField="TimeZone" Width="70" HeaderText="Time Zone"
                                    ConvertEmptyStringToNull="False" Index="5" />
                                <obout:Column ID="Column14" DataField="Location" Width="100" HeaderText="Location"
                                    ConvertEmptyStringToNull="False" Index="6">
                                </obout:Column>
                             

                                <obout:Column ID="Column6" Width="130" HeaderText="Last Ping" DataField="LastPing"
                                    ConvertEmptyStringToNull="False" Index="7" TemplateId="LastPing_Template">
                                    <TemplateSettings TemplateId="LastPing_Template" />
                                </obout:Column>
                                <obout:Column ID="Column3" Width="130" HeaderText="Last Reset" DataField="LastReset"
                                    ConvertEmptyStringToNull="False" Index="8" TemplateId="LastPing_Template">
                                    <TemplateSettings TemplateId="LastReset_Template" />
                                </obout:Column>

                                

                                <obout:Column ID="Column12" Width="75" HeaderText="Status" ConvertEmptyStringToNull="False"
                                    Index="9" TemplateId="DeviceStatus_Template">
                                    <TemplateSettings TemplateId="DeviceStatus_Template" />
                                </obout:Column>
                                <obout:Column ID="Column22"  Width="110" HeaderText="Activation Status" TemplateId="tplValidateActivation"
                                    ConvertEmptyStringToNull="False" Index="10" >
                                    <TemplateSettings TemplateId="tplValidateActivation" />
                                    </obout:Column>
                                <obout:Column Width="110" ConvertEmptyStringToNull="False" Index="11" TemplateId="tplViewUsersInDeviceBtn">
                                    <TemplateSettings TemplateId="tplViewUsersInDeviceBtn" />
                                </obout:Column>


                                <obout:Column Width="90" ConvertEmptyStringToNull="False" Index="12" TemplateId="tplViewGroupsInDeviceBtn">
                                    <TemplateSettings TemplateId="tplViewGroupsInDeviceBtn" />
                                </obout:Column>

                                <obout:Column Width="80" ConvertEmptyStringToNull="False" Index="13" TemplateId="tplViewTimePeriodsInDeviceBtn">
                                    <TemplateSettings TemplateId="tplViewTimePeriodsInDeviceBtn" />
                                </obout:Column>



                                <obout:Column HeaderText="Edit" Width="45" AllowEdit="True" AllowDelete="True" ConvertEmptyStringToNull="False"
                                    Index="14" TemplateId="tplEditBtn">
                                    <TemplateSettings TemplateId="tplEditBtn" />
                                </obout:Column>
                                <obout:Column HeaderText="Delete" Width="80" AllowDelete="True" ConvertEmptyStringToNull="False"
                                    Index="15" />
                                
                                <obout:Column ID="Column21" DataField="ActivationCode" Visible="False" Width="200"
                                    HeaderText="DeviceActivationCode" ConvertEmptyStringToNull="False" Index="16" />
                                <obout:Column ID="Column4" DataField="DeviceType" Visible="False" Width="200"
                                    HeaderText="DeviceType" ConvertEmptyStringToNull="False" Index="17" />

                              <obout:Column ID="Column5" DataField="IsAttendanceDevice" Visible=false Width="100" HeaderText="IsAttendanceDevice"
                                    ConvertEmptyStringToNull="False" Index="18">
                                </obout:Column>

                                 <obout:Column ID="Column9" DataField="LocationId" Visible=false Width="100" HeaderText="LocationId"
                                    ConvertEmptyStringToNull="False" Index="19">
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
                                            <%# CheckPermissions("Add", "AddDevices")%></a>
                                    </Template>
                                </obout:GridTemplate>
                                <obout:GridTemplate runat="server" ID="tplViewUsersInDeviceBtn" ControlID="" ControlPropertyName="">
                                    <Template>
                                        <asp:HyperLink runat="server" CssClass="ob_gAL" Style="cursor: hand;" Text='<%# CheckPermissions("Employees","DeviceEmployees")%>'
                                            NavigateUrl='<%# CheckPermissions("~/Manage/DeviceEmployees.aspx?Id=" + URLEncode("DeviceId=" + Container.DataItem.Item("DeviceId")+"&DeviceName=" + Container.DataItem.Item("DeviceName")+"&SerialNumber=" + Container.DataItem.Item("SerialNumber")),"DeviceEmployees")%>'
                                            ID="AA1" />
                                   &nbsp;

                                        <asp:HyperLink runat="server" CssClass="ob_gAL" Style="cursor: hand;" Text='<%# CheckPermissions("Visitors","DeviceVisitors")%>'
                                            NavigateUrl='<%# CheckPermissions("~/Manage/DeviceVisitors.aspx?Id=" + URLEncode("DeviceId=" + Container.DataItem.Item("DeviceId")+"&DeviceName=" + Container.DataItem.Item("DeviceName")+"&SerialNumber=" + Container.DataItem.Item("SerialNumber")),"DeviceVisitors")%>'
                                            ID="AA2" />

                                    </Template>
                                </obout:GridTemplate>


                                <obout:GridTemplate runat="server" ID="tplViewGroupsInDeviceBtn" ControlID="" ControlPropertyName="">
                                    <Template>
                                        <asp:HyperLink runat="server" CssClass="ob_gAL" Style="cursor: hand;" Text='<%# CheckPermissions("Access Groups","DeviceGroups")%>'
                                            NavigateUrl='<%# CheckPermissions("~/Manage/DeviceGroups.aspx?Id=" + URLEncode("DeviceId=" + Container.DataItem.Item("DeviceId")+"&DeviceName=" + Container.DataItem.Item("DeviceName")+"&SerialNumber=" + Container.DataItem.Item("SerialNumber")),"DeviceGroups")%>'
                                            ID="AA1" />
                                    </Template>
                                </obout:GridTemplate>


                                <obout:GridTemplate runat="server" ID="tplViewTimePeriodsInDeviceBtn" ControlID="" ControlPropertyName="">
                                    <Template>
                                        <asp:HyperLink runat="server" CssClass="ob_gAL" Style="cursor: hand;" Text='<%# CheckPermissions("Time Periods","DeviceTimePeriods")%>'
                                            NavigateUrl='<%# CheckPermissions("~/Manage/DeviceTimePeriods.aspx?Id=" + URLEncode("DeviceId=" + Container.DataItem.Item("DeviceId")+"&DeviceName=" + Container.DataItem.Item("DeviceName")+"&SerialNumber=" + Container.DataItem.Item("SerialNumber")),"DeviceTimePeriods")%>'
                                            ID="AA1" />
                                    </Template>
                                </obout:GridTemplate>



                                <obout:GridTemplate runat="server" ID="LastPing_Template">
                                    <Template>
                                        <%#ParseLastPing(Container.DataItem.Item("LastPing"))%>
                                    </Template>
                                </obout:GridTemplate>

                                <obout:GridTemplate runat="server" ID="LastReset_Template">
                                    <Template>
                                        <%# ParseLastPing(Container.DataItem.Item("LastReset"))%>
                                    </Template>
                                </obout:GridTemplate>

                                <obout:GridTemplate runat="server" ID="DeviceStatus_Template">
                                    <Template>
                                        <asp:Label ID="Label1" runat="server" Text='<%#DeviceStatus(Container.DataItem.Item("LastPing"),Container.DataItem.Item("TimeOut"))%>'
                                            ForeColor='<%#ChangeColorOnDeviceStatusCheck(Container.DataItem("LastPing"),Container.DataItem("TimeOut")) %>'></asp:Label>
                                    </Template>
                                </obout:GridTemplate>
                                <obout:GridTemplate runat="server" ID="TemplateWithCheckbox" >
                                    <Template>
                                            <input type="checkbox"   id="chk_grid_<%# Container.DataItem("DeviceId") %>" tooltip='<%# Container.Value %>' />
                                    </Template>
                                </obout:GridTemplate>

                                <obout:GridTemplate runat="server" ID="tplValidateActivation">
                                    <Template>
                                            
                                            <%# ValidateActivation(Container.DataItem.Item("ActivationCode"))%>
                                    </Template>
                                </obout:GridTemplate>

                            </Templates>
                        </obout:Grid>
                    </div>
                </td>
            </tr>
        </table>
        <obout:Flyout runat="server" ID="Flyout1" Align="left" Position="BOTTOM_left" CloseEvent="NONE"
            OpenEvent="NONE" DelayTime="500">
            <table class="rowEditTable">
                <tr>
                    <td>
                        <fieldset>
                            <legend>Device Information</legend>
                            <table>
                                <tr>
                                    <td style="font-weight: bold;width:80px;" >
                                        Device Name
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txt_DeviceName" Width="170px" runat="server"></asp:TextBox>
                                    </td>
                                     <td style="font-weight: bold;width:100px;">
                                        Serial Number
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txt_SerialNo" Width="170px" runat="server"></asp:TextBox>
                                    </td>
                                </tr>
                                
                                <tr>
                                   
                                    <td>
                                        Location
                                    </td>
                                    <td>
                                    <asp:DropDownList ID="drpBaseLocation" runat="server"  CssClass="WebControls" Width="170px"></asp:DropDownList>
                                   
                                </td>
                                    <td style="font-weight: bold;">
                                        Time Zone
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txt_TimeZone" Width="170px" runat="server"></asp:TextBox>
                                    </td>
                                </tr>
                               
                                <tr>
                                    <td>
                                        Direction
                                    </td>
                                    <td>

                                        <asp:DropDownList ID="drp_DeviceDiretion" runat="server"  Width="170px">
                                   


                                    <asp:ListItem  value="IN" selected Text="IN"></asp:ListItem>
                                    <asp:ListItem  value="OUT" Text="OUT"></asp:ListItem>
                                    <asp:ListItem  value="INOUT" Text="INOUT"></asp:ListItem>
                                    <asp:ListItem  value="DEVICE" Text="DEVICE"></asp:ListItem>

                                    </asp:DropDownList>

                                        
                                    </td>
                                    
                                
                                    <td style="font-weight: bold;">
                                        Activation Code
                                    </td>
                                    <td colspan="3">
                                         <asp:TextBox ID="txt_DeviceActivationCode" runat="server" Width="170px"></asp:TextBox>
                                    </td>
                                </tr>


                                <tr>
                                    <td>
                                        Device Type
                                    </td>
                                    <td>

                                        <asp:DropDownList ID="drp_DeviceType" runat="server"  Width="170px">
                                   


                                    <asp:ListItem  value="" selected Text="Non AI"></asp:ListItem>
                                    <asp:ListItem  value="AI" Text="AI Device"></asp:ListItem>

                                    </asp:DropDownList>

                                        
                                    </td>
                                    
                                
                                    <td >
                                       Is&nbsp;Attendance&nbsp;Device
                                    </td>
                                    <td colspan="3">
                                         <asp:DropDownList ID="drpIsAttendanceDevice" runat="server"  Width="170px">
                                   


                                    <asp:ListItem  value="0" selected Text="No"></asp:ListItem>
                                    <asp:ListItem  value="1" Text="Yes"></asp:ListItem>

                                    </asp:DropDownList>
                                    </td>
                                </tr>






                            </table>
                        </fieldset>
                    </td>
                </tr>
                <tr>
                    <td align="right">
                        <input id="btn_Save" type="button" value="Save" onclick="javascript:btn_Save_onclick();" />&nbsp;&nbsp;&nbsp;&nbsp;<input
                            id="btn_Cancel" type="button" value="Close" onclick="javascript:closeFlyout();" />
                    </td>
                </tr>
                <tr>
                    <td>
                        &nbsp; &nbsp; &nbsp;
                        <asp:Label runat="server" ForeColor="red" EnableViewState="false" ID="Lbl_InvalidError"></asp:Label>
                        <asp:HiddenField ID="Hdn_DeviceId" runat="server" />
                        <asp:HiddenField ID="Hdn_SerialNumber" runat="server" />
                        <asp:HiddenField ID="Hdn_DeviceName" runat="server" />
                    </td>
                </tr>
            </table>
        </obout:Flyout>

        <owd:Window ID="WndCommand0" runat="server" IsModal="true" Height="100" Width="330"
            StyleFolder="~/Styles/mainwindow/blue" Title="Clear Logs From Device" VisibleOnLoad="false"
            ShowCloseButton="false" ShowStatusBar="False" Left="450" Top="120">
            <table class="rowEditTable" width="100%" height="100%">
                <tr>
                    <td>
                        <fieldset>
                            <table>
                                <tr>
                                    <td>
                                        <asp:CheckBox ID="chkSelected0" onclick="flip(this,'0','0');" runat="server" Text="For Selected Devices" />
                                        &nbsp;&nbsp;
                                        <asp:CheckBox ID="chkAll0" runat="server" onclick="flip(this,'1','0');" Text="For All Devices" />
                                    </td>
                                </tr>

                                                           </table>
                        </fieldset>
                    </td>
                </tr>
                <tr>
                    <td align="right">
                        <asp:Button ID="btnOk" runat="server" Text="Ok" />&nbsp;
                        <input id="Button6" onclick="CloseAndClearAll('WndCommand0');" 
                            type="button" value="Close" />
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="Label6" runat="server" EnableViewState="false"></asp:Label>
                    </td>
                </tr>
            </table>
        </owd:Window>


        <owd:Window ID="WndCommand1" runat="server" IsModal="true" Height="150" Width="330"
            StyleFolder="~/Styles/mainwindow/blue" Title="Clear Logs From Device" VisibleOnLoad="false"
            ShowCloseButton="false" ShowStatusBar="False" Left="450" Top="120">
            <table class="rowEditTable" width="100%" height="100%">
                <tr>
                    <td>
                        <fieldset>
                            <table>
                                <tr>
                                    <td>
                                        <asp:CheckBox ID="chkSelected1" onclick="flip(this,'0','1');" runat="server" Text="For Selected Devices" />
                                        &nbsp;&nbsp;
                                        <asp:CheckBox ID="chkAll1" runat="server" onclick="flip(this,'1','1');" Text="For All Devices" />
                                    </td>
                                </tr>

                                <tr>
                                    <td>

                                      <div  runat="server"  id="CommandRow1">
                                        
                                          <table style="width:100%">
                                        <tr>
                                        
                                        <td><asp:Label ID="CustomLabel" runat="server" Text="User Id" ></asp:Label></asp:Label>
                                        </td>
                                        <td>  <asp:TextBox ID="CustomTextBox1" runat="server"></asp:TextBox>
                                        </td>
                                       
                                        </tr>

                                         </table>
                                       
                                         

                                        </div>
                                        </td>
                                       

                                       
                                 
                                </tr>

                          
                            </table>
                        </fieldset>
                    </td>
                </tr>
                <tr>
                    <td align="right">
                        <asp:Button ID="btn1" runat="server" Text="Ok" />&nbsp;
                        <input id="btnClose" onclick="CloseAndClearAll('WndCommand1');" 
                            type="button" value="Close" />
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="Label3" runat="server" EnableViewState="false"></asp:Label>
                    </td>
                </tr>
            </table>
        </owd:Window>


         <owd:Window ID="WndCommand2" runat="server" IsModal="true" Height="200" Width="330"
            StyleFolder="~/Styles/mainwindow/blue" Title="Clear Logs From Device" VisibleOnLoad="false"
            ShowCloseButton="false" ShowStatusBar="False" Left="450" Top="120">
            <table class="rowEditTable" width="100%" height="100%">
                <tr>
                    <td>
                        <fieldset>
                            <table>
                                <tr>
                                    <td>
                                        <asp:CheckBox ID="chkSelected2" onclick="flip(this,'0','2');" runat="server" Text="For Selected Devices" />
                                        &nbsp;&nbsp;
                                        <asp:CheckBox ID="chkAll2" runat="server" onclick="flip(this,'1','2');" Text="For All Devices" />
                                    </td>
                                </tr>

                                <tr>
                                    <td>

                                                                            
                                        <div  runat="server" id="CommandRow2">
                                        
                                         <table style="width:100%">
                                        <tr>
                                        
                                        <td><asp:Label ID="CommandRow2Label1" runat="server" Text="User Id"></asp:Label>
                                        </td>
                                        <td><asp:TextBox ID="TextBoxUserId" runat="server"></asp:TextBox>
                                        </td>
                                        </tr>

                                        <tr>
                                        
                                        <td> <asp:Label ID="Label4" runat="server" Text="Index"></asp:Label>
                                        </td>
                                        <td> <asp:TextBox ID="TextBoxIndex" runat="server"></asp:TextBox>
                                        </td>
                                        </tr>


                                        </table>
                                        
                                         
                                         
                                        
                                        

                                        </div>
                                        
                                       
                                        
                                       
                                    </td>
                                </tr>
                            </table>
                        </fieldset>
                    </td>
                </tr>
                <tr>
                    <td align="right">
                        <asp:Button ID="btn2" runat="server" Text="Ok" />&nbsp;
                        <input id="Button2" onclick="CloseAndClearAll('WndCommand2');" 
                            type="button" value="Close" />
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="Label2" runat="server" EnableViewState="false"></asp:Label>
                    </td>
                </tr>
            </table>
        </owd:Window>


        <owd:Window ID="WndCommand3" runat="server" IsModal="true" Height="200" Width="330"
            StyleFolder="~/Styles/mainwindow/blue" Title="Clear Logs From Device" VisibleOnLoad="false"
            ShowCloseButton="false" ShowStatusBar="False" Left="450" Top="120">
            <table class="rowEditTable" width="100%" height="100%">
                <tr>
                    <td>
                        <fieldset>
                            <table>
                                <tr>
                                    <td>
                                        <asp:CheckBox ID="chkSelected3" onclick="flip(this,'0','3');" runat="server" Text="For Selected Devices" />
                                        &nbsp;&nbsp;
                                        <asp:CheckBox ID="chkAll3" runat="server" onclick="flip(this,'1','3');" Text="For All Devices" />
                                    </td>
                                </tr>

                                <tr>
                                    <td>

                                                                             
                                        <div  runat="server" id="CommandRow3">

                                        <table style="width:100%">
                                        <tr>
                                        
                                        <td><asp:Label ID="LabelName1" runat="server" Text="From Date"></asp:Label></td>
                                        
                                        <td> <asp:TextBox ID="TextBoxFromDate" runat="server"></asp:TextBox>
                                             <obout:Calendar ID="Calendar1" runat="server" DateFormat="yyyy-MM-dd hh:mm:ss" DatePickerImagePath="~/Images/icon2.gif"
                                                DatePickerMode="True" TextBoxId="TextBoxFromDate" ShowTimeSelector="true">
                                            </obout:Calendar></td></tr>

                                         <tr>
                                         <td><asp:Label ID="LabelName2" runat="server" Text="To Date"></asp:Label></td>
                                         <td><asp:TextBox ID="TextBoxToDate" runat="server"></asp:TextBox>
                                             <obout:Calendar ID="Calendar2" runat="server" DateFormat="yyyy-MM-dd hh:mm:ss" DatePickerImagePath="~/Images/icon2.gif"
                                                DatePickerMode="True" TextBoxId="TextBoxToDate" ShowTimeSelector="true">
                                            </obout:Calendar></td>
                                         
                                         </tr>

                                        
                                        </table>

                                            
                                           

                                            <br />

                                            
                                            
                                        </div>

                                        
                                       
                                    </td>
                                </tr>
                            </table>
                        </fieldset>
                    </td>
                </tr>
                <tr>
                    <td align="right">
                        <asp:Button ID="btn3" runat="server" Text="Ok" />&nbsp;
                        <input id="Button4" onclick="CloseAndClearAll('WndCommand3');" 
                            type="button" value="Close" />
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="Label5" runat="server" EnableViewState="false"></asp:Label>
                    </td>
                </tr>
            </table>
        </owd:Window>




          <asp:HiddenField ID="hidSelectedCommand" runat="server" />
         <div Style="display: none;">  <asp:Button ID="btnClearGridSelection" runat="server"  Text="Close" /></div>
        <asp:HiddenField ID="HiddenSelectedCommandWindow" runat="server" />


    </div>
    </form>
    <script type="text/javascript">
        document.getElementById("ob_drp_LocationContainer").style.zIndex = "99999";
    </script>
    <script runat="server">
        
        Function ValidateActivation(ByVal ActivationCode As String) As String
            If ActivationCode = "" Or ActivationCode = "0" Then
                Return "Not Active"
            Else
                Return "Active"
            End If
        End Function
        
        
        Function CheckPermissions(ByVal Action As String, ByVal Permission As String) As String
            If Not Session.Item("LoginUser") Is Nothing Then
                If CType(Session("LoginUser"), eBioServerLibrary.Data.Admin.User).PermissionList.Contains(Permission) Then
                    Return Action
                End If
                Return ""
            End If
        End Function
        
        Function ParseLastPing(ByVal LastCheckDate As String)
            Try
                If CDate(LastCheckDate) < CDate("1910-01-01") Then
                    Return ""
                Else
                    Return CDate(LastCheckDate).ToString("dd-MMM-yyyy HH:mm:ss")
                End If
            Catch ex As Exception
                Return ""
            End Try
        End Function
        
        Function DeviceStatus(ByVal LastCheckDate As String, TimeOut As String)
            Try
                If TimeOut = "" Then
                    TimeOut = 300
                End If
            
                If DateDiff(DateInterval.Second, CDate(LastCheckDate), CDate(Now.ToString("dd-MMM-yyyy HH:mm:ss"))) > TimeOut Then
                    Return "offline"
                Else
                    Return "online"
                End If
                Return "offline"
            Catch ex As Exception
                Return "offline"
            End Try
        End Function
        
        Function ChangeColorOnDeviceStatusCheck(ByVal LastCheckDate As String, TimeOut As String) As System.Drawing.Color
            Try
                If TimeOut = "" Then
                    TimeOut = 300
                End If
            
                If DateDiff(DateInterval.Second, CDate(LastCheckDate), CDate(Now.ToString("dd-MMM-yyyy HH:mm:ss"))) > TimeOut Then
                    Return Drawing.Color.Red
                Else
                    Return Drawing.Color.Green
                End If
                Return Drawing.Color.Red
            Catch ex As Exception
                Return Drawing.Color.Red
            End Try
        End Function
        
        Function URLEncode(ByVal url) As String
            url = url + "&sessionid=" + Session.SessionID
            Return eBioServerLibrary.Utilities.URLEncodeDecode.Encode(url)
            
        End Function
        
    </script>
    <script type="text/javascript">
	
    function flip(cb,strVal,strCMD)
    {

        
         if (cb.checked)
         {
            if(strVal=='0')
            {

                if (strCMD=='1')
                {
                    document.getElementById('<%=chkAll1.ClientID %>').checked=false;
                }
                else if  (strCMD=='2')
                {
                    document.getElementById('<%=chkAll2.ClientID %>').checked=false;
                }
                else if  (strCMD=='3')
                {
                    document.getElementById('<%=chkAll3.ClientID %>').checked=false;
                }
                else
                {
                     document.getElementById('<%=chkAll0.ClientID %>').checked=false;
                }
              
            }
            else
            {

                if (strCMD=='1')
                {
                    document.getElementById('<%=chkSelected1.ClientID %>').checked=false;
                }
                else if  (strCMD=='2')
                {
                    document.getElementById('<%=chkSelected2.ClientID %>').checked=false;
                }
                else if  (strCMD=='3')
                {
                    document.getElementById('<%=chkSelected3.ClientID %>').checked=false;
                }
               else
                {
                     document.getElementById('<%=chkSelected0.ClientID %>').checked=false;
                }
            
            }
         }
    }
        
        
   
    
    function AlertMessage()
    {
      var hidValue=document.getElementById('<%=hidSelectedCommand.ClientID %>').value;
      if(hidValue=='Clear Logs From Device')
      {
         return confirm('Are you sure you want to delete all the logs from device.');
      }
    }	 
    
    
    function ExecuteCommands()
    {
      var SelectedCommand=document.getElementById('<%=ddlCommand.ClientID %>').value;
      document.getElementById('<%=hidSelectedCommand.ClientID %>').value=SelectedCommand;

      
      
      
      if(SelectedCommand=='--Select--')
        {
          alert("Please select command");
        }
      else if(SelectedCommand=='Reset Transaction Stamp')
        {
         
          
          
          WndCommand0.setTitle('Reset Transaction Stamp');
        

         
          WndCommand0.Open();
          WndCommand0.screenCenter();
          
        
        }
      else if(SelectedCommand=='Reset Operation Stamp')
        {

         
        
          WndCommand0.setTitle('Reset OpStamp');
          WndCommand0.Open();
          WndCommand0.screenCenter();
        }

else if(SelectedCommand=='Get Device Logs By Date Time')
        {

          WndCommand3.setTitle('Get Device Logs By Date Time');
          WndCommand3.Open();
          WndCommand3.screenCenter();
        }


        
      else if(SelectedCommand=='Block User')
        {

         document.getElementById('<%=CustomLabel.ClientID %>').innerText="User Id";
        
          WndCommand1.setTitle('Block User');
          WndCommand1.Open();
          WndCommand1.screenCenter();
        }
      else if(SelectedCommand=='UnBlock User')
        {
         
           

            document.getElementById('<%=CustomLabel.ClientID %>').innerText="User Id";
        
          WndCommand1.setTitle('UnBlock User');
          WndCommand1.Open();
          WndCommand1.screenCenter();
        }
      else if(SelectedCommand=='Enroll User Fingerprint')
        {
         
          WndCommand2.setTitle('Enroll User Fingerprint');
          WndCommand2.Open();
          WndCommand2.screenCenter();
        }
      else if (SelectedCommand == 'Enroll User Face') {

          document.getElementById('<%=CustomLabel.ClientID %>').innerText = "User Id";

          WndCommand1.setTitle('Enroll User Face');
          WndCommand1.Open();
          WndCommand1.screenCenter();
      }
      else if (SelectedCommand == 'Enroll User Face Ex') {

          document.getElementById('<%=CustomLabel.ClientID %>').innerText = "User Id";

          WndCommand1.setTitle('Enroll User Face Ex');
          WndCommand1.Open();
          WndCommand1.screenCenter();
      }

       else if(SelectedCommand=='Clear Logs from Device')
        {
          WndCommand0.setTitle('Clear Logs from Device');
               
          WndCommand0.Open();
          WndCommand0.screenCenter();
        }
        
       else if(SelectedCommand=='Change Webserver Address')
        {

        document.getElementById('<%=CustomLabel.ClientID %>').innerText="URL/IP";
        
          WndCommand1.setTitle('Change Webserver Address');
          WndCommand1.Open();
          WndCommand1.screenCenter();
        }
        
       else if(SelectedCommand=='Change Webserver Port')
        {

        
          document.getElementById('<%=CustomLabel.ClientID %>').innerText="Port";
        
          WndCommand1.setTitle('Change Webserver Port');
          WndCommand1.Open();
          WndCommand1.screenCenter();
        }
        
       else if(SelectedCommand=='Unlock Door')
        {

          WndCommand0.setTitle('Unlock Door');
      
         
          WndCommand0.Open();
          WndCommand0.screenCenter();
        }
         else if(SelectedCommand=='Reboot Device')
        {

          WndCommand0.setTitle('Reboot Device');
      
         
          WndCommand0.Open();
          WndCommand0.screenCenter();
        }
        
     


    }       
    
    
      
		    function attachFlyoutToLink(oLink,Action)
		        {	
	                <%=Flyout1.getClientID()%>.AttachTo(oLink.id);		            		            
	                <%=Flyout1.getClientID()%>.Open();
	                clearFlyout();
	                if(Action=='Update')
	                {
	                    populateEditControls(oLink.id.toString().replace("grid_link_", ""));
	                }
		        }
		        
		        function GetSerialNumber(Sender)
		        {
		            var id=Sender.id;
		            document.getElementById('<%=Hdn_SerialNumber.ClientID %>').value=id.replace('lnkDevice_','')
		        }
		    
		    function closeFlyout() 
		        {
		            <%=Flyout1.getClientID()%>.Close();
		        }
		        
		        
		       
		    
		    function populateEditControls(iRecordIndex) 
		        {	

                     document.getElementById('<%=txt_SerialNo.ClientID %>').disabled=true; 
		            document.getElementById("<%=Hdn_DeviceId.ClientID%>").value =grid_Devices.Rows[iRecordIndex].Cells[0].Value;
		            document.getElementById("<%=txt_DeviceName.ClientID%>").value = grid_Devices.Rows[iRecordIndex].Cells[2].Value;
		            document.getElementById( "<%=txt_SerialNo.ClientID %>").value = grid_Devices.Rows[iRecordIndex].Cells[3].Value;
                    document.getElementById("<%=drp_DeviceDiretion.ClientID %>").value=grid_Devices.Rows[iRecordIndex].Cells[4].Value;
		             document.getElementById("<%=txt_TimeZone.ClientID%>").value = grid_Devices.Rows[iRecordIndex].Cells[5].Value;
		            document.getElementById("<%=drpBaseLocation.ClientID%>").value=grid_Devices.Rows[iRecordIndex].Cells[19].Value;
		            document.getElementById("<%=txt_DeviceActivationCode.ClientID%>").value = grid_Devices.Rows[iRecordIndex].Cells[16].Value;

                    document.getElementById("<%=drp_DeviceType.ClientID %>").value=grid_Devices.Rows[iRecordIndex].Cells[17].Value;
                    document.getElementById("<%=drpIsAttendanceDevice.ClientID %>").value=grid_Devices.Rows[iRecordIndex].Cells[18].Value;
                    

                    
		        }
		   
		   
		      
		      
		       function btn_Save_onclick()
		        {
		            var oRecord = new Object();
	                oRecord.DeviceId =document.getElementById("<%=Hdn_DeviceId.ClientID %>").value ;
		            
	                oRecord.Error='';
	                
	                grid_Devices.executeInsert(oRecord);
		        }
		    
            function clearFlyout() 
            {
                 document.getElementById('<%=txt_SerialNo.ClientID %>').disabled=false; 
		        document.getElementById("<%=txt_DeviceName.ClientID%>").value = '';
		        document.getElementById( "<%=txt_SerialNo.ClientID %>").value = '';
		        document.getElementById("<%=drp_DeviceDiretion.ClientID %>").value='INOUT';
		        document.getElementById("<%=Hdn_DeviceId.ClientID%>").value = '0';
		        document.getElementById("<%=Lbl_InvalidError.ClientID %>").innerHTML ='';
		        document.getElementById("<%=txt_TimeZone.ClientID%>").value = '330';
                document.getElementById("<%=txt_DeviceActivationCode.ClientID%>").value='0';
                document.getElementById("<%=drp_DeviceType.ClientID %>").value='';
		        document.getElementById("<%=drpIsAttendanceDevice.ClientID %>").value='0';
		        document.getElementById("<%=drpBaseLocation.ClientID %>").value='0';
                
		        
		    }
		    
		    function RefreshDataGrid()
            {
                grid_Devices.refresh();
                window.setTimeout('RefreshDataGrid()', 15000);
            }

             function CloseAndClearAll(CommandWindowName)
    {

        document.getElementById("HiddenSelectedCommandWindow").value=CommandWindowName;
        document.getElementById("btnClearGridSelection").click();

     
    }



    </script>
    <script type="text/javascript">
        var tmp;
        function AuToRefreshGrid() {
            var SecondValue = document.getElementById("<%=ddlAutoRefresh.ClientID %>").value;
            tmp = setInterval("callitrept()", SecondValue);
        }
        function callitrept() {
            document.getElementById("btn_Refresh").click();
        }
    </script>

     <script type="text/javascript">
         assignEventsToCheckboxes();

         var sDeselectRecordsIds = grid_Devices.getRecordsIds();
         if (sDeselectRecordsIds != null && sDeselectRecordsIds.length > 0) {
             var arrRecordsDeselectIds = sDeselectRecordsIds.split(",");
             for (var i = 0; i < arrRecordsDeselectIds.length; i++) {
                 grid_Devices.deselectRecord(i);

             }
         }
</script>

</body>
</html>
