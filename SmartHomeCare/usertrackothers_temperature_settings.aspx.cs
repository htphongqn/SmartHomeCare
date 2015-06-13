using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

public partial class usertrackothers_temperature_settings : System.Web.UI.Page
{
    private DBClass _db = new DBClass();
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
        siteuser _siteuser = (siteuser)this.Master;
        TreeView treeview = _siteuser.treeview;
        BaseView.SelectedTreeView(treeview, siteuser.REPORTS, siteuser.TRACKOTHERS);

        if (!IsPostBack)
        {
            DataRow rowcurrentuser = (DataRow)Session["AuthorizedUser"];
            lbNameHealth.Text = BaseView.GetStringFieldValue(rowcurrentuser, "FullName");
            //IsEdit(false);
            LoadDropdown();
            LoadInfo();
            ChangeTextUnits();
        }
    }
    //private void IsEdit(bool s)
    //{
    //    ddlSimpleRate.Visible = s; txtSimpleRate.Visible = s;
    //    lbSimpleRate.Visible = !ddlSimpleRate.Visible;

    //    txtNormalThreshold.Visible = s;
    //    lbNormalThreshold.Visible = !txtNormalThreshold.Visible;

    //    txtHighThreshold.Visible = s;
    //    lbHighThreshold.Visible = !txtHighThreshold.Visible;

    //    txtVeryHighThreshold.Visible = s;
    //    lbVeryHighThreshold.Visible = !txtVeryHighThreshold.Visible;

    //    btnSave.Visible = s;
    //    btnCancel.Visible = s;
    //    btnEdit.Visible = !s;
    //    btnback.Visible = !s;

    //}
    private void ChangeTextUnits()
    {
        DataRow rowcurrentuser = (DataRow)Session["AuthorizedUser"];
        string username = BaseView.GetStringFieldValue(rowcurrentuser, "Username");
        bool isUS = _db.Get_IsUS_UserTrackMyHealth_ByUserName(username);
        if (isUS)
        {
            lbNormalThresholdUnits.Text = "⁰F";
            lbHighThresholdUnits.Text = "⁰F";
            lbVeryHighThresholdUnits.Text = "⁰F";
        }
        else
        {
            lbNormalThresholdUnits.Text = "⁰C";
            lbHighThresholdUnits.Text = "⁰C";
            lbVeryHighThresholdUnits.Text = "⁰C";
        }
    }
    private void LoadInfo()
    {
        DataRow rowcurrentuser = (DataRow)Session["AuthorizedUser"];
        string username = BaseView.GetStringFieldValue(rowcurrentuser, "Username");

        DataRow dr = _db.GetInfo_UserTrackMyHealth(username);
        if (dr != null)
        {
            //ddlSimpleRate.SelectedValue = BaseView.GetStringFieldValue(dr, "SampleRateId") == "" ? "0" : BaseView.GetStringFieldValue(dr, "SampleRateId");
            BaseView.SelectDropdownItem(ddlSimpleRate, BaseView.GetStringFieldValue(dr, "SampleRateId"));
            txtSimpleRate.Text = BaseView.GetStringFieldValue(dr, "SampleRate");
            //lbSimpleRate.Text = BaseView.GetStringFieldValue(dr, "SampleRateName");

            txtNormalThreshold.Text = BaseView.GetStringFieldValue(dr, "LowValue");
            //lbNormalThreshold.Text = BaseView.GetStringFieldValue(dr, "LowValue");

            txtHighThreshold.Text = BaseView.GetStringFieldValue(dr, "HighValue");
            //lbHighThreshold.Text = BaseView.GetStringFieldValue(dr, "HighValue");

            txtVeryHighThreshold.Text = BaseView.GetStringFieldValue(dr, "VeryHighValue");
            //lbVeryHighThreshold.Text = BaseView.GetStringFieldValue(dr, "VeryHighValue");
        }
    }
    private void LoadDropdown()
    {
        BaseView.BindDataToDropdownList(ddlSimpleRate, _db.GetList_UnitTime());
    }
    protected void btnEdit_Click(object sender, EventArgs e)
    {
        //IsEdit(true);
    }
    protected void btnSave_Click(object sender, EventArgs e)
    {
        DataRow rowcurrentuser = (DataRow)Session["AuthorizedUser"];
        string username = BaseView.GetStringFieldValue(rowcurrentuser, "Username");

        decimal? SampleRateUnitTimeid = ToSQL.SQLToDecimalNull(txtSimpleRate.Text);//chua ap dung
        int? SampleRate = ToSQL.SQLToIntNull(ddlSimpleRate.SelectedValue);
        decimal? LowValue = ToSQL.SQLToDecimalNull(txtNormalThreshold.Text);
        decimal? HighValue = ToSQL.SQLToDecimalNull(txtHighThreshold.Text);
        decimal? VeryHighValue = ToSQL.SQLToDecimalNull(txtVeryHighThreshold.Text);

        _db.InsertUpdate_UserTrackMyHealth_Threshold(username, SampleRateUnitTimeid, SampleRate, LowValue, HighValue, VeryHighValue);

        //MessagesBox.jQueryShow(Page.ClientScript, this.GetType(), DBClass.GetMessageByCode2("edit_success"), "Edit message");
        //IsEdit(false);
        //LoadInfo();
        Response.Redirect("~/usertrackothers_temperature.aspx");
    }
    protected void btnCancel_Click(object sender, EventArgs e)
    {
        //IsEdit(false);
    }    
}