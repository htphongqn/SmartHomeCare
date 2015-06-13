using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;

public partial class Admin_account_info : System.Web.UI.Page
{
    DBClass _cl = new DBClass();
    DataSet ds = new DataSet();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            ShowInfoUser();
        }
    }
    void ShowInfoUser()
    {
        string UserId = Request.QueryString["Id"];
        if (UserId != "")
        {
            ds = _cl.GetList_Users_Admin(UserId, "", "", null, null);
            DataTable dt = ds.Tables[0];
            if (dt.Rows.Count > 0)
            {
                DataRow dr = dt.Rows[0];
                txtCode.Text = dr["UserName"].ToString();

                txtfirstname.Text = BaseView.GetStringFieldValue(dr, "FirstName");
                txtlastname.Text = BaseView.GetStringFieldValue(dr, "LastName");
                txtdateofbirth.Text = BaseView.GetStringFieldValue(dr, "dateofbirth");
                txtemailaddress.Text = BaseView.GetStringFieldValue(dr, "EmailAddress");
                txtstreetaddress.Text = BaseView.GetStringFieldValue(dr, "StreetAddress");
                txtcity.Text = BaseView.GetStringFieldValue(dr, "CityCode");
                txtstate.Text = BaseView.GetStringFieldValue(dr, "StateCode");
                txtzipcode.Text = BaseView.GetStringFieldValue(dr, "ZIPCode");
                txtcounty.Text = BaseView.GetStringFieldValue(dr, "County");
                txtcountry.Text = BaseView.GetStringFieldValue(dr, "CountryCode");
                txthomephone.Text = BaseView.GetStringFieldValue(dr, "HomePhone");
                txtmobilephone.Text = BaseView.GetStringFieldValue(dr, "MobilePhone");
                txtname.Text = BaseView.GetStringFieldValue(dr, "ContactName");
                txtemailaddress.Text = BaseView.GetStringFieldValue(dr, "ContactEmail");
                txtphone.Text = BaseView.GetStringFieldValue(dr, "ContactPhone");
                txtaddress.Text = BaseView.GetStringFieldValue(dr, "ContactAddress");
               
                if (dr["IsGender"].ToString().ToLower() == "true")
                    rdfemale.Checked = true;
                else
                    rdmale.Checked = true;

            }
        }

    }
}