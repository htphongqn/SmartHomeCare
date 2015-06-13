using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
public partial class Admin_adminmessages : System.Web.UI.Page
{
    DBClass _cl = new DBClass();
    DataSet ds = new DataSet();
    DataTable dt = new DataTable();
    protected void Page_Load(object sender, EventArgs e)
    {
        if(!IsPostBack)
        {
            ShowData();
        }
    }
    void ShowData()
    {
        ds = _cl.GetList_AdminMessages(0,"","");
        grdMessages.DataSource = ds;
        grdMessages.DataBind();
    }
    protected void grdMessages_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        grdMessages.PageIndex = e.NewPageIndex;
        ShowData();
    }
}