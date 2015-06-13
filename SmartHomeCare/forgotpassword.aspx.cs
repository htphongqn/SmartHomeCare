using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class forgotpassword : System.Web.UI.Page
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
            MessagesBox.jQueryShow(Page.ClientScript, this.GetType(), "Invalid date of birth.", "Notification message");
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
        DataRow row = _db.Submit_Forgot_Password(txtusername.Text.Trim(), dateofbirth);
        if (row != null)
        {
            if (Convert.ToBoolean(row["issubmitok"]))
            {
                string email = BaseView.GetStringFieldValue(row, "EmailAddress");
                string name = BaseView.GetStringFieldValue(row, "FirstName") + " " + BaseView.GetStringFieldValue(row, "LastName");
                string passhint = BaseView.GetStringFieldValue(row, "PassHint");
                MailDaemon.forgotpassword(email, name, passhint);
                //Response.Redirect("~/gotohome.aspx");
                lbmessage.Text = "I've sent your password hint to your mail, Please check your email.";
                //MessagesBox.jQueryShow(Page.ClientScript, this.GetType(), "I've sent your password hint to your mail, Please check your email.", "Notification message");
            }
            else
            {
                MessagesBox.jQueryShow(Page.ClientScript, this.GetType(), "Record not on file.", "Notification message");                
            }
        }
    }
}