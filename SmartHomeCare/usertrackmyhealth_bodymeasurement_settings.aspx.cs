using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class usertrackmyhealth_bodymeasurement_settings : System.Web.UI.Page
{
    private DBClass _db = new DBClass();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["User"] == null)
        {
            Response.Redirect("~/home.aspx");
        }
        //siteuser _siteuser = (siteuser)this.Master;
        //TreeView treeview = _siteuser.treeview;
        //BaseView.SelectedTreeView(treeview, siteuser.REPORTS, siteuser.TRACKMYHEALTH);
        
        if (!IsPostBack)
        {
            ViewState["AutoId"] = 0;
            //IsEdit(false);
            LoadDropdown();
            LoadInfo();
            ChangeTextUnits();
        }
    }
    protected void lblinks_Click(object sender, EventArgs e)
    {
        Session["FromDateBody"] = null;
        Session["ToDateBody"] = null;
        Session["Tab_Body"] = null;
        Response.Redirect("~/usertrackmyhealth_bodymeasurement.aspx");
    }
    private void LoadDropdown()
    {
        BaseView.BindDataToDropdownList(ddliwmethod, _db.GetList_BodyIWType());
        BaseView.BindDataToDropdownList(ddlbfmethod, _db.GetList_BodyBFType());
        BaseView.BindDataToDropdownList(ddlfateval, _db.GetList_BodyFatEval());
        BaseView.BindDataToDropdownList(ddlbmrmethod, _db.GetList_BodyBMRType());
        BaseView.BindDataToDropdownList(ddlactivityfactor, _db.GetList_BodyActivityFactorType());
    }
    private void LoadInfo()
    {
        DataRow row = (DataRow)Session["User"];
        string username = BaseView.GetStringFieldValue(row, "Username");
        DataRow dr = _db.GetInfo_BodyMeasurement(username);
        if (dr != null)
        {
            ViewState["AutoId"] = BaseView.GetIntFieldValue(dr, "AutoId");
            //ddliwmethod.SelectedValue = BaseView.GetStringFieldValue(dr, "IWTypeId") == "" ? "0" : BaseView.GetStringFieldValue(dr, "IWTypeId");
            BaseView.SelectDropdownItem(ddliwmethod, BaseView.GetStringFieldValue(dr, "IWTypeId"));
            //lbiwmethod.Text = BaseView.GetStringFieldValue(dr, "IWTypeName");
            //ddlbfmethod.SelectedValue = BaseView.GetStringFieldValue(dr, "BFTypeId") == "" ? "0" : BaseView.GetStringFieldValue(dr, "BFTypeId");
            BaseView.SelectDropdownItem(ddlbfmethod, BaseView.GetStringFieldValue(dr, "BFTypeId"));
            //lbbfmethod.Text = BaseView.GetStringFieldValue(dr, "BFTypeName");
            //ddlfateval.SelectedValue = BaseView.GetStringFieldValue(dr, "FatEvalId") == "" ? "0" : BaseView.GetStringFieldValue(dr, "FatEvalId");
            BaseView.SelectDropdownItem(ddlfateval, BaseView.GetStringFieldValue(dr, "FatEvalId"));
            //lbfateval.Text = BaseView.GetStringFieldValue(dr, "FatEvalName");
            //ddlbmrmethod.SelectedValue = BaseView.GetStringFieldValue(dr, "BMRTypeId") == "" ? "0" : BaseView.GetStringFieldValue(dr, "BMRTypeId");
            BaseView.SelectDropdownItem(ddlbmrmethod, BaseView.GetStringFieldValue(dr, "BMRTypeId"));
            //lbbmrmethod.Text = BaseView.GetStringFieldValue(dr, "BMRTypeName");
            //ddlactivityfactor.SelectedValue = BaseView.GetStringFieldValue(dr, "ActivityFactorTypeId") == "" ? "0" : BaseView.GetStringFieldValue(dr, "ActivityFactorTypeId");
            BaseView.SelectDropdownItem(ddlactivityfactor, BaseView.GetStringFieldValue(dr, "ActivityFactorTypeId"));
            //lbactivityfactor.Text = BaseView.GetStringFieldValue(dr, "ActivityFactorTypeName");
           
            bool isUS = BaseView.GetBooleanFieldValue(dr, "isUS");
            if (isUS)
            {
                txtweight.Text = BaseView.GetStringFieldValue(dr, "Weight");
                //lbweight.Text = BaseView.GetStringFieldValue(dr, "Weight");
                txtheightfeet.Text = BaseView.GetStringFieldValue(dr, "HeightFeet");
                //lbheightfeet.Text = BaseView.GetStringFieldValue(dr, "HeightFeet");
                txtheight.Text = BaseView.GetStringFieldValue(dr, "HeightInch");
                //lbheight.Text = BaseView.GetStringFieldValue(dr, "HeightInch");
                txtwaist.Text = BaseView.GetStringFieldValue(dr, "Waist");
                //lbwaist.Text = BaseView.GetStringFieldValue(dr, "Waist");
                txthip.Text = BaseView.GetStringFieldValue(dr, "Hip");
                //lbhip.Text = BaseView.GetStringFieldValue(dr, "Hip");
                txtneck.Text = BaseView.GetStringFieldValue(dr, "Neck");
                //lbneck.Text = BaseView.GetStringFieldValue(dr, "Neck");
            }
            else
            {
                txtweight.Text = BaseView.GetStringFieldValue(dr, "Weight0");
                //lbweight.Text = BaseView.GetStringFieldValue(dr, "Weight0");
                txtheightfeet.Visible = false;
                //lbheightfeet.Visible = false;
                txtheight.Width = new Unit(220);
                txtheight.Text = BaseView.GetStringFieldValue(dr, "Height0");
                //lbheight.Text = BaseView.GetStringFieldValue(dr, "Height0");
                txtwaist.Text = BaseView.GetStringFieldValue(dr, "Waist0");
                //lbwaist.Text = BaseView.GetStringFieldValue(dr, "Waist0");
                txthip.Text = BaseView.GetStringFieldValue(dr, "Hip0");
                //lbhip.Text = BaseView.GetStringFieldValue(dr, "Hip0");
                txtneck.Text = BaseView.GetStringFieldValue(dr, "Neck0");
                //lbneck.Text = BaseView.GetStringFieldValue(dr, "Neck0");
            }
            
        }
        
    }
    private void ChangeTextUnits()
    {
        DataRow row = (DataRow)Session["User"];
        string username = BaseView.GetStringFieldValue(row, "Username");
        bool isUS = _db.Get_IsUS_UserTrackMyHealth_ByUserName(username);
        if (isUS)
        {
            lbweightunits.Text = "pound";
            lbheightunits.Text = "inches";
            lbheightfeetunits.Text = "feet";
            lbwaistunits.Text = "inches";
            lbhipunits.Text = "inches";
            lbneckunits.Text = "inches";
        }
        else
        {
            lbweightunits.Text = "kg";
            lbheightunits.Text = "cm";
            lbheightfeetunits.Text = "";
            lbwaistunits.Text = "cm";
            lbhipunits.Text = "cm";
            lbneckunits.Text = "cm";
        }
    }
    //private void IsEdit(bool s)
    //{
    //    ddliwmethod.Visible = s;
    //    lbiwmethod.Visible = !ddliwmethod.Visible;
    //    ddlbfmethod.Visible = s;
    //    lbbfmethod.Visible = !ddlbfmethod.Visible;
    //    ddlfateval.Visible = s;
    //    lbfateval.Visible = !ddlfateval.Visible;
    //    ddlbmrmethod.Visible = s;
    //    lbbmrmethod.Visible = !ddlbmrmethod.Visible;
    //    ddlactivityfactor.Visible = s;
    //    lbactivityfactor.Visible = !ddlactivityfactor.Visible;

    //    txtweight.Visible = s;
    //    lbweight.Visible = !txtweight.Visible;
    //    DataRow row = (DataRow)Session["User"];
    //    string username = BaseView.GetStringFieldValue(row, "Username");
    //    bool isUS = _db.Get_IsUS_UserTrackMyHealth_ByUserName(username);
    //    if (isUS)
    //    {
    //        txtheightfeet.Visible = s;
    //        lbheightfeet.Visible = !txtheightfeet.Visible;
    //    }
    //    else
    //    {
    //        txtheightfeet.Visible = false;
    //        lbheightfeet.Visible = false;
    //        txtheight.Width = new Unit(220);
    //    }
    //    txtheight.Visible = s;
    //    lbheight.Visible = !txtheight.Visible;
    //    txtwaist.Visible = s;
    //    lbwaist.Visible = !txtwaist.Visible;
    //    txthip.Visible = s;
    //    lbhip.Visible = !txthip.Visible;
    //    txtneck.Visible = s;
    //    lbneck.Visible = !txtneck.Visible;

    //    btnSave.Visible = s;
    //    btnCancel.Visible = s;
    //    btnEdit.Visible = !s;
    //    btnback.Visible = !s;
    //}
    protected void btnEdit_Click(object sender, EventArgs e)
    {
        //IsEdit(true);
    }
    protected void btnSave_Click(object sender, EventArgs e)
    {
        DataRow row = (DataRow)Session["User"];
        string username = BaseView.GetStringFieldValue(row, "Username");

        int? iwmethod = ToSQL.SQLToIntNull(ddliwmethod.SelectedValue);
        int? bfmethod = ToSQL.SQLToIntNull(ddlbfmethod.SelectedValue);
        int? fateval = ToSQL.SQLToIntNull(ddlfateval.SelectedValue);
        int? bmrmethod = ToSQL.SQLToIntNull(ddlbmrmethod.SelectedValue);
        int? activityfactor = ToSQL.SQLToIntNull(ddlactivityfactor.SelectedValue);

        decimal? weight = ToSQL.SQLToDecimalNull(txtweight.Text);
        decimal? heightfeet = ToSQL.SQLToDecimalNull(txtheightfeet.Text);
        decimal? height = ToSQL.SQLToDecimalNull(txtheight.Text);
        decimal? waist = ToSQL.SQLToDecimalNull(txtwaist.Text);
        decimal? hip = ToSQL.SQLToDecimalNull(txthip.Text);
        decimal? neck = ToSQL.SQLToDecimalNull(txtneck.Text);
        int autoId = (int)ViewState["AutoId"];
        bool isUS = _db.Get_IsUS_UserTrackMyHealth_ByUserName(username);
        if (isUS)
        {
            _db.InsertUpdate_BodyMeasurement_US(autoId, username, iwmethod, bfmethod, bmrmethod, fateval, activityfactor, weight, heightfeet, height, waist, hip, neck);
        }
        else
        {
            _db.InsertUpdate_BodyMeasurement_Metric(autoId, username, iwmethod, bfmethod, bmrmethod, fateval, activityfactor, weight, height, waist, hip, neck);
        }
        //MessagesBox.jQueryShow(Page.ClientScript, this.GetType(), DBClass.GetMessageByCode2("edit_success"), "Edit message");
        //LoadInfo();
        //IsEdit(false);
        Response.Redirect("~/usertrackmyhealth_bodymeasurement.aspx");
    }
    protected void btnCancel_Click(object sender, EventArgs e)
    {
        //IsEdit(false);
    }
}