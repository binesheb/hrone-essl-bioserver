<%@ control language="VB" autoeventwireup="false" inherits="ess_TeamOutDuties, App_Web_cnzlixsj" %>


<div class="container-fluid p-0" >
    <h1 class="h4 mb-3 " style="align-items: center;">
    
        Out Duties&nbsp;
        <asp:DropDownList ID="ddlStatus" runat="server"     Style="width: 120px;display:inline-block;" class="form-select" >
        
            <asp:ListItem Text="--- All ---" Value="" Selected></asp:ListItem>
            <asp:ListItem Text="Approved" Value="Approved" ></asp:ListItem>
            <asp:ListItem Text="Pending" Value="Pending"></asp:ListItem>
            <asp:ListItem Text="Rejected" Value="Rejected"></asp:ListItem>
        </asp:DropDownList>
        <asp:DropDownList ID="ddlYears" runat="server"    Style="width: 90px;display:inline-block;padding:4px;" class="form-select" ></asp:DropDownList>
        <asp:Button ID="BtnGo" CssClass="btn btn-primary" runat="server" style="display:inline-block;padding:4px;" Text="Go" />&nbsp;
    </h1> 
    <div class="row">
       
        <div class="col-12">
              <div class="card table-responsive">
                        
                        <table  id="datatables-reponsive" class="table table-hover my-0"  style="width:100%;">
                            <thead>
                                <tr>
                                    <th style="text-align: left;">
                                    Out&nbsp;Duty&nbsp;Date                                    
                                    
                                    </th>

                                    <th>
                                        Employee&nbsp;Code
                                    </th>
                                    <th >
                                        Name
                                    </th>

                                    <th>
                                    Duration                                   
                                    
                                    </th>

                                    
                                    <th >
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
