using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class adminusermanagement : System.Web.UI.Page
{
    private DBClass _db = new DBClass();
    protected void Page_Load(object sender, EventArgs e)
    {
        //siteadmin _siteadmin = (siteadmin)this.Master;
        //TreeView treeview = _siteadmin.treeview;
        //BaseView.SelectedTreeView(treeview, siteadmin.USERMANAGEMENT);

        if (!IsPostBack)
        {
            LoadListUser();
        }

    }

    private void LoadListUser()
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
        bool? active = null;
        if (ddlactive.SelectedValue == "1")
            active = true;
        else if (ddlactive.SelectedValue == "0")
            active = false;
        DataTable dt = _db.GetList_Users(ToSQL.SQLToInt(txtuserid.Text.Trim()), ToSQL.EmptyNull(txtusername.Text), active, ToSQL.EmptyNull(txtemail.Text), from, to);
        grdusermanagement.DataSource = dt;
        grdusermanagement.DataBind();
    }
    protected void btnactive_Click(object sender, EventArgs e)
    {
        string ids = GetCheckIds();

        _db.IsActive_User_ByIds(ids, true);
        LoadListUser();
    }    
    protected void btndeactive_Click(object sender, EventArgs e)
    {
        string ids = GetCheckIds();

        _db.IsActive_User_ByIds(ids, false);
        LoadListUser();
    }
    private string GetCheckIds()
    {
        string ids = "";
        for (int i = 0; i < grdusermanagement.Rows.Count; i++)
        {
            if (grdusermanagement.Rows[i].RowType == DataControlRowType.DataRow)
            {
                CheckBox chkcheckuser = (CheckBox)grdusermanagement.Rows[i].Cells[0].FindControl("chkcheckuser");

                if (chkcheckuser.Checked)
                {
                    HyperLink hplID = (HyperLink)grdusermanagement.Rows[i].Cells[0].FindControl("hplID");
                    ids += hplID.Text + ",";
                }
            }
        }
        return ids;
    }

    protected void grdusermanagement_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        grdusermanagement.PageIndex = e.NewPageIndex;
        LoadListUser();
    }
    protected void btnfilter_Click(object sender, EventArgs e)
    {
        LoadListUser();
    }
}