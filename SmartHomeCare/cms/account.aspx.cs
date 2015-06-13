using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
public partial class Admin_account : System.Web.UI.Page
{
    DBClass _cl = new DBClass();
    DataSet ds = new DataSet();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            ShowInfoUser();
        }
    }
    void ShowInfoUser()
    {
        ds = _cl.GetList_Users_Admin("","","",null,null);
        grdParameter.DataSource = ds;
        grdParameter.DataBind();
    }
    protected void grdParameter_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        grdParameter.PageIndex = e.NewPageIndex;
        ShowInfoUser();
    }
}