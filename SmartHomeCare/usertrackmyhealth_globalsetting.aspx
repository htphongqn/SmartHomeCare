<%@ Page Title="" Language="C#" MasterPageFile="~/siteuser.master" AutoEventWireup="true" CodeFile="usertrackmyhealth_globalsetting.aspx.cs" Inherits="usertrackmyhealth_globalsetting" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head1" Runat="Server">
    <style type="text/css">
        .style1
        {
            width: 59px;
        }
    </style>

    <script type="text/javascript">
        $(document).ready(function () {
            $('#userhelp').click(function (e) {
                window.open('userhelp.aspx', 'User Help', 500, 500);
            });
        });
    </script>
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
                    <a href="usertrackmyhealth.aspx"> Track <asp:Label ID="lbNameHealth" runat="server" Text="my"></asp:Label> health </a>  » Global settings
                </div>
                <div class="panel-body">
                    <div class="row">
                        <div class="col-lg-6">
                            <div class="clear">
                                This page display current global settings.<br /><br />
                                Measurement system: <asp:RadioButton ID="rdmetric" runat="server" Text="Metric" GroupName="g" />
                                                    <asp:RadioButton ID="rdus" runat="server" Text="US" GroupName="g" Checked="True"/>
                            </div>                              
                            <div class="no-border" style="margin-bottom:10px;margin-top:10px">
                                <asp:Button ID="btnsave" runat="server" Text="Save" onclick="btnsave_Click"  CssClass="btn btn-default"/>
                                <asp:Button ID="btncancel" runat="server" Text="Cancel" 
                        onclick="btncancel_Click" CausesValidation="False"  CssClass="btn btn-default"
                        PostBackUrl="~/usertrackmyhealth.aspx" />
                            </div>                
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>

