using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Web.UI.DataVisualization.Charting;
using Steema.TeeChart;
using System.Drawing;
using System.Text;
using System.IO;
public partial class usertrackmyhealth_temperature_graph : System.Web.UI.Page
{
    private DBClass _db = new DBClass();
    DataTable dt = new DataTable();
    int i = 0;
    private bool _refreshState;
    private bool _isRefresh;
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
            if (Session["FromDateTemperature"] == null && Session["ToDateTemperature"] == null)
            {
                if (Session["Page_Temp"] != null)
                {
                    Page_number((int)Session["Page_Temp"]);
                }
                if (Session["PageIndex_Temp"] != null)
                    LoadGridDefault((int)Session["PageIndex_Temp"]);
                else
                    LoadGridDefault(0);
                LoadTempDefaultUser();
                

            }
            else
            {
                //date_graph.Visible = false;
                if (Session["Page_Temp"] != null)
                {
                    Page_number((int)Session["Page_Temp"]);
                }
                if (Session["PageIndex_Temp"] != null)
                    LoadGridviewTemp((int)Session["PageIndex_Temp"], DateTime.Parse(Session["FromDateTemperature"].ToString()), DateTime.Parse(Session["ToDateTemperature"].ToString()));
                else
                    LoadGridviewTemp(0, DateTime.Parse(Session["FromDateTemperature"].ToString()), DateTime.Parse(Session["ToDateTemperature"].ToString()));
                LoadTempUser();
            }
            if (Session["IndexTab_Temperture"] != null)
            {
                if ((int)Session["IndexTab_Temperture"] == 1)
                {
                    Select_graph(true);
                    MultiViewTemperature.ActiveViewIndex = 1;
                }
                else
                {
                    Select_graph(false);
                    MultiViewTemperature.ActiveViewIndex = 0;
                }
            }
            else
            {
                Select_graph(false);
            }
        }
        else
        {
            if (Session["FromDateTemperature"] == null && Session["ToDateTemperature"] == null)
            {
                if (Session["Page_Temp"] != null)
                {
                    Page_number((int)Session["Page_Temp"]);
                }
                if (Session["PageIndex_Temp"] != null)
                    LoadGridDefault((int)Session["PageIndex_Temp"]);
                else
                    LoadGridDefault(0);
                LoadTempDefaultUser();

            }
            else
            {
                if (Session["Page_Temp"] != null)
                {
                    Page_number((int)Session["Page_Temp"]);
                }
                if (Session["PageIndex_Temp"] != null)
                    LoadGridviewTemp((int)Session["PageIndex_Temp"], DateTime.Parse(Session["FromDateTemperature"].ToString()), DateTime.Parse(Session["ToDateTemperature"].ToString()));
                else
                    LoadGridviewTemp(0, DateTime.Parse(Session["FromDateTemperature"].ToString()), DateTime.Parse(Session["ToDateTemperature"].ToString()));
                LoadTempUser();
            }
        }
    }
    protected void grvTemp_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        grvTemp.PageIndex = e.NewPageIndex;
    }
    private string userName()
    {
        DataRow row = (DataRow)Session["User"];
        if (row == null)
            return null;
        else
            return BaseView.GetStringFieldValue(row, "Username");
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

    private void LoadTempDefaultUser()
    {
        DataRow row = (DataRow)Session["User"];
        if (row != null)
        {
            //DataTable dt = _db.GetList_Temperature_Default(userName());
            DataTable dt = _db.GetList_UserTemperature(userName(), null, null);
            if (dt.Rows.Count > 0)
            {
                //lbDataEmpty.Visible = false;
                AddSeriesChart(dt);
                AddGridview(dt);
                pager(0);
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
    private void LoadGridDefault(int i)
    {
        DataRow row = (DataRow)Session["User"];
        if (row != null)
        {
            //DataTable dt = _db.GetList_Temperature_Default(userName());
            DataTable dt = _db.GetList_UserTemperature(userName(), null, null);
            if (dt.Rows.Count > 0)
            {
                grvTemp.PageIndex = i;
                AddGridview(dt);
                pager(0);
            }
        }
        string No = _db.Get_IsUS_UserTrackMyHealth_ByUserName(userName()).ToString();
        if (No.ToLower() == "false")
        {
            lbSkin.Text = " (⁰C)";
            lbAmb.Text = " (⁰C)";
        }
        else
        {
            lbSkin.Text = " (⁰F)";
            lbAmb.Text = " (⁰F)";
        }
    }
    private void AddGridview(DataTable table)
    {
        grvTemp.DataSource = table;
        grvTemp.DataBind();
    }
    private void LoadGridviewTemp(int index,DateTime? fromdate,DateTime? todate)
    {
        DataRow row = (DataRow)Session["User"];
        if (row != null)
        {
            
            DataTable dt = _db.GetList_UserTemperature(userName(), fromdate, todate);
            grvTemp.PageIndex = index;
            AddGridview(dt);
            pager(index);
            string No = _db.Get_IsUS_UserTrackMyHealth_ByUserName(userName()).ToString();
            if (No.ToLower() == "false")
            {
                lbSkin.Text = " (⁰C)";
                lbAmb.Text = " (⁰C)";
            }
            else
            {
                lbSkin.Text = " (⁰F)";
                lbAmb.Text = " (⁰F)";
            }
            
        }

    }
    
    private void AddSeriesChart(DataTable dt)
    {
        Steema.TeeChart.Chart ch1 = ChartTemperature.Chart;
        if (dt != null && dt.Rows.Count > 0)
        {
            Steema.TeeChart.Styles.Line sNormal = new Steema.TeeChart.Styles.Line();
            Steema.TeeChart.Styles.Line sHigh = new Steema.TeeChart.Styles.Line();
            Steema.TeeChart.Styles.Line sVeryHigh = new Steema.TeeChart.Styles.Line();
            Steema.TeeChart.Styles.Line sKinTemp = new Steema.TeeChart.Styles.Line();
            Steema.TeeChart.Styles.Line sAmbTemp = new Steema.TeeChart.Styles.Line();

            sNormal.Color = System.Drawing.Color.Lime;
            sHigh.Color = System.Drawing.Color.Orange;
            sVeryHigh.Color = System.Drawing.Color.OrangeRed;
            sKinTemp.Color = System.Drawing.Color.Black;
            sAmbTemp.Color = System.Drawing.Color.Red;

            sNormal.Title = "Normal";
            sHigh.Title = "High";
            sVeryHigh.Title = "Very High";
            sKinTemp.Title = "Skin Temp";
            sAmbTemp.Title = "Amb Temp";

            sNormal.LinePen.Width = 3;
            sHigh.LinePen.Width = 3;
            sVeryHigh.LinePen.Width = 3;

            double TempNormal = 97, TempHigh = 100.4, TempVeryHigh = 103.9;
            if (GetIsUSOrMetricForUser(userName()))
            {
                ch1.Axes.Left.Title.Text = "Temperature (°F)";
                TempNormal = 97;
                TempHigh = 100.4;
                TempVeryHigh = 103.9;
                foreach (DataRow row in dt.Rows)
                {
                    sNormal.Add(BaseView.GetDateTimeFieldValue(row, "ReceivedDate"), TempNormal);
                    sHigh.Add(BaseView.GetDateTimeFieldValue(row, "ReceivedDate"), TempHigh);
                    sVeryHigh.Add(BaseView.GetDateTimeFieldValue(row, "ReceivedDate"), TempVeryHigh);
                    sKinTemp.Add(BaseView.GetDateTimeFieldValue(row, "ReceivedDate"), BaseView.GetFloatFieldValue(row, "SkinTemp"));
                    sAmbTemp.Add(BaseView.GetDateTimeFieldValue(row, "ReceivedDate"), BaseView.GetFloatFieldValue(row, "AmbTemp"));
                }
            }
            else
            {                
                ch1.Axes.Left.Title.Text = "Temperature (°C)";
                TempNormal = 36.1;
                TempHigh = 38;
                TempVeryHigh = 39.9;
                foreach (DataRow row in dt.Rows)
                {
                    sNormal.Add(BaseView.GetDateTimeFieldValue(row, "ReceivedDate"), TempNormal);
                    sHigh.Add(BaseView.GetDateTimeFieldValue(row, "ReceivedDate"), TempHigh);
                    sVeryHigh.Add(BaseView.GetDateTimeFieldValue(row, "ReceivedDate"), TempVeryHigh);
                    sKinTemp.Add(BaseView.GetDateTimeFieldValue(row, "ReceivedDate"), BaseView.GetFloatFieldValue(row, "SkinTempC"));
                    sAmbTemp.Add(BaseView.GetDateTimeFieldValue(row, "ReceivedDate"), BaseView.GetFloatFieldValue(row, "AmbTempC"));
                }
            }

            Steema.TeeChart.Legend le = new Steema.TeeChart.Legend(ch1);
            
            ch1.Axes.Bottom.Labels.DateTimeFormat = "MM/dd/yyyy HH:mm";
            ch1.Axes.Left.SetMinMax(TempNormal - 10, TempVeryHigh + 10);
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
        MultiViewTemperature.ActiveViewIndex = 0;
        //LoadTempUser();
        Session["IndexTab_Temperture"] = 0;
        Select_graph(false);
    }
    protected void btnTable2_Click(object sender, EventArgs e)
    {
        MultiViewTemperature.ActiveViewIndex = 1;
        Session["IndexTab_Temperture"] = 1;
        Select_graph(true);
    }
    protected void btnFilter_Click(object sender, EventArgs e)
    {
        Session["ToDateTemperature"] = toDate();
        if (fromDate().Year > 1753)
        {
            Session["FromDateTemperature"] = fromDate();
        }
        else
        {
            MessagesBox.jQueryShow(ClientScript, this.GetType(), DBClass.GetMessageByCode2("SelectTime"), "Notice");
           
            return;
        }
        LoadTempUser();
        LoadGridviewTemp(0, fromDate(), toDate());
        date_table.Visible = false;
    }
    protected void Button1_Click(object sender, EventArgs e)
    {
       
       Response.Redirect("~/usertrackmyhealth_temperature_settings.aspx");
       
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
            if (Session["FromDateTemperature"] == null && Session["ToDateTemperature"] == null)
            {
                LoadGridDefault(i);
            }
            else
                LoadGridviewTemp(i,fromDateT(),toDateT());
            Session["PageIndex_Temp"] = i;
            pager(i);
        }
    }
    protected void next_Click(object sender, ImageClickEventArgs e)
    {
        if (grvTemp.PageIndex < grvTemp.PageCount - 1)
        {
            i = grvTemp.PageIndex;
            grvTemp.PageIndex = i++;
            if (Session["FromDateTemperature"] == null && Session["ToDateTemperature"] == null)
            {
                LoadGridDefault(i);
            }
            else
                LoadGridviewTemp(i,fromDateT(), toDateT());
            Session["PageIndex_Temp"] = i;
            pager(i);
        }
    }
    private void pager(int index)
    {
        int pagecount = index + 1;
        txtpage.Text = pagecount.ToString();
        if (grvTemp.PageCount == 0)
        {
            lb_pager.Text = "/ 1";
        }
        else 
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
        LoadGridviewTemp(index, fromDateT(), toDateT());
        Session["PageIndex_Temp"] = index;
        pager(index);
    }


    #endregion

    protected void btnOk_Click(object sender, EventArgs e)
    {
        pnEmptyData.Visible = false;
        Session["ToDateTemperature"] = toDate();
        if (fromDate().Year > 1753)
        {
            Session["FromDateTemperature"] = fromDate();
        }
        else
        {
            MessagesBox.jQueryShow(ClientScript, this.GetType(), DBClass.GetMessageByCode2("SelectTime"), "Notice");
            pnEmptyData.Visible = true;
            return;
        }
        LoadTempUser();
        LoadGridviewTemp(0,fromDate(),toDate());// Datetime of graph load gripview.
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
        txtFromDate.Text = fromT;
        DateTime.TryParse(fromT, out fromTime);
        if (fromTime == DateTime.MinValue)
            fromTime = DateTime.Now.Date;
        return fromTime;
    }
    private DateTime fromDateT()
    {
        DateTime fromTime = DateTime.MinValue;
        string fromT = txtFromDate.Text;
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
        txtToDate.Text = toT;
        DateTime.TryParse(toT, out toTime);
        if (toTime == DateTime.MinValue)
            toTime = DateTime.Now.Date;
        return toTime;
    }
    private DateTime toDateT()
    {
        DateTime toTime;
        string toT = "";
        toT = txtToDate.Text;
        
        DateTime.TryParse(toT, out toTime);
        if (toTime == DateTime.MinValue)
            toTime = DateTime.Now.Date;
        return toTime;
    }

    private void LoadDateTime()
    {
        if (Session["FromDateTemperature"] != null)
        {
            DateTime startdate = (DateTime)Session["FromDateTemperature"];
            if (startdate.Year > 1753)
            {
                txtFromDate.Text = startdate.ToShortDateString();
                txtFromDateChart.Text = startdate.ToShortDateString();
            }
        }

        if (Session["ToDateTemperature"] != null)
        {
            DateTime startdate = (DateTime)Session["ToDateTemperature"];
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
    protected void btnPrint_Click(object sender, EventArgs e)
    {
        
    }
    protected void ddl_number_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddl_number.SelectedValue == "0")
        {
            grvTemp.AllowPaging = false;
            if (Session["FromDateTemperature"] == null && Session["ToDateTemperature"] == null)
            {
                LoadTempDefaultUser();
            }
            else
                 LoadGridviewTemp(0,fromDateT(),toDateT());
            pager(0);
        }
        else
        {
            Page_number(ToSQL.SQLToInt(ddl_number.SelectedValue));
            if (Session["FromDateTemperature"] == null && Session["ToDateTemperature"] == null)
            {
                LoadTempDefaultUser();
                LoadGridDefault(0);
            }
            else
                LoadGridviewTemp(0,fromDateT(),toDateT());
            pager(0);
        }
    }
    private void Page_number(int i)
    {
        grvTemp.AllowPaging = true;
        grvTemp.PageSize = i;
        if(!IsPostBack)
            ddl_number.SelectedValue = i.ToString();
        Session["Page_Temp"] = i;
    }
    #region Refresh
    protected override void LoadViewState(object savedState)
    {
        try
        {
            object[] AllStates = (object[])savedState;
            base.LoadViewState(AllStates[0]);
            _refreshState = bool.Parse(AllStates[1].ToString());
            _isRefresh = _refreshState ==
            bool.Parse(Session["__ISREFRESH"].ToString());
        }
        catch
        { }
    }

    protected override object SaveViewState()
    {
        Session["__ISREFRESH"] = _refreshState;
        object[] AllStates = new object[2];
        AllStates[0] = base.SaveViewState();
        AllStates[1] = !(_refreshState);
        return AllStates;
    }
    #endregion
    protected void ImageButton2_Click(object sender, ImageClickEventArgs e)
    {
        if (!_isRefresh)
        {
            if(MultiViewTemperature.ActiveViewIndex == 1)
            {
                grvTemp.AllowPaging = false;
                grvTemp.ShowHeader = true;
                BaseView.PrintWebControl(grvTemp);
                grvTemp.AllowPaging = true;
                grvTemp.ShowHeader = false;
            }
            else
            {
               ClientScript.RegisterStartupScript(this.GetType(), "", "<script language='JavaScript'>processPrint('print');</script>");
            }
        }
    }
    protected void lnlinks_Click(object sender, EventArgs e)
    {
        Session["FromDateTemperature"] = null ;
        Session["ToDateTemperature"] = null;
        Session["Page_Temp"] = null;
        Session["PageIndex_Temp"] = null;
        Session["IndexTab_Temperture"] = null;
        Response.Redirect("~/usertrackmyhealth_temperature.aspx");
    }
}