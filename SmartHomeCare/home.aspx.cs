using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Web.UI;
using System.Web.UI.WebControls;

/**
* Home class for login. 
 * 
 * Class nay duoc su dung de làm gì đó ai mà biết
*/

public partial class home : System.Web.UI.Page
{
    private DBClass _db = new DBClass();

    /**
    * @brief Hàm để load trang.
     * 
     * Hàm này duoc su dung de load trang web.
     * @param sender la mot cai j do
     * @param e la mot cai j khac nua
     * @return la mot hai ba bon nam
     * @see btnsignin_Click()
    */
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if (!string.IsNullOrEmpty(Request.QueryString["status"]))
            {
                if (ToSQL.EmptyNull(Request.QueryString["status"]) == "logout")
                {
                    Session["User"] = null;
                }
            }

            if (Request.QueryString.Count > 0)
            {
                if (!string.IsNullOrEmpty(Request.QueryString["w"]))
                {
                    bool b = _db.IsActive_User_ByWebCode(Convert.ToString(Request.QueryString["w"]));
                    if (!b)
                    {
                        Response.Redirect("urlinvalid.aspx");
                    }
                }
            }

            //lbcontent.Text = "Welcome...<br />Introduction...";

            if (Session["User"] != null)
            {
                DataRow row = (DataRow)Session["User"];
                LoginRedirect(row);
            }
        }
    }
    protected void btnsignin_Click(object sender, EventArgs e)
    {
        DataRow row = _db.Login_Website(txtusername.Text.Trim(), txtpassword.Text.Trim(),Security.GetClientIP());
        if (row != null)
        {
            if (Convert.ToBoolean(row["IsLoginOk"]))
            {
                Session["User"] = row;
                LoginRedirect(row);
            }
            else
            {
                if (BaseView.GetBooleanFieldValue(row, "IsDisableLogin"))
                {
                    //lbmessage.Text = BaseView.GetStringFieldValue(row, "NotesLogin");
                    MessagesBox.jQueryShow(Page.ClientScript, this.GetType(), BaseView.GetStringFieldValue(row, "NotesLogin"), "Notification message");
                }
                else
                {
                    //lbmessage.Text = "The username or password you entered is incorrect.<br />Please try again.";
                    string msg = DBClass.GetMessageByCode2("login_no_success");
                    MessagesBox.jQueryShow(Page.ClientScript, this.GetType(),msg, "Notification message");
                }
            }

        }
    }
    private void LoginRedirect(DataRow row)
    {
        if (BaseView.GetBooleanFieldValue(row, "IsAdminADM"))
        {
            Response.Redirect("adminusermanagement.aspx");
        }
        else
        {
            Response.Redirect("userhome.aspx");
        }
    }
    protected void lnkregister_Click(object sender, EventArgs e)
    {
        Response.Redirect("register.aspx");
    }
    protected void lnkfqas_Click(object sender, EventArgs e)
    {
        //lbcontent.Text = lnkfqas.Text;
    }
    protected void lnkprivacypolicy_Click(object sender, EventArgs e)
    {
        //lbcontent.Text = lnkprivacypolicy.Text;
    }
    protected void lnktermsandconditions_Click(object sender, EventArgs e)
    {
        //lbcontent.Text = lnktermsandconditions.Text;
    }
}