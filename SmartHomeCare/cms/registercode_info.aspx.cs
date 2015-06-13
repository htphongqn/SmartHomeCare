using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
public partial class cms_registercode_info : System.Web.UI.Page
{
    DBClass _db = new DBClass();
    DataTable dt = new DataTable();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Load_RegisCode();
        }
    }
    protected void btnsave_Click(object sender, EventArgs e)
    {   string RegisterCode =txtRegisterCode.Text;
        if(RegisterCode != "")
        {
            _db.Set_RegisterCode_Using(RegisterCode);
            Response.Redirect("~/cms/register_code.aspx");
        }
        
    }
    void Load_RegisCode()
    {
        
        if (!String.IsNullOrEmpty(Request.QueryString["Code"]))
        {   
            //dt = _db.GetList_RegisterCodes(RuleCode);
            //if (dt.Rows.Count >0)
            //{
            //    DataRow row = dt.Rows[0];
                string RuleCode  = Request.QueryString["Code"];
                txtRegisterCode.Text = RuleCode;
                //string IsActive = row["IsUsing"].ToString();
                //if (IsActive == "0")
                //    chkIsActive.Checked = false;
                //txtRegisterCode.Enabled = false;
            //}
            
        }
        
    }
}