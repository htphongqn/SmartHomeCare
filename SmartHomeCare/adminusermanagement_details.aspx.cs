using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Net;
public partial class adminusermanagement_details : System.Web.UI.Page
{
    private DBClass _db = new DBClass();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["User"] == null)
        {
            Response.Redirect("~/home.aspx");
        }
        siteadmin _siteadmin = (siteadmin)this.Master;
        TreeView treeview = _siteadmin.treeview;
        BaseView.SelectedTreeView(treeview, siteadmin.USERMANAGEMENT);
            
        if (!IsPostBack)
        {
            LoadOverview();
            IsEditOverview(false);
            LoadProfile();
            IsEditProfile(false);
            LoadPreferentces();  
            LoadPermission();
            
            LoadBillingtype();           
            
        }       
    }

    private void IsEditOverview(bool q)
    {
        txtUserName.Visible = false;
        lbUserName.Visible = !txtUserName.Visible;

        txtRegistered.Visible = false;
        lbRegistered.Enabled = false;

        txtIP.Visible = false;
        lbIP.Enabled = false;

        txtLastActive.Visible = false;
        lbLastActive.Enabled = false;

        txtWarning.Visible = q;
        lbWarning.Visible = !txtWarning.Visible;

        txtEmail.Visible = q;
        lbEmail.Visible = !txtEmail.Visible;

        txtConfirmEmail.Visible = q;
        lbConfirmEmail.Visible = !txtConfirmEmail.Visible;

        txtNewPassword.Visible = q;
        lbNewPassword.Visible = !txtNewPassword.Visible;

        txtConfirmPass.Visible = q;
        lbConfirmPass.Visible = !txtConfirmPass.Visible;
    }
    private void LoadOverview()
    {
        if (!String.IsNullOrEmpty(Request.QueryString["user"]))
        {
            string username = ToSQL.EmptyNull(Request.QueryString["user"]);
            DataRow dr = _db.GetInfo_UserOverview(username);
            if (dr != null)
            {
                txtUserName.Text = dr["Username"].ToString();
                lbUserName.Text = dr["Username"].ToString();

                txtRegistered.Text = dr["RegisteredDate"].ToString();
                lbRegistered.Text = dr["RegisteredDate"].ToString();

                txtIP.Text = dr["RegisteredIP"].ToString();
                lbIP.Text = dr["RegisteredIP"].ToString();

                txtLastActive.Text = dr["LastActive"].ToString();
                lbLastActive.Text = dr["LastActive"].ToString();

                txtWarning.Text = dr["Warning"].ToString();
                lbWarning.Text = dr["Warning"].ToString();

                txtEmail.Text = dr["EmailAddress"].ToString();
                lbEmail.Text = dr["EmailAddress"].ToString();

                txtConfirmEmail.Text = "";
                lbConfirmEmail.Text = "";

                txtNewPassword.Text = "";
                lbNewPassword.Text = "";

                txtConfirmPass.Text = "";
                lbConfirmPass.Text = "";
            }
        }        
    }
    private void IsEditProfile(bool q)
    {
        txtemailinfo.Visible = q;
        lbemailinfo.Visible = !txtemailinfo.Visible;

        txtfirstname.Visible = false;
        lbfirstname.Visible = !txtfirstname.Visible;
        txtlastname.Visible = false;
        lblastname.Visible = !txtlastname.Visible;
        txtdateofbirth.Visible = false;
        lbdateofbirth.Visible = !txtdateofbirth.Visible;
        rdmale.Visible = rdfemale.Visible = false;
        lbgender.Visible = !rdmale.Visible;

        txtaddress.Visible = q;
        lbaddress.Visible = !txtaddress.Visible;
        txtcity.Visible = q;
        lbcity.Visible = !txtcity.Visible;
        ddlstate.Visible = q;
        lbstate.Visible = !ddlstate.Visible;
        txtzipcode.Visible = q;
        lbzipcode.Visible = !txtzipcode.Visible;
        txtcounty.Visible = q;
        lbcounty.Visible = !txtcounty.Visible;
        ddlcountry.Visible = q;
        lbcountry.Visible = !ddlcountry.Visible;
        txthomephone.Visible = q;
        lbhomephone.Visible = !txthomephone.Visible;
        txtmobilephone.Visible = q;
        lbmobilephone.Visible = !txtmobilephone.Visible;
        ddlmembertype.Visible = false;
        lbmembertype.Visible = !ddlmembertype.Visible;
    }
    private void LoadProfile()
    {
        LoadCountry();
        LoadState("");
        LoadMemberType();
        if (!String.IsNullOrEmpty(Request.QueryString["user"]))
        {
            string username = ToSQL.EmptyNull(Request.QueryString["user"]);
            DataRow row = _db.GetInfo_UsersAll_ByUserName(username);

            if (row != null)
            {
                lbemailinfo.Text = txtemailinfo.Text = BaseView.GetStringFieldValue(row, "EmailAddress");
                lbfirstname.Text = txtfirstname.Text = BaseView.GetStringFieldValue(row, "FirstName");
                lblastname.Text = txtlastname.Text = BaseView.GetStringFieldValue(row, "LastName");
                lbdateofbirth.Text = txtdateofbirth.Text = BaseView.GetDateTimeFieldValue(row, "DateofBirth") == DateTime.MinValue ? "" : BaseView.GetDateTimeFieldValue(row, "DateofBirth").ToString("MM/dd/yyyy");
                if (BaseView.GetBooleanFieldValue(row, "IsGender"))
                {
                    lbgender.Text = "Male";
                    rdmale.Checked = true;
                }
                else
                {
                    lbgender.Text = "Female";
                    rdfemale.Checked = true;
                }
                lbaddress.Text = txtaddress.Text = BaseView.GetStringFieldValue(row, "StreetAddress");
                lbcity.Text = txtcity.Text = BaseView.GetStringFieldValue(row, "CityCode");

                lbzipcode.Text = txtzipcode.Text = BaseView.GetStringFieldValue(row, "ZipCode");
                lbcounty.Text = txtcounty.Text = BaseView.GetStringFieldValue(row, "County");
                lbcountry.Text = BaseView.GetStringFieldValue(row, "CountryName");
                ddlcountry.SelectedValue = BaseView.GetStringFieldValue(row, "CountryCode") == "" ? "0" : BaseView.GetStringFieldValue(row, "CountryCode");
                LoadState(ddlcountry.SelectedValue);
                lbstate.Text = BaseView.GetStringFieldValue(row, "StateName");
                ddlstate.SelectedValue = BaseView.GetStringFieldValue(row, "StateCode") == "" ? "0" : BaseView.GetStringFieldValue(row, "StateCode");
                lbhomephone.Text = txthomephone.Text = BaseView.GetStringFieldValue(row, "HomePhone");
                lbmobilephone.Text = txtmobilephone.Text = BaseView.GetStringFieldValue(row, "MobilePhone");
                lbmembertype.Text = BaseView.GetStringFieldValue(row, "RuleName");
                //ddlmembertype.SelectedValue = BaseView.GetStringFieldValue(row, "RuleCode") == "" ? "0" : BaseView.GetStringFieldValue(row, "RuleCode");
                HiddenRegistercode.Value = BaseView.GetStringFieldValue(row, "RegisterCode");
            }
        }
    }
    private void LoadPreferentces()
    {
        if (!String.IsNullOrEmpty(Request.QueryString["user"]))
        {
            string username = ToSQL.EmptyNull(Request.QueryString["user"]);
            DataRow dr = _db.GetInfo_UserTrackMyHealth_Measurement(username);
            if (dr != null)
            {
                bool us = BaseView.GetBooleanFieldValue(dr, "IsUS");

                if (us)
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
        }
    }
    private void LoadPermission()
    {
        DataRow row = (DataRow)Session["User"];
        string username = BaseView.GetStringFieldValue(row, "username");
        DataTable dt = _db.GetList_AuthorizedUser(username).Tables[0];
        BaseView.BindDataToListBox(lstuser, dt);
    }

    protected void btneditoverview_Click(object sender, EventArgs e)
    {
        IsEditOverview(true);
    }
    protected void btnsaveoverview_Click(object sender, EventArgs e)
    {
        if (!String.IsNullOrEmpty(Request.QueryString["user"]))
        {
            string username = ToSQL.EmptyNull(Request.QueryString["user"]);
            int i = _db.Update_UserOverview(username, txtUserName.Text, txtEmail.Text, txtWarning.Text, txtConfirmPass.Text);
            DataRow row = _db.GetMessageByCode("edit_success");
            string title = BaseView.GetStringFieldValue(row, "Title");
            ClientScript.RegisterStartupScript(this.GetType(), "onload", "jAlert('" + title + "','');", true);
            IsEditOverview(false);
            LoadOverview();
        }
    }
    protected void btncanceloverview_Click(object sender, EventArgs e)
    {
        IsEditOverview(false);
        LoadOverview();
    }
    protected void btneditprofile_Click(object sender, EventArgs e)
    {
        IsEditProfile(true);
    }
    protected void btnsaveprofile_Click(object sender, EventArgs e)
    {
        if (!String.IsNullOrEmpty(Request.QueryString["user"]))
        {
            string title = "";
            string username = ToSQL.EmptyNull(Request.QueryString["user"]);
            if (!_db.IsInvalid_EmailAddress(username, txtemailinfo.Text.Trim()))
            {
                title = "Email address unavailable";
                ClientScript.RegisterStartupScript(this.GetType(), "onload", "jAlert('" + title + "','');", true);
                return;
            }
            DateTime temp = new DateTime();
            DateTime? dateofbirth = null;
            bool isdate = DateTime.TryParse(txtdateofbirth.Text.Trim(), out temp);
            if (isdate)
                dateofbirth = temp;
            int i = _db.InsertUpdate_UsersInfo(username, txtfirstname.Text.Trim(), txtlastname.Text.Trim(), dateofbirth, rdmale.Checked, txtemailinfo.Text.Trim(),
                txtaddress.Text.Trim(), txtcity.Text.Trim(), ddlstate.SelectedValue, txtzipcode.Text.Trim(), txtcounty.Text.Trim(), ddlcountry.SelectedValue, txthomephone.Text, txtmobilephone.Text, HiddenRegistercode.Value);
            
            IsEditProfile(false);
            LoadProfile();

            DataRow row = _db.GetMessageByCode("edit_success");
            title = BaseView.GetStringFieldValue(row, "Title");
            ClientScript.RegisterStartupScript(this.GetType(), "onload", "jAlert('" + title + "','');", true);
        }
    }
    protected void btncancelprofile_Click(object sender, EventArgs e)
    {
        IsEditProfile(false);
        LoadProfile();
    }
    protected void btnsavepreferentces_Click(object sender, EventArgs e)
    {
        if (!String.IsNullOrEmpty(Request.QueryString["user"]))
        {
            string username = ToSQL.EmptyNull(Request.QueryString["user"]);
            bool Metric = true;
            bool Us = true;

            if (rdmetric.Checked)
            {
                Us = false;
            }
            else
            {
                Metric = false;
            }
            _db.InsertUpdate_UserTrackMyHealth_Measurement(username, Metric, Us);
            //MessagesBox.ShowF5(DBClass.GetMessageByCode2("edit_success"));
        }
    }

    private void LoadMemberType()
    {
        DataTable dt = _db.GetList_MemberType();
        BaseView.BindDataToDropdownList(ddlmembertype, dt);

    }
    private void LoadBillingtype()
    {
        DataTable dt = _db.GetList_BillingAccountTypes();
        BaseView.BindDataToDropdownList(ddlType, dt);
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
    protected void ddlcountry_SelectedIndexChanged(object sender, EventArgs e)
    {
        LoadState(ddlcountry.SelectedValue);
    }
  
    private string GetAccountNumber()
    {
        string username = "";
        if (!String.IsNullOrEmpty(Request.QueryString["user"]))
            username = Request.QueryString["user"];
        string account_number="";
        DataRow dr = _db.GetInfo_BillingAccounts_User(username);
        if(dr!=null)
            account_number = BaseView.GetStringFieldValue(dr, "AccountNumber");
        return account_number;
    }
    private void SaveBilling(bool IsAdd)
    {
        try
        {
            string accountNumber = GetAccountNumber();
            if (!String.IsNullOrEmpty(accountNumber))
            {
                DateTime? date = null;
                if (chkAuto.Checked && IsAdd == false)
                {
                    int billingtype = ToSQL.SQLToInt(ddlType.SelectedValue);
                    date = ToSQL.SQLToDateTime(txtDate.Text);
                    decimal amount = ToSQL.SQLToDecimal(txtAmount.Text);
                    string desciption = txtDescription.Text;
                    _db.Update_BillingAccount_Management(accountNumber, billingtype, date, amount, true, desciption);
                }
                if (IsAdd == true)
                {
                    date = ToSQL.SQLToDateTime(txtDateManual.Text);
                    decimal amount = ToSQL.SQLToDecimal(txtAmountManual.Text);
                    string desciption = txtDescriptionManual.Text;
                    _db.AddManual_BillingAccount_Management(accountNumber, date, amount, desciption);
                }
            }
            else
            {
                
                MessagesBox.jQueryShow(ClientScript, this.GetType(), DBClass.GetMessageByCode2("null_account_number"), "Messages Box");
            }
        }
        catch
        {
            
        }        
    }
    protected void btnsavebill_Click(object sender, EventArgs e)
    {
        SaveBilling(false);
    }
    protected void btnaddbill_Click(object sender, EventArgs e)
    {
        SaveBilling(true);
    }

}