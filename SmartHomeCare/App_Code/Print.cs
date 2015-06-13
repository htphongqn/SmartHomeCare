using System;

using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Text;

/// <summary>
/// Summary description for Print
/// </summary>
public class Print
{
	public Print()
	{
		//
		// TODO: Add constructor logic here
		//
	}
    public void CallFunctionScript(ClientScriptManager clientScript, Type type, string functionName)
    {
        clientScript.RegisterStartupScript(type, "", "<script language='JavaScript'>"+functionName+";</script>");
    }
    public void PrintCurrentPage(ClientScriptManager clientScript, Type type, GridView GridView1)
    {
        GridView1.PagerSettings.Visible = false;
        GridView1.DataBind();
        StringWriter sw = new StringWriter();
        HtmlTextWriter hw = new HtmlTextWriter(sw);
        GridView1.RenderControl(hw);
        string gridHTML = sw.ToString().Replace("\"", "'")
            .Replace(System.Environment.NewLine, "");
        StringBuilder sb = new StringBuilder();
        sb.Append("<script type = 'text/javascript'>");
        sb.Append("window.onload = new function(){");
        sb.Append("var printWin = window.open('', '', 'left=0");
        sb.Append(",top=0,width=1000,height=600,status=0');");
        sb.Append("printWin.document.write(\"");
        sb.Append(gridHTML);
        sb.Append("\");");
        sb.Append("printWin.document.close();");
        sb.Append("printWin.focus();");
        sb.Append("printWin.print();");
        sb.Append("printWin.close();};");
        sb.Append("</script>");

        clientScript.RegisterStartupScript(type, "GridPrint", sb.ToString());
        GridView1.PagerSettings.Visible = true;
        GridView1.DataBind();
    }

    public void PrintAllPages(ClientScriptManager clientScript, Type type,GridView GridView1)
    {

        GridView1.AllowPaging = false;
        GridView1.DataBind();
        StringWriter sw = new StringWriter();
        HtmlTextWriter hw = new HtmlTextWriter(sw);
        GridView1.RenderControl(hw);
        string gridHTML = sw.ToString().Replace("\"", "'")
            .Replace(System.Environment.NewLine, "");
        StringBuilder sb = new StringBuilder();
        sb.Append("<script type = 'text/javascript'>");
        sb.Append("window.onload = new function(){");
        sb.Append("var printWin = window.open('', '', 'left=0");
        sb.Append(",top=0,width=1000,height=600,status=0');");
        sb.Append("printWin.document.write(\"");
        sb.Append(gridHTML);
        sb.Append("\");");
        sb.Append("printWin.document.close();");
        sb.Append("printWin.focus();");
        sb.Append("printWin.print();");
        sb.Append("printWin.close();};");
        sb.Append("</script>");
        clientScript.RegisterStartupScript(type, "GridPrint", sb.ToString());
        GridView1.AllowPaging = true;
        GridView1.DataBind();
    }
}