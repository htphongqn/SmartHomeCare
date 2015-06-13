<%@ Page Title="" Language="C#" MasterPageFile="~/siteuser.master" AutoEventWireup="true" CodeFile="useralarmmessages.aspx.cs" Inherits="useralarmmessages" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head1" Runat="Server">
<script src="scripts/jquery-2.0.3.js" type="text/javascript"></script>
    <script src="scripts/jquery-2.0.3.min.js" type="text/javascript"></script>
    <script src="scripts/jquery-ui.js" type="text/javascript"></script>
    <script type="text/javascript">
        $(document).ready(function () {

        });

        function checkAll(element) {
            var GridView = element.parentNode.parentNode.parentNode;
            var inputList = GridView.getElementsByTagName("input");
            for (var i = 0; i < inputList.length; i++) {
                //Get the Cell To find out ColumnIndex
                var row = inputList[i].parentNode.parentNode;
                if (inputList[i].type == "checkbox" && element != inputList[i]) {
                    if (element.checked) {
                        //If the header checkbox is checked
                        //check all checkboxes
                        //and highlight all rows
                        row.style.backgroundColor = "white";
                        inputList[i].checked = true;
                    }
                    else {
                        //If the header checkbox is checked
                        //uncheck all checkboxes
                        //and change rowcolor back to original 
                        if (row.rowIndex % 2 == 0) {
                            //Alternating Row Color
                            row.style.backgroundColor = "#white";
                        }
                        else {
                            row.style.backgroundColor = "white";
                        }
                        inputList[i].checked = false;
                    }
                }
            }
        }

        function GetDataAndDisplay(Control) {
            var popup = $('.popupConfirmation');
            var tr = $(this).parents(".record");
            var Id = $(Control).attr("name");
            $.ajax({
                type: "POST",
                url: 'userinbox.aspx/ReadMessage',
                data: "{id: " + Id + "}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (message) {
                    if (message.d['error'] == 0) {
                    }
                    else {
                        $('#title').html(message.d['title']);
                        $('#message').html(message.d['message']);
                        if (message.d['title'] == '') {
                            $('#title').html('no subject');

                        }
                        if (message.d['message'] == '') {
                            $('#message').html('no sender info');
                        }
                    }
                    popup.css('display', 'block');
                    popup.dialog({ modal: true });
                    $('.ui-dialog-titlebar').css('display', 'none');
                    tr.css('font-weight', 'bold');
                }
            });
            return false;
        }

        function DeleteMessage() {
            var Ids = "";
            var Gridview = document.getElementById("main_right1_grvInBox");
            var CheckBoxs = Gridview.getElementsByTagName('input');
            for (var i = 1; i < CheckBoxs.length; i++) {
                //Get the Cell To find out ColumnIndex
                //var row = CheckBoxs[i].parentNode.parentNode;
                if (CheckBoxs[i].type == "checkbox" && CheckBoxs[i].checked == true) {
                    Ids += $(CheckBoxs[i]).attr('name') + ",";
                }
            }
            $.ajax({
                type: "POST",
                url: 'userinbox.aspx/DeleteMessage',
                data: JSON.stringify({ args: [{
                    Ids: Ids
                }]
                }),
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (message) {
                    if (message.d == 1) {
                        alert('Delete successfull');
                        window.location.reload();
                    }
                    else {
                    }
                }
            });
            return false;
        }

        function Close() {
            $('.popupConfirmation').css('display', 'none');
            location.reload();
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="right1" Runat="Server">
    <div class="title_new">
            <div class="floatleft">
                <div class="td">
                   Alarm messages
                </div>
             </div>
            <div class="floatright">
                <%--<asp:ImageButton ID="ImageButton2" runat="server" Height="25px" ImageUrl="~/resources/images/printer.png" Width="25px" OnClientClick="return processPrint('print');" CssClass="floatleft"/>&nbsp;&nbsp;--%>
                <a id="userhelp" href="#"><img src="resources/images/h.png" /></a>
            </div>
            <div class="clear"></div>
     </div><!-- border bottom -->
    <div class="clear">
        Click on a messages to view the text of the message.<br />
        Messages in bold have not yet been read by the users.<br /><br />
    </div>
    <div class="clear gridview">
        <asp:GridView ID="grvAlarmBox" runat="server" AllowPaging="True" 
            AutoGenerateColumns="False" BackColor="White" BorderColor="#CCCCCC" 
            BorderStyle="None" BorderWidth="1px" CellPadding="3" Width="98%" 
            EmptyDataText="No message">
            <Columns>
                <asp:TemplateField>
                    <ItemTemplate>
                        <%--<asp:LinkButton ID="lblView" runat="server" Text="View" CommandArgument='<%# Eval("AutoId") %>' 
                            Font-Bold='<%# ((bool)Eval("IsView"))==true? false : true %>' CssClass= '<%# Eval("AutoId") %>' "></asp:LinkButton>--%>
                        <a href="#" id="view" onclick="GetDataAndDisplay(this)" name='<%# Eval("AutoId") %>' style="font-weight:<%# Eval("IsView").ToString().ToLower()=="true"? "normal" : "bold" %>" >View</a>
<%--                        <asp:ModalPopupExtender ID="lblView_ModalPopupExtender" runat="server" 
                            DynamicServicePath="" Enabled="True" TargetControlID="lblView" PopupControlID="panel1">
                        </asp:ModalPopupExtender>--%>
                        
                    </ItemTemplate>
                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Subject">
                    <ItemTemplate>
                        <asp:Label ID="Label1" runat="server" Text='<%# Bind("MsgSubject") %>' Font-Bold='<%# ((bool)Eval("IsView"))==true? false : true %>'></asp:Label>
                    </ItemTemplate>
                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                </asp:TemplateField>
                
                <asp:TemplateField HeaderText="Recieved">
                    <ItemTemplate>
                        <asp:Label ID="Label3" runat="server" 
                            Text='<%# Bind("Received", "{0:MM/dd/yyyy hh:mmtt}") %>' Font-Bold='<%# ((bool)Eval("IsView"))==true? false : true %>'></asp:Label>
                    </ItemTemplate>
                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                </asp:TemplateField>
            </Columns>
            <FooterStyle BackColor="White" ForeColor="#000066" />
            <HeaderStyle BackColor="#006699" Font-Bold="True" ForeColor="White" />
            <PagerStyle BackColor="White" ForeColor="#000066" HorizontalAlign="Left" />
            <RowStyle CssClass="record" ForeColor="#000066" />
            <SelectedRowStyle BackColor="#669999" Font-Bold="True" ForeColor="White" />
            <SortedAscendingCellStyle BackColor="#F1F1F1" />
            <SortedAscendingHeaderStyle BackColor="#007DBB" />
            <SortedDescendingCellStyle BackColor="#CAC9C9" />
            <SortedDescendingHeaderStyle BackColor="#00547E" />
        </asp:GridView>
    </div>
    <br />
     <div class="clear">
        <asp:Button ID="btndelete" runat="server" Text="Delete" Visible="False" />
    </div>
    <div class="popupConfirmation" style="display:none;">
        <div class="popup_Container">
            <div class="popup_Titlebar">
                <div class="TitlebarLeft">
                    <label id="title"></label>
                </div>
                <div class="TitlebarRight" onclick="Close();"></div>
            </div>
            <div class="popup_Body">
                <fieldset id="Message">
                    <legend style="font-weight:bold;"> Message
                    </legend>
                        <label id="message"></label>
                </fieldset>
            </div>
            <div class="popup_Buttons">
                <input id="btnCancel" value="Ok" type="button" />
            </div>
        </div>
    </div>

</asp:Content>

