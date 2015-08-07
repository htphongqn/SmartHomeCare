using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Drawing;
using System.IO;

public partial class usertrackothers_spo2 : System.Web.UI.Page
{
    private DBClass _db = new DBClass();
    private MemoryStream tmpChart = new MemoryStream();
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
            //BaseView.SelectedTreeView(treeview, siteuser.REPORTS, siteuser.TRACKOTHERS);
            //treeview.Nodes[siteuser.REPORTS].ChildNodes[siteuser.TRACKMYHEALTH].ChildNodes.AddAt(0, new TreeNode("Oxygen", "0"));
            //treeview.Nodes[siteuser.REPORTS].ChildNodes[siteuser.TRACKMYHEALTH].Expand();
            //treeview.Nodes[siteuser.REPORTS].ChildNodes[siteuser.TRACKMYHEALTH].ChildNodes[0].Selected = true;
            LoadDateTime();
            Load_DataOxygenTable(0);
            LoadSPO2Graph();
            Select_graph(false);
            if (Session["FromDateSPO2Others"] == null && Session["ToDateSPO2Others"] == null)
            {
                date_graph.Visible = true;
            }
            else
            {
                date_graph.Visible = false;
            }
        }
    }

    private void Fullname()
    {
        DataRow row = (DataRow)Session["AuthorizedUser"];
        lbNameHealth.Text = BaseView.GetStringFieldValue(row, "FullName");
    }

    #region Page
    private string userName()
    {
        DataRow row = (DataRow)Session["User"];
        if (row == null)
            return null;
        else
            return BaseView.GetStringFieldValue(row, "Username");
    }

    private void LoadDateTime()
    {
        if (Session["FromDateSPO2Others"] != null)
        {
            DateTime startdate = (DateTime)Session["FromDateSPO2Others"];
            if (startdate.Year > 1753)
            {
                txtFromDate.Text = startdate.ToShortDateString();
                //txtFromDate2.Text = startdate.ToShortDateString();
            }
        }

        if (Session["ToDateSPO2Others"] != null)
        {
            DateTime startdate = (DateTime)Session["ToDateSPO2Others"];
            if (startdate.Year > 1753)
            {
                txtToDate.Text = startdate.ToShortDateString();
                //txtToDate2.Text = startdate.ToShortDateString();
            }
        }
    }

    #endregion

    #region Table
    private void Add_grvDataPosition(DataTable table)
    {
        grvSpO2.DataSource = table;
        grvSpO2.DataBind();
    }
    private DateTime fromDate()
    {
        DateTime fromTime = DateTime.MinValue;
        string fromT = "";
        if (txtFromDateTable.Text == "" || String.IsNullOrEmpty(txtFromDateTable.Text))
        {
            fromT = txtFromDate.Text;
        }
        else
        {
            fromT = txtFromDateTable.Text;
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
        if (txtToDateTable.Text == "" || String.IsNullOrEmpty(txtToDateTable.Text))
        {
            toT = txtToDate.Text;
        }
        else
        {
            toT = txtToDateTable.Text;
        }
        DateTime.TryParse(toT, out toTime);
        if (toTime == DateTime.MinValue)
            toTime = DateTime.Now.Date;
        return toTime;
    }
    private void Load_DataOxygenTable(int index)
    {
        grvSpO2.PageIndex = index;
        DataTable table = _db.GetList_SpO2_Table(userName(), fromDate(), toDate());
        Add_grvDataPosition(table);
        pager(index);
    }
    protected void btnView_Click(object sender, EventArgs e)
    {
        Load_DataOxygenTable(0);
        date_table.Visible = false;
    }
    protected void grvSpO2_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        Load_DataOxygenTable(e.NewPageIndex);
    }
    #endregion

    #region Graph

    private void LoadSPO2Graph()
    {
        DataTable dt = _db.GetList_SpO2_Graph(userName(), fromDate(), toDate());
        if (dt == null || dt.Rows.Count <= 0)
        {
            pnGraphSpO2.Visible = false;
            pnEmptyData.Visible = true;
        }
        else
        {
            //AddSeriesLowHighToWebChart(dt);
            ChartSpo2Main.DataSource = dt;
            ChartSpo2Main.DataBind();
            pnGraphSpO2.Visible = true;
            pnEmptyData.Visible = false;
        }
    }

    //private void AddSeriesLowHighToWebChart(DataTable dt)
    //{
    //    Steema.TeeChart.Chart ch1 = WebChartGraphSpO2.Chart;
    //    tmpChart = new MemoryStream();
    //    if (Session["WebChartGraphSpO2"] == null)
    //    {
    //        if (dt != null && dt.Rows.Count > 0)
    //        {
    //            Steema.TeeChart.Styles.Line Low = new Steema.TeeChart.Styles.Line();
    //            Steema.TeeChart.Styles.FastLine SPO2 = new Steema.TeeChart.Styles.FastLine();
    //            Low.XValues.DateTime = true;

    //            Low.Color = System.Drawing.Color.Blue;
    //            SPO2.Color = Color.Red;
    //            int MinL1 = 0, MaxL1 = 0;

    //            foreach (DataRow row in dt.Rows)
    //            {
    //                Low.Add(BaseView.GetDateTimeFieldValue(row, "ReceivedDate"), BaseView.GetFloatFieldValue(row, "ThresholdValue"));
    //                SPO2.Add(BaseView.GetDateTimeFieldValue(row, "ReceivedDate"), BaseView.GetFloatFieldValue(row, "SpO2Value"));
    //                if (MinL1 == 0 || (BaseView.GetIntFieldValue(row, "SpO2Value") < MinL1 && BaseView.GetIntFieldValue(row, "SpO2Value") > 0))
    //                {
    //                    MinL1 = BaseView.GetIntFieldValue(row, "SpO2Value");
    //                }
    //                if (MaxL1 == 0 || (BaseView.GetIntFieldValue(row, "SpO2Value") > MaxL1 && BaseView.GetIntFieldValue(row, "SpO2Value") > 0))
    //                {
    //                    MaxL1 = BaseView.GetIntFieldValue(row, "SpO2Value");
    //                }
    //            }

    //            ch1.Series.Add(Low);
    //            ch1.Series.Add(SPO2);

    //            ch1.Axes.Bottom.SetMinMax(ch1.Series[1].MinXValue(), ch1.Series[1].MaxXValue());
    //            ch1.Axes.Left.SetMinMax(MinL1, MaxL1);
    //            //ch1.Axes.Left.SetMinMax(90, 100);

    //            ch1.Axes.Left.Visible = false;
    //            ch1.Axes.Right.Visible = false;
    //            ch1.Axes.Bottom.Labels.DateTimeFormat = "MM/dd/yyyy hh:mm:ss tt";
    //            ch1.Export.Template.Save(tmpChart);
    //            //save template to a Session variable
    //            Page.Cache.Add("ch1Scroll", tmpChart, null,
    //            DateTime.Now.AddSeconds(40), System.Web.Caching.Cache.NoSlidingExpiration,
    //            System.Web.Caching.CacheItemPriority.NotRemovable, null);
    //            Session.Add("WebChartGraphSpO2", tmpChart);
    //            ((Steema.TeeChart.Tools.ScrollTool)WebChartGraphSpO2.Chart.Tools[0]).StartPosition = 0;
    //        }
    //    }
    //    else
    //    {
    //        //retrieve the session stored Chart
    //        tmpChart = (MemoryStream)Session["WebChartGraphSpO2"];
    //        //set the Stream position to 0 as the last read/write
    //        //will have moved the position to the end of the stream
    //        tmpChart.Position = 0;
    //        //import saved Chart
    //        WebChartGraphSpO2.Chart.Import.Template.Load(tmpChart);
    //    }
    //}

    #endregion

    protected void btnOk_Click(object sender, EventArgs e)
    {
        pnEmptyData.Visible = false;
        Session["ToDateSPO2Others"] = toDate();
        if (fromDate().Year > 1753)
        {
            Session["FromDateSPO2Others"] = fromDate();
        }
        else
        {
            MessagesBox.jQueryShow(ClientScript, this.GetType(), DBClass.GetMessageByCode2("SelectTime"), "Notice");
            pnEmptyData.Visible = true;
            return;
        }
        LoadSPO2Graph();
        Load_DataOxygenTable(0);
        date_graph.Visible = false;
    }

    #region pager
    protected void back_Click(object sender, ImageClickEventArgs e)
    {
        i = grvSpO2.PageIndex;
        if (grvSpO2.PageIndex > 0)
        {
            grvSpO2.PageIndex = i--;
            Load_DataOxygenTable(i);
            pager(i);
        }
    }
    protected void next_Click(object sender, ImageClickEventArgs e)
    {
        if (grvSpO2.PageIndex < grvSpO2.PageCount - 1)
        {
            i = grvSpO2.PageIndex;
            grvSpO2.PageIndex = i++;
            Load_DataOxygenTable(i);
            pager(i);
        }
    }
    private void pager(int index)
    {
        int pagecount = index + 1;
        txtpage.Text = pagecount.ToString();
        lb_pager.Text = "/" + grvSpO2.PageCount.ToString();
    }
    private void pager2(int index)
    {
        int pagecount = index + 1;
        //txt_page2.Text = pagecount.ToString();
        //lbpage2.Text = "/" + grvRawData.PageCount.ToString();
    }
    protected void txtpage_TextChanged(object sender, EventArgs e)
    {
        int page = Int32.Parse(txtpage.Text);
        int index = page - 1;
        Load_DataOxygenTable(index);
        pager(index);
    }
    protected void btn_back1_Click(object sender, ImageClickEventArgs e)
    {
        //i = grvRawData.PageIndex;
        //if (grvRawData.PageIndex > 0)
        //{
        //    grvRawData.PageIndex = i--;
        //    Load_RawDataPositionTable(i);
        //    pager(i);
        //}
    }
    protected void btn_next2_Click(object sender, ImageClickEventArgs e)
    {
        //if (grvRawData.PageIndex < grvRawData.PageCount - 1)
        //{
        //    i = grvRawData.PageIndex;
        //    grvRawData.PageIndex = i++;
        //    Load_RawDataPositionTable(i);
        //    pager(i);
        //}
    }
    protected void txt_page2_TextChanged(object sender, EventArgs e)
    {
        //int page = Int32.Parse(txt_page2.Text);
        //int index = page - 1;
        //Load_RawDataPositionTable(i);
        //pager2(index);
    }
    #endregion

    #region Tab
    private void Select_graph(bool q)
    {
        btnGraph2.Enabled = q;
        btnTable2.Enabled = !btnGraph2.Enabled;
        if (btnGraph2.Enabled == false)
        {
            btnGraph2.ForeColor = ColorTranslator.FromHtml("#E0C55C");
            btnTable2.ForeColor = ColorTranslator.FromHtml("#fff");
        }
        else
        {
            btnGraph2.ForeColor = ColorTranslator.FromHtml("#fff");
            btnTable2.ForeColor = ColorTranslator.FromHtml("#E0C55C");
        }
    }
    protected void btnGraph2_Click(object sender, EventArgs e)
    {
        MultiViewOxyGen.ActiveViewIndex = 0;
        Select_graph(false);
    }
    protected void btnTable2_Click(object sender, EventArgs e)
    {
        MultiViewOxyGen.ActiveViewIndex = 1;
        Select_graph(true);
    }
    #endregion
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