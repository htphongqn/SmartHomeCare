using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Web.UI.DataVisualization.Charting;

public partial class usertrackmyhealth_temperature_graph : System.Web.UI.Page
{
    private DBClass _db = new DBClass();
    string UserName = "";
    DataTable dt = new DataTable();
    protected void Page_Load(object sender, EventArgs e)
    {

        if (Session["User"] == null)
        {
            Response.Redirect("~/home.aspx");
        }
        if (Session["AuthorizedUser"] == null)
        {
            Response.Redirect("~/usertrackothers.aspx");
        }
        if (!IsPostBack)
        {
            siteuser _siteuser = (siteuser)this.Master;
            TreeView treeview = _siteuser.treeview;
            BaseView.SelectedTreeView(treeview, siteuser.REPORTS, siteuser.TRACKOTHERS);
            treeview.Nodes[siteuser.REPORTS].ChildNodes[siteuser.TRACKOTHERS].ChildNodes.AddAt(0, new TreeNode("Temperature", "0"));
            treeview.Nodes[siteuser.REPORTS].ChildNodes[siteuser.TRACKOTHERS].Expand();
            treeview.Nodes[siteuser.REPORTS].ChildNodes[siteuser.TRACKOTHERS].ChildNodes[0].Selected = true;
            LoadTempUser();
            fullName();
            LoadTime();
            LoadGridviewTemp();
        }

    }
    protected void grvTemp_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        grvTemp.PageIndex = e.NewPageIndex;
        LoadGridviewTemp();
    }
    private void fullName()
    {
        
        if (Session["AuthorizedUser"] != null)
        {
            DataRow rowcurrentuser = (DataRow)Session["AuthorizedUser"];
            UserName = BaseView.GetStringFieldValue(rowcurrentuser, "Username");
          
            lbNameHealth.Text = BaseView.GetStringFieldValue(rowcurrentuser, "Fullname");
            
        }
     

    }
    private void LoadTempUser()
    {
        if (Session["AuthorizedUser"] != null)
        {
            DataRow rowcurrentuser = (DataRow)Session["AuthorizedUser"];
            UserName = BaseView.GetStringFieldValue(rowcurrentuser, "Username");
            string FromDate = txtFromDate.Text;
            string FromH = drpFromH.Text;
            string FromM = drpFromM.Text;
            string ToDate = txtToDate.Text;
            string ToH = drpToH.Text;
            string ToM = drpToM.Text;
            DateTime? fromdate = null;
            try
            {
                fromdate = DateTime.Parse(FromDate+" "+FromH+":"+FromM);
            }
            catch { }

            DateTime? todate = null;
            try
            {
                todate = DateTime.Parse(ToDate + " " + ToH + ":" + ToM);
            }
            catch { }
            if (txtFromDate.Text == "" && txtToDate.Text == "")
            {
                fromdate = null;
                todate = null;
            }
            
            DataTable dt = _db.GetList_UserTemperature(UserName, fromdate, todate);
            if (dt.Rows.Count > 1)
            {
                lbDataEmpty.Visible = false;
                AddSeriesChart(dt);
                ChartTemperature.DataSource = dt;
                ChartTemperature.DataBind();
            }
            else
            {
               // ChartTemperature.Visible = false;
                lbDataEmpty.Visible = true;
            }
           
        }
    }
    private void LoadGridviewTemp()
    {
        if (Session["AuthorizedUser"] != null)
        {
            DataRow rowcurrentuser = (DataRow)Session["AuthorizedUser"];
            UserName = BaseView.GetStringFieldValue(rowcurrentuser, "Username");
            
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
        {   string M="";
           
            if(i.ToString().Length < 2)
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
    private void AddSeriesChart(DataTable dt)
    {
        if (dt != null && dt.Rows.Count > 0)
        {
            Series sNormal = new Series();
            Series sHigh = new Series();
            Series sVeryHigh = new Series();
            sNormal.ChartType = SeriesChartType.Line;
            sHigh.ChartType = SeriesChartType.Line;
            sVeryHigh.ChartType = SeriesChartType.Line;
            sNormal.BorderWidth = sHigh.BorderWidth = sVeryHigh.BorderWidth = 2;
            sNormal.Color = System.Drawing.Color.Lime;
            sHigh.Color = System.Drawing.Color.Orange;
            sVeryHigh.Color = System.Drawing.Color.OrangeRed;
            foreach (DataRow row in dt.Rows)
            {
                sNormal.Points.AddXY(BaseView.GetDateTimeFieldValue(row, "ReceivedDate"), 35);
                sHigh.Points.AddXY(BaseView.GetDateTimeFieldValue(row, "ReceivedDate"), 99.6);
                sVeryHigh.Points.AddXY(BaseView.GetDateTimeFieldValue(row, "ReceivedDate"), 103);
            }
            sNormal.ChartArea = "ChartAreaTemperature";
            sHigh.ChartArea = "ChartAreaTemperature";
            sVeryHigh.ChartArea = "ChartAreaTemperature";
            ChartTemperature.Series.Add(sNormal);
            ChartTemperature.Series.Add(sHigh);
            ChartTemperature.Series.Add(sVeryHigh);
        }
    }

    protected void btnFilter_Click(object sender, EventArgs e)
    {
        LoadTempUser();
        LoadGridviewTemp();
    }
    protected void Button1_Click(object sender, EventArgs e)
    {
            Response.Redirect("~/usertrackothers_temperature_settings.aspx");
       
    }
    protected void btntable_Click(object sender, EventArgs e)
    {

    }
}