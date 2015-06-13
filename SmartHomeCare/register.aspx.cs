using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class register : System.Web.UI.Page
{
    private DBClass _db = new DBClass();
    protected void Page_Load(object sender, EventArgs e)
    {
        string password = txtpassword.Text;
        txtpassword.Attributes.Add("value", password);
        string passwordconfirm = txtpasswordconfirm.Text;
        txtpasswordconfirm.Attributes.Add("value", passwordconfirm);

        if (!IsPostBack)
        {
            txtusername.Text = "";
            txtpassword.Text = "";
            txtpasswordconfirm.Text = "";
            ViewState["myCount"] = 0;
            LoadCountry();
            LoadState("");
            // Create a random code and store it in the Session object.
            //this.Session["CaptchaImageText"] = Security.GenerateRandomCode();
            //lbcaptcha.Text = ToSQL.EmptyNull(this.Session["CaptchaImageText"]);
            captchaImage.ImageUrl = new CaptchaImage().CreateCaptcha();

            if (!string.IsNullOrEmpty(Request.QueryString["code"]))
            {
                txtregistrationcode.Text = ToSQL.EmptyNull(Request.QueryString["code"]);
            }
            //else
            //{
            //    txtregistrationcode.Text = _db.Get_RegistrationCode_Automatic();                
            //}
        }
        else
        {
            int countmax = _db.GetValue_Paramter_ByCode("AmountEmergencyContact");
            int myCount = (int)ViewState["myCount"];
            if (myCount + 1 < countmax)
            {
                Control myControl = GetPostBackControl(this.Page);

                if ((myControl != null))
                {
                    if ((myControl.ID == btnaddmore.ID))
                    {
                        myCount = myCount + 1;
                        ViewState["myCount"] = myCount;
                    }
                }
            }
            else
            {
                MessagesBox.jQueryShow(ClientScript, this.GetType(), "Emergency contact maximum : " + ToSQL.EmptyNull(countmax), "MessagesBox");
            }
        }
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
    protected void btnregister_Click(object sender, EventArgs e)
    {
        object obj = _db.Register_Validation_UserName(txtusername.Text.Trim());
        if (!Convert.ToBoolean(obj) && txtusername.Text.Trim().Length > 0)
        {
            string strdateofbirth = txtyyyy.Text.Trim() + "/" + txtmm.Text.Trim() + "/" + txtdd.Text.Trim();
            DateTime temp = new DateTime();
            DateTime? dateofbirth = null;
            bool isdate = DateTime.TryParse(strdateofbirth, out temp);
            if (isdate)
            {
                dateofbirth = temp;
                lberrordate.Text = "";
            }
            else
            {
                lberrordate.Text = "<br />Datetime mismatched";
                txtmm.Text = ""; txtdd.Text = ""; txtyyyy.Text = "";
                return;
            }
            object isemail = _db.IsExists_Email(txtemailaddress.Text.Trim());
            if (ToSQL.SQLToBool(isemail))
            {
                txtemailaddress.Text = ""; txtemailaddressconfirm.Text = "";
                lberroremailaddress.Text = "<br />" + DBClass.GetMessageByCode2("exists_email");
                return;
            }
            else
            {
                lberroremailaddress.Text = "";
            }
            DataRow rcode = _db.Invalid_RegistrationCode(txtregistrationcode.Text.Trim());
            if (rcode != null)
            {
                if (!BaseView.GetBooleanFieldValue(rcode, "IsOk"))
                {
                    txtregistrationcode.Text = "";
                    lberrorregistrationcode.Text = BaseView.GetStringFieldValue(rcode, "Notes");
                    return;
                }
            }
            else
            {
                return;
            }

            if (this.Session["captcha"] == null || txtcaptcha.Text != this.Session["captcha"].ToString())
            {
                // Display an error message.
                this.lbmessage.CssClass = "error";
                this.lbmessage.Text = "ERROR: Incorrect, Please try again.";

                // Clear the input and create a new random code.
                this.txtcaptcha.Text = "";
                //this.Session["CaptchaImageText"] = Security.GenerateRandomCode();
                //lbcaptcha.Text = ToSQL.EmptyNull(this.Session["CaptchaImageText"]);
                captchaImage.ImageUrl = new CaptchaImage().CreateCaptcha();
                return;
            }
            else
            {
                this.lbmessage.Text = "";
            }

            DataRow row = _db.Register_Account_Users(txtusername.Text.Trim(), txtpassword.Text.Trim(), txtpasswordhint.Text.Trim(), txtfirstname.Text.Trim(), txtlastname.Text.Trim(),
                dateofbirth, rdmale.Checked, txtemailaddress.Text.Trim(), txtstreetaddress.Text.Trim(), txtcity.Text.Trim(), ddlstate.SelectedValue, txtzipcode.Text.Trim(),
                txtcounty.Text.Trim(), ddlcountry.SelectedValue, txthomephone.Text.Trim(), txtmobilephone.Text.Trim(), Security.GetClientIP(), txtregistrationcode.Text.Trim());
           
            if (row != null)
            {
                if (BaseView.GetBooleanFieldValue(row, "IsOK"))
                {
                    int i = _db.InsertUpdate_UsersContact(txtusername.Text.Trim(), txtname.Text.Trim(), txtemail.Text.Trim(), txtphone.Text.Trim(), txtaddress.Text.Trim(),true);

                    //more contacts
                    foreach (TableRow[] item in contacts)
                    {
                        TextBox itemname = (TextBox)item[1].Cells[1].Controls[0];
                        TextBox itemmail = (TextBox)item[2].Cells[1].Controls[0];
                        TextBox itemphone = (TextBox)item[3].Cells[1].Controls[0];
                        TextBox itemaddress = (TextBox)item[4].Cells[1].Controls[0];

                        _db.InsertUpdate_UsersContact(txtusername.Text.Trim(), itemname.Text.Trim(), itemmail.Text.Trim(), itemphone.Text.Trim(), itemaddress.Text.Trim(), false);
                    }
                    string name = txtfirstname.Text.Trim() + " " + txtlastname.Text.Trim();
                    string webcode = BaseView.GetStringFieldValue(row, "WebCode");
                    MailDaemon.registration(txtemailaddress.Text.Trim(), name, webcode);
                    //string msg = DBClass.GetMessageByCode2("register_success");
                    //MessagesBox.jQueryShow(ClientScript, this.GetType(), msg, "notification");
                    Response.Redirect("registersuccessfull.aspx");
                }
            }
        }
        else
        {
            //ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('" + DBClass.GetMessageByCode2("incorrectly") + "');", true);
            MessagesBox.jQueryShow(ClientScript, this.GetType(), DBClass.GetMessageByCode2("username_exist"), "MessagesBox");
            txtusername.Text = "";
            this.lbmessage.Text = "";
            this.txtcaptcha.Text = "";
            this.Session["CaptchaImageText"] = Security.GenerateRandomCode();
        }
                                                
    }

    protected void imgreload_Click(object sender, ImageClickEventArgs e)
    {
        this.txtcaptcha.Text = "";
        //this.Session["CaptchaImageText"] = Security.GenerateRandomCode();
        //lbcaptcha.Text = ToSQL.EmptyNull(this.Session["CaptchaImageText"]);
        captchaImage.ImageUrl = new CaptchaImage().CreateCaptcha();
    }

    protected void ddlcountry_SelectedIndexChanged(object sender, EventArgs e)
    {
        LoadState(ddlcountry.SelectedValue);
    }

    [WebMethod]
    public static bool UserNameChecker(string username)
    {
        DBClass _db = new DBClass();
        object obj = _db.Register_Validation_UserName(username);
        return Convert.ToBoolean(obj);
    }

    #region add more contacts

    private List<TableRow[]> contacts;

    private TableRow[] contact(int index)
    {
        TableRow[] dynamicTableRows = new TableRow[5];

        TableRow row;
        row = rowcontacttitle("Emergency contact " + index);
        dynamicTableRows[0] = row;
        row = rowcontact("Name:");
        dynamicTableRows[1] = row;
        row = rowcontact("Email:");
        dynamicTableRows[2] = row;
        row = rowcontact("Phone:");
        dynamicTableRows[3] = row;
        row = rowcontact("Address:");
        dynamicTableRows[4] = row;
        return dynamicTableRows;
    }
    private TableRow rowcontacttitle(string text)
    {
        TableCell cell;
        TableRow row;

        cell = new TableCell();
        cell.Text = text;
        cell.Width = 200;
        cell.CssClass = "bold";
        row = new TableRow();
        row.Cells.Add(cell);

        cell = new TableCell();
        row.Cells.Add(cell);

        return row;
    }
    private TableRow rowcontact(string text)
    {
        TextBox txt;
        TableCell cell;
        TableRow row;

        cell = new TableCell();
        cell.Text = text;
        cell.Width = 200;
        row = new TableRow();
        row.Cells.Add(cell);

        txt = new TextBox();
        txt.Width = 220;
        cell = new TableCell();
        cell.Controls.Add(txt);
        row.Cells.Add(cell);

        return row;
    }

    protected void btnaddmore_Click(object sender, EventArgs e)
    {
        // Handled in preInit due to event sequencing.
    }
    protected override void OnLoad(EventArgs e)
    {
        base.OnLoad(e);
        int myCount = (int)ViewState["myCount"];
        contacts = new List<TableRow[]>(myCount);
        int i;
        for (i = 0; i < myCount; i += 1)
        {
            TableRow[] rows = contact(i+2);
            tblcontacts.Rows.AddRange(rows);            
            contacts.Add(rows);
        }
    }
    private Control GetPostBackControl(Page thePage)
    {
        Control myControl = null;
        string ctrlName = thePage.Request.Params.Get("__EVENTTARGET");
        if (((ctrlName != null) & (ctrlName != string.Empty)))
        {
            myControl = ((ContentPlaceHolder)thePage.Master.FindControl("main")).Page.FindControl(ctrlName);
        }
        else
        {
            foreach (string Item in thePage.Request.Form)
            {
                Control c = ((ContentPlaceHolder)thePage.Master.FindControl("main")).Page.FindControl(Item);
                if (((c) is System.Web.UI.WebControls.Button))
                {
                    myControl = c;
                }
            }
        }
        return myControl;
    }

    #endregion

}