<%@ Page Title="" Language="C#" MasterPageFile="~/siteuser.master" AutoEventWireup="true" CodeFile="userbillingaccountsummar.aspx.cs" Inherits="userbillingaccountsummar" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head1" Runat="Server">
<style type="text/css">
    .padding
    {
        padding:7px;
    }
</style>
    <script src="scripts/Print.js" type="text/javascript"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="right1" Runat="Server">
    <div class="row">
        <div class="col-lg-12">
            <h1 class="page-header">Reports</h1>
        </div>
        <!-- /.col-lg-12 -->
    </div>
    <div class="row">
        <div class="col-lg-12">
            <div class="panel panel-default">
                <div class="panel-heading">
                    Billing Account Summary
                    <div class="floatright">
                        <asp:ImageButton ID="ImageButton2" runat="server" Height="25px" ImageUrl="~/resources/images/printer.png" Width="25px" OnClientClick="return processPrint('print');" CssClass="floatleft"/>&nbsp;&nbsp;
                    </div>
                </div>
                <div class="panel-body">
                    <div class="row">
                        <div class="col-lg-6" style="width:100%;">
                            <div class="borderbottom clear">
                                Click Account Details or See More Payments to see more
                                information about a particular account. If you have an outstanding balance on an account,
                                click Pay Bill to pay online using a credit card.<br /><br />
                            </div>
                            <div id="print">
                            <div class=" textright padding">
                            <div class="gridview">
                                <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" 
                                    EmptyDataText="empty data" Width="100%">
                                    <Columns>
                                        <asp:BoundField DataField="AccountNumber" HeaderText="Account" ItemStyle-HorizontalAlign="Center"/>
                                        <asp:BoundField DataField="AccountType" HeaderText="Account Type" ItemStyle-HorizontalAlign="Center"/>
                                        <asp:BoundField DataField="LastPayment" HeaderText="Last Payment" ItemStyle-HorizontalAlign="Center"/>
                                        <asp:BoundField DataField="Balance"  HeaderText="Outstanding Balance" >
                                            <HeaderStyle Width="180px" HorizontalAlign="Center"/>
                                        </asp:BoundField>
                                    </Columns>
                                </asp:GridView>
                                </div>
                            </div>
                             <div class="borderbottom textright">
                                <asp:Button ID="btnaccountdetail" runat="server" Text="Account Details" CssClass="btn btn-default"
                                     PostBackUrl="~/useraccountdetails.aspx" Width="185px" style="margin-top:10px;"/>
                                <asp:Button ID="btnseemorepayments" runat="server" Text="See More Payments" CssClass="btn btn-default"
                                     onclick="btnseemorepayments_Click" Width="185px" style="margin-top:10px;"/>
                                <asp:Button ID="btnpaybill" runat="server" Text="Pay Bill" CssClass="btn btn-default"
                                     PostBackUrl="~/userpaybill.aspx" Width="185px" style="margin-top:10px;"/>
                                <br /><br /><br />
                            </div>
                            </div>
                            <div class="borderbottom textcenter">
                            <br />
                                <asp:Button ID="Button1" runat="server" Text="Back to Home" PostBackUrl="~/userhome.aspx" CssClass="btn btn-default"/>
                                <br /><br />
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>

