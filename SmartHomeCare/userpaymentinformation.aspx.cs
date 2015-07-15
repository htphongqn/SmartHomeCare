using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
public partial class userpaymentinformation : System.Web.UI.Page
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
        dt = _db.GetList_BillingPayments(AccountNumber);
        grdInfo.DataSource = dt;
        grdInfo.DataBind();
    }
    int total = 0;
    protected void grdInfo_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            Label lbAmount = (Label)e.Row.FindControl("lbAmount");
            int quantity = Convert.ToInt32(DataBinder.Eval(e.Row.DataItem, "AmountPay"));
            total += quantity;
        }
        if (e.Row.RowType == DataControlRowType.Footer)
        {
            Label lbTotal = (Label)e.Row.FindControl("lbTotal");
            decimal totals = Convert.ToDecimal(total);
            lbTotal.Text = "$" + totals.ToString();
        }
    }
}