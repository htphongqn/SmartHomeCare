using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Script.Services;
public partial class gotohome : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    { 
       
        ClientScript.RegisterStartupScript(this.GetType(), "onload", "Clicked();", true);
         
        
    }
}