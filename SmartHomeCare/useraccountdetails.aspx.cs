using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
public partial class useraccountdetails : System.Web.UI.Page
{
    DBClass _db = new DBClass();
    DataTable dt = new DataTable();
    string AccountNumber = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        //siteuser _siteuser = (siteuser)this.Master;
        //TreeView treeview = _siteuser.treeview;
        //BaseView.SelectedTreeView(treeview, siteuser.MYACCOUNT, siteuser.BILLINGACCOUNTSUMMAR);

        if (Session["Account"] == null)
            Response.Redirect("~/userbillingaccountsummar.aspx");
        else
        {
            DataTable dt = (DataTable)Session["Account"];
            if (dt.Rows.Count > 0)
            {
                DataRow row = dt.Rows[0];
                AccountNumber = row["AccountNumber"].ToString();
            }
        }
        if (!IsPostBack)
        {
            ShowData();
        }
    }
    void ShowData()
    {


        lbAmountDue.Text = "$" + _db.Get_TotalAmountDue_ByAccountNumber(AccountNumber);
        dt = _db.GetList_BillingAccountDetails(AccountNumber);
        grdDetailAccount.DataSource = dt;
        grdDetailAccount.DataBind();
    }
}