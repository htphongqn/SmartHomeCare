using System.Collections.Generic;
using System.Linq;
using System;
using System.Text;
using System.Collections;
using System.Web;
using System.Web.UI;
using System.Web.Script.Services;

/**
 * \brief messages box use for project
 * */
public class MessagesBox
{
	public MessagesBox()
	{

	}

    protected static Hashtable handlerPages = new Hashtable();
    /**
     * [jQueryShow] Show messages with jquery.
     **/
    public static void jQueryShow(ClientScriptManager clientScript, Type type, string Message, string title)
    {
        clientScript.RegisterStartupScript(type, "onload", " jAlert('" + Message + "','" + title + "'); setTimeout('reloadpage()', 3000); ", true);
    }
    private static void CurrentPageUnload(object sender, EventArgs e)
    {
        Queue queue = ((Queue)(handlerPages[HttpContext.Current.Handler]));
        if (queue != null)
        {
            StringBuilder builder = new StringBuilder();
            int iMsgCount = queue.Count;
            builder.Append("<script language='javascript'>");
            string sMsg;
            while ((iMsgCount > 0))
            {
                iMsgCount = iMsgCount - 1;
                sMsg = System.Convert.ToString(queue.Dequeue());
                sMsg = sMsg.Replace("\"", "'");
                builder.Append("alert( \"" + sMsg + "\" );");
            }
            builder.Append("</script>");
            handlerPages.Remove(HttpContext.Current.Handler);
            HttpContext.Current.Response.Write(builder.ToString());
        }
    }

    /**
     * [Messages Box Nomal] Show Messages box normal
     * */
    public static void Show(string Message)
    {
        HttpContext.Current.Response.Write("<script>alert('" + Message + "') ; window.location.href='" + HttpContext.Current.Request.Url.PathAndQuery + "' </script>");
    }
}