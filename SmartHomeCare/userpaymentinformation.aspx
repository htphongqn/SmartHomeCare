<%@ Page Title="" Language="C#" MasterPageFile="~/siteuser.master" AutoEventWireup="true" CodeFile="userpaymentinformation.aspx.cs" Inherits="userpaymentinformation" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head1" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="right1" Runat="Server">
    <div class="title_new">
            <div class="floatleft">
                <div class="td">
                   Payment Information
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
        Payment Information
    </div>
    <div class="borderbottom">
    <div class="gridview">
        <asp:GridView ID="grdInfo" runat="server" Width="98%" 
            AutoGenerateColumns="False" ShowFooter="True" 
            onrowdatabound="grdInfo_RowDataBound">
            <Columns>
                 <%--<asp:TemplateField>
                    <ItemTemplate>
                        <asp:HyperLink ID="lbInfo" runat="server" NavigateUrl='<%# "userpayment_receipt.aspx?Id=" + Eval("BillingInfoId") %>' Text="Info"></asp:HyperLink> 
                    </ItemTemplate>
                    <ItemStyle HorizontalAlign="Center" />
                </asp:TemplateField>--%>
                <asp:BoundField DataField="PaymentDate" HeaderText="Date" >
                <HeaderStyle HorizontalAlign="Left" />
                </asp:BoundField>
                <asp:BoundField DataField="Description" HeaderText="Description" >
                <HeaderStyle HorizontalAlign="Left" />
                </asp:BoundField>
                
                    <asp:TemplateField HeaderText="Payment ID">
                        <ItemTemplate>
                            <asp:HyperLink ID="lbPayment" runat="server" NavigateUrl='<%# "userpayment_receipt.aspx?Id=" + Eval("BillingInfoId") %>' Text='<%# Bind("BillingInfoId") %>'></asp:HyperLink>
                            
                        </ItemTemplate>
                         <FooterTemplate >
                            Total :
                         </FooterTemplate>
                         <ItemStyle HorizontalAlign="Center" />
                         <FooterStyle Font-Bold="true" />
                    </asp:TemplateField>
                <asp:TemplateField HeaderText="Amount">
                    <ItemTemplate>
                        <asp:Label ID="lbAmount" runat="server" Text='<%# Bind("AmountPay") %>'></asp:Label> 
                       
                    </ItemTemplate>
                    <FooterTemplate >
                       <asp:Label ID="lbTotal" runat="server" Text=""></asp:Label>
                    </FooterTemplate>
                    <HeaderStyle HorizontalAlign="Left" />
                    
                </asp:TemplateField>
                
            </Columns>
        </asp:GridView>
       </div>
    </div>
    </div>
    <div class="borderbottom">
        <br /><br /><br /><br />
    </div>
    <div class="borderbottom textcenter">
        <br />
        <asp:Button ID="Button1" runat="server" Text="Back to Billing Account Summary" PostBackUrl="~/userbillingaccountsummar.aspx" />
        <br /><br />
    </div>
</asp:Content>

