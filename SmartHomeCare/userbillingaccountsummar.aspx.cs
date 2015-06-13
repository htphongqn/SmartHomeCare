using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
public partial class userbillingaccountsummar : System.Web.UI.Page
{
    DBClass _db = new DBClass();
    string Username = "";
    DataTable dt = new DataTable();
    protected void Page_Load(object sender, EventArgs e)
    {
        siteuser _siteuser = (siteuser)this.Master;
        TreeView treeview = _siteuser.treeview;
        BaseView.SelectedTreeView(treeview, siteuser.MYACCOUNT, siteuser.BILLINGACCOUNTSUMMAR);
        DataRow row = (DataRow)Session["User"];
        if (row == null)
            Response.Redirect("~/home.aspx");
        else
        {
            Username = row["username"].ToString();
        }
        if (!IsPostBack)
        {
            ShowData();
        }
    }
    void ShowData()
    {
        dt = _db.GetInfo_BillingAccounts(Username);
        
        GridView1.DataSource = dt;
        GridView1.DataBind();
        Session["Account"] = dt;
    }
    protected void btnseemorepayments_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/userpaymentinformation.aspx");
    }
}