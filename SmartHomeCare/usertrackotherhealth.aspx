<%@ Page Title="" Language="C#" MasterPageFile="~/siteuser.master" AutoEventWireup="true" CodeFile="usertrackotherhealth.aspx.cs" Inherits="usertrackmyhealth" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head1" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="right1" Runat="Server">
    <div class="borderbottom">
        <div class="floatleft title">Track <asp:Label ID="lbcurrentuser" runat="server" Text=""></asp:Label> health</div>
        <div class="floatright"><a href="userhelp.aspx">Help</a></div>
        <div class="clear"></div>
    </div>
    <br />
    <div class="clear">
        The reports listed below are available for your use.<br />
        Click the name of the report you wish to view.
    </div>
    <div class="clear borderbottom">
        <table cellspacing="10" >
            <tr>
                <td>
                    <%--<asp:ImageButton ID="btnheartrate" runat="server" CssClass="btn_img"
                        ImageUrl="~/resources/images/heart-rate-training.jpg" 
                        PostBackUrl="~/usertrackmyhealth_heartrate.aspx" ToolTip="Heart Rate" 
                        Height="100px" Width="100px"/>--%>
                        <div class="btn_img">
                                <a href="usertrackothers_temperature.aspx"  >
                                    <img src="resources/images/icon_tracktem.png" alt=""/>
                                    Temperature<br /> Monitoring
                                </a>
                        </div>
                </td>
                <td>
                    <%--<asp:ImageButton ID="btnbody" runat="server" CssClass="btn_img"
                        ImageUrl="~/resources/images/body.jpg" 
                        PostBackUrl="~/usertrackmyhealth_bodymeasurement.aspx" 
                        ToolTip="Body measurement" Height="100px" Width="100px"/>--%>
                        <div class="btn_img">
                            <a href="usertrackothers_bodymeasurement.aspx">
                               <img src="resources/images/body.jpg" alt=""/>
                                Body measurement<br /> Monitoring
                            </a>
                        </div>
                    </td>
                <td>
                    <%--<asp:ImageButton ID="btnheartrate" runat="server" CssClass="btn_img"
                        ImageUrl="~/resources/images/heart-rate-training.jpg" 
                        PostBackUrl="~/usertrackmyhealth_heartrate.aspx" ToolTip="Heart Rate" 
                        Height="100px" Width="100px"/>--%>
                        <div class="btn_img">
                            <a href="usertrackothers_heartrate.aspx" >
                                <img src="resources/images/heart-rate-training.jpg" alt=""/>
                                Heart Rate<br /> Monitoring
                           </a>
                        </div>
                </td>
            </tr>
            <tr>
                <td>
                    <%--<asp:ImageButton ID="btnspo2" runat="server" CssClass="btn_img"
                        ImageUrl="~/resources/images/o2.jpg" 
                        PostBackUrl="~/usertrackmyhealth_spo2.aspx" Height="100px" Width="100px" ToolTip="Oxygen"/>--%>
                        <div class="btn_img">
                            <a href="usertrackothers_spo2.aspx"  >
                                <img src="resources/images/o2.jpg" alt=""/>
                                Oxygen<br /> Monitoring
                           </a>
                        </div>
                </td>
                <td>
                    <%--<asp:ImageButton ID="btnfitness" runat="server" CssClass="btn_img"
                        ImageUrl="~/resources/images/fitness.jpg" 
                        PostBackUrl="~/usertrackmyhealth_fitness.aspx" Height="100px" ToolTip="Fitness"
                        Width="100px"/>--%>
                        <div class="btn_img">
                            <a href="usertrackothers_fitness.aspx" >
                                <img src="resources/images/fitness.jpg" alt=""/>
                                Fitness<br /> Monitoring
                           </a>
                        </div>
                </td>
                <td>
                    
                   <%-- <asp:ImageButton ID="btnstress" runat="server" CssClass="btn_img"
                        ImageUrl="~/resources/images/stress.png" 
                        PostBackUrl="~/usertrackothers_stress.aspx" Height="100px" Width="100px" ToolTip="Stress"/>--%>
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
                    <%--<asp:ImageButton ID="btnfertility" runat="server" CssClass="btn_img"
                        ImageUrl="~/resources/images/fertility.jpg" 
                        PostBackUrl="~/usertrackmyhealth_fertility.aspx" Height="100px" 
                        Width="100px" ToolTip="Fertility"/>--%>
                        <div class="btn_img">
                            <a href="usertrackothers_fertility.aspx">
                                <img src="resources/images/fertility.jpg" alt=""/>
                                Fertility<br /> Monitoring
                           </a>
                        </div>
                </td>
                <td>
                   <%-- <asp:ImageButton ID="btnposition" runat="server" CssClass="btn_img"
                        ImageUrl="~/resources/images/position.png" 
                        PostBackUrl="~/usertrackmyhealth_position.aspx" Height="100px" 
                        Width="100px" ToolTip="Position"/>--%>
                        <div class="btn_img">
                            <a href="usertrackothers_position.aspx">
                                
                                <img src="resources/images/position.png" />
                                Position<br /> Monitoring
                           </a>
                        </div>
                </td>
                <td>
                    <%--<asp:ImageButton ID="btnsleep" runat="server" CssClass="btn_img"
                        ImageUrl="~/resources/images/sleep.jpg" 
                        PostBackUrl="~/usertrackmyhealth_sleep.aspx" Height="100px" 
                        Width="100px" ToolTip="Sleep"/>--%>
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
    <br />
     <div class="no-border">
        <asp:Button ID="btnglobalsettings" runat="server" Text="Global Settings" 
             onclick="btnglobalsettings_Click" />
        <asp:Button ID="Button1" runat="server" Text="Back to Home" 
             PostBackUrl="~/userhome.aspx" />
    </div>
</asp:Content>
