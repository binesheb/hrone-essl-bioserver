<%@ control language="VB" autoeventwireup="false" inherits="ess_Dashboard, App_Web_cnzlixsj" %>
<div class="container-fluid p-0">
    <h1 class="h4 mb-3 d-flex " style="align-items: center;">
        Dashboard&nbsp;
        <asp:DropDownList runat="server" ID="ddlMonths" Style="width: 85px; display: inline-block;"
            class="form-select" >
            <asp:ListItem Text="Jan" Value="01"></asp:ListItem>
            <asp:ListItem Text="Feb" Value="02"></asp:ListItem>
            <asp:ListItem Text="Mar" Value="03"></asp:ListItem>
            <asp:ListItem Text="Apr" Value="04"></asp:ListItem>
            <asp:ListItem Text="May" Value="05"></asp:ListItem>
            <asp:ListItem Text="Jun" Value="06"></asp:ListItem>
            <asp:ListItem Text="Jul" Value="07"></asp:ListItem>
            <asp:ListItem Text="Aug" Value="08"></asp:ListItem>
            <asp:ListItem Text="Sep" Value="09"></asp:ListItem>
            <asp:ListItem Text="Oct" Value="10"></asp:ListItem>
            <asp:ListItem Text="Nov" Value="11"></asp:ListItem>
            <asp:ListItem Text="Dec" Value="12"></asp:ListItem>
        </asp:DropDownList>&nbsp;
        <asp:DropDownList ID="ddlYears" runat="server"  Style="width: 90px;
            display: inline-block;" class="form-select">
        </asp:DropDownList>
        <asp:Button ID="BtnGo" CssClass="btn btn-primary" Style=" display: inline-block;padding:4px;" runat="server" Text="Go" />
         
    </h1>
    <div class="row">
        <div class="col-xl-12 col-xxl-12 d-flex">
            <div class="w-100">
                <div class="row">
                    <div class="col-sm-3">
                        <div class="card">
                            <div class="card-body">
                                <div class="row ">
                                    <div class="col mt-0">
                                        <h5 class="card-title border-primary">
                                            Present</h5>
                                    </div>
                                    <div class="col-auto">
                                        <div class="stat text-primary">
                                            <i class="align-middle" data-feather="check-square"></i>
                                        </div>
                                    </div>
                                </div>
                                <h1 class="mt-1 mb-3 text-primary">
                                    <asp:Literal ID="ltlPresent" runat="server"></asp:Literal> Days</h1>
                            </div>
                        </div>
                    </div>
                    <div class="col-sm-3">
                        <div class="card">
                            <div class="card-body">
                                <div class="row">
                                    <div class="col mt-0">
                                        <h5 class="card-title">
                                            Absent</h5>
                                    </div>
                                    <div class="col-auto">
                                        <div class="stat text-danger">
                                            <i class="align-middle" data-feather="alert-circle"></i>
                                        </div>
                                    </div>
                                </div>
                                <h1 class="mt-1 mb-3 text-danger">
                                     <asp:Literal ID="ltlAbsent" runat="server"></asp:Literal> Days</h1>
                            </div>
                        </div>
                    </div>
                    <div class="col-sm-3">
                        <div class="card">
                            <div class="card-body">
                                <div class="row">
                                    <div class="col mt-0">
                                        <h5 class="card-title">
                                            Leave/Comp Off</h5>
                                    </div>
                                    <div class="col-auto">
                                        <div class="stat text-info">
                                            <i class="align-middle" data-feather="instagram"></i>
                                        </div>
                                    </div>
                                </div>
                                <h1 class="mt-1 mb-3 text-info">
                                     <asp:Literal ID="ltlLeaveOrCompOff" runat="server"></asp:Literal> Days</h1>
                            </div>
                        </div>
                    </div>
                    <div class="col-sm-3">
                        <div class="card">
                            <div class="card-body">
                                <div class="row">
                                    <div class="col mt-0">
                                        <h5 class="card-title">
                                            Late/Early Going</h5>
                                    </div>
                                    <div class="col-auto">
                                        <div class="stat text-warning">
                                            <i class="align-middle " data-feather="alert-triangle"></i>
                                        </div>
                                    </div>
                                </div>
                                <h1 class="mt-1 mb-3 text-warning">
                                     <asp:Literal ID="ltlLateOrEarly" runat="server"></asp:Literal> Days</h1>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-xl-12 col-xxl-12 d-flex">
            <div class="card flex-fill table-responsive">
                <div class="card-header" style="padding-left: .75rem;">
                    <h5 class="card-title mb-0">
                        Attendance Register</h5>
                </div>
                <table class="table table-hover my-0" >
                    <thead>
                        <tr>
                            <th >
                                Date
                            </th>
                            <th  >
                                Shift
                            </th>
                            <th >
                                In/Out&nbsp;Time
                            </th>
                            <th >
                                Duration
                            </th>
                           
                            <th >
                                Status
                            </th>
                        </tr>
                    </thead>
                    <tbody>
                        <asp:Literal ID="ltlAttendanceSummarry" runat="server"></asp:Literal>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>
