using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
public partial class usertrackmyhealth_stress_settings : System.Web.UI.Page
{
    private DBClass _db = new DBClass();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["User"] == null)
        {
            Response.Redirect("~/home.aspx");
        }
        siteuser _siteuser = (siteuser)this.Master;
        TreeView treeview = _siteuser.treeview;
        BaseView.SelectedTreeView(treeview, siteuser.REPORTS, siteuser.TRACKMYHEALTH);

        if (!IsPostBack)
        {
            ViewState["AutoId"] = 0;
            //IsEdit(false);
            LoadDropdown();
            LoadInfo();
            //ChangeTextUnits();
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
    //private void IsEdit(bool s)
    //{
    //    ddlmeasurementduration.Visible = s; txtmeasurementduration.Visible = s;
    //    lbmeasurementduration.Visible = !ddlmeasurementduration.Visible;
    //    ddlheartratesample.Visible = s; txtheartratesample.Visible = s;
    //    lbheartratesample.Visible = !ddlheartratesample.Visible;
    //    ddlgsrsamplerate.Visible = s; txtgsrsamplerate.Visible = s;
    //    lbgsrsamplerate.Visible = !ddlgsrsamplerate.Visible;
    //    ddlaccelerometersamplerate.Visible = s; txtaccelerometersamplerate.Visible = s;
    //    lbaccelerometersamplerate.Visible = !ddlaccelerometersamplerate.Visible;

    //    btnSave.Visible = s;
    //    btnCancel.Visible = s;
    //    btnEdit.Visible = !s;
    //    btnback.Visible = !s;
    //}
    private void LoadDropdown()
    {
        BaseView.BindDataToDropdownList(ddlmeasurementduration, _db.GetList_UnitTime());
        BaseView.BindDataToDropdownList(ddlheartratesample, _db.GetList_UnitTime());
        BaseView.BindDataToDropdownList(ddlgsrsamplerate, _db.GetList_UnitTime());
        BaseView.BindDataToDropdownList(ddlaccelerometersamplerate, _db.GetList_UnitTime());
    }
    private void LoadInfo()
    {
        DataRow row = (DataRow)Session["User"];
        string username = BaseView.GetStringFieldValue(row, "Username");
        DataRow dr = _db.GetInfo_Stress(username);
        if (dr != null)
        {
            ViewState["AutoId"] = BaseView.GetIntFieldValue(dr, "AutoId");
            //ddlmeasurementduration.SelectedValue = BaseView.GetStringFieldValue(dr, "HRExerciseId") == "" ? "0" : BaseView.GetStringFieldValue(dr, "HRExerciseId");
            BaseView.SelectDropdownItem(ddlmeasurementduration, BaseView.GetStringFieldValue(dr, "MDUnitTimeId"));
            txtmeasurementduration.Text = BaseView.GetStringFieldValue(dr, "MeasureDuration");
            //lbmeasurementduration.Text = BaseView.GetStringFieldValue(dr, "MeasureDurationName");
            //ddlheartratesample.SelectedValue = BaseView.GetStringFieldValue(dr, "HRTargetId") == "" ? "0" : BaseView.GetStringFieldValue(dr, "HRTargetId");
            BaseView.SelectDropdownItem(ddlheartratesample, BaseView.GetStringFieldValue(dr, "HRSRUnitTimeId"));
            txtheartratesample.Text = BaseView.GetStringFieldValue(dr, "HRSampleRate");
            //lbheartratesample.Text = BaseView.GetStringFieldValue(dr, "HRSampleRateName");
            //ddlgsrsamplerate.SelectedValue = BaseView.GetStringFieldValue(dr, "PMTargetId") == "" ? "0" : BaseView.GetStringFieldValue(dr, "PMTargetId");
            BaseView.SelectDropdownItem(ddlgsrsamplerate, BaseView.GetStringFieldValue(dr, "GSRSRUnittimeId"));
            txtgsrsamplerate.Text = BaseView.GetStringFieldValue(dr, "GSRSampleRate");
            //lbgsrsamplerate.Text = BaseView.GetStringFieldValue(dr, "GSRSampleRateName");
            //ddlaccelerometersamplerate.SelectedValue = BaseView.GetStringFieldValue(dr, "PMRemindId") == "" ? "0" : BaseView.GetStringFieldValue(dr, "PMRemindId");
            BaseView.SelectDropdownItem(ddlaccelerometersamplerate, BaseView.GetStringFieldValue(dr, "ASRUnitTimeId"));
            txtaccelerometersamplerate.Text = BaseView.GetStringFieldValue(dr, "AccelSampleRate");
            //lbaccelerometersamplerate.Text = BaseView.GetStringFieldValue(dr, "AccelSampleRateName");
        }
    }
    protected void btnEdit_Click(object sender, EventArgs e)
    {
        //IsEdit(true);
    }
    protected void btnSave_Click(object sender, EventArgs e)
    {
        DataRow row = (DataRow)Session["User"];
        string username = BaseView.GetStringFieldValue(row, "Username");

        decimal? measurementduration = ToSQL.SQLToDecimalNull(txtmeasurementduration.Text);
        int? measurementdurationUnitTimeId = ToSQL.SQLToIntNull(ddlmeasurementduration.SelectedValue);
        decimal? heartratesample = ToSQL.SQLToDecimalNull(txtheartratesample.Text);
        int? heartratesampleUnitTimeId = ToSQL.SQLToIntNull(ddlheartratesample.SelectedValue);
        decimal? gsrsamplerate = ToSQL.SQLToDecimalNull(txtgsrsamplerate.Text);
        int? gsrsamplerateUnitTimeId = ToSQL.SQLToIntNull(ddlgsrsamplerate.SelectedValue);
        decimal? accelerometersamplerate = ToSQL.SQLToDecimalNull(txtaccelerometersamplerate.Text);
        int? accelerometersamplerateUnitTimeId = ToSQL.SQLToIntNull(ddlaccelerometersamplerate.SelectedValue);

        int autoId = (int)ViewState["AutoId"];
        _db.InsertUpdate_Stress(autoId, username, measurementduration, measurementdurationUnitTimeId, heartratesample, heartratesampleUnitTimeId, gsrsamplerate, gsrsamplerateUnitTimeId, accelerometersamplerate, accelerometersamplerateUnitTimeId);

        //MessagesBox.jQueryShow(Page.ClientScript, this.GetType(), DBClass.GetMessageByCode2("edit_success"), "Edit message");
        //LoadInfo();
        //IsEdit(false);
        Response.Redirect("~/usertrackmyhealth_stress.aspx");
    }
    protected void btnCancel_Click(object sender, EventArgs e)
    {
        //IsEdit(false);
    }
}