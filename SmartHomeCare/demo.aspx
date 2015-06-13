<%@ Page Title="" Language="C#" MasterPageFile="~/siteuser.master" AutoEventWireup="true" CodeFile="demo.aspx.cs" Inherits="demo" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head1" Runat="Server">
    <link href="styles/BodyMeasurement.css" rel="stylesheet" type="text/css" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="right1" Runat="Server">
<div class="body_measurement">
    <div class="title_data">
        <table>
            <tr>
                <th></th>
            </tr>
            <tr>
                <td>
                    <asp:Label runat="server" ID="lbDateTable" Text="DateTime"></asp:Label>
                </td>
            </tr>
            <tr>
                <td style="width:79px">BMI</td>
            </tr>
            <tr>
                <td>WHR</td>
            </tr>
            <tr>
                <td>BMR</td>
            </tr>
            <tr>
                <td>BF%</td>
            </tr>
            <tr>
                <td>LBW</td>
            </tr>
            <tr>
                <td>Ideal W</td>
            </tr>
            <tr>
                <td>Meta. age</td>
            </tr>
            <tr>
                <td>Act. level</td>
            </tr>
            <tr>
                <td>Cal. needs</td>
            </tr>
        </table>
    </div>
    <div class="body_data">
            <asp:Label runat="server" ID="ld_data"></asp:Label>
    </div>
    <div class="clear"></div>
</div><!-- end -->
</asp:Content>

