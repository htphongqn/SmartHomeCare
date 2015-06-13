using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class userreadmessage : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["User"] != null && Request.Params["MsgId"] != null)
        {
            
        }
        else
        {
            lblTitle.Text = "Error";
            ltrMessage.Text = "No Data";
        }
    }
   
}