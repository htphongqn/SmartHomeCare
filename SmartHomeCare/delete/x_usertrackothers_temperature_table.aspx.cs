using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
public partial class usertrackothers_temperature_table : System.Web.UI.Page
{
    private DBClass _db = new DBClass();
    string Username = "";
    DataTable dt = new DataTable();
    protected void Page_Load(object sender, EventArgs e)
    {
        //siteuser _siteuser = (siteuser)this.Master;
        //TreeView treeview = _siteuser.treeview;
        //BaseView.SelectedTreeView(treeview, siteuser.REPORTS, siteuser.TRACKOTHERS);
        if (Session["AuthorizedUser"] != null)
        {
            LoadGridviewTemp();
        }
        else
        {
            Response.Redirect("~/usertrackothers.aspx");
        }
        if (!IsPostBack)
        {
            
            ShowData();
            LoadTime();
        }
    }
    
    private void LoadGridviewTemp()
    {
        DataRow row = (DataRow)Session["User"];
        if (row != null)
        {
            string UserName = BaseView.GetStringFieldValue(row, "UserName");
            string FromDate = txtFromDate.Text;
            string FromH = drpFromH.Text;
            string FromM = drpFromM.Text;
            string ToDate = txtToDate.Text;
            string ToH = drpToH.Text;
            string ToM = drpToM.Text;
            DateTime? fromdate = null;
            try
            {
                fromdate = DateTime.Parse(FromDate + " " + FromH + ":" + FromM);
            }
            catch { }

            DateTime? todate = null;
            try
            {
                todate = DateTime.Parse(ToDate + " " + ToH + ":" + ToM);
            }
            catch { }
            if (Session["AuthorizedUser"] != null)
            {
                UserName = (string)Session["AuthorizedUser"];
            }
            if (txtFromDate.Text == "" && txtToDate.Text == "")
            {
                fromdate = null;
                todate = null;
            }
            DataTable dt = _db.GetList_UserTemperature(UserName, fromdate, todate);
            grvTemp.DataSource = dt;
            grvTemp.DataBind();
        }
    }
    void LoadTime()
    {
        for (int i = 0; i < 60; i++)
        {
            string M = "";

            if (i.ToString().Length < 2)
                M += "0";
            M += i.ToString();
            drpToM.Items.Add(M);
            drpFromM.Items.Add(M);
        }
        for (int i = 0; i < 24; i++)
        {
            string Hours = "";

            if (i.ToString().Length < 2)
                Hours += "0";
            Hours += i.ToString();
            drpToH.Items.Add(Hours);
            drpFromH.Items.Add(Hours);
        }
    }
    protected void btnFilter_Click(object sender, EventArgs e)
    {
        LoadGridviewTemp();
    }
    private void ShowData()
    {
        
        DataRow dr;
        if (Session["AuthorizedUser"]!=null)
        {
            Username = (string)Session["AuthorizedUser"];
            dt = _db.GetInfo_UserAll_ByUserName(Username);

            if (dt.Rows.Count > 0)
            {
                dr = dt.Rows[0];
                lbNameHealth.Text = dr["Firstname"].ToString() + " " + dr["Lastname"].ToString();
            }
            else
                lbNameHealth.Text = Username;

        }


    }
    protected void btntable_Click(object sender, EventArgs e)
    {

    }
    protected void Button1_Click(object sender, EventArgs e)
    {
       
      Response.Redirect("~/usertrackothers_temperature_settings.aspx");
       
    }
    protected void grvTemp_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        grvTemp.PageIndex = e.NewPageIndex;
        LoadGridviewTemp();
    }
}