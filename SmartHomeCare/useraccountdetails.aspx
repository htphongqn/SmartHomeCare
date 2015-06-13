<%@ Page Title="" Language="C#" MasterPageFile="~/siteuser.master" AutoEventWireup="true" CodeFile="useraccountdetails.aspx.cs" Inherits="useraccountdetails" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head1" Runat="Server">
    <script src="scripts/Print.js" type="text/javascript"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="right1" Runat="Server">
    <div class="title_new">
            <div class="floatleft">
                <div class="td">
                   Account Details
                </div>
             </div>
            <div class="floatright">
                <asp:ImageButton ID="ImageButton2" runat="server" Height="25px" ImageUrl="~/resources/images/printer.png" Width="25px" OnClientClick="return processPrint('print');" CssClass="floatleft"/>&nbsp;&nbsp;
                <a id="userhelp" href="#"><img src="resources/images/h.png" /></a>
            </div>
            <div class="clear"></div>
     </div><!-- border bottom -->
    <div id="print">
    <div class="borderbottom clear">
        Account Details information
    </div>
    <div class="borderbottom">
    <div class="gridview">
        <asp:GridView ID="grdDetailAccount" runat="server" AutoGenerateColumns="False" 
            Height="34px" Width="98%" EmptyDataText="empty data">
            <Columns>
                <asp:BoundField DataField="PaymentDate" HeaderText="Date" >
                <HeaderStyle HorizontalAlign="Left" />
                <ItemStyle HorizontalAlign="Left" />
                </asp:BoundField>
                <asp:BoundField DataField="Description" HeaderText="Description" >
                <HeaderStyle HorizontalAlign="Left" />
                <ItemStyle HorizontalAlign="Left" />
                </asp:BoundField>
                <asp:BoundField DataField="Charge" HeaderText="Charge" >
                <ItemStyle HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:TemplateField HeaderText="Pay">
                    <ItemTemplate>
                        <asp:Label ID="lbPay" runat="server" Text='<%# Bind("Pay") %>'></asp:Label>
                    </ItemTemplate>
                   
                    <ItemStyle HorizontalAlign="Center" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Balance">
                    <ItemTemplate>
                        <asp:Label ID="lbBalance" runat="server" Text='<%# Bind("Balance") %>'></asp:Label>
                    </ItemTemplate>
                  
                    <ItemStyle HorizontalAlign="Center" />
                    <FooterStyle HorizontalAlign="Center" />
                </asp:TemplateField>
            </Columns>
        </asp:GridView>
        </div>
       <div class="textright">Amount Due | 
           <asp:Label ID="lbAmountDue" runat="server" Text="$10"></asp:Label></div>
    </div>
    <div class="borderbottom">
        <div class="textright">
            <br />
            <asp:Button ID="btnseepayments" runat="server" Text="See Payments" PostBackUrl="~/userpaymentinformation.aspx" />
            <asp:Button ID="btnpaybill" runat="server" Text="Pay Bill" 
                PostBackUrl="~/userpaybill.aspx"  />
        </div>
        <div class="textleft">
            <span class="bold">Note:</span> There may be pending balances on your account that are not 
             included on your current statement
        </div>
    </div>
    </div>
    <div class="borderbottom textcenter">
        <br />
        <asp:Button ID="Button1" runat="server" Text="Back to Home" PostBackUrl="~/userhome.aspx" />
        <br /><br />
    </div>
</asp:Content>

