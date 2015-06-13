using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
public partial class cms_EmailTemplex : System.Web.UI.Page
{
    DBClass _db = new DBClass();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            LoadListEmail();
        }
    }
    private void LoadListEmail()
    {
        DataTable dt = _db.GetList_EmailTemplates();
        grvemailtemplates.DataSource = dt;
        grvemailtemplates.DataBind();
    }
}