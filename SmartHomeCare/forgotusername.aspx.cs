using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class forgotusername : System.Web.UI.Page
{
    private DBClass _db = new DBClass();
    protected void Page_Load(object sender, EventArgs e)
    {
        lbmessage.Text = "";
        if (!IsPostBack)
        {
            captchaImage.ImageUrl = new CaptchaImage().CreateCaptcha();
        }
    }
    protected void imgreload_Click(object sender, ImageClickEventArgs e)
    {
        this.txtcaptcha.Text = "";
        captchaImage.ImageUrl = new CaptchaImage().CreateCaptcha();
    }
    protected void btnsubmit_Click(object sender, EventArgs e)
    {
        string strdateofbirth = txtyyyy.Text.Trim() + "/" + txtmm.Text.Trim() + "/" + txtdd.Text.Trim();
        DateTime temp = new DateTime();
        DateTime? dateofbirth = null;
        bool isdate = DateTime.TryParse(strdateofbirth, out temp);
        if (isdate)
            dateofbirth = temp;
        if (dateofbirth == null)
        {
            string msg = DBClass.GetMessageByCode2("invalid_birthday");
            MessagesBox.jQueryShow(ClientScript, this.GetType(), msg, "Notification message");
            return;
        }
        if (this.Session["captcha"] == null || txtcaptcha.Text != this.Session["captcha"].ToString())
        {
            // Display an error message.
            this.lbmessagecaptcha.CssClass = "error";
            this.lbmessagecaptcha.Text = "ERROR: Incorrect, Please try again.";

            // Clear the input and create a new random code.
            this.txtcaptcha.Text = "";
            captchaImage.ImageUrl = new CaptchaImage().CreateCaptcha();
            return;
        }
        else
        {
            this.lbmessagecaptcha.Text = "";
        }
        DataRow row = _db.Submit_Forgot_UserName(txtfirstname.Text.Trim(), txtlastname.Text.Trim(), dateofbirth, txtzipcode.Text.Trim());
        if (row != null)
        {
            if (BaseView.GetBooleanFieldValue(row,"IsSubmitOK"))
            {
                string email=BaseView.GetStringFieldValue(row, "EmailAddress");
                string name = BaseView.GetStringFieldValue(row, "FirstName") + " " + BaseView.GetStringFieldValue(row, "LastName");
                string username = BaseView.GetStringFieldValue(row, "UserName");
                MailDaemon.forgotusername(email, name, username);
                Response.Redirect("~/gotohome.aspx");
                string msg = DBClass.GetMessageByCode2("forgot_username_success");
                lbmessage.Text = msg;
                //MessagesBox.jQueryShow(ClientScript, this.GetType(), msg, "Notification message");
              
            }
            else
            {
                string msg = DBClass.GetMessageByCode2("record_not_in_file");
                string title = "Notification";
                //MessagesBox.jQueryShow(ClientScript, this.GetType(), msg, "Notification message");
               //ClientScript.RegisterStartupScript(this.GetType(), "onload", "not_record();", true);
                ClientScript.RegisterStartupScript(this.GetType(), "onload", "jAlert('" + msg + "','" + title + "');", true);
            }
        }
    }
}