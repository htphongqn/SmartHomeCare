using System;
using System.Configuration;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Collections;
using System.Net.Mail;
using System.Data;

/**
 * \brief process send mail
 */
public class MailDaemon
{
    private static DBClass _db = new DBClass();
    private static SmtpClient MailClient = new SmtpClient();
    private static string sitename = ConfigurationSettings.AppSettings["SiteName"];
    private static string https = HttpContext.Current.Request.ServerVariables["HTTPS"];

    private static List<MailAddress> AdditionalCCEmails = new List<MailAddress>
    {
    };

    private static List<MailAddress> AdditionalBCCEmails = new List<MailAddress>
    {
    };
    
    //public static void registration(string email,string name, string webcode)
    //{
    //    try
    //    {
    //        MailAddress source = new MailAddress("confirmation@mint-corp.com", sitename);
    //        MailAddress recipient = new MailAddress(email, name);

    //        MailMessage msg = new MailMessage();
    //        msg.From = source;
    //        msg.To.Add(recipient);

    //        foreach (MailAddress ma in MailDaemon.AdditionalCCEmails)
    //            msg.CC.Add(ma);

    //        foreach (MailAddress ma in MailDaemon.AdditionalBCCEmails)
    //            msg.Bcc.Add(ma);

    //        msg.Subject = "Registration Confirmation";

    //        string ss = "Hello " + name;

    //        ss += "<br />       <br />";
    //        ss += "You have already registered, click on the link below to complete and sign.<br />";
    //        string link = "http://97.74.205.162:8090/home.aspx?w=" + webcode;
    //        ss += "<a href='" + link + "'>" + link + "</a>";
    //        ss += "<br />If you are not registered, then ignore this message.";



    //        ss += "<br />       <br />";
    //        ss += "We appreciate your business!<br />        <br />";
    //        ss += "Sincerely,     <br />       <br />";
    //        ss += "HomeCare System<br />      <br />";
    //        ss += "Customer Service Team   <br />    <br />";
    //        ss += "1-855-4-ABC    <br />    <br />";
    //        ss += "FAX: 1-866-XXX-XXXX     <br />       <br />";
    //        ss += "Email : support@mint-corp.com";

    //        msg.Body = ss;
    //        msg.IsBodyHtml = true;
    //        MailDaemon.MailClient.Send(msg);
    //    }
    //    catch
    //    {
            
    //    }
        
    //}

    //public static void forgotusername(string email, string name, string username)
    //{
    //    try
    //    {
    //        MailAddress source = new MailAddress("confirmation@mint-corp.com", sitename);
    //        MailAddress recipient = new MailAddress(email, name);

    //        MailMessage msg = new MailMessage();
    //        msg.From = source;
    //        msg.To.Add(recipient);

    //        foreach (MailAddress ma in MailDaemon.AdditionalCCEmails)
    //            msg.CC.Add(ma);

    //        foreach (MailAddress ma in MailDaemon.AdditionalBCCEmails)
    //            msg.Bcc.Add(ma);

    //        msg.Subject = "Forgot Username ";

    //        string ss = "Hello " + name;

    //        ss += "<br />       <br />";
    //        ss += "You just send the requested username. At website HomeCare Systems : ";

    //        string link = "http://97.74.205.162:8090/";
    //        ss += "<a href='" + link + "'>" + link + "</a>";

    //        ss += "<br />Username : " + username;


    //        ss += "<br />       <br />";
    //        ss += "We appreciate your business!<br />        <br />";
    //        ss += "Sincerely,     <br />       <br />";
    //        ss += "HomeCare System<br />      <br />";
    //        ss += "Customer Service Team   <br />    <br />";
    //        ss += "1-855-4-ABC    <br />    <br />";
    //        ss += "FAX: 1-866-XXX-XXXX     <br />       <br />";
    //        ss += "Email : support@mint-corp.com";

    //        msg.Body = ss;
    //        msg.IsBodyHtml = true;
    //        MailDaemon.MailClient.Send(msg);
    //    }
    //    catch
    //    {

    //    }
        
    //}
    //public static void forgotpassword(string email, string name, string passhint)
    //{
    //    try
    //    {
    //        MailAddress source = new MailAddress("confirmation@mint-corp.com", sitename);
    //        MailAddress recipient = new MailAddress(email, name);

    //        MailMessage msg = new MailMessage();
    //        msg.From = source;
    //        msg.To.Add(recipient);

    //        foreach (MailAddress ma in MailDaemon.AdditionalCCEmails)
    //            msg.CC.Add(ma);

    //        foreach (MailAddress ma in MailDaemon.AdditionalBCCEmails)
    //            msg.Bcc.Add(ma);

    //        msg.Subject = "Forgot Password";

    //        string ss = "Hello " + name;

    //        ss += "<br />       <br />";
    //        ss += "You just send the requested Password Hint. At website HomeCare Systems : ";
    //        string link = "http://97.74.205.162:8090/";
    //        ss += "<a href='" + link + "'>" + link + "</a>";
    //        ss += "<br />This is Password Hint: " + passhint;


    //        ss += "<br />       <br />";
    //        ss += "We appreciate your business!<br />        <br />";
    //        ss += "Sincerely,     <br />       <br />";
    //        ss += "HomeCare System<br />      <br />";
    //        ss += "Customer Service Team   <br />    <br />";
    //        ss += "1-855-4-ABC    <br />    <br />";
    //        ss += "FAX: 1-866-XXX-XXXX     <br />       <br />";
    //        ss += "Email : support@mint-corp.com";

    //        msg.Body = ss;
    //        msg.IsBodyHtml = true;
    //        MailDaemon.MailClient.Send(msg);
    //    }
    //    catch
    //    {

    //    }        
    //}
    /**
     * initialization smtp client
     * @see getsmtpgmail()
     */
    private static SmtpClient getsmtpgmail()
    {
        string from = "mintcorptest@gmail.com";
        string password = "Mint8600";

        var smtp = new SmtpClient()
        {
            Host = "smtp.gmail.com",
            Port = 587,
            EnableSsl = ("TLS" != ""),
            UseDefaultCredentials = false,
            Credentials = new System.Net.NetworkCredential(from, password)
        };
        return smtp;

        //string from = "postmaster@smarteyewear.com";
        //string password = "Angela02";

        //var smtp = new SmtpClient()
        //{
        //    Host = "184.168.69.59",
        //    UseDefaultCredentials = false,
        //    Credentials = new System.Net.NetworkCredential(from, password)
        //};
        //return smtp;

    }
    /**
     * send mail, enable registration
     * @see registration()
     * @param email is email registration
     * @param name is name recipient
     * @param webcode is enable account
     */
    public static void registration(string email, string name, string webcode)
    {
        var smtp = getsmtpgmail();

        string from = "noreply@gmail.com";

        DataTable dt = _db.GetInfo_EmailTemplates(1);

        string body = "";
        string subject = "Registration Confirmation";
        if (dt.Rows.Count > 0)
        {
            body = BaseView.GetStringFieldValue(dt.Rows[0], "Body");
            body = body.Replace("@name", name);
            body = body.Replace("@webcode", webcode);
            subject = BaseView.GetStringFieldValue(dt.Rows[0], "Subject");
        }
        using (MailMessage msg = new MailMessage())
        {
            try
            {
                MailAddress source = new MailAddress(from, sitename);
                MailAddress recipient = new MailAddress(email);

                msg.From = source;
                msg.To.Add(recipient);
                msg.Subject = subject;
                msg.Body = body;

                msg.IsBodyHtml = true;
                smtp.Send(msg);
            }
            catch (Exception) { }
        }
    }
    /**
     * send mail, get back username
     * @see forgotusername()
     * @param email is email account
     * @param name is name account
     * @param username sent mail
     */
    public static void forgotusername(string email, string name, string username)
    {
        var smtp = getsmtpgmail();

        string from = "noreply@gmail.com";

        DataTable dt = _db.GetInfo_EmailTemplates(3);

        string body = "";
        string subject = "Forgot Username";
        if (dt.Rows.Count > 0)
        {
            body = BaseView.GetStringFieldValue(dt.Rows[0], "Body");
            body = body.Replace("@name", name);
            body = body.Replace("@username", username);
            subject = BaseView.GetStringFieldValue(dt.Rows[0], "Subject");
        }

        using (MailMessage msg = new MailMessage())
        {
            try
            {
                MailAddress source = new MailAddress(from, sitename);
                MailAddress recipient = new MailAddress(email);

                msg.From = source;
                msg.To.Add(recipient);
                msg.Subject = subject;
                msg.Body = body;

                msg.IsBodyHtml = true;
                smtp.Send(msg);
            }
            catch (Exception) {
                
            }
        }

    }
    /**
     * send mail, get back password
     * @see forgotpassword()
     * @param email is email account
     * @param name is name account
     * @param passhint sent mail
     */
    public static void forgotpassword(string email, string name, string passhint)
    {
        var smtp = getsmtpgmail();

        string from = "noreply@gmail.com";
        //string from = "notification@mint-corp.com";

        DataTable dt = _db.GetInfo_EmailTemplates(2);
        string body = "";
        string subject = "Forgot Password";
        if (dt.Rows.Count > 0)
        {
            body = BaseView.GetStringFieldValue(dt.Rows[0], "Body");
            body = body.Replace("@name", name);
            body = body.Replace("@passhint", passhint);
            subject = BaseView.GetStringFieldValue(dt.Rows[0], "Subject");
        }

        using (MailMessage msg = new MailMessage())
        {
            try
            {
                MailAddress source = new MailAddress(from, sitename);
                MailAddress recipient = new MailAddress(email);

                msg.From = source;
                msg.To.Add(recipient);
                msg.Subject = subject;
                msg.Body = body;

                msg.IsBodyHtml = true;
                smtp.Send(msg);
            }
            catch (Exception) { }
        }

    }
    /**
     * send mail, invite new member
     * @see invitenewmember()
     * @param email is invite
     * @param code permission
     * @param name is Invitations
     */
    public static void invitenewmember(string email, string code, string name)
    {
        var smtp = getsmtpgmail();

        string from = "noreply@gmail.com";

        DataTable dt = _db.GetInfo_EmailTemplates(4);
        string body = "";
        string subject = "Invite New Member";
        if (dt.Rows.Count > 0)
        {
            body = BaseView.GetStringFieldValue(dt.Rows[0], "Body");
            body = body.Replace("@email", email);
            body = body.Replace("@code", code);
            body = body.Replace("@name", name);
            subject = BaseView.GetStringFieldValue(dt.Rows[0], "Subject");
        }

        using (MailMessage msg = new MailMessage())
        {
            try
            {
                MailAddress source = new MailAddress(from, sitename);
                MailAddress recipient = new MailAddress(email);
                
                msg.From = source;
                msg.To.Add(recipient);
                msg.Subject = subject;
                msg.Body = body;

                msg.IsBodyHtml = true;
                smtp.Send(msg);
            }
            catch (Exception) { }
        }

    }
}
