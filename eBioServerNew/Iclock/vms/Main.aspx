<%@ page language="VB" autoeventwireup="false" inherits="vms_Main, App_Web_sk3pvy4c" enableEventValidation="false" %>

<%@ Register Src="SideMenu.ascx" TagName="Menu" TagPrefix="uc1" %>
<%@ Register src="Header.ascx" tagname="Header" tagprefix="uc2" %>
<%@ Register src="Footer.ascx" tagname="Footer" tagprefix="uc3" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <link rel="preconnect" href="https://fonts.gstatic.com">
    <link rel="shortcut icon" href="img/icons/icon-48x48.ico" />
    <title>eBio - VMS</title>
    <link href="css/app.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;600&display=swap"
        rel="stylesheet">


</head>

<link rel="stylesheet" type="text/css" href="js/datatables.min.css">
<script src="js/jquery-3.7.1.js" type="text/javascript"></script>
<script src="js/datatables.min.js" type="text/javascript"></script>

<script src="js/moment.min.js"></script>
<script>
    document.addEventListener("DOMContentLoaded", function () {
        // Datatables Responsive

        $("#datatables-reponsive").DataTable({

            columnDefs: [{
                target: 0,
                render: DataTable.render.datetime("DD MMM YYYY")
            },
    { className: 'dt-left', targets: '_all' }
    ],
            order: [[0, 'desc']],
            responsive: true,
            "lengthChange": false
        });


        $("#datatables-reponsive1").DataTable({

            columnDefs: [
    { className: 'dt-left', targets: '_all' }
    ],
            order: [[0, 'desc']],
            responsive: true,
            "lengthChange": false
        });


    });




    
	</script>

<body>
    <form id="form1" runat="server">
    <div class="wrapper">
        
        <div class="main">
            <uc2:Header ID="Header1" runat="server" />            
            <main class="content" style="padding-left:12px; padding-right:5px;">
			    <asp:PlaceHolder ID="PlaceHolder1" runat="server"></asp:PlaceHolder>            
			</main>
            <uc3:Footer ID="Footer1" runat="server" />            
        </div>
    </div>
    <script src="js/app.js"></script>
    </form>
</body>
</html>
