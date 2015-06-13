using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

public partial class useralarmmessages : System.Web.UI.Page
{
    private DBClass _db = new DBClass();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["User"] != null)
        {
            LoadAlarmMessage();
        }
        else
        {
            Response.Redirect("~/home.aspx");
        }
        if (!IsPostBack)
        {
            siteuser _siteuser = (siteuser)this.Master;
            TreeView treeview = _siteuser.treeview;
            BaseView.SelectedTreeView(treeview, siteuser.MESSAGECENTER, siteuser.ALARMMESSAGES);
        }
    }

    private void LoadAlarmMessage()
    {
        DataRow row = (DataRow)Session["User"];
        if (row != null)
        {
            string UserName = BaseView.GetStringFieldValue(row, "UserName");
            DataTable dt = _db.GetList_MessageCenter_Alarm(UserName);
            grvAlarmBox.DataSource = dt;
            grvAlarmBox.DataBind();
        }
    }
}