<%@ Page Title="" Language="C#" MasterPageFile="~/siteuser.master" AutoEventWireup="true" CodeFile="usertrackothers.aspx.cs" Inherits="usertrackothers" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head1" Runat="Server">
    <%--<link href="styles/control.css" rel="stylesheet" type="text/css" />--%>
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
                    Track others
                </div>
                <div class="panel-body">
                    <div class="row">
                        <div class="col-lg-6">
                            <div class="clear">
                                Select other user you want to view/track.<br /><br />
                            </div>  
                            <div class="clear">
                                <asp:ListBox ID="lstTracOther" runat="server"
                                    ondblclick="lstTracOther_DoubleClick()" Rows="8" CssClass="form-control">           
                                </asp:ListBox>
                            </div>    
                             <div class="clear"  style="margin-bottom:10px;margin-top:10px">
                                <asp:Label ID="lbMaessages" runat="server" Text="Please select other user" ForeColor="Red" Visible="false"></asp:Label><br />
                                <asp:Button ID="btnglobalsettings" runat="server" Text="Select"  CssClass="btn btn-default"
                                     onclick="btnglobalsettings_dbick" />
                                <asp:Button ID="Button1" runat="server" Text="Back to Home"  CssClass="btn btn-default"
                                     PostBackUrl="~/userhome.aspx" CausesValidation="False" />
                            </div>              
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>

