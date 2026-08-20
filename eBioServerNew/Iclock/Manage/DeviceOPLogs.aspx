<%@ page language="VB" autoeventwireup="false" inherits="Manage_DeviceOPLogs, App_Web_v2kwzk4v" enableEventValidation="false" %>

<%@ Register TagPrefix="obout" Namespace="Obout.Grid" Assembly="obout_Grid_NET" %>
<%@ Register TagPrefix="uctrl" Src="~/Header.ascx" TagName="header" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" >


<html >
<head id="Head1" runat="server">
    <title>Untitled Page</title>
    <link href="../StyleSheet.css" rel="stylesheet" type="text/css" />
   
   <script type="text/javascript">
       var popUpobj;
       function showPopoUp(query) {

           window.open(query, "ModelPopopUp", "toolbar=no,scrollbars=no,location=no,resizable=yes,top=200,left=500,width=320,height=320");
       }

   </script>
</head>
   <uctrl:header ID="Header1" runat="server" />
<body>
    <form id="form1" runat="server">
    <uctrl:header ID="MyHeader" runat="server" />
    <table cellpadding="0" cellspacing="0" style="border-right: gray 1px solid; border-top: gray 1px solid;
        border-left: gray 1px solid; border-bottom: gray 1px solid;">
      <tr style="font-weight: bold; font-size: 14px; background-color: lightsteelblue;
            padding-left: 5px; padding-top: 3px; padding-bottom: 3px; color: white;">
            <td style="font-weight: bold; font-size: 14px; background-color: lightsteelblue;
                padding: 5px; color: white;">
                Device OP Logs List
            </td>
            <td align="right">
              
            </td>
        </tr>
        <tr style="background-color: lightsteelblue;">
            <td colspan="2" style="text-align: right;">
                <hr />
                
                &nbsp;
                From Date
                <asp:DropDownList ID="ddlFromDate" runat="server" Width="48px">

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
                &nbsp;To Date
                <asp:DropDownList ID="ddlToDate" runat="server" Width="48px">

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
                &nbsp; Month
                <asp:DropDownList ID="ddlMonth" runat="server" Width="48px" >
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
                </asp:DropDownList>&nbsp;
                Year
                <asp:TextBox ID="txtYear" runat="server" Width="48px" ></asp:TextBox>&nbsp;
                <asp:Button ID="btnGo" runat="server" Text="Refresh" OnClientClick="SetSource(this.id)" />

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
                <obout:Grid ID="Dg_DeviceLogs1" runat="server" ShowLoadingMessage="true" EnableRecordHover="true"
                    AllowFiltering="true" CallbackMode="true" Serialize="false" KeepSelectedRecords="true"
                    AutoGenerateColumns="false" AllowAddingRecords="False" FolderStyle="~/styles/grid/styles/premiere_blue"
                    Width="808px">
                    <Columns>






                        <obout:Column ID="OPLogDate" SortOrder="Desc" DataField="OPLogDate" Width="130"
                            HeaderText="OP Log Date" DataFormatString="{0:dd MMM yyyy HH:mm:ss}" ConvertEmptyStringToNull="False"
                            DataFormatString_GroupHeader="{0:dd MMM yyyy HH:mm:ss}" Index="0" />
                       
                        
                        <obout:Column ID="DeviceName" DataField="DeviceName" Width="120" HeaderText="Device Name" ConvertEmptyStringToNull="False"
                            Index="1">
                        </obout:Column>
                        <obout:Column ID="SerialNumber" DataField="SerialNumber" Width="120" HeaderText="Serial Number" ConvertEmptyStringToNull="False"
                            Index="2">
                        </obout:Column>
                        <obout:Column ID="Location" DataField="Location" Width="120" HeaderText="Location" ConvertEmptyStringToNull="False"
                            Index="3">
                        </obout:Column>
                         
                         <obout:Column ID="OPCode" DataField="OPCode" Width="80" HeaderText="OP Code" ConvertEmptyStringToNull="False"
                            Index="4">
                        </obout:Column>
                        <obout:Column ID="Description" DataField="Description" Width="350" HeaderText="Description" ConvertEmptyStringToNull="False"
                            Index="5">
                        </obout:Column>
                        
                       
                        
                    </Columns>
                    
                </obout:Grid>
            </td>
        </tr>
    </table>
    </form>
   
</body>
</html>
