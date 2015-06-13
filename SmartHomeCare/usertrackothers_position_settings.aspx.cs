using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
public partial class usertrackothers_position_settings : System.Web.UI.Page
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

    //    btnSave.Visible = s;
    //    btnCancel.Visible = s;
    //    btnEdit.Visible = !s;
    //    btnback.Visible = !s;
    //}
    private void LoadDropdown()
    {
        BaseView.BindDataToDropdownList(ddlsamplerate, _db.GetList_UnitTime());
    }
    private void LoadInfo()
    {
        DataRow rowcurrentuser = (DataRow)Session["AuthorizedUser"];
        string username = BaseView.GetStringFieldValue(rowcurrentuser, "Username");
        DataRow dr = _db.GetInfo_Position(username);
        if (dr != null)
        {
            ViewState["AutoId"] = BaseView.GetIntFieldValue(dr, "AutoId");
            BaseView.SelectDropdownItem(ddlsamplerate, BaseView.GetStringFieldValue(dr, "SampleRateId"));
            txtsamplerate.Text = BaseView.GetStringFieldValue(dr, "SampleRate");
            //lbsamplerate.Text = BaseView.GetStringFieldValue(dr, "SampleRateName");
            chkSupine.Checked = BaseView.GetBooleanFieldValue(dr, "IsSupine");
            chkProne.Checked = BaseView.GetBooleanFieldValue(dr, "IsProne");
            chkLeftLateral.Checked = BaseView.GetBooleanFieldValue(dr, "IsLeft");
            chkRightLateral.Checked = BaseView.GetBooleanFieldValue(dr, "IsRight");
            chkUp.Checked = BaseView.GetBooleanFieldValue(dr, "IsUp");
            chkDown.Checked = BaseView.GetBooleanFieldValue(dr, "IsDown");
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
        int autoId = (int)ViewState["AutoId"];
        _db.InsertUpdate_Position(autoId, username, samplerate, samplerateId, chkSupine.Checked, chkProne.Checked, chkLeftLateral.Checked, chkRightLateral.Checked, chkUp.Checked, chkDown.Checked);

        //MessagesBox.jQueryShow(Page.ClientScript, this.GetType(), DBClass.GetMessageByCode2("edit_success"), "Edit message");
        //LoadInfo();
        //IsEdit(false);
        Response.Redirect("~/usertrackothers_position.aspx");
    }
    protected void btnCancel_Click(object sender, EventArgs e)
    {
        //IsEdit(false);
    }
}