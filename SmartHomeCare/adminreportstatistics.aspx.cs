using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class adminreportstatistics : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        siteadmin _siteadmin = (siteadmin)this.Master;
        TreeView treeview = _siteadmin.treeview;
        BaseView.SelectedTreeView(treeview, siteadmin.REPORTS,siteadmin.STATISTICS);
    }
}