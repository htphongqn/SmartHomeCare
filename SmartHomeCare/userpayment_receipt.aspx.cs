using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
public partial class userpaymentreceipt : System.Web.UI.Page
{
    DBClass _db = new DBClass();
    protected void Page_Load(object sender, EventArgs e)
    {
        //siteuser _siteuser = (siteuser)this.Master;
        //TreeView treeview = _siteuser.treeview;
        //BaseView.SelectedTreeView(treeview, siteuser.MYACCOUNT, siteuser.BILLINGACCOUNTSUMMAR);

        if (Session["User"] == null)
        {
            Response.Redirect("~/home.aspx");
        }
        DataRow row = (DataRow)Session["User"];
        if (!IsPostBack)
        {
            LoadInfo();
        }
    }
    private void LoadInfo()
    {   string Id = Request.QueryString["Id"];
        if (!String.IsNullOrEmpty(Id))
        {
            DataTable dt = _db.GetInfo_BillingInfo_ById(Id);
            if (dt.Rows.Count > 0)
            {
                DataRow dr = dt.Rows[0];

                string address = dr["Address"].ToString() + ", " + dr["AddressLine2"].ToString() + ", " + dr["City"].ToString() + ", ";
                address += dr["StateCode"].ToString() + ", " + dr["ZipCode"].ToString() + ", " + dr["CountryCode"].ToString();
                string email = dr["Email"].ToString();
                string nameoncard = dr["NameCard"].ToString();
                string phone = dr["Phone"].ToString();
                string AccountNumber = dr["AccountNumber"].ToString();
                decimal AmountPay = Decimal.Parse(dr["AmountPay"].ToString());
                string AccountType = dr["CardType"].ToString();
                string AmountDue = dr["AmountDue"].ToString();
                string cardNumber = dr["CardNumber"].ToString();
                if (cardNumber.Length > 4)
                {
                    cardNumber ="xxxxxxxxxx" + cardNumber.Substring(cardNumber.Length - 4);
                }
                lbAcountNumber.Text = AccountNumber;
                lbAccountType.Text = AccountType;
                lbAmountDue.Text = AmountDue;
                lbAmountPay.Text = AmountPay.ToString();
                lbName.Text = nameoncard;
                lbAddress.Text = address;
                lbPhone.Text = phone;
                lbEmail.Text = email;
                lbPay.Text = cardNumber;
            }
            lbtitle.Visible = false;
            lbtitleid.Text = "Pay ID : " + Id;
        }
    }
}