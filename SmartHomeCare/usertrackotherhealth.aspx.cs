using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
public partial class usertrackmyhealth : System.Web.UI.Page
{
    DBClass _db = new DBClass();
    DataTable dt = new DataTable();   
    protected void Page_Load(object sender, EventArgs e)
    {
        siteuser _siteuser = (siteuser)this.Master;
        TreeView treeview = _siteuser.treeview;
        BaseView.SelectedTreeView(treeview, siteuser.REPORTS, siteuser.TRACKOTHERS);

        if (Session["User"] == null)
        {
            Response.Redirect("~/home.aspx");
        }
        if (Session["AuthorizedUser"] == null)
        {
            Response.Redirect("~/usertrackothers.aspx");
        }

        if (!IsPostBack)
        {
            DataRow rowcurrentuser = (DataRow)Session["AuthorizedUser"];
            lbcurrentuser.Text = BaseView.GetStringFieldValue(rowcurrentuser, "FullName");
        }
    }
    protected void btnglobalsettings_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/usertrackothers_globalsetting.aspx");       
    }
    protected void ibtn_Click1(object sender, ImageClickEventArgs e)
    {
        Response.Redirect("~/usertrackother_temperature.aspx");
    }
}