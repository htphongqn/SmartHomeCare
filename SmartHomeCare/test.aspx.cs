using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
public partial class test : System.Web.UI.Page
{
    string Username = "";
    DataTable dt = new DataTable();
    DBClass _db = new DBClass();
    public static int i=1;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack) {
            i = 1;
            LoadTableBody();
        }
    }
    #region Table
    DataTable Get_date(string username)
    {
        //dt = _db.GetList_Datetime_BodyMeasurement(username);
        return dt;
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
        DataRow row = (DataRow)Session["User"];
        Username = row["username"].ToString();
        Username = "tuan.nguyen";
        DataSet ds = new DataSet();
        dt = Get_date(Username);
        if (dt.Rows.Count > 1)
        {
            DateTime todate = ToSQL.SQLToDateTime(dt.Rows[1][0].ToString());
            DateTime date = ToSQL.SQLToDateTime(dt.Rows[0][0].ToString());
            DataTable table = _db.GetList_BodyMeasurement_Datatable(Username, date, todate).Tables[0];
            DataTable table2 = _db.GetList_BodyMeasurement_Datatable(Username, date, todate).Tables[1];
            AddGrvBody(table);
            AddGrvBody2(table2);
        }
       
    }

    protected void btnNext_Click(object sender, EventArgs e)
    {
        DataRow row = (DataRow)Session["User"];
        Username = row["username"].ToString();
        Username = "tuan.nguyen";
        dt = Get_date(Username);
   
        if (dt.Rows.Count > 1)
        {
            if (i < dt.Rows.Count - 1)
            { i++; }
            int first = i - 1;
            try
            {
                DateTime date = ToSQL.SQLToDateTime(dt.Rows[first][0].ToString());
                DateTime todate = ToSQL.SQLToDateTime(dt.Rows[i][0].ToString());
                DataTable table = _db.GetList_BodyMeasurement_Datatable(Username, date, todate).Tables[0];
                DataTable table2 = _db.GetList_BodyMeasurement_Datatable(Username, date, todate).Tables[1];
                AddGrvBody(table);
                AddGrvBody2(table2);
            }
            catch (Exception x)
            {
                MessagesBox.jQueryShow(ClientScript, this.GetType(), "Datetime is not validate", "Messages Box");
            }
        }
    }
    protected void btn_back_Click(object sender, EventArgs e)
    {
        if (i > 1)
        { i--; }
        DataRow row = (DataRow)Session["User"];
        Username = row["username"].ToString();
        Username = "tuan.nguyen";
        dt = Get_date(Username);
        if (dt.Rows.Count > 1)
        {
            int first = i - 1;
            try{
                DateTime date = ToSQL.SQLToDateTime(dt.Rows[first][0].ToString());
                DateTime todate = ToSQL.SQLToDateTime(dt.Rows[i][0].ToString());
                DataTable table = _db.GetList_BodyMeasurement_Datatable(Username, date, todate).Tables[0];
                DataTable table2 = _db.GetList_BodyMeasurement_Datatable(Username, date, todate).Tables[1];
                AddGrvBody(table);
                AddGrvBody2(table2);
            }
            catch (Exception x)
            {
                MessagesBox.jQueryShow(ClientScript, this.GetType(), "Datetime is not validate", "Messages Box");
            }
        }
    }
    #endregion
   
}