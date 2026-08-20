<%@ page language="VB" autoeventwireup="false" inherits="Attendance_EmployeeLeaveLimits, App_Web_haagzrto" enableEventValidation="false" %>
<%@ Import Namespace="eBioServerLibrary.Utilities" %>


<%@ Register TagPrefix="uctrl" Src="~/Header.ascx" TagName="header" %>

<%@ Register TagPrefix="obout" Namespace="Obout.Grid" Assembly="obout_Grid_NET" %>
<%@ Register TagPrefix="obout" Namespace="OboutInc.Flyout2" Assembly="obout_Flyout2_NET" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" >
<script type="text/javascript">
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
                Employee Leave Limits - <b><%= URLEncodeDecode.GetQueryString(URLEncodeDecode.Decode(Request.QueryString("Id")), "EmployeeName")%></b>
            </td>
            <td align=right>


             Select Year 
                    <asp:DropDownList ID="ddlYears" runat="server" AutoPostBack="false" Width="70px">
                        
                    </asp:DropDownList>
                    
                    &nbsp;
                    <asp:Button ID="btlReset" runat="server" Text="Filter" />  
                    &nbsp;
                    <input type=button value="Back" onclick="JavaScript:location.href='Employees.aspx';" />
                    </td>
            
        </tr>
        <tr>
            <td colspan="2">
                <obout:Grid ID="Dg_Employee" runat="server" ShowLoadingMessage="true" EnableRecordHover="true"
                    AllowFiltering="true" CallbackMode="true" Serialize="false" KeepSelectedRecords="true"
                    AutoGenerateColumns="false" AllowAddingRecords="false" FolderStyle="~/styles/grid/styles/premiere_blue"
                    Width="907px" OnInsertCommand="InsertRecord" >
                    <ClientSideEvents OnClientInsert="OnInsert"  />
                    <Columns>
                        <obout:Column ID="Id" DataField="Id" Visible="False" Width="100" ReadOnly="True"
                            HeaderText="Id" ConvertEmptyStringToNull="False" Index="0" />
                        <obout:Column ID="Code" DataField="Code" Width="120" HeaderText="Leave Code"
                            ConvertEmptyStringToNull="False" Index="1" />
                        <obout:Column ID="Name" DataField="Name" Width="160" HeaderText="Leave Name"
                            ConvertEmptyStringToNull="False" Index="2" />
                        <obout:Column ID="Column2" DataField="YearlyLimit" Width="150" HeaderText="Yearly Limit"
                            ConvertEmptyStringToNull="False" Index="3">
                        </obout:Column>
                        <obout:Column ID="Column3" DataField="AllowedLimit" Width="150" HeaderText="Allowed Limit" ConvertEmptyStringToNull="False"
                            Index="4">
                        </obout:Column>
                        <obout:Column HeaderText="Edit" Width="70" AllowEdit="True" AllowDelete="True" ConvertEmptyStringToNull="False"
                            Index="5" TemplateId="tplEditBtn">
                            <TemplateSettings TemplateId="tplEditBtn" />
                        </obout:Column>
                        <obout:Column ID="Column1" Visible=false DataField="LeaveTypeId" Width="150" HeaderText="LeaveTypeId" ConvertEmptyStringToNull="False"
                            Index="6">
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
                        <legend>Employee Leave Limit Details</legend>
                        <table>
                            <tr>
                                <td align="right" style="font-weight: bold;">
                                    Leave&nbsp;Code
                                </td>
                                <td>
                                    <asp:TextBox ID="txt_code" runat="server" Enabled=false CssClass="WebControls" Width="125px"></asp:TextBox>
                                </td>
                                <td align="right" style="font-weight: bold;">
                                    Leave&nbsp;Name
                                </td>
                                <td>
                                    <asp:TextBox ID="txt_Name" runat="server" Enabled=false CssClass="WebControls" Width="125px"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td align="right" style="font-weight: bold;">
                                    Yearly&nbsp;Limit
                                </td>
                                <td>
                                    <asp:TextBox ID="txt_YearlyLimit" runat="server" Enabled=false CssClass="WebControls" Width="125px" ></asp:TextBox>
                                </td>
                                <td align="right" style="font-weight: bold;">
                                    Allowed&nbsp;Limit
                                </td>
                                <td>
                                    <asp:TextBox ID="txt_AllowedLimit" runat="server" CssClass="WebControls" Width="125px"></asp:TextBox>
                                </td>
                            </tr>


                        </table>
                    </fieldset>
                </td>
            </tr>
            <tr>
            
             <td align="right">

                                 <asp:HiddenField ID="Hdn_Id" runat="server" />
                                 <asp:HiddenField ID="Hdn_LeaveTypeId" runat="server" />

                                 

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
		        
		        Dg_Employee.executeInsert(oRecord);
		    }
		    
		     function clearFlyout_Details() 
            {
                document.getElementById("<%=Hdn_Id.ClientID %>").value = '0';
   		        document.getElementById("<%=Hdn_LeaveTypeId.ClientID %>").value = "0";

                document.getElementById("<%=Lbl_InvalidError.ClientID %>").innerHTML='';

               }

           
         
		    
		     function populateEditControls(iRecordIndex) 
		    {	
		        document.getElementById("<%=Hdn_Id.ClientID %>").value = Dg_Employee.Rows[iRecordIndex].Cells[0].Value;
		        document.getElementById("<%=Hdn_LeaveTypeId.ClientID %>").value = Dg_Employee.Rows[iRecordIndex].Cells[6].Value;
		        document.getElementById("<%=txt_Code.ClientID %>").value = Dg_Employee.Rows[iRecordIndex].Cells[1].Value;
		        document.getElementById("<%=txt_Name.ClientID %>").value = Dg_Employee.Rows[iRecordIndex].Cells[2].Value;
		        document.getElementById("<%=txt_YearlyLimit.ClientID %>").value = Dg_Employee.Rows[iRecordIndex].Cells[3].Value;
		        document.getElementById("<%=txt_AllowedLimit.ClientID %>").value = Dg_Employee.Rows[iRecordIndex].Cells[4].Value;


		   }


           

		    
		   
    </script>
</body>
</html>
