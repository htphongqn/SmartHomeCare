using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Web.UI.DataVisualization.Charting;
using System.Drawing;
using DevExpress.XtraCharts;
public partial class usertrackmyhealth_fitness : System.Web.UI.Page
{
    DBClass _db = new DBClass();
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
            ddlNo2.SelectedValue = "100";
            if (Session["FromDateFitness"] == null && Session["FromDateFitness"] == null)
            {
                LoadFitness_Graph_Default();

                if (Session["Page_NoFitness1"] != null)
                {
                    Page_number((int)Session["Page_NoFitness1"]);
                }
                if (Session["Page_NoFitness2"] != null)
                {
                    Page_number2((int)Session["Page_NoFitness2"]);
                }
                if (Session["PageIndex_Fitness"] != null)
                    Load_HRExercise_Default((int)Session["PageIndex_Fitness"]);
                else
                    Load_HRExercise_Default(0);
                if (Session["PageIndex_Fitness2"] != null)
                    Load_TablePedometer_Default((int)Session["PageIndex_Fitness2"]);
                else
                    Load_TablePedometer_Default(0);
            }
            else
            {
                if (Session["Page_NoFitness1"] != null )
                {
                    Page_number((int)Session["Page_NoFitness1"]);
                }
                if (Session["Page_NoFitness2"] != null)
                {
                    Page_number2((int)Session["Page_NoFitness2"]);
                }
                if (Session["PageIndex_Fitness"] != null)
                    Load_HRExercise((int)Session["PageIndex_Fitness"]);
                else
                    Load_HRExercise(0);
                if (Session["PageIndex_Fitness2"] != null)
                    Load_TablePedometer((int)Session["PageIndex_Fitness2"]);
                else
                    Load_TablePedometer(0);
                LoadFitness_Graph();
                
            }
            if (Session["IndexTab_Fitness"] != null)
            {
                if ((int)Session["IndexTab_Fitness"] == 1)
                {
                    Select_graph(true);
                    MultiViewHeartRate.ActiveViewIndex = 1;
                    if (Session["ActiveTab"] != null && (int)Session["ActiveTab"] == 1)
                    {
                        Subtab.ActiveTabIndex = 1;
                    }
                    else
                    {
                        Subtab.ActiveTabIndex = 0;
                    }
                }
                else
                {
                    Select_graph(false);
                    MultiViewHeartRate.ActiveViewIndex = 0;
                }
            }
            else
            {
                Select_graph(false);
            }
        }
        else
        {
            if (Session["FromDateFitness"] == null && Session["FromDateFitness"] == null)
            {
                LoadFitness_Graph_Default();
            }
            else
            {
                LoadFitness_Graph();
            }
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
            if (Session["FromDateFitness"] == null && Session["FromDateFitness"] == null)
            {
                LoadFitness_Graph_Default();
            }
            else
            {
                LoadFitness_Graph();
            }
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

        //private void LoadFitness_Graph_Default()
        //{
        //    switch (ddlParameter.SelectedValue)
        //    {
        //        case "step_counts":
        //            LoadStepCountsDefault(ddlParameter.SelectedValue);
        //            break;
        //        case "distance":
        //            LoadDistanceDefault(ddlParameter.SelectedValue);
        //            break;
        //        case "average_speed":
        //            LoadAverageSpeedDefault(ddlParameter.SelectedValue);
        //            break;
        //        case "calory_burn":
        //            LoadCaloriesBurnedDefault(ddlParameter.SelectedValue);
        //            break;
        //        case "pedometer_duration":
        //            LoadPedometerDurationDefault(ddlParameter.SelectedValue);
        //            break;
        //        default:
        //            LoadStepCountsDefault("step_counts");
        //            break;
        //    }
        //}
        private void LoadFitness_Graph_Default()
        {
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


        //private void LoadStepCounts(string ParameterCode)
        //{
        //    WebChartFitness.Chart.Series.RemoveAllSeries();
        //    DataTable dt = _db.GetList_Fitness_Pedometer_Graph_ByParameterCode(userName(), fromDateGraph(), toDateGraph(), ParameterCode);
        //    if (dt != null && dt.Rows.Count > 0)
        //    {
        //        pnEmptyData.Visible = false;
        //        pnFitness.Visible = true;
        //        Steema.TeeChart.Styles.Bar sTarget = new Steema.TeeChart.Styles.Bar();
        //        Steema.TeeChart.Styles.Bar sSteps = new Steema.TeeChart.Styles.Bar();
        //        sTarget.Title = "Target";
        //        sSteps.Title = "Step Counts";
        //        foreach (DataRow row in dt.Rows)
        //        {
        //            sTarget.Add(BaseView.GetDateTimeFieldValue(row, "ReceivedDate"), BaseView.GetFloatFieldValue(row, "TargetPM"));
        //            sSteps.Add(BaseView.GetDateTimeFieldValue(row, "ReceivedDate"), BaseView.GetFloatFieldValue(row, "Steps"));
        //        }
        //        WebChartFitness.Chart.Series.Add(sTarget);
        //        WebChartFitness.Chart.Series.Add(sSteps);
        //        WebChartFitness.Chart.Axes.Left.Title.Text = "Steps";
        //      }
        //    else
        //    {
        //        pnEmptyData.Visible = true;
        //        pnFitness.Visible = false;
        //    }
        //}
        private void LoadStepCounts(string ParameterCode)
        {
            DataTable dt = _db.GetList_Fitness_Pedometer_Graph_ByParameterCode(userName(), fromDateGraph(), toDateGraph(), ParameterCode);
            if (dt != null && dt.Rows.Count > 0)
            {
                pnEmptyData.Visible = false;
                pnFitness.Visible = true;

                ChartFitness.Series.Clear();
                string nameOfSeries1 = "Target";
                DevExpress.XtraCharts.Series Series1 = new DevExpress.XtraCharts.Series(nameOfSeries1, ViewType.StackedBar);
                Series1.ArgumentDataMember = "ReceivedDate";
                Series1.ArgumentScaleType = ScaleType.DateTime;
                Series1.ValueDataMembersSerializable = "TargetPM";
                ChartFitness.Series.Add(Series1);

                string nameOfSeries2 = "Step Count";
                DevExpress.XtraCharts.Series Series2 = new DevExpress.XtraCharts.Series(nameOfSeries2, ViewType.StackedBar);
                Series2.ArgumentDataMember = "ReceivedDate";
                Series2.ArgumentScaleType = ScaleType.DateTime;
                Series2.ValueDataMembersSerializable = "Steps";
                ChartFitness.Series.Add(Series2);

                ChartFitness.DataSource = dt;
                ChartFitness.DataBind();
            }
            else
            {
                pnEmptyData.Visible = true;
                pnFitness.Visible = false;
            }
        }

        //private void LoadDistance(string ParameterCode)
        //{
        //    WebChartFitness.Chart.Series.RemoveAllSeries();
        //    DataTable dt = _db.GetList_Fitness_Pedometer_Graph_ByParameterCode(userName(), fromDateGraph(), toDateGraph(), ParameterCode);
        //    if (dt != null && dt.Rows.Count > 0)
        //    {
        //        pnEmptyData.Visible = false;
        //        pnFitness.Visible = true;
        //        Steema.TeeChart.Styles.Bar sTarget = new Steema.TeeChart.Styles.Bar();
        //        Steema.TeeChart.Styles.Bar sSteps = new Steema.TeeChart.Styles.Bar();
        //        sTarget.Title = "Target";
        //        sSteps.Title = "Distance";
        //        foreach (DataRow row in dt.Rows)
        //        {
        //            sTarget.Add(BaseView.GetDateTimeFieldValue(row, "ReceivedDate"), BaseView.GetFloatFieldValue(row, "TargetPM"));
        //            sSteps.Add(BaseView.GetDateTimeFieldValue(row, "ReceivedDate"), BaseView.GetFloatFieldValue(row, "Distance"));
        //        }
        //        WebChartFitness.Chart.Series.Add(sTarget);
        //        WebChartFitness.Chart.Series.Add(sSteps);
        //        WebChartFitness.Chart.Axes.Left.Title.Text = "Distance";
        //    }
        //    else
        //    {
        //        pnEmptyData.Visible = true;
        //        pnFitness.Visible = false;
        //    }
        //}
        private void LoadDistance(string ParameterCode)
        {
            DataTable dt = _db.GetList_Fitness_Pedometer_Graph_ByParameterCode(userName(), fromDateGraph(), toDateGraph(), ParameterCode);
            if (dt != null && dt.Rows.Count > 0)
            {
                pnEmptyData.Visible = false;
                pnFitness.Visible = true;

                ChartFitness.Series.Clear();
                string nameOfSeries1 = "Target";
                DevExpress.XtraCharts.Series Series1 = new DevExpress.XtraCharts.Series(nameOfSeries1, ViewType.StackedBar);
                Series1.ArgumentDataMember = "ReceivedDate";
                Series1.ArgumentScaleType = ScaleType.DateTime;
                Series1.ValueDataMembersSerializable = "TargetPM";
                ChartFitness.Series.Add(Series1);

                string nameOfSeries2 = "Distance";
                DevExpress.XtraCharts.Series Series2 = new DevExpress.XtraCharts.Series(nameOfSeries2, ViewType.StackedBar);
                Series2.ArgumentDataMember = "ReceivedDate";
                Series2.ArgumentScaleType = ScaleType.DateTime;
                Series2.ValueDataMembersSerializable = "Distance";
                ChartFitness.Series.Add(Series2);

                ChartFitness.DataSource = dt;
                ChartFitness.DataBind();
            }
            else
            {
                pnEmptyData.Visible = true;
                pnFitness.Visible = false;
            }
        }

        //private void LoadAverageSpeed(string ParameterCode)
        //{
        //    WebChartFitness.Chart.Series.RemoveAllSeries();
        //    DataTable dt = _db.GetList_Fitness_Pedometer_Graph_ByParameterCode(userName(), fromDateGraph(), toDateGraph(), ParameterCode);
        //    if (dt != null && dt.Rows.Count > 0)
        //    {
        //        pnEmptyData.Visible = false;
        //        pnFitness.Visible = true;
        //        Steema.TeeChart.Styles.Bar sTarget = new Steema.TeeChart.Styles.Bar();
        //        Steema.TeeChart.Styles.Bar sSteps = new Steema.TeeChart.Styles.Bar();
        //        sTarget.Title = "Target";
        //        sSteps.Title = "Average Speed";
        //        foreach (DataRow row in dt.Rows)
        //        {
        //            sTarget.Add(BaseView.GetDateTimeFieldValue(row, "ReceivedDate"), BaseView.GetFloatFieldValue(row, "TargetPM"));
        //            sSteps.Add(BaseView.GetDateTimeFieldValue(row, "ReceivedDate"), BaseView.GetFloatFieldValue(row, "AverageSpeed"));
        //        }
        //        WebChartFitness.Chart.Series.Add(sTarget);
        //        WebChartFitness.Chart.Series.Add(sSteps);
        //        WebChartFitness.Chart.Axes.Left.Title.Text = "AverageSpeed";
        //    }
        //    else
        //    {
        //        pnEmptyData.Visible = true;
        //        pnFitness.Visible = false;
        //    }
        //}
        private void LoadAverageSpeed(string ParameterCode)
        {
            DataTable dt = _db.GetList_Fitness_Pedometer_Graph_ByParameterCode(userName(), fromDateGraph(), toDateGraph(), ParameterCode);
            if (dt != null && dt.Rows.Count > 0)
            {
                pnEmptyData.Visible = false;
                pnFitness.Visible = true;

                ChartFitness.Series.Clear();
                string nameOfSeries1 = "Target";
                DevExpress.XtraCharts.Series Series1 = new DevExpress.XtraCharts.Series(nameOfSeries1, ViewType.StackedBar);
                Series1.ArgumentDataMember = "ReceivedDate";
                Series1.ArgumentScaleType = ScaleType.DateTime;
                Series1.ValueDataMembersSerializable = "TargetPM";
                ChartFitness.Series.Add(Series1);

                string nameOfSeries2 = "Average Speed";
                DevExpress.XtraCharts.Series Series2 = new DevExpress.XtraCharts.Series(nameOfSeries2, ViewType.StackedBar);
                Series2.ArgumentDataMember = "ReceivedDate";
                Series2.ArgumentScaleType = ScaleType.DateTime;
                Series2.ValueDataMembersSerializable = "AverageSpeed";
                ChartFitness.Series.Add(Series2);

                ChartFitness.DataSource = dt;
                ChartFitness.DataBind();
            }
            else
            {
                pnEmptyData.Visible = true;
                pnFitness.Visible = false;
            }
        }

        //private void LoadCaloriesBurned(string ParameterCode)
        //{
        //    WebChartFitness.Chart.Series.RemoveAllSeries();
        //    DataTable dt = _db.GetList_Fitness_Pedometer_Graph_ByParameterCode(userName(), fromDateGraph(), toDateGraph(), ParameterCode);
        //    if (dt != null && dt.Rows.Count > 0)
        //    {
        //        pnEmptyData.Visible = false;
        //        pnFitness.Visible = true;
        //        Steema.TeeChart.Styles.Bar sTarget = new Steema.TeeChart.Styles.Bar();
        //        Steema.TeeChart.Styles.Bar sSteps = new Steema.TeeChart.Styles.Bar();
        //        sTarget.Title = "Target";
        //        sSteps.Title = "CaloryBurn";
        //        foreach (DataRow row in dt.Rows)
        //        {
        //            sTarget.Add(BaseView.GetDateTimeFieldValue(row, "ReceivedDate"), BaseView.GetFloatFieldValue(row, "TargetPM"));
        //            sSteps.Add(BaseView.GetDateTimeFieldValue(row, "ReceivedDate"), BaseView.GetFloatFieldValue(row, "CaloryBurn"));
        //        }
        //        WebChartFitness.Chart.Series.Add(sTarget);
        //        WebChartFitness.Chart.Series.Add(sSteps);
        //        WebChartFitness.Chart.Axes.Left.Title.Text = "Calory Burn";
        //    }
        //    else
        //    {
        //        pnEmptyData.Visible = true;
        //        pnFitness.Visible = false;
        //    }
        //}
        private void LoadCaloriesBurned(string ParameterCode)
        {
            DataTable dt = _db.GetList_Fitness_Pedometer_Graph_ByParameterCode(userName(), fromDateGraph(), toDateGraph(), ParameterCode);
            if (dt != null && dt.Rows.Count > 0)
            {
                pnEmptyData.Visible = false;
                pnFitness.Visible = true;

                ChartFitness.Series.Clear();
                string nameOfSeries1 = "Target";
                DevExpress.XtraCharts.Series Series1 = new DevExpress.XtraCharts.Series(nameOfSeries1, ViewType.StackedBar);
                Series1.ArgumentDataMember = "ReceivedDate";
                Series1.ArgumentScaleType = ScaleType.DateTime;
                Series1.ValueDataMembersSerializable = "TargetPM";
                ChartFitness.Series.Add(Series1);

                string nameOfSeries2 = "Colories Burn";
                DevExpress.XtraCharts.Series Series2 = new DevExpress.XtraCharts.Series(nameOfSeries2, ViewType.StackedBar);
                Series2.ArgumentDataMember = "ReceivedDate";
                Series2.ArgumentScaleType = ScaleType.DateTime;
                Series2.ValueDataMembersSerializable = "CaloryBurn";
                ChartFitness.Series.Add(Series2);

                ChartFitness.DataSource = dt;
                ChartFitness.DataBind();
            }
            else
            {
                pnEmptyData.Visible = true;
                pnFitness.Visible = false;
            }
        }

        //private void LoadPedometerDuration(string ParameterCode)
        //{
        //    WebChartFitness.Chart.Series.RemoveAllSeries();
        //    DataTable dt = _db.GetList_Fitness_Pedometer_Graph_ByParameterCode(userName(), fromDateGraph(), toDateGraph(), ParameterCode);
        //    if (dt != null && dt.Rows.Count < 10)
        //    {
        //        ((Steema.TeeChart.Tools.ScrollTool)WebChartFitness.Chart.Tools[0]).StartPosition = 0;
        //        ((Steema.TeeChart.Tools.ScrollTool)WebChartFitness.Chart.Tools[0]).ViewSegmentSize = dt.Rows.Count / 100;
        //    }
        //    if (dt != null && dt.Rows.Count > 0)
        //    {
        //        pnEmptyData.Visible = false;
        //        pnFitness.Visible = true;
        //        Steema.TeeChart.Styles.Bar sTarget = new Steema.TeeChart.Styles.Bar();
        //        Steema.TeeChart.Styles.Bar sSteps = new Steema.TeeChart.Styles.Bar();
        //        sTarget.UseAxis = false;
        //        sTarget.Title = "Target";
        //        sSteps.Title = "Duration";
        //        foreach (DataRow row in dt.Rows)
        //        {
        //            sTarget.Add(BaseView.GetDateTimeFieldValue(row, "ReceivedDate"), BaseView.GetFloatFieldValue(row, "TargetPM"));
        //            sSteps.Add(BaseView.GetDateTimeFieldValue(row, "ReceivedDate"), BaseView.GetFloatFieldValue(row, "Duration"));
        //        }
        //        WebChartFitness.Chart.Series.Add(sTarget);
        //        WebChartFitness.Chart.Series.Add(sSteps);
        //        WebChartFitness.Chart.Axes.Left.Title.Text = "Duration";
        //    }
        //    else
        //    {
        //        pnEmptyData.Visible = true;
        //        pnFitness.Visible = false;
        //    }
        //}
        private void LoadPedometerDuration(string ParameterCode)
        {
            DataTable dt = _db.GetList_Fitness_Pedometer_Graph_ByParameterCode(userName(), fromDateGraph(), toDateGraph(), ParameterCode);
            if (dt != null && dt.Rows.Count > 0)
            {
                pnEmptyData.Visible = false;
                pnFitness.Visible = true;

                ChartFitness.Series.Clear();
                string nameOfSeries1 = "Target";
                DevExpress.XtraCharts.Series Series1 = new DevExpress.XtraCharts.Series(nameOfSeries1, ViewType.StackedBar);
                Series1.ArgumentDataMember = "ReceivedDate";
                Series1.ArgumentScaleType = ScaleType.DateTime;
                Series1.ValueDataMembersSerializable = "TargetPM";
                ChartFitness.Series.Add(Series1);

                string nameOfSeries2 = "Pedometer Duration";
                DevExpress.XtraCharts.Series Series2 = new DevExpress.XtraCharts.Series(nameOfSeries2, ViewType.StackedBar);
                Series2.ArgumentDataMember = "ReceivedDate";
                Series2.ArgumentScaleType = ScaleType.DateTime;
                Series2.ValueDataMembersSerializable = "Duration";
                ChartFitness.Series.Add(Series2);

                ChartFitness.DataSource = dt;
                ChartFitness.DataBind();
            }
            else
            {
                pnEmptyData.Visible = true;
                pnFitness.Visible = false;
            }
        }

        //private void LoadStepCountsDefault(string ParameterCode)
        //{
        //    WebChartFitness.Chart.Series.RemoveAllSeries();
        //    //DataTable dt = _db.GetList_Fitness_Pedometer_Graph_Default(userName(), ParameterCode);
        //    DataTable dt = _db.GetList_Fitness_Pedometer_Graph_ByParameterCode(userName(), null, null, ParameterCode);
        //    if (dt != null && dt.Rows.Count > 0)
        //    {
        //        pnEmptyData.Visible = false;
        //        pnFitness.Visible = true;
        //        Steema.TeeChart.Styles.Bar sTarget = new Steema.TeeChart.Styles.Bar();
        //        Steema.TeeChart.Styles.Bar sSteps = new Steema.TeeChart.Styles.Bar();
        //        sTarget.Title = "Target";
        //        sSteps.Title = "Step Counts";
        //        foreach (DataRow row in dt.Rows)
        //        {
        //            sTarget.Add(BaseView.GetDateTimeFieldValue(row, "ReceivedDate"), BaseView.GetFloatFieldValue(row, "TargetPM"));
        //            sSteps.Add(BaseView.GetDateTimeFieldValue(row, "ReceivedDate"), BaseView.GetFloatFieldValue(row, "Steps"));
        //        }
        //        WebChartFitness.Chart.Series.Add(sTarget);
        //        WebChartFitness.Chart.Series.Add(sSteps);
        //        WebChartFitness.Chart.Axes.Left.Title.Text = "Steps";
        //    }
        //    else
        //    {
        //        pnEmptyData.Visible = true;
        //        pnFitness.Visible = false;
        //    }
        //}
        private void LoadStepCountsDefault(string ParameterCode)
        {
            DataTable dt = _db.GetList_Fitness_Pedometer_Graph_ByParameterCode(userName(), null, null, ParameterCode);
            if (dt != null && dt.Rows.Count > 0)
            {
                pnEmptyData.Visible = false;
                pnFitness.Visible = true;


            }
            else
            {
                pnEmptyData.Visible = true;
                pnFitness.Visible = false;
            }
        }

        //private void LoadDistanceDefault(string ParameterCode)
        //{
        //    WebChartFitness.Chart.Series.RemoveAllSeries();
        //    DataTable dt = _db.GetList_Fitness_Pedometer_Graph_Default(userName(), ParameterCode);
        //    if (dt != null && dt.Rows.Count > 0)
        //    {
        //        pnEmptyData.Visible = false;
        //        pnFitness.Visible = true;
        //        Steema.TeeChart.Styles.Bar sTarget = new Steema.TeeChart.Styles.Bar();
        //        Steema.TeeChart.Styles.Bar sSteps = new Steema.TeeChart.Styles.Bar();
        //        sTarget.Title = "Target";
        //        sSteps.Title = "Distance";
        //        foreach (DataRow row in dt.Rows)
        //        {
        //            sTarget.Add(BaseView.GetDateTimeFieldValue(row, "ReceivedDate"), BaseView.GetFloatFieldValue(row, "TargetPM"));
        //            sSteps.Add(BaseView.GetDateTimeFieldValue(row, "ReceivedDate"), BaseView.GetFloatFieldValue(row, "Distance"));
        //        }
        //        WebChartFitness.Chart.Series.Add(sTarget);
        //        WebChartFitness.Chart.Series.Add(sSteps);
        //        WebChartFitness.Chart.Axes.Left.Title.Text = "Distance";
        //    }
        //    else
        //    {
        //        pnEmptyData.Visible = true;
        //        pnFitness.Visible = false;
        //    }
        //}
        private void LoadDistanceDefault(string ParameterCode)
        {
            DataTable dt = _db.GetList_Fitness_Pedometer_Graph_Default(userName(), ParameterCode);
            if (dt != null && dt.Rows.Count > 0)
            {
                pnEmptyData.Visible = false;
                pnFitness.Visible = true;


            }
            else
            {
                pnEmptyData.Visible = true;
                pnFitness.Visible = false;
            }
        }

        //private void LoadAverageSpeedDefault(string ParameterCode)
        //{
        //    WebChartFitness.Chart.Series.RemoveAllSeries();
        //    DataTable dt = _db.GetList_Fitness_Pedometer_Graph_Default(userName(), ParameterCode);
        //    if (dt != null && dt.Rows.Count > 0)
        //    {
        //        pnEmptyData.Visible = false;
        //        pnFitness.Visible = true;
        //        Steema.TeeChart.Styles.Bar sTarget = new Steema.TeeChart.Styles.Bar();
        //        Steema.TeeChart.Styles.Bar sSteps = new Steema.TeeChart.Styles.Bar();
        //        sTarget.Title = "Target";
        //        sSteps.Title = "Average Speed";
        //        foreach (DataRow row in dt.Rows)
        //        {
        //            sTarget.Add(BaseView.GetDateTimeFieldValue(row, "ReceivedDate"), BaseView.GetFloatFieldValue(row, "TargetPM"));
        //            sSteps.Add(BaseView.GetDateTimeFieldValue(row, "ReceivedDate"), BaseView.GetFloatFieldValue(row, "AverageSpeed"));
        //        }
        //        WebChartFitness.Chart.Series.Add(sTarget);
        //        WebChartFitness.Chart.Series.Add(sSteps);
        //        WebChartFitness.Chart.Axes.Left.Title.Text = "AverageSpeed";
        //    }
        //    else
        //    {
        //        pnEmptyData.Visible = true;
        //        pnFitness.Visible = false;
        //    }
        //}
        private void LoadAverageSpeedDefault(string ParameterCode)
        {
            DataTable dt = _db.GetList_Fitness_Pedometer_Graph_Default(userName(), ParameterCode);
            if (dt != null && dt.Rows.Count > 0)
            {
                pnEmptyData.Visible = false;
                pnFitness.Visible = true;

            }
            else
            {
                pnEmptyData.Visible = true;
                pnFitness.Visible = false;
            }
        }

        //private void LoadCaloriesBurnedDefault(string ParameterCode)
        //{
        //    WebChartFitness.Chart.Series.RemoveAllSeries();
        //    DataTable dt = _db.GetList_Fitness_Pedometer_Graph_Default(userName(), ParameterCode);
        //    if (dt != null && dt.Rows.Count > 0)
        //    {
        //        pnEmptyData.Visible = false;
        //        pnFitness.Visible = true;
        //        Steema.TeeChart.Styles.Bar sTarget = new Steema.TeeChart.Styles.Bar();
        //        Steema.TeeChart.Styles.Bar sSteps = new Steema.TeeChart.Styles.Bar();
        //        sTarget.Title = "Target";
        //        sSteps.Title = "CaloryBurn";
        //        foreach (DataRow row in dt.Rows)
        //        {
        //            sTarget.Add(BaseView.GetDateTimeFieldValue(row, "ReceivedDate"), BaseView.GetFloatFieldValue(row, "TargetPM"));
        //            sSteps.Add(BaseView.GetDateTimeFieldValue(row, "ReceivedDate"), BaseView.GetFloatFieldValue(row, "CaloryBurn"));
        //        }
        //        WebChartFitness.Chart.Series.Add(sTarget);
        //        WebChartFitness.Chart.Series.Add(sSteps);
        //        WebChartFitness.Chart.Axes.Left.Title.Text = "Calory Burn";
        //    }
        //    else
        //    {
        //        pnEmptyData.Visible = true;
        //        pnFitness.Visible = false;
        //    }
        //}
        private void LoadCaloriesBurnedDefault(string ParameterCode)
        {
            DataTable dt = _db.GetList_Fitness_Pedometer_Graph_Default(userName(), ParameterCode);
            if (dt != null && dt.Rows.Count > 0)
            {
                pnEmptyData.Visible = false;
                pnFitness.Visible = true;


            }
            else
            {
                pnEmptyData.Visible = true;
                pnFitness.Visible = false;
            }
        }

        //private void LoadPedometerDurationDefault(string ParameterCode)
        //{
        //    WebChartFitness.Chart.Series.RemoveAllSeries();
        //    DataTable dt = _db.GetList_Fitness_Pedometer_Graph_Default(userName(), ParameterCode);
        //    if (dt != null && dt.Rows.Count < 10)
        //    {
        //        ((Steema.TeeChart.Tools.ScrollTool)WebChartFitness.Chart.Tools[0]).StartPosition = 0;
        //        ((Steema.TeeChart.Tools.ScrollTool)WebChartFitness.Chart.Tools[0]).ViewSegmentSize = dt.Rows.Count / 100;
        //    }
        //    if (dt != null && dt.Rows.Count > 0)
        //    {
        //        pnEmptyData.Visible = false;
        //        pnFitness.Visible = true;
        //        Steema.TeeChart.Styles.Bar sTarget = new Steema.TeeChart.Styles.Bar();
        //        Steema.TeeChart.Styles.Bar sSteps = new Steema.TeeChart.Styles.Bar();
        //        sTarget.UseAxis = false;
        //        sTarget.Title = "Target";
        //        sSteps.Title = "Duration";
        //        foreach (DataRow row in dt.Rows)
        //        {
        //            sTarget.Add(BaseView.GetDateTimeFieldValue(row, "ReceivedDate"), BaseView.GetFloatFieldValue(row, "TargetPM"));
        //            sSteps.Add(BaseView.GetDateTimeFieldValue(row, "ReceivedDate"), BaseView.GetFloatFieldValue(row, "Duration"));
        //        }
        //        WebChartFitness.Chart.Series.Add(sTarget);
        //        WebChartFitness.Chart.Series.Add(sSteps);
        //        WebChartFitness.Chart.Axes.Left.Title.Text = "Duration";
        //    }
        //    else
        //    {
        //        pnEmptyData.Visible = true;
        //        pnFitness.Visible = false;
        //    }
        //}
        private void LoadPedometerDurationDefault(string ParameterCode)
        {
            DataTable dt = _db.GetList_Fitness_Pedometer_Graph_Default(userName(), ParameterCode);
            if (dt != null && dt.Rows.Count > 0)
            {
                pnEmptyData.Visible = false;
                pnFitness.Visible = true;


            }
            else
            {
                pnEmptyData.Visible = true;
                pnFitness.Visible = false;
            }
        }

    #endregion

    #region Table
        /**
         * [Add Data to gridview] Add data to gridview HRExercise.
         * */
        private void Add_grvHRExercise(DataTable table)
        {
            grvHRExercise.DataSource = table;
            grvHRExercise.DataBind();
        }
        /**
        * [Add Data to gridview] Add data to gridview Pedometer.
        * */
        private void Add_grvPedometer(DataTable table)
        {
            grvPedometer.DataSource = table;
            grvPedometer.DataBind();
        }
        /**
        * [Load HRExercise] Load data HRExercise.
        * */
        private void Load_HRExercise(int index)
        {
            grvHRExercise.PageIndex = index;
            DataTable table = _db.GetList_Fitness_HRExercise_Table(userName(), fromDate(), toDate());
            Add_grvHRExercise(table);
            pager(index);
        }
        /**
        * [Load Pedometer] Load data Pedometer.
        * */
        private void Load_TablePedometer(int index)
        {
            grvPedometer.PageIndex = index;
            DataTable table = _db.GetList_Fitness_Pedometer_Table(userName(), fromDate(), toDate());
            Add_grvPedometer(table);
            pager2(index);
        }
        private void Load_HRExercise_Default(int index)
        {
            grvHRExercise.PageIndex = index;
            //DataTable table = _db.GetList_Fitness_HRExercise_Default(userName());
            DataTable table = _db.GetList_Fitness_HRExercise_Table(userName(), null, null);
            Add_grvHRExercise(table);
            pager(index);
        }
        /**
        * [Load Pedometer] Load data Pedometer.
        * */
        private void Load_TablePedometer_Default(int index)
        {
            grvPedometer.PageIndex = index;
            //DataTable table = _db.GetList_Fitness_Pedometer_Default(userName());
            DataTable table = _db.GetList_Fitness_Pedometer_Table(userName(), null, null);
            Add_grvPedometer(table);
            pager2(index);
        }
        /**
        * [Get From Date] get from date.
        * */
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
        /**
        * [Get TO Date] get to date.
        * */
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
        /**
           * [Filter] filter data with datetime selected.
           * */
        protected void btnView_Click(object sender, EventArgs e)
        {
            Session["ToDateFitness"] = toDate();
            if (fromDate().Year > 1753)
            {
                Session["FromDateFitness"] = fromDate();
            }
            else
            {
                MessagesBox.jQueryShow(ClientScript, this.GetType(), DBClass.GetMessageByCode2("SelectTime"), "Notice");
                return;
            }
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
    /**
     * [Select color] select color,Visible for tab selected.
     * */
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
    /**
     * [Active tab] Active graph
     * */
    protected void btnGraph2_Click(object sender, EventArgs e)
    {
        MultiViewHeartRate.ActiveViewIndex = 0;
        Select_graph(false);
        Session["IndexTab_Fitness"] = 0;
    }
    /**
    * [Active tab] Active table
    * */
    protected void btnTable2_Click(object sender, EventArgs e)
    {
        MultiViewHeartRate.ActiveViewIndex = 1;
        Select_graph(true);
        Session["IndexTab_Fitness"] = 1;
    }
    #endregion
        
    #region pager
    protected void back_Click(object sender, ImageClickEventArgs e)
    {
        i = grvHRExercise.PageIndex;
        if (grvHRExercise.PageIndex > 0)
        {
            grvHRExercise.PageIndex = i--;
            if (Session["FromDateFitness"] == null && Session["FromDateFitness"] == null)
                Load_HRExercise_Default(i);
            else
                Load_HRExercise(i);
            Session["PageIndex_Fitness"] = i;
            pager(i);
        }
    }
    protected void next_Click(object sender, ImageClickEventArgs e)
    {
        if (grvHRExercise.PageIndex < grvHRExercise.PageCount - 1)
        {
            i = grvHRExercise.PageIndex;
            grvHRExercise.PageIndex = i++;
            if (Session["FromDateFitness"] == null && Session["FromDateFitness"] == null)
                Load_HRExercise_Default(i);
            else
                Load_HRExercise(i);
            Session["PageIndex_Fitness"] = i;
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
        if (Session["FromDateFitness"] == null && Session["FromDateFitness"] == null)
            Load_HRExercise_Default(index);
        else
            Load_HRExercise(index);
        Session["PageIndex_Fitness"] = index;
        pager(index);
    }
    protected void btn_back1_Click(object sender, ImageClickEventArgs e)
    {
        i = grvPedometer.PageIndex;
        if (grvPedometer.PageIndex > 0)
        {
            grvPedometer.PageIndex = i--;
            if (Session["FromDateFitness"] == null && Session["FromDateFitness"] == null)
                Load_TablePedometer_Default(i);
            else
                Load_TablePedometer(i);
            Session["PageIndex_Fitness2"] = i;
            pager2(i);
        }
    }
    protected void btn_next2_Click(object sender, ImageClickEventArgs e)
    {
        if (grvPedometer.PageIndex < grvPedometer.PageCount - 1)
        {
            i = grvPedometer.PageIndex;
            grvPedometer.PageIndex = i++;
            if (Session["FromDateFitness"] == null && Session["FromDateFitness"] == null)
                Load_TablePedometer_Default(i);
            else
                Load_TablePedometer(i);
            Session["PageIndex_Fitness2"] = i;
            pager2(i);
        }
    }
    protected void txt_page2_TextChanged(object sender, EventArgs e)
    {
        int page = Int32.Parse(txt_page2.Text);
        int index = page - 1;
        if (Session["FromDateFitness"] == null && Session["FromDateFitness"] == null)
            Load_TablePedometer_Default(i);
        else
            Load_TablePedometer(i);
        Session["PageIndex_Fitness2"] = i;
        pager2(index);
    }
    #endregion
    /**
     * [Cancel] click  -> popup datetime graph close.
     * */
    protected void btnCancel_Click(object sender, EventArgs e)
    {
        date_graph.Visible = false;
    }
    /**
     * [Cancel] click  -> popup datetime table close.
     * */
    protected void btncancelTable_Click(object sender, EventArgs e)
    {
        date_table.Visible = false;
    }
    /**
     * [Open] click  -> popup datetime table open.
     * */
    protected void lbPopup_Click(object sender, EventArgs e)
    {
        date_table.Visible = true;
    }
    /**
     * [Open] click  -> popup datetime graph open.
     * */
    protected void lbtnDateTime_Click(object sender, EventArgs e)
    {
        date_graph.Visible = true;
    }
    protected void ddl_number_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddl_number.SelectedValue == "0")
        {
            grvHRExercise.AllowPaging = false;
            if (Session["FromDateFitness"] == null && Session["FromDateFitness"] == null)
            {
                Load_HRExercise_Default(0);
            }
            else
                Load_HRExercise(0);
            pager(0);
        }
        else
        {
            
            Page_number(ToSQL.SQLToInt(ddl_number.SelectedValue));
            if (Session["FromDateFitness"] == null && Session["FromDateFitness"] == null)
            {
                Load_HRExercise_Default(0);
            }
            else
                Load_HRExercise(0);
            pager(0);
        }
    }
    private void Page_number(int i)
    {
        grvHRExercise.AllowPaging = true;
        grvHRExercise.PageSize = i;
        if (!IsPostBack)
        {
            ddl_number.SelectedValue = i.ToString();
        }
        Session["Page_NoFitness1"] = i;
    }
    private void Page_number2(int i)
    {
        grvPedometer.AllowPaging = true;
        grvPedometer.PageSize = i;
        if(!IsPostBack)
            ddlNo2.SelectedValue = i.ToString();
        Session["Page_NoFitness2"] = i;
    }
    protected void ddlNo2_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddlNo2.SelectedValue == "0")
        {
            grvPedometer.AllowPaging = false;
            if (Session["FromDateFitness"] == null && Session["FromDateFitness"] == null)
            {
                Load_TablePedometer_Default(0);
            }
            else
                Load_TablePedometer(0);
            pager2(0);
        }
        else
        {
            Page_number2(ToSQL.SQLToInt(ddlNo2.SelectedValue));
            if (Session["FromDateFitness"] == null && Session["FromDateFitness"] == null)
            {
                Load_TablePedometer_Default(0);
            }
            else
                Load_TablePedometer(0);
            pager2(0);
        }
        Session["ViewSate"] = tabHR.ViewStateMode;
    }
    protected void lnlinks_Click(object sender, EventArgs e)
    {
        Session["IndexTab_Fitness"] = null;
        Session["FromDateFitness"] = null;
        Session["ToDateFitness"] = null;
        Session["Page_NoFitness2"] = null;
        Session["Page_NoFitness1"] = null;
        Session["PageIndex_Fitness"] = null;
        Session["PageIndex_Fitness2"] = null;
        Session["ActiveTab"] = null;
        Response.Redirect("~/usertrackmyhealth_fitness.aspx");
    }
    protected void Setting_Click(object sender, EventArgs e)
    {
        if (Subtab.ActiveTabIndex == 1)
            Session["ActiveTab"] = 1;
        else
            Session["ActiveTab"] = 0;
      Response.Redirect("~/usertrackmyhealth_fitness_settings.aspx");
    }
}