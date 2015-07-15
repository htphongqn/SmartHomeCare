using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.IO;
using System.Drawing;
public partial class usertrackmyhealth_spo2 : System.Web.UI.Page
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

        if (!IsPostBack)
        {
            //siteuser _siteuser = (siteuser)this.Master;
            //TreeView treeview = _siteuser.treeview;
            //BaseView.SelectedTreeView(treeview, siteuser.REPORTS, siteuser.TRACKMYHEALTH);
            LoadDateTime();  
            ddl_number.SelectedValue = "100";
            if (Session["FromDateSPO2"] == null && Session["ToDateSPO2"] == null)
            {
                LoadSPO2GraphDefault();
            }
            else
            {
                //date_graph.Visible = false;
                if (Session["Page_NoSpO2"] != null)
                {
                    Select_Page_Number((int)Session["Page_NoSpO2"]);
                }
                if (Session["PageIndex_SO2"] != null)
                {
                    Load_DataOxygenTable((int)Session["PageIndex_SO2"]);
                }
                else
                    Load_DataOxygenTable(0);
                LoadSPO2Graph();

            }
            SetTab();
        }
        else
        {
            SetDefaultData();
        }
    }
    private void SetDefaultData()
    {
        if (Session["FromDateSPO2"] == null && Session["ToDateSPO2"] == null)
        {
            LoadSPO2GraphDefault();
        }
        else
        {
            LoadSPO2Graph();
        }
    }
    private void SetTab()
    {
        if (Session["IndexTab_SP"] != null)
        {
            if ((int)Session["IndexTab_SP"] == 1)
            {
                Select_graph(true);
                MultiViewOxyGen.ActiveViewIndex = 1;
            }
            else
            {
                Select_graph(false);
                MultiViewOxyGen.ActiveViewIndex = 0;
            }
        }
        else
        {
            Select_graph(false);
        }
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
        if (Session["FromDateSPO2"] != null)
        {
            DateTime startdate = (DateTime)Session["FromDateSPO2"];
            if (startdate.Year > 1753)
            {
                txtFromDate.Text = startdate.ToShortDateString();
               txtFromDateTable.Text = startdate.ToShortDateString();
            }
        }

        if (Session["ToDateSPO2"] != null)
        {
            DateTime startdate = (DateTime)Session["ToDateSPO2"];
            if (startdate.Year > 1753)
            {
                txtToDate.Text = startdate.ToShortDateString();
                txtToDateTable.Text = startdate.ToShortDateString();
            }
        }
    }

    #endregion

    #region Table
    private void Add_grvData(DataTable table)
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
        Add_grvData(table);
        pager(index);
    }
    protected void btnView_Click(object sender, EventArgs e)
    {
        Session["ToDateSPO2"] = toDate();
        if (fromDate().Year > 1753)
        {
            Session["FromDateSPO2"] = fromDate();
        }
        else
        {
            MessagesBox.jQueryShow(ClientScript, this.GetType(), DBClass.GetMessageByCode2("SelectTime"), "Notice");
            return;
        }
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
            AddSeriesLowHighToWebChart(dt);
            pnGraphSpO2.Visible = true;
            pnEmptyData.Visible = false;
        }
    }

    private void LoadSPO2GraphDefault()
    {
        //DataTable dt = _db.GetList_SpO2_Default(userName());
        DataTable dt = _db.GetList_SpO2_Table(userName(), null, null);
        if (dt == null || dt.Rows.Count <= 0)
        {
            pnGraphSpO2.Visible = false;
            pnEmptyData.Visible = true;
        }
        else
        {
            AddSeriesLowHighToWebChart(dt);
            pnGraphSpO2.Visible = true;
            pnEmptyData.Visible = false;
        }
    }

    private void AddSeriesLowHighToWebChart(DataTable dt)
    {
        Steema.TeeChart.Chart ch1 = WebChartGraphSpO2.Chart;
        ch1.Series.RemoveAllSeries();
        tmpChart = new MemoryStream();
        if (dt != null && dt.Rows.Count > 0)
        {
            Steema.TeeChart.Styles.Line Low = new Steema.TeeChart.Styles.Line();
            Steema.TeeChart.Styles.FastLine SPO2 = new Steema.TeeChart.Styles.FastLine();
            Low.XValues.DateTime = true;

            Low.Color = System.Drawing.Color.Blue;
            SPO2.Color = Color.Red;
            int MinL1 = 0, MaxL1 = 0;

            foreach (DataRow row in dt.Rows)
            {
                Low.Add(BaseView.GetDateTimeFieldValue(row, "ReceivedDate"), BaseView.GetFloatFieldValue(row, "ThresholdValue"));
                SPO2.Add(BaseView.GetDateTimeFieldValue(row, "ReceivedDate"), BaseView.GetFloatFieldValue(row, "SpO2Value"));
                float a = BaseView.GetFloatFieldValue(row, "SpO2Value");
                if (MinL1 == 0 || (BaseView.GetIntFieldValue(row, "SpO2Value") < MinL1 && BaseView.GetIntFieldValue(row, "SpO2Value") > 0))
                {
                    MinL1 = BaseView.GetIntFieldValue(row, "SpO2Value");
                }
                if (MaxL1 == 0 || (BaseView.GetIntFieldValue(row, "SpO2Value") > MaxL1 && BaseView.GetIntFieldValue(row, "SpO2Value") > 0))
                {
                    MaxL1 = BaseView.GetIntFieldValue(row, "SpO2Value");
                }
            }

            ch1.Series.Add(Low);
            ch1.Series.Add(SPO2);
            Steema.TeeChart.Legend le = new Steema.TeeChart.Legend(ch1);

            ch1.Axes.Bottom.SetMinMax(ch1.Series[1].MinXValue(), ch1.Series[1].MaxXValue());
            //ch1.Axes.Left.SetMinMax(MinL1, MaxL1);
            //ch1.Axes.Left.SetMinMax(90, 100);

            //ch1.Axes.Left.Visible = false;
            //ch1.Axes.Right.Visible = false;
            ch1.Axes.Bottom.Labels.DateTimeFormat = "MM/dd/yyyy HH:mm:ss";
            ch1.Export.Template.Save(tmpChart);
            //save template to a Session variable
            Page.Cache.Add("ch1Scroll", tmpChart, null,
            DateTime.Now.AddSeconds(40), System.Web.Caching.Cache.NoSlidingExpiration,
            System.Web.Caching.CacheItemPriority.NotRemovable, null);
            Session.Add("WebChartGraphSpO2", tmpChart);
            ((Steema.TeeChart.Tools.ScrollTool)WebChartGraphSpO2.Chart.Tools[0]).StartPosition = 0;
        }
    }

    #endregion

    protected void btnOk_Click(object sender, EventArgs e)
    {
        pnEmptyData.Visible = false;
        Session["ToDateSPO2"] = toDate();
        if (fromDate().Year > 1753)
        {
            Session["FromDateSPO2"] = fromDate();
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
            Session["PageIndex_SO2"] = i;
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
            Session["PageIndex_SO2"] = i;
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
        Session["PageIndex_SO2"] = index;
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
        Session["IndexTab_SP"] = 0;
    }
    protected void btnTable2_Click(object sender, EventArgs e)
    {
        MultiViewOxyGen.ActiveViewIndex = 1;
        Select_graph(true);
        Session["IndexTab_SP"] = 1;
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
    protected void ddl_number_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddl_number.SelectedValue == "0")
        {
            grvSpO2.AllowPaging = false;
            Load_DataOxygenTable(0);
            pager(0);
        }
        else
        {
            
            Select_Page_Number(ToSQL.SQLToInt(ddl_number.SelectedValue));
            Load_DataOxygenTable(0);
            pager(0);
        }
    }
    private void Select_Page_Number(int i)
    {
        grvSpO2.AllowPaging = true;
        grvSpO2.PageSize = i;
        if (!IsPostBack)
            ddl_number.SelectedValue = i.ToString();
        Session["Page_NoSpO2"] =i;
    }
    protected void lbLinks_Click(object sender, EventArgs e)
    {
        Session["PageIndex_SO2"] =null;
        Session["Page_NoSpO2"] = null;
        Session["IndexTab_SP"] = null;
        Session["FromDateSPO2"] = null ;
        Session["ToDateSPO2"] = null;
        Response.Redirect("~/usertrackmyhealth_spo2.aspx");
    }
}