<%@ page language="VB" autoeventwireup="false" inherits="Manage_DeviceTimePeriods, App_Web_v2kwzk4v" enableEventValidation="false" %>



<%@ Import Namespace="eBioServerLibrary.Utilities" %>

<%@ Register TagPrefix="obout" Namespace="Obout.Grid" Assembly="obout_Grid_NET" %>
<%@ Register TagPrefix="obout" Namespace="OboutInc.Flyout2" Assembly="obout_Flyout2_NET" %>
<%@ Register TagPrefix="uctrl" Src="~/Header.ascx" TagName="header" %>
<%@ Register TagPrefix="owd" Namespace="OboutInc.Window" Assembly="obout_Window_NET" %>
<%@ Register TagPrefix="oem" Namespace="OboutInc.EasyMenu_Pro" Assembly="obout_EasyMenu_Pro" %>


<script type="text/javascript">
    // Client-Side Events for Delete

    function OnInsert(record) {
        document.getElementById("<%=Lbl_InvalidError.ClientID %>").innerHTML = record.Error;
    }

	
</script>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" >
<html >
<head id="Head1" runat="server">
    <title>Untitled Page</title>


    <link href="../StyleSheet.css" rel="stylesheet" type="text/css" />
</head>
   <uctrl:header ID="Header1" runat="server" />
<body background="../Images/bck1.gif" style="background-repeat: no-repeat; background-position-x: right;
    background-position-y: top;">
    <form id="form1" runat="server">
        <div>
            <uctrl:header ID="MyHeader" runat="server" />
            <table cellpadding="0" cellspacing="0" style="border-right: gray 1px solid; border-top: gray 1px solid;
                border-left: gray 1px solid; border-bottom: gray 1px solid;">
                <tr style="font-weight: bold; font-size: 14px; background-color: lightsteelblue;
                    padding-left: 5px; padding-top: 3px; padding-bottom: 3px; color: white;">
                    <td id="Td1" runat="server" style="font-weight: bold; font-size: 14px; background-color: lightsteelblue;
                        padding: 5px; color: white; width:50%; ">
                        Time Periods in Device - <b><%= URLEncodeDecode.GetQueryString(URLEncodeDecode.Decode(Request.QueryString("Id")), "DeviceName")%></b>
                    </td>

                      <td align=right>
                    <input type=button value="Back" onclick="JavaScript:location.href='Devices.aspx';" />
                    </td>

                </tr>
                <tr style="background-color: lightsteelblue;">
                    <td colspan="2">
                        <hr />
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <div id="div_Groups">
                            <obout:Grid ID="Dg_TimePeriods" runat="server"  Serialize="false"
                                AutoGenerateColumns="false" FolderStyle="~/styles/grid/styles/premiere_blue"
                                AllowMultiRecordDeleting="true" AllowAddingRecords="true" PageSize="10" AllowMultiRecordSelection="false"
                                GenerateRecordIds="true" AllowFiltering="true"  OnRebind="RebindGrid"  OnInsertCommand="InsertRecord">

                                <ClientSideEvents OnClientInsert="OnInsert" />

                               <TemplateSettings NewRecord_TemplateId="tplAddBtn" />
                                <Columns>
                                    <obout:Column ID="Column12" DataField="Id" Visible="False" Width="300" HeaderText="Id"
                                    ConvertEmptyStringToNull="False" Index="0" />
                                    <obout:Column ID="Column1" DataField="TimePeriodId" Width="120" HeaderText="TimePeriodId" ConvertEmptyStringToNull="False" Index="1" />
                                    <obout:Column ID="Column7" DataField="Name" Width="150" HeaderText="Name" ConvertEmptyStringToNull="False" Index="2" />
                                    <obout:Column ID="Column6" DataField="Sunday" Width="90" HeaderText="Sunday" ConvertEmptyStringToNull="False" Index="3" />
                                    <obout:Column ID="Column2" DataField="Monday" Width="90" HeaderText="Monday" ConvertEmptyStringToNull="False" Index="4" />
                                    <obout:Column ID="Column5" DataField="Tuesday" Width="90" HeaderText="Tuesday" ConvertEmptyStringToNull="False" Index="5" />
                                    <obout:Column ID="Column8" DataField="Wednesday" Width="90" HeaderText="Wednesday" ConvertEmptyStringToNull="False" Index="6" />
                                    <obout:Column ID="Column9" DataField="Thursday" Width="90" HeaderText="Thursday" ConvertEmptyStringToNull="False" Index="7" />
                                    <obout:Column ID="Column10" DataField="Friday" Width="90" HeaderText="Friday" ConvertEmptyStringToNull="False" Index="8" />
                                    <obout:Column ID="Column11" DataField="Saturday" Width="90" HeaderText="Saturday" ConvertEmptyStringToNull="False" Index="9" />
                                    <obout:Column ID="Column3" DataField="Status" Width="80" HeaderText="Status" ConvertEmptyStringToNull="False" Index="10" />
                                    <obout:Column ID="Column4" DataField="SyncDate" Width="150" HeaderText="SyncDate" ConvertEmptyStringToNull="False" Index="11" />
                                    <obout:Column ID="Column13" DataField="DeviceId" Width="150" HeaderText="DeviceId" ConvertEmptyStringToNull="False" Visible="false" Index="12" />
                                      <obout:Column HeaderText="Edit" Width="60" AllowEdit="True" AllowDelete="True" ConvertEmptyStringToNull="False" Index="13" TemplateId="tplEditBtn">
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

                                <obout:GridTemplate runat="server" ID="tplAddBtn" ControlID="" ControlPropertyName="">
                                    <Template>
                                        <a href="javascript: //" id="btAdd" onclick="attachFlyoutToLink(this,'Add')" class="ob_gAL">
                                            Add</a>
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
                            <legend>Time Period Information</legend>
                            <table>
                                <tr>
                                    <td style="font-weight: bold;width:80px;" >
                                        TimePeriodId&nbsp;(1&minus;50)
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txt_TimePeriodId" Width="170px" runat="server"></asp:TextBox>
                                    </td>
                                     <td style="font-weight: bold;width:100px;">
                                        Name
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txt_Name" Width="170px" runat="server"></asp:TextBox>
                                    </td>
                                </tr>
                                
                                <tr>
                                   
                                    <td style="font-weight: bold;">
                                        Sunday
                                    </td>
                                    <td>
                                    
                                    <asp:TextBox ID="txtSunday" runat="server" Width="170px"></asp:TextBox>
                                    

                                </td>
                                    <td style="font-weight: bold;">
                                       Monday
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtMonday" runat="server" Width="170px"></asp:TextBox>
                                    </td>
                                </tr>
                               
                                <tr>
                                    <td style="font-weight: bold;">
                                        Tuesday
                                    </td>
                                    <td >

                                       <asp:TextBox ID="txtTuesday" runat="server" Width="170px"></asp:TextBox>

                                        
                                    </td>
                                    
                                
                                    <td style="font-weight: bold;">
                                        Wednesday
                                    </td>
                                    <td colspan="3">
                                         <asp:TextBox ID="txtWednesday" runat="server" Width="170px"></asp:TextBox>
                                    </td>
                                </tr>


                                <tr>
                                    <td style="font-weight: bold;">
                                       Thursday
                                    </td>
                                    <td>

                                        <asp:TextBox ID="txtThursday" runat="server" Width="170px"></asp:TextBox>

                                        
                                    </td>
                                    
                                
                                    <td style="font-weight: bold;">
                                       Friday
                                    </td>
                                    <td colspan="3">
                                        <asp:TextBox ID="txtFriday" runat="server" Width="170px"></asp:TextBox>
                                    </td>
                                </tr>


                                 <tr>
                                    <td style="font-weight: bold;">
                                       Saturday
                                    </td>
                                    <td>

                                        <asp:TextBox ID="txtSaturday" runat="server" Width="170px"></asp:TextBox>

                                        
                                    </td>
                                    
                                
                                    <td style="font-weight: bold;">
                                       
                                    </td>
                                    <td colspan="3">
                                       
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
                        <asp:HiddenField ID="Hdn_Id" runat="server" />
                        <asp:HiddenField ID="Hdn_DeviceId" runat="server" />
                    </td>
                </tr>
            </table>
        </obout:Flyout>


        </div>
        
    </form>


    
    <script type="text/javascript">
    
    
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
		        
		      
		    
		    function closeFlyout() 
		        {
		            <%=Flyout1.getClientID()%>.Close();
		        }
		        
		        
		       
		    
		    function populateEditControls(iRecordIndex) 
		        {	

                     
                
                    
                document.getElementById('<%=txt_TimePeriodId.ClientID %>').disabled=true; 
		        document.getElementById("<%=txt_TimePeriodId.ClientID%>").value = Dg_TimePeriods.Rows[iRecordIndex].Cells[1].Value;;
		        document.getElementById("<%=txt_Name.ClientID%>").value = Dg_TimePeriods.Rows[iRecordIndex].Cells[2].Value;;
		        document.getElementById( "<%=txtSunday.ClientID %>").value = Dg_TimePeriods.Rows[iRecordIndex].Cells[3].Value;;
		        document.getElementById("<%=txtMonday.ClientID %>").value=Dg_TimePeriods.Rows[iRecordIndex].Cells[4].Value;;
                document.getElementById("<%=Hdn_Id.ClientID%>").value = Dg_TimePeriods.Rows[iRecordIndex].Cells[0].Value;
                document.getElementById("<%=Hdn_DeviceId.ClientID%>").value = Dg_TimePeriods.Rows[iRecordIndex].Cells[12].Value;
		        document.getElementById("<%=Lbl_InvalidError.ClientID %>").innerHTML ='';
		        document.getElementById("<%=txtTuesday.ClientID%>").value = Dg_TimePeriods.Rows[iRecordIndex].Cells[5].Value;;
                document.getElementById("<%=txtWednesday.ClientID%>").value=Dg_TimePeriods.Rows[iRecordIndex].Cells[6].Value;;
                document.getElementById("<%=txtThursday.ClientID %>").value=Dg_TimePeriods.Rows[iRecordIndex].Cells[7].Value;;
                document.getElementById("<%=txtFriday.ClientID %>").value=Dg_TimePeriods.Rows[iRecordIndex].Cells[8].Value;;
                document.getElementById("<%=txtSaturday.ClientID %>").value=Dg_TimePeriods.Rows[iRecordIndex].Cells[9].Value;;



                    
		        }
		   
		   
		      
		      
		       function btn_Save_onclick()
		        {
		            var oRecord = new Object();
	                oRecord.Id =document.getElementById("<%=Hdn_Id.ClientID %>").value ;
		            
	                oRecord.Error='';
	                
	                Dg_TimePeriods.executeInsert(oRecord);
		        }
		    
            function clearFlyout() 
            {
                 document.getElementById('<%=txt_TimePeriodId.ClientID %>').disabled=false; 
		        document.getElementById("<%=txt_TimePeriodId.ClientID%>").value = '';
		        document.getElementById("<%=txt_Name.ClientID%>").value = '';
		        document.getElementById( "<%=txtSunday.ClientID %>").value = '00:00-23:59';
		        document.getElementById("<%=txtMonday.ClientID %>").value='00:00-23:59';
		        document.getElementById("<%=Hdn_Id.ClientID%>").value = '0';
		        document.getElementById("<%=Lbl_InvalidError.ClientID %>").innerHTML ='';
		        document.getElementById("<%=txtTuesday.ClientID%>").value = '00:00-23:59';
                document.getElementById("<%=txtWednesday.ClientID%>").value='00:00-23:59';
                document.getElementById("<%=txtThursday.ClientID %>").value='00:00-23:59';
                document.getElementById("<%=txtFriday.ClientID %>").value='00:00-23:59';
                document.getElementById("<%=txtSaturday.ClientID %>").value='00:00-23:59';

		        
		    }
		    
		  
    
    </script>

</body>
</html>



