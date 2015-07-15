using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
public partial class userpaymentreview : System.Web.UI.Page
{
    DBClass _db = new DBClass();
    DataTable dt = new DataTable();
    string Username = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        //siteuser _siteuser = (siteuser)this.Master;
        //TreeView treeview = _siteuser.treeview;
        //BaseView.SelectedTreeView(treeview, siteuser.MYACCOUNT, siteuser.BILLINGACCOUNTSUMMAR);
        DataRow row = (DataRow)Session["User"];
        //if (row == null)
        //    Response.Redirect("~/home.aspx");
        //else
        //{
        //    Username = row["username"].ToString();
        //}
        if (!IsPostBack)
        {
            LoadData();
        }
    }
    void LoadData()
    {
        if (Session["table"] != null)
        {
            dt = (DataTable)Session["table"];
            if (dt.Rows.Count > 0)
            {
                DataRow dr = dt.Rows[0];

                string address = dr["Address"].ToString() + ", " + dr["AddressLine"].ToString() + ", " + dr["City"].ToString() + ", ";
                address += dr["State"].ToString() + ", " + dr["ZipCode"].ToString() + ", " + dr["Country"].ToString();
                string email = dr["Email"].ToString();
                string nameoncard = dr["NameCard"].ToString();
                string phone = dr["Phone"].ToString();
                string AccountNumber = dr["AccountNumber"].ToString();
                decimal AmountPay = Decimal.Parse(dr["AmountPay"].ToString());
                string AccountType = dr["AccountType"].ToString();
                string AmountDue = dr["AmountDue"].ToString();
                string card = dr["card"].ToString();
                lbAcountNumber.Text = AccountNumber;
                lbAccountType.Text = card;
                lbAmountDue.Text = AmountDue;
                lbAmountPay.Text = AmountPay.ToString();
                lbName.Text = nameoncard;
                lbAddress.Text = address;
                lbPhone.Text = phone;
                lbEmail.Text = email;
                lbPay.Text = dr["CardNumber"].ToString();
            }
        }
    }
    protected void btnsubmit_Click(object sender, EventArgs e)
    {
        dt = (DataTable)Session["table"];
        string Id = "";
        if (dt.Rows.Count > 0)
        {
            DataRow dr = dt.Rows[0];

            string address = dr["Address"].ToString();
            string addressline = dr["AddressLine"].ToString();
            string cardnumber = dr["CardNumber"].ToString();
            string city = dr["City"].ToString();
            string email = dr["Email"].ToString();
            string nameoncard = dr["NameCard"].ToString();
            string phone = dr["Phone"].ToString();
            string securitycode = dr["Code"].ToString();
            string zipcode = dr["ZipCode"].ToString();
            int cardtype = Int32.Parse(dr["CardType"].ToString());
            string country = dr["Country"].ToString();
     
            string state = dr["State"].ToString();
       
            string AccountNumber = dr["AccountNumber"].ToString();
            
            string month =dr["Month"].ToString();
            string year = dr["Year"].ToString();
            decimal AmountPay = Decimal.Parse(dr["AmountPay"].ToString());
            string AccountType = dr["AccountType"].ToString(); ;
            string AmountDue = dr["AmountDue"].ToString(); ;
            Id = _db.Insert_BillingInfo(nameoncard, address, addressline, city, state, zipcode, country, phone, email, cardtype, cardnumber, month,year, securitycode, AccountNumber, AmountPay);
        }
        Response.Redirect("~/userpayment_receipt.aspx?Id="+Id);
    }
}