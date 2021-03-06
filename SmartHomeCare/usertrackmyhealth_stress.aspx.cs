﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Drawing;
using System.IO;
public partial class usertrackmyhealth_stress : System.Web.UI.Page
{
    private DBClass _db = new DBClass();

    private MemoryStream tmpChart = new MemoryStream();
    int i = 0;
    private bool DrawData = false;

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
           
            LoadDataStress();
            LoadDateTime();
            if (Session["ToDateStress"] == null && Session["FromDateStress"] == null)
            {
                if (DrawData)
                {
                    LoadDrawDataDefault();
                }
                else
                {
                    LoadDataStressDefault();
                }
                LoadViewStateData();
            }
            else
            {
                if (DrawData)
                {
                    LoadDrawData();
                }
                else
                {
                    LoadDataStress();
                }

                LoadViewStateData();
                
            }
            if (Session["IndexTab_Stress"] != null)
            {
                if ((int)Session["IndexTab_Stress"] == 1)
                {
                    Select_graph(true);
                    MultiViewStress.ActiveViewIndex = 1;
                }
                else
                {
                    Select_graph(false);
                    MultiViewStress.ActiveViewIndex = 0;
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
        if (Session["RawGraph_Stress"] != null && (int)Session["RawGraph_Stress"] == 0)
        {
            LoadDrawData();
            ddl_graph.SelectedValue = "0";
        }
        else
        {
            LoadDataStress();
            ddl_graph.SelectedValue = "1";
        }
        if (Session["DataRawTable_Stress"] != null && (int)Session["DataRawTable_Stress"] == 0)
        {
            ddl_Table.SelectedValue = "0";
            table_item2.Visible = true;
            table_item.Visible = false;
        }
        else
        {
            ddl_Table.SelectedValue = "1";
            table_item2.Visible = false;
            table_item.Visible = true;
        }
    }
    private void LoadViewStateData()
    {
        if (Session["PageSize_Stress2"] != null)
        {
            Select_Number_Page2((int)Session["PageSize_Stress2"]);
        }
        if (Session["PageSize_Stress"] != null)
        {
            Select_Number_Page((int)Session["PageSize_Stress"]);
        }

        if (Session["PageIndex_Stress2"] != null)
            Load_DataStressTable((int)Session["PageIndex_Stress2"]);
        else
            Load_DataStressTable(0);
        if (Session["PageIndex_Stress"] != null)
           Load_RawDataStressTable((int)Session["PageIndex_Stress"]);
        else
            Load_RawDataStressTable(0);
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

    #region Table
        private void Add_grvRawStress(DataTable table)
        {
            grvRawData_Stress.DataSource = table;
            grvRawData_Stress.DataBind();
        }
        private void Add_grvDataStress(DataTable table)
        {
            grvDataStress.DataSource = table;
            grvDataStress.DataBind();
        }
        private void Load_DataStressTable(int index)
        {
            grvDataStress.PageIndex = index;
            DataTable table = _db.GetList_Stress_Table(userName(), fromDateTable(), toDateTable());
            Add_grvDataStress(table);
            pager2(index);
        } 
        private void Load_RawDataStressTable(int index)
        {
            grvRawData_Stress.PageIndex = index;
            DataTable table = _db.GetList_Stress_Rawdata_Table(userName(), fromDateTable(), toDateTable());
            Add_grvRawStress(table);
            pager(index);
        }
        protected void btnView_Click(object sender, EventArgs e)
        {
            Session["ToDateStress"] = toDateTable();
            if (fromDate().Year > 1753)
            {
                Session["FromDateStress"] = fromDateTable();
            }
            Load_RawDataStressTable(0);
            Load_DataStressTable(0);
        }
        protected void btnRawData_Click(object sender, EventArgs e)
        {
            if (table_item.Visible == false)
            {
                table_item.Visible = true;
                table_item2.Visible = false;
            }
            else
            {
                table_item.Visible = false;
                table_item2.Visible = true;
            }

        }
        protected void grvDataStress_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            Load_DataStressTable(e.NewPageIndex);
        }
        protected void grvRawData_Stress_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
           
            Load_RawDataStressTable(e.NewPageIndex);

        }
    #endregion

    #region Graph

        private void LoadDataStress()
        {
            DrawData = false;
            DataTable dt = _db.GetList_Stress_Table(userName(), fromDate(), toDate());

            if (dt != null && dt.Rows.Count > 0)
            {
                //AddSeriesLowHighToWebChart(dt);
                ChartStressMain.DataSource = dt;
                ChartStressMain.DataBind();
                pnStress.Visible = true;
                pnEmptyData.Visible = false;
                pnRawData.Visible = false;
            }
            else
            {
                pnStress.Visible = false;
                pnEmptyData.Visible = true;
                pnRawData.Visible = false;
            }
        }

        private void LoadDataStressDefault()
        {
            DrawData = false;
            //DataTable dt = _db.GetList_Stress_Default(userName());
            DataTable dt = _db.GetList_Stress_Table(userName(), null, null);
            if (dt != null && dt.Rows.Count > 0)
            {
                //AddSeriesLowHighToWebChart(dt);
                ChartStressMain.DataSource = dt;
                ChartStressMain.DataBind();
                pnStress.Visible = true;
                pnEmptyData.Visible = false;
                pnRawData.Visible = false;
            }
            else
            {
                pnStress.Visible = false;
                pnEmptyData.Visible = true;
                pnRawData.Visible = false;
            }
        }

        //private void AddSeriesLowHighToWebChart(DataTable dt)
        //{
        //    Steema.TeeChart.Chart ch1 = WebChartStress.Chart;
        //    ch1.Series.Clear();
        //    tmpChart = new MemoryStream();
        //    //if (Session["WebChartStress"] == null)
        //    //{
        //        if (dt != null && dt.Rows.Count > 0)
        //        {
        //            Steema.TeeChart.Styles.Bar bar = new Steema.TeeChart.Styles.Bar();
        //            //bar.XValues.DateTime = true;
        //            //bar.Color = System.Drawing.Color.Blue;
        //            bar.Marks.Visible = false;
        //            int MinL1 = 0, MaxL1 = 0;
        //            foreach (DataRow row in dt.Rows)
        //            {
        //                bar.Add(BaseView.GetDateTimeFieldValue(row, "ReceivedDate"), BaseView.GetFloatFieldValue(row, "StressLevel"));
        //                //if (MinL1 == 0 || (BaseView.GetIntFieldValue(row, "StressLevel") < MinL1 && BaseView.GetIntFieldValue(row, "StressLevel") > 0))
        //                //{
        //                //    MinL1 = BaseView.GetIntFieldValue(row, "StressLevel");
        //                //}
        //                //if (MaxL1 == 0 || (BaseView.GetIntFieldValue(row, "StressLevel") > MaxL1 && BaseView.GetIntFieldValue(row, "StressLevel") > 0))
        //                //{
        //                //    MaxL1 = BaseView.GetIntFieldValue(row, "StressLevel");
        //                //}
        //            }
        //            ch1.Axes.Bottom.Labels.DateTimeFormat = "MM/dd/yyyy HH:mm:ss";
        //            ch1.Axes.Left.Title.Text = "% Stress";
        //            ch1.Series.Add(bar);
        //            ch1.Axes.Bottom.SetMinMax(ch1.Series[0].MinXValue(), ch1.Series[0].MaxXValue());
        //            ch1.Axes.Left.SetMinMax(0, 100);
        //            //ch1.Axes.Left.Visible = false;
        //            //ch1.Axes.Right.Visible = false;
        //            ch1.Export.Template.Save(tmpChart);
        //            //save template to a Session variable
        //            ((Steema.TeeChart.Tools.ScrollTool)WebChartStress.Chart.Tools[0]).StartPosition = 1;
        //            int n = 20 * 100 / dt.Rows.Count;
        //            //((Steema.TeeChart.Tools.ScrollTool)WebChartStress.Chart.Tools[0]).ViewSegmentSize = 3;
                    
        //        }
        //    //}
        //    //else
        //    //{
        //    //    //retrieve the session stored Chart
        //    //    tmpChart = (MemoryStream)Session["WebChartStress"];
        //    //    //set the Stream position to 0 as the last read/write
        //    //    //will have moved the position to the end of the stream
        //    //    tmpChart.Position = 0;
        //    //    //import saved Chart
        //    //    WebChartStress.Chart.Import.Template.Load(tmpChart);
        //    //    //CheckZoom(WebChartHeartRate);
        //    //}
        //}

        private void LoadDrawData()
        {
            DrawData = true;
            DataTable dt = _db.GetList_Stress_Rawdata_Graph(userName(), fromDate(), toDate());
            if (dt != null && dt.Rows.Count > 0)
            {
                //ChartDrawData.DataSource = dt;
                //ChartDrawData.DataBind();
                ChartStress.DataSource = dt;
                ChartStress.DataBind();
                pnStress.Visible = false;
                pnEmptyData.Visible = false;
                pnRawData.Visible = true;
            }
            else
            {
                pnStress.Visible = false;
                pnEmptyData.Visible = true;
                pnRawData.Visible = false;
            }
        }

        private void LoadDrawDataDefault()
        {
            DrawData = true;
            //DataTable dt = _db.GetList_Stress_RawData_Default(userName());
            DataTable dt = _db.GetList_Stress_Rawdata_Table(userName(), null, null);
            if (dt != null && dt.Rows.Count > 0)
            {
                //ChartDrawData.DataSource = dt;
                //ChartDrawData.DataBind();
                ChartStress.DataSource = dt;
                ChartStress.DataBind();
                pnStress.Visible = false;
                pnEmptyData.Visible = false;
                pnRawData.Visible = true;
            }
            else
            {
                pnStress.Visible = false;
                pnEmptyData.Visible = true;
                pnRawData.Visible = false;
            }
        }

        protected void btnOk_Click(object sender, EventArgs e)
        {
            pnEmptyData.Visible = false;
            Session["ToDateStress"] = toDate();
            if (fromDate().Year > 1753)
            {
                Session["FromDateStress"] = fromDate();
            }
            else
            {
                MessagesBox.jQueryShow(ClientScript, this.GetType(), DBClass.GetMessageByCode2("SelectTime"), "Notice");
                pnEmptyData.Visible = true;
                return;
            }
            if (DrawData)
            {
                LoadDrawData();
            }
            else
            {
                LoadDataStress();
            }
            Load_DataStressTable(0);
            Load_RawDataStressTable(0);
            date_graph.Visible = false;

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
            MultiViewStress.ActiveViewIndex = 0;
            Select_graph(false);
            Session["IndexTab_Stress"] = 0;
        }
        protected void btnTable2_Click(object sender, EventArgs e)
        {
            MultiViewStress.ActiveViewIndex = 1;
            Select_graph(true);
            Session["IndexTab_Stress"] = 1;
        }
    #endregion

    #region pager
        protected void back_Click(object sender, ImageClickEventArgs e)
        {
            i = grvRawData_Stress.PageIndex;
            if (grvRawData_Stress.PageIndex > 0)
            {
                grvRawData_Stress.PageIndex = i--;
                Load_RawDataStressTable(i);
                Session["PageIndex_Stress"] = i;
                pager(i);
            }
        }
        protected void next_Click(object sender, ImageClickEventArgs e)
        {
            if (grvRawData_Stress.PageIndex < grvRawData_Stress.PageCount- 1)
            {
                i = grvRawData_Stress.PageIndex;
                grvRawData_Stress.PageIndex = i++;
                Load_RawDataStressTable(i);
                Session["PageIndex_Stress"] = i;
                pager(i);
            }
        }
        private void pager(int index)
        {
            int pagecount = index + 1;
            txtpage.Text = pagecount.ToString();
            lb_pager.Text = "/" + grvRawData_Stress.PageCount.ToString();
        }
        private void pager2(int index)
        {
            int pagecount = index + 1;
            txt_page2.Text = pagecount.ToString();
            lbpage2.Text = "/" + grvDataStress.PageCount.ToString();
        }
        protected void txtpage_TextChanged(object sender, EventArgs e)
        {
            int page = Int32.Parse(txtpage.Text);
            int index = page - 1;
            Load_RawDataStressTable(index);
            Session["PageIndex_Stress"] = index;
            pager(index);
        }
        protected void btn_back1_Click(object sender, ImageClickEventArgs e)
        {
            i = grvDataStress.PageIndex;
            if (grvDataStress.PageIndex > 0)
            {

                grvDataStress.PageIndex = i--;
                Load_DataStressTable(i);
                Session["PageIndex_Stress2"] = i;
                pager2(i);
            }
        }
        protected void btn_next2_Click(object sender, ImageClickEventArgs e)
        {
            if (grvDataStress.PageIndex < grvDataStress.PageCount - 1)
            {
                i = grvDataStress.PageIndex;
                grvDataStress.PageIndex = i++;
                Load_DataStressTable(i);
                Session["PageIndex_Stress2"] = i;
                pager2(i);
            }
        }
        protected void txt_page2_TextChanged(object sender, EventArgs e)
        {
            int page = Int32.Parse(txt_page2.Text);
            int index = page - 1;
            Load_DataStressTable(index);
            Session["PageIndex_Stress2"] = index;
            pager2(index);
        }
        #endregion
        
        protected void grvRawData_Stress_SelectedIndexChanged(object sender, EventArgs e)
        {

        }
        #region Time
        private DateTime fromDate()
        {
            DateTime fromTime = DateTime.MinValue;
            string fromT = "";
            if (txtFromDate.Text == "" || String.IsNullOrEmpty(txtFromDate.Text))
            {
                fromT = txtFromDate2.Text;
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
        private DateTime toDate()
        {
            DateTime toTime;
            string toT = "";
            if (txtToDate.Text == "" || String.IsNullOrEmpty(txtToDate.Text))
            {
                toT = txtToDate2.Text;
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

        private DateTime fromDateTable()
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
        private DateTime toDateTable()
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

        protected void btnOk2_Click(object sender, EventArgs e)
        {
            Session["ToDateStress"] = toDateTable();
            if (fromDate().Year > 1753)
            {
                Session["FromDateStress"] = fromDateTable();
            }
            else
            {
                MessagesBox.jQueryShow(ClientScript, this.GetType(), DBClass.GetMessageByCode2("SelectTime"), "Notice");
                pnEmptyData.Visible = true;
                return;
            }
            Load_DataStressTable(0);
            Load_RawDataStressTable(0);
            date_table.Visible = false;
        }
       
        
        #endregion

        private void LoadDateTime()
        {
            if (Session["FromDateStress"] != null)
            {
                DateTime startdate = (DateTime)Session["FromDateStress"];
                if (startdate.Year > 1753)
                {
                    txtFromDate.Text = startdate.ToShortDateString();
                    txtFromDate2.Text = startdate.ToShortDateString();
                }
            }

            if (Session["ToDateStress"] != null)
            {
                DateTime startdate = (DateTime)Session["ToDateStress"];
                if (startdate.Year > 1753)
                {
                    txtToDate.Text = startdate.ToShortDateString();
                    txtToDate2.Text = startdate.ToShortDateString();
                }
            }
        }

        protected void ddl_Table_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (ddl_Table.SelectedValue == "0")
            {
                select_RawData_Table(true);
                Session["DataRawTable_Stress"] = 0;
            }
            else
            {
                select_RawData_Table(false);
                Session["DataRawTable_Stress"] = 1;
            }
        }
        private void select_RawData_Table(bool q)
        {
            table_item2.Visible = q;
            table_item.Visible = !table_item2.Visible;
        }
        protected void ddl_graph_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (ddl_graph.SelectedValue == "0")
            {
                LoadDrawData();
                Session["RawGraph_Stress"] = 0;
            }
            else
            {
                LoadDataStress();
                Session["RawGraph_Stress"] = 1;
            }
        }
        protected void btnDraw_Click(object sender, EventArgs e)
        {
            LoadDrawData();
        }
        protected void btnReturnChart_Click(object sender, EventArgs e)
        {
            LoadDataStress();
        }
        protected void lbtnDateTime_Click(object sender, EventArgs e)
        {
            date_graph.Visible = true;
        }
        protected void btnCancel_Click(object sender, EventArgs e)
        {
            date_graph.Visible = false;
        }
        protected void btnCancel2_Click(object sender, EventArgs e)
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
                grvRawData_Stress.AllowPaging = false;
                Load_DataStressTable(0);
                pager(0);
            }
            else
            {
                
                Select_Number_Page(ToSQL.SQLToInt(ddl_number.SelectedValue));
                Load_RawDataStressTable(0);
                pager(0);
            }
        }
        private void Select_Number_Page(int i)
        {
            grvRawData_Stress.AllowPaging = true;
            grvRawData_Stress.PageSize = i;
            if (!IsPostBack)
                ddl_number.SelectedValue = i.ToString();
            Session["PageSize_Stress"] = i;
        }
        private void Select_Number_Page2(int i)
        {
            grvDataStress.AllowPaging = true;
            grvDataStress.PageSize = i;
            if(!IsPostBack)
                ddlNo2.SelectedValue = i.ToString();
            Session["PageSize_Stress2"] = i;
        }
        protected void ddlNo2_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (ddlNo2.SelectedValue == "0")
            {
                grvDataStress.AllowPaging = false;
                Load_DataStressTable(0);
                pager2(0);
            }
            else
            {
                
                Select_Number_Page2(ToSQL.SQLToInt(ddlNo2.SelectedValue));
                Load_DataStressTable(0);
                pager2(0);
            }
        }
        protected void btnlinks_Click(object sender, EventArgs e)
        {
            Session["FromDateStress"] = null;
            Session["ToDateStress"] = null;
            Session["PageIndex_Stress"] = null;
            Session["PageIndex_Stress2"] = null;
            Session["PageSize_Stress"] = null;
            Session["PageSize_Stress2"] = null;
            Session["TabIndex_Stress"] = null;
            Session["DataRawTable_Stress"] = null;
            Session["RawGraph_Stress"] = null;
            Response.Redirect("~/usertrackmyhealth_stress.aspx");
        }
}