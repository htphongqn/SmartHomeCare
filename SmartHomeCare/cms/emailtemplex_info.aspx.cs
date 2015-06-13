using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
public partial class cms_emailtemplex_info : System.Web.UI.Page
{
    DBClass _db = new DBClass();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            LoadInfo();
        }
    }
    private void LoadInfo()
    {
        if (!String.IsNullOrEmpty(Request.QueryString["Id"]))
        {
            int Id = Convert.ToInt32(Request.QueryString["Id"]);
            DataTable dt = _db.GetInfo_EmailTemplates(Id);
            if (dt.Rows.Count > 0)
            {
                DataRow dr = dt.Rows[0];
                txtcode.Text = dr["Code"].ToString(); txtcode.Enabled = false;
                txtsubject.Text = dr["Subject"].ToString();
                txtbody.Text = dr["Body"].ToString();
                txtnote.Text = dr["Note"].ToString();
            }
        }
    }
    protected void btnUpdate_Click(object sender, EventArgs e)
    {
        int i;
        if (!String.IsNullOrEmpty(Request.QueryString["Id"]))
        {
            int Id = Convert.ToInt32(Request.QueryString["Id"]);
            i = _db.InsertUpdate_EmailTemplates(Id, txtcode.Text.Trim(), txtsubject.Text.Trim(), txtbody.Text, txtnote.Text);
        }
        else
        {
            i = _db.InsertUpdate_EmailTemplates(0, txtcode.Text.Trim(), txtsubject.Text.Trim(), txtbody.Text, txtnote.Text);
        }

        Response.Redirect("~/cms/emailtemplex.aspx");
    }
   
}