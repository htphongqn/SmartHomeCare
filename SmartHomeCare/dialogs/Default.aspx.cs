using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class _Default : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        Response.Cache.SetExpires(DateTime.Now.AddDays(-1));
        Response.Cache.SetCacheability(HttpCacheability.NoCache);
        Response.Cache.SetValidUntilExpires(false);
        string msg = DBClass.GetMessageByCode2("forgot_username_success");
        //MessagesBox.jQueryShow(ClientScript, this.GetType(), msg, "Notification message");
        
       // ClientScript.RegisterStartupScript(this.GetType(), "onload", "jAlert('" + msg + "','" + msg + "');", true);
    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        string Message="Day la message";
        string title="Day la title";
        string a = "1212";
        if (a == "1212")
        {
            ClientScript.RegisterStartupScript(this.GetType(), "onload", "jAlert('" + Message + "','" + title + "');", true);
        }
        else
        {
            //Clicked
            ClientScript.RegisterStartupScript(this.GetType(), "onload", "Clicked();", true);
        }
    }
    public string Msg()
    {
       
        return "thanh cong";
    }
    protected void btnEmpty_Click(object sender, EventArgs e)
    {
        ClientScript.RegisterStartupScript(this.GetType(), "onload", "Clicked();", true);
        //ClientScript.RegisterStartupScript(this.GetType(), "onload", " jConfirm('Do you want is empty?', 'Empty Trash',true);", true);
    }
}