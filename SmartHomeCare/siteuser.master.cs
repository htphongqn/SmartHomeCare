using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class siteuser : System.Web.UI.MasterPage
{
    private DBClass _db = new DBClass();
    public TreeView treeview;
    protected void Page_Init(object sender, EventArgs e)
    {
        treeview = treeview1;
    }
    //PARENTNODE
    public const int HOME = 0;
    public const int MYPROFILE = 1;
    public const int REPORTS = 2;
    public const int MESSAGECENTER = 3;
    public const int MYACCOUNT = 4;
    //MYPROFILE
    public const int USERINFORMATION = 0;
    public const int CHANGEPASSWORD = 1;
    public const int AUTHORIZEDUSERS = 2;
    //REPORTS
    public const int TRACKMYHEALTH = 0;
    public const int TRACKOTHERS = 1;
    //MESSAGECENTER
    public const int COMPOSE = 0;
    public const int INBOX = 1;
    public const int SENTMESSAGES = 2;
    public const int ALARMMESSAGES = 3;
    public const int TRASH = 4;
    //MYACCOUNT
    public const int BILLINGACCOUNTSUMMAR = 0;
    public const int COVERRAGEDETAILS = 1;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["User"] == null)
        {
            Response.Redirect("~/home.aspx");
        }
        if (!IsPostBack)
        {
            DataRow row = (DataRow)Session["User"];
            //int counttrash =_db.GetCount_EmailTrash_ByUserName(BaseView.GetStringFieldValue(row, "Username"));
            //int countsent = _db.GetCount_EmailSent_ByUserName(BaseView.GetStringFieldValue(row, "Username"));
            //int countinbox = _db.GetCount_EmailNew_ByUserName(BaseView.GetStringFieldValue(row, "Username"));
            //treeview1.Nodes[MESSAGECENTER].ChildNodes[TRASH].Text = "Trash messages (" + counttrash + ")";
            //treeview1.Nodes[MESSAGECENTER].ChildNodes[SENTMESSAGES].Text = "Sent messages (" + countsent + ")";
            //treeview1.Nodes[MESSAGECENTER].ChildNodes[INBOX].Text = "Inbox (" + countinbox + ")";

            //set permission
            if (!BaseView.GetBooleanFieldValue(row, "IsAdminMEM"))
            {
                TreeNode tn = treeview1.FindNode("1/0");
                treeview1.Nodes[REPORTS].ChildNodes.Remove(tn);
            }
        }
    }
}
