<%@ Page Title="Inbox" Language="C#" MasterPageFile="~/siteuser.master" AutoEventWireup="true" CodeFile="userinbox.aspx.cs" Inherits="userinbox" %>

<%@ Register Assembly="CollectionPager" Namespace="SiteUtils" TagPrefix="cc1" %>

<%@ Register assembly="AjaxControlToolkit" namespace="AjaxControlToolkit" tagprefix="asp" %>

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
                if (inputList[i].type == "checkbox" && element != inputList[i] && inputList[i].style.visibility == "visible") {
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
                            $('#title').html(' no subject');

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
            var Gridview = document.getElementById("main_right1_grvInbox");
            var CheckBoxs = Gridview.getElementsByTagName('input');
            for (var i = 1; i < CheckBoxs.length; i++) {
                //Get the Cell To find out ColumnIndex
                //var row = CheckBoxs[i].parentNode.parentNode;
                if (CheckBoxs[i].type == "checkbox" && CheckBoxs[i].checked == true) {
                    Ids += $(CheckBoxs[i]).attr('name') + ",";
                }
            }
            if (Ids != "") {
                jConfirm('<%= DBClass.GetMessageByCode2("delete_message") %>', 'Question?', function (r) {
                    if (r) {
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
                                    jAlert('<%= DBClass.GetMessageByCode2("delete_message_success") %>', 'Notice');
                                    window.location.reload();
                                }
                                else {
                                    jAlert('<%= DBClass.GetMessageByCode2("delete_message_error") %>', 'Notice');
                                }
                            }
                        });
                    } 
                });
            }
            else {
                jAlert('<%= DBClass.GetMessageByCode2("select_message_null") %>', 'Notice');
            }
            return false;
        }

        function Close() {
            $('.popupConfirmation').css('display', 'none');
            location.reload();
        }
        function MessageDelete() {

            result = confirm('<%= DBClass.GetMessageByCode2("delete_message") %>');
            if (result) {
                return true;
            }
            return false;

        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="right1" Runat="Server">
    <div class="title_new">
            <div class="floatleft">
                <div class="td">
                   Inbox
                </div>
             </div>
            <div class="floatright">
                
                <a id="userhelp" href="#"><img src="resources/images/h.png" /></a>
            </div>
            <div class="clear"></div>
     </div><!-- border bottom -->
    <div class="clear">
        Messages that admin and other users have sent you are listed on this page.<br />
        You can view the complete text of any message by clicking on its message row.<br />
        Only messages that have been marked as read can be deleted.<br /><br />
    </div>
    <div class="clear gridview">
        <asp:GridView ID="grvInbox" runat="server" 
            AutoGenerateColumns="False" BackColor="White" BorderColor="#CCCCCC" 
            BorderStyle="None" BorderWidth="1px" CellPadding="3" Width="98%" 
            EmptyDataText="No message" AllowPaging="True" 
             PageSize="5" >
            <Columns>
                <asp:TemplateField>
                    <HeaderTemplate>
                        <asp:CheckBox ID="chkAll" onclick = "checkAll(this);" runat="server" />
                    </HeaderTemplate>
                    <ItemTemplate>
                        <%--<asp:CheckBox ID="chkSelected"  Visible='<%# Eval("IsView")%>'  CssClass='<%# Eval("AutoId") %>' runat="server" Name='<%# Eval("AutoId") %>' />--%>
                        <input id='<%# Eval("AutoId") %>' style="visibility:<%# Eval("IsView").ToString()=="False"?"hidden":"visible" %>" type="checkbox" name='<%# Eval("AutoId") %>' />
                    </ItemTemplate>
                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="10px" />
                </asp:TemplateField>

                <asp:TemplateField HeaderText="Subject">
                    <ItemTemplate>
                        <asp:HyperLink ID="view" runat="server" onclick="GetDataAndDisplay(this)" NavigateUrl="#" name='<%# Eval("AutoId") %>'  Text='<%# Bind("MsgSubject") %>' Font-Bold='<%# ((bool)Eval("IsView"))==true? false : true %>'></asp:HyperLink>
                        <asp:HyperLink ID="HyperLink1" runat="server" onclick="GetDataAndDisplay(this)" Visible='<%# Eval("MsgSubject")==""?true:false %>' NavigateUrl="#" name='<%# Eval("AutoId") %>'  Text="No Subject" Font-Bold='<%# ((bool)Eval("IsView"))==true? false : true %>'></asp:HyperLink>
                       <%-- <asp:Label ID="Label1" runat="server" Text='<%# Bind("MsgSubject") %>' Font-Bold='<%# ((bool)Eval("IsView"))==true? false : true %>'></asp:Label>--%>
                    </ItemTemplate>
                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="40%" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText="From">
                    <ItemTemplate>
                        <asp:Label ID="Label2" runat="server" Text='<%# Bind("FirstName") %>' Font-Bold='<%# ((bool)Eval("IsView"))==true? false : true %>'></asp:Label>
                        <asp:Label ID="Label1" runat="server" Text='<%# Bind("LastName") %>' Font-Bold='<%# ((bool)Eval("IsView"))==true? false : true %>'></asp:Label>
                    </ItemTemplate>
                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Recieved">
                    <ItemTemplate>
                        <asp:Label ID="Label3" runat="server" 
                            Text='<%# Bind("Received", "{0:MM/dd/yyyy hh:mm tt}") %>' Font-Bold='<%# ((bool)Eval("IsView"))==true? false : true %>'></asp:Label>
                    </ItemTemplate>
                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="20%" />
                </asp:TemplateField>
            </Columns>
            <FooterStyle BackColor="White" ForeColor="#000066" />
            <HeaderStyle BackColor="#006699" Font-Bold="True" ForeColor="White" />
            <PagerSettings FirstPageText="" LastPageText="" Visible="False" />
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
        <input id="btnDelete" type="button" value="Delete" onclick="DeleteMessage()"/>
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
                <input id="btnCancel" value="OK" onclick="Close();" type="button" />
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

