<%@ Page Title="" Language="C#" MasterPageFile="~/siteuser.master" AutoEventWireup="true" CodeFile="usertrackotherhealth.aspx.cs" Inherits="usertrackmyhealth" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head1" Runat="Server">
    <style type="text/css">
        .style1
        {
            height: 114px;
            width:33%;
        }
        .btn_img
        {
            border: 1px solid #005E8F;
            text-align: center;
            width: 95%;
            margin: auto;
            max-width: 275px;
            }
        .btn_img a
        {
            text-decoration: none;
            font-size: 14px;
            }
        .btn_img img
        {
            height: 250px;
            width: 100%;
            border: 0px;
            border-bottom: 1px solid #005E8F;
            }
        .style2
        {
            height: 136px;
        }
        td, th {
          padding: 5px;
        }
    </style>
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
                    Track <asp:Label ID="lbcurrentuser" runat="server" Text=""></asp:Label> health
                </div>
                <div class="panel-body">
                    <div class="row">
                        <div class="col-lg-6" style="width:100%;">
                            <div class="clear">
                                The reports listed below are available for your use.<br />
                                Click the name of the report you wish to view.
                            </div>    
                            <div class="clear borderbottom">
                                <table cellspacing="10" >
                                    <tr>
                                        <td class="style1">
                                                <div class="btn_img">
                                                        <a href="usertrackothers_temperature.aspx"  >
                                                            <img src="resources/images/icon_tracktem.png" alt=""/>
                                                            Temperature<br /> Monitoring
                                                        </a>
                                                </div>
                                        </td>
                                        <td class="style1">
                                                <div class="btn_img">
                                                    <a href="usertrackothers_bodymeasurement.aspx">
                                                       <img src="resources/images/body.jpg" alt=""/>
                                                        Body measurement<br /> Monitoring
                                                    </a>
                                                </div>
                                            </td>
                                        <td class="style1">
                                                <div class="btn_img">
                                                    <a href="usertrackothers_heartrate.aspx" >
                                                        <img src="resources/images/heart-rate-training.jpg" alt=""/>
                                                        Heart Rate<br /> Monitoring
                                                   </a>
                                                </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="style2">
                                            
                                                <div class="btn_img">
                                                    <a href="usertrackothers_spo2.aspx"  >
                                                        <img src="resources/images/o2.jpg" alt=""/>
                                                        Oxygen<br /> Monitoring
                                                   </a>
                                                </div>
                                        </td>
                                        <td class="style2">
                                                <div class="btn_img">
                                                    <a href="usertrackothers_fitness.aspx" >
                                                        <img src="resources/images/fitness.jpg" alt=""/>
                                                        Fitness<br /> Monitoring
                                                   </a>
                                                </div>
                                        </td>
                                        <td class="style2">
                                                <div class="btn_img">
                                                    <a href="usertrackothers_stress.aspx">
                                                        <img src="resources/images/stress.png" alt=""/>
                                                        Stress<br /> Monitoring
                                                   </a>
                                                </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                                <div class="btn_img">
                                                    <a href="usertrackothers_fertility.aspx">
                                                        <img src="resources/images/fertility.jpg" alt=""/>
                                                        Fertility<br /> Monitoring
                                                   </a>
                                                </div>
                                        </td>
                                        <td>
                                                <div class="btn_img">
                                                    <a href="usertrackothers_position.aspx">
                                
                                                        <img src="resources/images/position.png" />
                                                        Position<br /> Monitoring
                                                   </a>
                                                </div>
                                        </td>
                                        <td>
                                                <div class="btn_img">
                                                    <a href="usertrackothers_sleep.aspx" >
                                                        <img src="resources/images/sleep.jpg" alt=""/>
                                                        Sleep<br /> Monitoring
                                                   </a>
                                                </div>
                                        </td>
                                    </tr>
                                </table>
                            </div>  
                            <div class="no-border" style="margin-bottom:10px;margin-top:10px">
                                <asp:Button ID="btnglobalsettings" runat="server" Text="Global Settings" CssClass="btn btn-default"
                                 onclick="btnglobalsettings_Click" />
                                <asp:Button ID="Button1" runat="server" Text="Back to Home" CssClass="btn btn-default"
                                 PostBackUrl="~/userhome.aspx" />
                            </div>            
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>     
</asp:Content>
