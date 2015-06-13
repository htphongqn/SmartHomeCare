using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
public partial class Admin_adminmessages_addnew : System.Web.UI.Page
{
    DBClass _cl = new DBClass();
    DataTable dt = new DataTable();
    DataSet ds = new DataSet();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            ShowData();
        }
    }
    protected void btnAddNew_Click(object sender, EventArgs e)
    {
        ReplaceControl();
        string Code = txtCode.Text;
        string Title = txtTitle.Text;
        string TitleVN = txtTitleVN.Text;
        string Note = txtNote.Text;
        bool Approved = false;
        if (chkApproved.Checked)
            Approved = true;
        int AutoId = 0;
        int i =0;
        if (!String.IsNullOrEmpty(Request.QueryString["MId"]))
        {
            
            AutoId =Convert.ToInt32(Request.QueryString["MId"]);
            i = _cl.InsertUpdate_AdminMessages(AutoId, Code, Title,TitleVN,Approved,Note);
        }
        else
            i = _cl.InsertUpdate_AdminMessages(AutoId, Code, Title, TitleVN, Approved,Note);
        if (i == -1)
        {
            Response.Redirect("~/cms/adminmessages.aspx");
        }
        else
            lbmessages.Visible = true;
    }
    void ReplaceControl()
    {
        txtCode.Text.Replace("'", "");
        txtTitle.Text.Replace("'","");
        txtNote.Text.Replace("'", "");
    }
    void ShowData()
    {
        int AutoId = 0;
        if (!String.IsNullOrEmpty(Request.QueryString["MId"]))
        {
            txtCode.Enabled = false;
            AutoId = Convert.ToInt32(Request.QueryString["MId"]);
            ds = _cl.GetList_AdminMessages(AutoId,"", "");
            dt = ds.Tables[0];
            if (dt.Rows.Count > 0)
            {
                DataRow dr = dt.Rows[0];
                txtCode.Text = BaseView.GetStringFieldValue(dr, "Code");
                txtTitle.Text = BaseView.GetStringFieldValue(dr, "Title");
                txtTitleVN.Text = BaseView.GetStringFieldValue(dr, "TitleVN");
                txtNote.Text = BaseView.GetStringFieldValue(dr, "Note");
                if (dr["IsApproved"].ToString().ToLower() == "true")
                    chkApproved.Checked = true;
                else
                    chkApproved.Checked = false;
            }
        }
    }
    protected void btnUpdate_Click(object sender, EventArgs e)
    {

    }
}