using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

public partial class cms_register_code : System.Web.UI.Page
{
    DataTable dt = new DataTable();
    DBClass _db = new DBClass();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {

            Load_RegisCode();
            LoadRule();
        }
    }
    void LoadRule()
    {
        ddlRule.DataSource = DBClass.GetDataTable("spGetList_MemberType");
        ddlRule.DataTextField = "RuleName";
        ddlRule.DataValueField = "RuleCode";
        ddlRule.DataBind();
        ddlRule.Items.Insert(0,new ListItem("(All)","0"));
    }
    DataTable table_Regiscode()
    {
        string RuleCode;
        bool? IsUsing;
        bool? Disable;
        RuleCode = ddlRule.SelectedValue;
        int s = Convert.ToInt32(ddlDisable.SelectedValue);
        Disable = Convert.ToBoolean(s);
        s = Convert.ToInt32(ddlIsUsing.SelectedValue);
        IsUsing = Convert.ToBoolean(s);
        if (ddlRule.SelectedValue == "0")
            RuleCode = "";

        if (ddlIsUsing.SelectedValue == "2")
            IsUsing = null;

        if (ddlDisable.SelectedValue == "2")
            Disable = null;
        dt = _db.GetList_RegisterCodes(RuleCode, IsUsing, Disable);
        return dt;
    }
    void Load_RegisCode()
    {
        dt = table_Regiscode();
        grvRegister.DataSource = dt;
        grvRegister.DataBind();
    }
    protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        grvRegister.PageIndex = e.NewPageIndex;
        Load_RegisCode();
    }
    protected void ddlRule_SelectedIndexChanged(object sender, EventArgs e)
    {
        
    }
    protected void btnfilter_Click(object sender, EventArgs e)
    {
        Load_RegisCode();
    }

    protected void GridView1_Sorting(object sender, GridViewSortEventArgs e)
    {
        dt = table_Regiscode();
        if(dt !=null)
        {
            DataView dv = new DataView();
            dv = dt.DefaultView;
            dv.Sort = e.SortExpression + " " + getSortDirectionString(e.SortDirection);
            grvRegister.DataSource = dv;
            grvRegister.DataBind();
        }
     
    }
    private string getSortDirectionString(SortDirection sortDirection)
    {
        string newSortDirection = String.Empty;
        if (sortDirection == SortDirection.Ascending)
        {
            //newSortDirection = "ASC";
            newSortDirection = "DESC";
        }
        else
        {
            //newSortDirection = "DESC";
            newSortDirection = "ASC";
        }
        return newSortDirection;
    }
}