<%@ control language="VB" autoeventwireup="false" inherits="vms_Dashboard, App_Web_afgfe1m4" %>
<div class="container-fluid p-0">
    <h1 class="h4 mb-3 " style="align-items: center;">
        
         <asp:DropDownList runat="server" ID="ddlDays" Style="width: 75px;display:inline-block;" class="form-select">
         
                    <asp:ListItem Value="01">1</asp:ListItem>
                    <asp:ListItem Value="02">2</asp:ListItem>
                    <asp:ListItem Value="03">3</asp:ListItem>
                    <asp:ListItem Value="04">4</asp:ListItem>
                    <asp:ListItem Value="05">5</asp:ListItem>
                    <asp:ListItem Value="06">6</asp:ListItem>
                    <asp:ListItem Value="07">7</asp:ListItem>
                    <asp:ListItem Value="08">8</asp:ListItem>
                    <asp:ListItem Value="09">9</asp:ListItem>
                    <asp:ListItem Value="10">10</asp:ListItem>
                    <asp:ListItem Value="11">11</asp:ListItem>
                    <asp:ListItem Value="12">12</asp:ListItem>
                    <asp:ListItem Value="13">13</asp:ListItem>
                    <asp:ListItem Value="14">14</asp:ListItem>
                    <asp:ListItem Value="15">15</asp:ListItem>
                    <asp:ListItem Value="16">16</asp:ListItem>
                    <asp:ListItem Value="17">17</asp:ListItem>
                    <asp:ListItem Value="18">18</asp:ListItem>
                    <asp:ListItem Value="19">19</asp:ListItem>
                    <asp:ListItem Value="20">20</asp:ListItem>
                    <asp:ListItem Value="21">21</asp:ListItem>
                    <asp:ListItem Value="22">22</asp:ListItem>                    
                    <asp:ListItem Value="23">23</asp:ListItem>
                    <asp:ListItem Value="24">24</asp:ListItem>
                    <asp:ListItem Value="25">25</asp:ListItem>
                    <asp:ListItem Value="26">26</asp:ListItem>
                    <asp:ListItem Value="27">27</asp:ListItem>
                    <asp:ListItem Value="28">28</asp:ListItem>
                    <asp:ListItem Value="29">29</asp:ListItem>
                    <asp:ListItem Value="30">30</asp:ListItem>
                    <asp:ListItem Value="31">31</asp:ListItem>
         </asp:DropDownList>
         
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
        </asp:DropDownList>&nbsp;
        <asp:Button ID="BtnGo" CssClass="btn btn-primary" Style=" display: inline-block;padding:4px;" runat="server" Text="Go" />
          &nbsp;<asp:Button ID="btnAdd" runat="server" Text="Add Log" CssClass="btn btn-primary" style="display:inline-block;padding:4px;" />

          <asp:Label ID="lblError" CssClass="h5 mb-3 text-danger" runat="server" Text=""></asp:Label>
    </h1>
    
    

    <script>

        function DivClicked(btn) {
            var btnHidden = $(btn);
            if (btnHidden != null) {
                btnHidden.click();
            }
        }

</script>


    <div class="row">
        <div class="col-xl-12 col-xxl-12 d-flex">
            <div class="w-100">
                <div class="row">

                    <asp:Button runat="server" id="btnINHidden" style="display:none" />
                    <div class="col-sm-3" style="cursor:pointer" onclick="document.getElementById('<%= btnINHidden.ClientID  %>').click(); return true;" >
                        <div class="card">
                            <div class="card-body">
                                <div class="row ">
                                    <div class="col mt-0" >
                                        <h5 class="card-title text-primary">
                                            IN</h5>
                                    </div>
                                    <div class="col-auto">
                                        <div class="stat text-primary">
                                            <i class="align-middle" data-feather="check-square"></i>
                                        </div>
                                    </div>
                                </div>
                                <h1 class="mt-1 mb-3 text-primary">
                                    <asp:Literal ID="ltlIN" runat="server"></asp:Literal> Visitor</h1>
                            </div>
                        </div>
                    </div>
                    <asp:Button runat="server" id="btnOUTHidden" style="display:none" />

                    <div class="col-sm-3"   style="cursor:pointer" onclick="document.getElementById('<%= btnOUTHidden.ClientID  %>').click(); return true;" >
                        <div class="card">
                            <div class="card-body">
                                <div class="row">
                                    <div class="col mt-0">
                                        <h5 class="card-title text-secondary">
                                            OUT</h5>
                                    </div>
                                    <div class="col-auto">
                                        <div class="stat text-secondary" >
                                            <i class="align-middle" data-feather="alert-circle"></i>
                                        </div>
                                    </div>
                                </div>
                                <h1 class="mt-1 mb-3 text-secondary">
                                     <asp:Literal ID="ltlOUT" runat="server"></asp:Literal> Visitor</h1>
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
                        <asp:Literal ID="ltlListTitle" runat="server"></asp:Literal>   Visitors</h5>
                </div>
                <table class="table table-hover my-0" >
                    <thead>
                        <tr>
                            <th >
                                Status
                            </th>
                            <th  >
                                Name
                            </th>
                            <th >
                                Contact&nbsp;No
                            </th>
                            <th >
                                To&nbsp;Meet
                            </th>
                           
                            <th >
                                
                            </th>
                        </tr>
                    </thead>
                    <tbody>
                        <asp:Literal ID="ltlVisitorLogSummarry" runat="server"></asp:Literal>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>
