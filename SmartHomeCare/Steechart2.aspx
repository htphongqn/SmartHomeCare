<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Steechart2.aspx.cs" Inherits="Steechart2" %>

<%@ Register assembly="TeeChart" namespace="Steema.TeeChart.Web" tagprefix="tchart" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
        <tchart:WebChart ID="WebChart1" runat="server" AutoPostback="False" 
            GetChartFile="GetChart.aspx" Height="400px" TempChart="Session" 
            Width="600px" 
            
            
            
            Config="AAEAAAD/////AQAAAAAAAAAMAgAAAFJUZWVDaGFydCwgVmVyc2lvbj00LjEuMjAxMy4xMTA4NiwgQ3VsdHVyZT1uZXV0cmFsLCBQdWJsaWNLZXlUb2tlbj05YzgxMjYyNzZjNzdiZGI3BQEAAAAVU3RlZW1hLlRlZUNoYXJ0LkNoYXJ0JQAAABAuQ3VzdG9tQ2hhcnRSZWN0Dy5MZWdlbmQuVmlzaWJsZRkuQXNwZWN0LkNvbG9yUGFsZXR0ZUluZGV4EC5Bc3BlY3QuSGVpZ2h0M0QPLkFzcGVjdC5XaWR0aDNEDi5Bc3BlY3QuVmlldzNEEi5BeGVzLk51bUZpeGVkQXhlcxMuQXhlcy5MZWZ0LklHYXBTaXplFC5BeGVzLkxlZnQuSVN0YXJ0UG9zEi5BeGVzLkxlZnQuSUVuZFBvcxQuQXhlcy5MZWZ0LklBeGlzU2l6ZRYuQXhlcy5MZWZ0LklzRGVwdGhBeGlzEi5BeGVzLlRvcC5JR2FwU2l6ZRMuQXhlcy5Ub3AuSVN0YXJ0UG9zES5BeGVzLlRvcC5JRW5kUG9zEy5BeGVzLlRvcC5JQXhpc1NpemUVLkF4ZXMuVG9wLklzRGVwdGhBeGlzFC5BeGVzLlJpZ2h0LklHYXBTaXplFS5BeGVzLlJpZ2h0LklTdGFydFBvcxMuQXhlcy5SaWdodC5JRW5kUG9zFS5BeGVzLlJpZ2h0LklBeGlzU2l6ZRcuQXhlcy5SaWdodC5Jc0RlcHRoQXhpcxUuQXhlcy5Cb3R0b20uSUdhcFNpemUWLkF4ZXMuQm90dG9tLklTdGFydFBvcxQuQXhlcy5Cb3R0b20uSUVuZFBvcxYuQXhlcy5Cb3R0b20uSUF4aXNTaXplGC5BeGVzLkJvdHRvbS5Jc0RlcHRoQXhpcxcuQXhlcy5EZXB0aFRvcC5JR2FwU2l6ZRguQXhlcy5EZXB0aFRvcC5JU3RhcnRQb3MWLkF4ZXMuRGVwdGhUb3AuSUVuZFBvcxguQXhlcy5EZXB0aFRvcC5JQXhpc1NpemUaLkF4ZXMuRGVwdGhUb3AuSXNEZXB0aEF4aXMULkF4ZXMuRGVwdGguSUdhcFNpemUVLkF4ZXMuRGVwdGguSVN0YXJ0UG9zEy5BeGVzLkRlcHRoLklFbmRQb3MVLkF4ZXMuRGVwdGguSUF4aXNTaXplFy5BeGVzLkRlcHRoLklzRGVwdGhBeGlzAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAEBCAgIAQgICAgIAQgICAgBCAgICAEICAgIAQgICAgBCAgICAECAAAAAAAAAAAAAAAAAAAAAAAABgAAAAAAAAA7AAAAawEAADABAAAAAAAAABkAAAA/AgAAJgIAAAAAAAAAOwAAAGsBAAAwAQAAAAAAAAAZAAAAPwIAACYCAAAAAAAAAAAAAAAAAAAAAAAAAAEAAAAAAAAAAAAAAAAAAAAAAQs=" />
    
        <br />
    
    </div>
    </form>
</body>
</html>
