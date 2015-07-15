using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
public partial class usertrackothers_fitness_settings : System.Web.UI.Page
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

            btnSave.Enabled = false;
            btnSave.ForeColor = System.Drawing.ColorTranslator.FromHtml("#999999");
        }
    }
    //private void IsEdit(bool s)
    //{
    //    ddlexercisemode.Visible = s;
    //    lbexercisemode.Visible = !ddlexercisemode.Visible;
    //    ddltargethr.Visible = s;
    //    lbtargethr.Visible = !ddltargethr.Visible;
    //    ddltargetsetting.Visible = s;
    //    lbtargetsetting.Visible = !ddltargetsetting.Visible;
    //    ddlremindsetting.Visible = s;
    //    lbremindsetting.Visible = !ddlremindsetting.Visible;
    //    ddlcaloryburn.Visible = s;
    //    lbcaloryburn.Visible = !ddlcaloryburn.Visible;

    //    btnSave.Visible = s;
    //    btnCancel.Visible = s;
    //    btnEdit.Visible = !s;
    //    btnback.Visible = !s;
    //}
    private void LoadDropdown()
    {
        BaseView.BindDataToDropdownList(ddlexercisemode, _db.GetList_Fitness_HRExerciseType());
        //BaseView.BindDataToDropdownList(ddltargethr, _db.GetList_Fitness_HRTargetType());
        BaseView.BindDataToDropdownList(ddltargetsetting, _db.GetList_Fitness_PMTargetType());
        BaseView.BindDataToDropdownList(ddlremindsetting, _db.GetList_Fitness_PMRemindType());
        BaseView.BindDataToDropdownList(ddlcaloryburn, _db.GetList_Fitness_PMCaloryBurnType());
    }
    private void LoadInfo()
    {
        DataRow rowcurrentuser = (DataRow)Session["AuthorizedUser"];
        string username = BaseView.GetStringFieldValue(rowcurrentuser, "Username");
        DataRow dr = _db.GetInfo_Fitness(username);
        if (dr != null)
        {
            ViewState["AutoId"] = BaseView.GetIntFieldValue(dr, "AutoId");
            //ddlexercisemode.SelectedValue = BaseView.GetStringFieldValue(dr, "HRExerciseId") == "" ? "0" : BaseView.GetStringFieldValue(dr, "HRExerciseId");
            BaseView.SelectDropdownItem(ddlexercisemode, BaseView.GetStringFieldValue(dr, "HRExerciseId"));
            //lbexercisemode.Text = BaseView.GetStringFieldValue(dr, "HRExerciseName");
            //ddltargethr.SelectedValue = BaseView.GetStringFieldValue(dr, "HRTargetId") == "" ? "0" : BaseView.GetStringFieldValue(dr, "HRTargetId");
            if (ddlexercisemode.SelectedValue == "1")
            {
                BaseView.BindDataToDropdownList(ddltargethr, _db.GetList_Fitness_HRTargetType_Single());
                hplcustom.Enabled = false;
            }
            else if (ddlexercisemode.SelectedValue == "2")
            {
                BaseView.BindDataToDropdownList(ddltargethr, _db.GetList_Fitness_HRTargetType_Mutil());
                hplcustom.Enabled = true;
            }
            else
            {
                hplcustom.Enabled = false;
            }
            BaseView.SelectDropdownItem(ddltargethr, BaseView.GetStringFieldValue(dr, "HRTargetId"));
            //lbtargethr.Text = BaseView.GetStringFieldValue(dr, "HRTargetName");
            hplcustom.Text = BaseView.GetStringFieldValue(dr, "ProgramName") == "" ? "Click here to customize" : BaseView.GetStringFieldValue(dr, "ProgramName");
            hplcustom.NavigateUrl = "usertrackothers_fitness_settings_custom.aspx?Id=" + BaseView.GetStringFieldValue(dr, "FitnessId");            
            //ddltargetsetting.SelectedValue = BaseView.GetStringFieldValue(dr, "PMTargetId") == "" ? "0" : BaseView.GetStringFieldValue(dr, "PMTargetId");
            BaseView.SelectDropdownItem(ddltargetsetting, BaseView.GetStringFieldValue(dr, "PMTargetId"));
            //lbtargetsetting.Text = BaseView.GetStringFieldValue(dr, "HighRestHRName");
            //ddlremindsetting.SelectedValue = BaseView.GetStringFieldValue(dr, "PMRemindId") == "" ? "0" : BaseView.GetStringFieldValue(dr, "PMRemindId");
            BaseView.SelectDropdownItem(ddlremindsetting, BaseView.GetStringFieldValue(dr, "PMRemindId"));
            //lbremindsetting.Text = BaseView.GetStringFieldValue(dr, "PMRemindName");
            //ddlcaloryburn.SelectedValue = BaseView.GetStringFieldValue(dr, "PMCaloryBurnId") == "" ? "0" : BaseView.GetStringFieldValue(dr, "PMCaloryBurnId");
            BaseView.SelectDropdownItem(ddlcaloryburn, BaseView.GetStringFieldValue(dr, "PMCaloryBurnId"));
            //lbcaloryburn.Text = BaseView.GetStringFieldValue(dr, "PMCaloryBurnName");
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

        int? exercisemode = ToSQL.SQLToIntNull(ddlexercisemode.SelectedValue);
        int? targethr = ToSQL.SQLToIntNull(ddltargethr.SelectedValue);
        int? targetsetting = ToSQL.SQLToIntNull(ddltargetsetting.SelectedValue);
        int? remindsetting = ToSQL.SQLToIntNull(ddlremindsetting.SelectedValue);
        int? caloryburn = ToSQL.SQLToIntNull(ddlcaloryburn.SelectedValue);

        int autoId = (int)ViewState["AutoId"];
        _db.InsertUpdate_Fitness(autoId, username, exercisemode, targethr, targetsetting, remindsetting, caloryburn);

        //MessagesBox.jQueryShow(Page.ClientScript, this.GetType(), DBClass.GetMessageByCode2("edit_success"), "Edit message");
        //LoadInfo();
        //IsEdit(false);
        //btnSave.Enabled = false;
        //btnSave.ForeColor = System.Drawing.ColorTranslator.FromHtml("#999999");
        Response.Redirect("~/usertrackothers_fitness.aspx");
    }
    protected void btnCancel_Click(object sender, EventArgs e)
    {
        //IsEdit(false);
    }
    protected void ddlexercisemode_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddlexercisemode.SelectedValue == "1")
        {
            BaseView.BindDataToDropdownList(ddltargethr, _db.GetList_Fitness_HRTargetType_Single());
        }
        else if (ddlexercisemode.SelectedValue == "2")
        {
            BaseView.BindDataToDropdownList(ddltargethr, _db.GetList_Fitness_HRTargetType_Mutil());
        }
        else
        {
            BaseView.BindDataToDropdownList(ddltargethr, null);
        }
        btnSave.Enabled = true;
        btnSave.ForeColor = System.Drawing.Color.White;
    }
}