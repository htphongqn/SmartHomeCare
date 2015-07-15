using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class siteadminX : System.Web.UI.MasterPage
{
    public TreeView treeview;
    protected void Page_Init(object sender, EventArgs e)
    {
        treeview = treeview1;
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
    public const int INBOX = 1;
    public const int COMPOSE = 0;
    public const int SENTMESSAGES = 2;
    public const int TRASH = 3;
    //MYACCOUNT

    protected void Page_Load(object sender, EventArgs e)
    {
        
    }
}
