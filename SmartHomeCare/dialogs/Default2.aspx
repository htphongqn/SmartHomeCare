<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default2.aspx.cs" Inherits="dialogs_Default2" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <script src="jquery1.2.6.js" type="text/javascript"></script>
    <script src="jquery.ui.draggable.js" type="text/javascript"></script>
    <script src="jquery.alerts.js" type="text/javascript"></script>
    <link href="jquery.alerts.css" rel="stylesheet" type="text/css" />
    <link href="http://netdna.bootstrapcdn.com/twitter-bootstrap/2.3.2/css/bootstrap-combined.min.css" rel="stylesheet">
    <script src="http://code.jquery.com/jquery-1.9.1.min.js"></script>
 <script type="text/javascript">
     $(function () {
         $("#delete-transfer-confirm").dialog({
             autoOpen: false,
             modal: true
         });

         $('.delete').click(function (e) {
             e.preventDefault();
             $('#delete-transfer-confirm').dialog({
                 buttons: {
                     'Confirm': function () {
                         $(this).dialog('close');
                         return true;
                     },
                     'Cancel': function () {
                         $(this).dialog('close');
                         return false;
                     }
                 }
             });

             $('p.message').text($(this).attr('rel'));
             $('#delete-transfer-confirm').dialog('open');
         });
     });

    </script>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    <asp:button ID="btnEmpty" runat="server" text="Empty"  OnClientClick="return Confirm();"
        />
    </div>
    <input type="submit" class="action-link delete" id="ctl00_c1_gvTransfers_ctl02_btnDelete" onclick="try{if (!window.confirm('Are you sure?')){return false;};}catch(e1){alert(&quot;Unexpected Error:\n\n&quot; + e1.toString());return false;};" value="Delete" name="ctl00$c1$gvTransfers$ctl02$btnDelete">
    </form>
</body>
</html>
