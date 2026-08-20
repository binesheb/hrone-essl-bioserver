<%@ control language="VB" autoeventwireup="false" inherits="ess_payslips, App_Web_cnzlixsj" %>
<div class="container-fluid p-0">
    <h1 class="h4 mb-3 d-flex" style="align-items: center;">
    
        Payslips&nbsp;
        <asp:DropDownList ID="ddlYears" runat="server"   Style="width: 90px;display:inline-block;" class="form-select" ></asp:DropDownList>
         <asp:Button ID="BtnGo" CssClass="btn btn-primary"  style="display:inline-block;padding:4px;"  runat="server" Text="Go" />

    </h1>
    <div class="row">
       
        <div class="col-xl-12 col-xxl-12 d-flex">
              <div class="card flex-fill">
                        
                        <table class="table table-hover my-0  table-responsive">
                            <thead>
                                <tr>
                                    <th style="width:30%;">
                                        Pay&nbsp;Date
                                    </th>
                                    <th >
                                        
                                    </th>
                                </tr>
                            </thead>
                            <tbody>

                                <asp:Literal ID="ltlRows" runat="server"></asp:Literal>

                                
                            </tbody>
                        </table>
               </div>
        </div>
    </div>
</div>