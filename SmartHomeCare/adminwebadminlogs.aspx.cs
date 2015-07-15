using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class adminwebadminlogs : System.Web.UI.Page
{
    private DBClass _db = new DBClass();
    int i=0;
    protected void Page_Load(object sender, EventArgs e)
    {
        //siteadmin _siteadmin = (siteadmin)this.Master;
        //TreeView treeview = _siteadmin.treeview;
        //BaseView.SelectedTreeView(treeview, siteadmin.LOGS, siteadmin.WEBADMINLOGS);
       
        if (!IsPostBack)
        {
            LoadListLogs(0);
        }
    }
    private void LoadListLogs(int index)
    {
        DateTime temp = new DateTime();
        DateTime? from = null;
        bool isfromdate = DateTime.TryParse(txtfromdate.Text, out temp);
        if (isfromdate)
            from = temp;
        DateTime? to = null;
        bool istodate = DateTime.TryParse(txttodate.Text, out temp);
        if (istodate)
            to = temp;
        DataTable dt = _db.GetList_User_Login(ToSQL.EmptyNull(txtusername.Text), from, to);
        grdlogs.PageIndex = index;
        grdlogs.DataSource = dt;
        grdlogs.DataBind();
        pager(index);
    }
    protected void btnfilter_Click(object sender, EventArgs e)
    {
        LoadListLogs(0);
    }
    protected void grdlogs_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        grdlogs.PageIndex = e.NewPageIndex;
        LoadListLogs(0);
    }
    #region pager
    protected void back_Click(object sender, ImageClickEventArgs e)
    {
        i = grdlogs.PageIndex;
        if (grdlogs.PageIndex > 0)
        {
            grdlogs.PageIndex = i--;
            LoadListLogs(i);
            pager(i);
        }
    }
    protected void next_Click(object sender, ImageClickEventArgs e)
    {
        if (grdlogs.PageIndex < grdlogs.PageCount - 1)
        {
            i = grdlogs.PageIndex;
            grdlogs.PageIndex = i++;
            LoadListLogs(i);
            pager(i);
        }
    }
    private void pager(int index)
    {
        int pagecount = index + 1;
        txtpage.Text = pagecount.ToString();
        lb_pager.Text = "/" + grdlogs.PageCount.ToString();
    }
    protected void txtpage_TextChanged(object sender, EventArgs e)
    {
        int page = Int32.Parse(txtpage.Text);
        int index = page - 1;
        LoadListLogs(index);
        pager(index);
    }
    #endregion
}