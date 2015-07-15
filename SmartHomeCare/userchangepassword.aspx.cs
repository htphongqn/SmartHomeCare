using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class userchangepassword : System.Web.UI.Page
{
    private DBClass _db = new DBClass();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["User"] == null)
        {
            Response.Redirect("home.aspx");
        }

        //siteuser _siteuser = (siteuser)this.Master;
        //TreeView treeview = _siteuser.treeview;
        //BaseView.SelectedTreeView(treeview, siteuser.MYPROFILE, siteuser.CHANGEPASSWORD);

        
        if (!IsPostBack)
        {
            DataRow row = (DataRow)Session["User"];
            txtpasswordhit.Text = BaseView.GetStringFieldValue(row, "PassHint");
        }
    }
    protected void btnsave_Click(object sender, EventArgs e)
    {
        string msg = "";
        DataRow row = (DataRow) Session["User"];
        int i = _db.ChangePassword(Convert.ToString(row["username"]), txtcurrentpassword.Text.Trim(), txtnewpassword.Text.Trim(), txtpasswordhit.Text.Trim());
        if (i == 1)
        {
            DataRow rowuser = _db.Login_Website(Convert.ToString(row["username"]), txtnewpassword.Text.Trim(), Security.GetClientIP());
            if (rowuser != null)
            {
                if (Convert.ToBoolean(rowuser["IsLoginOk"]))
                {
                    Session["User"] = rowuser;
                    txtpasswordhit.Text = BaseView.GetStringFieldValue(rowuser, "PassHint");
                }
            }
            msg = DBClass.GetMessageByCode2("pass_change_ok");
        }
        else
        {

            msg = DBClass.GetMessageByCode2("pass_invalid");            
            row = (DataRow)Session["User"];
            txtpasswordhit.Text = BaseView.GetStringFieldValue(row, "PassHint");
        }
        //lbmessage.Text = msg;
        MessagesBox.jQueryShow(ClientScript, this.GetType(), msg, "Messages Box");
    }
}