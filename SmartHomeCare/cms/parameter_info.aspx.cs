using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
public partial class Admin_parameter_addnew : System.Web.UI.Page
{
   
    DBClass _cl = new DBClass();
    DataSet ds = new DataSet();
    DataTable dt = new DataTable();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
            ShowData();
    }
    protected void btnAddNew_Click(object sender, EventArgs e)
    {
        string ParaCode = txtCode.Text;
        string Description = txtDescription.Text;
        string Value = txtValue.Text;
        string Note = txtNote.Text;
        bool Active = true;
        if (!chkIsActive.Checked)
        {
            Active = false;
        }
        int AutoId = 0;
        int i = 0;
        if (!String.IsNullOrEmpty(Request.QueryString["PId"]))
        {
            AutoId = Convert.ToInt32(Request.QueryString["PId"]);
            i = _cl.InsertUpdate_Paramaters(AutoId, ParaCode, Description, Value, Active,Note);
        }
        else
            i = _cl.InsertUpdate_Paramaters(AutoId, ParaCode, Description, Value, Active,Note);
        
       
        if (i == -1)
            Response.Redirect("~/cms/parameter.aspx");
        else
            lbMessages.Visible = true;
    }
    void ReplaceControl()
    {
        txtCode.Text.Replace("'","");
        txtDescription.Text.Replace("'", "");
        txtValue.Text.Replace("'", "");
        txtNote.Text.Replace("'", "");
    }
    void ShowData()
    {
        int AutoId = 0;
        if (!String.IsNullOrEmpty(Request.QueryString["PId"]))
        {
            txtCode.Enabled = false;
            AutoId = Convert.ToInt32(Request.QueryString["PId"]);
            ds = _cl.GetList_Paramaters(AutoId, "","");
            dt = ds.Tables[0];
            if (dt.Rows.Count > 0)
            {
                DataRow dr = dt.Rows[0];
                txtCode.Text = BaseView.GetStringFieldValue(dr,"ParamCode");
                txtDescription.Text =BaseView.GetStringFieldValue(dr,"Description");
                txtValue.Text = BaseView.GetStringFieldValue(dr,"ParamValue");
                txtNote.Text = BaseView.GetStringFieldValue(dr, "Note");
                string Active = BaseView.GetStringFieldValue(dr,"IsActive");
                if (Active.ToLower() == "true")
                {
                    chkIsActive.Checked = true;
                }
            }
        }
    }
    protected void CustomValidator1_ServerValidate(object source, ServerValidateEventArgs args)
    {
       
    }
    protected void btnCancel_Click(object sender, EventArgs e)
    {
        //Response.Redirect("~/Admin/parameters.aspx");
    }
}