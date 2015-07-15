using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class userinformation : System.Web.UI.Page
{
    private DBClass _db = new DBClass();
    private string RegisterCode = "";           
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["User"] == null)
        {
            Response.Redirect("home.aspx");
        }

        //siteuser _siteuser = (siteuser)this.Master;
        //TreeView treeview = _siteuser.treeview;
        //BaseView.SelectedTreeView(treeview, siteuser.MYPROFILE, siteuser.USERINFORMATION);

        if (!IsPostBack)
        {
            IsEdit(false);
            LoadCountry();
            LoadState("");
            LoadUserType();
            LoadInfo();
        }
    }
    private void IsEdit(bool p)
    {
        txtemail.Visible = p;
        lbemail.Visible = !txtemail.Visible;

        txtfirstname.Visible = false;
        lbfirstname.Visible = !txtfirstname.Visible;
        txtlastname.Visible = false;
        lblastname.Visible = !txtlastname.Visible;
        txtdateofbirth.Visible = false;
        lbdateofbirth.Visible = !txtdateofbirth.Visible;
        rdmale.Visible = rdfemale.Visible = false;
        lbgender.Visible = !rdmale.Visible;

        txtaddress.Visible = p;
        lbaddress.Visible = !txtaddress.Visible;
        txtcity.Visible = p;
        lbcity.Visible = !txtcity.Visible;
        ddlstate.Visible = p;
        lbstate.Visible = !ddlstate.Visible;
        txtzipcode.Visible = p;
        lbzipcode.Visible = !txtzipcode.Visible;
        txtcounty.Visible=p;
        lbcounty.Visible = !txtcounty.Visible;
        ddlcountry.Visible = p;
        lbcountry.Visible = !ddlcountry.Visible;
        txthomephone.Visible = p;
        lbhomephone.Visible = !txthomephone.Visible;
        txtmobilephone.Visible = p;
        lbmobilephone.Visible = !txtmobilephone.Visible;

        ddlUserType.Visible = false;
        lblUserType.Visible = !ddlUserType.Visible;

        btnsave.Visible = p;
        btncancel.Visible = p;
        btnedit.Visible = !p;
        btnback.Visible = !p;
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

    private void LoadUserType()
    {
          DataTable dt = _db.GetList_MemberType();
          if (dt != null)
          {
                BaseView.BindDataToDropdownList(ddlUserType, dt);
          }
    }
    private void LoadInfo()
    {
        DataRow userrow = (DataRow)Session["User"];
        DataRow row = _db.GetInfo_UsersAll_ByUserName(BaseView.GetStringFieldValue(userrow, "Username"));
        if (row != null)
        {
            lbemail.Text = txtemail.Text = BaseView.GetStringFieldValue(row, "EmailAddress");
            lbfirstname.Text = txtfirstname.Text = BaseView.GetStringFieldValue(row, "FirstName");
            lblastname.Text = txtlastname.Text = BaseView.GetStringFieldValue(row, "LastName");
            lbdateofbirth.Text = txtdateofbirth.Text = BaseView.GetDateTimeFieldValue(row, "DateofBirth").ToString("MM/dd/yyyy");
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
            ddlcountry.SelectedValue = BaseView.GetStringFieldValue(row, "CountryCode");
            LoadState(ddlcountry.SelectedValue);
            lbstate.Text = BaseView.GetStringFieldValue(row, "StateName");
            ddlstate.SelectedValue = BaseView.GetStringFieldValue(row, "StateCode");
            lbhomephone.Text = txthomephone.Text = BaseView.GetStringFieldValue(row, "HomePhone");
            lbmobilephone.Text = txtmobilephone.Text = BaseView.GetStringFieldValue(row, "MobilePhone");

            lblUserType.Text = BaseView.GetStringFieldValue(row, "RuleName");
             ddlUserType.SelectedValue = BaseView.GetStringFieldValue(row, "RuleCode");

             RegisterCode = BaseView.GetStringFieldValue(row, "RegisterCode"); 
        }
    }
    protected void btnedit_Click(object sender, EventArgs e)
    {
        IsEdit(true);
    }    
    protected void btncancel_Click(object sender, EventArgs e)
    {
        IsEdit(false);
        LoadInfo();
    }
    protected void btnsave_Click(object sender, EventArgs e)
    {
        DataRow userrow = (DataRow)Session["User"];
        if (!_db.IsInvalid_EmailAddress(BaseView.GetStringFieldValue(userrow, "Username"), txtemail.Text.Trim()))
        {
            string title = "Email address unavailable";
            ClientScript.RegisterStartupScript(this.GetType(), "onload", "jAlert('" + title + "','');", true);
            return;
        }
        DateTime temp = new DateTime();
        DateTime? dateofbirth = null;
        bool isdate = DateTime.TryParse(txtdateofbirth.Text.Trim(), out temp);
        if (isdate)
            dateofbirth = temp;

        RegisterCode = BaseView.GetStringFieldValue(userrow, "RegistrationCode");
        int i = _db.InsertUpdate_UsersInfo(BaseView.GetStringFieldValue(userrow, "Username"), txtfirstname.Text.Trim(), txtlastname.Text.Trim(), dateofbirth, rdmale.Checked, txtemail.Text.Trim(),
            txtaddress.Text.Trim(), txtcity.Text.Trim(), ddlstate.SelectedValue, txtzipcode.Text.Trim(), txtcounty.Text.Trim(), ddlcountry.SelectedValue, txthomephone.Text, txtmobilephone.Text, RegisterCode);

        IsEdit(false);
        LoadInfo();

        DataRow dr = _db.GetInfo_Rule_ByUserName(BaseView.GetStringFieldValue(userrow, "Username"));
        if (dr != null)
        {
            DataRow dr_ = userrow;
            dr_["RegistrationCode"] = dr["RegisterCode"].ToString();

            Session["User"] = dr_;
        }
    }
    protected void ddlcountry_SelectedIndexChanged(object sender, EventArgs e)
    {
        LoadState(ddlcountry.SelectedValue);
    }
    protected void ddlstate_SelectedIndexChanged(object sender, EventArgs e)
    {

    }
}