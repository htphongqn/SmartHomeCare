using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Text.RegularExpressions;
/** 
 * User compose 
 * */
public partial class usercompose : System.Web.UI.Page
{
    private DBClass db = new DBClass();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["User"] == null)
        {
            Response.Redirect("~/home.aspx");
        }
        else
        {
            LoadUserInfo();
        }
        if (!IsPostBack)
        {
            siteuser _siteuser = (siteuser)this.Master;
            TreeView treeview = _siteuser.treeview;
            BaseView.SelectedTreeView(treeview, siteuser.MESSAGECENTER, siteuser.COMPOSE);
        }
    }

    [System.Web.Services.WebMethod]
    public static object SendMailToUser(object[] args)
    {
        Dictionary<string, object> values = (Dictionary<string, object>)((object[])args)[0];
        string MailTo = values["MailTo"].ToString();
        string Subject = values["Subject"].ToString();
        string Content = values["Content"].ToString();
        return 0;
    }

    private void LoadUserInfo()
    {
        DataRow row = (DataRow)Session["User"];
        if (row != null)
        {
            string Name = BaseView.GetStringFieldValue(row, "FirstName") + " " + BaseView.GetStringFieldValue(row, "LastName");
            txtMailFrom.Text = Name;
           
        }
    }

    protected void btnSend_Click(object sender, EventArgs e)
    {
        DataRow dr = (DataRow)Session["User"];
        string MailFrom = BaseView.GetStringFieldValue(dr, "Username");
        string Message = txtMessage.Text.Replace("\r\n", "</br>");
        DataRow row = db.Insert_MessageCenter(MailFrom, txtSubject.Text, txtMailTo.Text, Message);
        if (BaseView.GetBooleanFieldValue(row,"IsOK"))
        {
            bool a = BaseView.GetBooleanFieldValue(row, "IsOK");
            Response.Redirect("~/userinbox.aspx");
        }
        else
        {
            MessagesBox.jQueryShow(ClientScript, this.GetType(), DBClass.GetMessageByCode2("user_not_exist"), "Messages Box");
        }
    }
}