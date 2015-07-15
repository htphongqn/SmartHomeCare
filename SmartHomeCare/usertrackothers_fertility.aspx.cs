using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Drawing;
using System.Data;
using System.Web.UI.DataVisualization.Charting;
public partial class usertrackothers_fertility : System.Web.UI.Page
{
    private DBClass _db = new DBClass();
    private static int CurrentMonth = 1, CurrentYear = 1753, CurrentFromDate = 1, CurrentToDate = 6;
    static int index = 0;
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
        else
        {
            LoadCurrentTime();
        }

        if (!IsPostBack)
        {
            //siteuser _siteuser = (siteuser)this.Master;
            //TreeView treeview = _siteuser.treeview;
            //BaseView.SelectedTreeView(treeview, siteuser.REPORTS, siteuser.TRACKOTHERS);
            Select_graph(false);
            GetCurrentMonthYear();
            Load_Fertility(0);
            index = 0;
            fullName();
        }
    }

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
        MultiViewFertility.ActiveViewIndex = 0;
        Select_graph(false);
    }
    protected void btnTable2_Click(object sender, EventArgs e)
    {
        MultiViewFertility.ActiveViewIndex = 1;
        Select_graph(true);
    }
    #endregion

    #region Graph

    private void LoadCurrentTime()
    {
        if (Session["CurrentMonth"] != null)
        {
            Int32.TryParse(Session["CurrentMonth"].ToString(), out CurrentMonth);
        }

        if (Session["CurrentYear"] != null)
        {
            Int32.TryParse(Session["CurrentYear"].ToString(), out CurrentYear);
        }

        if (Session["CurrentFromDate"] != null)
        {
            Int32.TryParse(Session["CurrentFromDate"].ToString(), out CurrentFromDate);
        }

        if (Session["CurrentToDate"] != null)
        {
            Int32.TryParse(Session["CurrentToDate"].ToString(), out CurrentToDate);
        }
    }

    private void GetCurrentMonthYear()
    {
        if (Session["CurrentMonth"] == null)
        {
            CurrentMonth = DateTime.Now.Month;
        }
        if (Session["CurrentYear"] == null)
        {
            CurrentYear = DateTime.Now.Year;
        }
        lblMonthYear.Text = (new System.Globalization.DateTimeFormatInfo()).GetMonthName(CurrentMonth) + "," + CurrentYear;
        LoadDaysInMonth(DateTime.DaysInMonth(CurrentYear, CurrentMonth));
        Session["CurrentMonth"] = CurrentMonth;
        Session["CurrentYear"] = CurrentYear;
    }

    private void GetNextMonthYear()
    {
        CurrentMonth++;
        if (CurrentMonth > 12)
        {
            CurrentMonth = 1;
            CurrentYear++;
        }
        lblMonthYear.Text = (new System.Globalization.DateTimeFormatInfo()).GetMonthName(CurrentMonth) + " , " + CurrentYear;
        LoadDaysInMonth(DateTime.DaysInMonth(CurrentYear, CurrentMonth));
        Session["CurrentMonth"] = CurrentMonth;
        Session["CurrentYear"] = CurrentYear;
    }

    private void GetPrevMonthYear()
    {
        CurrentMonth--;
        if (CurrentMonth <= 0)
        {
            CurrentMonth = 12;
            CurrentYear--;
        }
        lblMonthYear.Text = (new System.Globalization.DateTimeFormatInfo()).GetMonthName(CurrentMonth) + " , " + CurrentYear;
        LoadDaysInMonth(DateTime.DaysInMonth(CurrentYear, CurrentMonth));
        Session["CurrentMonth"] = CurrentMonth;
        Session["CurrentYear"] = CurrentYear;
    }

    private void LoadDaysInMonth(int DaysInMonth)
    {
        DataTable dt = new DataTable();
        dt.Columns.Add("Index");
        dt.Columns.Add("Value");
        CurrentFromDate = 1;
        CurrentToDate = CurrentFromDate + 5;
        for (int i = CurrentFromDate; i <= CurrentToDate; i++)
        {
            dt.Rows.Add(i, i);
        }
        LoadFertilityTemperature();
        dtlDaysInMonth.DataSource = dt;
        dtlDaysInMonth.DataBind();
        Session["CurrentFromDate"] = CurrentFromDate;
        Session["CurrentToDate"] = CurrentToDate;
    }

    private void GetPrevWeek(int DaysInMonth)
    {
        DataTable dt = new DataTable();
        dt.Columns.Add("Index");
        dt.Columns.Add("Value");
        if (CurrentFromDate - 6 > 0)
        {
            CurrentFromDate -= 6;
            if (CurrentFromDate + 5 >= DaysInMonth)
            {
                CurrentToDate = DaysInMonth;
                //lbtnPrevWeek.Visible = false;
            }
            else
            {
                CurrentToDate = CurrentFromDate + 5;
            }
        }
        else
        {
            CurrentFromDate = 1;
            CurrentToDate = CurrentFromDate + 5;
        }

        for (int i = CurrentFromDate; i <= CurrentToDate; i++)
        {
            dt.Rows.Add(i, i);
        }
        LoadFertilityTemperature();
        dtlDaysInMonth.DataSource = dt;
        dtlDaysInMonth.DataBind();
        Session["CurrentFromDate"] = CurrentFromDate;
        Session["CurrentToDate"] = CurrentToDate;
    }

    private void GetNextWeek(int DaysInMonth)
    {
        DataTable dt = new DataTable();
        dt.Columns.Add("Index");
        dt.Columns.Add("Value");

        if (CurrentFromDate + 6 <= DaysInMonth)
        {
            CurrentFromDate = CurrentFromDate + 6;
            if (CurrentFromDate + 5 <= DaysInMonth)
            {
                CurrentToDate = CurrentFromDate + 5;
            }
            else
            {
                CurrentToDate = DaysInMonth;
            }
        }

        for (int i = CurrentFromDate; i <= CurrentToDate; i++)
        {
            dt.Rows.Add(i, i);
        }
        LoadFertilityTemperature();
        dtlDaysInMonth.DataSource = dt;
        dtlDaysInMonth.DataBind();
        Session["CurrentFromDate"] = CurrentFromDate;
        Session["CurrentToDate"] = CurrentToDate;
    }

    private void LoadFertilityTemperature()
    {
        LoadCyclePeriod();
        DataTable dt = _db.GetList_Fertility_Temperature(userName(), FromDate(), ToDate());
        if (dt != null && dt.Rows.Count > 0)
        {
            ChartFertility.DataSource = dt;
            ChartFertility.DataBind();
        }
    }

    private void LoadCyclePeriod()
    {
        DateTime first = new DateTime(CurrentYear, CurrentMonth, 1);
        DateTime last = new DateTime(CurrentYear, CurrentMonth, DateTime.DaysInMonth(CurrentYear, CurrentMonth));
        DataTable dt = _db.GetList_Fertility_Graph(userName(), first, last);
        if (dt != null && dt.Rows.Count > 0)
        {
            DataRow row = dt.Rows[0];
            DateTime StartOfPeriod = BaseView.GetDateTimeFieldValue(row, "StartOfPeriod");
            DateTime MidCycleDate = BaseView.GetDateTimeFieldValue(row, "MidCycleDate");
            DateTime OvulationDate = BaseView.GetDateTimeFieldValue(row, "OvulationDate");

            DateTime MostFertileTimeStart = BaseView.GetDateTimeFieldValue(row, "MostFertileTimeStart");
            DateTime MostFertileTimeEnd = BaseView.GetDateTimeFieldValue(row, "MostFertileTimeEnd");
            DateTime MostPregnantTimeStart = BaseView.GetDateTimeFieldValue(row, "MostPregnantTimeStart");
            DateTime MostPregnantTimeEnd = BaseView.GetDateTimeFieldValue(row, "MostPregnantTimeEnd");

            DateTime NextStartOfPeriod = BaseView.GetDateTimeFieldValue(row, "NextStartOfPeriod");
            DateTime NextOvulationDate = BaseView.GetDateTimeFieldValue(row, "NextOvulationDate");
            DateTime NextMostFertileTimeStart = BaseView.GetDateTimeFieldValue(row, "NextMostFertileTimeStart");
            DateTime NextMostFertileTimeEnd = BaseView.GetDateTimeFieldValue(row, "NextMostFertileTimeEnd");
            DateTime NextMostPregnantTimeStart = BaseView.GetDateTimeFieldValue(row, "NextMostPregnantTimeStart");
            DateTime NextMostPregnantTimeEnd = BaseView.GetDateTimeFieldValue(row, "NextMostPregnantTimeEnd");

            DateTime MostFertileTime = BaseView.GetDateTimeFieldValue(row, "MostFertileTime");
            DateTime MostPregnantTime = BaseView.GetDateTimeFieldValue(row, "MostPregnantTime");
            DateTime NextMostFertileTime = BaseView.GetDateTimeFieldValue(row, "NextMostFertileTime");
            DateTime NextMostPregnantTime = BaseView.GetDateTimeFieldValue(row, "NextMostPregnantTime");

            AddSeriesOvulation(OvulationDate, NextOvulationDate);
            AddSeriesMostFertileTime(MostFertileTimeStart, MostFertileTimeEnd);
            AddSeriesMostPregnantTime(MostPregnantTimeStart, MostPregnantTimeEnd);
            AddSeriesPeriod(StartOfPeriod, NextStartOfPeriod);
        }
    }

    private void AddSeriesOvulation(DateTime? OldDate, DateTime? NextDate)
    {
        if (OldDate >= FromDate() && OldDate <= ToDate())
        {
            Series sOldDate = new Series("OldOvulationDate");
            sOldDate.ChartType = SeriesChartType.Point;
            sOldDate.Points.AddXY(OldDate, 50);
            sOldDate.MarkerStyle = MarkerStyle.Circle;
            sOldDate.Color = (OldDate <= DateTime.Now ? Color.Black : Color.Green);
            sOldDate.MarkerSize = 20;
            ChartFertility.Series.Add(sOldDate);
        }

        if (NextDate >= FromDate() && NextDate <= ToDate())
        {
            Series sNextDate = new Series("NextOvulationDate");
            sNextDate.ChartType = SeriesChartType.Point;
            sNextDate.Points.AddXY(NextDate, 50);
            sNextDate.MarkerStyle = MarkerStyle.Circle;
            sNextDate.Color = Color.Green;
            sNextDate.MarkerSize = 20;
            ChartFertility.Series.Add(sNextDate);
        }
    }

    private void AddSeriesMostFertileTime(DateTime StartDate, DateTime EndDate)
    {
        if (StartDate > EndDate)
        {
            return;
        }
        else
        {
            Series sMostFertileTime = new Series("MostFertileTime");
            sMostFertileTime.ChartType = SeriesChartType.Line;
            sMostFertileTime.Color = Color.LightGreen;
            sMostFertileTime.BorderWidth = 5;
            for (DateTime date = StartDate; EndDate.CompareTo(date) >= 0; date = date.AddDays(1))
            {
                if (date.CompareTo(FromDate()) >= 0 && date.CompareTo(ToDate()) <= 0 && date.CompareTo(EndDate) <= 0)
                {
                    sMostFertileTime.Points.AddXY(date, 50);
                }
            }
            ChartFertility.Series.Add(sMostFertileTime);
        }
    }

    private void AddSeriesMostPregnantTime(DateTime StartDate, DateTime EndDate)
    {
        if (StartDate > EndDate)
        {
            return;
        }
        else
        {
            Series sMostPregnantTime = new Series("MostPregnantTime");
            sMostPregnantTime.ChartType = SeriesChartType.Line;
            sMostPregnantTime.Color = Color.Green;
            sMostPregnantTime.BorderWidth = 5;
            for (DateTime date = StartDate; EndDate.CompareTo(date) >= 0; date = date.AddDays(1.0))
            {
                if (date.CompareTo(FromDate()) >= 0 && date.CompareTo(ToDate()) <= 0 && date.CompareTo(EndDate) <= 0)
                {
                    sMostPregnantTime.Points.AddXY(date, 50);
                }
            }
            ChartFertility.Series.Add(sMostPregnantTime);
        }
    }

    private void AddSeriesPeriod(DateTime OldDate, DateTime NextDate)
    {
        if (OldDate >= FromDate() && OldDate <= ToDate())
        {
            Series sOldPeriod = new Series("OldPeriod");
            sOldPeriod.ChartType = SeriesChartType.Point;
            sOldPeriod.Points.AddXY(OldDate, 20);
            sOldPeriod.MarkerStyle = MarkerStyle.Triangle;
            sOldPeriod.Color = Color.Black;
            sOldPeriod.MarkerSize = 20;
            ChartFertility.Series.Add(sOldPeriod);
        }

        if (NextDate >= FromDate() && NextDate <= ToDate())
        {
            Series sNextPeriod = new Series("NextPeriod");
            sNextPeriod.ChartType = SeriesChartType.Point;
            sNextPeriod.Points.AddXY(NextDate, 20);
            sNextPeriod.MarkerStyle = MarkerStyle.Triangle;
            sNextPeriod.Color = Color.Red;
            sNextPeriod.MarkerSize = 20;
            ChartFertility.Series.Add(sNextPeriod);
        }
    }

    private DateTime FromDate()
    {
        DateTime fromdate;
        DateTime.TryParse(CurrentMonth + "/" + CurrentFromDate + "/" + CurrentYear, out fromdate);
        if (fromdate == DateTime.MinValue)
        {
            fromdate = DateTime.Now.Date;
        }
        return fromdate;
    }

    private DateTime ToDate()
    {
        DateTime todate;
        DateTime.TryParse(CurrentMonth + "/" + CurrentToDate + "/" + CurrentYear, out todate);
        if (todate == DateTime.MinValue)
        {
            todate = DateTime.Now.Date;
        }
        return todate;
    }
    #endregion

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
        DataRow row = (DataRow)Session["AuthorizedUser"];
        if (row == null)
            return null;
        else
            return BaseView.GetStringFieldValue(row, "Username");
    }
    private string getUserName()
    {
        DataRow row = (DataRow)Session["AuthorizedUser"];
        if (row == null)
            return null;
        else
            return BaseView.GetStringFieldValue(row, "Username");
    }
    protected void btn_Ok_Table_Click(object sender, EventArgs e)
    {
        //Load_Fertility();
        date_table.Visible = false;
    }

    #endregion
    #region Table

    private void Load_Fertility(int j)
    {
        DataTable dt = _db.GetList_Fertility_Table(getUserName(), null, null);
        int i;
        int width = 0;
        string dates = "<table style='width:100%'><tr>";
        string start_of_period = "", ovulation_date = "", most_fertile_time = "", most_pregnant_time = "", start_of_next = "", next_ovulation = "", next_most_fertile = "", next_most_pregnant = "", nulltd = "";
        string Cycle_stracked_N = "", average_cycle_length = "", cycle_length_variation = "", average_ovulation_time = "", longest_cycle = "", shortest_cycle = "";
        if (dt.Rows.Count > 0)
        {
            for (i = j; i <= j + 2; i++)
            {
                if (i > dt.Rows.Count - 1)
                {
                    return;
                }
                else
                {
                    DateTime a = ToSQL.SQLToDateTime(BaseView.GetStringFieldValue(dt.Rows[i], "StartOfPeriod"));
                    DateTime b;
                    start_of_period += "<td>" + a.Month + "/" + a.Day + "/" + a.Year + "</td>";

                    a = ToSQL.SQLToDateTime(BaseView.GetStringFieldValue(dt.Rows[i], "OvulationDate"));
                    ovulation_date += "<td>" + a.Month + "/" + a.Day + "/" + a.Year + "</td>";

                    a = ToSQL.SQLToDateTime(BaseView.GetStringFieldValue(dt.Rows[i], "MostFertileTimeStart"));
                    b = ToSQL.SQLToDateTime(BaseView.GetStringFieldValue(dt.Rows[i], "MostFertileTimeEnd"));
                    most_fertile_time += "<td>" + a.Month + "/" + a.Day + "/" + a.Year + " - " + b.Month + "/" + b.Day + "/" + b.Year + "</td>";

                    a = ToSQL.SQLToDateTime(BaseView.GetStringFieldValue(dt.Rows[i], "MostPregnantTimeStart"));
                    b = ToSQL.SQLToDateTime(BaseView.GetStringFieldValue(dt.Rows[i], "MostPregnantTimeEnd"));
                    most_pregnant_time += "<td>" + a.Month + "/" + a.Day + "/" + a.Year + " - " + b.Month + "/" + b.Day + "/" + b.Year + "</td>";

                    a = ToSQL.SQLToDateTime(BaseView.GetStringFieldValue(dt.Rows[i], "NextStartOfPeriod"));
                    start_of_next += "<td>" + a.Month + "/" + a.Day + "/" + a.Year + "</td>";

                    a = ToSQL.SQLToDateTime(BaseView.GetStringFieldValue(dt.Rows[i], "NextOvulationDate"));
                    next_ovulation += "<td>" + a.Month + "/" + a.Day + "/" + a.Year + "</td>";

                    a = ToSQL.SQLToDateTime(BaseView.GetStringFieldValue(dt.Rows[i], "NextMostFertileTimeStart"));
                    b = ToSQL.SQLToDateTime(BaseView.GetStringFieldValue(dt.Rows[i], "NextMostFertileTimeEnd"));
                    next_most_fertile += "<td>" + a.Month + "/" + a.Day + "/" + a.Year + " - " + b.Month + "/" + b.Day + "/" + b.Year + "</td>";

                    a = ToSQL.SQLToDateTime(BaseView.GetStringFieldValue(dt.Rows[i], "NextMostPregnantTimeStart"));
                    b = ToSQL.SQLToDateTime(BaseView.GetStringFieldValue(dt.Rows[i], "NextMostPregnantTimeEnd"));
                    next_most_pregnant += "<td>" + a.Month + "/" + a.Day + "/" + a.Year + " - " + b.Month + "/" + b.Day + "/" + b.Year + "</td>";

                    DateTime time = ToSQL.SQLToDateTime(BaseView.GetStringFieldValue(dt.Rows[i], "StartOfPeriod"));
                    dates += "<td style='width:200px'>" + (new System.Globalization.DateTimeFormatInfo()).GetMonthName(time.Month) + "," + time.Year + "</td>";

                    width += 180;

                    Cycle_stracked_N += "<td>" + BaseView.GetStringFieldValue(dt.Rows[i], "CycleLenght_Days") + "</td>";

                    average_cycle_length += "<td>" + BaseView.GetStringFieldValue(dt.Rows[i], "AvgCycleLenght_Days") + "</td>";

                    cycle_length_variation += "<td>" + BaseView.GetStringFieldValue(dt.Rows[i], "CycleLengthVariation_Days") + "</td>";

                    average_ovulation_time += "<td>" + BaseView.GetStringFieldValue(dt.Rows[i], "AverageOvulationTime_Days") + "</td>";

                    longest_cycle += "<td>" + BaseView.GetStringFieldValue(dt.Rows[i], "LongestCycle") + "</td>";

                    shortest_cycle += "<td>" + BaseView.GetStringFieldValue(dt.Rows[i], "ShortestCycle") + "</td>";
                }
            }
            string html = "<div style='width:" + width + "px'><table style='width:100%'>";
            html += "<tr><td colspan='" + i + "'></td></tr>";
            html += "<tr>" + start_of_period + "</tr>";
            html += "<tr>" + ovulation_date + "</tr>";
            html += "<tr>" + most_fertile_time + "</tr>";
            html += "<tr>" + most_pregnant_time + "</tr>";
            html += "</table></div>";
            lb_html.Text = html;

            string html3 = "<div style='width:" + width + "px'><table style='width:100%'><tr><td colspan='" + i + "'></td></tr>";
            html3 += "<tr>" + start_of_next + "</tr>";
            html3 += "<tr>" + next_ovulation + "</tr>";
            html3 += "<tr>" + next_most_fertile + "</tr>";
            html3 += "<tr>" + next_most_pregnant + "</tr>";
            html3 += "</table></div>";
            lbhtml3.Text = html3;

            string html2 = "<div style='width:" + width + "px'><table style='width:100%'>";
            html2 += "<tr><td colspan='" + i + "'></td></tr>";
            html2 += "<tr>" + Cycle_stracked_N + "</tr>";
            html2 += "<tr>" + average_cycle_length + "</tr>";
            html2 += "<tr>" + cycle_length_variation + "</tr>";
            html2 += "<tr>" + average_ovulation_time + "</tr>";
            html2 += "<tr>" + longest_cycle + "</tr>";
            html2 += "<tr>" + shortest_cycle + "</tr>";
            html2 += "</table></div>";
            lb_html2.Text = html2;
            lbdate.Text = dates + "</tr></table>";
        }
    }
    private bool Is_Process(int j)
    {
        bool result = true;
        DataTable dt = _db.GetList_Fertility_Table(getUserName(), null, null);
        int i;
        if (dt.Rows.Count > 0)
        {
            for (i = j; i <= j + 2; i++)
            {
                if (i > dt.Rows.Count - 1 || j < 0 || j > dt.Rows.Count - 3)
                {
                    result = false;
                }
                else
                {
                    result = true;
                }
            }
        }
        return result;
    }
    private string GetMonth(string month)
    {
        string result = "";
        switch (month)
        {
            case "1":
                result = "Jan";
                break;
            case "2":
                result = "Feb";
                break;
            case "3":
                result = "March";
                break;
            case "4":
                result = "April";
                break;
            case "5":
                result = "May";
                break;
            case "6":
                result = "June";
                break;
            case "7":
                result = "July";
                break;
            case "8":
                result = "Aug";
                break;
            case "9":
                result = "Sept";
                break;
            case "10":
                result = "Oct";
                break;
            case "11":
                result = "Nov";
                break;
            case "12":
                result = "Dec";
                break;

        }
        return result;
    }
    protected void lbtnNextMonth_Click(object sender, EventArgs e)
    {
        GetNextMonthYear();
    }
    protected void lbtnPrevMonth_Click(object sender, EventArgs e)
    {
        GetPrevMonthYear();
    }
    protected void lbtnNextWeek_Click(object sender, EventArgs e)
    {
        GetNextWeek(DateTime.DaysInMonth(CurrentYear, CurrentMonth));
    }
    protected void lbtnPrevWeek_Click(object sender, EventArgs e)
    {
        GetPrevWeek(DateTime.DaysInMonth(CurrentYear, CurrentMonth));
    }

    private DateTime LastDayOfMonth(DateTime theDay)
    {
        return DateTime.Parse(String.Format("{0:MM/dd/yyyy hh:mm:ss}", theDay)).AddMonths(1).AddDays(-1);
    }
    protected void Datime_Click(object sender, EventArgs e)
    {
        date_table.Visible = true;
    }
    protected void btncancel2_Click(object sender, EventArgs e)
    {
        date_table.Visible = false;
    }
    private void load_DateTime()
    {
        for (int i = 1; i < 13; i++)
        {
            ddl_FromMonth.Items.Add(i.ToString());
            ddl_ToMonth.Items.Add(i.ToString());
        }
        for (int i = 2010; i < 2100; i++)
        {
            ddl_FromYear.Items.Add(i.ToString());
            ddl_ToYear.Items.Add(i.ToString());
        }
    }
    private DateTime getFromDate()
    {
        DateTime time;
        string toT = ddl_FromMonth.SelectedItem.Text + "/" + "01/" + ddl_FromYear.SelectedItem.Text;

        DateTime.TryParse(toT, out time);

        if (time == DateTime.MinValue)
            time = DateTime.Now.Date;
        return time;
    }
    private DateTime getToDate()
    {
        DateTime time;
        string toT = ddl_ToMonth.SelectedItem.Text + "/" + "01/" + ddl_ToYear.SelectedItem.Text;

        DateTime.TryParse(toT, out time);
        time = LastDayOfMonth(time);
        if (time == DateTime.MinValue)
            time = DateTime.Now.Date;
        return time;
    }
    #endregion
    protected void lbBack_Click(object sender, EventArgs e)
    {
        if (index > 0)
        {
            index--;
            Load_Fertility(index);
        }
    }
    protected void lbNext_Click(object sender, EventArgs e)
    {
        if (Is_Process(index) == true)
        {
            index++;
            Load_Fertility(index);
        }

    }
}