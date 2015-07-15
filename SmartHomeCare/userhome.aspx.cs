using System;
using System.Collections.Generic;
using System.Linq;
using System.Data;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Drawing;
public partial class userhome : System.Web.UI.Page
{
    private DBClass _db = new DBClass();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["User"] == null)
        {
            Response.Redirect("home.aspx");
        }
        //siteuser _siteuser = (siteuser)this.Master;
        //TreeView treeview = _siteuser.treeview;
        //BaseView.SelectedTreeView(treeview, siteuser.HOME);

        if (!IsPostBack)
        {
            DataRow userrow = (DataRow)Session["User"];
            int j = _db.GetCount_EmailAlarm_ByUserName(BaseView.GetStringFieldValue(userrow, "Username"));
            
            int i = _db.GetCount_EmailNew_ByUserName(BaseView.GetStringFieldValue(userrow, "Username"));
            
            lbMessage.Text = "New message notification " + " (" + i.ToString() + " items)";
            lbalarm.Text = "New alarm notification" + " (" + j.ToString() + " items)";
            if (i > 0)
            {
                lbMessage.ForeColor = ColorTranslator.FromHtml("Red");
                lbnew.Text = "<img class='msg_img_new' src='resources/images/new.gif' />";
            }
            if (j > 0)
            {
                lbalarm.ForeColor = ColorTranslator.FromHtml("Red");
                lbnew_alarm.Text = "<img class='msg_img_new' src='resources/images/new.gif' />";
            }
        }
    }
}