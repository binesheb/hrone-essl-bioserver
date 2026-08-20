<%@ page language="VB" autoeventwireup="false" inherits="Manage_DeviceGroups, App_Web_v2kwzk4v" enableEventValidation="false" %>


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
                    <td id="Td1" runat="server"  style="font-weight: bold; font-size: 14px; background-color: lightsteelblue;
                        padding: 5px; color: white; width:50%;">
                        Access Groups in Device - <b><%= URLEncodeDecode.GetQueryString(URLEncodeDecode.Decode(Request.QueryString("Id")), "DeviceName")%></b>
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
                            <obout:Grid ID="Dg_Groups" runat="server"  Serialize="false"
                                AutoGenerateColumns="false" FolderStyle="~/styles/grid/styles/premiere_blue"
                                AllowMultiRecordDeleting="true" AllowAddingRecords="true" PageSize="10" AllowMultiRecordSelection="false"
                                GenerateRecordIds="true" AllowFiltering="true" OnRebind="RebindGrid"  OnInsertCommand="InsertRecord">
                              
                              <ClientSideEvents OnClientInsert="OnInsert" />
                               <TemplateSettings NewRecord_TemplateId="tplAddBtn" />

                                <Columns>
                                    <obout:Column ID="Column12" DataField="Id" Visible="False" Width="300" HeaderText="Id"
                                    ConvertEmptyStringToNull="False" Index="0" />
                                    <obout:Column ID="Column1" DataField="GroupId" Width="120" HeaderText="GroupId" ConvertEmptyStringToNull="False" Index="1" />
                                    <obout:Column ID="Column7" DataField="Name" Width="150" HeaderText="Name" ConvertEmptyStringToNull="False" Index="2" />
                                    <obout:Column ID="Column5" DataField="VerificationType" Width="160" HeaderText="Verification Type" ConvertEmptyStringToNull="False" Index="3" />
                                    <obout:Column ID="Column2" DataField="IsHolidayApplicable" Width="150" HeaderText="Is Holiday Applicable" ConvertEmptyStringToNull="False" Index="4" />
                                    <obout:Column ID="Column6" DataField="TimePeriod1" Width="120" HeaderText="TimePeriod1" ConvertEmptyStringToNull="False" Index="5" />
                                    <obout:Column ID="Column8" DataField="TimePeriod2" Width="120" HeaderText="TimePeriod2" ConvertEmptyStringToNull="False" Index="6" />
                                    <obout:Column ID="Column9" DataField="TimePeriod3" Width="120" HeaderText="TimePeriod3" ConvertEmptyStringToNull="False" Index="7" />
                                    <obout:Column ID="Column3" DataField="Status" Width="80" HeaderText="Status" ConvertEmptyStringToNull="False" Index="8" />
                                    <obout:Column ID="Column4" DataField="SyncDate" Width="150" HeaderText="SyncDate" ConvertEmptyStringToNull="False" Index="9" />
                                    <obout:Column ID="Column10" DataField="VerificationTypeCode" Width="160" HeaderText="Verification Type" ConvertEmptyStringToNull="False" Visible="false" Index="10" />
                                    <obout:Column ID="Column11" DataField="DeviceId" Width="160" HeaderText="DeviceId" ConvertEmptyStringToNull="False" Visible="false" Index="11" />

                                    <obout:Column HeaderText="Edit" Width="60" AllowEdit="True" AllowDelete="True" ConvertEmptyStringToNull="False" Index="12" TemplateId="tplEditBtn">
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
                            <legend>Access Group Information</legend>
                            <table>
                                <tr>
                                    <td style="font-weight: bold;width:80px;" >
                                        GroupId&nbsp;(1&minus;99)
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txt_GroupId" Width="170px" runat="server"></asp:TextBox>
                                    </td>
                                     <td style="font-weight: bold;width:100px;">
                                        Name
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txt_Name" Width="170px" runat="server"></asp:TextBox>
                                    </td>
                                </tr>
                                
                                <tr>
                                   
                                    <td>
                                        Verification&nbsp;Type&nbsp;
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
                                        
                                    </asp:DropDownList>

                                </td>
                                    <td >
                                        Is&nbsp;Holiday&nbsp;Applicable&nbsp;
                                    </td>
                                    <td>
                                        <asp:DropDownList ID="drp_IsHolidayApplicable" runat="server"  Width="170px">
                                   


                                    <asp:ListItem  value="0" selected Text="No"></asp:ListItem>
                                    <asp:ListItem  value="1" Text="Yes"></asp:ListItem>

                                    </asp:DropDownList>
                                    </td>
                                </tr>
                               
                                <tr>
                                    <td style="font-weight: bold;">
                                        Time&nbsp;Period&nbsp;1&nbsp;(0&minus;50)
                                    </td>
                                    <td>

                                       <asp:TextBox ID="txt_TimePeriod1" runat="server" Width="170px"></asp:TextBox>

                                        
                                    </td>
                                    
                                
                                    <td style="font-weight: bold;">
                                        Time&nbsp;Period&nbsp;2&nbsp;(0&minus;50)
                                    </td>
                                    <td colspan="3">
                                         <asp:TextBox ID="txt_TimePeriod2" runat="server" Width="170px"></asp:TextBox>
                                    </td>
                                </tr>


                                <tr>
                                    <td style="font-weight: bold;">
                                        Time&nbsp;Period&nbsp;3&nbsp;(0&minus;50)
                                    </td>
                                    <td>

                                        <asp:TextBox ID="txt_TimePeriod3" runat="server" Width="170px"></asp:TextBox>

                                        
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

                 document.getElementById('<%=txt_GroupId.ClientID %>').disabled=true; 
                 document.getElementById("<%=txt_GroupId.ClientID%>").value = Dg_Groups.Rows[iRecordIndex].Cells[1].Value;
		        document.getElementById("<%=txt_Name.ClientID%>").value = Dg_Groups.Rows[iRecordIndex].Cells[2].Value;
                document.getElementById( "<%=drp_VerificationType.ClientID %>").value = Dg_Groups.Rows[iRecordIndex].Cells[10].Value;
		        document.getElementById("<%=drp_IsHolidayApplicable.ClientID %>").value=Dg_Groups.Rows[iRecordIndex].Cells[4].Value;
		        document.getElementById("<%=Hdn_Id.ClientID%>").value = Dg_Groups.Rows[iRecordIndex].Cells[0].Value;
		        document.getElementById("<%=Hdn_DeviceId.ClientID%>").value = Dg_Groups.Rows[iRecordIndex].Cells[11].Value;
		        document.getElementById("<%=Lbl_InvalidError.ClientID %>").innerHTML ='';
		        document.getElementById("<%=txt_TimePeriod1.ClientID%>").value = Dg_Groups.Rows[iRecordIndex].Cells[5].Value;
                document.getElementById("<%=txt_TimePeriod2.ClientID%>").value=Dg_Groups.Rows[iRecordIndex].Cells[6].Value;
                document.getElementById("<%=txt_TimePeriod3.ClientID %>").value=Dg_Groups.Rows[iRecordIndex].Cells[7].Value;

                    
		        }
		   
		   
		      
		      
		       function btn_Save_onclick()
		        {
                  
		            var oRecord = new Object();
	                oRecord.Id =document.getElementById("<%=Hdn_Id.ClientID %>").value ;
		              
	                oRecord.Error='';
	                
	                Dg_Groups.executeInsert(oRecord);
		        }
		    
            function clearFlyout() 
            {
                document.getElementById('<%=txt_GroupId.ClientID %>').disabled=false; 
		        document.getElementById("<%=txt_GroupId.ClientID%>").value = '';
		        document.getElementById("<%=txt_Name.ClientID%>").value = '';
		        document.getElementById( "<%=drp_VerificationType.ClientID %>").value = '0';
		        document.getElementById("<%=drp_IsHolidayApplicable.ClientID %>").value='0';
		        document.getElementById("<%=Hdn_Id.ClientID%>").value = '0';
		        document.getElementById("<%=Lbl_InvalidError.ClientID %>").innerHTML ='';
		        document.getElementById("<%=txt_TimePeriod1.ClientID%>").value = '1';
                document.getElementById("<%=txt_TimePeriod2.ClientID%>").value='0';
                document.getElementById("<%=txt_TimePeriod3.ClientID %>").value='0';

		        
		    }
		    
		  
    
    </script>
</body>
</html>



