using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;

/**
   * Day la public class
   * 
   * Mo ta class dung chung
   * @author  Ric Ly <ric.ly@mint-corpt.com>
       
  */
public partial class usertrackothers : System.Web.UI.Page
{
    DBClass _db = new DBClass();
    DataTable dt = new DataTable();
    protected void Page_Load(object sender, EventArgs e)
    {
        
        siteuser _siteuser = (siteuser)this.Master;
        TreeView treeview = _siteuser.treeview;                
        BaseView.SelectedTreeView(treeview, siteuser.REPORTS, siteuser.TRACKOTHERS);

        if (Session["User"] == null)
        {
            Response.Redirect("~/home.aspx");
        }
        if (!IsPostBack)
        {
            Session["AuthorizedUser"] = null;
            if (Session["User"] == null)
            { Response.Redirect("~/home.aspx"); }
            
            ShowData();
            
        }
        if (lstTracOther.Items.Count > 0)
        { DoubleClick(); }
      
    }

    private void Unitdt()
    {
        dt.Columns.Add("Username");
        dt.Columns.Add("FullName");
    }
    /**
     * [Short Description] Double click
     * 
     * [Details desription] Select user 
     * @author  Ric Ly <ric.ly@mint-corpt.com>
       
    */
    void DoubleClick()
    {
        if (Request["__EVENTARGUMENT"] != null && Request["__EVENTARGUMENT"] == "click")
        {
           Selected_AuthorizedUser();
            
        }
        lstTracOther.Attributes.Add("ondblclick", ClientScript.GetPostBackEventReference(lstTracOther, "click"));
        
    }
    /**
    * [Short Description] get user is selected
    * 
    * [Details desription] Get user is selected and go to page usertrackotherhealth.
    * @author  Ric Ly <ric.ly@mint-corpt.com>
       
   */
    private void Selected_AuthorizedUser()
    {
        if (lstTracOther.SelectedIndex == -1)
        {
            MessagesBox.jQueryShow(ClientScript, this.GetType(), DBClass.GetMessageByCode2("userauthoried_null"), "Messages Box");
            return;
        }
        Unitdt();
        DataRow AuthorizedUser = dt.NewRow();
        AuthorizedUser["Username"] = lstTracOther.SelectedItem.Value;
        AuthorizedUser["FullName"] = lstTracOther.SelectedItem.Text;
        if (AuthorizedUser != null)
        {
            Session["AuthorizedUser"] = AuthorizedUser;
            Response.Redirect("~/usertrackotherhealth.aspx");
        }
    }
    protected void btnglobalsettings_dbick(object sender, EventArgs e)
    {
        Selected_AuthorizedUser();
    }
    private void ShowData()
    {
        DataRow rowuser =(DataRow) Session["User"];
        dt = _db.GetList_UserTrackOthers(BaseView.GetStringFieldValue(rowuser, "Username"));
        ListItem item = new ListItem();
        foreach (DataRow row in dt.Rows)
        { 
            lstTracOther.Items.Add(new ListItem(row["FirstName"].ToString() + " " + row["Lastname"].ToString(), row["AuthorizedUser"].ToString()));
        }
        
    }
}   