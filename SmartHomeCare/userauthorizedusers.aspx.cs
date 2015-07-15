using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class userauthorizedusers : System.Web.UI.Page
{
    private DBClass _db = new DBClass();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["User"] == null)
        {
            Response.Redirect("home.aspx");
        }
        DataRow row = (DataRow)Session["User"];
        //siteuser _siteuser = (siteuser)this.Master;
        //TreeView treeview = _siteuser.treeview;
        //BaseView.SelectedTreeView(treeview, siteuser.MYPROFILE, siteuser.AUTHORIZEDUSERS);
        //set permission
        if (!BaseView.GetBooleanFieldValue(row, "IsAdminMEM"))
        {
            traddcurrent.Visible = false;
            traddcurrentcontrol.Visible = false;
            trcurrent.Visible = false;
            trcurrentcontrol.Visible = false;
        }
        if (!IsPostBack)
        {
            LoadAuthorizedUser();
            LoadMemberType();
        }
    }
    private void LoadAuthorizedUser()
    {
        DataRow userrow = (DataRow)Session["User"];
        DataSet ds = _db.GetList_AuthorizedUser(BaseView.GetStringFieldValue(userrow, "Username"));
        if (ds != null && ds.Tables.Count > 0)
        {
            BaseView.BindDataToListBox(lstcurrentauthorizedusers, ds.Tables[0]);
        }
    }
    private void LoadMemberType()
    {
        DataTable dt = _db.GetList_MemberType();
        BaseView.BindDataToDropdownList(ddlmembertype, dt);
    }
    protected void btndelete_Click(object sender, EventArgs e)
    {
        if (!string.IsNullOrEmpty(lstcurrentauthorizedusers.SelectedValue))
        {
            int i = _db.Delete_UsersAuthorizes_ById(Convert.ToInt32(lstcurrentauthorizedusers.SelectedValue));
            LoadAuthorizedUser();
        }
    }
    protected void btnadd_Click(object sender, EventArgs e)
    {
        DataRow userrow = (DataRow)Session["User"];
        if (BaseView.GetStringFieldValue(userrow, "Username").Trim().ToLower() == txtusername.Text.Trim().ToLower())
        {
            MessagesBox.jQueryShow(ClientScript, this.GetType(), "No add current user !", "Messages Box");
            //ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('No add current user !');", true);
            return;
        }

        object obj = _db.Register_Validation_UserName(txtusername.Text.Trim());
        if (Convert.ToBoolean(obj) && txtusername.Text.Trim().Length > 0)
        {
            DataRow row = _db.Insert_UsersAuthorizes(BaseView.GetStringFieldValue(userrow, "Username"), txtusername.Text.Trim());
            if (BaseView.GetBooleanFieldValue(row, "IsAddOK"))
            {
                LoadAuthorizedUser();
                txtusername.Text = "";
                //Response.Redirect("userauthorizedusers.aspx");
            }
            else
            {
                txtusername.Text = "";
                //lbcheckusername.Text = BaseView.GetStringFieldValue(row, "Notes");
                string notes = BaseView.GetStringFieldValue(row, "Notes");
                MessagesBox.jQueryShow(ClientScript, this.GetType(), "User already in the list", "Messages Box");
                //ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('" + notes + "');", true);
            }
        }
    }
    [WebMethod]
    public static bool UserNameChecker(string username)
    {
        DBClass _db = new DBClass();
        object obj = _db.Register_Validation_UserName(username);
        return Convert.ToBoolean(obj);   
    }
    [WebMethod]
    public static bool EmailChecker(string email)
    {
        DBClass _db = new DBClass();
        object obj = _db.IsExists_Email(email);
        return Convert.ToBoolean(obj);
    }
    protected void btninvite_Click(object sender, EventArgs e)
    {
        DataRow userrow = (DataRow)Session["User"];
        string name = BaseView.GetStringFieldValue(userrow, "Firstname") + " " + BaseView.GetStringFieldValue(userrow, "Lastname");
        string code = _db.Invite_Membertype(ToSQL.EmptyNull(ddlmembertype.SelectedValue));
        if (Convert.ToBoolean(_db.IsExists_Email(txtemail.Text)))
        {
            lbinvitenewmember.Visible = true;
            lbinvitenewmember.Text = DBClass.GetMessageByCode2("email_registered");
            
        }
        else
        {
            lbinvitenewmember.Visible = false;
            MailDaemon.invitenewmember(txtemail.Text, code, name);
            string mgs = DBClass.GetMessageByCode2("sent_success");
            MessagesBox.jQueryShow(ClientScript, this.GetType(), mgs, "Messages Box");
            txtemail.Text = "";
        }

    }
}