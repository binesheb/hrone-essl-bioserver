<%@ control language="VB" autoeventwireup="false" inherits="vms_Header, App_Web_afgfe1m4" %>
<nav class="navbar navbar-expand navbar-light navbar-bg" style="padding-left:12px;">
			 <h1 class="h4 mb-3 d-flex">
        <asp:Literal ID="ltlHeader" runat="server"></asp:Literal>
    </h1>

				<div class="navbar-collapse collapse">
					<ul class="navbar-nav navbar-align">
						
						
						<li class="nav-item dropdown">
							<a class="nav-icon dropdown-toggle d-inline-block d-sm-none" href="#" data-bs-toggle="dropdown">
                <i class="align-middle" data-feather="settings"></i>
              </a>

							<a class="nav-link dropdown-toggle d-none d-sm-inline-block" href="#" data-bs-toggle="dropdown">
                <img src="img/avatars/avatar.jpg" class="avatar img-fluid rounded me-1" alt="Charles Hall" /> <span class="text-dark"><asp:Literal ID="ltlName" runat="server"></asp:Literal></span>
              </a>
							<div class="dropdown-menu dropdown-menu-end">
								<a class="dropdown-item" href="Main.aspx?Page=ChangePassword"><i class="align-middle me-1" data-feather="settings"></i> Change Password</a>
								<div class="dropdown-divider"></div>
								<a class="dropdown-item" href="Default.aspx"><i class="align-middle me-1" data-feather="log-out"></i> Log out</a>
							</div>
						</li>
					</ul>
				</div>
			</nav>
