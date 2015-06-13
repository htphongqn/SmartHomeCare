<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Default" %>

<%@ Register Assembly="TeeChart" Namespace="Steema.TeeChart.Web" TagPrefix="tchart" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    
    <script src="scroll/jquery.mCustomScrollbar.js" type="text/javascript"></script>
    <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.4/jquery.min.js"></script>
    <script src="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8/jquery-ui.min.js" type="text/javascript"></script>
    <script src="scroll/jquery.mCustomScrollbar.js" type="text/javascript"></script>
    <script src="scroll/jquery.mousewheel.min.js" type="text/javascript"></script>
    <script src="scroll/jquery.easing.1.3.js" type="text/javascript"></script>

    <link href="styles/gridview.css" rel="stylesheet" type="text/css" />

    <noscript>
	<style type="text/css">
		#mcs_container .customScrollBox,#mcs2_container .customScrollBox,#mcs3_container .customScrollBox,#mcs4_container .customScrollBox,#mcs5_container .customScrollBox{overflow:auto;}
		#mcs_container .dragger_container,#mcs2_container .dragger_container,#mcs3_container .dragger_container,#mcs4_container .dragger_container,#mcs5_container .dragger_container{display:none;}
	</style>
</noscript>

<script>
    $(window).load(function () {
        mCustomScrollbars();
    });

    function mCustomScrollbars() {
        /* 
        malihu custom scrollbar function parameters: 
        1) scroll type (values: "vertical" or "horizontal")
        2) scroll easing amount (0 for no easing) 
        3) scroll easing type 
        4) extra bottom scrolling space for vertical scroll type only (minimum value: 1)
        5) scrollbar height/width adjustment (values: "auto" or "fixed")
        6) mouse-wheel support (values: "yes" or "no")
        7) scrolling via buttons support (values: "yes" or "no")
        8) buttons scrolling speed (values: 1-20, 1 being the slowest)
        */
        $("#mcs_container").mCustomScrollbar("vertical", 400, "easeOutCirc", 1.05, "auto", "yes", "yes", 10);
        $("#mcs2_container").mCustomScrollbar("vertical", 0, "easeOutCirc", 1.05, "auto", "yes", "no", 0);
        $("#mcs3_container").mCustomScrollbar("vertical", 900, "easeOutCirc", 1.05, "auto", "no", "no", 0);
        $("#mcs4_container").mCustomScrollbar("vertical", 200, "easeOutCirc", 1.25, "fixed", "yes", "no", 0);
        $("#mcs5_container").mCustomScrollbar("horizontal", 500, "easeOutCirc", 1, "fixed", "yes", "yes", 20);
    }

    /* function to fix the -10000 pixel limit of jquery.animate */
    $.fx.prototype.cur = function () {
        if (this.elem[this.prop] != null && (!this.elem.style || this.elem.style[this.prop] == null)) {
            return this.elem[this.prop];
        }
        var r = parseFloat(jQuery.css(this.elem, this.prop));
        return typeof r == 'undefined' ? 0 : r;
    }

    /* function to load new content dynamically */
    function LoadNewContent(id, file) {
        $("#" + id + " .customScrollBox .content").load(file, function () {
            mCustomScrollbars();
        });
    }
</script>

    <script src="scroll/jquery.mCustomScrollbar.js" type="text/javascript"></script>
</head>
<body>
    <form id="form1" runat="server">
    <asp:Panel ID="table_item" runat="server" CssClass="table_item">
        <div class="title_grv">
            <table>
                <tr>
                    <td style="width:150px;">
                        DateTime
                    </td>
                    <td style="width:80px;">
                        HR
                    </td>
                    <td style="width:120px;">
                        Resting HR
                    </td>
                    <td style="width:120px;">
                        HRV
                    </td>
                    <td style="width:200px;">
                        Diagn
                    </td>
                    
                </tr>
            </table>
        </div><!-- Title -->
        <div id="mcs_container">
        <div class="customScrollBox">
		<div class="container">
    		<div class="content">
            <asp:GridView ID="grvTable" runat="server" AutoGenerateColumns="False"
                BackColor="White" BorderColor="#CCCCCC" BorderStyle="None" BorderWidth="1px"
                CellPadding="3" EmptyDataText=" Data null " AllowPaging="false" 
                    PageSize="100" ShowHeader="False" >
                <Columns>
                    <asp:BoundField DataFormatString="{0:MM/dd/yyyy hh:mm tt}" DataField="ReceivedDate">
                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="150px" />
                    </asp:BoundField>
                    <asp:BoundField HeaderText="HR" DataField="HR">
                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="80px" />
                    </asp:BoundField>
                    <asp:BoundField HeaderText="Resting HR" DataField="RestHR">
                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="120px" />
                    </asp:BoundField>
                    <asp:BoundField HeaderText="HRV" DataField="Voltage">
                        <ItemStyle HorizontalAlign="Center" Width="120px" />
                    </asp:BoundField>
                    <asp:BoundField HeaderText="Diagn" DataField="Diagnosis">
                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="200px" />
                    </asp:BoundField>
                </Columns>
                <FooterStyle BackColor="White" ForeColor="#000066" />
                <HeaderStyle BackColor="#006699" Font-Bold="True" ForeColor="White" />
                <PagerSettings Visible="False" />
                <PagerStyle BackColor="White" ForeColor="#000066" HorizontalAlign="Left" />
                <RowStyle CssClass="record" ForeColor="#000066" />
                <SelectedRowStyle BackColor="#669999" Font-Bold="True" ForeColor="White" />
                <SortedAscendingCellStyle BackColor="#F1F1F1" />
                <SortedAscendingHeaderStyle BackColor="#007DBB" />
                <SortedDescendingCellStyle BackColor="#CAC9C9" />
                <SortedDescendingHeaderStyle BackColor="#00547E" />
            </asp:GridView>
       </div>
		</div>
		<div class="dragger_container">
    		<div class="dragger"></div>
		</div>
	</div>
    <a href="#" class="scrollUpBtn"></a> <a href="#" class="scrollDownBtn"></a>
</div>
    </asp:Panel><!-- table item -->
    </form>
    
</body>
</html>
