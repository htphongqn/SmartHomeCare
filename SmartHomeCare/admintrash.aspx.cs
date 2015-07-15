using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
public partial class admintrash : System.Web.UI.Page
{
    DBClass _db = new DBClass();
    DataTable dt = new DataTable();
    int i = 0;
    static double s = 0.0;
    public string Ids = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        //siteadmin _siteuser = (siteadmin)this.Master;
        //TreeView treeview = _siteuser.treeview;
        //BaseView.SelectedTreeView(treeview, siteadmin.MESSAGECENTER, siteadmin.TRASH);

        if (!IsPostBack)
        {

            if (Session["User"] != null)
            {
                s = 0.0;
                LoadTrash(0);
                LoadAllIdsFromTrash();
                CountPageNext(0);
            }
            else
            {
                Response.Redirect("~/home.aspx");
            }

        }
    }
    /**
     * [Get ID] get all Id from trash.
     * */
    private void LoadAllIdsFromTrash()
    {
        Ids = "";
        if (grdTrash.Rows.Count > 0)
        {
            for (int i = 0; i < grdTrash.Rows.Count; i++)
            {
                CheckBox checkbox = (CheckBox)grdTrash.Rows[i].FindControl("chkSelected");
                Ids += Convert.ToString(checkbox.CssClass) + ",";

            }
        }
    }
    /**
     * [Load Message] load message in trash.
     * */
    void LoadTrash(int i)
    {
        DataRow row = (DataRow)Session["User"];
        if (row != null)
        {
            string UserName = BaseView.GetStringFieldValue(row, "UserName");
            DataTable dt = _db.GetList_MessageCenter_Trash("");
            grdTrash.PageIndex = i;
            grdTrash.DataSource = dt;
            grdTrash.DataBind();
        }
    }
    /**
     * [Get checkbox] get id messages checkbox selected.
     * */
    string GetCheckBox()
    {
        string id = "";
        for (int i = 0; i < grdTrash.Rows.Count; i++)
        {
            CheckBox checkbox = (CheckBox)grdTrash.Rows[i].FindControl("chkSelected");
            if (checkbox.Checked)
            {
                id += Convert.ToString(checkbox.CssClass) + ",";

            }
        }
        return id;
    }
    /**
     * [Delete] delete message trash.
     * */
    protected void btnDelete_Click(object sender, EventArgs e)
    {
        string Ids = "";
        GridViewRowCollection col = grdTrash.Rows;
        Ids = GetCheckBox();
        if (Ids == "")
        {
            string msg = DBClass.GetMessageByCode2("select_message_null");
            MessagesBox.jQueryShow(ClientScript,this.GetType(),msg,"Messages box");
        }
        else
        {
            _db.Delete_MessageCenter_Trash_ByIds(Ids);
            Response.Redirect("~/usertrash.aspx");
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
            DataRow row = (new DBClass()).Delete_MessageCenter_Trash_ByIds(IdDeletes);
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
    protected void LinkButton2_Click(object sender, EventArgs e)
    {
        if (grdTrash.PageIndex < grdTrash.PageCount - 1)
        {
            i = grdTrash.PageIndex;

            grdTrash.PageIndex = i++;

            LoadTrash(i);
            CountPageNext(i);
        }
    }

    protected void lbPre_Click(object sender, EventArgs e)
    {
        i = grdTrash.PageIndex;
        if (grdTrash.PageIndex > 0)
        {
            grdTrash.PageIndex = i--;

            LoadTrash(i);
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
            s = grdTrash.Rows.Count;
        }
        else
        {
            x = s + 1;
            s += grdTrash.Rows.Count;

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
            s = grdTrash.Rows.Count;
        }
        else
        {
            x = s + 1;
            s += grdTrash.Rows.Count;

        }
        lbCount.Text = "Messages " + x.ToString() + " - " + s.ToString();

    }
}