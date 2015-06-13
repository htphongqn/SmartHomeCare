using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class sitecms : System.Web.UI.MasterPage
{
    public TreeView treeview;
    protected void Page_Init(object sender, EventArgs e)
    {
        treeview = trvMenu;
    }
    //PARENTNODE
    public const int USERMANAGEMENT = 0;
    public const int REPORTS = 1;
    public const int LOGS = 2;
    public const int SYSTEMTOOLS = 3;
    public const int MESSAGECENTER = 4;
    public const int MYACCOUNT = 5;
    //USERMANAGEMENT
    //REPORTS
    public const int STATISTICS = 0;
    //LOGS
    public const int WEBADMINLOGS = 0;
    public const int SYNCLOG = 1;
    //SYSTEMTOOLS
    public const int SECURITY = 0;
    public const int CONFIGURE = 1;
    //MESSAGECENTER
    public const int INBOX = 0;
    public const int SENTMESSAGES = 1;
    //MYACCOUNT

    protected void Page_Load(object sender, EventArgs e)
    {
        //Session["User"] = "Welcome, admin ! <br /><a href='home.aspx'>LOGOUT</a>";

        if (Session["log"] == null)
            Response.Redirect("~/cms/login.aspx");
    }
}
