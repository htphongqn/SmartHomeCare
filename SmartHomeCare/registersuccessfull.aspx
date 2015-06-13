<%@ Page Title="" Language="C#" MasterPageFile="~/site.master" AutoEventWireup="true" CodeFile="registersuccessfull.aspx.cs" Inherits="registersuccessfull" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <style type="text/css">
        .divinfo
        {
            margin-top:10px;
            padding-left:20px;
            padding-bottom:40px;
            font-size:14px;
        }
    </style>
    <script type="text/javascript">
        function newpage() {
            location.href = 'home.aspx'; //Mở 1 trang mới có địa chỉ là b.html
        }
        //setTimeout("newpage()", 3000); //Goi hàm "newpage" sau 1 giây
    </script>
      <script type="text/javascript">

          $(document).ready(function () {
              $("#alert_button").click(function () {
                  jAlert('This is a custom alert box', 'Alert Dialog');
              });

              $("#confirm_button").click(function () {
                  jConfirm('Can you confirm this?', 'Confirmation Dialog', function (r) {
                      jAlert('Confirmed: ' + r, 'Confirmation Results');
                  });
              });

              $("#prompt_button").click(function () {
                  jPrompt('Type something:', 'Prefilled value', 'Prompt Dialog', function (r) {
                      if (r) alert('You entered ' + r);
                  });
              });

              $("#alert_button_with_html").click(function () {
                  jAlert('You can use HTML, such as <strong>bold</strong>, <em>italics</em>, and <u>underline</u>!');
              });

              $(".alert_style_example").click(function () {
                  $.alerts.dialogClass = $(this).attr('id'); // set custom style class
                  jAlert('This is the custom class called &ldquo;style_1&rdquo;', 'Custom Styles', function () {
                      $.alerts.dialogClass = null; // reset to default
                  });
              });

          });

          function Clicked() {

              jAlert('Your account has been created. Please check your email for registration confirmation.', 'Notification message');
          }

    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="menu" Runat="Server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="main" Runat="Server">

    <div class="divinfo">
        Your account has been created.<br />
        Please check your email for the registration confirmation or click <a href="home.aspx">here</a> to go back Home page
    </div>

</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="footer" Runat="Server">
</asp:Content>

