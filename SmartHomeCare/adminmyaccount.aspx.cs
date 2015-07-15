using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
public partial class adminmyaccount : System.Web.UI.Page
{
    DBClass _db = new DBClass();
    DataTable dt = new DataTable();
    string Username = "";
    protected void Page_Load(object sender, EventArgs e)
    {   if(!IsPostBack)
        {
            //siteadmin _siteadmin = (siteadmin)this.Master;
            //TreeView treeview = _siteadmin.treeview;
            //BaseView.SelectedTreeView(treeview, siteadmin.MYACCOUNT);
            IsEdit(false);
            ShowInfo();
        }
    }
    void IsEdit(bool q)
    {
        txtEmail.Visible = q;
        lbEmail.Visible = !txtEmail.Visible;

        txtName.Visible = q;
        lbName.Visible = !txtName.Visible;

        txtLastLogin.Visible = q;
        lbLastLogin.Visible = !txtLastLogin.Visible;

        txtPrivileges.Visible = q;
        lbPrivileges.Visible = !txtPrivileges.Visible;

        txtPassword.Visible = q;
        lbPassword.Visible = !txtPassword.Visible;

        txtLanguage.Visible = q;
        lbLanguage.Visible = !txtLanguage.Visible;


        btnsave.Enabled = q;
        btncancel.Enabled = q;
        btnedit.Enabled = !q;
    }
    void ShowInfo()
    {

    }
    protected void btnedit_Click(object sender, EventArgs e)
    {
        IsEdit(true);
    }
    protected void btnsave_Click(object sender, EventArgs e)
    {
        IsEdit(false);
    }
    protected void btncancel_Click(object sender, EventArgs e)
    {
        IsEdit(false);
    }
}