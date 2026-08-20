<%@ control language="VB" autoeventwireup="false" inherits="ess_CompOffs, App_Web_cnzlixsj" %>
<div class="container-fluid p-0">
    <h1 class="h4 mb-3 " style="align-items: center;">
    
        Comp&nbsp;Offs&nbsp;
        <asp:DropDownList ID="ddlStatus" runat="server"    Style="width: 120px;display:inline-block;" class="form-select" >
        <asp:ListItem Text="--- All ---" Value="" Selected></asp:ListItem>
            <asp:ListItem Text="Approved" Value="Approved" ></asp:ListItem>
            <asp:ListItem Text="Pending" Value="Pending"></asp:ListItem>
            <asp:ListItem Text="Rejected" Value="Rejected"></asp:ListItem>
        </asp:DropDownList>

        <asp:DropDownList ID="ddlYears" runat="server"   Style="width: 90px;display:inline-block;" class="form-select" ></asp:DropDownList>
        <asp:Button ID="BtnGo" CssClass="btn btn-primary" style="display:inline-block;padding:4px;"  runat="server" Text="Go" />&nbsp;
       <asp:Button ID="btnApply" runat="server" Text="Apply" CssClass="btn btn-primary" style="display:inline-block;padding:4px;" />
    </h1>
    <div class="row">
       
        <div class="col-xl-12 col-xxl-5 d-flex">
              <div class="card flex-fill  table-responsive">
                        
                        <table class="table table-hover my-0">
                            <thead>
                                <tr>
                                    <th>
                                        Date
                                    </th>
                                   
                                    <th >
                                        Duration
                                    </th>
                                    <th>
                                        Status
                                    </th>
                                    <th style="width:50%;"></th>
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