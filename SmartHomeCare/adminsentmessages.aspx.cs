using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
public partial class adminsentmessages : System.Web.UI.Page
{
    private DBClass _db = new DBClass();
    int i = 0;
    static double s = 0.0;
    protected void Page_Load(object sender, EventArgs e)
    {

        if (!IsPostBack)
        {
            siteadmin _siteadmin = (siteadmin)this.Master;
            TreeView treeview = _siteadmin.treeview;
            BaseView.SelectedTreeView(treeview, siteadmin.MESSAGECENTER, siteadmin.SENTMESSAGES);
            if (Session["User"] != null)
            {
                s = 0.0;
                LoadSentMessage(0);
                CountPageNext(0);
            }
            else
            {
                Response.Redirect("~/home.aspx");
            }
        }
    }

    

    private void LoadSentMessage(int i)
    {
        DataRow row = (DataRow)Session["User"];
        if (row != null)
        {
            string UserName = BaseView.GetStringFieldValue(row, "UserName");
            DataTable dt = _db.GetList_MessageCenter_Sent("");
            grvSentBox.PageIndex = i;
            grvSentBox.DataSource = dt;
            grvSentBox.DataBind();
        }
    }
    string GetCheckBox()
    {
        string id = "";
        for (int i = 0; i < grvSentBox.Rows.Count; i++)
        {
            CheckBox checkbox = (CheckBox)grvSentBox.Rows[i].FindControl("chkSelected");
            if (checkbox.Checked)
            {
                id += Convert.ToString(checkbox.CssClass) + ",";

            }
        }
        return id;
    }
    protected void btndelete_Click(object sender, EventArgs e)
    {
        string Ids = "";
        GridViewRowCollection col = grvSentBox.Rows;
        Ids = GetCheckBox();
        if (Ids == "")
        {
            string msg = DBClass.GetMessageByCode2("select_message_null");
            MessagesBox.jQueryShow(ClientScript, this.GetType(), msg, "Messages box");
        }
        else
        {
            _db.Delete_MessageCenter_ByIds(Ids); ;
            Response.Redirect("~/usersentmessages.aspx");
        }


    }
    protected void LinkButton2_Click(object sender, EventArgs e)
    {


        if (grvSentBox.PageIndex < grvSentBox.PageCount - 1)
        {
            i = grvSentBox.PageIndex;

            grvSentBox.PageIndex = i++;

            LoadSentMessage(i);
            CountPageNext(i);
        }
    }

    protected void lbPre_Click(object sender, EventArgs e)
    {
        i = grvSentBox.PageIndex;
        if (grvSentBox.PageIndex > 0)
        {
            grvSentBox.PageIndex = i--;

            LoadSentMessage(i);
            CountPageBack(i);
        }

    }

    void CountPageNext(int a)
    {
        double x = a;
        if (a == 0)
        {
            x = 1;
            s = grvSentBox.Rows.Count;
        }
        else
        {
            x = s + 1;
            s += grvSentBox.Rows.Count;

        }
        lbCount.Text = "Messages " + x.ToString() + " - " + s.ToString();

    }
    void CountPageBack(int a)
    {
        double x = a;
        if (a == 0)
        {
            x = 1;
            s = grvSentBox.Rows.Count;
        }
        else
        {
            x = s + 1;
            s += grvSentBox.Rows.Count;

        }
        lbCount.Text = "Messages " + x.ToString() + " - " + s.ToString();

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

    //EmptyTrashService
    [System.Web.Services.WebMethod]
    public static object EmptyTrashService(object args)
    {
        Dictionary<string, object> values = (Dictionary<string, object>)((object[])args)[0];
        string Ids = values["Ids"].ToString();
        if (!string.IsNullOrEmpty(Ids) && Ids != "")
        {
            (new DBClass()).Delete_MessageCenter_Trash_ByIds(Ids);
            return 1;
        }
        return 0;
    }

    #endregion
    protected void btnEmpty_Click(object sender, EventArgs e)
    {
        //MessagesBox.jQueryShow(ClientScript, this.GetType(), "Thanh cong", "box");

    }
}