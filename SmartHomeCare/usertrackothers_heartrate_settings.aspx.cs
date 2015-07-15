using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

public partial class usertrackothers_heartrate_settings : System.Web.UI.Page
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
        //siteuser _siteuser = (siteuser)this.Master;
        //TreeView treeview = _siteuser.treeview;
        //BaseView.SelectedTreeView(treeview, siteuser.REPORTS, siteuser.TRACKOTHERS);

        if (!IsPostBack)
        {
            ViewState["AutoId"] = 0;
            DataRow rowcurrentuser = (DataRow)Session["AuthorizedUser"];
            lbNameHealth.Text = BaseView.GetStringFieldValue(rowcurrentuser, "FullName");
            //IsEdit(false);
            LoadDropdown();
            LoadInfo();
            //ChangeTextUnits();
        }
    }
    //private void IsEdit(bool s)
    //{
    //    ddlsamplerate.Visible = s; txtsamplerate.Visible = s;
    //    lbsamplerate.Visible = !ddlsamplerate.Visible;
    //    ddlmaxhrestimation.Visible = s;
    //    lbmaxhrestimation.Visible = !ddlmaxhrestimation.Visible;
    //    ddlhighresting.Visible = s;
    //    lbhighresting.Visible = !ddlhighresting.Visible;
    //    ddllowresting.Visible = s;
    //    lblowresting.Visible = !ddllowresting.Visible;
    //    ddlhrvanalysis.Visible = s; txthrvanalysis.Visible = s;
    //    lbhrvanalysis.Visible = !ddlhrvanalysis.Visible;

    //    btnSave.Visible = s;
    //    btnCancel.Visible = s;
    //    btnEdit.Visible = !s;
    //    btnback.Visible = !s;
    //}
    private void LoadDropdown()
    {
        BaseView.BindDataToDropdownList(ddlsamplerate, _db.GetList_UnitTime());
        BaseView.BindDataToDropdownList(ddlmaxhrestimation, _db.GetList_HeartRateHREstType());
        BaseView.BindDataToDropdownList(ddlhighresting, _db.GetList_UnitBPM());
        BaseView.BindDataToDropdownList(ddllowresting, _db.GetList_UnitBPM());
        BaseView.BindDataToDropdownList(ddlhrvanalysis, _db.GetList_UnitTime());
    }
    private void LoadInfo()
    {
        DataRow rowcurrentuser = (DataRow)Session["AuthorizedUser"];
        string username = BaseView.GetStringFieldValue(rowcurrentuser, "Username");
        DataRow dr = _db.GetInfo_HeartRate(username);
        if (dr != null)
        {
            ViewState["AutoId"] = BaseView.GetIntFieldValue(dr, "AutoId");
            //ddlsamplerate.SelectedValue = BaseView.GetStringFieldValue(dr, "SampleRateId") == "" ? "0" : BaseView.GetStringFieldValue(dr, "SampleRateId");
            BaseView.SelectDropdownItem(ddlsamplerate, BaseView.GetStringFieldValue(dr, "SRUnitTimeId"));
            txtsamplerate.Text = BaseView.GetStringFieldValue(dr, "SampleRate");
            //lbsamplerate.Text = BaseView.GetStringFieldValue(dr, "SampleRateName");
            //ddlmaxhrestimation.SelectedValue = BaseView.GetStringFieldValue(dr, "MaxHREstimationId") == "" ? "0" : BaseView.GetStringFieldValue(dr, "MaxHREstimationId");
            BaseView.SelectDropdownItem(ddlmaxhrestimation, BaseView.GetStringFieldValue(dr, "MaxHREstimationId"));
            //lbmaxhrestimation.Text = BaseView.GetStringFieldValue(dr, "MaxHREstimationName");
            //ddlhighresting.SelectedValue = BaseView.GetStringFieldValue(dr, "HighRestHRId") == "" ? "0" : BaseView.GetStringFieldValue(dr, "HighRestHRId");
            BaseView.SelectDropdownItem(ddlhighresting, BaseView.GetStringFieldValue(dr, "HighRestHRId"));
            //lbhighresting.Text = BaseView.GetStringFieldValue(dr, "HighRestHRName");
            //ddllowresting.SelectedValue = BaseView.GetStringFieldValue(dr, "LowRestHRId") == "" ? "0" : BaseView.GetStringFieldValue(dr, "LowRestHRId");
            BaseView.SelectDropdownItem(ddllowresting, BaseView.GetStringFieldValue(dr, "LowRestHRId"));
            //lblowresting.Text = BaseView.GetStringFieldValue(dr, "LowRestHRName");
            //ddlhrvanalysis.SelectedValue = BaseView.GetStringFieldValue(dr, "HRVAnalysisInteralId") == "" ? "0" : BaseView.GetStringFieldValue(dr, "HRVAnalysisInteralId");
            BaseView.SelectDropdownItem(ddlhrvanalysis, BaseView.GetStringFieldValue(dr, "HRVUnitTimeId"));
            txthrvanalysis.Text = BaseView.GetStringFieldValue(dr, "HRVAnalysisInteral");
            //lbhrvanalysis.Text = BaseView.GetStringFieldValue(dr, "HRVAnalysisInteralName");
        }
    }
    //private void ChangeTextUnits()
    //{
    //    DataRow row = (DataRow)Session["User"];
    //    string username = BaseView.GetStringFieldValue(row, "Username");
    //    bool isUS = _db.Get_IsUS_UserTrackMyHealth_ByUserName(username);
    //    if (isUS)
    //    {
    //        lbweightunits.Text = "pound";
    //        lbheightunits.Text = "inches";
    //        lbwaistunits.Text = "inches";
    //        lbhipunits.Text = "inches";
    //        lbneckunits.Text = "inches";
    //    }
    //    else
    //    {
    //        lbweightunits.Text = "kg";
    //        lbheightunits.Text = "cm";
    //        lbwaistunits.Text = "cm";
    //        lbhipunits.Text = "cm";
    //        lbneckunits.Text = "cm";
    //    }
    //}
    protected void btnEdit_Click(object sender, EventArgs e)
    {
        //IsEdit(true);
    }
    protected void btnSave_Click(object sender, EventArgs e)
    {
        DataRow rowcurrentuser = (DataRow)Session["AuthorizedUser"];
        string username = BaseView.GetStringFieldValue(rowcurrentuser, "Username");

        decimal? samplerate = ToSQL.SQLToDecimalNull(txtsamplerate.Text);
        int? samplerateUnitTimeId = ToSQL.SQLToIntNull(ddlsamplerate.SelectedValue);
        int? maxhrestimation = ToSQL.SQLToIntNull(ddlmaxhrestimation.SelectedValue);
        int? highresting = ToSQL.SQLToIntNull(ddlhighresting.SelectedValue);
        int? lowresting = ToSQL.SQLToIntNull(ddllowresting.SelectedValue);
        decimal? hrvanalysis = ToSQL.SQLToDecimalNull(txthrvanalysis.Text);
        int? hrvanalysisUnitTimeId = ToSQL.SQLToIntNull(ddlhrvanalysis.SelectedValue);

        int autoId = (int)ViewState["AutoId"];
        _db.InsertUpdate_HeartRate(autoId, username, samplerate, samplerateUnitTimeId, maxhrestimation, highresting, lowresting, hrvanalysis, hrvanalysisUnitTimeId);

        //MessagesBox.jQueryShow(Page.ClientScript, this.GetType(), DBClass.GetMessageByCode2("edit_success"), "Edit message");
        //LoadInfo();
        //IsEdit(false);
        Response.Redirect("~/usertrackothers_heartrate.aspx");
    }
    protected void btnCancel_Click(object sender, EventArgs e)
    {
        //IsEdit(false);
    }
}