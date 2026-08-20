<%@ page language="VB" autoeventwireup="false" inherits="Payroll_Payslips, App_Web_rhfymj1w" enableEventValidation="false" %>

<%@ Import Namespace="eBioServerLibrary.Utilities" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>
<%@ Register TagPrefix="uctrl" Src="~/Header.ascx" TagName="header" %>

<%@ Register TagPrefix="obout" Namespace="Obout.Grid" Assembly="obout_Grid_NET" %>
<%@ Register TagPrefix="obout" Namespace="OboutInc.Flyout2" Assembly="obout_Flyout2_NET" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" >
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
                Payslips of <b><%=URLEncodeDecode.GetQueryString(URLEncodeDecode.Decode(Request.QueryString("Id")), "Name")%> </b>
            </td>
            <td align="right">
               
            </td>
        </tr>
        
          <tr style="background-color: lightsteelblue;">
                <td colspan="2" style="text-align: right;font-weight: normal; font-size: 11px; ">
                    <hr />

                  
                     Location
                 <asp:DropDownList ID="drpLocation"  Width="130px" runat="server">
                                    </asp:DropDownList>

                   
                 
                    &nbsp;
                    <asp:Button ID="btlReset" runat="server" Text="Filter"   OnClientClick="SetSource(this.id)"  />  &nbsp;
                                       <asp:HiddenField ID="hidSourceID" runat="server" />
                  <script type="text/javascript">
                      function SetSource(SourceID) {
                          var hidSourceID = document.getElementById("<%=hidSourceID.ClientID%>");
                          hidSourceID.value = SourceID;
                      }
                  </script>
   
                   <asp:Button ID="btnBack" runat="server" Text="Back"   />

                </td>
            </tr>


        <tr>
            <td colspan="2">
                <obout:Grid ID="Dg_List" runat="server" ShowLoadingMessage="true" EnableRecordHover="true"
                    AllowFiltering="true" CallbackMode="true" Serialize="false" KeepSelectedRecords="true"
                    AutoGenerateColumns="false" AllowAddingRecords="false" FolderStyle="~/styles/grid/styles/premiere_blue"
                    Width="907px" >
                    <Columns>
                        <obout:Column ID="Id" DataField="Id" Visible="False" Width="100" ReadOnly="True"
                            HeaderText="Id" ConvertEmptyStringToNull="False" Index="0" />
                       


                        <obout:Column ID="Column4" DataField="EmployeeCode" Width="130" HeaderText="Employee Code"
                            ConvertEmptyStringToNull="False"  Index="1" />

                        <obout:Column ID="Column7" DataField="EmployeeName" Width="130" HeaderText="Employee Name"
                            ConvertEmptyStringToNull="False"  Index="2" />


                        <obout:Column ID="Column5" DataField="AttendanceLocation" Width="130" HeaderText="Location"
                            ConvertEmptyStringToNull="False"  Index="3" />

                        <obout:Column ID="Column3" DataField="GrossSalary" Width="120" HeaderText="Gross Salary"
                            ConvertEmptyStringToNull="False"  Index="4" />


                        <obout:Column ID="Column6" DataField="NetSalary" Width="120" HeaderText="Net Salary"
                            ConvertEmptyStringToNull="False"  Index="5" />



                     <obout:Column HeaderText="" Width="130" AllowEdit="True" AllowDelete="True" ConvertEmptyStringToNull="False"
                            Index="6" TemplateId="tplComponentsBtn">
                            <TemplateSettings TemplateId="tplComponentsBtn" />
                        </obout:Column>

                     

                    </Columns>
                    <Templates>
                       

                        <obout:GridTemplate runat="server" ID="tplComponentsBtn" ControlID="" ControlPropertyName="">
                            <Template>
                                
                                     <asp:HyperLink runat="server" CssClass="ob_gAL" Style="cursor: hand;" Text='Pay Components'
                                    NavigateUrl='<%#"~/Payroll/PayslipComponets.aspx?Id=" + URLEncode("PayCycleId=" + URLEncodeDecode.GetQueryString(URLEncodeDecode.Decode(Request.QueryString("Id")), "Id")+"&Year=" + URLEncodeDecode.GetQueryString(URLEncodeDecode.Decode(Request.QueryString("Id")), "Year") + "&Id="+ Container.DataItem.Item("Id") + "&Location=" + drpLocation.SelectedValue + "&EmployeeCode=" + Container.DataItem.Item("EmployeeCode") + "&EmployeeName=" + Container.DataItem.Item("EmployeeName") + "&PayCycleName=" & URLEncodeDecode.GetQueryString(URLEncodeDecode.Decode(Request.QueryString("Id")), "Name") )%>'
                                    ID="AA1" />

                            </Template>
                        </obout:GridTemplate>

                     
                    </Templates>
                </obout:Grid>
            </td>
        </tr>
    </table>
   
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
    
</body>
</html>
