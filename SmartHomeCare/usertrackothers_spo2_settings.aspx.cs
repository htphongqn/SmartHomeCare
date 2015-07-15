using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

public partial class usertrackothers_spo2_settings : System.Web.UI.Page
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
        }
    }
    //private void IsEdit(bool s)
    //{
    //    ddlsamplerate.Visible = s; txtsamplerate.Visible = s;
    //    lbsamplerate.Visible = !ddlsamplerate.Visible;
    //    ddltrackingmode.Visible = s;
    //    lbtrackingmode.Visible = !ddltrackingmode.Visible;
    //    ddlmeasurementduration.Visible = s; txtmeasurementduration.Visible = s;
    //    lbmeasurementduration.Visible = !ddlmeasurementduration.Visible;

    //    btnSave.Visible = s;
    //    btnCancel.Visible = s;
    //    btnEdit.Visible = !s;
    //    btnback.Visible = !s;
    //}
    private void LoadDropdown()
    {
        BaseView.BindDataToDropdownList(ddlsamplerate, _db.GetList_UnitTime());
        BaseView.BindDataToDropdownList(ddltrackingmode, _db.GetList_SpO2_TrackingModeType());
        BaseView.BindDataToDropdownList(ddlmeasurementduration, _db.GetList_UnitTime());
    }
    private void LoadInfo()
    {
        DataRow rowcurrentuser = (DataRow)Session["AuthorizedUser"];
        string username = BaseView.GetStringFieldValue(rowcurrentuser, "Username");
        DataRow dr = _db.GetInfo_SpO2(username);
        if (dr != null)
        {
            ViewState["AutoId"] = BaseView.GetIntFieldValue(dr, "AutoId");
            BaseView.SelectDropdownItem(ddlsamplerate, BaseView.GetStringFieldValue(dr, "SampleRateId"));
            txtsamplerate.Text = BaseView.GetStringFieldValue(dr, "SampleRate");
            //lbsamplerate.Text = BaseView.GetStringFieldValue(dr, "SampleRateName");
            BaseView.SelectDropdownItem(ddltrackingmode, BaseView.GetStringFieldValue(dr, "TrackingTypeId"));
            //lbtrackingmode.Text = BaseView.GetStringFieldValue(dr, "TrackingModeName");
            lbwarningthreshold.Text = BaseView.GetStringFieldValue(dr, "Threshold");
            BaseView.SelectDropdownItem(ddlmeasurementduration, BaseView.GetStringFieldValue(dr, "MeasurementId"));
            txtmeasurementduration.Text = BaseView.GetStringFieldValue(dr, "MeasurementValue");
            //lbmeasurementduration.Text = BaseView.GetStringFieldValue(dr, "MeasurementName");
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

        decimal? samplerate = ToSQL.SQLToDecimalNull(txtsamplerate.Text);
        int? samplerateId = ToSQL.SQLToIntNull(ddlsamplerate.SelectedValue);
        int? trackingmode = ToSQL.SQLToIntNull(ddltrackingmode.SelectedValue);
        decimal? warningthreshold = ToSQL.SQLToDecimalNull(lbwarningthreshold.Text);
        decimal? measurementduration = ToSQL.SQLToDecimalNull(txtmeasurementduration.Text);
        int? measurementdurationId = ToSQL.SQLToIntNull(ddlmeasurementduration.SelectedValue);

        int autoId = (int)ViewState["AutoId"];
        _db.InsertUpdate_SpO2(autoId, username, samplerate, samplerateId, trackingmode, warningthreshold, measurementduration, measurementdurationId);

        //MessagesBox.jQueryShow(Page.ClientScript, this.GetType(), DBClass.GetMessageByCode2("edit_success"), "Edit message");
        //LoadInfo();
        //IsEdit(false);
        //btnSave.Enabled = false;
        //btnSave.ForeColor = System.Drawing.ColorTranslator.FromHtml("#999999");
        Response.Redirect("~/usertrackothers_spo2.aspx");
    }
    protected void btnCancel_Click(object sender, EventArgs e)
    {
        //IsEdit(false);
    }
    protected void ddltrackingmode_SelectedIndexChanged(object sender, EventArgs e)
    {
        DataRow dr = _db.GetInfo_SpO2_TrackingModeType(ToSQL.SQLToInt(ddltrackingmode.SelectedValue));
        if (dr != null)
        {
            lbwarningthreshold.Text = BaseView.GetStringFieldValue(dr, "Threshold");
        }
        else
        {
            lbwarningthreshold.Text = "";
        }
        btnSave.Enabled = true;
        btnSave.ForeColor = System.Drawing.Color.White;
    }
}