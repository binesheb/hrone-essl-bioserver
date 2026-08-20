<%@ page language="VB" autoeventwireup="false" inherits="Manage_Members, App_Web_v2kwzk4v" enableEventValidation="false" %>

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
        document.getElementById("<%=Hdn_MemberId.ClientID %>").value = record.MemberId;
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
                Members List
            </td>
            <td align="right">
                <asp:Label ID="lblError" runat="server" Width="300px" ForeColor="Red"></asp:Label>
                &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;
            </td>
        </tr>
        <tr>
            <td colspan="2">
                <obout:Grid ID="Dg_Member" runat="server" ShowLoadingMessage="true" EnableRecordHover="true"
                    AllowFiltering="true" CallbackMode="true" Serialize="false" KeepSelectedRecords="true"
                    AutoGenerateColumns="false" AllowAddingRecords="true" FolderStyle="~/styles/grid/styles/premiere_blue"
                    Width="907px" OnInsertCommand="InsertRecord" OnDeleteCommand="DeleteRecord">
                    <ClientSideEvents OnClientInsert="OnInsert" OnBeforeClientDelete="OnBeforeDelete"
                        OnClientDelete="OnDelete" />
                    <TemplateSettings NewRecord_TemplateId="tplAddBtn" />
                    <Columns>
                        <obout:Column ID="Id" DataField="MemberId" Visible="False" Width="100" ReadOnly="True"
                            HeaderText="MemberId" ConvertEmptyStringToNull="False" Index="0" />
                        <obout:Column ID="MemberCode" DataField="MemberCode" Width="160" HeaderText="Member Code"
                            ConvertEmptyStringToNull="False" Index="1" />
                        <obout:Column ID="MemberName" DataField="MemberName" Width="160" HeaderText="Member Name"
                            ConvertEmptyStringToNull="False" Index="2" />
                        <obout:Column ID="Column2" DataField="Location" Width="150" HeaderText="Location"
                            ConvertEmptyStringToNull="False" Index="3">
                        </obout:Column>
                        <obout:Column ID="Column3" DataField="Role" Width="100" HeaderText="Role" ConvertEmptyStringToNull="False"
                            Index="4">
                        </obout:Column>
                        <obout:Column ConvertEmptyStringToNull="False" DataField="MemberRFIDNumber" HeaderText="Card Number"
                            Index="5" Width="100">
                        </obout:Column>
                        <obout:Column ConvertEmptyStringToNull="False" DataField="VerificationType" HeaderText="VerificationType"
                            Visible="false" Index="6">
                        </obout:Column>
                        <obout:Column ConvertEmptyStringToNull="False" DataField="VerificationTypeName" Width="200"
                            HeaderText="Verification Type" Visible="True" Index="7">
                        </obout:Column>
                        <obout:Column Width="100" ConvertEmptyStringToNull="False" Index="8" TemplateId="tplViewMemberBiometricsBtn">
                            <TemplateSettings TemplateId="tplViewMemberBiometricsBtn" />
                        </obout:Column>
                        <obout:Column HeaderText="Edit" Width="70" AllowEdit="True" AllowDelete="True" ConvertEmptyStringToNull="False"
                            Index="9" TemplateId="tplEditBtn">
                            <TemplateSettings TemplateId="tplEditBtn" />
                        </obout:Column>
                        <obout:Column HeaderText="Delete" Width="70" AllowDelete="True" ConvertEmptyStringToNull="False"
                            Index="10" />
                        <obout:Column ConvertEmptyStringToNull="False" DataField="ExpiryFrom" HeaderText="ExpiryFrom"
                            Visible="false" Index="11">
                        </obout:Column>
                        <obout:Column ConvertEmptyStringToNull="False" DataField="ExpiryTo" HeaderText="ExpiryTo"
                            Visible="false" Index="12">
                        </obout:Column>
                           <obout:Column ConvertEmptyStringToNull="False" DataField="GroupId" HeaderText="GroupId"
                            Visible="false" Index="13">
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
                                    <%#CheckPermissions("Add", "AddMembersAC")%>
                                </a>
                            </Template>
                        </obout:GridTemplate>
                        <obout:GridTemplate runat="server" ID="tplViewMemberBiometricsBtn" ControlID=""
                            ControlPropertyName="">
                            <Template>
                                <asp:HyperLink runat="server" CssClass="ob_gAL" Style="cursor: hand;" Text='<%# CheckPermissions("Biometrics","MemberBiometrics")%>'
                                    NavigateUrl='<%# CheckPermissions("~/Manage/MemberBiometrics.aspx?Id=" + URLEncode("MemberCode=" + Container.DataItem.Item("MemberCode")+"&MemberName=" + Container.DataItem.Item("MemberName")),"MemberBiometrics")%>'
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
                        <legend>Member Details</legend>
                        <table>
                            <tr>
                                <td align="right" style="font-weight: bold;">
                                    Member Code
                                </td>
                                <td>
                                    <asp:TextBox ID="txt_Membercode" runat="server" CssClass="WebControls" Width="175px"></asp:TextBox>
                                </td>
                                <td align="right" style="font-weight: bold;">
                                    Member Name
                                </td>
                                <td>
                                    <asp:TextBox ID="txt_MemberName" runat="server" CssClass="WebControls" Width="175px"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td align="right" style="font-weight: bold;">
                                    Location
                                </td>
                                <td>
                                    <asp:TextBox ID="txt_Location" runat="server"  CssClass="WebControls" Width="175px" ></asp:TextBox>
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
                                <td align="right" style="font-weight: bold;">
                                    Expiry From
                                </td>
                                <td>
                                    <asp:TextBox ID="txt_ExpiryFrom" runat="server"  CssClass="WebControls" Width="90px" ></asp:TextBox>(yyyy-MM-dd)
                                </td>
                                <td align="right" style="font-weight: bold;">
                                    Expiry To
                                </td>
                                <td>
                                    <asp:TextBox ID="txt_ExpiryTo" runat="server" CssClass="WebControls" Width="90px"></asp:TextBox>(yyyy-MM-dd)
                                </td>
                            </tr>
                           
                        </table>
                    </fieldset>
                </td>
                <tr>
                
                 
                                <td align="right" >
                                 <asp:HiddenField ID="Hdn_MemberId" runat="server" />
                                    <asp:Label runat="server" ForeColor="red" EnableViewState="false" Text="&nbsp;&nbsp;&nbsp;&nbsp;"
                                        ID="Lbl_InvalidError"></asp:Label>
                                    <input id="btn_Save" type="button" value="Save" onclick="javascript:btn_Save_onclick();" />&nbsp;&nbsp;<input
                                        id="btn_Cancel" type="button" value="Close" onclick="javascript:closeFlyout_Details();" />
                                </td>
                            </tr>
                          
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
		        oRecord.MemberId =document.getElementById("<%=Hdn_MemberId.ClientID %>").value ;
		        oRecord.Error='';
		        
		        Dg_Member.executeInsert(oRecord);
		    }
		    
		     function clearFlyout_Details() 
            {
                document.getElementById("<%=Hdn_MemberId.ClientID %>").value = '0';
		        document.getElementById("<%=txt_Membercode.ClientID %>").value = '';
		        document.getElementById("<%=txt_MemberName.ClientID %>").value = '';
		        document.getElementById("<%=txt_CardNumber.ClientID %>").value = '';
		        document.getElementById("<%=drp_Role.ClientID %>").value = 'Normal User';
                document.getElementById("<%=drp_VerificationType.ClientID %>").value = '0';

                document.getElementById("<%=txt_ExpiryFrom.ClientID %>").value = '2000-01-01';
		        document.getElementById("<%=txt_ExpiryTo.ClientID %>").value = '3000-01-01';
		        
                document.getElementById("<%=txt_EmpDevicePassword.ClientID %>").value = '';
                document.getElementById("<%=txt_GroupId.ClientID %>").value = '1';
		        document.getElementById("<%=Lbl_InvalidError.ClientID %>").innerHTML='';

                document.getElementById("<%=txt_Membercode.ClientID %>").disabled = false;
               }

           
         
		    
		     function populateEditControls(iRecordIndex) 
		    {	
                
                
		        document.getElementById("<%=Hdn_MemberId.ClientID %>").value = Dg_Member.Rows[iRecordIndex].Cells[0].Value;
		        document.getElementById("<%=txt_Membercode.ClientID %>").value = Dg_Member.Rows[iRecordIndex].Cells[1].Value;
		        document.getElementById("<%=txt_MemberName.ClientID %>").value = Dg_Member.Rows[iRecordIndex].Cells[2].Value;
                document.getElementById("<%=txt_Location.ClientID %>").value = Dg_Member.Rows[iRecordIndex].Cells[3].Value;
                document.getElementById("<%=drp_Role.ClientID %>").value = Dg_Member.Rows[iRecordIndex].Cells[4].Value;
		        document.getElementById("<%=txt_CardNumber.ClientID %>").value = Dg_Member.Rows[iRecordIndex].Cells[5].Value;
                document.getElementById("<%=drp_VerificationType.ClientID %>").value = Dg_Member.Rows[iRecordIndex].Cells[6].Value;
                document.getElementById("<%=txt_ExpiryFrom.ClientID %>").value = Dg_Member.Rows[iRecordIndex].Cells[11].Value;
                document.getElementById("<%=txt_ExpiryTo.ClientID %>").value = Dg_Member.Rows[iRecordIndex].Cells[12].Value;
                document.getElementById("<%=txt_GroupId.ClientID %>").value = Dg_Member.Rows[iRecordIndex].Cells[13].Value;
                                
                document.getElementById("<%=txt_Membercode.ClientID %>").disabled = true;
		                  


		   }


           

		    
		   
    </script>
</body>
</html>
