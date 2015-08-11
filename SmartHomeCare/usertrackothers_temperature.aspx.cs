using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Drawing;
using DevExpress.XtraCharts;

public partial class usertrackothers_temperature : System.Web.UI.Page
{
    private DBClass _db = new DBClass();
    string Username = "";
    DataTable dt = new DataTable();
    int i = 0;
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
            //siteuser _siteuser = (siteuser)this.Master;
            //TreeView treeview = _siteuser.treeview;
            //BaseView.SelectedTreeView(treeview, siteuser.REPORTS, siteuser.TRACKMYHEALTH);
            LoadTime();
            LoadDateTime();
            //LoadTempUser();
            Select_graph(false);
            LoadGridviewTemp(0);
            if (Session["FromDateTemperatureOthers"] == null && Session["ToDateTemperatureOthers"] == null)
            {
                date_graph.Visible = true;
            }
            else
            {
                date_graph.Visible = false;
            }
        }
    }

    #region Page

    /**
       * [getUserName] get username from session
       * */
    private string userName()
    {
        DataRow rowcurrentuser = (DataRow)Session["AuthorizedUser"];
        if (rowcurrentuser != null)
        {
            return BaseView.GetStringFieldValue(rowcurrentuser, "Username");
        }
        else
            return "";
    }
    /**
        * [NullName] load FullName
        * */
    private void Fullname()
    {
        DataRow row = (DataRow)Session["AuthorizedUser"];
        lbNameHealth.Text = BaseView.GetStringFieldValue(row, "FullName");
    }
    #endregion

    protected void grvTemp_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        grvTemp.PageIndex = e.NewPageIndex;
        LoadGridviewTemp(0);
    }

    private void LoadTempUser()
    {
        DataRow row = (DataRow)Session["User"];
        if (row != null)
        {
            DateTime fromTime = DateTime.MinValue, toTime;
            DateTime.TryParse(txtFromDateChart.Text, out fromTime);
            DateTime.TryParse(txtToDateChart.Text, out toTime);
            if (toTime == DateTime.MinValue)
                toTime = DateTime.MaxValue.Date;
            if (fromTime == DateTime.MinValue)
                fromTime = DateTime.Now.Date;
            DataTable dt = _db.GetList_UserTemperature(userName(), fromTime, toTime);
            if (dt.Rows.Count > 0)
            {
                //lbDataEmpty.Visible = false;
                AddSeriesChart(dt);
                pnEmptyData.Visible = false;
                pnChart.Visible = true;
            }
            else
            {
                pnChart.Visible = false;
                pnEmptyData.Visible = true;
            }

        }
    }
    private void LoadGridviewTemp(int index)
    {
        DataRow row = (DataRow)Session["User"];
        if (row != null)
        {
            //string UserName = BaseView.GetStringFieldValue(row, "UserName");
            //string FromDate = txtFromDate.Text;
            //string FromH = drpFromH.Text;
            //string FromM = drpFromM.Text;
            //string ToDate = txtToDate.Text;
            //string ToH = drpToH.Text;
            //string ToM = drpToM.Text;
            //DateTime? fromdate = null;
            //try
            //{
            //    fromdate = DateTime.Parse(FromDate + " " + FromH + ":" + FromM);
            //}
            //catch { }

            //DateTime? todate = null;
            //try
            //{
            //    todate = DateTime.Parse(ToDate + " " + ToH + ":" + ToM);
            //}
            //catch { }

            //if (txtFromDate.Text == "" && txtToDate.Text == "")
            //{
            //    fromdate = null;
            //    todate = null;
            //}
            DataTable dt = _db.GetList_UserTemperature(userName(), fromDate(), toDate());
            grvTemp.PageIndex = index;
            grvTemp.DataSource = dt;
            grvTemp.DataBind();
            pager(index);
        }
    }
    void LoadTime()
    {
        //for (int i = 0; i < 60; i++)
        //{   string M="";

        //    if(i.ToString().Length < 2)
        //        M += "0";
        //    M += i.ToString();
        //    drpToM.Items.Add(M);
        //    drpFromM.Items.Add(M);
        //}
        //for (int i = 0; i < 24; i++)
        //{
        //    string Hours = "";

        //    if (i.ToString().Length < 2)
        //        Hours += "0";
        //    Hours += i.ToString();
        //    drpToH.Items.Add(Hours);
        //    drpFromH.Items.Add(Hours);
        //}
    }
    private void AddSeriesChart(DataTable dt)
    {
        ChartTemperature.Series.Clear();
        ChartTemperature.Titles.Clear();
        DevExpress.XtraCharts.Web.WebChartControl ch1 = ChartTemperature;
        if (dt != null && dt.Rows.Count > 0)
        {
            DevExpress.XtraCharts.Series sNormal = new DevExpress.XtraCharts.Series("Normal", DevExpress.XtraCharts.ViewType.Line);
            DevExpress.XtraCharts.Series sHigh = new DevExpress.XtraCharts.Series("High", DevExpress.XtraCharts.ViewType.Line);
            DevExpress.XtraCharts.Series sVeryHigh = new DevExpress.XtraCharts.Series("Very High", DevExpress.XtraCharts.ViewType.Line);
            DevExpress.XtraCharts.Series sKinTemp = new DevExpress.XtraCharts.Series("Skin Temp", DevExpress.XtraCharts.ViewType.Line);
            DevExpress.XtraCharts.Series sAmbTemp = new DevExpress.XtraCharts.Series("Amb Temp", DevExpress.XtraCharts.ViewType.Line);

            sNormal.View.Color = System.Drawing.Color.Lime;
            sHigh.View.Color = System.Drawing.Color.Orange;
            sVeryHigh.View.Color = System.Drawing.Color.OrangeRed;
            sKinTemp.View.Color = System.Drawing.Color.Black;
            sAmbTemp.View.Color = System.Drawing.Color.Red;

            //sNormal.LinePen.Width = 3;
            //sHigh.LinePen.Width = 3;
            //sVeryHigh.LinePen.Width = 3;

            double TempNormal = 97, TempHigh = 100.4, TempVeryHigh = 103.9;
            if (GetIsUSOrMetricForUser(userName()))
            {
                ChartTitle chartTitle1 = new ChartTitle();
                chartTitle1.Text = "Temperature (°F)";
                ch1.Titles.Add(chartTitle1);
                //ch1.Axes.Left.Title.Text = "Temperature (°F)";
                TempNormal = 97;
                TempHigh = 100.4;
                TempVeryHigh = 103.9;
                foreach (DataRow row in dt.Rows)
                {
                    sNormal.Points.Add(new DevExpress.XtraCharts.SeriesPoint(BaseView.GetDateTimeFieldValue(row, "ReceivedDate"), TempNormal));
                    sHigh.Points.Add(new DevExpress.XtraCharts.SeriesPoint(BaseView.GetDateTimeFieldValue(row, "ReceivedDate"), TempHigh));
                    sVeryHigh.Points.Add(new DevExpress.XtraCharts.SeriesPoint(BaseView.GetDateTimeFieldValue(row, "ReceivedDate"), TempVeryHigh));
                    sKinTemp.Points.Add(new DevExpress.XtraCharts.SeriesPoint(BaseView.GetDateTimeFieldValue(row, "ReceivedDate"), BaseView.GetFloatFieldValue(row, "SkinTemp")));
                    sAmbTemp.Points.Add(new DevExpress.XtraCharts.SeriesPoint(BaseView.GetDateTimeFieldValue(row, "ReceivedDate"), BaseView.GetFloatFieldValue(row, "AmbTemp")));
                }
            }
            else
            {
                //ch1.Axes.Left.Title.Text = "Temperature (°C)";
                ChartTitle chartTitle1 = new ChartTitle();
                chartTitle1.Text = "Temperature (°C)";
                ch1.Titles.Add(chartTitle1);
                TempNormal = 36.1;
                TempHigh = 38;
                TempVeryHigh = 39.9;
                foreach (DataRow row in dt.Rows)
                {
                    sNormal.Points.Add(new DevExpress.XtraCharts.SeriesPoint(BaseView.GetDateTimeFieldValue(row, "ReceivedDate"), TempNormal));
                    sHigh.Points.Add(new DevExpress.XtraCharts.SeriesPoint(BaseView.GetDateTimeFieldValue(row, "ReceivedDate"), TempHigh));
                    sVeryHigh.Points.Add(new DevExpress.XtraCharts.SeriesPoint(BaseView.GetDateTimeFieldValue(row, "ReceivedDate"), TempVeryHigh));
                    sKinTemp.Points.Add(new DevExpress.XtraCharts.SeriesPoint(BaseView.GetDateTimeFieldValue(row, "ReceivedDate"), BaseView.GetFloatFieldValue(row, "SkinTempC")));
                    sAmbTemp.Points.Add(new DevExpress.XtraCharts.SeriesPoint(BaseView.GetDateTimeFieldValue(row, "ReceivedDate"), BaseView.GetFloatFieldValue(row, "AmbTempC")));
                }
            }

            //Steema.TeeChart.Legend le = new Steema.TeeChart.Legend(ch1);

            //ch1.Axes.Bottom.Labels.DateTimeFormat = "MM/dd/yyyy HH:mm";
            //ch1.Axes.Left.SetMinMax(TempNormal - 10, TempVeryHigh + 10);
            ch1.Series.Add(sNormal);
            ch1.Series.Add(sHigh);
            ch1.Series.Add(sVeryHigh);
            ch1.Series.Add(sKinTemp);
            ch1.Series.Add(sAmbTemp);
        }
    }
    public bool GetIsUSOrMetricForUser(string username)
    {
        return _db.Get_IsUS_UserTrackMyHealth_ByUserName(username);
    }
    private void Select_graph(bool q)
    {
        btnGraph2.Enabled = q;
        btnTable2.Enabled = !btnGraph2.Enabled;
        if (btnGraph2.Enabled == false)
        {
            btnGraph2.BackColor = ColorTranslator.FromHtml("#e6e6e6");
            btnTable2.BackColor = ColorTranslator.FromHtml("#fff");
        }
        else
        {
            btnGraph2.BackColor = ColorTranslator.FromHtml("#fff");
            btnTable2.BackColor = ColorTranslator.FromHtml("#e6e6e6");
        }
    }
    protected void btnGraph2_Click(object sender, EventArgs e)
    {
        MultiViewTemperature.ActiveViewIndex = 0;
        LoadTempUser();
        Select_graph(false);
    }
    protected void btnTable2_Click(object sender, EventArgs e)
    {
        MultiViewTemperature.ActiveViewIndex = 1;
        Select_graph(true);
    }
    protected void btnFilter_Click(object sender, EventArgs e)
    {
        //LoadTempUser();
        LoadGridviewTemp(0);
        date_table.Visible = false;
    }
    protected void Button1_Click(object sender, EventArgs e)
    {

        Response.Redirect("~/usertrackothers_temperature_settings.aspx");

    }
    protected void btntable_Click(object sender, EventArgs e)
    {

    }

    #region pager
    protected void back_Click(object sender, ImageClickEventArgs e)
    {
        i = grvTemp.PageIndex;
        if (grvTemp.PageIndex > 0)
        {

            grvTemp.PageIndex = i--;
            LoadGridviewTemp(i);
            pager(i);
        }
    }
    protected void next_Click(object sender, ImageClickEventArgs e)
    {
        if (grvTemp.PageIndex < grvTemp.PageCount - 1)
        {
            i = grvTemp.PageIndex;
            grvTemp.PageIndex = i++;
            LoadGridviewTemp(i);
            pager(i);
        }
    }
    private void pager(int index)
    {
        int pagecount = index + 1;
        txtpage.Text = pagecount.ToString();
        lb_pager.Text = "/" + grvTemp.PageCount.ToString();
    }
    private void pager2(int index)
    {
        //int pagecount = index + 1;
        ////txt_page2.Text = pagecount.ToString();
        //lbpage2.Text = "/" + grvHVRData.PageCount.ToString();
    }
    protected void txtpage_TextChanged(object sender, EventArgs e)
    {
        int page = Int32.Parse(txtpage.Text);
        int index = page - 1;
        // Load_TableHeartRate(index);
        pager(index);
    }
    protected void btn_back1_Click(object sender, ImageClickEventArgs e)
    {
        //j = grvHVRData.PageIndex;
        //if (grvHVRData.PageIndex > 0)
        //{

        //    grvHVRData.PageIndex = j--;
        //    Load_TableHRV(j);
        //    pager(j);
        //}
    }
    protected void btn_next2_Click(object sender, ImageClickEventArgs e)
    {
        //if (grvHVRData.PageIndex < grvHVRData.PageCount - 1)
        //{
        //    j = grvHVRData.PageIndex;
        //    grvHVRData.PageIndex = j++;

        //    Load_TableHRV(j);
        //    pager(j);
        //}
    }
    protected void txt_page2_TextChanged(object sender, EventArgs e)
    {
        //int page = Int32.Parse(txt_page2.Text);
        //int index = page - 1;
        //Load_TableHRV(index);
        //pager2(index);
    }
    #endregion

    protected void btnOk_Click(object sender, EventArgs e)
    {
        pnEmptyData.Visible = false;
        Session["ToDateTemperatureOthers"] = toDate();
        if (fromDate().Year > 1753)
        {
            Session["FromDateTemperatureOthers"] = fromDate();
        }
        else
        {
            MessagesBox.jQueryShow(ClientScript, this.GetType(), DBClass.GetMessageByCode2("SelectTime"), "Notice");
            pnEmptyData.Visible = true;
            return;
        }
        LoadTempUser();
        LoadGridviewTemp(0);
        date_graph.Visible = false;
    }

    private DateTime fromDate()
    {
        DateTime fromTime = DateTime.MinValue;
        string fromT = "";
        if (txtFromDateChart.Text == "" || String.IsNullOrEmpty(txtFromDateChart.Text))
        {
            fromT = txtFromDate.Text;
        }
        else
        {
            fromT = txtFromDateChart.Text;
        }
        DateTime.TryParse(fromT, out fromTime);
        if (fromTime == DateTime.MinValue)
            fromTime = DateTime.Now.Date;
        return fromTime;
    }
    private DateTime toDate()
    {
        DateTime toTime;
        string toT = "";
        if (txtToDateChart.Text == "" || String.IsNullOrEmpty(txtToDateChart.Text))
        {
            toT = txtToDate.Text;
        }
        else
        {
            toT = txtToDateChart.Text;
        }
        DateTime.TryParse(toT, out toTime);
        if (toTime == DateTime.MinValue)
            toTime = DateTime.Now.Date;
        return toTime;
    }

    private void LoadDateTime()
    {
        if (Session["FromDateTemperatureOthers"] != null)
        {
            DateTime startdate = (DateTime)Session["FromDateTemperatureOthers"];
            if (startdate.Year > 1753)
            {
                txtFromDate.Text = startdate.ToShortDateString();
                txtFromDateChart.Text = startdate.ToShortDateString();
            }
        }

        if (Session["ToDateTemperatureOthers"] != null)
        {
            DateTime startdate = (DateTime)Session["ToDateTemperatureOthers"];
            if (startdate.Year > 1753)
            {
                txtToDate.Text = startdate.ToShortDateString();
                txtToDateChart.Text = startdate.ToShortDateString();
            }
        }
    }
    protected void lbtnDateTime_Click(object sender, EventArgs e)
    {
        date_graph.Visible = true;
    }
    protected void btnCancel_Click(object sender, EventArgs e)
    {
        date_graph.Visible = false;
    }
    protected void btncancelTable_Click(object sender, EventArgs e)
    {
        date_table.Visible = false;
    }
    protected void lbPopup_Click(object sender, EventArgs e)
    {
        date_table.Visible = true;
    }
}