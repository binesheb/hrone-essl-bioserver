<%@ control language="VB" autoeventwireup="false" inherits="ess_EditOutDuty, App_Web_cnzlixsj" %>
<div class="container-fluid p-0">
    <h1 class="h4 mb-3 d-flex">
        View Out Duty
    </h1>

    <div class="row p-2">
    <div class="card">
        <div class="row col-12">
            <div class="row col-12 col-lg-6 align-items-center p-3 ">
                <div class="card-body col-3   p-1  m-0">
                    <label class=" fw-bold">
                        Date</label>
                </div>
                <div class="card-body col-9 d-flex p-1   m-0 text-primary">
                    <asp:Literal ID="ltlFromDate" runat="server">From Date</asp:Literal>
                </div>
            </div>
             <div class="row align-items-center col-12 col-lg-6 p-3 ">
                <div class="card-body col-3  p-1 m-0">
                    <label class="fw-bold">
                        Duration</label>
                </div>
                <div class="card-body col-9  p-1 m-0 text-primary">
                       <asp:Literal ID="ltlDuration" runat="server">Duration</asp:Literal>
                </div>
            </div>
        </div>
       

        <div class="row col-12">
            <div class="row align-items-center col-12 col-lg-6 p-3 ">
                <div class="card-body col-3  p-1 m-0">
                    <label class=" fw-bold">
                        Applied Date</label>
                </div>
                <div class="card-body col-9  p-1 m-0 text-primary">
                                        <asp:Literal ID="ltlAppliedDate" runat="server">Applied Date</asp:Literal>

                </div>
            </div>
            <div class="row align-items-center col-12 col-lg-6 p-3 ">
                <div class="card-body col-3  p-1 m-0">
                    <label class="fw-bold">
                        Status</label>
                </div>
                <div class="card-body col-9  p-1 m-0 text-primary">
                       <asp:Literal ID="ltlStatus" runat="server">Status</asp:Literal>
                </div>
            </div>
        </div>
         
        <div class="row col-12">
            <div class="row align-items-center col-12 col-lg-6 p-3 ">
                <div class="card-body col-3  p-1 m-0">
                    <label class=" fw-bold">
                        Approved By</label>
                </div>
                <div class="card-body col-9  p-1 m-0 text-primary">
                                        <asp:Literal ID="ltlApprovedBy" runat="server">Approved By</asp:Literal>

                </div>
            </div>
            <div class="row align-items-center col-12 col-lg-6 p-3 ">
                <div class="card-body col-3  p-1 m-0">
                    <label class="fw-bold">
                        Approved Date</label>
                </div>
                <div class="card-body col-9  p-1 m-0 text-primary">
                       <asp:Literal ID="ltlApprovedDate" runat="server">Approved Date</asp:Literal>
                </div>
            </div>
        </div>


        <div class="row col-12">
            <div class="row align-items-center col-12 col-lg-12  p-3 ">
                <div class="card-body col-3 col-lg-1  p-1 m-0">
                    <label class=" fw-bold ">
                        Remarks</label>
                </div>
                <div class="card-body col-9 col-lg-10  p-1 m-0 text-primary">
                 <asp:TextBox ID="txt_Remarks" CssClass="form-control" TextMode="MultiLine" Style="width: 250px;"
                            Rows="3" runat="server"></asp:TextBox>
                     <asp:Literal ID="ltlRemarks" runat="server">Remarks</asp:Literal>
                </div>
            </div>
        </div>
        <div class="row col-12">
            <div class="col-12 col-lg-12">
                <asp:Label ID="lblSuccess" ForeColor="Blue" runat="server" Text=""></asp:Label>
                <asp:Label ID="lblError" ForeColor="Red" runat="server" Text=""></asp:Label>
                <asp:Button ID="btnApprove" runat="server" Text="Approve" CssClass="btn btn-primary" />
                <asp:Button ID="btnReject" runat="server" Text="Reject" CssClass="btn btn-primary" />
                <asp:Button ID="btnBack" runat="server" Text="Back" CssClass="btn btn-primary" />
            </div>
        </div>
    </div>
    </div>
    
</div>