<%@ page language="VB" autoeventwireup="false" inherits="Visitor_VisitorLogs, App_Web_03za5vfq" enableEventValidation="false" %>

<%@ Register TagPrefix="obout" Namespace="Obout.Grid" Assembly="obout_Grid_NET" %>
<%@ Register TagPrefix="obout" Namespace="OboutInc.Flyout2" Assembly="obout_Flyout2_NET" %>

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
                Visitor Logs List
            </td>
            <td align="right">
              
            </td>
        </tr>
        <tr style="background-color: lightsteelblue;">
            <td colspan="2" style="text-align: right;">
                <hr />
                 Location
                 <asp:DropDownList ID="drpLocation"  Width="130px" runat="server">
                                    </asp:DropDownList>
                
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
                <obout:Grid ID="Dg_List" runat="server" ShowLoadingMessage="true" EnableRecordHover="true"
                    AllowFiltering="true" CallbackMode="true" Serialize="false" KeepSelectedRecords="true"
                    AutoGenerateColumns="false" AllowAddingRecords="true" FolderStyle="~/styles/grid/styles/premiere_blue"
                    Width="808px">
                    <Columns>






                        <obout:Column ID="InDate" SortOrder="Desc" DataField="InDate" Width="110"
                            HeaderText="In Date" DataFormatString="{0:dd MMM yyyy HH:mm}" ConvertEmptyStringToNull="False"
                            DataFormatString_GroupHeader="{0:dd MMM yyyy HH:mm}" Index="0" />

                        <obout:Column ID="OutDate" SortOrder="Desc" DataField="OutDate" Width="110"
                            HeaderText="Out Date" DataFormatString="{0:dd MMM yyyy HH:mm}" ConvertEmptyStringToNull="False"
                            DataFormatString_GroupHeader="{0:dd MMM yyyy HH:mm}" Index="1" />
                       
                       
                         <obout:Column ID="Location" DataField="Location" Width="100" HeaderText="Location" ConvertEmptyStringToNull="False"
                            Index="2">
                        </obout:Column>

                        <obout:Column ID="Name" DataField="Name" Width="120" HeaderText="Name"
                            ConvertEmptyStringToNull="False" Index="3" />

                        <obout:Column ID="Company" DataField="Company" Width="120" HeaderText="Company" ConvertEmptyStringToNull="False"
                            Index="4">
                        </obout:Column>

                        <obout:Column ID="Designation" DataField="Designation" Visible=false Width="100" HeaderText="Designation" ConvertEmptyStringToNull="False"
                            Index="5">
                        </obout:Column>

                         <obout:Column ID="ToMeet" DataField="ToMeet" Width="140" HeaderText="To Meet" ConvertEmptyStringToNull="False"
                            Index="6">
                        </obout:Column>
                         <obout:Column ID="Purpose" DataField="Purpose" Width="220" HeaderText="Purpose" ConvertEmptyStringToNull="False"
                            Index="7">
                        </obout:Column>

                         <obout:Column ID="VisitorDesk" Visible=false DataField="VisitorDesk" Width="100" HeaderText="VisitorDesk" ConvertEmptyStringToNull="False"
                            Index="8">
                        </obout:Column>
                        
                         <obout:Column ID="VisitorCard"  Visible=false DataField="VisitorCard" Width="100" HeaderText="VisitorCard" ConvertEmptyStringToNull="False"
                            Index="9">
                        </obout:Column>
                        
                         <obout:Column  ID="Status" DataField="Status" Width="80" HeaderText="Status" ConvertEmptyStringToNull="False"
                            Index="10">
                        </obout:Column>


                        <obout:Column HeaderText="Photo" Width="80" AllowEdit="true" AllowDelete="true"  Index="11" >
                                    <TemplateSettings TemplateId="tplPhotoBtn" />
                                </obout:Column>

                         <obout:Column Visible=false ID="ContactNumber" DataField="ContactNumber" Width="220" HeaderText="ContactNumber Type" ConvertEmptyStringToNull="False"
                            Index="12">
                        </obout:Column>
                        
                         <obout:Column Visible=false ID="Email" DataField="Email" Width="220" HeaderText="Email" ConvertEmptyStringToNull="False"
                            Index="13">
                        </obout:Column>
                        
                        

                        

                        
                           <obout:Column ID="Column13" DataField="Remarks" Width="120" HeaderText="FDate"
                            ConvertEmptyStringToNull="False" Visible=False Index="14" />

                      
                        
                         <obout:Column HeaderText="" Width="140" AllowEdit="True" AllowDelete="True" ConvertEmptyStringToNull="False"
                            Index="15" TemplateId="tplEditBtn">
                            <TemplateSettings TemplateId="tplEditBtn" />
                        </obout:Column>


                    </Columns>
                    <Templates>
                       
                         <obout:GridTemplate runat="server" ID="tplEditBtn" ControlID="" ControlPropertyName="">
                            <Template>
                                <a href="javascript: //" id="grid_link_<%# Container.PageRecordIndex %>" onclick="attachFlyoutToLink(this)"
                                    class="ob_gAL">View Other Details</a>
                            </Template>
                        </obout:GridTemplate>

                        <obout:GridTemplate runat="server" ID="tplPhotoBtn">
                            <Template>
                            <a href='Javascript:void(0);' onclick="showPopoUp('<%# "ViewVisitorLogPhoto.aspx?Id=" +  ParsePhotoVar(Container.DataItem.Item("Id"))%>')"><%# IsPhoto(Container.DataItem.Item("Photo"))%></a>
                               
                                
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
                        <legend>Other Details</legend>
                        <table>

                            <tr>
                                <td align="right" style="font-weight: bold;">
                                    Visitor Desk
                                </td>
                                <td>
                                    <asp:TextBox ID="txt_VisitorDesk" Enabled=false runat="server" CssClass="WebControls" Width="175px"></asp:TextBox>
                                </td>
                                <td align="right" style="font-weight: bold;">
                                    Visitor Card
                                </td>
                                <td>
                                    <asp:TextBox ID="txt_VisitorCard"  Enabled=false runat="server" CssClass="WebControls" Width="175px"></asp:TextBox>
                                </td>
                            </tr>
                            

                            <tr>
                                <td align="right" style="font-weight: bold;">
                                    Contact&nbsp;Number
                                </td>
                                <td>
                                    <asp:TextBox ID="txt_ContactNumber" Enabled=false runat="server" CssClass="WebControls" Width="175px"></asp:TextBox>
                                </td>
                                <td align="right" style="font-weight: bold;">
                                    Email
                                </td>
                                <td>
                                    <asp:TextBox ID="txt_Email"  Enabled=false runat="server" CssClass="WebControls" Width="175px"></asp:TextBox>
                                </td>
                            </tr>
                            

                            <tr>
                                <td align="right"  style="font-weight: bold;">
                                  Remarks
                                </td>
                                <td colspan="3">
                                     <asp:TextBox TextMode=MultiLine Rows=3 Enabled=false ID="txt_Remarks" runat="server" CssClass="WebControls"
                                        Width="465px"></asp:TextBox> 
                                </td>


                                

                            </tr>
                                                        



                        </table>
                    </fieldset>
                </td>
            </tr>
            <tr>
            
             <td align="right">

                                
                                    <asp:Label runat="server" ForeColor="red" EnableViewState="false" Text="&nbsp;&nbsp;&nbsp;&nbsp;"
                                        ID="Lbl_InvalidError"></asp:Label>

                                    <input
                                        id="btn_Cancel" type="button" value="Close" onclick="javascript:closeFlyout_Details();" />
                                </td>
            </tr>
        </table>
    </obout:Flyout>
   </form>
    

      <script type="text/javascript">
		        
 	            function attachFlyoutToLink(oLink)
		        {	
	                <%=Flyout1.getClientID()%>.AttachTo(oLink.id);		            		            
	                <%=Flyout1.getClientID()%>.Open();
                    populateEditControls(oLink.id.toString().replace("grid_link_", ""));
		        }
	        function closeFlyout_Details() 
		    {
		        <%=Flyout1.getClientID()%>.Close();
		    }
		    
		   
		    
		     function clearFlyout_Details() 
            {
              
                document.getElementById("<%=Lbl_InvalidError.ClientID %>").innerHTML='';

               }

           
         
		    
		     function populateEditControls(iRecordIndex) 
		    {	
		        document.getElementById("<%=txt_VisitorDesk.ClientID %>").value = Dg_List.Rows[iRecordIndex].Cells[8].Value;
		        document.getElementById("<%=txt_VisitorCard.ClientID %>").value = Dg_List.Rows[iRecordIndex].Cells[9].Value;
		        document.getElementById("<%=txt_ContactNumber.ClientID %>").value = Dg_List.Rows[iRecordIndex].Cells[12].Value;
		        document.getElementById("<%=txt_Email.ClientID %>").value = Dg_List.Rows[iRecordIndex].Cells[13].Value;                                

                document.getElementById("<%=txt_Remarks.ClientID %>").value = Dg_List.Rows[iRecordIndex].Cells[14].Value.replaceAll('<br>','\n');
                

		   }


           

		    
		   
    </script>


    <script runat="server">
        
        Function ParseDirection(ByVal Direction As String, ByVal DeviceDirection As String)
            
            Try
                If DeviceDirection = "DEVICE" Then
                    Return Direction
                Else
                    Return DeviceDirection
                End If
            Catch ex As Exception
                Return ""
            End Try
            
        End Function
        
        Function IsPhoto(ByVal varIsPhoto As String)
            
            Try
                If varIsPhoto = "" Then
                    Return ""
                Else
                    Return "View"
                End If
            Catch ex As Exception
                Return ""
            End Try
            
        End Function
        
        
        Function ParsePhotoVar(ByVal Id As String)
         
            Try
                Return URLEncode("Id=" & Id)
                
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
