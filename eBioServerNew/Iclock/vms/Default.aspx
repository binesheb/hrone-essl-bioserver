<%@ page language="VB" autoeventwireup="false" inherits="vms_Default, App_Web_afgfe1m4" enableEventValidation="false" %>


<!DOCTYPE html>
<html lang="en">

<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
	<link rel="preconnect" href="https://fonts.gstatic.com">
	<link rel="shortcut icon" href="img/icons/icon-48x48.png" />
	<title>Sign In | eBio VMS</title>

	<link href="css/app.css" rel="stylesheet">
	<link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;600&display=swap" rel="stylesheet">
</head>

<body>
	<main class="d-flex w-100">
		<div class="container d-flex flex-column">
			<div class="row vh-100">
				<div class="col-sm-10 col-md-8 col-lg-6 col-xl-5 mx-auto d-table h-100">
					<div class="d-table-cell align-middle">

						<div class="text-center mt-4">
                            <table style="width:100%;text-align:left;background-color:#ffffff;padding:0;"><tr >
                            <td style="padding-left:30px;"><img src="img/logo.gif" /></td>
                            <td style="width:100%;padding-top:20px;" ><h1 class="h2">eSSL Bio VMS</h1>
							<p class="lead">
								Sign in to your account
							</p></td>
                            </tr></table>
							
						</div>

						<div class="card">
							<div class="card-body">
								<div class="m-sm-3">
									<form id="form1" runat=server>
										<div class="mb-3">
											<label class="form-label">Login Name</label>
											<asp:TextBox ID="txtLoginName" class="form-control form-control-lg" runat="server" placeholder="Enter your Employee Code" ></asp:TextBox>
										</div>
										<div class="mb-3">
											<label class="form-label">Password</label>
											<asp:TextBox ID="txtPassword" runat="server"  class="form-control form-control-lg" TextMode=Password placeholder="Enter your password" ></asp:TextBox>
										</div>
										<div class="mb-3">
											<div class="form-check align-items-center">
                                                <input type="checkbox" class="form-check-input" id="chkRemember" value="remember-me" name="remember-me" checked runat="server" />
												<label class="form-check-label text-small" for="customControlInline">Remember me</label>
											</div>
										</div>

                                        <div id="divError" runat=server>
											<div class="align-items-align-content-lg-start">
                                              <label class="text-danger" >Invalid Login Details</label>
											</div>
										</div>

										<div class="d-grid gap-2 mt-3">
											<asp:Button ID="btnLogin"  class="btn btn-lg btn-primary" runat="server" Text="Sign in"></asp:Button>
										</div>
									</form>
								</div>
							</div>
						</div>
						
					</div>
				</div>
			</div>
		</div>
	</main>

	<script src="js/app.js"></script>

</body>

</html>
