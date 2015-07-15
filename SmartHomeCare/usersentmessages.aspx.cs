using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

public partial class usersentmessages : System.Web.UI.Page
{
    private DBClass _db = new DBClass();
    int i = 0;
    static double s = 0.0;
    protected void Page_Load(object sender, EventArgs e)
    {
        
        if (!IsPostBack)
        {
            //siteuser _siteuser = (siteuser)this.Master;
            //TreeView treeview = _siteuser.treeview;
            //BaseView.SelectedTreeView(treeview, siteuser.MESSAGECENTER, siteuser.SENTMESSAGES);
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
            DataTable dt = _db.GetList_MessageCenter_Sent(UserName);
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
            MessagesBox.jQueryShow(ClientScript, this.GetType(), msg, "Messages Box");
        }
        else
        {
            _db.Delete_MessageCenter_ByIds(Ids);;
            Response.Redirect("~/usersentmessages.aspx");
        }
      
        
    }
    protected void LinkButton2_Click(object sender, EventArgs e)
    {
        Next();
    }

    protected void lbPre_Click(object sender, EventArgs e)
    {
        Back();
    }
    private void Back()
    {
        i = grvSentBox.PageIndex;
        if (grvSentBox.PageIndex > 0)
        {
            grvSentBox.PageIndex = i--;

            LoadSentMessage(i);
            CountPageBack(i);
        }
        else
        {
            MessagesBox.jQueryShow(ClientScript, this.GetType(), "This is the first page", "Notification");
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
    protected void LinkButton2_Click(object sender, ImageClickEventArgs e)
    {
        Next();
    }
    private void Next()
    {
        if (grvSentBox.PageIndex < grvSentBox.PageCount - 1)
        {
            i = grvSentBox.PageIndex;

            grvSentBox.PageIndex = i++;

            LoadSentMessage(i);
            CountPageNext(i);
        }
        else
        {
            MessagesBox.jQueryShow(ClientScript, this.GetType(), "This is the last page", "Notification");
        }
    }
}