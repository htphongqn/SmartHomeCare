using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

public partial class usertrackothers_fertility_settings : System.Web.UI.Page
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
            lbcurrentuser.Text = BaseView.GetStringFieldValue(rowcurrentuser, "FullName");
            //IsEdit(false);
            //LoadDropdown();
            LoadInfo();
        }
    }
    private void LoadInfo()
    {
        DataRow rowcurrentuser = (DataRow)Session["AuthorizedUser"];
        string username = BaseView.GetStringFieldValue(rowcurrentuser, "Username");
        DataRow dr = _db.GetInfo_Fertility(username);
        if (dr != null)
        {
            ViewState["AutoId"] = BaseView.GetIntFieldValue(dr, "AutoId");
            ddlinputtemperature.SelectedValue = BaseView.GetBooleanFieldValue(dr, "IsInputAuto") == true ? "1" : "0";
            //lbinputtemperature.Text = BaseView.GetBooleanFieldValue(dr, "IsInputAuto") == true ? "Auto" : "Manual";
        }
    }
    //private void IsEdit(bool s)
    //{
    //    ddlinputtemperature.Visible = s;
    //    lbinputtemperature.Visible = !ddlinputtemperature.Visible;

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
        DataRow rowcurrentuser = (DataRow)Session["AuthorizedUser"];
        string username = BaseView.GetStringFieldValue(rowcurrentuser, "Username");

        bool isinputtemperature = false;
        if (ddlinputtemperature.SelectedValue == "1")
            isinputtemperature = true;

        int autoId = (int)ViewState["AutoId"];
        _db.InsertUpdate_Fertility(autoId, username, isinputtemperature);

        //MessagesBox.jQueryShow(Page.ClientScript, this.GetType(), DBClass.GetMessageByCode2("edit_success"), "Edit message");
        //LoadInfo();
        //IsEdit(false);
        Response.Redirect("~/usertrackothers_fertility.aspx");
    }
    protected void btnCancel_Click(object sender, EventArgs e)
    {
        //IsEdit(false);
    }
}