<%@ page language="VB" autoeventwireup="false" inherits="Utilities_ParallelDataExport, App_Web_h00j2pts" enableEventValidation="false" %>

<%@ Register Assembly="obout_Window_NET" Namespace="OboutInc.Window" TagPrefix="owd" %>
<%@ Register TagPrefix="uctrl" Src="~/Header.ascx" TagName="header" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" >
<html >
<head id="Head1" runat="server">
    <title>Untitled Page</title>
    <link href="../StyleSheet.css" rel="stylesheet" type="text/css" />
</head>
   <uctrl:header ID="Header1" runat="server" />
<body onload="drp_DatabaseType_OnChange();chk_IsParallelDatabaseExport_onclick();">
    <form id="form1" runat="server">
        <div>
            <uctrl:header ID="MyHeader" runat="server" />
            <owd:Window ID="Wnd_ParallelDatabaseExport" runat="server" Height="380" Width="670"
                StyleFolder="~/Styles/mainwindow/blue" Title="Parallel Logs Export" ShowCloseButton="false"
                ShowStatusBar="False" Left="250" Top="25">
                <table class="rowEditTable" width="100%" cellpadding="1" style="border-top-style: none;
                    border-right-style: none; border-left-style: none; border-bottom-style: none;
                    height: 100%">
                    <tr>
                        <td>
                            <fieldset>
                                <legend>
                                    <asp:CheckBox ID="chk_IsParallelDatabaseExport" onclick="chk_IsParallelDatabaseExport_onclick();"
                                        Text=" Enable Parallel Logs Export" runat="server" /></legend>
                                <table id="table_ParallelDatabaseExport">
                                    <tr>
                                        <td style="font-weight: bold;width:30%">
                                            DB Type</td>
                                        <td style="width:20%;">
                                            <asp:DropDownList ID="drp_DatabaseType" runat="server" Width="150px" onchange="drp_DatabaseType_OnChange();">
                                                <asp:ListItem>MS SQL Server</asp:ListItem>
                                                <asp:ListItem>MS SQL Server (TLS)</asp:ListItem>
                                                <asp:ListItem>Oracle</asp:ListItem>
                                                <asp:ListItem>My Sql</asp:ListItem>
                                            </asp:DropDownList>
                                        </td>
                                        <td style="width:15%">
                                            Service</td>
                                        <td style="width:25%">
                                            <asp:TextBox ID="txt_Service" runat="server" Width="90px"></asp:TextBox></td>
                                        <td style="width:10%">
                                            Port</td>
                                        <td style="width:20%">
                                            <asp:TextBox ID="txt_Port" runat="server" Width="90px"></asp:TextBox></td>
                                    </tr>
                                    <tr>
                                        <td style="font-weight: bold;">
                                            Server Name/IP</td>
                                        <td>
                                            <asp:TextBox ID="txt_Ip" runat="server" Width="142px"></asp:TextBox>
                                        </td>
                                        <td  style="font-weight: bold;">
                                            DB Name
                                            
                                        </td>
                                        <td colspan="3"><asp:TextBox ID="txt_DBName" runat="server" Width="275px"></asp:TextBox></td>
                                    </tr>
                                    <tr>
                                        <td>
                                            User Name</td>
                                        <td>
                                            <asp:TextBox ID="txt_UserName" runat="server" Width="142px"></asp:TextBox>
                                        </td>
                                        <td >
                                            Password
                                            </td>
                                        <td colspan="3"><asp:TextBox ID="txt_Password" TextMode="Password" runat="server" Width="275px"></asp:TextBox>
                                        
                                        <asp:TextBox ID="txt_Password1" Visible=false runat="server" Width="275px"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="font-weight: bold;">
                                            Table Name</td>
                                        <td colspan="5">
                                            <asp:TextBox ID="txt_TableName" runat="server" Width="502px"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="6">
                                            <fieldset>
                                                <legend>Table Field Mapping</legend>
                                                <table width="100%">
                                                    <tr>
                                                        <td>
                                                            Employee Code=</td>
                                                        <td >
                                                            <asp:TextBox ID="txt_EmployeeCode" runat="server" Width="192px"></asp:TextBox></td>
                                                        <td>
                                                            Log DateTime=</td>
                                                        <td>
                                                            <asp:TextBox ID="txt_LogDateTime" runat="server" Width="192px"></asp:TextBox></td>
                                                        <td>

                                                    </tr>
                                                  
                                                    <tr>
                                                     <td >
                                                            Device&nbsp;Name=
                                                        </td>
                                                        <td >
                                                            <asp:TextBox ID="txt_DeviceName" runat="server" Width="192px"></asp:TextBox>
                                                        </td>
                                                         <td>
                                                            Serial Number=</td>
                                                        <td >
                                                            <asp:TextBox ID="txt_SerialNumb" runat="server" Width="192px"></asp:TextBox></td>

                                                       
                                                    </tr>
                                                    <tr>
                                                     <td>
                                                            Direction=</td>
                                                        <td>
                                                            <asp:TextBox ID="txt_Direction" runat="server" Width="192px"></asp:TextBox></td>
                                                       
                                                        <td>
                                                            Work Code=</td>
                                                        <td >
                                                            <asp:TextBox ID="txt_WorkCode" runat="server" Width="192px"></asp:TextBox></td>
                                                  
                                                       
                                                    </tr>
                                                    <tr>
                                                       <td>
                                                            VerificationType=</td>
                                                        <td>
                                                            <asp:TextBox ID="txt_VerificationType" runat="server" Width="192px"></asp:TextBox></td>
                                                       
                                                        <td>
                                                            GPS=</td>
                                                        <td >
                                                            <asp:TextBox ID="txt_GPS" runat="server" Width="192px"></asp:TextBox></td>
                                                  
                                                       
                                                    </tr>

                                                    <tr>
                                                       <td>
                                                            Punch&nbsp;IN=</td>
                                                        <td>
                                                            <asp:TextBox ID="txt_PunchIn" runat="server" Width="192px"></asp:TextBox></td>
                                                       
                                                        <td>
                                                            Punch&nbsp;OUT=</td>
                                                        <td >
                                                            <asp:TextBox ID="txt_PunchOut" runat="server" Width="192px"></asp:TextBox></td>
                                                  
                                                       
                                                    </tr>



                                                </table>
                                            </fieldset>
                                        </td>
                                    </tr>

                                    <tr>
                                    <td colspan="6"><b>Last Sync Log Date</b> (yyyy-MM-dd)&nbsp;<asp:TextBox ID="txt_LastSyncDate" runat="server" Width="142px"></asp:TextBox>&nbsp;<asp:Button
                                        ID="Btn_Reset" Width="50px" runat="server" Text="Reset" /></td>
                                    </tr>

                                </table>
                            </fieldset>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <table>
                                <tr>
                                    <td align="left" style="width: 520px">
                                        <asp:Button ID="btn_TestConnection" runat="server" Text="Test Connection" />
                                    </td>
                                    <td align="right">
                                        <asp:Button ID="Btn_Save" runat="server" Text="Save" />&nbsp;&nbsp;
                                        <input id="btn_Cancel" type="button" value="Close" onclick="Wnd_ParallelDatabaseExport.Close();" />&nbsp;&nbsp;
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="Lbl_Error" runat="server" EnableViewState="False" Text="&nbsp;" ForeColor="Red"></asp:Label>
                        </td>
                    </tr>
                    <tr><td><br /><br /><br /></td></tr>
                </table>
            </owd:Window>
        </div>
    </form>

    <script type="text/javascript">
        function drp_DatabaseType_OnChange() {
            document.getElementById("<%=txt_Service.ClientID %>").disabled = false;
            document.getElementById("<%=txt_Port.ClientID %>").disabled = false;
            document.getElementById("<%=txt_Ip.ClientID %>").disabled = false;
            document.getElementById("<%=txt_DBName.ClientID %>").disabled = false;
            document.getElementById("<%=txt_UserName.ClientID %>").disabled = false;
            document.getElementById("<%=txt_Password.ClientID %>").disabled = false;
            var DatabaseType = document.getElementById("<%=drp_DatabaseType.ClientID %>").value;

            if (DatabaseType == 'MS SQL Server') {
                document.getElementById("<%=txt_Service.ClientID %>").disabled = true;
                document.getElementById("<%=txt_Port.ClientID %>").disabled = true;
            }

            else if (DatabaseType == 'Oracle') {
                document.getElementById("<%=txt_DBName.ClientID %>").disabled = true;
            }

            else if (DatabaseType == 'My Sql') {
                document.getElementById("<%=txt_Service.ClientID %>").disabled = true;
            }
        }

        function chk_IsParallelDatabaseExport_onclick() {
            if (document.getElementById("<%=chk_IsParallelDatabaseExport.ClientID %>").checked) {
                document.getElementById("table_ParallelDatabaseExport").disabled = false;
            }
            else {
                document.getElementById("table_ParallelDatabaseExport").disabled = true;
            }

        }

      
    </script>

</body>
</html>

