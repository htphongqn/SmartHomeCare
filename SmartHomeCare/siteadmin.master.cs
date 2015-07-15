using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

public partial class siteadmin : System.Web.UI.MasterPage
{
    public static string username = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["User"] != null)
        {
            DataRow userrow = (DataRow)Session["User"];
            username = BaseView.GetStringFieldValue(userrow, "Username");
        }
    }
}
