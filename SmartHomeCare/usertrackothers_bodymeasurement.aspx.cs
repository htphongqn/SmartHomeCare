using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Web.UI.DataVisualization.Charting;
using System.Drawing;
/**
* User track others body measument
* */
public partial class usertrackothers_bodymeasurement : System.Web.UI.Page
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
            treeview.Nodes[siteuser.REPORTS].ChildNodes[siteuser.TRACKOTHERS].ChildNodes.AddAt(0, new TreeNode("Body Measurement", "0"));
            treeview.Nodes[siteuser.REPORTS].ChildNodes[siteuser.TRACKOTHERS].Expand();
            treeview.Nodes[siteuser.REPORTS].ChildNodes[siteuser.TRACKOTHERS].ChildNodes[0].Selected = true;
            //loaddata();
            fullName();
            i = 1;
            dataTime = null;
            loadBodyMeasurementTable();
            LoadGridviewTemp();
            Select_graph(false);
            LoadDateTime();
            
            if (Session["FromDateBody"] == null && Session["ToDateBody"] == null)
            {
                //MPE.Show();
                LoadMeasurementUserDefault();
                datetime_graph.Visible = true;
                div_popup.Visible = false;
            }
            else
            {
                datetime_graph.Visible = false;
                LoadMeasurementUser();
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
            }
        }         
    }
    /**
        * [LoadName] load fullname
        * */
   
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
        MultiViewBody.ActiveViewIndex = 0;
        Select_graph(false);
    }
    protected void btnTable2_Click(object sender, EventArgs e)
    {
        MultiViewBody.ActiveViewIndex = 1;
        Select_graph(true);
    }
    #endregion

    #region Page
    protected void grvTemp_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        //grvTemp.PageIndex = e.NewPageIndex;
        LoadGridviewTemp();
    }
    private void fullName()
    {

        if (Session["AuthorizedUser"] != null)
        {
            DataRow rowcurrentuser = (DataRow)Session["AuthorizedUser"];
            lbNameHealth.Text = BaseView.GetStringFieldValue(rowcurrentuser, "Fullname");

        }
    }
    private string getUserName()
    {
        DataRow rowcurrentuser = (DataRow)Session["AuthorizedUser"];
        if (rowcurrentuser != null)
        {
            return BaseView.GetStringFieldValue(rowcurrentuser, "Username");
        }
        else
            return "";
    }
    private void LoadMeasurementUser()
    {
        DataRow row = (DataRow)Session["User"];
        if (row != null)
        {
            DataTable dt = _db.GetList_BodyMeasurement_Graph(getUserName(), fromDate(), toDate());
            if (dt == null || dt.Rows.Count <= 0)
            {
                pnChart.Visible = false;
                pnEmptyData.Visible = true;
            }
            else
            {
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
            DataTable dt = _db.GetList_BodyMeasurement_Graph_Default(getUserName());
            if (dt == null || dt.Rows.Count <= 0)
            {
                pnChart.Visible = false;
                pnEmptyData.Visible = true;
            }
            else
            {
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
    private DateTime? getFromDate(){
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
    private DateTime? getToDate()
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
    private DataTable Get_date(string username)
    {
        dt = _db.GetList_Datetime_BodyMeasurement(username,getFromDate(),getToDate());
        return dt;
    }
    
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
            //MessagesBox.jQueryShow(ClientScript, this.GetType(), "There is no record to show !", "Message box");
        }
            
    }
    protected void btn_Ok_Table_Click(object sender, EventArgs e)
    {
        loadBodyMeasurementTable();
        div_popup.Visible = false;
    }
    #endregion

    protected void btncancel2_Click(object sender, EventArgs e)
    {
        div_popup.Visible = false;
    }
    protected void lbDateTable_Click(object sender, EventArgs e)
    {
        div_popup.Visible = true;
    }
    protected void btnCancel_Click(object sender, EventArgs e)
    {
        datetime_graph.Visible = false;
    }
    protected void lbtnDateTime_Click(object sender, EventArgs e)
    {
        datetime_graph.Visible = true;
    }
}
