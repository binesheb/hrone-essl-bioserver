<%@ control language="VB" autoeventwireup="false" inherits="vms_AddLog, App_Web_afgfe1m4" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>
<asp:Label ID="lblSuccess" ForeColor="Blue" runat="server" Text=""></asp:Label>
<asp:Label ID="lblError" ForeColor="Red" runat="server" Text=""></asp:Label>
<script type="text/javascript" src="js/jquery-3.7.1.js"></script>
<div class="container-fluid p-0">
    <div class="row p-2">
        <div class="card">
            <div class="row col-12">
                <div class="row col-12 col-lg-6 align-items-center p-1 ">
                    <div class="card-body m-0   pt-0 pb-1">
                        <label class=" fw-bold">
                            Photo</label>
                        <div class="d-flex">
                            <img runat="server" src='' id="imgCapture" class="pointer" style="width: 150px; height: 200px;
                                border: 1px; border-color: #D3D3D3; border-style: solid; cursor: pointer;" onclick="ImgUpload.click()" />
                            <asp:HiddenField ID="txtPhoto" runat="server" />
                            <input type="file" id="ImgUpload" onchange="ImgPre(this)" class="form-control " accept="image/*;capture=camera"
                                hidden="hidden" />
                        </div>
                    </div>
                </div>
            </div>
            <div class="row col-12">
                <div class="row col-12 col-lg-6 align-items-center p-1 ">
                    <div class="card-body m-0  pt-0 pb-1">
                        <label class=" fw-bold">
                            Status</label>
                        <div class="d-flex">
                            <asp:DropDownList runat="server" ID="ddlStatus" Style="width: 75px; display: inline-block;"
                                class="form-select">
                                <asp:ListItem Value="IN" Selected>IN</asp:ListItem>
                                <asp:ListItem Value="OUT">OUT</asp:ListItem>
                            </asp:DropDownList>
                        </div>
                    </div>
                </div>
            </div>
            <div class="row col-12">
                <div class="row align-items-center col-12 col-lg-6 p-1 ">
                    <div class="card-body m-0    pt-0 pb-1">
                        <label class=" fw-bold">
                            To Meet</label>
                        <div class="d-flex">
                            <asp:TextBox ID="txtToMeet" CssClass="form-control" runat="server" Style=""></asp:TextBox>
                            <asp:ScriptManager ID="ScriptManager" runat="server" EnablePageMethods="true">
                            </asp:ScriptManager>
                            <ajaxToolkit:AutoCompleteExtender ID="AutoCompleteExtender1" runat="server" ServiceMethod="SearchEmployees"
                                MinimumPrefixLength="1" CompletionInterval="100" EnableCaching="false" CompletionSetCount="10"
                                TargetControlID="txtToMeet" FirstRowSelected="false">
                            </ajaxToolkit:AutoCompleteExtender>
                        </div>
                    </div>
                </div>
                <div class="row align-items-center col-12 col-lg-6 p-1 ">
                    <div class="card-body m-0   pt-0 pb-1">
                        <label class="fw-bold">
                            Purpose</label>
                        <div class="d-flex">
                            <asp:TextBox ID="txtPurpose" CssClass="form-control" runat="server" Style=""></asp:TextBox>
                        </div>
                    </div>
                </div>
            </div>
            <div class="row col-12">
                <div class="row align-items-center col-12 col-lg-6 p-1 ">
                    <div class="card-body m-0   pt-0 pb-1">
                        <label class="fw-bold">
                            Visitor Card</label>
                        <div class="d-flex">
                            <asp:DropDownList runat="server" ID="ddlVisitorCard" Style=" display: inline-block;"
                                class="form-select">
                            </asp:DropDownList>
                        </div>
                    </div>
                </div>
                <div class="row align-items-center col-12 col-lg-6 p-1 ">
                    <div class="card-body m-0   pt-0 pb-1">
                        <label class="fw-bold">
                            Visitor Name</label>
                        <div class="d-flex">
                            <asp:TextBox ID="txtName" CssClass="form-control" runat="server" Style=""></asp:TextBox>
                        </div>
                    </div>
                </div>
            </div>
            <div class="row col-12">
                <div class="row align-items-center col-12 col-lg-6 p-1 ">
                    <div class="card-body m-0   pt-0 pb-1">
                        <label class=" fw-bold">
                            Company</label>
                        <div class="d-flex">
                            <asp:TextBox ID="txtCompany" CssClass="form-control" runat="server" Style=""></asp:TextBox>
                        </div>
                    </div>
                </div>
                <div class="row align-items-center col-12 col-lg-6 p-1 ">
                    <div class="card-body m-0   pt-0 pb-1">
                        <label class="fw-bold">
                            Designation</label>
                        <div class="d-flex">
                            <asp:TextBox ID="txtDesignation" CssClass="form-control" runat="server" Style=""></asp:TextBox>
                        </div>
                    </div>
                </div>
            </div>
            <div class="row col-12">
                <div class="row align-items-center col-12 col-lg-6 p-1 ">
                    <div class="card-body m-0   pt-0 pb-1">
                        <label class=" fw-bold">
                            Contact No.</label>
                        <div class="d-flex">
                            <asp:TextBox ID="txtContactNumber" CssClass="form-control" runat="server" Style=""></asp:TextBox>
                        </div>
                    </div>
                </div>
                <div class="row align-items-center col-12 col-lg-6 p-1 ">
                    <div class="card-body m-0   pt-0 pb-1">
                        <label class="fw-bold">
                            Email</label>
                        <div class="d-flex">
                            <asp:TextBox ID="txtEmail" CssClass="form-control" runat="server" Style=""></asp:TextBox>
                        </div>
                    </div>
                </div>
            </div>
            <div class="row col-12">
                <div class="row col-12 col-lg-6 align-items-center p-1 ">
                    <div class="card-body m-0   pt-0 pb-1">
                        <label class=" fw-bold">
                            In Date</label>
                        <div class="d-flex  align-items-center ">
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
                            <asp:DropDownList ID="ddlFromYears" runat="server" Style="width: 95px; display: inline-block;"
                                class="form-select">
                            </asp:DropDownList>
                        </div>
                    </div>
                </div>
                <div class="row col-12 col-lg-6 align-items-center p-1">
                    <div class="card-body  m-0   pt-0 pb-1">
                        <label class=" fw-bold">
                            In Time</label>
                        <div class="d-flex  align-items-center ">
                            <asp:DropDownList runat="server" ID="ddlInHour" Style="width: 75px; display: inline-block;"
                                class="form-select">
                            </asp:DropDownList>
                            :
                            <asp:DropDownList runat="server" ID="ddlInMinute" Style="width: 85px; display: inline-block;"
                                class="form-select">
                            </asp:DropDownList>
                            (HH:MM)
                        </div>
                    </div>
                </div>
            </div>
            <div class="row col-12">
                <div class="row col-12 col-lg-6 align-items-center p-1 ">
                    <div class="card-body m-0   pt-0 pb-1">
                        <label class="fw-bold">
                            Out Date</label>
                        <div class="d-flex align-items-center ">
                            <asp:DropDownList runat="server" ID="ddlToDays" Style="width: 75px; display: inline-block;"
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
                            <asp:DropDownList runat="server" ID="ddlToMonths" Style="width: 85px; display: inline-block;"
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
                            <asp:DropDownList ID="ddlToYears" runat="server" Style="width: 95px; display: inline-block;"
                                class="form-select">
                            </asp:DropDownList>
                        </div>
                    </div>
                </div>
                <div class="row col-12 col-lg-6 align-items-center p-1 ">
                    <div class="card-body m-0   pt-0 pb-1">
                        <label class="fw-bold">
                            Out Time</label>
                        <div class="d-flex align-items-center">
                            <asp:DropDownList runat="server" ID="ddlOutHour" Style="width: 75px; display: inline-block;"
                                class="form-select">
                            </asp:DropDownList>
                            :
                            <asp:DropDownList runat="server" ID="ddlOutMinute" Style="width: 85px; display: inline-block;"
                                class="form-select">
                            </asp:DropDownList>
                            (HH:MM)
                        </div>
                    </div>
                </div>
            </div>
            <div class="row col-12">
                <div class="row col-12 col-lg-6 align-items-center p-1 ">
                    <div class="card-body m-0   pt-0 pb-1">
                        <label class=" fw-bold">
                            Remarks</label>
                        <div class="d-flex align-items-center">
                            <asp:TextBox ID="txt_Remarks" CssClass="form-control" TextMode="MultiLine" Style=""
                                Rows="3" runat="server"></asp:TextBox>
                        </div>
                    </div>
                </div>
            </div>
            <div class="row col-12">
                <div class="col-12 col-lg-12">
                    <asp:Button ID="btnApply" runat="server" Text="Apply Now" OnClientClick="submitLog(this);"
                        CssClass="btn btn-primary" />
                    <asp:Button ID="btnBack" runat="server" Text="Back" CssClass="btn btn-primary" />
                    <asp:Button ID="btnAdd" runat="server" Text="Apply Now" Style="visibility: hidden;
                        width: 0px;" CssClass="btn btn-primary" />
                </div>
            </div>
        </div>
    </div>
    <script type="text/javascript">

        function submitLog(btn) {

            btn.disabled = true;
            document.getElementById("<%=btnAdd.ClientId %>").click();
        }


        function ImgPre(input) {
            if (input.files[0]) {


                var idxDot = input.files[0].name.lastIndexOf(".") + 1;
                var extFile = input.files[0].name.substr(idxDot, input.files[0].name.length).toLowerCase();




                if (extFile == "jpg" || extFile == "jpeg" || extFile == "png" || extFile == "gif" || extFile == "bmp" || extFile == "tiff") {

                    var uploadimg = new FileReader();

                    var image = new Image();


                    image.onload = function () {


                        var canvas = document.createElement("canvas");
                        var context = canvas.getContext("2d");


                        var newWidth = image.width;
                        var newHeight = image.height;



                        if (image.width > 150 || image.height > 200) {
                            var ratio = Math.min(150 / image.width, 200 / image.height);
                            newWidth = image.width * ratio;
                            newHeight = image.height * ratio;
                        }



                        canvas.width = newWidth;
                        canvas.height = newHeight;
                        context.drawImage(image, 0, 0, image.width, image.height, 0, 0, canvas.width, canvas.height);
                        document.getElementById("<%=imgCapture.ClientID %>").src = canvas.toDataURL();

                        document.getElementById("<%=txtPhoto.ClientID %>").value = document.getElementById("<%=imgCapture.ClientID %>").src;
                    }


                    uploadimg.onload = function (displayimg) {

                        image.src = displayimg.target.result;


                    }
                    uploadimg.readAsDataURL(input.files[0]);

                }

                else {

                    document.getElementById("<%=txtPhoto.ClientID %>").value = 'data:image/gif;base64,R0lGODlhAQABAAAAACH5BAEKAAEALAAAAAABAAEAAAICTAEAOw==';

                    document.getElementById("<%=imgCapture.ClientID %>").src = 'data:image/gif;base64,R0lGODlhAQABAAAAACH5BAEKAAEALAAAAAABAAEAAAICTAEAOw==';


                }

            }
        }
    </script>
