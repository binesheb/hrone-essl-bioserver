<%@ page language="VB" autoeventwireup="false" inherits="Reports_Payslips, App_Web_jj0rp3ex" enableEventValidation="false" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>

<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
    Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>
<%@ Register Assembly="obout_Window_NET" Namespace="OboutInc.Window" TagPrefix="owd" %>
<%@ Register TagPrefix="uctrl" Src="~/Header.ascx" TagName="header" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" >
<html>
<head id="Head1" runat="server">
    <title>Untitled Page</title>
    <link href="../StyleSheet.css" rel="stylesheet" type="text/css" />
</head>
<uctrl:header ID="Header1" runat="server" />
<body background="../Images/bck1.gif" style="background-repeat: no-repeat; background-position-x: right;
    background-position-y: top;">
    <form id="form1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <asp:UpdatePanel ID="UpdatePanel3" UpdateMode="Always" runat="server">
        <ContentTemplate>
            <table cellpadding="0" cellspacing="0" style="border-right: gray 1px solid; border-top: gray 1px solid;
                border-left: gray 1px solid; border-bottom: gray 1px solid;" runat="server" id="tblReport">
                <tr id="trHeader" style="font-weight: bold; font-size: 14px; background-color: lightsteelblue;
                    padding-left: 5px; padding-top: 3px; padding-bottom: 3px; color: white;">
                    <td style="font-weight: bold; font-size: 14px; background-color: lightsteelblue;
                        padding: 5px; color: white;">
                        Payslip Report
                    </td>
                    <td align="right">
                        <input id="btnDisplayReportForm" type="button" onclick="DisplayReportForm();" value="Regenerate Report" />&nbsp;
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <div style="">
                            <rsweb:ReportViewer ID="ReportViewer1" runat="server" BorderColor="Black" BackColor="White"
                                Font-Names="Verdana" Font-Size="8pt" InteractiveDeviceInfos="(Collection)" WaitMessageFont-Names="Verdana"
                                WaitMessageFont-Size="14pt" Width="100%" Height="100%" AsyncRendering="true"
                                SizeToReportContent="true">
                            </rsweb:ReportViewer>
                        </div>
                    </td>
                </tr>
            </table>

             <owd:Window ID="WndCommand0" runat="server" IsModal="true" Height="142" Width="375"
            StyleFolder="~/Styles/mainwindow/blue" Title="Payslip Report" VisibleOnLoad="true"
            ShowCloseButton="true" Left="350" Top="100" ShowStatusBar="False">

            
                <table class="rowEditTable" style="width:100%;" height="100%">
                    <tr>
                        <td>
                            <fieldset>
                                <table style="width:100%;">
                                    <tr>
                                        <td>
                                           &nbsp;Pay&nbsp;Cycle
                                        </td>
                                        <td width="100%" align="left">
                                        
                    
                                   
                                            <asp:DropDownList ID="ddlFromYears" runat="server" AutoPostBack="true" Width="70px">
                        
                    </asp:DropDownList>
                    -
                         <asp:DropDownList ID="ddlPayCycle" DataTextField="Name" DataValueField="Id" runat="server" AutoPostBack="false" Width="150px">
                        
                    </asp:DropDownList>
                                        </td>
                                    </tr>


                                     

                                    <tr>
                                    <td>&nbsp;Location</td>
                                    <td align=left>
                                    <asp:DropDownList ID="drpLocation"  Width="200px" runat="server">
                                    </asp:DropDownList>
                                    </td>
                                    </tr>
                                     <tr>
                                    <td>&nbsp;Employee&nbsp;Code</td>
                                    <td align=left>
                                    
                                     <asp:TextBox ID="txt_EmployeeCode"  runat="server" CssClass="WebControls"
                                        Width="200px"></asp:TextBox>

                            
        <ajaxToolkit:AutoCompleteExtender ID="AutoCompleteExtender1" runat="server" ServiceMethod="SearchEmployees"
            MinimumPrefixLength="1" CompletionInterval="100" EnableCaching="false" CompletionSetCount="10"
            TargetControlID="txt_EmployeeCode" FirstRowSelected="false" 
            CompletionListCssClass="CompletionListCssClass"
            CompletionListItemCssClass="CompletionListItemCssClass" 
            CompletionListHighlightedItemCssClass="CompletionListHighlightedItemCssClass" >
        </ajaxToolkit:AutoCompleteExtender>

         </script>

   
                                    
                                    </td>
                                    </tr>



                                </table>
                            </fieldset>
                        </td>
                    </tr>
                    <tr>
                        <td align="right">
                            <asp:Label ID="hiddenThreadId" Visible="false" runat="server" Text=""></asp:Label>
                            <asp:Timer ID="Timer1" OnTick="Timer1_Tick" runat="server" Enabled="false" /> 
                           <asp:Label runat="server" ForeColor="red" EnableViewState="false" Text=""
                                        ID="Lbl_InvalidError"></asp:Label><asp:Label ID="Label1" runat="server" Text=""></asp:Label>
                            <asp:Button ID="btnOk" runat="server" Text="Generate Report" />&nbsp;
                        </td>
                    </tr>
                    
                </table>
                 
            </owd:Window>
        </ContentTemplate>
    </asp:UpdatePanel>
    </form>
    <script type="text/javascript">


        function DisplayReportForm() {

            try {
                WndCommand0.Open();
            }
            catch (ex) {
                alert(ex);
            }


        }   

    </script>
    
    
     <style>
        
 .CompletionListCssClass
{
    z-index: 99999 !important;
    border: solid 1px #444444;
    margin: 0px;
    padding: 2px;
    overflow: auto;
    background-color: ivory;
    cursor: pointer;
    text-align:left;
    list-style-type:none;
 
}
.CompletionListHighlightedItemCssClass
{
	z-index: 99999!important;
	background-color:#ffff99;
	cursor:hand;
	
 
}
.CompletionListItemCssClass
{
	z-index: 99999!important;
	background-color:Window;
	cursor:hand;
	
}
    </style>

    </body>
</html>
