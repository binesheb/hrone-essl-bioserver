<%@ control language="VB" autoeventwireup="false" inherits="ess_Header, App_Web_cnzlixsj" %>
<nav class="navbar navbar-expand navbar-light navbar-bg" style="padding-left:12px;">
				<a class="sidebar-toggle js-sidebar-toggle">
          <i class="hamburger align-self-center"></i>
        </a>

				<div class="navbar-collapse collapse">
					<ul class="navbar-nav navbar-align">
						<li class="nav-item dropdown">
							<a class="nav-icon dropdown-toggle" href="#" id="alertsDropdown" data-bs-toggle="dropdown">
								<div class="position-relative">
									<i class="align-middle" data-feather="bell"></i>
									<span class="indicator"><asp:Literal ID="ltlTotal1" runat="server"></asp:Literal> </span>
								</div>
							</a>
							<div class="dropdown-menu dropdown-menu-lg dropdown-menu-end py-0" aria-labelledby="alertsDropdown">
								<div class="dropdown-menu-header">
									<asp:Literal ID="ltlTotal" runat="server"></asp:Literal> Notifications
								</div>
								<div class="list-group">
									<a href="Main.aspx?Page=TeamLeaves&Status=Pending" class="list-group-item">
										<div class="row g-0 align-items-center">
											<div class="col-2">
												<i class="text-primary" data-feather="instagram"></i>
											</div>
											<div class="col-10">
												<div class="text-dark">Pending Leave Approval</div>
												<div class="text-muted small mt-1"><asp:Literal ID="ltlLeaves" runat="server"></asp:Literal> pending leave approvals.</div>
												
											</div>
										</div>
									</a>
									<a href="Main.aspx?Page=TeamOutDuties&Status=Pending" class="list-group-item">
										<div class="row g-0 align-items-center">
											<div class="col-2">
												<i class="text-primary" data-feather="list"></i>
											</div>
											<div class="col-10">
												<div class="text-dark">Pending Out Duty Approval</div>
												<div class="text-muted small mt-1"><asp:Literal ID="ltlOutDuties" runat="server"></asp:Literal> pending out duty approvals.</div>
												
											</div>
										</div>
									</a>
									<a href="Main.aspx?Page=TeamCompOffs&Status=Pending" class="list-group-item">
										<div class="row g-0 align-items-center">
											<div class="col-2">
												<i class="text-primary" data-feather="clipboard"></i>
											</div>
											<div class="col-10">
												<div class="text-dark">Pending Comp Off Approval</div>
												<div class="text-muted small mt-1"><asp:Literal ID="ltlCompOffs" runat="server"></asp:Literal> pending comp off approvals.</div>
											</div>
										</div>
									</a>
									
								</div>
							
							</div>
						</li>
						
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
