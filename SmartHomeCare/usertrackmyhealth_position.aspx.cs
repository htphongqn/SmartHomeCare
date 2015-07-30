using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Web.UI.DataVisualization.Charting;
using System.Drawing;

public partial class usertrackmyhealth_position : System.Web.UI.Page
{
    private DBClass _db = new DBClass();
    int i = 0;
    private static bool RawData;
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
            LoadPositionGraph();

            ddl_number.SelectedValue = "100";
            ddlNo2.SelectedValue = "100";
            if (Session["FromDatePosition"] == null && Session["ToDatePosition"] == null)
            {
                if (RawData)
                {
                    LoadRawDataPositionGraphDefault();
                }
                else
                {
                    LoadPositionGraphDefault();
                }
            }
            else
            {
                LoadViewStateData();
            }
            if (Session["IndexTab_Position"] != null)
            {
                if ((int)Session["IndexTab_Position"] == 1)
                {
                    Select_graph(true);
                    MultiViewPosition.ActiveViewIndex = 1;
                }
                else
                {
                    Select_graph(false);
                    MultiViewPosition.ActiveViewIndex = 0;
                }
            }
           
            else
            {
                Select_graph(false);
            }
            LoadStateDll();

        }
    }
    private void LoadStateDll()
    {
        if (Session["DataRawGraph"] != null && (int)Session["DataRawGraph"] == 1)
        {
            ddl_Graph.SelectedValue = "0";
            LoadPositionGraph();
        }
        else
        {
            ddl_Graph.SelectedValue = "1";
            LoadRawDataPositionGraph();
        }
        if (Session["DataRawTable"] != null && (int)Session["DataRawTable"] == 1)
        {
            ddl_Table.SelectedValue = "1";
            table_item2.Visible = true;
            table_item.Visible = false;
        }
        else
        {
            ddl_Table.SelectedValue = "0";
            table_item2.Visible = false;
            table_item.Visible = true;
        }
    }
    private void LoadViewStateData()
    {
        if (Session["PageSize_Position"] != null)
        {
            page_number1((int)Session["PageSize_Position"]);
        }
        if (Session["PageSize_Position2"] != null)
        {
            page_number1((int)Session["PageSize_Position2"]);
        }

        if (Session["PageIndex_Position"] != null)
            Load_DataPositionTable((int)Session["PageIndex_Position"]);
        else
            Load_DataPositionTable(0);
        if (Session["PageIndex_Position2"] != null)
            Load_RawDataPositionTable((int)Session["PageIndex_Position2"]);
        else
            Load_RawDataPositionTable(0);
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
            btnGraph2.BackColor = ColorTranslator.FromHtml("#e6e6e6");
            btnTable2.BackColor = ColorTranslator.FromHtml("#fff");
        }
        else
        {
            btnGraph2.BackColor = ColorTranslator.FromHtml("#fff");
            btnTable2.BackColor = ColorTranslator.FromHtml("#e6e6e6");
        }
    }
    /**
        * [Active tab] Active graph
        * */
    protected void btnGraph2_Click(object sender, EventArgs e)
    {
        MultiViewPosition.ActiveViewIndex = 0;
        Select_graph(false);
        Session["IndexTab_Position"] = 0;
    }
    /**
        * [Active tab] Active table
        * */
    protected void btnTable2_Click(object sender, EventArgs e)
    {
        MultiViewPosition.ActiveViewIndex = 1;
        Select_graph(true);
        Session["IndexTab_Position"] = 1;
    }
    #endregion

    #region Table

    private void Add_grvDataPosition(DataTable table)
    {
        grvData.DataSource = table;
        grvData.DataBind();
    }
    private void Add_RawData(DataTable table)
    {
        grvRawData.DataSource = table;
        grvRawData.DataBind();
    }
    private DateTime fromDate()
    {
        DateTime fromTime = DateTime.MinValue;
        string fromT = "";
        if (txtFromDate2.Text == "" || String.IsNullOrEmpty(txtFromDate2.Text))
        {
            fromT = txtFromDate.Text;
        }
        else
        {
            fromT = txtFromDate2.Text;
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
        if (txtToDate2.Text == "" || String.IsNullOrEmpty(txtToDate2.Text))
        {
            toT = txtToDate.Text;
        }
        else
        {
            toT = txtToDate2.Text;
        }
        DateTime.TryParse(toT, out toTime);
        if (toTime == DateTime.MinValue)
            toTime = DateTime.Now.Date;
        return toTime;
    }
    private void Load_DataPositionTable(int index)
    {
        grvData.PageIndex = index;
        DataTable table = _db.GetList_Position_Table(userName(), fromDate(), toDate());
        Add_grvDataPosition(table);
        pager(index);
    }
    private void Load_RawDataPositionTable(int index)
    {
        grvRawData.PageIndex = index;
        DataTable table = _db.GetList_Position_XYZ_Rawdata_Table(userName(), fromDate(), toDate());
        Add_RawData(table);
        pager2(index);
    }
    
    protected void btnRawData_Click(object sender, EventArgs e)
    {
        if (table_item2.Visible == false)
        {
            table_item2.Visible = true;
            table_item.Visible = false;
        }
        else
        {
            table_item2.Visible = false;
            table_item.Visible = true;
        }
    }
     protected void grvData_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        Load_DataPositionTable(e.NewPageIndex);
    }
    protected void grvRawData_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        Load_RawDataPositionTable(e.NewPageIndex);
    }
    
    #endregion
   
    #region Graph

    private void LoadPositionGraph()
    {
        DateTime fromTime = DateTime.MinValue, toTime;
        DateTime.TryParse(txtFromDate.Text, out fromTime);
        DateTime.TryParse(txtToDate.Text, out toTime);
        if (toTime == DateTime.MinValue)
            toTime = DateTime.MaxValue.Date;
        if (fromTime == DateTime.MinValue)
            fromTime = DateTime.Now.Date;
        DataTable dt = _db.GetList_Position_Graph(userName(), fromDate(), toDate());
        if (dt != null && dt.Rows.Count > 0)
        {
            foreach (DataRow row in dt.Rows)
            {
                string Position = BaseView.GetStringFieldValue(row, "Position");
                switch (Position)
                {
                    case "Supine":
                        AddSupine();
                        break;
                    case "Prone":
                        AddProne();
                        break;
                    case "Left":
                        AddLeft();
                        break;
                    case "Right":
                        AddRight();
                        break;
                    case "Up":
                        AddUp();
                        break;
                    case "Down":
                        AddDown();
                        break;
                    case "Undefined":
                        break;
                    default:
                        break;
                }
            }
            //ChartPosition.DataSource = dt;
            //ChartPosition.DataBind();
            dtlPostion.DataSource = dt;
            dtlPostion.DataBind();
            pnEmptyData.Visible = false;
            pnChart.Visible = true;
            pnDrawData.Visible = false;
        }
        else
        {
            pnEmptyData.Visible = true;
            pnChart.Visible = false;
        }
    }

    private void LoadPositionGraphDefault()
    {
        //DataTable dt = _db.GetList_Position_Default(userName());
        DataTable dt = _db.GetList_Position_Table(userName(), null, null);
        if (dt != null && dt.Rows.Count > 0)
        {
            foreach (DataRow row in dt.Rows)
            {
                string Position = BaseView.GetStringFieldValue(row, "Position");
                switch (Position)
                {
                    case "Supine":
                        AddSupine();
                        break;
                    case "Prone":
                        AddProne();
                        break;
                    case "Left":
                        AddLeft();
                        break;
                    case "Right":
                        AddRight();
                        break;
                    case "Up":
                        AddUp();
                        break;
                    case "Down":
                        AddDown();
                        break;
                    case "Undefined":
                        break;
                    default:
                        break;
                }
            }
            //ChartPosition.DataSource = dt;
            //ChartPosition.DataBind();
            dtlPostion.DataSource = dt;
            dtlPostion.DataBind();
            pnEmptyData.Visible = false;
            pnChart.Visible = true;
            pnDrawData.Visible = false;
        }
        else
        {
            pnEmptyData.Visible = true;
            pnChart.Visible = false;
        }
    }

    private void LoadRawDataPositionGraph()
    {
        DateTime fromTime = DateTime.MinValue, toTime;
        DateTime.TryParse(txtFromDate.Text, out fromTime);
        DateTime.TryParse(txtToDate.Text, out toTime);
        if (toTime == DateTime.MinValue)
            toTime = DateTime.MaxValue.Date;
        if (fromTime == DateTime.MinValue)
            fromTime = DateTime.Now.Date;
        DataTable dt = _db.GetList_Position_XYZ_Rawdata_Graph(userName(), fromDate(), toDate());
        if (dt != null && dt.Rows.Count > 0)
        {
            ChartDrawData.DataSource = dt;
            ChartDrawData.DataBind();
            pnEmptyData.Visible = false;
            pnChart.Visible = true;
            pnDrawData.Visible = false;
        }
        else
        {
            pnEmptyData.Visible = true;
            pnChart.Visible = false;
        }
    }

    private void LoadRawDataPositionGraphDefault()
    {
        DateTime fromTime = DateTime.MinValue, toTime;
        DateTime.TryParse(txtFromDate.Text, out fromTime);
        DateTime.TryParse(txtToDate.Text, out toTime);
        if (toTime == DateTime.MinValue)
            toTime = DateTime.MaxValue.Date;
        if (fromTime == DateTime.MinValue)
            fromTime = DateTime.Now.Date;
        //DataTable dt = _db.GetList_Position_XYZ_Rawdata_Graph_Default(userName());
        DataTable dt = _db.GetList_Position_XYZ_Rawdata_Table(userName(), null, null);
        if (dt != null && dt.Rows.Count > 0)
        {
            ChartDrawData.DataSource = dt;
            ChartDrawData.DataBind();
            pnEmptyData.Visible = false;
            pnChart.Visible = true;
            pnDrawData.Visible = false;
        }
        else
        {
            pnEmptyData.Visible = true;
            pnChart.Visible = false;
        }
    }

    private void AddSupine()
    {
        DataPoint point = new DataPoint(0, 1.2);
        point.Color = Color.Blue;
        point.BackGradientStyle = GradientStyle.None;
        point.MarkerStyle = MarkerStyle.Circle;
        point.MarkerSize = 20;
        //ChartPosition.Series[0].Points.Add(point);
    }

    private void AddProne()
    {
        DataPoint point = new DataPoint(0, 1.0);
        point.Color = Color.Red;
        point.BackGradientStyle = GradientStyle.None;
        point.MarkerStyle = MarkerStyle.Circle;
        point.MarkerSize = 20;
        //ChartPosition.Series[0].Points.Add(point);
    }

    private void AddLeft()
    {
        DataPoint point = new DataPoint(0, 0.8);
        point.Color = Color.Purple;
        point.BackGradientStyle = GradientStyle.None;
        point.MarkerStyle = MarkerStyle.Circle;
        point.MarkerSize = 20;
        //ChartPosition.Series[0].Points.Add(point);
    }

    private void AddRight()
    {
        DataPoint point = new DataPoint(0, 0.6);
        point.Color = Color.Orange;
        point.BackGradientStyle = GradientStyle.None;
        point.MarkerStyle = MarkerStyle.Circle;
        point.MarkerSize = 20;
        //ChartPosition.Series[0].Points.Add(point);
    }

    private void AddUp()
    {
        DataPoint point = new DataPoint(0, 0.4);
        point.Color = Color.Green;
        point.BackGradientStyle = GradientStyle.None;
        point.MarkerStyle = MarkerStyle.Circle;
        point.MarkerSize = 20;
        //ChartPosition.Series[0].Points.Add(point);
    }

    private void AddDown()
    {
        DataPoint point = new DataPoint(0, 0.2);
        point.Color = Color.BlueViolet;
        point.BackGradientStyle = GradientStyle.None;
        point.MarkerStyle = MarkerStyle.Circle;
        point.MarkerSize = 20;
        //ChartPosition.Series[0].Points.Add(point);
    }

    #endregion

    #region Time
    protected void btnOk_Click(object sender, EventArgs e)
    {
        txtFromDate2.Text = "";
        txtToDate2.Text = "";
        pnEmptyData.Visible = false;
        Session["ToDatePosition"] = toDate();
        if (fromDate().Year > 1753)
        {
            Session["FromDatePosition"] = fromDate();
        }
        else
        {
            MessagesBox.jQueryShow(ClientScript, this.GetType(), DBClass.GetMessageByCode2("SelectTime"), "Notice");
            pnEmptyData.Visible = true;
            return;
            
        }
        LoadPositionGraph();
        Load_DataPositionTable(0);
        Load_RawDataPositionTable(0);
        date_graph.Visible = false;
    }

    #endregion

    #region pager
    protected void back_Click(object sender, ImageClickEventArgs e)
    {
        i = grvData.PageIndex;
        if (grvData.PageIndex > 0)
        {
            grvData.PageIndex = i--;
            Load_DataPositionTable(i);
            Session["PageIndex_Position"] = i;
            pager(i);
        }
    }
    protected void next_Click(object sender, ImageClickEventArgs e)
    {
        if (grvData.PageIndex < grvData.PageCount - 1)
        {
            i = grvData.PageIndex;
            grvData.PageIndex = i++;
            Load_DataPositionTable(i);
            Session["PageIndex_Position"] = i;
            pager(i);
        }
    }
    private void pager(int index)
    {
        int pagecount = index + 1;
        txtpage.Text = pagecount.ToString();
        lb_pager.Text = "/" + grvData.PageCount.ToString();
    }
    private void pager2(int index)
    {
        int pagecount = index + 1;
        txt_page2.Text = pagecount.ToString();
        lbpage2.Text = "/" + grvRawData.PageCount.ToString();
    }
    protected void txtpage_TextChanged(object sender, EventArgs e)
    {
        int page = Int32.Parse(txtpage.Text);
        int index = page - 1;
        Load_DataPositionTable(index);
        Session["PageIndex_Position"] = index;
        pager(index);
    }
    protected void btn_back1_Click(object sender, ImageClickEventArgs e)
    {
        i = grvRawData.PageIndex;
        if (grvRawData.PageIndex > 0)
        {
            grvRawData.PageIndex = i--;
            Load_RawDataPositionTable(i);
            Session["PageIndex_Position2"] = i;
            pager(i);
        }
    }
    protected void btn_next2_Click(object sender, ImageClickEventArgs e)
    {
        if (grvRawData.PageIndex < grvRawData.PageCount - 1)
        {
            i= grvRawData.PageIndex;
            grvRawData.PageIndex = i++;
            Load_RawDataPositionTable(i);
            Session["PageIndex_Position2"] = i;
            pager(i);
        }
    }
    protected void txt_page2_TextChanged(object sender, EventArgs e)
    {
        int page = Int32.Parse(txt_page2.Text);
        int index = page - 1;
        Load_RawDataPositionTable(index);
        Session["PageIndex_Position2"] = index;
        pager2(index);
    }
   
    protected void btnOk2_Click(object sender, EventArgs e)
    {
        Session["ToDatePosition"] = toDate();
        if (fromDate().Year > 1753)
        {
            Session["FromDatePosition"] = fromDate();
        }
        else
        {
            MessagesBox.jQueryShow(ClientScript, this.GetType(), DBClass.GetMessageByCode2("SelectTime"), "Notice");
            pnEmptyData.Visible = true;
            return;

        }
        
        Load_DataPositionTable(0);
        Load_RawDataPositionTable(0);
        date_table.Visible = false;
        
    }

    #endregion

    protected void btnDrawData_Click(object sender, EventArgs e)
    {
        
    }
    protected void ddl_Graph_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (RawData)
        {
            LoadRawDataPositionGraph();
            Session["DataRawGraph"] = 0;
        }
        else
        {
            LoadPositionGraph();
            Session["DataRawGraph"] = 1;
        }
    }
    protected void ddl_Table_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddl_Table.SelectedValue == "0")
        {
            select_RawData_Table(true);
            Session["DataRawTable"] = 0;
        }
        else
        {
            select_RawData_Table(false);
            Session["DataRawTable"] = 1;
        }
    }
    /**
       * [Change Data View] click  -> change data.
       * */
    private void select_RawData_Table(bool q)
    {
        table_item2.Visible = q;
        table_item.Visible = !table_item2.Visible;
    }
    /**
        * [Datetime] click  -> popup datetime graph open.
        * */
    protected void lbtnDateTime_Click(object sender, EventArgs e)
    {
        date_graph.Visible = true;
    }
    /**
        * [Cancel] click  -> popup datetime graph close.
        * */
    protected void btnCancel_Click(object sender, EventArgs e)
    {
        date_graph.Visible = false;
    }
    protected void grvRawData_SelectedIndexChanged(object sender, EventArgs e)
    {

    }
    /**
        * [Datetime] click  -> popup datetime table open.
        * */
    protected void lbPopup_Click(object sender, EventArgs e)
    {
        date_table.Visible = true;
    }
    /**
        * [Cancel] click  -> popup datetime table close.
        * */
    protected void btnCancel2_Click(object sender, EventArgs e)
    {
        date_table.Visible = false;
    }

    private void LoadDateTime()
    {
        if (Session["FromDatePosition"] != null)
        {
            DateTime startdate = (DateTime)Session["FromDatePosition"];
            if (startdate.Year > 1753)
            {
                txtFromDate.Text = startdate.ToShortDateString();
                txtFromDate2.Text = startdate.ToShortDateString();
            }
        }
        if (Session["ToDatePosition"] != null)
        {
            DateTime startdate = (DateTime)Session["ToDatePosition"];
            if (startdate.Year > 1753)
            {
                txtToDate.Text = startdate.ToShortDateString();
                txtToDate2.Text = startdate.ToShortDateString();
            }
        }
    }
    private void page_number1(int i)
    {
        grvData.AllowPaging = true;
        grvData.PageSize = i;
        if (!IsPostBack)
            ddl_number.SelectedValue = i.ToString();
        Session["PageSize_Position"] = i;
    }
    private void page_number2(int i)
    {
        grvRawData.AllowPaging = true;
        grvRawData.PageSize = i;
        if (!IsPostBack)
            ddlNo2.SelectedValue = i.ToString();
        Session["PageSize_Position2"] = i;
    }
    protected void ddl_number_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddl_number.SelectedValue == "0")
        {
            grvData.AllowPaging = false;
            Load_DataPositionTable(0);
            pager(0);
        }
        else
        {
            page_number1(ToSQL.SQLToInt(ddl_number.SelectedValue));
            Load_DataPositionTable(0);
            pager(0);
        }
    }
    protected void ddlNo2_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddlNo2.SelectedValue == "0")
        {
            grvRawData.AllowPaging = false;
            Load_RawDataPositionTable(0);
            pager2(0);
        }
        else
        {
            page_number2(ToSQL.SQLToInt(ddlNo2.SelectedValue));
            Load_RawDataPositionTable(0);
            pager2(0);
        }
    }
    protected void lbLinks_Click(object sender, EventArgs e)
    {
        Session["IndexTab_Position"] = null;
        Session["PageSize_Position"] = null;
        Session["PageSize_Position2"] = null;
        Session["PageIndex_Position2"] = null;
        Session["PageIndex_Position"] = null;
        Session["DataRawTable"] = null;
        Session["DataRawGraph"] = null;
        Session["ToDatePosition"] = null;
        Session["FromDatePosition"] = null;
        Response.Redirect("~/usertrackmyhealth_position.aspx");
    }
}