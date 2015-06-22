using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Drawing;
using System.IO;
public partial class usertrackmyhealth_sleep : System.Web.UI.Page
{
    private DBClass _db = new DBClass();
    private DataTable dt = new DataTable();
    int i = 0;
    private static bool RawData = false;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            siteuser _siteuser = (siteuser)this.Master;
            TreeView treeview = _siteuser.treeview;
            BaseView.SelectedTreeView(treeview, siteuser.REPORTS, siteuser.TRACKMYHEALTH);
            LoadDateTime();
            Load_Data_Raw_Table(0);
            Load_Data_Table(0);   
            if (Session["FromDateSleep"] == null && Session["ToDateSleep"] == null)
            {
                if (RawData)
                {
                    LoadDrawDataDefault();
                }
                else
                {
                    
                }
            }
            else
            {
                LoadViewStateData();
            }
            if (Session["IndexTab_Sleep"] != null)
            {
                if ((int)Session["IndexTab_Sleep"] == 1)
                {
                    Select_graph(true);
                    MultiViewSleep.ActiveViewIndex = 1;
                }
                else
                {
                    Select_graph(false);
                    MultiViewSleep.ActiveViewIndex = 0;
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
            
        }
        else
        {
            ddl_Graph.SelectedValue = "1";
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
        if (Session["PageSize_Sleep"] != null)
        {
            page_number1((int)Session["PageSize_Sleep"]);
        }
        if (Session["PageSize_Sleep2"] != null)
        {
            page_number1((int)Session["PageSize_Sleep2"]);
        }

        if (Session["PageIndex_Sleep"] != null)
            Load_Data_Table((int)Session["PageIndex_Sleep"]);
        else
            Load_Data_Table(0);
        if (Session["PageIndex_Sleep2"] != null)
            Load_Data_Raw_Table((int)Session["PageIndex_Sleep2"]);
        else
            Load_Data_Raw_Table(0);
    }
    #region Page
    private string userName()
    {
        DataRow row = (DataRow)Session["User"];

        if (row != null)
        {
            return BaseView.GetStringFieldValue(row, "Username");
        }
        return "";
    }
    #endregion

    #region DateTime
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
        MultiViewSleep.ActiveViewIndex = 0;
        Select_graph(false);
        Session["IndexTab_Sleep"] = 0;
    }
    protected void btnTable2_Click(object sender, EventArgs e)
    {
        MultiViewSleep.ActiveViewIndex = 1;
        Select_graph(true);
        Session["IndexTab_Sleep"] = 1;
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
    private void Load_Data_Raw_Table(int index)
    {
        grvRawData.PageIndex = index;
        dt = _db.GetList_Sleep_Rawdata(userName(), fromDate(), toDate());
        grvRawData.DataSource = dt;
        grvRawData.DataBind();
        pager2(index);
    }
    private void Load_Data_Table(int index)
    {
       // grvRawData.PageIndex = index;
       //dt = _db.GetList_Sleep_Rawdata(userName(), fromDate(), toDate());
        grvTemp.DataSource = dt;
        grvTemp.DataBind();
        //pager2(index);
    }
    #endregion

    #region pager
    protected void back_Click(object sender, ImageClickEventArgs e)
    {
        i = grvTemp.PageIndex;
        if (grvTemp.PageIndex > 0)
        {
            grvTemp.PageIndex = i--;
            pager(i);
        }
    }
    protected void next_Click(object sender, ImageClickEventArgs e)
    {
        if (grvTemp.PageIndex < grvTemp.PageCount - 1)
        {
            i = grvTemp.PageIndex;
            grvTemp.PageIndex = i++;
            pager(i);
        }
    }
    private void pager(int index)
    {
        int pagecount = index + 1;
        txtpage.Text = pagecount.ToString();
        lb_pager.Text = "/" + grvTemp.PageCount.ToString();
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
        //Load_TableHeartRate(index);
        pager(index);
    }
    protected void btn_back1_Click(object sender, ImageClickEventArgs e)
    {
        i = grvRawData.PageIndex;
        if (grvRawData.PageIndex > 0)
        {
            grvRawData.PageIndex =i--;
            Load_Data_Raw_Table(i);
            pager(i);
        }
    }
    protected void btn_next2_Click(object sender, ImageClickEventArgs e)
    {
        if (grvRawData.PageIndex < grvRawData.PageCount - 1)
        {
            i = grvRawData.PageIndex;
            grvRawData.PageIndex = i++;
            Load_Data_Raw_Table(i);
            pager(i);
        }
    }
    protected void txt_page2_TextChanged(object sender, EventArgs e)
    {
        int page = Int32.Parse(txt_page2.Text);
        int index = page - 1;
        Load_Data_Raw_Table(index);
        pager2(index);
    }
    #endregion

    #region Graph

    private void LoadDrawData()
    {
        DataTable dt = _db.GetList_Sleep_Rawdata(userName(), fromDate(), toDate());
        if (dt != null && dt.Rows.Count > 0)
        {
            LoadDrawDataFromDatatable(dt);
        }
    }

    private void LoadDrawDataDefault()
    {
        //DataTable dt = _db.GetList_Sleep_Rawdata_Default(userName());
        DataTable dt = _db.GetList_Sleep_Rawdata(userName(), null, null);
        if (dt != null && dt.Rows.Count > 0)
        {
            LoadDrawDataFromDatatable(dt);
        }
    }

    private void LoadDrawDataFromDatatable(DataTable dt)
    {
        int MinHR = int.MaxValue, MinSkinTemp = int.MaxValue, MinGSR = int.MaxValue, MinX = int.MaxValue, MinY = int.MaxValue, MinZ = int.MaxValue, MinActivity = int.MaxValue,
            MaxHR = int.MinValue, MaxSkinTemp = int.MinValue, MaxGSR = int.MinValue, MaxX = int.MinValue, MaxY = int.MinValue, MaxZ = int.MinValue, MaxActivity = int.MinValue;
        foreach (DataRow row in dt.Rows)
        {
            MinHR = Math.Min(MinHR, BaseView.GetIntFieldValue(row, "HR"));
            MaxHR = Math.Max(MaxHR, BaseView.GetIntFieldValue(row, "HR"));
            MinSkinTemp = Math.Min(MinSkinTemp, BaseView.GetIntFieldValue(row, "SkinTemp"));
            MaxSkinTemp = Math.Max(MaxSkinTemp, BaseView.GetIntFieldValue(row, "SkinTemp"));
            MinGSR = Math.Min(MinGSR, BaseView.GetIntFieldValue(row, "GSR"));
            MaxGSR = Math.Max(MaxGSR, BaseView.GetIntFieldValue(row, "GSR"));
            MinX = Math.Min(MinX, BaseView.GetIntFieldValue(row, "ValueX"));
            MaxX = Math.Max(MaxX, BaseView.GetIntFieldValue(row, "ValueX"));
            MinY = Math.Min(MinY, BaseView.GetIntFieldValue(row, "ValueY"));
            MaxY = Math.Max(MaxY, BaseView.GetIntFieldValue(row, "ValueY"));
            MinZ = Math.Min(MinZ, BaseView.GetIntFieldValue(row, "ValueZ"));
            MaxZ = Math.Max(MaxZ, BaseView.GetIntFieldValue(row, "ValueZ"));
            MinActivity = Math.Min(MinActivity, BaseView.GetIntFieldValue(row, "ActivityLevel"));
            MaxActivity = Math.Max(MaxActivity, BaseView.GetIntFieldValue(row, "ActivityLevel"));
        }

        Steema.TeeChart.Styles.FastLine sHR = new Steema.TeeChart.Styles.FastLine();
        sHR.Stairs = true;
        sHR.Color = Color.Red;

        Steema.TeeChart.Styles.Line sSkinTemp = new Steema.TeeChart.Styles.Line();
        sSkinTemp.Color = Color.YellowGreen;

        Steema.TeeChart.Styles.Line sGSR = new Steema.TeeChart.Styles.Line();
        sGSR.Color = Color.Black;

        Steema.TeeChart.Styles.Line sX = new Steema.TeeChart.Styles.Line();
        sX.Color = Color.Green;

        Steema.TeeChart.Styles.Line sY = new Steema.TeeChart.Styles.Line();
        sY.Color = Color.DarkRed;

        Steema.TeeChart.Styles.Line sZ = new Steema.TeeChart.Styles.Line();
        sZ.Color = Color.Blue;

        Steema.TeeChart.Styles.Line sActility = new Steema.TeeChart.Styles.Line();
        sActility.Color = Color.Purple;

        foreach (DataRow row in dt.Rows)
        {
            sHR.Add(BaseView.GetDateTimeFieldValue(row, "ReceivedDate"), MaHoaKhongThuNguyen(BaseView.GetFloatFieldValue(row, "HR"), 13, MaxHR, MinHR));
            sSkinTemp.Add(BaseView.GetDateTimeFieldValue(row, "ReceivedDate"), MaHoaKhongThuNguyen(BaseView.GetFloatFieldValue(row, "SkinTemp"), 11, MaxHR, MinHR));
            sGSR.Add(BaseView.GetDateTimeFieldValue(row, "ReceivedDate"), MaHoaKhongThuNguyen(BaseView.GetFloatFieldValue(row, "GSR"), 9, MaxHR, MinHR));
            sX.Add(BaseView.GetDateTimeFieldValue(row, "ReceivedDate"), MaHoaKhongThuNguyen(BaseView.GetFloatFieldValue(row, "ValueX"), 7, MaxHR, MinHR));
            sY.Add(BaseView.GetDateTimeFieldValue(row, "ReceivedDate"), MaHoaKhongThuNguyen(BaseView.GetFloatFieldValue(row, "ValueY"), 5, MaxHR, MinHR));
            sZ.Add(BaseView.GetDateTimeFieldValue(row, "ReceivedDate"), MaHoaKhongThuNguyen(BaseView.GetFloatFieldValue(row, "ValueZ"), 3, MaxHR, MinHR));
            sActility.Add(BaseView.GetDateTimeFieldValue(row, "ReceivedDate"), MaHoaKhongThuNguyen(BaseView.GetFloatFieldValue(row, "ActivityLevel"), 1, MaxHR, MinHR));
        }

        WebChartDrawData.Chart.Series.Add(sHR);
        WebChartDrawData.Chart.Series.Add(sSkinTemp);
        WebChartDrawData.Chart.Series.Add(sGSR);
        WebChartDrawData.Chart.Series.Add(sX);
        WebChartDrawData.Chart.Series.Add(sY);
        WebChartDrawData.Chart.Series.Add(sZ);
        WebChartDrawData.Chart.Series.Add(sActility);
    }

    private float MaHoaKhongThuNguyen(float Zj, float Position, float Zmax, float Zmin)
    {
        return ((2 * (Zj - ((Zmax + Zmin) / 2))) / (Zmax - Zmin)) + Position;
    }

    #endregion

    protected void ddl_Table_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddl_Table.SelectedValue == "0")
        {
            select_RawData_Table(true);
            Session["DataRawGraph"] = 0;
        }
        else
        {
            select_RawData_Table(false);
            Session["DataRawTable"] = 1;
        }
    }
    private void select_RawData_Table(bool q)
    {
        table_item2.Visible = q;
        table_item.Visible = !table_item2.Visible;
    }
    protected void btnOk_Click(object sender, EventArgs e)
    {
        pnEmptyData.Visible = false;
        Session["ToDateSleep"] = toDate();
        if (fromDate().Year > 1753)
        {
            Session["FromDateSleep"] = fromDate();
        }
        else
        {
            MessagesBox.jQueryShow(ClientScript, this.GetType(), DBClass.GetMessageByCode2("SelectTime"), "Notice");
            pnEmptyData.Visible = true;
            return;
        }
        date_graph.Visible = false;
    }

    private void LoadDateTime()
    {
        if (Session["FromDateSleep"] != null)
        {
            DateTime startdate = (DateTime)Session["FromDateSleep"];
            if (startdate.Year > 1753)
            {
                txtFromDate.Text = startdate.ToShortDateString();
                txtFromDateTable.Text = startdate.ToShortDateString();
            }
        }

        if (Session["ToDateSleep"] != null)
        {
            DateTime startdate = (DateTime)Session["ToDateSleep"];
            if (startdate.Year > 1753)
            {
                txtToDate.Text = startdate.ToShortDateString();
                txtToDateTable.Text = startdate.ToShortDateString();
            }
        }
    }
    protected void lbtdatesleep_Click(object sender, EventArgs e)
    {
        date_table.Visible = true;
    }
    protected void btncancel2_Click(object sender, EventArgs e)
    {
        date_table.Visible = false;
    }
    protected void btnClose_Click(object sender, EventArgs e)
    {
        date_table.Visible = false;
    }
    protected void btnOkTable_Click(object sender, EventArgs e)
    {
        date_table.Visible = false;
    }
    protected void btn_Ok_Table_Click(object sender, EventArgs e)
    {
        Session["ToDateSleep"] = toDate();
        if (fromDate().Year > 1753)
        {
            Session["FromDateSleep"] = fromDate();
        }
        else
        {
            MessagesBox.jQueryShow(ClientScript, this.GetType(), DBClass.GetMessageByCode2("SelectTime"), "Notice");
            return;
        }
        Load_Data_Raw_Table(0);
        Load_Data_Table(0);
        date_table.Visible = false;
    }
    protected void lbtnDateTime_Command(object sender, CommandEventArgs e)
    {

    }
    protected void lbtnDateTime_Click(object sender, EventArgs e)
    {
        date_graph.Visible = true;
    }
    protected void btnCancel_Click(object sender, EventArgs e)
    {
        date_graph.Visible = false;
    }
    protected void ddl_number_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddl_number.SelectedValue == "0")
        {
            grvTemp.AllowPaging = false;
            Load_Data_Table(0);
            pager(0);
        }
        else
        {
            page_number1(ToSQL.SQLToInt(ddl_number.SelectedValue));
            Load_Data_Table(0);
            pager(0);
        }
    }
    private void page_number1(int i)
    {
        grvTemp.AllowPaging = true;
        grvTemp.PageSize = i;
        if (!IsPostBack)
            ddl_number.SelectedValue = i.ToString();
        Session["PageSize_Sleep"] = i;
    }
    private void page_number2(int i)
    {
        grvRawData.AllowPaging = true;
        grvRawData.PageSize = i;
        if (!IsPostBack)
            ddlNo2.SelectedValue = i.ToString();
        Session["PageSize_Sleep2"] = i;
    }
    protected void ddlNo2_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddlNo2.SelectedValue == "0")
        {
            grvRawData.AllowPaging = false;
            Load_Data_Raw_Table(0);
            pager2(0);
        }
        else
        {
            page_number2(ToSQL.SQLToInt(ddlNo2.SelectedValue));
            Load_Data_Raw_Table(0);
            pager2(0);
        }
    }
    protected void ddl_Graph_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (Session["FromDateSleep"] == null && Session["ToDateSleep"] == null)
        {
            if (RawData)
            {
                LoadDrawDataDefault();
            }
            else
            {
                //loadda
            }
        }
    }
    protected void ddlTimeType_SelectedIndexChanged(object sender, EventArgs e)
    {

    }
    protected void btnLinks_Click(object sender, EventArgs e)
    {
        Session["FromDateSleep"] = null;
        Session["ToDateSleep"] = null;
        Session["PageIndex_Sleep"] = null;
        Session["PageIndex_Sleep2"] = null;
        Session["PageSize_Sleep"] = null;
        Session["PageSize_Sleep2"] = null;
        Session["IndexTab_Sleep"] = null;
        Session["DataRawTable"] = null;
        Session["DataRawGraph"] = null;
        Response.Redirect("~/usertrackmyhealth_sleep.aspx");
    }
}

