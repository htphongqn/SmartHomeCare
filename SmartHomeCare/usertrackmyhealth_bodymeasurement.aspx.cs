using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Web.UI.DataVisualization.Charting;
using System.Collections;
using System.Drawing;

public partial class usertrackmyhealth_bodymeasurement : System.Web.UI.Page
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
        //first, load datetime. after load page
        if (!IsPostBack)
        {
            //siteuser _siteuser = (siteuser)this.Master;
            //TreeView treeview = _siteuser.treeview;
            //BaseView.SelectedTreeView(treeview, siteuser.REPORTS, siteuser.TRACKMYHEALTH);
            i = 1;
            dataTime = null;
            loadBodyMeasurementTable();
            LoadGridviewTemp();
            LoadDateTime();
            if (Session["FromDateBody"] == null && Session["ToDateBody"] == null)
            {
                LoadMeasurementUserDefault();
                loadBodyMeasurementTableDefault();
            }
            else
            {
                LoadMeasurementUser();
                loadBodyMeasurementTable();
            }
            if(Session["Tab_Body"] !=null)
            {
                if ((int)Session["Tab_Body"] == 1)
                {
                    MultiViewBody.ActiveViewIndex = 1;
                    Select_graph(true);
                }
                else
                {
                    MultiViewBody.ActiveViewIndex = 0;
                    Select_graph(false);
                }
            }
        }
        else
        {
            if (Session["FromDateBody"] == null && Session["ToDateBody"] == null)
            {
                LoadMeasurementUserDefault();
            }
            else
            {
                LoadMeasurementUser();
                loadBodyMeasurementTable();
            }
        }
    }
    #region Tab
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
        MultiViewBody.ActiveViewIndex = 0;
        Select_graph(false);
        Session["Tab_Body"]= 0;
    }
    protected void btnTable2_Click(object sender, EventArgs e)
    {
        MultiViewBody.ActiveViewIndex = 1;
        Select_graph(true);
        Session["Tab_Body"] = 1;
    }
    #endregion

    #region Page
    protected void grvTemp_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        //grvTemp.PageIndex = e.NewPageIndex;
        LoadGridviewTemp();
    }
    
    private void LoadMeasurementUser()
    {
        DataRow row = (DataRow)Session["User"];
        if (row != null)
        {
            DataTable dt = _db.GetList_BodyMeasurement_Graph(userName(), fromDate(), toDate());
            if (dt == null || dt.Rows.Count <= 0)
            {
                pnChart.Visible = false;
                pnEmptyData.Visible = true;
            }
            else
            {
                LoadBFLegend();
                dtlChart.DataSource = dt;
                dtlChart.DataBind();
                pnChart.Visible = true;
                pnEmptyData.Visible = false;
            }
        }
    }

    private void LoadMeasurementUserDefault()
    {
        DataRow row = (DataRow)Session["User"];
        if (row != null)
        {
            //DataTable dt = _db.GetList_BodyMeasurement_Graph_Default(userName());
            DataTable dt = _db.GetList_BodyMeasurement_Graph(userName(), null, null);
            if (dt == null || dt.Rows.Count <= 0)
            {
                pnChart.Visible = false;
                pnEmptyData.Visible = true;
            }
            else
            {
                LoadBFLegend();
                dtlChart.DataSource = dt;
                dtlChart.DataBind();
                pnChart.Visible = true;
                pnEmptyData.Visible = false;
            }
        }
    }

    private void LoadGridviewTemp()
    {
        DataRow row = (DataRow)Session["User"];
        if (row != null)
        {

        }
    }

    public void LoadBFLegend()
    {
        DataRow dr = _db.GetInfo_BodyMeasurement(userName());
        if (dr != null)
        {
            int FatEvalId = BaseView.GetIntFieldValue(dr, "FatEvalId");
            switch (FatEvalId)
            {
                case 1:
                    ltrBF.Text = "<fieldset style='height:120px;'><legend>BF% - WHO</legend><table cellpadding='0' cellspacing='1'><tr><td><div class=Legend style='background-color: LightBlue;'>"+
                                 "</div></td><td>Underfat</td></tr><tr><td><div class='Legend' style='background-color:Green;'></div>" +
                                 "</td><td>Healthy</td></tr><tr><td><div class='Legend' style='background-color: Orange;'>" +
                                 "</div></td><td>Overfat</td></tr><tr><td><div class='Legend' style='background-color: Red;'>" +
                                 "</div></td><td>Obese</td></tr></table></fieldset>";
                    break;
                case 2:
                    ltrBF.Text = "<fieldset style='height:120px;'><legend>BF% - Tanita chart</legend><table cellpadding='0' cellspacing='1'><tr><td><div class=Legend style='background-color: LightBlue;'>" +
                                 "</div></td><td>Underfat</td></tr><tr><td><div class='Legend' style='background-color:Green;'></div>" +
                                 "</td><td>Standard minus</td></tr><tr><td><div class='Legend' style='background-color: Yellow;'>" +
                                 "</div></td><td>Standard plus</td></tr><tr><td><div class='Legend' style='background-color: Orange;'>" +
                                 "</div></td><td>Overfat</td></tr><tr><td><div class=Legend style='background-color: Red;'>" +
                                 "</div></td><td>Obese</td></tr></table></fieldset>";
                    break;
                case 3:
                    ltrBF.Text = "<fieldset style='height:120px;'><legend>BF% - Brainy chart</legend><table cellpadding='0' cellspacing='1'><tr><td><div class=Legend style='background-color: LightBlue;'>" +
                                 "</div></td><td>Lean (Low)</td></tr><tr><td><div class='Legend' style='background-color:Green;'></div>" +
                                 "</td><td>Slim (Healthy)</td></tr><tr><td><div class='Legend' style='background-color: Yellow;'>" +
                                 "</div></td><td>Fit (Fair)</td></tr><tr><td><div class='Legend' style='background-color: Orange;'>" +
                                 "</div></td><td>Average (High)</td></tr><tr><td><div class=Legend style='background-color: Red;'>" +
                                 "</div></td><td>Obese (Very High)</td></tr></table></fieldset>";
                    break;
                default:
                    break;
            }
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

    protected void Button1_Click(object sender, EventArgs e)
    {
    }
    protected void btnOk_Click(object sender, EventArgs e)
    {
        Session["ToDateBody"] = toDate();
        if (fromDate().Year > 1753)
        {
            Session["FromDateBody"] = fromDate();
        }
        else
        {
            MessagesBox.jQueryShow(ClientScript, this.GetType(), DBClass.GetMessageByCode2("SelectTime"), "Notice");
            pnEmptyData.Visible = true;
            return;
        }        
        LoadMeasurementUser();
        LoadGridviewTemp();
        loadBodyMeasurementTable();
        datetime_graph.Visible = false;
    }

    private void LoadDateTime()
    {        
        if (Session["FromDateBody"] != null)
        {
            DateTime startdate = (DateTime)Session["FromDateBody"];
            if (startdate.Year > 1753)
            {
                txtFromDate.Text = startdate.ToShortDateString();
                txtFromDateTable.Text = startdate.ToShortDateString();
            }
        }

        if (Session["ToDateBody"] != null)
        {
            DateTime startdate = (DateTime)Session["ToDateBody"];
            if (startdate.Year > 1753)
            {
                txtToDate.Text = startdate.ToShortDateString();
                txtToDateTable.Text = startdate.ToShortDateString();
            }
        }
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

    #endregion

    #region Table
    /**
     *[Filter] Filter Bodymeasurement data.
     * */
    protected void btnView_Click(object sender, EventArgs e)
    {
        try
        {
            loadBodyMeasurementTable();
        }
        catch (Exception)
        {
            string msg = DBClass.GetMessageByCode2("date_invalid");
            MessagesBox.jQueryShow(ClientScript, this.GetType(), msg, "Messages Box");
            
        }
    }
    /**
     * [From Date] get from date.
     * */
    private DateTime? getFromDate(){
        DateTime? time = null;
        time = cl_txtFromT.SelectedDate;
        return time;
    }
    /**
     * [To Date] get to date.
     * */
    private DateTime? getToDate()
    {
        DateTime? time = null;
        time = cl_txtToT.SelectedDate;
        return time;
    }
    /**
     * [Data Datetime] get datetime bodymeasurement from database
     * */
    private DataTable Get_date(string username)
    {
        dt = _db.GetList_Datetime_BodyMeasurement(username,fromDate(),toDate());
        return dt;
    }
    /**
     * [User name] get username from session.
     * */
    private string getUserName()
    {   
        DataRow row = (DataRow)Session["User"];
        if (row != null)
        {
            return BaseView.GetStringFieldValue(row, "username");
        }
        else
            return "";
    }
    /**
     * [BodyMeasurement] load data BodyMeasurement from database.
     * */
    private void loadBodyMeasurementTable()
    {
        DataSet ds = new DataSet();
        DataTable dt = Get_date(getUserName());
        if (dt.Rows.Count > 0)
        {
            ds = _db.GetList_BodyMeasurement_Datatable(getUserName(), fromDate(), toDate());
            int width = 0;
            string table = "";
            if (ds.Tables.Count > 0)
            {
                for (int i = 0; i < ds.Tables.Count; i++)
                {
                    DataTable dts = ds.Tables[i];
                    if (dts.Rows.Count > 0)
                    {
                        string date = dts.Rows[0][2].ToString();
                        DateTime time = ToSQL.SQLToDateTime(date);
                        string times = time.Month.ToString() + "/" + time.Day.ToString() + "/" + time.Year.ToString() + " " + time.Hour.ToString() + ":" + time.Minute.ToString() + ":" + time.Second.ToString();
                        table += "<table style='float:left;width:320px'>";
                        table += "<tr>";
                        table += "<th>Value</th>";
                        table += "<th>Diagnose</th>";
                        table += "</tr>";
                        table += "<tr>";
                        table += "<td class='value_body'>" + times + "</td>";
                        table += "<td>...</td>";
                        table += "</tr>";
                        for (int j = 0; j < dts.Rows.Count; j++)
                        {
                            string value = dts.Rows[j]["Value"].ToString();
                            string diagnose = dts.Rows[j]["Diagnose"].ToString();
                            table += "<tr>";
                            table += "<td class='value_body'>" + value + "</td>";
                            table += "<td>" + diagnose + "</td>";
                            table += "</tr>";
                        }
                        table += "</table>";
                        width += 320;
                    }
                }
            }
            string tables = "<div class='data_main' style='width:" + width.ToString() + "px'>" + table + " </div>";
            ld_data.Text = tables;
        }
        else
        {
            ld_data.Text = "";
            
        }
            
    }
    private void loadBodyMeasurementTableDefault()
    {
            //DataTable dt = _db.GetList_BodyMeasurement_Datatable_Default(getUserName());
            DataTable dt = _db.GetList_BodyMeasurement_Datatable(getUserName(), null, null).Tables[0];
            int width = 0;
            string table = "";
            if (dt.Rows.Count > 0)
            {
                string date = dt.Rows[0][2].ToString();
                DateTime time = ToSQL.SQLToDateTime(date);
                string times = time.Month.ToString() + "/" + time.Day.ToString() + "/" + time.Year.ToString() + " " + time.Hour.ToString() + ":" + time.Minute.ToString() + ":" + time.Second.ToString();
                table += "<table style='float:left;width:320px'>";
                table += "<tr>";
                table += "<th>Value</th>";
                table += "<th>Diagnose</th>";
                table += "</tr>";
                table += "<tr>";
                table += "<td class='value_body'>" + times + "</td>";
                table += "<td>...</td>";
                table += "</tr>";
                for (int j = 0; j < dt.Rows.Count; j++)
                {
                    string value = dt.Rows[j]["Value"].ToString();
                    string diagnose = dt.Rows[j]["Diagnose"].ToString();
                    table += "<tr>";
                    table += "<td class='value_body'>" + value + "</td>";
                    table += "<td>" + diagnose + "</td>";
                    table += "</tr>";
                }
                table += "</table>";
                width += 320;
            }
            string tables = "<div class='data_main' style='width:" + width.ToString() + "px'>" + table + " </div>";
            ld_data.Text = tables;
    }
    /**
     * [Filter for table report]Filter data with datetime selected.
     * */
    protected void btn_Ok_Table_Click(object sender, EventArgs e)
    {
        Session["ToDateBody"] = toDate();
        if (fromDate().Year > 1753)
        {
            Session["FromDateBody"] = fromDate();
        }
        else
        {
            MessagesBox.jQueryShow(ClientScript, this.GetType(), DBClass.GetMessageByCode2("SelectTime"), "Notice");
            pnEmptyData.Visible = true;
            return;
        }  
        loadBodyMeasurementTable();
        div_popup.Visible = false;
    }
    #endregion
    /**
     * [Cancel] click  -> popup datetime table close.
     * */
    protected void btncancel2_Click(object sender, EventArgs e)
    {
        div_popup.Visible = false;
    }
    /**
     * [Datetime Table] click  -> popup datetime table open.
     * */
    protected void lbDateTable_Click(object sender, EventArgs e)
    {
        div_popup.Visible = true;
    }
    /**
     * [Cancel] click  -> popup datetime graph close.
     * */
    protected void btnCancel_Click(object sender, EventArgs e)
    {
        datetime_graph.Visible = false;
    }
    /**
     * [Datetime] click  -> popup datetime graph open.
     * */
    protected void lbtnDateTime_Click(object sender, EventArgs e)
    {
        datetime_graph.Visible = true;
    }
    protected void lblinks_Click(object sender, EventArgs e)
    {
        Session["FromDateBody"] = null;
        Session["ToDateBody"] = null;
        Session["Tab_Body"] = null;
        Response.Redirect("~/usertrackmyhealth_bodymeasurement.aspx");
    }
}