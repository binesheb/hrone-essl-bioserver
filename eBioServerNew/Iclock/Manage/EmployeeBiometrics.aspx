<%@ page language="VB" autoeventwireup="false" inherits="Manage_EmployeeBiometrics, App_Web_v2kwzk4v" enableEventValidation="false" %>

<%@ Import Namespace="eBioServerLibrary.Utilities" %>

<%@ Register TagPrefix="obout" Namespace="Obout.Grid" Assembly="obout_Grid_NET" %>
<%@ Register TagPrefix="obout" Namespace="OboutInc.Flyout2" Assembly="obout_Flyout2_NET" %>
<%@ Register TagPrefix="uctrl" Src="~/Header.ascx" TagName="header" %>
<%@ Register TagPrefix="owd" Namespace="OboutInc.Window" Assembly="obout_Window_NET" %>
<%@ Register TagPrefix="oem" Namespace="OboutInc.EasyMenu_Pro" Assembly="obout_EasyMenu_Pro" %>
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
                        padding: 5px; color: white; width:50%">
                        Employee Biometrics - <b><%= URLEncodeDecode.GetQueryString(URLEncodeDecode.Decode(Request.QueryString("Id")), "EmployeeName")%></b>
                    </td>

                      <td align=right>
                    <input type=button value="Back" onclick="JavaScript:location.href='Employees.aspx';" />
                    </td>
                </tr>
                <tr style="background-color: lightsteelblue;">
                    <td colspan="2">
                        <hr />
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <div id="div_Employees">
                            <obout:Grid ID="Dg_Employees" runat="server"  Serialize="false"
                                AutoGenerateColumns="false" FolderStyle="~/styles/grid/styles/premiere_blue"
                                AllowMultiRecordDeleting="true" AllowAddingRecords="false" PageSize="20" AllowMultiRecordSelection="false"
                                GenerateRecordIds="true" AllowFiltering="true">
                              
                                <Columns>
                                    
                                    <obout:Column ID="Column1" DataField="BiometricName" Width="250" HeaderText="Biometric Name" ConvertEmptyStringToNull="False" Index="1" />
                                    
                                    <obout:Column HeaderText="Status" Width="170" AllowEdit="True" AllowDelete="True" ConvertEmptyStringToNull="False"
                            Index="3" TemplateId="tplEditBtn">
                            <TemplateSettings TemplateId="tplEditBtn" />
                        </obout:Column>
                                 </Columns>
                                

                                 <Templates>
                        <obout:GridTemplate runat="server" ID="tplEditBtn" ControlID="" ControlPropertyName="">
                            <Template>
                                <%# Container.DataItem("Status")%>
                            </Template>
                        </obout:GridTemplate>
                       
                    </Templates>
                            </obout:Grid>
                        </div>
                    </td>
                </tr>
            </table>
        </div>
        
    </form>
</body>
</html>



