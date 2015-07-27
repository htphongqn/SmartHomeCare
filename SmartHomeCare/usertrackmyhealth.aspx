<%@ Page Title="" Language="C#" MasterPageFile="~/siteuser.master" AutoEventWireup="true" CodeFile="usertrackmyhealth.aspx.cs" Inherits="usertrackmyhealth" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head1" Runat="Server">
    <style type="text/css">
        .style1
        {
            height: 114px;
        }
        .style2
        {
            height: 136px;
        }
        td, th {
          padding: 5px;
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
                    Track <asp:Label ID="lbNamehealth" runat="server" Text="my"></asp:Label> health
                </div>
                <div class="panel-body">
                    <div class="row">
                        <div class="col-lg-6">
                            <div class="clear">
                                The reports listed below are available for your use.<br />
                                Click the name of the report you wish to view.
                            </div>    
                            <asp:UpdatePanel ID="UpdatePanel" runat="server">
                                <ContentTemplate>        
                                <div class="clear">
                                    <table cellspacing="10">
                                        <tr>
                                            <td class="style1">
                                                    <div class="btn_img">
                                                            <a href="usertrackmyhealth_temperature.aspx"  >
                                                                <img src="resources/images/icon_tracktem.png" alt=""/>
                                                                Temperature<br /> Monitoring
                                                            </a>
                                                    </div>
                                            </td>
                                            <td class="style1">
                                                    <div class="btn_img">
                                                        <a href="usertrackmyhealth_bodymeasurement.aspx">
                                                           <img src="resources/images/body.jpg" alt=""/>
                                                            Body measurement<br /> Monitoring
                                                        </a>
                                                    </div>
                   
                   
                                                </td>
                                            <td class="style1">
                                                    <div class="btn_img">
                                                        <a href="usertrackmyhealth_heartrate.aspx" >
                                                            <img src="resources/images/heart-rate-training.jpg" alt=""/>
                                                            Heart Rate<br /> Monitoring
                                                       </a>
                                                    </div>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="style2">
                                                    <div class="btn_img">
                                                        <a href="usertrackmyhealth_spo2.aspx"  >
                                                            <img src="resources/images/o2.jpg" alt=""/>
                                                            Oxygen<br /> Monitoring
                                                       </a>
                                                    </div>
                                            <td class="style2">
                                                    <div class="btn_img">
                                                        <a href="usertrackmyhealth_fitness.aspx" >
                                                            <img src="resources/images/fitness.jpg" alt=""/>
                                                            Fitness<br /> Monitoring
                                                       </a>
                                                    </div>
                                            </td>
                                            <td class="style2">
                                                     <div class="btn_img">
                                                        <a href="usertrackmyhealth_stress.aspx">
                                                            <img src="resources/images/stress.png" alt=""/>
                                                            Stress<br /> Monitoring
                                                       </a>
                                                    </div>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                    <div class="btn_img">
                                                        <a href="usertrackmyhealth_fertility.aspx">
                                                            <img src="resources/images/fertility.jpg" alt=""/>
                                                            Fertility<br /> Monitoring
                                                       </a>
                                                    </div>
                                            </td>
                                            <td>
                                                     <div class="btn_img">
                                                        <a href="usertrackmyhealth_position.aspx">
                                
                                                            <img src="resources/images/position.png" />
                                                            Position<br /> Monitoring
                                                       </a>
                                                    </div>
                                            </td>
                                            <td>
                                                    <div class="btn_img">
                                                        <a href="usertrackmyhealth_sleep.aspx" >
                                                            <img src="resources/images/sleep.jpg" alt=""/>
                                                            Sleep<br /> Monitoring
                                                       </a>
                                                    </div>
                                            </td>
                                        </tr>
                                    </table>
                                </div>
                                </ContentTemplate>
                            </asp:UpdatePanel>  
                            <div class="no-border" style="margin-bottom:10px;margin-top:10px">
                                <asp:Button ID="btnglobalsettings" runat="server" Text="Global Settings"  CssClass="btn btn-default"
                                        onclick="btnglobalsettings_Click" />
                                <asp:Button ID="Button1" runat="server" Text="Back to Home"  CssClass="btn btn-default"
                                        PostBackUrl="~/userhome.aspx" onclick="Button1_Click" />
                            </div>                
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <asp:UpdateProgress ID="UpadateProc" AssociatedUpdatePanelID="UpdatePanel" runat="server">
            <ProgressTemplate>
                    <div class="loading">
                <img src="resources/images/process.gif" />
            </div>
    </ProgressTemplate>
</asp:UpdateProgress>
</asp:Content>
