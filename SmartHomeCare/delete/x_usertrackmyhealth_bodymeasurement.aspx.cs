using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Web.UI.DataVisualization.Charting;
using System.Collections;

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
        if (!IsPostBack)
        {
            //siteuser _siteuser = (siteuser)this.Master;
            //TreeView treeview = _siteuser.treeview;
            //BaseView.SelectedTreeView(treeview, siteuser.REPORTS, siteuser.TRACKMYHEALTH);
            //treeview.Nodes[siteuser.REPORTS].ChildNodes[siteuser.TRACKMYHEALTH].ChildNodes.AddAt(0, new TreeNode("Body Measurement", "0"));
            //treeview.Nodes[siteuser.REPORTS].ChildNodes[siteuser.TRACKMYHEALTH].Expand();
            //treeview.Nodes[siteuser.REPORTS].ChildNodes[siteuser.TRACKMYHEALTH].ChildNodes[0].Selected = true;
            i = 1;
            dataTime = null;
            LoadTableBody();
            LoadGridviewTemp();
            LoadTempUser();
        }

    }
    #region Tab
    protected void btnGraph2_Click(object sender, EventArgs e)
    {
        MultiViewBody.ActiveViewIndex = 0;
    }
    protected void btnTable2_Click(object sender, EventArgs e)
    {
        MultiViewBody.ActiveViewIndex = 1;
    }
    #endregion
    protected void grvTemp_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        //grvTemp.PageIndex = e.NewPageIndex;
        LoadGridviewTemp();
    }
    private void LoadName()
    {
        DataRow row = (DataRow)Session["User"];
        Username = row["username"].ToString();
        DataRow dr;
        if (!String.IsNullOrEmpty(Request.QueryString["AuthorizedUser"]))
        {
            Username = Request.QueryString["AuthorizedUser"].ToString();
            dt = _db.GetInfo_UserAll_ByUserName(Username);

            if (dt.Rows.Count > 0)
            {
                dr = dt.Rows[0];
                lbNameHealth.Text = dr["Firstname"].ToString() + " " + dr["Lastname"].ToString();
            }
            else
                lbNameHealth.Text = Username;

        }


    }
    private void LoadTempUser()
    {
        DataRow row = (DataRow)Session["User"];
        if (row != null)
        {
            DataTable dt = _db.GetList_BodyMeasurement_Graph(row["UserName"].ToString(), txtFromDate_CalendarExtender.SelectedDate, txtToDate_CalendarExtender.SelectedDate);
            if (dt == null || dt.Rows.Count <= 0)
            {
                pnChart.Visible = false;
                lbDataEmpty.Visible = true;
            }
            else
            {
                dtlChart.DataSource = dt;
                dtlChart.DataBind();
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

    protected void btnFilter_Click(object sender, EventArgs e)
    {
        LoadTempUser();
        LoadGridviewTemp();
    }
    protected void Button1_Click(object sender, EventArgs e)
    {
    }
    protected void btnOk_Click(object sender, EventArgs e)
    {
        LoadTempUser();
    }
    #region Table
    protected void btnView_Click(object sender, EventArgs e)
    {
        try
        {

            LoadTableBody();

        }
        catch (Exception)
        {
            string msg = DBClass.GetMessageByCode2("date_invalid");
            MessagesBox.jQueryShow(ClientScript, this.GetType(), msg, "Messages Box");
            
        }
    }
    
    DataTable Get_date(string username)
    {   
        dt = _db.GetList_Datetime_BodyMeasurement(username,getFromDate(),getToDate());
        return dt;
    }
    private DateTime? getFromDate()
    {
        
        return clFrom.SelectedDate;
       
    }
    private DateTime? getToDate()
    {
        return clTo.SelectedDate;
        
    }
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
    private void AddGrvBody(DataTable table)
    {
        grvBody.DataSource = table.DefaultView;
        grvBody.DataBind();
        if (grvBody.Rows.Count == 0) { lbEmpty.Visible = true; }
        else { lbEmpty.Visible = false; }
    }
    private void AddGrvBody2(DataTable table)
    {
        grvBody2.DataSource = table.DefaultView;
        grvBody2.DataBind();
    }
    private void LoadTableBody()
    {
        
        dataTime = Get_date(getUserName());
        if (dataTime.Rows.Count > 1)
        {
            DateTime todate = ToSQL.SQLToDateTime(dataTime.Rows[1][0].ToString());
            DateTime date = ToSQL.SQLToDateTime(dataTime.Rows[0][0].ToString());
            DataSet ds = _db.GetList_BodyMeasurement_Datatable(getUserName(), date, todate);
            lbDate1.Text = date.ToString();
            lbDate2.Text = todate.ToString();
            DataTable table = ds.Tables[0];
            AddGrvBody(table);
            if (ds.Tables.Count > 1)
            {
                DataTable table2 = ds.Tables[1];
                AddGrvBody2(table2);
            }
        }

    }

    protected void btnNext_Click(object sender, EventArgs e)
    {
        dataTime = Get_date(getUserName());

        if (dataTime.Rows.Count > 1)
        {
            if (i < dataTime.Rows.Count -1)
            { i++; }
            int first = i - 1;
            try
            {
                DateTime date = ToSQL.SQLToDateTime(dataTime.Rows[first][0].ToString());
                DateTime todate = ToSQL.SQLToDateTime(dataTime.Rows[i][0].ToString());
                lbDate1.Text = date.ToString();
                lbDate2.Text = todate.ToString();
                DataSet ds = _db.GetList_BodyMeasurement_Datatable(getUserName(), date, todate);

                DataTable table = ds.Tables[0];
                AddGrvBody(table);
                if (ds.Tables.Count > 1)
                {
                    DataTable table2 = ds.Tables[1];
                    AddGrvBody2(table2);
                }
            }
            catch (Exception)
            {
                string msg = DBClass.GetMessageByCode2("date_invalid");
                MessagesBox.jQueryShow(ClientScript, this.GetType(), msg, "Messages Box");
            }
        }
    }
    protected void btn_back_Click(object sender, EventArgs e)
    {
        if (i > 1)
        { i--; }

        dataTime = Get_date(getUserName());
        if (dataTime.Rows.Count > 1)
        {
            int first = i - 1;
            try
            {
                DateTime date = ToSQL.SQLToDateTime(dataTime.Rows[first][0].ToString());
                DateTime todate = ToSQL.SQLToDateTime(dataTime.Rows[i][0].ToString());
                DataSet ds = _db.GetList_BodyMeasurement_Datatable(getUserName(), date, todate);
                lbDate1.Text = date.ToString();
                lbDate2.Text = todate.ToString();
                DataTable table = ds.Tables[0];
                AddGrvBody(table);
                if (ds.Tables.Count > 1)
                {
                    DataTable table2 = ds.Tables[1];
                    AddGrvBody2(table2);
                }
            }
            catch (Exception)
            {
                string msg = DBClass.GetMessageByCode2("date_invalid");
                MessagesBox.jQueryShow(ClientScript, this.GetType(), msg, "Messages Box");
            }
        }
    }
    #endregion
    
}