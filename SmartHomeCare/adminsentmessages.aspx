<%@ Page Title="" Language="C#" MasterPageFile="~/siteadmin.master" AutoEventWireup="true" CodeFile="adminsentmessages.aspx.cs" Inherits="adminsentmessages" %>

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
            var Gridview = document.getElementById("main_right1_grvSentBox");
            var CheckBoxs = Gridview.getElementsByTagName('input');
            for (var i = 1; i < CheckBoxs.length; i++) {
                //Get the Cell To find out ColumnIndex
                //var row = CheckBoxs[i].parentNode.parentNode;
                if (CheckBoxs[i].type == "checkbox" && CheckBoxs[i].checked == true) {
                    Ids += $(CheckBoxs[i]).attr('name') + ",";
                }
            }
            if (Ids != "") {
                if (confirm('Are you want to delete message')) {
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
                }
            }
            else {
                alert("No row selected");
            }
            return false;
        }

        function Close() {
            $('.popupConfirmation').css('display', 'none');
            location.reload();
        }
        function ConfirmDelete() {
            var Ids = "";
            var Gridview = document.getElementById("main_right1_grvSentBox");
            var CheckBoxs = Gridview.getElementsByTagName('input');
            for (var i = 1; i < CheckBoxs.length; i++) {
                //Get the Cell To find out ColumnIndex
                //var row = CheckBoxs[i].parentNode.parentNode;
                if (CheckBoxs[i].type == "checkbox" && CheckBoxs[i].checked == true) {
                    Ids += $(CheckBoxs[i]).attr('name') + ",";
                }
            }
            if (Ids == "") {
                jAlert('<%= DBClass.GetMessageByCode2("select_message_null") %>', 'Notice');
            }
            else {
                jConfirm('<%= DBClass.GetMessageByCode2("delete_message") %>', 'Question?', function (r) {
                    if (r) {
                        $.ajax({
                            type: "POST",
                            url: 'adminsentmessages.aspx/DeleteMessage',
                            data: JSON.stringify({ args: [{
                                Ids: Ids
                            }]
                            }),
                            contentType: "application/json; charset=utf-8",
                            dataType: "json",
                            success: function (message) {
                                if (message.d == 1) {
                                    jAlert('<%= DBClass.GetMessageByCode2("delete_message_success") %>');
                                    window.location.reload();
                                }
                                else {
                                    jAlert('<%= DBClass.GetMessageByCode2("delete_message_error") %>');
                                }
                            }
                        });
                    }
                });
            }
            return false;
        }
    </script>    
 
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="right1" Runat="Server">

    <div class="title_new">
            <div class="floatleft">
                <div class="td">
                   Sent messages
                </div>
             </div>
            <div class="floatright">
                <%--<asp:ImageButton ID="ImageButton3" runat="server" Height="25px" ImageUrl="~/resources/images/printer.png" Width="25px" OnClientClick="return processPrint('print');" CssClass="floatleft"/>&nbsp;&nbsp;--%>
                <a id="adminhelp" href="#"><img src="resources/images/h.png" /></a>
            </div>
            <div class="clear"></div>
     </div><!-- border bottom -->
    <div class="clear">
        Click on a messages to view the text of the message.<br />
        Messages in bold have not yet been read by the remote users.<br /><br />
    </div>
    <div class="clear gridview">
        <asp:GridView ID="grvSentBox" runat="server" AllowPaging="True" 
            AutoGenerateColumns="False" BackColor="White" BorderColor="#CCCCCC" 
            BorderStyle="None" BorderWidth="1px" CellPadding="3" Width="98%" 
            EmptyDataText="No message" DataKeyNames="AutoId" PageSize="4">
            <Columns>
                <asp:TemplateField>
                    <HeaderTemplate>
                        <asp:CheckBox ID="chkAll" onclick = "checkAll(this);" runat="server" />
                    </HeaderTemplate>
                    <ItemTemplate>
                       <asp:CheckBox ID="chkSelected"  Checked="false" CssClass='<%# Eval("AutoId") %>' runat="server"  Visible="false"/>
                        <input id='<%# Eval("AutoId") %>' type="checkbox" name='<%# Eval("AutoId") %>'/>
                    </ItemTemplate>
                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="10px" />
                </asp:TemplateField>

                <asp:TemplateField HeaderText="Subject">
                    <ItemTemplate>
                       <asp:HyperLink ID="view" runat="server" onclick="GetDataAndDisplay(this)" NavigateUrl="#" name='<%# Eval("AutoId") %>'  Text='<%# Bind("MsgSubject") %>' ></asp:HyperLink>
                        <asp:HyperLink ID="HyperLink1" runat="server" onclick="GetDataAndDisplay(this)" Visible='<%# Eval("MsgSubject")==""?true:false %>' NavigateUrl="#" name='<%# Eval("AutoId") %>'  Text="No Subject" ></asp:HyperLink>
                    </ItemTemplate>
                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="40%" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText="To">
                    <ItemTemplate>
                        <asp:Label ID="Label2" runat="server" Text='<%# Bind("ToUserName") %>'></asp:Label>
                    </ItemTemplate>
                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Sent" >
                    <ItemTemplate>
                        <asp:Label ID="Label3" runat="server" 
                            Text='<%# Bind("Received", "{0:MM/dd/yyyy hh:mm tt}") %>' ></asp:Label>
                    </ItemTemplate>
                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="25%" />
                </asp:TemplateField>
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
    <br />
     <div class="clear">
        <%--<asp:Button ID="btndelete" runat="server" Text="Delete" 
             onclick="btndelete_Click" onclientclick="return MessageDelete();" />--%>
        <input id="btnDelete" type="button" value="Delete" onclick="ConfirmDelete()"/>
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
                <input id="btnCancel" value="Cancel" onclick="Close();" type="button" />
            </div>
        </div>
    </div>
    <div class ="collectionpager">
         
            <asp:ImageButton ID="ImageButton1" runat="server"  CssClass="floatleft" Width="20px" 
            onclick="lbPre_Click" Height="21px" 
            ImageUrl="~/resources/images/Previous-icon.png"/>
         
        <asp:LinkButton ID="lbPre" runat="server" CssClass="floatleft" Width="73px" 
            onclick="lbPre_Click" Height="23px">Previous</asp:LinkButton>
        <div class="floatleft" style="text-align:center;width:76%">
        <asp:Label ID="lbCount" runat="server" Text="Messages  1-3" Font-Bold="True" CssClass="collectionpager"></asp:Label>
           
        </div>
        <asp:LinkButton ID="LinkButton2" runat="server" CssClass="floatleft" 
            onclick="LinkButton2_Click">Next </asp:LinkButton>
         <asp:ImageButton ID="ImageButton2" runat="server"  CssClass="floatleft" Width="25px" 
            onclick="LinkButton2_Click" Height="21px" 
            ImageUrl="~/resources/images/next.jpg"/>
    </div><!-- collection page -->
      
</asp:Content>

