using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class site : System.Web.UI.MasterPage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["User"] != null)
        {
            DataRow userrow = (DataRow)Session["User"];
            lbInfo.Text = "Welcome, " + BaseView.GetStringFieldValue(userrow, "FirstName") + "! <br /><a href='home.aspx?status=logout'>LOGOUT</a>";
        }
    }
}
