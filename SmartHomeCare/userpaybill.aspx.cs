using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
public partial class userpaybill : System.Web.UI.Page
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
        if (row == null)
            Response.Redirect("~/home.aspx");
        else
        {
            Username = row["username"].ToString();
        }
        if (!IsPostBack)
        {
            LoadCountry();
            LoadState("");
            LoadCard();
            Date();
            ShowData();
        }
    }
    protected void btncontinue_Click(object sender, EventArgs e)
    {

        Session["table"] = GetTable();
        Response.Redirect("~/userpayment_review.aspx");
        
    }
    private void LoadCountry()
    {
        DataSet ds = _db.GetList_Countries();
        if (ds != null && ds.Tables.Count > 0)
        {
            BaseView.BindDataToDropdownList(ddlcountry, ds.Tables[0]);
        }
    }
    private void LoadState(string countrycode)
    {
        DataSet ds = _db.GetList_CountryStates_ByCountryCode(countrycode);
        if (ds != null && ds.Tables.Count > 0)
        {
            BaseView.BindDataToDropdownList(ddlstate, ds.Tables[0]);
        }
    }
    private void LoadCard()
    {
        DataSet ds = _db.GetList_CreditCardType();
        if (ds != null && ds.Tables.Count > 0)
        {
            BaseView.BindDataToDropdownList(ddlcardtype, ds.Tables[0]);
        }
    }
    private void Date()
    {
        ddlmmexpirationdate.Items.Add("");
        for (int i = 1; i < 13; i++)
            ddlmmexpirationdate.Items.Add(i.ToString());

        ddlyyexpirationdate.Items.Add("");
        for (int i = DateTime.Now.Year; i < DateTime.Now.Year + 25; i++)
        {
            ddlyyexpirationdate.Items.Add(i.ToString());
        }
    }
    protected void ddlcountry_SelectedIndexChanged(object sender, EventArgs e)
    {
        LoadState(ddlcountry.SelectedValue);
    }
    private void ShowData()
    {
        DataRow dr = _db.GetInfo_PayBill_CreditCard(Username);
        if (dr != null)
        {
            int AmountDue = 0;
            lbAccountNumber.Text = dr["Accountnumber"].ToString();
            //lbAccountNumber.Text = BaseView.GetStringFieldValue(dr, "Accountnumber");
            lbAccountType.Text = BaseView.GetStringFieldValue(dr, "AccountType");
            lbAmountDue.Text = BaseView.GetStringFieldValue(dr, "AccountDue");
            AmountDue = ToSQL.SQLToInt(lbAmountDue.Text);
            if( AmountDue < 0)
            {
                AmountDue = AmountDue*(-1);
            }
            txtAmountPay.Text = AmountDue.ToString();
        }
    }
    private DataTable GetTable()
    {
        string address = txtaddress.Text;
        string addressline = txtaddressline.Text;
        string cardnumber = txtcardnumber.Text;
        string city = txtciy.Text;
        string email = txtemailaddress.Text;
        string nameoncard = txtnameoncard.Text;
        string phone = txtphone.Text;
        string securitycode = txtsecuritycode.Text;
        string zipcode = txtzipcode.Text;
        int cardtype = Int32.Parse(ddlcardtype.SelectedValue);
        string country = ddlcountry.SelectedValue;
        string mmexpirationdate = ddlmmexpirationdate.SelectedValue;
        string state = ddlstate.SelectedValue;
        string expirationdate = ddlyyexpirationdate.SelectedValue;
        string AccountNumber = lbAccountNumber.Text;
        
        decimal AmountPay = Decimal.Parse(txtAmountPay.Text);
        string AccountType = ddlcardtype.SelectedValue;
        string card = ddlcardtype.SelectedItem.Text;
        string AmountDue = lbAmountDue.Text;
        string code = txtsecuritycode.Text;
        DataTable table = new DataTable();
        table.Columns.Add("AccountNumber", typeof(string));
        table.Columns.Add("AccountType", typeof(string));
        table.Columns.Add("AmountDue", typeof(string));
        table.Columns.Add("AmountPay", typeof(string));
        table.Columns.Add("NameCard", typeof(string));
        table.Columns.Add("Address", typeof(string));
        table.Columns.Add("AddressLine", typeof(string));
        table.Columns.Add("City", typeof(string));
        table.Columns.Add("State", typeof(string));
        table.Columns.Add("ZipCode", typeof(string));
        table.Columns.Add("Country", typeof(string));
        table.Columns.Add("Phone", typeof(string));
        table.Columns.Add("Email", typeof(string));
        table.Columns.Add("CardType", typeof(string));
        table.Columns.Add("CardNumber", typeof(string));
        table.Columns.Add("Month", typeof(string));
        table.Columns.Add("Year", typeof(string));
        table.Columns.Add("Code", typeof(string));
        table.Columns.Add("card", typeof(string));
        table.Rows.Add(AccountNumber,AccountType,AmountDue,AmountPay,nameoncard,address,addressline,city,state,zipcode,country,phone,email,cardtype,cardnumber,mmexpirationdate,expirationdate,code,card);
       
        return table;
    }
    protected void lbtnprint_Click(object sender, EventArgs e)
    {
        
    }
}