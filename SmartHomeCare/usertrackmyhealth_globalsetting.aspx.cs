using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
public partial class usertrackmyhealth_globalsetting : System.Web.UI.Page
{
    DBClass _db = new DBClass();
    DataTable dt = new DataTable();
    protected void Page_Load(object sender, EventArgs e)
    {
        //siteuser _siteuser = (siteuser)this.Master;
        //TreeView treeview = _siteuser.treeview;
        //BaseView.SelectedTreeView(treeview, siteuser.REPORTS, siteuser.TRACKMYHEALTH);

        if (Session["User"] == null)
        {
            Response.Redirect("~/home.aspx");
        }
        if (!IsPostBack)
        {
            ShowGlobal();
        }
    }
    protected void btnedit_Click(object sender, EventArgs e)
    {
       
    }
    protected void btnsave_Click(object sender, EventArgs e)
    {
        DataRow row = (DataRow)Session["User"];
        
        string Username = row["username"].ToString();

        bool Metric =rdmetric.Checked;
        bool Us = rdus.Checked;

        _db.InsertUpdate_UserTrackMyHealth_Measurement(Username,Metric,Us);
        //MessagesBox.jQueryShow(ClientScript, this.GetType(), DBClass.GetMessageByCode2("edit_success"), "Edit message");
        Response.Redirect("~/usertrackmyhealth.aspx");

    }
    void ShowGlobal()
    {
        DataRow row= (DataRow)Session["User"];
        string Username = row["username"].ToString();
        string Us = "";
        DataRow dr = _db.GetInfo_UserTrackMyHealth_Measurement(Username);
        if(dr!= null)
        {
             Us = Convert.ToString(dr["IsUS"].ToString());
        }
        if (Us.ToLower()== "true")
        {
            rdus.Checked = true;
            rdmetric.Checked = false;
        }
        else {
            rdmetric.Checked = true;
            rdus.Checked = false;
        }
    }

    protected void btncancel_Click(object sender, EventArgs e)
    {
    }
}