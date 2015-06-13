using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Web.UI.DataVisualization.Charting;
public partial class usertrackothers_temperature_graph : System.Web.UI.Page
{
    private DBClass _db = new DBClass();
    string Username = "";
    DataTable dt = new DataTable();
    protected void Page_Load(object sender, EventArgs e)
    {
        siteuser _siteuser = (siteuser)this.Master;
        TreeView treeview = _siteuser.treeview;
        BaseView.SelectedTreeView(treeview, siteuser.REPORTS, siteuser.TRACKOTHERS);
       if (Session["AuthorizedUser"] == null)
        {
            Response.Redirect("~/usertrackothers.aspx");
        }
       else
        {
            LoadTempUser();
        }
       
        if (!IsPostBack)
        {
            ShowData();
            LoadTime();
        }
    }
    private void ShowData()
    {
        DataRow row = (DataRow)Session["User"];
        Username = row["username"].ToString();
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
    private void LoadTempUser()
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
            if (Session["AuthorizedUser"]!=null)
            {
                UserName = (string)Session["AuthorizedUser"];
            }
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
                
                lbDataEmpty.Visible = true;
            }
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

    private void ReadText()
    {
        string text = "Thích Là Nhích";
        Dictionary<char, int> dictCount = new Dictionary<char, int>();
        foreach (char chr in text)
        {
            if (dictCount.ContainsKey(chr))
            {
                dictCount[chr]++;
            }
            else
            {
                dictCount.Add(chr, 1);
            }
        }
        foreach (KeyValuePair<char, int> rs in dictCount)
        {
            Console.WriteLine("{0} = {1} \n", rs.Key, rs.Value);
        }
    }
    protected void btnFilter_Click(object sender, EventArgs e)
    {
        LoadTempUser();
    }
    protected void Button1_Click(object sender, EventArgs e)
    {
            Response.Redirect("~/usertrackothers_temperature_settings.aspx");
        
    }
    protected void btntable_Click(object sender, EventArgs e)
    {

    }
}