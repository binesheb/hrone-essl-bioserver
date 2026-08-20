<%@ page language="VB" autoeventwireup="false" inherits="Attendance_Shifts, App_Web_haagzrto" enableEventValidation="false" %>

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
        document.getElementById("<%=Hdn_Id.ClientID %>").value = record.Id;
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
                Shift Types
            </td>
            <td align="right">
                <asp:Label ID="lblError" runat="server" Width="300px" ForeColor="Red"></asp:Label>
                &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;
            </td>
        </tr>
        
          


        <tr>
            <td colspan="2">
                <obout:Grid ID="Dg_List" runat="server" ShowLoadingMessage="true" EnableRecordHover="true"
                    AllowFiltering="true" CallbackMode="true" Serialize="false" KeepSelectedRecords="true"
                    AutoGenerateColumns="false" AllowAddingRecords="true" FolderStyle="~/styles/grid/styles/premiere_blue"
                    Width="907px" OnInsertCommand="InsertRecord" OnDeleteCommand="DeleteRecord">
                    <ClientSideEvents OnClientInsert="OnInsert" OnBeforeClientDelete="OnBeforeDelete"
                        OnClientDelete="OnDelete" />
                    <TemplateSettings NewRecord_TemplateId="tplAddBtn" />
                    <Columns>
                        <obout:Column ID="Id" DataField="Id" Visible="False" Width="100" ReadOnly="True"
                            HeaderText="Id" ConvertEmptyStringToNull="False" Index="0" />
                        <obout:Column ID="Code" DataField="Code" Width="120" HeaderText="Code"
                            ConvertEmptyStringToNull="False"  Index="1" />
                        <obout:Column ID="Name" DataField="Name" Width="130" HeaderText="Name"
                            ConvertEmptyStringToNull="False" Index="2" />
                        <obout:Column ID="Location" DataField="Location" Width="130" HeaderText="Location"
                            ConvertEmptyStringToNull="False" Index="3">
                        </obout:Column>

                         <obout:Column ID="Column1" DataField="BeginTime" Width="100" HeaderText="Begin Time"
                            ConvertEmptyStringToNull="False" Index="4"   DataFormatString="{0:HH mm}"  />
                       <obout:Column ID="Column2" DataField="EndTime" Width="100" HeaderText="End Time"
                            ConvertEmptyStringToNull="False" Index="5"    DataFormatString="{0:HH mm}"  />


                        <obout:Column HeaderText="Edit" Width="70" AllowEdit="True" AllowDelete="True" ConvertEmptyStringToNull="False"
                            Index="6" TemplateId="tplEditBtn">
                            <TemplateSettings TemplateId="tplEditBtn" />
                        </obout:Column>
                        <obout:Column HeaderText="Delete" Width="60" AllowDelete="True" ConvertEmptyStringToNull="False"
                            Index="7" />
                      
                       <obout:Column ID="Column3" DataField="PartialDay" Visible=false Width="160" HeaderText="Name"
                            ConvertEmptyStringToNull="False" Index="8" />
                       <obout:Column ID="Column4" DataField="PartialDayBeginTime" Visible=false Width="160" HeaderText="Name"
                            ConvertEmptyStringToNull="False" Index="9" />
                       <obout:Column ID="Column5" DataField="PartialDayEndTime" Visible=false Width="160" HeaderText="Name"
                            ConvertEmptyStringToNull="False" Index="10" />
                     
                     <obout:Column ID="Column6" DataField="FullDayDuration" Visible=false Width="160" HeaderText="Name"
                            ConvertEmptyStringToNull="False" Index="11" />

                     <obout:Column ID="Column7" DataField="PartialDayDuration" Visible=false Width="160" HeaderText="Name"
                            ConvertEmptyStringToNull="False" Index="12" />

                     <obout:Column ID="Column8" DataField="PunchBeginBefore" Visible=false Width="160" HeaderText="Name"
                            ConvertEmptyStringToNull="False" Index="13" />

                     <obout:Column ID="Column9" DataField="PunchEndAfter" Visible=false Width="160" HeaderText="Name"
                            ConvertEmptyStringToNull="False" Index="14" />

                     <obout:Column ID="Column10" DataField="LocationId" Visible=false Width="160" HeaderText="LocationId"
                            ConvertEmptyStringToNull="False" Index="15" />


                            
                            

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
                                    <%#CheckPermissions("Add", "AddShiftTypes")%>
                                </a>
                            </Template>
                        </obout:GridTemplate>
                     
                    </Templates>
                </obout:Grid>
            </td>
        </tr>
    </table>
    <obout:Flyout runat="server" ID="Flyout1" Align="left" Position="BOTTOM_CENTER" CloseEvent="NONE"
        OpenEvent="NONE" DelayTime="500">
        <table class="rowEditTable">
            <tr>
                <td>
                    <fieldset>
                        <legend>Shift Type Details</legend>
                        <table>
                            <tr>
                                <td align="right" style="font-weight: bold;">
                                    Shift Code
                                </td>
                                <td >
                                     <asp:TextBox ID="txt_Code"  runat="server" CssClass="WebControls"
                                        Width="100px"></asp:TextBox>
                                      
                                </td>

                                <td align="right" style="font-weight: bold;">
                                   Shift Name
                                </td>
                                <td style="width:100%;" >
                                    <asp:TextBox ID="txt_Name"  runat="server" CssClass="WebControls"
                                        Width="100px"></asp:TextBox>
                                </td>
                               
                                <td align="right" >
                                    Location
                                </td>
                                <td>
                                    <asp:DropDownList ID="drpBaseLocation" runat="server"  CssClass="WebControls" Width="125px" >
                                    </asp:DropDownList>
                                </td>
                            </tr>
                              
                       
                           
                       
                         <tr>
                             <td align="right" style="font-weight: bold;">
                                    Shift Begin&nbsp;Time
                                </td>
                              <td>
                                    <asp:TextBox ID="txt_BeginTime"  runat="server" CssClass="WebControls"
                                        Width="50px"></asp:TextBox>&nbsp;HH:MM
                               </td>

                                <td align="right" style="font-weight: bold;">
                                    Shift End&nbsp;Time
                                </td>
                                <td>
                                    <asp:TextBox ID="txt_EndTime"  runat="server" CssClass="WebControls"
                                        Width="50px"></asp:TextBox>&nbsp;HH:MM
                                </td>
                                <td  align="right"  >Duration</td>
                                
                                <td><asp:TextBox ID="txt_FullDayDuration"  runat="server" CssClass="WebControls"
                                        Width="50px"></asp:TextBox>&nbsp;Minutes</td>
                            </tr>

                             <tr>
                             <td align="right" >
                                    Partial&nbsp;Day&nbsp;Begin&nbsp;Time
                                </td>
                              <td>
                                    <asp:TextBox ID="txt_PartialDayBeginTime"  runat="server" CssClass="WebControls"
                                        Width="50px"></asp:TextBox>&nbsp;HH:MM
                               </td>

                                <td align="right" >
                                    Partial&nbsp;Day&nbsp;End&nbsp;Time
                                </td>
                                <td>
                                    <asp:TextBox ID="txt_PartialDayEndTime"  runat="server" CssClass="WebControls"
                                        Width="50px"></asp:TextBox>&nbsp;HH:MM
                                </td>
                                <td>Partial&nbsp;Day</td><td>
                                
                                <asp:DropDownList ID="drp_PartialDay" runat="server"  Width="100px">
                                   

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
                            </tr>
                            <tr>
                            
                             <td  align="right"  >Partial&nbsp;Day&nbsp;Duration</td>
                                
                                <td align=left><asp:TextBox ID="txt_PartialDayDuration"  runat="server" CssClass="WebControls"
                                        Width="50px"></asp:TextBox>&nbsp;Minutes</td>
                             <td  align="right"  >Punch&nbsp;Begin&nbsp;Before</td>
                                
                                <td align=left><asp:TextBox ID="txt_PunchBeginBefore"  runat="server" CssClass="WebControls"
                                        Width="50px"></asp:TextBox>&nbsp;Minutes</td>
                             <td  align="right"  >Punch&nbsp;End&nbsp;After</td>
                                
                                <td align=left><asp:TextBox ID="txt_PunchEndAfter"  runat="server" CssClass="WebControls"
                                        Width="50px"></asp:TextBox>&nbsp;Minutes</td>
                                        
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
            
            
            
            If Not Session.Item("LoginUser") Is Nothing Then
            
                If CType(Session("LoginUser"), eBioServerLibrary.Data.Admin.User).PermissionList.Contains(Permission) Then
                    Return Action
                End If
                Return ""
            End If
            
             Return ""
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

		        Dg_List.executeInsert(oRecord);
		    }
		    
		     function clearFlyout_Details() 
            {
                document.getElementById("<%=Hdn_Id.ClientID %>").value = '0';
		        document.getElementById("<%=txt_Code.ClientID %>").value =  '';
		        document.getElementById("<%=txt_Name.ClientID %>").value = '';

 		        document.getElementById("<%=txt_BeginTime.ClientID %>").value = '09:00';
 		        document.getElementById("<%=txt_EndTime.ClientID %>").value = '18:00';
 		        document.getElementById("<%=drp_PartialDay.ClientID %>").value = '';
 		        document.getElementById("<%=txt_PartialDayBeginTime.ClientID %>").value = '09:00';
 		        document.getElementById("<%=txt_PartialDayEndTime.ClientID %>").value = '18:00';

 		        document.getElementById("<%=txt_FullDayDuration.ClientID %>").value = '540';
 		        document.getElementById("<%=txt_PartialDayDuration.ClientID %>").value = '540';

 		        document.getElementById("<%=txt_PunchBeginBefore.ClientID %>").value = '120';
 		        document.getElementById("<%=txt_PunchEndAfter.ClientID %>").value = '480';
                document.getElementById("<%=drpBaseLocation.ClientID %>").value = '0';


                
                                        

		        document.getElementById("<%=Lbl_InvalidError.ClientID %>").innerHTML='';

               }

           
         
		    
		     function populateEditControls(iRecordIndex) 
		    {	
		        document.getElementById("<%=Hdn_Id.ClientID %>").value = Dg_List.Rows[iRecordIndex].Cells[0].Value;
		        document.getElementById("<%=txt_Code.ClientID %>").value = Dg_List.Rows[iRecordIndex].Cells[1].Value;
                document.getElementById("<%=txt_Name.ClientID %>").value = Dg_List.Rows[iRecordIndex].Cells[2].Value;

   		        document.getElementById("<%=txt_BeginTime.ClientID %>").value = Dg_List.Rows[iRecordIndex].Cells[4].Value;
 		        document.getElementById("<%=txt_EndTime.ClientID %>").value = Dg_List.Rows[iRecordIndex].Cells[5].Value;
 		        document.getElementById("<%=drp_PartialDay.ClientID %>").value = Dg_List.Rows[iRecordIndex].Cells[8].Value;
 		        document.getElementById("<%=txt_PartialDayBeginTime.ClientID %>").value = Dg_List.Rows[iRecordIndex].Cells[9].Value;
 		        document.getElementById("<%=txt_PartialDayEndTime.ClientID %>").value = Dg_List.Rows[iRecordIndex].Cells[10].Value;

                document.getElementById("<%=txt_FullDayDuration.ClientID %>").value = Dg_List.Rows[iRecordIndex].Cells[11].Value;
 		        document.getElementById("<%=txt_PartialDayDuration.ClientID %>").value = Dg_List.Rows[iRecordIndex].Cells[12].Value;

  		        document.getElementById("<%=txt_PunchBeginBefore.ClientID %>").value = Dg_List.Rows[iRecordIndex].Cells[13].Value;
 		        document.getElementById("<%=txt_PunchEndAfter.ClientID %>").value = Dg_List.Rows[iRecordIndex].Cells[14].Value;
                document.getElementById("<%=drpBaseLocation.ClientID %>").value = Dg_List.Rows[iRecordIndex].Cells[15].Value;

                



		                  


		   }


           

		    
		   
    </script>
</body>
</html>
