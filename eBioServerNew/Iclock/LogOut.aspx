<%@ page language="VB" autoeventwireup="false" inherits="LogOut, App_Web_0iwe3y3l" enableEventValidation="false" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" >

<html  >
<head id="Head1" runat="server">
    <title>Untitled Page</title>
    <script type="text/javascript">
    function DisableHistory() {
    window.history.forward(1);
    }
    function RedirectToHome() {
    setTimeout("window.top.location.href = 'Default.aspx'",0);
    }
    </script>
</head>
<body onload="RedirectToHome();">
    <form id="form1" runat="server">
    <div>
    <span class="kwrd"></span> 
    </div>
    </form>
</body>
</html>
