<%@ page language="VB" autoeventwireup="false" inherits="Attendance_Holidays, App_Web_haagzrto" enableEventValidation="false" %>


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
                Holidays
            </td>
            <td align="right">
                <asp:Label ID="lblError" runat="server" Width="300px" ForeColor="Red"></asp:Label>
                &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;
            </td>
        </tr>
        
          <tr style="background-color: lightsteelblue;">
                <td colspan="2" style="text-align: right;font-weight: normal; font-size: 11px; ">
                    <hr />

                   Select Year 
                    <asp:DropDownList ID="ddlYears" runat="server" AutoPostBack="false" Width="70px">
                        
                    </asp:DropDownList>
                   Location
                 <asp:DropDownList ID="drpLocation"  Width="130px" runat="server">
                                    </asp:DropDownList> 
                                   
                    <asp:Button ID="btlReset" runat="server" Text="Filter"   OnClientClick="SetSource(this.id)"  />  &nbsp;
                   <asp:HiddenField ID="hidSourceID" runat="server" />
                  <script type="text/javascript">
                      function SetSource(SourceID) {
                          var hidSourceID = document.getElementById("<%=hidSourceID.ClientID%>");
                          hidSourceID.value = SourceID;
                      }
                  </script>
                </td>
            </tr>


        <tr>
            <td colspan="2">
                <obout:Grid ID="Dg_Holidays" runat="server" ShowLoadingMessage="true" EnableRecordHover="true"
                    AllowFiltering="true" CallbackMode="true" Serialize="false" KeepSelectedRecords="true"
                    AutoGenerateColumns="false" AllowAddingRecords="true" FolderStyle="~/styles/grid/styles/premiere_blue"
                    Width="907px" OnInsertCommand="InsertRecord" OnDeleteCommand="DeleteRecord">
                    <ClientSideEvents OnClientInsert="OnInsert" OnBeforeClientDelete="OnBeforeDelete"
                        OnClientDelete="OnDelete" />
                    <TemplateSettings NewRecord_TemplateId="tplAddBtn" />
                    <Columns>
                        <obout:Column ID="Id" DataField="Id" Visible="False" Width="100" ReadOnly="True"
                            HeaderText="Id" ConvertEmptyStringToNull="False" Index="0" />
                        <obout:Column ID="Date" DataField="Date" Width="150" HeaderText="Date"
                            ConvertEmptyStringToNull="False" DataFormatString="{0:dd MMM yyyy}" Index="1" />
                        <obout:Column ID="Name" DataField="Name" Width="280" HeaderText="Name"
                            ConvertEmptyStringToNull="False" Index="2" />
                        <obout:Column ID="Location" DataField="Location" Width="200" HeaderText="Location"
                            ConvertEmptyStringToNull="False" Index="3">
                        </obout:Column>
                        <obout:Column HeaderText="Edit" Width="70" AllowEdit="True" AllowDelete="True" ConvertEmptyStringToNull="False"
                            Index="4" TemplateId="tplEditBtn">
                            <TemplateSettings TemplateId="tplEditBtn" />
                        </obout:Column>
                        <obout:Column HeaderText="Delete" Width="60" AllowDelete="True" ConvertEmptyStringToNull="False"
                            Index="5" />
                       
                       <obout:Column ID="FDate" DataField="FDate" Width="120" HeaderText="FDate"
                            ConvertEmptyStringToNull="False" Visible=False Index="6" />
                    
                          <obout:Column ID="LocationId" DataField="LocationId" Width="120" HeaderText="LocationId"
                            ConvertEmptyStringToNull="False" Visible=False Index="7" />

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
                                    <%#CheckPermissions("Add", "AddHoliday")%>
                                </a>
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
                        <legend>Holiday Details</legend>
                        <table>
                            <tr>
                                <td align="right" style="font-weight: bold;">
                                    Holiday&nbsp;Date
                                </td>
                                <td>
                                    
                                      <asp:DropDownList runat="server" ID="drpDay" Width="40px">
                                            <asp:ListItem Value="01">1</asp:ListItem>
                                            <asp:ListItem Value="02">2</asp:ListItem>
                                            <asp:ListItem Value="03">3</asp:ListItem>
                                            <asp:ListItem Value="04">4</asp:ListItem>
                                            <asp:ListItem Value="05">5</asp:ListItem>
                                            <asp:ListItem Value="06">6</asp:ListItem>
                                            <asp:ListItem Value="07">7</asp:ListItem>
                                            <asp:ListItem Value="08">8</asp:ListItem>
                                            <asp:ListItem Value="09">9</asp:ListItem>
                                            <asp:ListItem Value="10">10</asp:ListItem>
                                            <asp:ListItem Value="11">11</asp:ListItem>
                                            <asp:ListItem Value="12">12</asp:ListItem>
                                            <asp:ListItem Value="13">13</asp:ListItem>
                                            <asp:ListItem Value="14">14</asp:ListItem>
                                            <asp:ListItem Value="15">15</asp:ListItem>
                                            <asp:ListItem Value="16">16</asp:ListItem>
                                            <asp:ListItem Value="17">17</asp:ListItem>
                                            <asp:ListItem Value="18">18</asp:ListItem>
                                            <asp:ListItem Value="19">19</asp:ListItem>
                                            <asp:ListItem Value="20">20</asp:ListItem>
                                            <asp:ListItem Value="21">21</asp:ListItem>
                                            <asp:ListItem Value="22">22</asp:ListItem>
                                            <asp:ListItem Value="23">23</asp:ListItem>
                                            <asp:ListItem Value="24">24</asp:ListItem>
                                            <asp:ListItem Value="25">25</asp:ListItem>
                                            <asp:ListItem Value="26">26</asp:ListItem>
                                            <asp:ListItem Value="27">27</asp:ListItem>
                                            <asp:ListItem Value="28">28</asp:ListItem>
                                            <asp:ListItem Value="29">29</asp:ListItem>
                                            <asp:ListItem Value="30">30</asp:ListItem>
                                            <asp:ListItem Value="31">31</asp:ListItem>
                                            </asp:DropDownList>
                                            -
                                            <asp:DropDownList runat="server" ID="drpMonth" Width="50px">
                                            <asp:ListItem Text="Jan" Value="01"></asp:ListItem>
                                            <asp:ListItem Text="Feb" Value="02"></asp:ListItem>
                                            <asp:ListItem Text="Mar" Value="03"></asp:ListItem>
                                            <asp:ListItem Text="Apr" Value="04"></asp:ListItem>
                                            <asp:ListItem Text="May" Value="05"></asp:ListItem>
                                            <asp:ListItem Text="Jun" Value="06"></asp:ListItem>
                                            <asp:ListItem Text="Jul" Value="07"></asp:ListItem>
                                            <asp:ListItem Text="Aug" Value="08"></asp:ListItem>
                                            <asp:ListItem Text="Sep" Value="09"></asp:ListItem>
                                            <asp:ListItem Text="Oct" Value="10"></asp:ListItem>
                                            <asp:ListItem Text="Nov" Value="11"></asp:ListItem>
                                            <asp:ListItem Text="Dec" Value="12"></asp:ListItem>

                                            </asp:DropDownList>
                                            -
                                         <asp:DropDownList ID="drpYear" runat="server" AutoPostBack="false" Width="60px" />

                                </td>
                               
                            </tr>
                               <tr>
                                <td align="right" style="font-weight: bold;">
                                    Holiday&nbsp;Title
                                </td>
                                <td>
                                    <asp:TextBox ID="txt_Name"  runat="server" CssClass="WebControls"
                                        Width="175px"></asp:TextBox>
                                </td>
                                
                            </tr>
                       
                              <tr>
                                <td align="right" style="font-weight: bold;">
                                    Location
                                </td>
                                <td>
                                    <asp:DropDownList ID="drpBaseLocation" runat="server"  CssClass="WebControls" Width="175px" >
                                    </asp:DropDownList>
                                </td>
                                
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

		        Dg_Holidays.executeInsert(oRecord);
		    }
		    
		     function clearFlyout_Details() 
            {
                
                document.getElementById("<%=Hdn_Id.ClientID %>").value = '0';
		        document.getElementById("<%=txt_Name.ClientID %>").value = '';
		        document.getElementById("<%=drpDay.ClientID %>").value = '01';
		        document.getElementById("<%=drpMonth.ClientID %>").value = '01';
		        document.getElementById("<%=drpYear.ClientID %>").value =  document.getElementById("<%=ddlYears.ClientID %>").value;
                document.getElementById("<%=drpBaseLocation.ClientID %>").value = '0';
		        
		        document.getElementById("<%=Lbl_InvalidError.ClientID %>").innerHTML='';


               }

           
         
		    
		     function populateEditControls(iRecordIndex) 
		    {	
		        document.getElementById("<%=Hdn_Id.ClientID %>").value = Dg_Holidays.Rows[iRecordIndex].Cells[0].Value;
		        document.getElementById("<%=txt_Name.ClientID %>").value = Dg_Holidays.Rows[iRecordIndex].Cells[2].Value;

                
                document.getElementById("<%=drpDay.ClientID %>").value = Dg_Holidays.Rows[iRecordIndex].Cells[6].Value.split("/")[0];
                document.getElementById("<%=drpMonth.ClientID %>").value = Dg_Holidays.Rows[iRecordIndex].Cells[6].Value.split("/")[1];
                document.getElementById("<%=drpYear.ClientID %>").value = Dg_Holidays.Rows[iRecordIndex].Cells[6].Value.split("/")[2];
                
		        document.getElementById("<%=drpBaseLocation.ClientID %>").value =  Dg_Holidays.Rows[iRecordIndex].Cells[7].Value;


		                  


		   }


           

		    
		   
    </script>
</body>
</html>
