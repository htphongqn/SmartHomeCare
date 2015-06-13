using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Admin_login : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void btnLogin_Click(object sender, EventArgs e)
    {
        if (txtUserName.Text == "admin" && txtPassWord.Text == "admin")
        {
            Session["log"] = true;
            Response.Redirect("~/cms/parameter.aspx");
        }
        else
        {
            lbMessages.Visible = true;
        }
    }
}