using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Drawing;
/**
 * User track others fitness
 * */
public partial class usertrackothers_fitness : System.Web.UI.Page
{
    private DBClass _db = new DBClass();
    private string Username = "";
    private DataTable dt = new DataTable();
    static int i = 1;
    private DataTable dataTime = new DataTable();
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
            fullName();
            LoadDateTime();
            Load_HRExercise(0);
            Load_TablePedometer(0);
            Select_graph(false);
        }
    }
    #region Page
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

    private void LoadDateTime()
    {
        if (Session["FromDateFitness"] != null)
        {
            DateTime startdate = (DateTime)Session["FromDateFitness"];
            if (startdate.Year > 1753)
            {
                txtFromDate.Text = startdate.ToShortDateString();
                txtFromDateTable.Text = startdate.ToShortDateString();
            }
        }

        if (Session["ToDateFitness"] != null)
        {
            DateTime startdate = (DateTime)Session["ToDateFitness"];
            if (startdate.Year > 1753)
            {
                txtToDate.Text = startdate.ToShortDateString();
                txtToDateTable.Text = startdate.ToShortDateString();
            }
        }
    }

    #endregion

    #region Graph
    protected void ddlParameter_SelectedIndexChanged(object sender, EventArgs e)
    {
        LoadFitness_Graph();
    }
    protected void btnOk_Click(object sender, EventArgs e)
    {
        Session["ToDateFitness"] = toDateGraph();
        if (fromDate().Year > 1753)
        {
            Session["FromDateFitness"] = fromDateGraph();
        }
        else
        {
            MessagesBox.jQueryShow(ClientScript, this.GetType(), DBClass.GetMessageByCode2("SelectTime"), "Notice");
            pnEmptyData.Visible = true;
            return;
        }
        Load_HRExercise(0);
        Load_TablePedometer(0);
        LoadFitness_Graph();
        date_graph.Visible = false;
    }

    private DateTime fromDateGraph()
    {
        DateTime fromTime = DateTime.MinValue;
        string fromT = "";
        if (txtFromDate.Text == "" || String.IsNullOrEmpty(txtFromDate.Text))
        {
            fromT = txtFromDateTable.Text;
        }
        else
        {
            fromT = txtFromDate.Text;
        }
        DateTime.TryParse(fromT, out fromTime);
        if (fromTime == DateTime.MinValue)
            fromTime = DateTime.Now.Date;
        return fromTime;
    }
    private DateTime toDateGraph()
    {
        DateTime toTime;
        string toT = "";
        if (txtToDate.Text == "" || String.IsNullOrEmpty(txtToDate.Text))
        {
            toT = txtToDateTable.Text;
        }
        else
        {
            toT = txtToDate.Text;
        }
        DateTime.TryParse(toT, out toTime);
        if (toTime == DateTime.MinValue)
            toTime = DateTime.Now.Date;
        return toTime;
    }

    private void Load_DLL()
    {
        DataTable dt = _db.GetList_Fitness_Pedometer_Table(userName(), null, null);
        ddlParameter.DataSource = dt;
        ddlParameter.DataBind();
    }

    private void LoadFitness_Graph()
    {
        WebChartFitness.Chart.Series.RemoveAllSeries();
        switch (ddlParameter.SelectedValue)
        {
            case "step_counts":
                LoadStepCounts(ddlParameter.SelectedValue);
                break;
            case "distance":
                LoadDistance(ddlParameter.SelectedValue);
                break;
            case "average_speed":
                LoadAverageSpeed(ddlParameter.SelectedValue);
                break;
            case "calory_burn":
                LoadCaloriesBurned(ddlParameter.SelectedValue);
                break;
            case "pedometer_duration":
                LoadPedometerDuration(ddlParameter.SelectedValue);
                break;
            default:
                LoadStepCounts("step_counts");
                break;
        }
    }

    private void LoadStepCounts(string ParameterCode)
    {
        DataTable dt = _db.GetList_Fitness_Pedometer_Graph_ByParameterCode(userName(), fromDateGraph(), toDateGraph(), ParameterCode);
        if (dt != null && dt.Rows.Count > 0)
        {
            pnEmptyData.Visible = false;
            pnFitness.Visible = true;
            Steema.TeeChart.Styles.Bar sTarget = new Steema.TeeChart.Styles.Bar();
            Steema.TeeChart.Styles.Bar sSteps = new Steema.TeeChart.Styles.Bar();
            sTarget.Title = "Target";
            sSteps.Title = "Step Counts";
            foreach (DataRow row in dt.Rows)
            {
                sTarget.Add(BaseView.GetDateTimeFieldValue(row, "ReceivedDate"), BaseView.GetFloatFieldValue(row, "TargetPM"));
                sSteps.Add(BaseView.GetDateTimeFieldValue(row, "ReceivedDate"), BaseView.GetFloatFieldValue(row, "Steps"));
            }
            sTarget.Marks.Visible = false;
            sSteps.Marks.Visible = false;
            WebChartFitness.Chart.Series.Add(sTarget);
            WebChartFitness.Chart.Series.Add(sSteps);
            WebChartFitness.Chart.Axes.Left.Title.Text = "Steps";
        }
        else
        {
            pnEmptyData.Visible = true;
            pnFitness.Visible = false;
        }
    }

    private void LoadDistance(string ParameterCode)
    {
        DataTable dt = _db.GetList_Fitness_Pedometer_Graph_ByParameterCode(userName(), fromDateGraph(), toDateGraph(), ParameterCode);
        if (dt != null && dt.Rows.Count > 0)
        {
            pnEmptyData.Visible = false;
            pnFitness.Visible = true;
            Steema.TeeChart.Styles.Bar sTarget = new Steema.TeeChart.Styles.Bar();
            Steema.TeeChart.Styles.Bar sSteps = new Steema.TeeChart.Styles.Bar();
            sTarget.Title = "Target";
            sSteps.Title = "Distance";
            foreach (DataRow row in dt.Rows)
            {
                sTarget.Add(BaseView.GetDateTimeFieldValue(row, "ReceivedDate"), BaseView.GetFloatFieldValue(row, "TargetPM"));
                sSteps.Add(BaseView.GetDateTimeFieldValue(row, "ReceivedDate"), BaseView.GetFloatFieldValue(row, "Distance"));
            }
            WebChartFitness.Chart.Series.Add(sTarget);
            WebChartFitness.Chart.Series.Add(sSteps);
            WebChartFitness.Chart.Axes.Left.Title.Text = "Distance";
        }
        else
        {
            pnEmptyData.Visible = true;
            pnFitness.Visible = false;
        }
    }

    private void LoadAverageSpeed(string ParameterCode)
    {
        DataTable dt = _db.GetList_Fitness_Pedometer_Graph_ByParameterCode(userName(), fromDateGraph(), toDateGraph(), ParameterCode);
        if (dt != null && dt.Rows.Count > 0)
        {
            pnEmptyData.Visible = false;
            pnFitness.Visible = true;
            Steema.TeeChart.Styles.Bar sTarget = new Steema.TeeChart.Styles.Bar();
            Steema.TeeChart.Styles.Bar sSteps = new Steema.TeeChart.Styles.Bar();
            sTarget.Title = "Target";
            sSteps.Title = "Average Speed";
            foreach (DataRow row in dt.Rows)
            {
                sTarget.Add(BaseView.GetDateTimeFieldValue(row, "ReceivedDate"), BaseView.GetFloatFieldValue(row, "TargetPM"));
                sSteps.Add(BaseView.GetDateTimeFieldValue(row, "ReceivedDate"), BaseView.GetFloatFieldValue(row, "AverageSpeed"));
            }
            WebChartFitness.Chart.Series.Add(sTarget);
            WebChartFitness.Chart.Series.Add(sSteps);
            WebChartFitness.Chart.Axes.Left.Title.Text = "AverageSpeed";
        }
        else
        {
            pnEmptyData.Visible = true;
            pnFitness.Visible = false;
        }
    }

    private void LoadCaloriesBurned(string ParameterCode)
    {
        DataTable dt = _db.GetList_Fitness_Pedometer_Graph_ByParameterCode(userName(), fromDateGraph(), toDateGraph(), ParameterCode);
        if (dt != null && dt.Rows.Count > 0)
        {
            pnEmptyData.Visible = false;
            pnFitness.Visible = true;
            Steema.TeeChart.Styles.Bar sTarget = new Steema.TeeChart.Styles.Bar();
            Steema.TeeChart.Styles.Bar sSteps = new Steema.TeeChart.Styles.Bar();
            sTarget.Title = "Target";
            sSteps.Title = "CaloryBurn";
            foreach (DataRow row in dt.Rows)
            {
                sTarget.Add(BaseView.GetDateTimeFieldValue(row, "ReceivedDate"), BaseView.GetFloatFieldValue(row, "TargetPM"));
                sSteps.Add(BaseView.GetDateTimeFieldValue(row, "ReceivedDate"), BaseView.GetFloatFieldValue(row, "CaloryBurn"));
            }
            WebChartFitness.Chart.Series.Add(sTarget);
            WebChartFitness.Chart.Series.Add(sSteps);
            WebChartFitness.Chart.Axes.Left.Title.Text = "Calory Burn";
        }
        else
        {
            pnEmptyData.Visible = true;
            pnFitness.Visible = false;
        }
    }

    private void LoadPedometerDuration(string ParameterCode)
    {
        DataTable dt = _db.GetList_Fitness_Pedometer_Graph_ByParameterCode(userName(), fromDateGraph(), toDateGraph(), ParameterCode);
        if (dt != null && dt.Rows.Count < 10)
        {
            ((Steema.TeeChart.Tools.ScrollTool)WebChartFitness.Chart.Tools[0]).StartPosition = 0;
            ((Steema.TeeChart.Tools.ScrollTool)WebChartFitness.Chart.Tools[0]).ViewSegmentSize = dt.Rows.Count / 100;
        }
        if (dt != null && dt.Rows.Count > 0)
        {
            pnEmptyData.Visible = false;
            pnFitness.Visible = true;
            Steema.TeeChart.Styles.Bar sTarget = new Steema.TeeChart.Styles.Bar();
            Steema.TeeChart.Styles.Bar sSteps = new Steema.TeeChart.Styles.Bar();
            sTarget.UseAxis = false;
            sTarget.Title = "Target";
            sSteps.Title = "Duration";
            foreach (DataRow row in dt.Rows)
            {
                sTarget.Add(BaseView.GetDateTimeFieldValue(row, "ReceivedDate"), BaseView.GetFloatFieldValue(row, "TargetPM"));
                sSteps.Add(BaseView.GetDateTimeFieldValue(row, "ReceivedDate"), BaseView.GetFloatFieldValue(row, "Duration"));
            }
            WebChartFitness.Chart.Series.Add(sTarget);
            WebChartFitness.Chart.Series.Add(sSteps);
            WebChartFitness.Chart.Axes.Left.Title.Text = "Duration";
        }
        else
        {
            pnEmptyData.Visible = true;
            pnFitness.Visible = false;
        }
    }

    #endregion

    #region Table
    private void Add_grvHRExercise(DataTable table)
    {
        grvHRExercise.DataSource = table;
        grvHRExercise.DataBind();
    }
    private void Add_grvPedometer(DataTable table)
    {
        grvPedometer.DataSource = table;
        grvPedometer.DataBind();
    }

    private void Load_HRExercise(int index)
    {
        grvHRExercise.PageIndex = index;
        DataTable table = _db.GetList_Fitness_HRExercise_Table(userName(), fromDate(), toDate());
        Add_grvHRExercise(table);
        pager(index);
    }
    private void Load_TablePedometer(int index)
    {
        grvPedometer.PageIndex = index;
        DataTable table = _db.GetList_Fitness_Pedometer_Table(userName(), fromDate(), toDate());
        Add_grvPedometer(table);
        pager2(index);
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
            fromTime = DateTime.Parse("1/1/1753 12:00:00 AM");
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
            toTime = DateTime.MaxValue;
        return toTime;
    }
    protected void btnView_Click(object sender, EventArgs e)
    {
        if (fromDate() == DateTime.MinValue || toDate() == DateTime.MinValue)
        {
            MessagesBox.jQueryShow(ClientScript, this.GetType(), DBClass.GetMessageByCode2("SelectTime"), "Notice");
        }
        else
        {
            Load_HRExercise(0);
            Load_TablePedometer(0);
            LoadFitness_Graph();
            date_table.Visible = false;
        }
    }
    protected void grvHRExercise_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        Load_HRExercise(e.NewPageIndex);
    }
    protected void grvPedometer_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        Load_TablePedometer(e.NewPageIndex);
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
        MultiViewHeartRate.ActiveViewIndex = 0;
        Select_graph(false);
    }
    protected void btnTable2_Click(object sender, EventArgs e)
    {
        MultiViewHeartRate.ActiveViewIndex = 1;
        Select_graph(true);
    }
    #endregion

    #region pager
    protected void back_Click(object sender, ImageClickEventArgs e)
    {
        i = grvHRExercise.PageIndex;
        if (grvHRExercise.PageIndex > 0)
        {
            grvHRExercise.PageIndex = i--;
            Load_HRExercise(i);
            pager(i);
        }
    }
    protected void next_Click(object sender, ImageClickEventArgs e)
    {
        if (grvHRExercise.PageIndex < grvHRExercise.PageCount - 1)
        {
            i = grvHRExercise.PageIndex;
            grvHRExercise.PageIndex = i++;
            Load_HRExercise(i);
            pager(i);
        }
    }
    private void pager(int index)
    {
        int pagecount = index + 1;
        txtpage.Text = pagecount.ToString();
        lb_pager.Text = "/" + grvHRExercise.PageCount.ToString();
    }
    private void pager2(int index)
    {
        int pagecount = index + 1;
        txt_page2.Text = pagecount.ToString();
        lbpage2.Text = "/" + grvPedometer.PageCount.ToString();
    }
    protected void txtpage_TextChanged(object sender, EventArgs e)
    {
        int page = Int32.Parse(txtpage.Text);
        int index = page - 1;
        Load_HRExercise(i);
        pager(index);
    }
    protected void btn_back1_Click(object sender, ImageClickEventArgs e)
    {
        i = grvPedometer.PageIndex;
        if (grvPedometer.PageIndex > 0)
        {
            grvPedometer.PageIndex = i--;
            Load_TablePedometer(i);
            pager2(i);
        }
    }
    protected void btn_next2_Click(object sender, ImageClickEventArgs e)
    {
        if (grvPedometer.PageIndex < grvPedometer.PageCount - 1)
        {
            i = grvPedometer.PageIndex;
            grvPedometer.PageIndex = i++;
            Load_TablePedometer(i);
            pager2(i);
        }
    }
    protected void txt_page2_TextChanged(object sender, EventArgs e)
    {
        int page = Int32.Parse(txt_page2.Text);
        int index = page - 1;
        Load_TablePedometer(i);
        pager2(index);
    }
    #endregion
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
    protected void lbtnDateTime_Click(object sender, EventArgs e)
    {
        date_graph.Visible = true;
    }
}