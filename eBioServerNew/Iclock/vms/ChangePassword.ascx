<%@ control language="VB" autoeventwireup="false" inherits="vms_ChangePassword, App_Web_afgfe1m4" %>
<div class="container-fluid p-0">
    <div class="mb-3">
        <h1 class="h3 d-inline align-middle">
            Change Password</h1>
    </div>

    <div class="row">
        <div class="col-12 col-lg-6">
            <div class="card">
                <div class="card-body">
                    
                    <div class="mb-3">
                        <label class="form-label">
                            Old Password</label>
                            <asp:TextBox ID="txtOldPassword" runat="server" class="form-control" placeholder="Old Password" TextMode=Password></asp:TextBox>                        
                    </div>

                    <div class="mb-3">
                        <label class="form-label">
                            New Password</label>
                            <asp:TextBox ID="txtNewPassword" runat="server" class="form-control" placeholder="New Password" TextMode=Password></asp:TextBox>                        
                    </div>
                    <div class="mb-3">
                        <label class="form-label">
                            Confirm Password</label>
                            <asp:TextBox ID="txtConfirmPassword" runat="server" class="form-control" placeholder="Confirm Password" TextMode=Password></asp:TextBox>                        
                    </div>

                     <div class="mb-3">
                     <asp:Button ID="btnOK"  class="btn btn-lg btn-primary" runat="server" Text="Change Password"></asp:Button>
                     <asp:Button ID="btnHome"  class="btn btn-lg btn-primary" runat="server" Text="Home"></asp:Button>

                      <label class="text-danger">
                          <asp:Literal ID="ltlError" runat="server"></asp:Literal></label>

                    <label class="text-success">
                          <asp:Literal ID="ltlSuccess" runat="server"></asp:Literal></label>

                     </div>


                </div>
            </div>
        </div>
    </div>
    
</div>
