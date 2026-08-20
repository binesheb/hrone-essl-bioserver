<%@ page language="VB" autoeventwireup="false" inherits="Utilities_ImportEmployees, App_Web_h00j2pts" enableEventValidation="false" %>

<%@ Register Assembly="obout_Window_NET" Namespace="OboutInc.Window" TagPrefix="owd" %>
<%@ Register TagPrefix="uctrl" Src="~/Header.ascx" TagName="header" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" >
<html >
<head id="Head1" runat="server">
    <title>Untitled Page</title>
    <link href="../StyleSheet.css" rel="stylesheet" type="text/css" />

    <style>

        .displayNone { display: none; }
    </style>

</head>
   <uctrl:header ID="Header1" runat="server" />
<body background="../Images/bck1.gif" style="background-repeat: no-repeat; background-position-x: right;
    background-position-y: top;">
    <form id="form1" runat="server">
    <div>
        <uctrl:header ID="MyHeader" runat="server" />
        <owd:Window ID="wnd_AddUpdate" runat="server" Height="130" StyleFolder="~/Styles/mainwindow/blue"
            Title="Import Employees List (Access Control)" Width="425" IsResizable="true" ShowStatusBar="false"
            Left="350" Top="155" >
            <table width="100%" cellpadding="1" class="Table" style="border-top-style: none;
                border-right-style: none; border-left-style: none; border-bottom-style: solid;">
               
                <tr>
                    <td>
                        <fieldset style="width: 395px;">
                            <legend>Import</legend>
                            <table>
                               
                                <tr>
                                    <td>
                                        &nbsp;Import&nbsp;From&nbsp;
                                    </td>
                                    <td>
                                        <asp:FileUpload ID="fleup_Employee" runat="server" Width="210px" CssClass="WebControls" />
                                    </td>
                                     <td><a target=_blank href="Employeelist_AccessControl.csv">sample&nbsp;format</a></td>
                                </tr>

                                 <tr><td>&nbsp;Import&nbsp;Purpose&nbsp;</td><td colspan=2><asp:DropDownList ID="drp_Pupose" runat="server" Width="150px">
                                        <asp:ListItem Text="Add/Update" Value="Add" Selected></asp:ListItem>
                                        <asp:ListItem Text="Delete" Value="Delete"></asp:ListItem>
                                    </asp:DropDownList></td></tr>

                            </table>
                        </fieldset>
                    </td>
                   
                </tr>
                <tr>
                    <td align="right" style="padding-right:5px;" >

                        <asp:Label ID="lblSuccess" runat="server" Visible=false ForeColor="Green" Text="Label"></asp:Label>
                                         <asp:Literal ID="ltlMessage" runat="server"></asp:Literal> 

                        <input id="btn_AddDelete" type="button" value="Import" onclick="OnBeforeImport();" class="WebControls" />

                       &nbsp;
                        <input id="btn_Cancel" type="button" value="Close" onclick="closeWindow();" class="WebControls" /> 
                        
                        <asp:Button ID="btn_OK" CssClass="displayNone" runat="server" Width="0" Height="0"  Text="" />
                    </td>
                </tr>
            </table>
          
        </owd:Window>
    
    </div>
    </form>

    
    <script type="text/javascript">


        function OnBeforeImport() {

                    

            if (document.getElementById("<%=drp_Pupose.ClientID %>").value == 'Delete') {

                if (confirm("Are you sure you want to delete? ")) {

                    document.getElementById("<%=btn_OK.ClientID %>").click();
                    return;
                }
                else {
                    return;
                }

            }

            document.getElementById("<%=btn_OK.ClientID %>").click();
        }


    function closeWindow()
		     {
		         try
		         {
		        
		        wnd_AddUpdate.Close();
		         }
		         catch(ex)
		         {
		            alert(ex.message);
		         }
		    }
		    
		  
		    
		    
		    
		    
    </script>
</body>
</html>
