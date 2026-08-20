<%@ page language="VB" autoeventwireup="false" inherits="Admin_Users2, App_Web_euao2wv0" enableEventValidation="false" %>
<%@ Register TagPrefix="obout" Namespace="Obout.Grid" Assembly="obout_Grid_NET" %>
<%@ Register TagPrefix="obout" Namespace="OboutInc.Flyout2" Assembly="obout_Flyout2_NET" %>
<%@ Register TagPrefix="uctrl" Src="~/Header.ascx" TagName="header" %>
<%@ Register TagPrefix="owd" Namespace="OboutInc.Window" Assembly="obout_Window_NET" %>

<script type="text/javascript" src="../md5-min.js"></script>
<script runat=server>
    Function URLEncode(ByVal url) As String
        url = url + "&sessionid=" + Session.SessionID
        Return eBioServerLibrary.Utilities.URLEncodeDecode.Encode(url)
            
    End Function
</script>
<script type="text/javascript">	
	// Client-Side Events for Delete
	    function OnBeforeDelete(record) 
	        {
	            record.Error='';
		        document.getElementById("<%=Hdn_UserId.ClientID %>").value = record.UserId;
	            if(confirm("Are you sure you want to delete? "))
	                return true;
	            else
	                return false;
	        }
	        
	    function OnBeforeClientInsert(record) 
	    {
	       
	        
	    }   
	     
	     
	    function EncryptPassword1()
        {
       
            var str = '<%= Session("rnumb") %>';
            if(document.getElementById('<%= txt_Password.ClientID %>').value != "")
            {
             var passstr=document.getElementById('<%= txt_Password.ClientID %>').value;
             document.getElementById('<%= txt_Password.ClientID %>').value= str+hex_md5(passstr);
            }
           return true;
       }   
	       
	
	    function OnDelete(record) 
	    {
	        alert(record.Error);
	    }
    	
	    function OnInsert(record) 
	    {
		    document.getElementById("<%=Lbl_InvalidError.ClientID %>").innerHTML = record.Error;
	    }
	    
	    
	
</script>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" >
<html >
<head runat="server">
    <title>Untitled Page</title>
    <link href="../StyleSheet.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript">
      function OpenPopUpWindow(url)

       {
          var iMyWidth;
          var iMyHeight;
          iMyWidth = (window.screen.width / 2) - (75 + 10);
          iMyHeight = (window.screen.height / 2) - (100 + 50);
          window.open( url, "PopupChild", "status=no,height=450,width=490,resizable=yes,left=" + iMyWidth + ",top=" + iMyHeight + ",screenX=" + iMyWidth + ",screenY=" + iMyHeight + ",toolbar=no,menubar=no,scrollbars=no,location=no,directories=no");
       }
       
        function ReloadGrid() {  
                 window.grid_SystemUsers.refresh();                   
                 
                }  
    </script>
    
</head>
   <uctrl:header ID="Header1" runat="server" />
<body>
    <form id="form1" runat="server">
        <div>
           
            <table cellpadding="0" cellspacing="0" style="border-right: gray 1px solid; border-top: gray 1px solid;
                border-left: gray 1px solid; border-bottom: gray 1px solid;">
                <tr style="font-weight: bold; font-size: 14px; background-color: lightsteelblue;
                    padding-left: 5px; padding-top: 3px; padding-bottom: 3px; color: white;">
                    <td colspan="2" style="font-weight: bold; font-size: 14px; background-color: lightsteelblue;padding:5px; color: white;">
                        Users List
                    </td>
                </tr>
                
                 <tr style=" background-color: lightsteelblue;">
                <td colspan="2">
                <hr /> 
                </td>
                </tr>
                
                <tr>
                    <td colspan="2">
                        <obout:Grid ID="grid_SystemUsers" runat="server" CallbackMode="true" EnableRecordHover="true"
                            KeepSelectedRecords="true" Serialize="true" AllowFiltering="true" AutoGenerateColumns="false"
                            FolderStyle="~/styles/grid/styles/premiere_blue" AllowAddingRecords="true" ShowLoadingMessage="false"
                            OnRebind="RebindGrid" OnInsertCommand="InsertRecord" OnDeleteCommand="DeleteRecord">
                            <ClientSideEvents OnClientInsert="OnInsert" OnBeforeClientInsert="OnBeforeClientInsert" OnBeforeClientDelete="OnBeforeDelete" OnClientDelete="OnDelete"/>
                            <TemplateSettings NewRecord_TemplateId="tplAddBtn" />
                            <Columns>
                                <obout:Column ID="Column0" DataField="UserId" Visible="false" Width="35" HeaderText="UserId"
                                    runat="server" Index="0" />
                                <obout:Column ID="Column1" DataField="LoginName" SortOrder="Asc" Visible="true" Width="400" HeaderText="Login Name"
                                    runat="server" Index="1" />
                                <obout:Column ID="Column2" DataField="RoleName" Visible="true" Width="200" HeaderText="Role Name"
                                    runat="server" Index="2" />
                                 <obout:Column ID="Column3" DataField="Locations" Visible="true" Width="200" HeaderText="Location"
                                    runat="server" Index="3" />

                                <obout:Column ID="Column6" DataField="Permissions" Visible="false" Width="300"
                                    HeaderText="" runat="server"  Index="4"/>
                               
                                 <obout:Column HeaderText="Edit" Width="90" AllowEdit="true" AllowDelete="true">
                                    <TemplateSettings TemplateId="tplEditBtn" />
                                </obout:Column>
                                    
                                <obout:Column HeaderText="Delete"  Width="90" AllowEdit="false" AllowDelete="true"
                                    Visible="true" />
                                
                            </Columns>
                            <Templates>
                                <obout:GridTemplate runat="server" ID="tplEditBtn">
                                    <Template>
                                        <a href="javascript: //" id="Edit_UserInfo" class="ob_gAL" onclick="OpenPopUpWindow('<%# "EditUserPermissions.aspx?Id=" + URLEncode("Id=" +  Container.DataItem("UserId"))%>')"><%#CheckPermissionsEdit("Edit")%></a>
                                    </Template>
                                </obout:GridTemplate>
                                
                                <obout:GridTemplate runat="server" ID="tplDeleteBtn">
                                    <Template>
                                        <a href="javascript: //"   id="grid_link_<%# Container.PageRecordIndex %>" 
                                            class="ob_gAL">Delete</a>
                                    </Template>
                                </obout:GridTemplate>
                                
                                
                                <obout:GridTemplate runat="server" ID="tplAddBtn">
                                    <Template>
                                        <a href="javascript: //" runat="server" id="btAdd" onclick="attachFlyoutToLink(this,'Add')" class="ob_gAL">
                                            <%#CheckPermissions("Add")%></a>
                                    </Template>
                                </obout:GridTemplate>
                            </Templates>
                        </obout:Grid>
                    </td>
                </tr>
            </table>
            
            <obout:Flyout runat="server" ID="Flyout1" Align="left" Position="BOTTOM_left" CloseEvent="NONE"
                OpenEvent="NONE" DelayTime="500">
                <table class="rowEditTable">
                    <tr>
                        <td>
                            <fieldset>
                                <legend>System User Information</legend>
                                <table>
                                    <tr>
                                        <td style="font-weight: bold;">
                                            Login Name</td>
                                        <td>
                                            <asp:TextBox ID="txt_Login" AutoComplete="off"  runat="server" Width="130px"></asp:TextBox>
                                        </td>
                                        <td style="font-weight: bold;">
                                            Password
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txt_Password" runat="server" CssClass="WebControls" TextMode="Password" Width="130px"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        
                                        <td>
                                            Role Name
                                        </td>
                                        <td >
                                            <asp:TextBox ID="txt_RoleName" CssClass="WebControls" runat="server" Width="130px"></asp:TextBox>
                                        </td>
                                        <td>All&nbsp;Locations</td>
                                        <td>
                                            <asp:DropDownList ID="drpAllLocations" runat="server" CssClass="WebControls"  Width="130px">
                                                <asp:ListItem Value="1" Selected=True>Yes</asp:ListItem>
                                                <asp:ListItem Value="0">No</asp:ListItem>
                                            </asp:DropDownList>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="2">
                                          Permissions Allowed
                                        </td>
                                        <td colspan="2">
                                           Locations
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="2">
                                            <div id="div_tree" runat="server" style="border-right: black 1px solid; border-top: black 1px solid; border-left: black 1px solid; border-bottom: black 1px solid;" >
                                            <asp:Literal ID="TreeView" EnableViewState="true" runat="server" />
                                        </div>
                                            <select visible="false" id="lst_Permissions" class="WebControls" runat="server" multiple="true" style="width: 202px;height:200px">
                                            </select>
                                        </td>
                                        <td colspan="2" valign=top>
                                            <asp:ListBox ID="lst_Locations" SelectionMode=Multiple runat="server" class="WebControls" style="width: 202px; Height:200px"></asp:ListBox>
                                        
                                        
                                        </td>
                                        
                                    </tr>
                                    <tr>
                                        <td colspan="2">
                                          <asp:HyperLink ID="lnk_PermissionsSelectAll" Style="cursor: hand;" CssClass="WebControls" onclick="SelectAllPermissions()"
                                                runat="server">Select All</asp:HyperLink>&nbsp;&nbsp;&nbsp;
                                            <asp:HyperLink ID="lnk_PermissionsDeSelectAll" Style="cursor: hand;" CssClass="WebControls" onclick="DeSelectAllPermissions()"
                                                runat="server">Deselect All</asp:HyperLink>
                                        </td>
                                        <td colspan="2">
                                          <asp:HyperLink  ID="HyperLink1" Style="cursor: hand;" CssClass="WebControls" onclick="SelectAllLocations()"
                                                runat="server">Select All</asp:HyperLink>&nbsp;&nbsp;&nbsp;
                                            <asp:HyperLink  ID="HyperLink2" Style="cursor: hand;" CssClass="WebControls" onclick="DeSelectAllLocations()"
                                                runat="server">Deselect All</asp:HyperLink>
                                        </td>
                                    </tr>

                                    <tr>
                                        <td colspan="4">
                                        
                                        <asp:CheckBox ID="chkStrongPassword" runat="server" Text="Enforce Strong Password" />&nbsp;
                                            <asp:CheckBox ID="chkBlockInvalidLogin" runat="server" Text="Block if 3 invalid login attempts" />
                                            
                                        
                                        </td>
                                    </tr>
                                   <tr>
                                        <td colspan="4">
                                        Password Expires 

                                         <asp:DropDownList ID="drpPasswordExpiry" runat="server" CssClass="WebControls"  Width="130px">
                                                <asp:ListItem Value="0" Selected=True>Never</asp:ListItem>
                                                <asp:ListItem Value="30">30 Days</asp:ListItem>
                                                <asp:ListItem Value="60">60 Days</asp:ListItem>
                                                <asp:ListItem Value="90">90 Days</asp:ListItem>
                                            </asp:DropDownList>

                                        </td>
                                        </tr>

                                </table>
                            </fieldset>
                        </td>
                    </tr>
                    <tr>
                        <td align="right" colspan="2">
                            <asp:Label runat="server" foreColor="red" EnableViewState="false" ID="Lbl_InvalidError"></asp:Label>&nbsp;<input id="btn_Save" type="button" value="Save" onclick="javascript:btn_Save_onclick();" />&nbsp;&nbsp;&nbsp;&nbsp;<input
                                id="btn_Cancel" type="button" value="Close" onclick="javascript:closeFlyout();" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            &nbsp; &nbsp; &nbsp;
                            
                            <asp:HiddenField  ID="Hdn_UserId" runat="server" />
                            <asp:HiddenField  ID="Hdn_Password" runat="server" />
                            <asp:HiddenField  ID="Hdn_LoginUserId" runat="server" />
                            <asp:HiddenField ID="Hdn_PermissionsId" runat="server" />
                             <asp:HiddenField ID="Hdn_LocationsId" runat="server" />
                             <asp:HiddenField ID="Hdn_LocationsName" runat="server" />
                            
                        </td>
                    </tr>
                </table>
            </obout:Flyout>
        </div>
    </form>
    
    <script runat="server">
        Function CheckPermissions(ByVal Action As String) As String
            If Not Session.Item("LoginUser") Is Nothing Then
                If CType(Session("LoginUser"), eBioServerLibrary.Data.Admin.User).PermissionList.Contains("AddUsers") Then
                    Return Action
                End If
                Return ""
            End If
        End Function
        
        Function CheckPermissionsEdit(ByVal Action As String) As String
            If Not Session.Item("LoginUser") Is Nothing Then
                If CType(Session("LoginUser"), eBioServerLibrary.Data.Admin.User).PermissionList.Contains("EditUsers") Then
                    Return Action
                End If
                Return ""
            End If
        End Function
        
    </script>

    <script type="text/javascript">
		    
		    function attachFlyoutToLink(oLink,Action)
		        {	
		            var Flyout=<%=Flyout1.getClientID()%>
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

                       
		            
		            document.getElementById("<%=txt_Login.ClientID %>").value = grid_SystemUsers.Rows[iRecordIndex].Cells[1].Value;
		            document.getElementById("<%=txt_Password.ClientID %>").value = '';
		            document.getElementById( "<%=txt_RoleName.ClientID %>").value = grid_SystemUsers.Rows[iRecordIndex].Cells[2].Value;
		            document.getElementById("<%=Hdn_UserId.ClientID %>").value = grid_SystemUsers.Rows[iRecordIndex].Cells[0].Value;
		            SelectPermissions(grid_SystemUsers.Rows[iRecordIndex].Cells[4].Value);
                        
		            
		        }
		   
		   function SelectPermissions(Permissions)
		        {
		            var PermissionArray=new Array();
                    PermissionArray = Permissions.split(',');
                    var DivObjevt=document.getElementById("<%=div_tree.ClientID %>");
		            var arrCheckboxes = DivObjevt.getElementsByTagName("INPUT");   
                   
		                for(var i=0;i<PermissionArray.length;i++)
		                {
		                    for(var j=0;j<arrCheckboxes.length;j++)
		                    {
		                        if (PermissionArray[i]==arrCheckboxes[j].name)
		                        {
		                            arrCheckboxes[j].checked=true;
		                        }
		                    }
		                }
		        }
		   

		      

		      
		       function SelectAllPermissions()
		        {
		            var DivObjevt=document.getElementById("<%=div_tree.ClientID %>");
		            var arrCheckboxes = DivObjevt.getElementsByTagName("INPUT");    
                    for(var i=0; i<arrCheckboxes.length; i++)
                     {      
                        if(arrCheckboxes[i].type == "checkbox")
                         {
                            arrCheckboxes[i].checked=true;
                        }
                    }
		        }
		        
		       
		      
		       function DeSelectAllPermissions()
		        {
		            var DivObjevt=document.getElementById("<%=div_tree.ClientID %>");
		            var arrCheckboxes = DivObjevt.getElementsByTagName("INPUT");    
                    for(var i=0; i<arrCheckboxes.length; i++)
                     {      
                        if(arrCheckboxes[i].type == "checkbox")
                         {
                            arrCheckboxes[i].checked=false;
                        }
                    }
		        }
		      
		      
                function SelectAllLocations()
		        {
		            var DivObjevt=document.getElementById("<%=lst_Locations.ClientID %>");

                   
                    for(var i=0; i<DivObjevt.options.length; i++)
                     {  
                            DivObjevt.options[i].selected = true;
                        
                    }
		        }
		        
		       
		      
		       function DeSelectAllLocations()
		        {
		            var DivObjevt=document.getElementById("<%=lst_Locations.ClientID %>");
                    for(var i=0; i<DivObjevt.options.length; i++)
                     {      
                        DivObjevt.options[i].selected=false;
                    }
                    
		        }
		      

		       function btn_Save_onclick()
		        {
		            document.getElementById("<%=Hdn_PermissionsId.ClientID %>").value='';
		            var oRecord = new Object();
		            
		            var DivObjevt=document.getElementById("<%=div_tree.ClientID %>");
		             var arrCheckboxes = DivObjevt.getElementsByTagName("INPUT");    
                    for(var i=0; i<arrCheckboxes.length; i++)
                     {      
                        if(arrCheckboxes[i].type == "checkbox" && arrCheckboxes[i].checked==true)
                         {
	                        document.getElementById("<%=Hdn_PermissionsId.ClientID %>").value=document.getElementById("<%=Hdn_PermissionsId.ClientID %>").value+arrCheckboxes[i].name+','
                            
                        }
                    }

                    document.getElementById("<%=Hdn_LocationsId.ClientID %>").value="";
                    document.getElementById("<%=Hdn_LocationsName.ClientID %>").value="";


                    ListViewObject=document.getElementById("<%=lst_Locations.ClientID %>");
	                for(var k=0;k<ListViewObject.options.length;k++)
	                        {
	                                if(ListViewObject.options[k].selected==true)
	                                {
	                                    document.getElementById("<%=Hdn_LocationsId.ClientID %>").value=document.getElementById("<%=Hdn_LocationsId.ClientID %>").value+ListViewObject.options[k].value+','
	                                    document.getElementById("<%=Hdn_LocationsName.ClientID %>").value=document.getElementById("<%=Hdn_LocationsName.ClientID %>").value+ListViewObject.options[k].text+','
	                                }
	                        }


	                oRecord.Login =document.getElementById("<%=txt_Login.ClientID %>").value ;
                    document.getElementById('<%= Hdn_Password.ClientID %>').value="";
	                var str = '<%= Session("rnumb") %>';
                    if(document.getElementById('<%= txt_Password.ClientID %>').value != "")
                    {
                     var passstr=document.getElementById('<%= txt_Password.ClientID %>').value;
                     document.getElementById('<%= Hdn_Password.ClientID %>').value= str+ hex_md5(passstr);
                     document.getElementById('<%= txt_Password.ClientID %>').value="";

                    }


	                oRecord.Error='';
	                grid_SystemUsers.executeInsert(oRecord);
		        }
		    
            function clearFlyout() 
            {
                document.getElementById("<%=txt_Login.ClientID %>").value = '';
		        document.getElementById("<%=txt_Password.ClientID %>").value = '';
		        document.getElementById( "<%=txt_RoleName.ClientID %>").value = '';
		        document.getElementById( "<%=drpPasswordExpiry.ClientID %>").value = '0';
		        document.getElementById("<%=Hdn_UserId.ClientID %>").value = '0';
		        document.getElementById("<%=Lbl_InvalidError.ClientID %>").innerHTML ='';


                document.getElementById( "<%=chkStrongPassword.ClientID %>").checked = false;
                document.getElementById( "<%=chkBlockInvalidLogin.ClientID %>").checked = false;

		        
		        SelectAllPermissions();
		    }
    </script>

</body>
</html>
