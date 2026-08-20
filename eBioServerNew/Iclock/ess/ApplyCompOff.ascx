<%@ control language="VB" autoeventwireup="false" inherits="ess_ApplyCompOff, App_Web_cnzlixsj" %>
<div class="container-fluid p-0">
    <h1 class="h4 mb-3 d-flex">
        Apply Comp Off
    </h1>
    <div class="row p-2">
        <div class="card">
            <div class="row col-12">
                <div class="row col-12 col-lg-6 align-items-center p-3 ">
                    <div class="card-body col-3   p-1  m-0">
                        <label class=" fw-bold">
                            &nbsp;Date</label>
                    </div>
                    <div class="card-body col-9 d-flex p-1   m-0">
                        <asp:DropDownList runat="server" ID="ddlFromDays" Style="width: 75px; display: inline-block;"
                            class="form-select">
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
                        <asp:DropDownList runat="server" ID="ddlFromMonths" Style="width: 85px; display: inline-block;"
                            class="form-select">
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
                        </asp:DropDownList>
                        <asp:DropDownList ID="ddlFromYears" runat="server" Style="width: 90px; display: inline-block;"
                            class="form-select">
                        </asp:DropDownList>
                    </div>
                </div>
                <div class="row align-items-center col-12 col-lg-6 p-3 ">
                    <div class="card-body col-3  p-1 m-0">
                        <label class="fw-bold">
                            Duration</label>
                    </div>
                    <div class="card-body col-9  p-1 m-0">
                        <asp:DropDownList runat="server" ID="drpDuration" Style="width: 250px;" CssClass="form-select">
                            <asp:ListItem Text="Full Day" Value="Full Day"></asp:ListItem>
                            <asp:ListItem Text="Half Day" Value="Half Day"></asp:ListItem>
                        </asp:DropDownList>
                    </div>
                </div>
            </div>
            <div class="row col-12">
                <div class="row align-items-center col-12 col-lg-12  p-3 ">
                    <div class="card-body col-3 col-lg-1  p-1 m-0">
                        <label class=" fw-bold">
                            Remarks</label>
                    </div>
                    <div class="card-body col-9 col-lg-10  p-1 m-0">
                        <asp:TextBox ID="txt_Remarks" CssClass="form-control" TextMode="MultiLine" Style="width: 250px;"
                            Rows="3" runat="server"></asp:TextBox>
                    </div>
                </div>
            </div>
            <div class="row col-12">
                <div class="col-12 col-lg-12">
                    <asp:Label ID="lblSuccess" ForeColor="Blue" runat="server" Text=""></asp:Label>
                    <asp:Label ID="lblError" ForeColor="Red" runat="server" Text=""></asp:Label>
                    <asp:Button ID="btnApply" runat="server" Text="Apply Now" CssClass="btn btn-primary" />
                   <asp:Button ID="btnBack" runat="server" Text="Back" CssClass="btn btn-primary" />
                </div>
            </div>
        </div>
    </div>
</div> 