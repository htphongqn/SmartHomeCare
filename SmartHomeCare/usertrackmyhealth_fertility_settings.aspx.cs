using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

public partial class usertrackmyhealth_fertility_settings : System.Web.UI.Page
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
            //LoadDropdown();
            LoadInfo();
        }
    }
    private void LoadInfo()
    {
        DataRow row = (DataRow)Session["User"];
        string username = BaseView.GetStringFieldValue(row, "Username");
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
        DataRow row = (DataRow)Session["User"];
        string username = BaseView.GetStringFieldValue(row, "Username");

        bool isinputtemperature = false;
        if (ddlinputtemperature.SelectedValue == "1")
            isinputtemperature = true;
         int autoId = (int)ViewState["AutoId"];
         _db.InsertUpdate_Fertility(autoId, username, isinputtemperature);
        
        //MessagesBox.jQueryShow(Page.ClientScript, this.GetType(), DBClass.GetMessageByCode2("edit_success"), "Edit message");
        //LoadInfo();
        //IsEdit(false);
        Response.Redirect("~/usertrackmyhealth_fertility.aspx");
    }
    protected void btnCancel_Click(object sender, EventArgs e)
    {
        //IsEdit(false);
    }
    protected void lblinks_Click(object sender, EventArgs e)
    {
        Session["Tab_Fertility"] = null;
        Session["Index"] = null;
        Response.Redirect("~/usertrackmyhealth_fertility.aspx");
    }
}