﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
public partial class usertrackothers_stress_settings : System.Web.UI.Page
{
    private DBClass _db = new DBClass();
    protected void Page_Load(object sender, EventArgs e)
    {
        //siteuser _siteuser = (siteuser)this.Master;
        //TreeView treeview = _siteuser.treeview;
        //BaseView.SelectedTreeView(treeview, siteuser.REPORTS, siteuser.TRACKOTHERS);

        if (Session["User"] == null)
        {
            Response.Redirect("~/home.aspx");
        } if (Session["AuthorizedUser"] == null)
        {
            Response.Redirect("~/usertrackothers.aspx");
        }
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
        DataRow rowcurrentuser = (DataRow)Session["AuthorizedUser"];
        string username = BaseView.GetStringFieldValue(rowcurrentuser, "Username");
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
        DataRow rowcurrentuser = (DataRow)Session["AuthorizedUser"];
        string username = BaseView.GetStringFieldValue(rowcurrentuser, "Username");

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
        Response.Redirect("~/usertrackothers_stress.aspx");
    }
    protected void btnCancel_Click(object sender, EventArgs e)
    {
        //IsEdit(false);
    }
}