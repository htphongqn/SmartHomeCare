using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
public partial class _Default : System.Web.UI.Page
{
    DBClass _db = new DBClass();
    int i = 0;
    protected void Page_Load(object sender, EventArgs e)
    {
        Response.Redirect("~/home.aspx");
        //if(!IsPostBack)
        //    Load_TableHRV(0);

    }
    private void LoadHeartRateData()
    {
        DateTime fromTime = DateTime.MinValue, toTime;
        DateTime.TryParse("11/25/2013 12:47:59 PM", out fromTime);
        DateTime.TryParse("11/25/2013 04:00:44 PM", out toTime);
        if (toTime == DateTime.MinValue)
            toTime = DateTime.Now;
        if (fromTime == DateTime.MinValue || fromTime.Year < DateTime.Parse("1/1/1753 12:00:00 AM").Year)
            fromTime = DateTime.Now;

        
    }
    private void Add_grvTable(DataTable table)
    {
        grvTable.DataSource = table;
        grvTable.DataBind();
    }
    private void Load_TableHRV(int index)
    {
        DateTime fromTime = DateTime.MinValue, toTime;
        DateTime.TryParse("01/01/1913 00:00:00", out fromTime);
        DateTime.TryParse("12/31/2014 23:59:59 PM", out toTime);
        if (toTime == DateTime.MinValue)
            toTime = DateTime.Now;
        if (fromTime == DateTime.MinValue || fromTime.Year < DateTime.Parse("1/1/1753 12:00:00 AM").Year)
            fromTime = DateTime.Now;
        grvTable.PageIndex = index;
        DataTable table = _db.GetList_HeartRate_Table("tuan.nguyen", fromTime, toTime);
        Add_grvTable(table);
        pager(i);
    }
    #region pager
    protected void back_Click(object sender, ImageClickEventArgs e)
    {
        i = grvTable.PageIndex;
        if (grvTable.PageIndex > 0)
        {
            
            grvTable.PageIndex = i--;
            Load_TableHRV(i);
            pager(i);
        }
    }
    protected void next_Click(object sender, ImageClickEventArgs e)
    {
        if (grvTable.PageIndex < grvTable.PageCount - 1)
        {
            i = grvTable.PageIndex;
            grvTable.PageIndex = i++;
            
            Load_TableHRV(i);
            pager(i);
        }
    }
    private void pager(int index)
    {
        //int pagecount = index + 1;
        //txtpage.Text = pagecount.ToString();
        //lb_pager.Text = "/" + grvTable.PageCount.ToString();
    }
    #endregion
    protected void txtpage_TextChanged(object sender, EventArgs e)
    {
        //int page = Int32.Parse(txtpage.Text);
        //int index = page - 1;
        //Load_TableHRV(index);
        //pager(index);
    }
}