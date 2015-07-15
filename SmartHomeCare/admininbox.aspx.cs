using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
public partial class admininbox : System.Web.UI.Page
{
    private DBClass _db = new DBClass();
    DataTable dt = new DataTable();
    int i = 0;
    static double s = 0.0;

    protected void Page_Load(object sender, EventArgs e)
    {

        if (!IsPostBack)
        {
            //siteadmin _siteuser = (siteadmin)this.Master;
            //TreeView treeview = _siteuser.treeview;
            //BaseView.SelectedTreeView(treeview, siteadmin.MESSAGECENTER, siteadmin.INBOX);
            if (Session["User"] != null)
            {
                s = 0.0;
                LoadInboxUser(0);
                CountPageNext(0);
            }
            else
            {
                Response.Redirect("~/home.aspx");
            }
        }
    }
    /**
     * [Get Id Messages] get checked id from gridview 
     * */
    string GetCheckBox()
    {
        string id = "";
        for (int i = 0; i < grvInbox.Rows.Count; i++)
        {
            CheckBox checkbox = (CheckBox)grvInbox.Rows[i].FindControl("chkSelected");
            if (checkbox.Checked)
            {
                id += Convert.ToString(checkbox.CssClass) + ",";

            }
        }
        return id;
    }
    /**
     * [Delete] delete message checked.
     * */
    protected void btndelete_Click(object sender, EventArgs e)
    {
        string Ids = "";
        GridViewRowCollection col = grvInbox.Rows;
        Ids = GetCheckBox();
        if (Ids == "")
        {
            string msg = DBClass.GetMessageByCode2("select_message_null");
            MessagesBox.jQueryShow(ClientScript, this.GetType(), msg, "Messages box");
        }
        else
        {
            _db.Delete_MessageCenter_ByIds(Ids);
            Response.Redirect("userinbox.aspx");
        }


    }
    private void LoadInboxUser(int i)
    {
        DataRow row = (DataRow)Session["User"];
        if (row != null)
        {
            string UserName = BaseView.GetStringFieldValue(row, "UserName");
            dt = _db.GetList_MessageCenter_Inbox("");
            grvInbox.PageIndex = i;
            grvInbox.DataSource = dt;
            grvInbox.DataBind();
        }
    }

    #region web method

    [System.Web.Services.WebMethod]
    public static object ReadMessage(int id)
    {
        DataRow row = (new DBClass()).GetInfo_MessageCenter_ById(id);
        if (row != null)
        {
            Dictionary<string, string> values = new Dictionary<string, string>();
            values.Add("id", BaseView.GetStringFieldValue(row, "AutoId"));
            values.Add("title", BaseView.GetStringFieldValue(row, "MsgSubject"));
            values.Add("message", BaseView.GetStringFieldValue(row, "MsgMessage"));
            return values;
        }
        Dictionary<string, string> error = new Dictionary<string, string>();
        error.Add("error", "0");
        return error;
    }

    [System.Web.Services.WebMethod]
    public static object DeleteMessage(object args)
    {
        Dictionary<string, object> values = (Dictionary<string, object>)((object[])args)[0];
        string IdDeletes = values["Ids"].ToString();
        if (!string.IsNullOrEmpty(IdDeletes) && IdDeletes != "")
        {
            DataRow row = (new DBClass()).Delete_MessageCenter_ByIds(IdDeletes);
            return 1;
        }
        return 0;
    }

    #endregion
    protected void LinkButton2_Click(object sender, EventArgs e)
    {


        if (grvInbox.PageIndex < grvInbox.PageCount - 1)
        {
            i = grvInbox.PageIndex;

            grvInbox.PageIndex = i++;

            LoadInboxUser(i);
            CountPageNext(i);
        }
    }

    protected void lbPre_Click(object sender, EventArgs e)
    {
        i = grvInbox.PageIndex;
        if (grvInbox.PageIndex > 0)
        {
            grvInbox.PageIndex = i--;

            LoadInboxUser(i);
            CountPageBack(i);
        }

    }
    /**
     * [CountPageNext] get page number if next
     * */
    void CountPageNext(int a)
    {
        double x = a;
        if (a == 0)
        {
            x = 1;
            s = grvInbox.Rows.Count;
        }
        else
        {
            x = s + 1;
            s += grvInbox.Rows.Count;

        }
        lbCount.Text = "Messages " + x.ToString() + " - " + s.ToString();

    }
    /**
     * [CountPageBack] get page number if back
     * */
    void CountPageBack(int a)
    {
        double x = a;
        if (a == 0)
        {
            x = 1;
            s = grvInbox.Rows.Count;
        }
        else
        {
            x = s + 1;
            s += grvInbox.Rows.Count;

        }
        lbCount.Text = "Messages " + x.ToString() + " - " + s.ToString();

    }
}