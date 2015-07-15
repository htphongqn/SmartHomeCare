using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
public partial class usertrackothers_globalsetting : System.Web.UI.Page
{
    DBClass _db = new DBClass();
    DataTable dt = new DataTable();
    string Username = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            //siteuser _siteuser = (siteuser)this.Master;
            //TreeView treeview = _siteuser.treeview;
            //BaseView.SelectedTreeView(treeview, siteuser.REPORTS, siteuser.TRACKOTHERS);
            DataRow row = (DataRow)Session["User"];
            if (row == null)
            {
                Response.Redirect("~/home.aspx");
            }
            if (Session["AuthorizedUser"] == null)
            {
                Response.Redirect("~/usertrackothers.aspx");
            }
            else
            {
                ShowGlobal();
                ShowData();
            }
        }
        
    }
    protected void btnedit_Click(object sender, EventArgs e)
    {

    }
    protected void btnsave_Click(object sender, EventArgs e)
    { 
        DataRow dr =(DataRow)Session["AuthorizedUser"];
        Username = BaseView.GetStringFieldValue(dr,"Username");
        bool Metric = rdmetric.Checked;
        bool Us = rdus.Checked;

        _db.InsertUpdate_UserTrackMyHealth_Measurement(Username, Metric, Us);
        //MessagesBox.jQueryShow(Page.ClientScript, this.GetType(), DBClass.GetMessageByCode2("edit_success"), "Edit message");
        Response.Redirect("~/usertrackotherhealth.aspx");
    }
    private void ShowGlobal()
    {
        DataRow dr = (DataRow)Session["AuthorizedUser"];
        Username = BaseView.GetStringFieldValue(dr, "Username");
        
        string Us = "";
        DataRow drs = _db.GetInfo_UserTrackMyHealth_Measurement(Username);
        if (drs != null)
        {
            Us = Convert.ToString(drs["IsUS"].ToString());
        }
        if (Us.ToLower() == "true")
        {
            rdus.Checked = true;
            rdmetric.Checked = false;
        }
        else
        {
            rdmetric.Checked = true;
            rdus.Checked = false;
        }
    }
    private void ShowData()
    {
        DataRow row = (DataRow)Session["AuthorizedUser"];
        Username = BaseView.GetStringFieldValue(row, "Username");
        lbNameHealth.Text = BaseView.GetStringFieldValue(row, "FullName");
        
    }
    protected void btncancel_Click(object sender, EventArgs e)
    {
        //Session["AuthorizedUser"] = null;
    }
}