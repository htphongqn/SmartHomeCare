using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;

public partial class cms_parameter : System.Web.UI.Page
{
    DBClass _cl = new DBClass();
    DataSet ds = new DataSet();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            ShowParameter();
        }
    }
    protected void btnAddnew_Click(object sender, EventArgs e)
    {

    }
    void ShowParameter()
    {
        ds = _cl.GetList_Paramaters(0,"", "");
        grdParameter.DataSource = ds;
        grdParameter.DataBind();
    }
}