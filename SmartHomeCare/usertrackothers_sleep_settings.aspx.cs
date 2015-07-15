using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

public partial class usertrackothers_sleep_settings : System.Web.UI.Page
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
            ViewState["dtAlarm"] = new DataTable();
            ViewState["myCount"] = 0;
            //IsEdit(false);
            LoadDropdown();
            LoadInfo();
        }
        else
        {
            int myCount = (int)ViewState["myCount"];
            if (myCount < 7)
            {
                Control myControl = GetPostBackControl(this.Page);

                if ((myControl != null))
                {
                    if ((myControl.ID == btnaddalarm.ID))
                    {
                        myCount = myCount + 1;
                        ViewState["myCount"] = myCount;
                    }
                }
            }
            else
            {
                MessagesBox.jQueryShow(ClientScript, this.GetType(), "Alarm setting maximum : " + 7, "MessagesBox");
            }
        }
    }
    //private void IsEdit(bool s)
    //{
    //    ddlhrsamplerate.Visible = s; txthrsamplerate.Visible = s;
    //    lbhrsamplerate.Visible = !ddlhrsamplerate.Visible;
    //    ddlgsrsamplerate.Visible = s; txtgsrsamplerate.Visible = s;
    //    lbgsrsamplerate.Visible = !ddlgsrsamplerate.Visible;
    //    ddlaccsamplerate.Visible = s; txtaccsamplerate.Visible = s;
    //    lbaccsamplerate.Visible = !ddlaccsamplerate.Visible;
    //    ddlskinsamplerate.Visible = s; txtskinsamplerate.Visible = s;
    //    lbskinsamplerate.Visible = !ddlskinsamplerate.Visible;

    //    btnSave.Visible = s;
    //    btnCancel.Visible = s;
    //    btnEdit.Visible = !s;
    //    btnback.Visible = !s;
    //}
    private void LoadDropdown()
    {
        BaseView.BindDataToDropdownList(ddlhrsamplerate, _db.GetList_UnitTime());
        BaseView.BindDataToDropdownList(ddlgsrsamplerate, _db.GetList_UnitTime());
        BaseView.BindDataToDropdownList(ddlaccsamplerate, _db.GetList_UnitTime());
        BaseView.BindDataToDropdownList(ddlskinsamplerate, _db.GetList_UnitTime());

        BaseView.BindDataToDropdownList(ddlsleepduration, _db.GetList_UnitTime());
    }
    private void LoadInfo()
    {
        DataRow rowcurrentuser = (DataRow)Session["AuthorizedUser"];
        string username = BaseView.GetStringFieldValue(rowcurrentuser, "Username");
        DataRow dr = _db.GetInfo_Sleep(username);
        if (dr != null)
        {
            ViewState["AutoId"] = BaseView.GetIntFieldValue(dr, "AutoId");
            BaseView.SelectDropdownItem(ddlhrsamplerate, BaseView.GetStringFieldValue(dr, "HRSampleRateId"));
            txthrsamplerate.Text = BaseView.GetStringFieldValue(dr, "HRSampleRate");
            //lbhrsamplerate.Text = BaseView.GetStringFieldValue(dr, "HRSampleRateName");
            BaseView.SelectDropdownItem(ddlgsrsamplerate, BaseView.GetStringFieldValue(dr, "GSRSampleRateId"));
            txtgsrsamplerate.Text = BaseView.GetStringFieldValue(dr, "GSRSampleRate");
            //lbgsrsamplerate.Text = BaseView.GetStringFieldValue(dr, "GSRSampleRateName");
            BaseView.SelectDropdownItem(ddlaccsamplerate, BaseView.GetStringFieldValue(dr, "AccSampleRateId"));
            txtaccsamplerate.Text = BaseView.GetStringFieldValue(dr, "AccSampleRate");
            //lbaccsamplerate.Text = BaseView.GetStringFieldValue(dr, "AccSampleRateName");
            BaseView.SelectDropdownItem(ddlskinsamplerate, BaseView.GetStringFieldValue(dr, "SkinTempSampleRateId"));
            txtskinsamplerate.Text = BaseView.GetStringFieldValue(dr, "SkinTempSampleRate");
            //lbskinsamplerate.Text = BaseView.GetStringFieldValue(dr, "SkinTempSampleRateName");
            rdauto.Checked = BaseView.GetBooleanFieldValue(dr, "IsAutoSetting");
            rdmanual.Checked = !BaseView.GetBooleanFieldValue(dr, "IsAutoSetting");
            if (rdauto.Checked)
            {
                trauto.Visible = rdauto.Checked;
                txtsleepduration.Text = BaseView.GetStringFieldValue(dr, "SleepDuration");
                BaseView.SelectDropdownItem(ddlsleepduration, BaseView.GetStringFieldValue(dr, "SleepDurationId"));
            }
            else
            {
                trmanual.Visible = !rdauto.Checked;
                DataTable dt = _db.GetList_Sleep_Manual_BySleepId(BaseView.GetIntFieldValue(dr, "AutoId"));
                ViewState["dtAlarm"] = dt;
                ViewState["myCount"] = dt.Rows.Count;
            }
        }
    }
    protected void btnEdit_Click(object sender, EventArgs e)
    {
        //IsEdit(true);
    }
    protected void btnSave_Click(object sender, EventArgs e)
    {
        if (!rdauto.Checked && !rdmanual.Checked)
        {
            MessagesBox.jQueryShow(Page.ClientScript, this.GetType(), "Select alarm setting", "Message  Box");
            return;
        }
        DataRow rowcurrentuser = (DataRow)Session["AuthorizedUser"];
        string username = BaseView.GetStringFieldValue(rowcurrentuser, "Username");

        decimal? hrsamplerate = ToSQL.SQLToDecimalNull(txthrsamplerate.Text);
        int? hrsamplerateId = ToSQL.SQLToIntNull(ddlhrsamplerate.SelectedValue);
        decimal? gsrsamplerate = ToSQL.SQLToDecimalNull(txtgsrsamplerate.Text);
        int? gsrsamplerateId = ToSQL.SQLToIntNull(ddlgsrsamplerate.SelectedValue);
        decimal? accsamplerate = ToSQL.SQLToDecimalNull(txtaccsamplerate.Text);
        int? accsamplerateId = ToSQL.SQLToIntNull(ddlaccsamplerate.SelectedValue);
        decimal? skinsamplerate = ToSQL.SQLToDecimalNull(txtskinsamplerate.Text);
        int? skinsamplerateId = ToSQL.SQLToIntNull(ddlskinsamplerate.SelectedValue);

        decimal? sleepduration = null;
        int? sleepdurationId = null;
        if (rdauto.Checked)
        {
            sleepduration = ToSQL.SQLToDecimalNull(txtsleepduration.Text);
            sleepdurationId = ToSQL.SQLToIntNull(ddlsleepduration.SelectedValue);
        }
        int autoId = (int)ViewState["AutoId"];
        int sleepId = _db.InsertUpdate_Sleep(autoId, username, hrsamplerate, hrsamplerateId, gsrsamplerate, gsrsamplerateId, accsamplerate, accsamplerateId, skinsamplerate, skinsamplerateId, rdauto.Checked, sleepduration, sleepdurationId);
        if (sleepId != 0 && rdmanual.Checked)
        {
            string names = ""; string weekIds = ""; string timeValues = ""; string timeIds = "";
            for (int i = 0; i < tblalarms.Rows.Count; i++)
            {
                TableRow item = tblalarms.Rows[i];
                TextBox txtName = (TextBox)item.Cells[0].Controls[0];
                names += txtName.Text + ",";
                DropDownList ddlWeek = (DropDownList)item.Cells[1].Controls[0];
                weekIds += ddlWeek.SelectedValue + ",";
                TextBox txtTime = (TextBox)item.Cells[2].Controls[0];
                timeValues += txtTime.Text + ",";
                DropDownList ddlTime = (DropDownList)item.Cells[2].Controls[1];
                timeIds += ddlTime.SelectedValue + ",";
            }
            _db.InsertUpdate_Sleep_Manual(sleepId, names, weekIds, timeValues, timeIds);
        }
        //MessagesBox.jQueryShow(Page.ClientScript, this.GetType(), DBClass.GetMessageByCode2("edit_success"), "Edit message");
        //LoadInfo();
        //IsEdit(false);
        //btnSave.Enabled = false;
        //btnSave.ForeColor = System.Drawing.ColorTranslator.FromHtml("#999999");
        Response.Redirect("~/usertrackothers_sleep.aspx");
    }
    protected void btnCancel_Click(object sender, EventArgs e)
    {
        //IsEdit(false);
    }
    protected void rdauto_CheckedChanged(object sender, EventArgs e)
    {
        trauto.Visible = rdauto.Checked;
        trmanual.Visible = !rdauto.Checked;

        btnSave.Enabled = true;
        btnSave.ForeColor = System.Drawing.Color.White;
    }
    protected void rdmanual_CheckedChanged(object sender, EventArgs e)
    {
        trauto.Visible = rdauto.Checked;
        trmanual.Visible = !rdauto.Checked;

        btnSave.Enabled = true;
        btnSave.ForeColor = System.Drawing.Color.White;
    }
    private TableRow alarmRow(string name, int weekId, string timeValue, int timeId)
    {
        TextBox txtName = new TextBox();
        txtName.Text = name;
        txtName.Width = 100;

        DropDownList ddlWeek = new DropDownList();
        ddlWeek.DataTextField = "Name";
        ddlWeek.DataValueField = "AutoId";
        BaseView.BindDataToDropdownList(ddlWeek, _db.GetList_UnitDate());
        BaseView.SelectDropdownItem(ddlWeek, weekId);

        TextBox txtTime = new TextBox();
        txtTime.Text = timeValue;
        txtTime.Width = 50;
        txtTime.Attributes.Add("onKeyPress", "return digits(this, event, true, true);");

        DropDownList ddlTime = new DropDownList();
        ddlTime.DataTextField = "Name";
        ddlTime.DataValueField = "AutoId";
        BaseView.BindDataToDropdownList(ddlTime, _db.GetList_UnitTime());
        BaseView.SelectDropdownItem(ddlTime, timeId);

        TableRow row = new TableRow();
        TableCell cell;


        cell = new TableCell();
        cell.Controls.Add(txtName);
        row.Cells.Add(cell);

        cell = new TableCell();
        cell.Controls.Add(ddlWeek);
        row.Cells.Add(cell);

        cell = new TableCell();
        cell.Controls.Add(txtTime);
        cell.Controls.Add(ddlTime);
        row.Cells.Add(cell);

        return row;
    }
    protected override void OnLoad(EventArgs e)
    {
        base.OnLoad(e);
        DataTable dt = (DataTable)ViewState["dtAlarm"];
        tblalarms.Rows.Clear();
        int rowCount = dt.Rows.Count;
        int myCount = (int)ViewState["myCount"];
        if (myCount == 0 && rowCount != 0)
        {
            myCount = rowCount;
        }
        if (rowCount == 0)
        {
            for (int i = 0; i < myCount; i++)
            {
                tblalarms.Rows.Add(alarmRow("", 0, "", 0));
            }
        }
        else
        {
            if (myCount > rowCount)
            {
                int balance = myCount - rowCount;
                for (int i = 0; i < rowCount; i++)
                {
                    tblalarms.Rows.Add(alarmRow(BaseView.GetStringFieldValue(dt.Rows[i], "Name"), BaseView.GetIntFieldValue(dt.Rows[i], "UnitDateId"), BaseView.GetStringFieldValue(dt.Rows[i], "UnitTimeValue"), BaseView.GetIntFieldValue(dt.Rows[i], "UnitTimeId")));
                }
                for (int i = 0; i < balance; i++)
                {
                    tblalarms.Rows.Add(alarmRow("", 0, "", 0));
                }
            }
            else
            {
                for (int i = 0; i < myCount; i++)
                {
                    tblalarms.Rows.Add(alarmRow(BaseView.GetStringFieldValue(dt.Rows[i], "Name"), BaseView.GetIntFieldValue(dt.Rows[i], "UnitDateId"), BaseView.GetStringFieldValue(dt.Rows[i], "UnitTimeValue"), BaseView.GetIntFieldValue(dt.Rows[i], "UnitTimeId")));
                }
            }
        }
    }
    private Control GetPostBackControl(Page thePage)
    {
        Control myControl = null;
        string ctrlName = thePage.Request.Params.Get("__EVENTTARGET");
        if (((ctrlName != null) & (ctrlName != string.Empty)))
        {
            myControl = ((ContentPlaceHolder)thePage.Master.Master.FindControl("main")).Page.FindControl(ctrlName);
        }
        else
        {
            foreach (string Item in thePage.Request.Form)
            {
                Control c = ((ContentPlaceHolder)thePage.Master.Master.FindControl("main")).Page.FindControl(Item);
                if (((c) is System.Web.UI.WebControls.Button))
                {
                    myControl = c;
                }
            }
        }
        return myControl;
    }
    protected void btnaddalarm_Click(object sender, EventArgs e)
    {
        btnSave.Enabled = true;
        btnSave.ForeColor = System.Drawing.Color.White;
    }
}