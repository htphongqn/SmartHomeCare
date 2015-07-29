using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.DataVisualization.Charting;
using Steema;
using Steema.TeeChart;
using System.Drawing;
using System.IO;
using Steema.TeeChart.Web;
using System.Collections;

public partial class usertrackothers_heartrate : System.Web.UI.Page
{
    private DBClass _db = new DBClass();
    private DataTable dt = new DataTable();
    private float maxMeanHR = 0, maxStdHR = 0, maxMeanRR = 0, maxSDNN = 0, maxRMSSD = 0, maxNN50 = 0, maxpNN50 = 0;

    private MemoryStream tmpChart = new MemoryStream();
    int i = 0;
    int j = 0;
    private int clickedX;
    private int clickedY;
    private string msgText;
    protected void Page_Load(object sender, EventArgs e)
    {
        clickedX = -1;
        clickedY = -1;
        msgText = "";
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
            //BaseView.SelectedTreeView(treeview, siteuser.REPORTS, siteuser.TRACKOTHERS);
            //treeview.Nodes[siteuser.REPORTS].ChildNodes[siteuser.TRACKOTHERS].ChildNodes.AddAt(0, new TreeNode("Heart Rate", "0"));
            //treeview.Nodes[siteuser.REPORTS].ChildNodes[siteuser.TRACKOTHERS].Expand();
            //treeview.Nodes[siteuser.REPORTS].ChildNodes[siteuser.TRACKOTHERS].ChildNodes[0].Selected = true;
            LoadDateTime();
            fullName();
            LoadHeartRateData();
            Select_graph(false);
            if (Session["FromDateHeartRate"] == null && Session["ToDateHeartRate"] == null)
            {
                date_graph.Visible = true;
            }
            else
            {
                date_graph.Visible = false;
            }
        }
        
    }
    private void fullName()
    {
        if (Session["AuthorizedUser"] != null)
        {
            DataRow rowcurrentuser = (DataRow)Session["AuthorizedUser"];
            lbNameHealth.Text = BaseView.GetStringFieldValue(rowcurrentuser, "Fullname");

        }
    }

    private string userName()
    {
        DataRow row = (DataRow)Session["User"];
        if (row == null)
            return null;
        else
            return BaseView.GetStringFieldValue(row, "Username");
    }
    #region Graph
    private void LoadHRVData()
    {
        DateTime fromDate = DateTime.MinValue, toDate;
        DateTime.TryParse(txtFromDate.Text, out fromDate);
        DateTime.TryParse(txtToDate.Text, out toDate);
        if (toDate == DateTime.MinValue)
            toDate = DateTime.MaxValue.Date;
        if (fromDate == DateTime.MinValue)
            fromDate = DateTime.Now.Date;
        DataSet ds = _db.GetList_HeartRate_HRV_Graph(userName(), fromDate, toDate);
        if (ds == null || ds.Tables.Count <= 0)
        {
            pnHRVData.Visible = false;
            pnHeartRateData.Visible = false;
            pnEmptyData.Visible = true;
        }
        else
        {
            DataTable dtMax = ds.Tables[0];
            if (dtMax != null && dtMax.Rows.Count > 0)
            {
                maxMeanHR = BaseView.GetFloatFieldValue(dtMax.Rows[0], "maxMeanHR");
                maxStdHR = BaseView.GetFloatFieldValue(dtMax.Rows[0], "maxStdHR");
                maxMeanRR = BaseView.GetFloatFieldValue(dtMax.Rows[0], "maxMeanRR");
                maxSDNN = BaseView.GetFloatFieldValue(dtMax.Rows[0], "maxSDNN");
                maxRMSSD = BaseView.GetFloatFieldValue(dtMax.Rows[0], "maxRMSSD");
                maxNN50 = BaseView.GetFloatFieldValue(dtMax.Rows[0], "maxNN50");
                maxpNN50 = BaseView.GetFloatFieldValue(dtMax.Rows[0], "maxpNN50");
            }
            DataTable dtChart = ds.Tables[1];
            dtlChart.DataSource = dtChart;
            dtlChart.DataBind();
            pnHeartRateData.Visible = false;
            pnHRVData.Visible = true;
        }
    }

    //PercentColumnMeanHR
    public string PercentColumnMeanHR(string Values)
    {
        float value = 0, pecent;
        float.TryParse(Values, out value);
        pecent = (value / maxMeanHR) * 100;
        return pecent.ToString() + "%";
    }

    //PercentColumnStdHR
    public string PercentColumnStdHR(string Values)
    {
        float value = 0, pecent;
        float.TryParse(Values, out value);
        pecent = (value / maxStdHR) * 100;
        return pecent.ToString() + "%";
    }

    //PercentColumnMeanRR
    public string PercentColumnMeanRR(string Values)
    {
        float value = 0, pecent;
        float.TryParse(Values, out value);
        pecent = (value / maxMeanRR) * 100;
        return pecent.ToString() + "%";
    }

    //PercentColumnSDNN
    public string PercentColumnSDNN(string Values)
    {
        float value = 0, pecent;
        float.TryParse(Values, out value);
        pecent = (value / maxSDNN) * 100;
        return pecent.ToString() + "%";
    }

    //PercentColumnRMSSD
    public string PercentColumnRMSSD(string Values)
    {
        float value = 0, pecent;
        float.TryParse(Values, out value);
        pecent = (value / maxRMSSD) * 100;
        return pecent.ToString() + "%";
    }

    //PercentColumnNN50
    public string PercentColumnNN50(string Values)
    {
        float value = 0, pecent;
        float.TryParse(Values, out value);
        pecent = (value / maxNN50) * 100;
        return pecent.ToString() + "%";
    }

    //PercentColumnpNN50
    public string PercentColumnpNN50(string Values)
    {
        float value = 0, pecent;
        float.TryParse(Values, out value);
        pecent = (value / maxpNN50) * 100;
        return pecent.ToString() + "%";
    }

    private void LoadHeartRateData()
    {
        DateTime fromDate = DateTime.MinValue, toDate;
        DateTime.TryParse(txtFromDate.Text, out fromDate);
        DateTime.TryParse(txtToDate.Text, out toDate);
        if (toDate == DateTime.MinValue)
            toDate = DateTime.MaxValue.Date;
        if (fromDate == DateTime.MinValue)
            fromDate = DateTime.Now.Date;
        DataTable dt = _db.GetList_HeartRate_Graph(userName(), fromDate, toDate);
        if (dt == null || dt.Rows.Count <= 0)
        {
            pnHRVData.Visible = false;
            pnHeartRateData.Visible = false;
            pnEmptyData.Visible = true;
        }
        else
        {
            AddSeriesLowHighToWebChart(dt);
            pnHeartRateData.Visible = true;
            pnHRVData.Visible = false;
            pnEmptyData.Visible = false;
        }
    }

    protected void BindDataToChart2(DataTable dt)
    {
        //Chart1.ChartAreas.Add("Default");
        //Chart1.ChartAreas["Default"].BackColor = Color.White;
        //Chart1.ChartAreas["Default"].BackSecondaryColor = Color.AliceBlue;
        //Chart1.ChartAreas["Default"].BackGradientStyle = GradientStyle.TopBottom;

        //Chart1.BackColor = Color.AliceBlue;
        //Chart1.BackSecondaryColor = Color.White;
        //Chart1.BackGradientStyle = GradientStyle.TopBottom;
        //Chart1.BorderSkin.SkinStyle = BorderSkinStyle.Emboss;
        //var colors = new List<Color>(GetSystemColors().Where(c => c.Name.StartsWith("Dark")));
        //var rng = new Random();
        //var start = rng.Next(0, colors.Count - 1);
        //for (var c = start; c < start + 6; c++)
        //{
        //    var color = colors[c % colors.Count];
        //    Chart1.Series.Add(color.Name);
        //    Chart1.Series[color.Name].BorderColor = color;
        //    Chart1.Series[color.Name].BorderWidth = 1;
        //    Chart1.Series[color.Name].Color = Color.FromArgb((int)(255 * .7), color);
        //    Chart1.Series[color.Name].BackSecondaryColor = Color.White;
        //    Chart1.Series[color.Name].BackGradientStyle = GradientStyle.TopBottom;
        //    for (var year = DateTime.Now.AddYears(-5).Year; year < DateTime.Now.Year; year++)
        //        Chart1.Series[color.Name].Points.Add(new DataPoint(year, rng.Next(0, 20)));

        //    Chart1.Series[color.Name]["PointWidth"] = (0.6).ToString();
        //}
        //Chart1.Legends.Add("Default");
    }

    static IEnumerable<Color> GetSystemColors()
    {
        Type type = typeof(Color);
        return type.GetProperties().Where(info => info.PropertyType == type).Select(info => (Color)info.GetValue(null, null));
    }

    private void AddSeriesLowHighToWebChart(DataTable dt)
    {
        BindDataToChart2(dt);
        Steema.TeeChart.Chart ch1 = WebChartHeartRate.Chart;
        tmpChart = new MemoryStream();
        if (Session["ch1"] == null)
        {
            if (dt != null && dt.Rows.Count > 0)
            {
                Steema.TeeChart.Styles.Line Low = new Steema.TeeChart.Styles.Line();
                Steema.TeeChart.Styles.Line Hight = new Steema.TeeChart.Styles.Line();
                Steema.TeeChart.Styles.Line Voltage = new Steema.TeeChart.Styles.Line();
                Steema.TeeChart.Styles.Points RestHR = new Steema.TeeChart.Styles.Points();
                Steema.TeeChart.Styles.Line HR = new Steema.TeeChart.Styles.Line();
                Low.XValues.DateTime = true;

                Low.Color = System.Drawing.Color.Blue;
                Hight.Color = System.Drawing.Color.Red;
                Voltage.Color = Color.Blue;
                HR.Color = Color.Red;
                RestHR.Color = Color.Orange;

                Low.Title = "Low";
                Hight.Title = "High";
                Voltage.Title = "Voltage";
                HR.Title = "HR";
                RestHR.Title = "RestHR";

                Voltage.VertAxis = Steema.TeeChart.Styles.VerticalAxis.Right;
                RestHR.Pointer.Style = Steema.TeeChart.Styles.PointerStyles.Circle;

                RestHR.Pointer.HorizSize = 10;
                int MinL1 = 0, MaxL1 = 0, MinL2 = 0, MaxL2 = 0, MinR = 0, MaxR = 0;

                float LowRest = 50, HighRest = 100;
                DataRow dr = _db.GetInfo_HeartRate(userName());
                if (dr != null)
                {
                    LowRest = BaseView.GetFloatFieldValue(dr, "HighRestHRValue");
                    HighRest = BaseView.GetFloatFieldValue(dr, "LowRestHRValue");
                }

                foreach (DataRow row in dt.Rows)
                {
                    Low.Add(BaseView.GetDateTimeFieldValue(row, "ReceivedDate"), LowRest);
                    Hight.Add(BaseView.GetDateTimeFieldValue(row, "ReceivedDate"), HighRest + 10);
                    Voltage.Add(BaseView.GetDateTimeFieldValue(row, "ReceivedDate"), BaseView.GetFloatFieldValue(row, "Voltage"));
                    HR.Add(BaseView.GetDateTimeFieldValue(row, "ReceivedDate"), BaseView.GetFloatFieldValue(row, "HR"));
                    RestHR.Add(BaseView.GetDateTimeFieldValue(row, "ReceivedDate"), BaseView.GetFloatFieldValue(row, "RestHR"));
                    if (MinL1 == 0 || (BaseView.GetIntFieldValue(row, "HR") < MinL1 && BaseView.GetIntFieldValue(row, "HR") > 0))
                    {
                        MinL1 = BaseView.GetIntFieldValue(row, "HR");
                    }
                    if (MinL2 == 0 || (BaseView.GetIntFieldValue(row, "RestHR") < MinL2 && BaseView.GetIntFieldValue(row, "RestHR") > 0))
                    {
                        MinL2 = BaseView.GetIntFieldValue(row, "RestHR");
                    }
                    if (MinR == 0 || (BaseView.GetIntFieldValue(row, "Voltage") < MinR && BaseView.GetIntFieldValue(row, "Voltage") > 0))
                    {
                        MinR = BaseView.GetIntFieldValue(row, "Voltage");
                    }

                    if (MaxL1 == 0 || (BaseView.GetIntFieldValue(row, "HR") > MaxL1 && BaseView.GetIntFieldValue(row, "HR") > 0))
                    {
                        MaxL1 = BaseView.GetIntFieldValue(row, "HR");
                    }
                    if (MaxL2 == 0 || (BaseView.GetIntFieldValue(row, "RestHR") > MaxL2 && BaseView.GetIntFieldValue(row, "RestHR") > 0))
                    {
                        MaxL2 = BaseView.GetIntFieldValue(row, "RestHR");
                    }
                    if (MaxR == 0 || (BaseView.GetIntFieldValue(row, "Voltage") > MaxR && BaseView.GetIntFieldValue(row, "Voltage") > 0))
                    {
                        MaxR = BaseView.GetIntFieldValue(row, "Voltage");
                    }
                }

                ch1.Series.Add(Low);
                ch1.Series.Add(Hight);
                ch1.Series.Add(Voltage);
                ch1.Series.Add(HR);
                ch1.Series.Add(RestHR);

                ch1.Axes.Bottom.SetMinMax(ch1.Series[0].MinXValue(), ch1.Series[0].MaxXValue());
                ch1.Axes.Right.SetMinMax(MinR, MaxR);
                ch1.Axes.Left.SetMinMax(LowRest - 10, HighRest + 10);
                ch1.Axes.Left.Title.Text = "Heart Rate (bpm)";
                Steema.TeeChart.Legend legend = new Steema.TeeChart.Legend(ch1);

                //ch1.Axes.Right.SetMinMax(500, 550);
                //ch1.Axes.Left.SetMinMax(40, 110);
                //ch1.Axes.Left.Visible = false;
                ch1.Axes.Right.Visible = false;

                ch1.Export.Template.Save(tmpChart);
                //save template to a Session variable
                Page.Cache.Add("ch1Scroll", tmpChart, null,
                DateTime.Now.AddSeconds(40), System.Web.Caching.Cache.NoSlidingExpiration,
                System.Web.Caching.CacheItemPriority.NotRemovable, null);
                Session.Add("ch1", tmpChart);
                ((Steema.TeeChart.Tools.ScrollTool)WebChartHeartRate.Chart.Tools[0]).StartPosition = 0;
            }
        }
        else
        {
            //retrieve the session stored Chart
            tmpChart = (MemoryStream)Session["ch1"];
            //set the Stream position to 0 as the last read/write
            //will have moved the position to the end of the stream
            tmpChart.Position = 0;
            //import saved Chart
            WebChartHeartRate.Chart.Import.Template.Load(tmpChart);
            CheckZoom(WebChartHeartRate);
        }
    }

    private void CheckZoom(WebChart wChart)
    {
        ArrayList zoomedState = (ArrayList)Session[wChart.ID + "Zoomed"];
        zoomedState = ((Steema.TeeChart.Tools.ZoomTool)wChart.Chart.Tools[0]).SetCurrentZoom(Request,
           zoomedState);
        if (zoomedState == null)
            Session.Remove(wChart.ID + "Zoomed");
        else
            Session.Add(wChart.ID + "Zoomed", zoomedState);
    }

    protected void HeartRateData_SelectedIndexChanged(object sender, EventArgs e)
    {
        pnEmptyData.Visible = false;
        DateTime fromTime = DateTime.MinValue, toTime;
        DateTime.TryParse(txtFromDate.Text, out fromTime);
        DateTime.TryParse(txtToDate.Text, out toTime);
        if (fromTime == DateTime.MinValue && toTime == DateTime.MinValue)
        {
            //MPE.Show();
            date_graph.Visible = true;
        }
        else
        {
            if (ddlHeartRateData.SelectedIndex == 0)
            {
                LoadHeartRateData();
            }
            else
            {
                LoadHRVData();
            }
        }
    }
    protected void btnOk_Click(object sender, EventArgs e)
    {
        pnEmptyData.Visible = false;
        Session["ToDateStress"] = toDate();
        if (fromDate().Year > 1753)
        {
            Session["FromDateStress"] = fromDate();
        }
        else
        {
            MessagesBox.jQueryShow(ClientScript, this.GetType(), DBClass.GetMessageByCode2("SelectTime"), "Notice");
            pnEmptyData.Visible = true;
            return;
        }
        if (ddlHeartRateData.SelectedIndex == 0)
        {
            LoadHeartRateData();

        }
        else
        {
            LoadHRVData();
        }
        Load_TableHeartRate(0);
        Load_TableHRV(0);
        date_graph.Visible = false;

    }
    #endregion
    #region Table
    private void Add_grvTable(DataTable table)
    {
        grvTable.DataSource = table;
        grvTable.DataBind();
    }
    private void Add_grvTableHRV(DataTable table)
    {
        grvHVRData.DataSource = table;
        grvHVRData.DataBind();
    }

    private void Load_TableHRV(int index)
    {
        grvHVRData.PageIndex = index;
        DataSet ds = _db.GetList_HeartRate_HRV_Table(userName(), fromDate(), toDate());
        if (ds != null && ds.Tables.Count >= 2)
        {
            Add_grvTableHRV(ds.Tables[1]);
        }
        pager2(index);
    }
    private void Load_TableHeartRate(int index)
    {
        grvTable.PageIndex = index;
        DataTable table = _db.GetList_HeartRate_Table(userName(), fromDate(), toDate());
        Add_grvTable(table);
        pager(index);
    }
    protected void btnView_Click(object sender, EventArgs e)
    {
        try
        {
            Load_TableHeartRate(0);
            Load_TableHRV(0);
        }
        catch (Exception)
        {
            string msg = DBClass.GetMessageByCode2("date_invalid");
            MessagesBox.jQueryShow(ClientScript, this.GetType(), msg, "Messages Box");
        }
    }
    protected void grvHVRData_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        grvHVRData.PageIndex = e.NewPageIndex;
        Load_TableHRV(0);
    }
    protected void grvTable_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        grvTable.PageIndex = e.NewPageIndex;
        Load_TableHeartRate(0);
    }
    private void selectData(bool q)
    {
        table_item.Visible = q;
        table_item2.Visible = !table_item.Visible;
    }
    protected void ddl_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddl.SelectedValue == "0")
            selectData(true);
        else
            selectData(false);
    }
    private DateTime fromDate()
    {
        DateTime fromTime = DateTime.MinValue;
        string fromT = "";
        if (txtFromDate2.Text == "" || String.IsNullOrEmpty(txtFromDate2.Text))
        {
            fromT = txtFromDate.Text;
        }
        else
        {
            fromT = txtFromDate2.Text;
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
        if (txtToDate2.Text == "" || String.IsNullOrEmpty(txtToDate2.Text))
        {
            toT = txtToDate.Text;
        }
        else
        {
            toT = txtToDate2.Text;
        }
        DateTime.TryParse(toT, out toTime);
        if (toTime == DateTime.MinValue)
            toTime = DateTime.Now.Date;
        return toTime;
    }

    protected void btnOk2_Click(object sender, EventArgs e)
    {

        if (fromDate() == DateTime.MinValue || toDate() == DateTime.MinValue)
        {
            MessagesBox.jQueryShow(ClientScript, this.GetType(), DBClass.GetMessageByCode2("SelectTime"), "Notice");

        }
        else
        {
            Load_TableHeartRate(0);
            Load_TableHRV(0);
            date_table.Visible = false;
        }
    }

    #endregion
    #region pager
    protected void back_Click(object sender, ImageClickEventArgs e)
    {
        i = grvTable.PageIndex;
        if (grvTable.PageIndex > 0)
        {

            grvTable.PageIndex = i--;
            Load_TableHeartRate(i);
            pager(i);
        }
    }
    protected void next_Click(object sender, ImageClickEventArgs e)
    {
        if (grvTable.PageIndex < grvTable.PageCount - 1)
        {
            i = grvTable.PageIndex;
            grvTable.PageIndex = i++;

            Load_TableHeartRate(i);
            pager(i);
        }
    }
    private void pager(int index)
    {
        int pagecount = index + 1;
        txtpage.Text = pagecount.ToString();
        lb_pager.Text = "/" + grvTable.PageCount.ToString();
    }
    private void pager2(int index)
    {
        int pagecount = index + 1;
        txt_page2.Text = pagecount.ToString();
        lbpage2.Text = "/" + grvHVRData.PageCount.ToString();
    }
    protected void txtpage_TextChanged(object sender, EventArgs e)
    {
        int page = Int32.Parse(txtpage.Text);
        int index = page - 1;
        Load_TableHeartRate(index);
        pager(index);
    }
    protected void btn_back1_Click(object sender, ImageClickEventArgs e)
    {
        j = grvHVRData.PageIndex;
        if (grvHVRData.PageIndex > 0)
        {

            grvHVRData.PageIndex = j--;
            Load_TableHRV(j);
            pager(j);
        }
    }
    protected void btn_next2_Click(object sender, ImageClickEventArgs e)
    {
        if (grvHVRData.PageIndex < grvHVRData.PageCount - 1)
        {
            j = grvHVRData.PageIndex;
            grvHVRData.PageIndex = j++;

            Load_TableHRV(j);
            pager(j);
        }
    }
    protected void txt_page2_TextChanged(object sender, EventArgs e)
    {
        int page = Int32.Parse(txt_page2.Text);
        int index = page - 1;
        Load_TableHRV(index);
        pager2(index);
    }
    #endregion

    private void LoadDateTime()
    {
        if (Session["FromDateHeartRate"] != null)
        {
            DateTime startdate = (DateTime)Session["FromDateHeartRate"];
            if (startdate.Year > 1753)
            {
                txtFromDate.Text = startdate.ToShortDateString();
                txtFromDate2.Text = startdate.ToShortDateString();
            }
        }

        if (Session["ToDateHeartRate"] != null)
        {
            DateTime startdate = (DateTime)Session["ToDateHeartRate"];
            if (startdate.Year > 1753)
            {
                txtToDate.Text = startdate.ToShortDateString();
                txtToDate2.Text = startdate.ToShortDateString();
            }
        }
    }
    protected void btnFilter_Click(object sender, EventArgs e)
    {
        pnEmptyData.Visible = false;
        DateTime fromTime = DateTime.MinValue, toTime;
        DateTime.TryParse(txtFromDate.Text, out fromTime);
        DateTime.TryParse(txtToDate.Text, out toTime);
        if (fromTime == DateTime.MinValue || toTime == DateTime.MinValue)
        {
            MessagesBox.jQueryShow(ClientScript, this.GetType(), DBClass.GetMessageByCode2("SelectTime"), "Notice");
            //MPE.Show();
        }
        else
        {
            if (ddlHeartRateData.SelectedIndex == 0)
            {
                LoadHeartRateData();
            }
            else
            {
                LoadHRVData();
            }
        }
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
        MultiViewHeartRate.ActiveViewIndex = 0;
        HeartRateData_SelectedIndexChanged(sender, e);
        Select_graph(false);
    }
    protected void btnTable2_Click(object sender, EventArgs e)
    {
        MultiViewHeartRate.ActiveViewIndex = 1;
        Select_graph(true);
    }
    protected void WebChartHeartRate_ClickAxis(object sender, ImageClickEventArgs e)
    {
        Steema.TeeChart.Axis axis = (Steema.TeeChart.Axis)sender;
        clickedX = e.X;
        clickedY = e.Y;
        double axisValue = 0;
        if (axis.Horizontal)
            axisValue = ((Steema.TeeChart.Axis)sender).CalcPosPoint(clickedX);
        else
            axisValue = ((Steema.TeeChart.Axis)sender).CalcPosPoint(clickedY);
        msgText = "Clicked Axis at:" + "\n\rValue: " + axisValue.ToString("#.00");
    }
    protected void WebChartHeartRate_AfterDraw(object sender, Steema.TeeChart.Drawing.Graphics3D g)
    {
        if (clickedX != -1)
        {
            g.Font.Color = Color.Maroon;
            g.TextOut(clickedX, clickedY, msgText);
        }
        WebChartHeartRate.Chart.Axes.Bottom.Labels.DateTimeFormat = "MM/dd/yyyy hh:mm:ss tt";
    }
    protected void WebChartHeartRate_ClickSeries(object sender, Steema.TeeChart.Styles.Series s, int valueIndex, EventArgs e)
    {
        Steema.TeeChart.Chart tChart = ((WebChart)sender).Chart;

        clickedX = s.CalcXPos(valueIndex);
        clickedY = s.CalcYPos(valueIndex);
        msgText = "Clicked Series: " + tChart.Series.IndexOf(s).ToString() + "\n\rValue: " + s.YValues[valueIndex].ToString("#0.00");
    }
    protected void lbtnDateTime_Click(object sender, EventArgs e)
    {
        date_graph.Visible = true;
    }
    protected void btnCancel_Click(object sender, EventArgs e)
    {
        date_graph.Visible = false;
    }
    protected void btnCancel2_Click(object sender, EventArgs e)
    {
        date_table.Visible = false;
    }
    protected void lbDateTable_Click(object sender, EventArgs e)
    {
        date_table.Visible = true;
    }
}