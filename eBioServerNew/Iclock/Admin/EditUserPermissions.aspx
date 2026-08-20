<%@ page language="VB" autoeventwireup="false" inherits="Manage_EditUserPermissions, App_Web_euao2wv0" enableEventValidation="false" %>
<%@ Register TagPrefix="obout" Namespace="Obout.Grid" Assembly="obout_Grid_NET" %>
<%@ Register TagPrefix="obout" Namespace="OboutInc.Flyout2" Assembly="obout_Flyout2_NET" %>
<%@ Register Assembly="obout_Window_NET" Namespace="OboutInc.Window" TagPrefix="owd" %>
<%@ Register TagPrefix="oem" Namespace="OboutInc.EasyMenu_Pro" Assembly="obout_EasyMenu_Pro" %>
<%@ Register TagPrefix="uctrl" Src="~/Header.ascx" TagName="header" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" >

<html  >
<head runat="server">
    <title>Edit User Details</title>
        <link href="../StyleSheet.css" rel="stylesheet" type="text/css" />
        <script type="text/javascript" src="../md5-min.js"></script>

        <script type="text/javascript">

		      
		       function SelectAllPermissions()
		        {
		            var DivObjevt=document.getElementById("<%=div_Edittree.ClientID %>");
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
		            var DivObjevt=document.getElementById("<%=div_Edittree.ClientID %>");
		            var arrCheckboxes = DivObjevt.getElementsByTagName("INPUT");    
                    for(var i=0; i<arrCheckboxes.length; i++)
                     {      
                        if(arrCheckboxes[i].type == "checkbox")
                         {
                            arrCheckboxes[i].checked=false;
                        }
                    }
                }

                function SelectAllLocations() {
                    var DivObjevt = document.getElementById("<%=lst_Locations.ClientID %>");


                    for (var i = 0; i < DivObjevt.options.length; i++) {
                        DivObjevt.options[i].selected = true;

                    }
                }



                function DeSelectAllLocations() {
                    var DivObjevt = document.getElementById("<%=lst_Locations.ClientID %>");
                    for (var i = 0; i < DivObjevt.options.length; i++) {
                        DivObjevt.options[i].selected = false;
                    }

                }
		      

		        
		        function SelectPermissions()
		        {
		            var listString = document.getElementById('Hdn_EditPermissionsId').value;
                    var PermissionArray=new Array();
                    PermissionArray = listString.split(',');
                    var DivObjevt=document.getElementById("<%=div_Edittree.ClientID %>");
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
		        
		        
		        function btn_Save_onclick()
		        {
		            document.getElementById("<%=Hdn_EditPermissionsId.ClientID %>").value='';
		            document.getElementById("<%=Hdn_EditCompaniesId.ClientID %>").value='';
		            var oRecord = new Object();
		            
		            var DivObjevt=document.getElementById("<%=div_Edittree.ClientID %>");
		            var arrCheckboxes = DivObjevt.getElementsByTagName("INPUT");    
                    for(var i=0; i<arrCheckboxes.length; i++)
                    {      
                        if(arrCheckboxes[i].type == "checkbox" && arrCheckboxes[i].checked==true)
                         {
	                        document.getElementById("<%=Hdn_EditPermissionsId.ClientID %>").value=document.getElementById("<%=Hdn_EditPermissionsId.ClientID %>").value+arrCheckboxes[i].name+','
                            
                        }
	                }


                    
                    var str = '<%= Session("rnumb") %>';
                    if(document.getElementById('<%= txt_EditPassword.ClientID %>').value != "")
                    {
                     var passstr=document.getElementById('<%= txt_EditPassword.ClientID %>').value;
                     document.getElementById('<%= txt_EditPassword.ClientID %>').value= str+ hex_md5(passstr);
                 }

                 document.getElementById("<%=Hdn_LocationsId.ClientID %>").value = "";
                 document.getElementById("<%=Hdn_LocationsName.ClientID %>").value = "";

                 ListViewObject = document.getElementById("<%=lst_Locations.ClientID %>");
                 for (var k = 0; k < ListViewObject.options.length; k++) {
                     if (ListViewObject.options[k].selected == true) {
                         document.getElementById("<%=Hdn_LocationsId.ClientID %>").value = document.getElementById("<%=Hdn_LocationsId.ClientID %>").value + ListViewObject.options[k].value + ','
                         document.getElementById("<%=Hdn_LocationsName.ClientID %>").value = document.getElementById("<%=Hdn_LocationsName.ClientID %>").value + ListViewObject.options[k].text + ','
                     }
                 }


                    
	               
		        }
		        
		        function Close() {  
                   opener.ReloadGrid();  
                   self.close();  
                } 
		      
        
        </script>
</head>
   <uctrl:header ID="MyHeader" runat="server" />

<body>
    <form id="form1" runat="server">
    <div>
        <table class="rowEditTable">
            <tr>
                <td>
                    <fieldset>
                        <legend>System User Information</legend>
                        <table>
                            <tr>
                                <td style="font-weight: bold;">
                                    Login&nbsp;Name</td>
                                <td>
                                    <asp:TextBox ID="txt_EditLogin" AutoComplete="off"  runat="server" Width="130px"></asp:TextBox>
                                </td>
                                <td style="font-weight: bold;">
                                    Password
                                </td>
                                <td>
                                    <asp:TextBox ID="txt_EditPassword" runat="server" CssClass="WebControls" TextMode="Password"
                                        Width="130px"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                           
                                <td>
                                    Role Name
                                </td>
                                <td >
                                    <asp:TextBox ID="txt_EditRoleName" CssClass="WebControls" runat="server" Width="130px"></asp:TextBox>
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
                                       <div id="div_Edittree" runat="server" style="border-right: black 1px solid; border-top: black 1px solid;
                                        border-left: black 1px solid; border-bottom: black 1px solid;">
                                        <asp:Literal ID="EditTreeview" EnableViewState="true" runat="server" />
                                    </div>
                                    <select visible="false" id="lst_EditPermissions" class="WebControls" runat="server"
                                        multiple="true" style="width: 202px; height: 200px">
                                    </select></td>

                                    <td colspan="2" valign=top>
                                            <asp:ListBox ID="lst_Locations" SelectionMode=Multiple runat="server" class="WebControls" style="width: 202px; Height:200px"></asp:ListBox>
                                        
                                        
                                        </td>


                            </tr>
                            <tr>
                                <td colspan="2" style="text-align: left">
                                    <asp:HyperLink ID="lnk_EditPermissionsSelectAll" Style="cursor: hand;" CssClass="WebControls"
                                        onclick="SelectAllPermissions()" runat="server">Select All</asp:HyperLink>&nbsp;<asp:HyperLink ID="lnk_EditPermissionsDeSelectAll" Style="cursor: hand;" CssClass="WebControls"
                                        onclick="DeSelectAllPermissions()" runat="server">Deselect All</asp:HyperLink></td>
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
                <td align="right" colspan="2"><asp:Label runat="server" ForeColor="red" EnableViewState="false" ID="Label1"></asp:Label>
                    <asp:Button ID="btnSave" runat="server" Text="Save" OnClientClick="btn_Save_onclick()"  />
                    <input
                        id="btn_EditCancel" type="button" value="Close" onclick="Close();" />
                </td>
            </tr>
            <tr>
                <td>
                    &nbsp; &nbsp; &nbsp;
                    
                    <asp:HiddenField ID="Hdn_EditUserId" runat="server" />
                    <asp:HiddenField ID="Hdn_EditLoginUserId" runat="server" />
                    <asp:HiddenField ID="Hdn_EditPermissionsId" runat="server" />
                    <asp:HiddenField ID="Hdn_EditCompaniesId" runat="server" />
                    <asp:HiddenField ID="Hdn_EditLoginPassword" runat="server" />
                    <asp:HiddenField  ID="Hdn_Password" runat="server" />
                    <asp:HiddenField ID="Hdn_LocationsId" runat="server" />
                    <asp:HiddenField ID="Hdn_LocationsName" runat="server" />


                </td>
            </tr>
        </table>
    </div>
    </form>
</body>
</html>
