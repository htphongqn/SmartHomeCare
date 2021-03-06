﻿<%@ Page Title="" Language="C#" MasterPageFile="~/siteuser.master" AutoEventWireup="true" CodeFile="usertrackothers_fitness_settings_custom.aspx.cs" Inherits="usertrackothers_fitness_settings_custom" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head1" Runat="Server">

    <style type="text/css">
    .form-control
        {
            display: inline;
            width: 100%;
            margin: 2px;
            height: 34px;
            padding: 6px 4px;
            font-size: 14px;
            line-height: 1.42857143;
            color: #555;
            background-color: #fff;
            background-image: none;
            border: 1px solid #ccc;
            border-radius: 4px;
            -webkit-box-shadow: inset 0 1px 1px rgba(0,0,0,.075);
            box-shadow: inset 0 1px 1px rgba(0,0,0,.075);
            -webkit-transition: border-color ease-in-out .15s,-webkit-box-shadow ease-in-out .15s;
            -o-transition: border-color ease-in-out .15s,box-shadow ease-in-out .15s;
            transition: border-color ease-in-out .15s,box-shadow ease-in-out .15s;
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
                    <a href="usertrackotherhealth.aspx"> Track <asp:Label ID="lbNameHealth" runat="server" Text="my"></asp:Label> health </a>  » <a href="usertrackothers_fertility.aspx">Fitness monitoring</a> » <a href="usertrackothers_fitness_settings.aspx"> Settings</a> » Custom
                </div>
                <div class="panel-body">
                    <div class="row">
                        <div class="col-lg-6" style="width:100%;">
                            <div id="print">
                             <div class="clear" style="margin-bottom:20px">
                                <table>
                                    <tr>
                                        <td colspan="2">
                                             This page display current settings of this feature.
                                        </td>
                                    </tr>
                                    <tr style="height:10px">
                                        <td colspan="2">
                     
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="2">
                                            Number of stages: <asp:TextBox ID="txtnumberofstages" runat="server" Width="60"  CssClass="form-control" style="margin: 20px 20px;"
                                                    AutoPostBack="True" onkeypress="return ValidateKeypress(/\d/,event);" 
                                                    ontextchanged="txtnumberofstages_TextChanged"></asp:TextBox>
                                                <asp:Button ID="btnSave" runat="server" Text="Save" onclick="btnSave_Click" CssClass="btn btn-default" />
                                                <asp:Button ID="btnback" runat="server" CausesValidation="false" PostBackUrl="usertrackothers_fitness_settings.aspx" Text="Cancel" CssClass="btn btn-default"/>
                                        </td>                
                                    </tr>
                                    <tr>
                                        <td colspan="2">
                                            <asp:Table ID="tblfitnessprogram" runat="server" Width="100%" 
                                                ViewStateMode="Enabled">
                                            </asp:Table>
                                        </td>
                                    </tr>            
                                    <tr>
                                        <td>Transition Audio:</td>
                                        <td><asp:TextBox ID="txttransitionaudio" runat="server" Width="200" CssClass="form-control"></asp:TextBox></td>
                                    </tr>
                                    <tr>
                                        <td>Program name:</td>
                                        <td><asp:TextBox ID="txtprogramname" runat="server" Width="200" CssClass="form-control"></asp:TextBox></td>
                                    </tr>
                                </table>
                            </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
</asp:Content>

