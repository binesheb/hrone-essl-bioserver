<%@ page language="VB" autoeventwireup="false" inherits="vms_test, App_Web_afgfe1m4" enableEventValidation="false" %>


<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8" />
    <title></title>
    <style type="text/css">
        body { font-family: Arial; font-size: 10pt; }
        table { border: 1px solid #ccc; border-collapse: collapse; }
        table th { background-color: #F7F7F7; color: #333; font-weight: bold; }
        table th, table td { padding: 5px; border: 1px solid #ccc; }
        table, table table td { border: 0px solid #ccc; }
    </style>
</head>
<script type="text/javascript" src="js/jquery-3.7.1.js"></script>
 <link rel="stylesheet" href="css/bootstrap.min.css" media="screen" />
 <script type="text/javascript" src="js/bootstrap.min.js"></script>
<body>


<div id="MyPopup" class="modal fade" role="dialog">
    <div class="modal-dialog"  style="width:360px;">
        <!-- Modal content-->
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">
                    &times;
                </button>
                
            </div>
            <div class="modal-body">
                <div id="webcam"></div>
            </div>
            <div class="modal-footer">
                <input type="button" id="btnFrontBack" value="Front" />
                <input type="button" id="btnCapture" value="Capture" />
             </div>
        </div>
    </div>
</div>


    <table border="0" cellpadding="0" cellspacing="0">
        <tr>
            
            <th align="center"><u>Photo</u></th>
        </tr>
        <tr>
            
            <td style="width: 320px; height: 240px;"><img id="imgCapture" /></td>
        </tr>
        <tr>
            <td align="center" colspan="2">
                <input type="button" id="btnShowPopup" value="Capture Photo" class="btn btn-info " />
            </td>
        </tr>
    </table>
    <script type="text/javascript" src="js/webcam.js"></script>
    <script type="text/javascript">
        $(function () {

            ApplyPlugin();
            $("#btnCapture").click(function () {
                Webcam.snap(function (data_uri) {
                    $("#imgCapture")[0].src = data_uri;
                    $("#MyPopup").modal("hide");
                });
            });

            $("#btnShowPopup").click(function () {

                $("#MyPopup").modal("show");
            });

            $("#btnClosePopup").click(function () {
                $("#MyPopup").modal("hide");
            });



            $("#btnFrontBack").click(function () {
                $('#btnFrontBack').val($('#btnFrontBack').val() == 'Back' ? 'Front' : 'Back');
                Webcam.reset();
                ApplyPlugin();
            });



        });
        function ApplyPlugin() {
            var mode = $('#btnFrontBack').val() == 'Back' ? 'user' : 'environment';
            Webcam.set({
                width: 320,
                height: 240,
                image_format: 'jpeg',
                jpeg_quality: 90,
                constraints: { facingMode: mode }
            });
            Webcam.attach('#webcam');
        };
    </script>
</body>
</html>