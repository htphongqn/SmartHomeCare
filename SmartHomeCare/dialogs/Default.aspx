<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Default" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <script src="jquery1.2.6.js" type="text/javascript"></script>
    <script src="jquery.ui.draggable.js" type="text/javascript"></script>
    <script src="jquery.alerts.js" type="text/javascript"></script>
    <link href="jquery.alerts.css" rel="stylesheet" type="text/css" />
    <style type="text/css">
			BODY,
			HTML {
				padding: 0px;
				margin: 0px;
			}
			BODY {
				font-family: Arial, Helvetica, sans-serif;
				font-size: 12px;
				background: #FFF;
				padding: 15px;
			}
			
			H1 {
				font-size: 20px;
				font-weight: normal;
			}
			
			H2 {
				font-size: 16px;
				font-weight: normal;
			}
			
			FIELDSET {
				border: solid 1px #CCC;
				-moz-border-radius: 16px;
				-webkit-border-radius: 16px;
				border-radius: 16px;
				padding: 1em 2em;
				margin: 1em 0em;
			}
			
			LEGEND {
				color: #666;
				font-size: 16px;
				padding: 0em .5em;
			}
			
			PRE {
				font-family: "Courier New", monospace;
				font-size: 11px;
				color: #666;
				background: #F8F8F8;
				padding: 1em;
				-moz-border-radius: 8px;
				-webkit-border-radius: 8px;
				border-radius: 8px;
			}
			
			/* Custom dialog styles */
			#popup_container.style_1 {
				font-family: Georgia, serif;
				color: #A4C6E2;
				background: #005294;
				border-color: #113F66;
			}
			
			#popup_container.style_1 #popup_title {
				color: #FFF;
				font-weight: normal;
				text-align: left;
				background: #76A5CC;
				border: solid 1px #005294;
				padding-left: 1em;
			}
			
			#popup_container.style_1 #popup_content {
				background: none;
			}
			
			#popup_container.style_1 #popup_message {
				padding-left: 0em;
			}
			
			#popup_container.style_1 INPUT[type='button'] {
				border: outset 2px #76A5CC;
				color: #A4C6E2;
				background: #3778AE;
			}
			
		</style>
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
//            document.getElementById("<%= btnEmpty.ClientID %>").click(function () {
//                   jConfirm('Can you confirm this?', 'Confirmation Dialog', function (r) {
//                            jAlert('Confirmed: ' + r, 'Confirmation Results');
//                    
//                });
//            });
//            $("<%= btnEmpty.ClientID %>").click(function () {
//                   jConfirm('Can you confirm this?', 'Confirmation Dialog', function (r) {
//                    jAlert('Confirmed: ' + r, 'Confirmation Results');
//               
//                });
//            });
           
        });

        function Confirm() {
            msg = "<%= Msg() %> ";
            jConfirm('Do you want is empty?', 'Empty Trash', function (r) {
                if (r == true)
                     result = confirm(msg);
            });
            return false;
        }

     
        function Click() {
            jAlert('This is a custom alert box', 'Alert Dialog');
        }

        function Clicked() {
            jAlert('Khong thuc thi duoc', 'Alert Dialog');
        }

    </script>
  <%--  <script type="text/javascript">
        function newpage() {
            location.href = 'home.aspx'; //Mở 1 trang mới có địa chỉ là b.html
        }
        setTimeout("newpage()", 5000); //Goi hàm "newpage" sau 1 giây
    </script>--%>
</head>
<body>
    <form id="form1" runat="server">
    <fieldset>
        <legend>Alert</legend>
        <pre>jAlert('This is a custom alert box', 'Alert Dialog');</pre>
        <p>
            <input id="alert_button1" type="button" onclick="Click()" value="Show Alert">

        </p>
    </fieldset>

    <asp:button ID="Button1" runat="server" text="Button" onclick="Button1_Click" />
    <asp:button ID="btnEmpty" runat="server" text="Empty" onclick="btnEmpty_Click"  OnClientClick="return Confirm();"
        />
    </form>
</body>

</html>
