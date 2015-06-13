using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;
using System.IO;
using System.Drawing;
using System.Drawing.Imaging;
using System.Drawing.Drawing2D;
using System.Drawing.Text;
using System.Text;
public partial class Default2 : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        Response.Cache.SetExpires(DateTime.Now.AddDays(-1));
        Response.Cache.SetCacheability(HttpCacheability.NoCache);
        Response.Cache.SetValidUntilExpires(false);
        if (!IsPostBack)
        {
            //DirectoryInfo dr = new DirectoryInfo(Server.MapPath("~/resources/images/captcha/"));
            //foreach (FileInfo f in dr.GetFiles())
            //{
            //    f.Delete();
            //}
            captchaImage.ImageUrl = new CaptchaImage().CreateCaptcha();
        }
    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        string msg = DBClass.GetMessageByCode2("register_success");
        MessagesBox.jQueryShow(ClientScript, this.GetType(), msg, "notification");
    }
    protected void ImageButton1_Click(object sender, ImageClickEventArgs e)
    {
        //DirectoryInfo dr = new DirectoryInfo(Server.MapPath("~/resources/images/captcha/"));
        //foreach (FileInfo f in dr.GetFiles())
        //{
        //    f.Delete();
        //}
        captchaImage.ImageUrl = new CaptchaImage().CreateCaptcha();
    }
    
}