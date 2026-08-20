<%@ control language="VB" autoeventwireup="false" inherits="ess_Menu, App_Web_cnzlixsj" %>
<nav id="sidebar" class="sidebar js-sidebar">
    <div class="sidebar-content js-simplebar">
				<a class="sidebar-brand" href="Main.aspx?Page=Dashboard">
          <span class="align-middle">eSSL Bio Server</span>
        </a>

				<ul class="sidebar-nav">
					<li class="sidebar-header">
						My Attendance
					</li>

					<li class="sidebar-item <%=iif(Request.QueryString("Page").ToLower="dashboard","active","")%>">
						<a class="sidebar-link" href="Main.aspx?Page=Dashboard">
              <i class="align-middle" data-feather="sliders"></i> <span class="align-middle">Dashboard</span>
            </a>
					</li>
                    
					<li class="sidebar-item <%=iif(Request.QueryString("Page").ToLower="punches","active","")%>" >
						<a class="sidebar-link" href="Main.aspx?Page=Punches">
              <i class="align-middle" data-feather="calendar"></i> <span class="align-middle">Punches</span>
            </a>
					</li>
                    

					<li class="sidebar-item <%=iif(Request.QueryString("Page").ToLower="holidays","active","")%>" >
						<a class="sidebar-link" href="Main.aspx?Page=Holidays">
              <i class="align-middle" data-feather="flag"></i> <span class="align-middle">Holidays</span>
            </a>
					</li>
                    

<li class="sidebar-item <%=iif(Request.QueryString("Page").ToLower="leaves","active","")%><%=iif(Request.QueryString("Page").ToLower="applyleave","active","")%><%=iif(Request.QueryString("Page").ToLower="viewleave","active","")%>" >
						<a class="sidebar-link" href="Main.aspx?Page=Leaves">
              <i class="align-middle" data-feather="instagram"></i> <span class="align-middle">Leaves</span>
            </a>
					</li>



<li class="sidebar-item <%=iif(Request.QueryString("Page").ToLower="outduties","active","")%><%=iif(Request.QueryString("Page").ToLower="applyoutduty","active","")%><%=iif(Request.QueryString("Page").ToLower="viewoutduty","active","")%>" >
						<a class="sidebar-link" href="Main.aspx?Page=OutDuties">
              <i class="align-middle" data-feather="list"></i> <span class="align-middle">Out Duties</span>
            </a>
					</li>


                    

<li class="sidebar-item <%=iif(Request.QueryString("Page").ToLower="compoffs","active","")%><%=iif(Request.QueryString("Page").ToLower="applycompoff","active","")%><%=iif(Request.QueryString("Page").ToLower="viewcompoff","active","")%>" >
						<a class="sidebar-link" href="Main.aspx?Page=CompOffs">
              <i class="align-middle" data-feather="clipboard"></i> <span class="align-middle">Comp Offs</span>
            </a>
					</li>


        <li class="sidebar-item <%=iif(Request.QueryString("Page").ToLower="leavesummary","active","")%>" >
						<a class="sidebar-link" href="Main.aspx?Page=LeaveSummary">
              <i class="align-middle" data-feather="instagram"></i> <span class="align-middle">Leave Summary</span>
            </a>
					</li>

             <li class="sidebar-item <%=iif(Request.QueryString("Page").ToLower="payslips","active","")%><%=iif(Request.QueryString("Page").ToLower="payslipsdetails","active","")%>" >
						<a class="sidebar-link" href="Main.aspx?Page=payslips">
              <i class="align-middle" data-feather="calendar"></i> <span class="align-middle">Payslips</span>
            </a>
					</li>
            


					<li class="sidebar-header">
						My Team Attendance
					</li>

					<li class="sidebar-item <%=iif(Request.QueryString("Page").ToLower="teamattendance","active","")%>">
						<a class="sidebar-link" href="Main.aspx?Page=TeamAttendance">
              <i class="align-middle" data-feather="sliders"></i> <span class="align-middle">Attendance</span>
            </a>
					</li>
                    
					
                                        

<li class="sidebar-item <%=iif(Request.QueryString("Page").ToLower="teamleaves","active","")%><%=iif(Request.QueryString("Page").ToLower="editleave","active","")%>" >
						<a class="sidebar-link" href="Main.aspx?Page=TeamLeaves">
              <i class="align-middle" data-feather="instagram"></i> <span class="align-middle">Leaves</span>
            </a>
					</li>



<li class="sidebar-item <%=iif(Request.QueryString("Page").ToLower="teamoutduties","active","")%><%=iif(Request.QueryString("Page").ToLower="editoutduty","active","")%>" >
						<a class="sidebar-link" href="Main.aspx?Page=TeamOutDuties">
              <i class="align-middle" data-feather="list"></i> <span class="align-middle">Out Duties</span>
            </a>
					</li>


                    

<li class="sidebar-item <%=iif(Request.QueryString("Page").ToLower="teamcompoffs","active","")%><%=iif(Request.QueryString("Page").ToLower="editcompoff","active","")%>" >
						<a class="sidebar-link" href="Main.aspx?Page=TeamCompOffs">
              <i class="align-middle" data-feather="clipboard"></i> <span class="align-middle">Comp Offs</span>
            </a>
					</li>

 <li class="sidebar-item <%=iif(Request.QueryString("Page").ToLower="teamleavesummary","active","")%>" >
						<a class="sidebar-link" href="Main.aspx?Page=TeamLeaveSummary">
              <i class="align-middle" data-feather="instagram"></i> <span class="align-middle">Leave Summary</span>
            </a>
					</li>
	
</nav>
       