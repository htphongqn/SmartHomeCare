using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
public partial class usertrackmyhealth : System.Web.UI.Page
{
    DBClass _db = new DBClass();
    DataTable dt = new DataTable();
    string Username = "";
    string AuthorizedUser = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        //siteuser _siteuser = (siteuser)this.Master;
        //TreeView treeview = _siteuser.treeview;
        //BaseView.SelectedTreeView(treeview, siteuser.REPORTS, siteuser.TRACKMYHEALTH);
        DataRow row = (DataRow)Session["User"];
        if (row == null)
            Response.Redirect("~/home.aspx");
        else
        {
            Username = row["username"].ToString();
            ClearSessionDateTimeAllPage();
        }
        if (!IsPostBack)
        {
            ShowData();
        }
        ClearSession();
    }
    private void ClearSession()
    {
        Session["FromDateBody"] = null;
        Session["ToDateBody"] = null;
        Session["Tab_Body"] = null;

        Session["Tab_Fertility"] = null;
        Session["Index"] = null;

        Session["IndexTab_Fitness"] = null;
        Session["FromDateFitness"] = null;
        Session["ToDateFitness"] = null;
        Session["Page_NoFitness2"] = null;
        Session["Page_NoFitness1"] = null;
        Session["PageIndex_Fitness"] = null;
        Session["PageIndex_Fitness2"] = null;
        Session["ActiveTab"] = null;

        Session["FromDateHeartRate"] = null;
        Session["ToDateHeartRate"] = null;
        Session["Page_NoHeartRate1"] = null;
        Session["Page_NoHeartRate2"] = null;
        Session["IndexTab_Heartrate"] = null;
        Session["HeartRateData"] = null;
        Session["PageIndex_HeartRate1"]=null;
        Session["PageIndex_HeartRate1"] = null;
        Session["HeartRateGraphData"] = null;

        Session["FromDateTemperature"] = null;
        Session["ToDateTemperature"] = null;
        Session["Page_Temp"] = null;
        Session["IndexTab_Temperture"] = null;
        Session["PageIndex_Temp"] = null;

        Session["PageIndex_SO2"] = null;
        Session["Page_NoSpO2"] = null;
        Session["IndexTab_SP"] = null;
        Session["FromDateSPO2"] = null;
        Session["ToDateSPO2"] = null;

        Session["IndexTab_Position"] = null;
        Session["PageSize_Position"] = null;
        Session["PageSize_Position2"] = null;
        Session["PageIndex_Position2"] = null;
        Session["PageIndex_Position"] = null;
        Session["DataRawTable"] = null;
        Session["DataRawGraph"] = null;
        Session["ToDatePosition"] = null;
        Session["FromDatePosition"] = null;

        Session["FromDateStress"] = null;
        Session["ToDateStress"] = null;
        Session["PageIndex_Stress"] = null;
        Session["PageIndex_Stress2"] = null;
        Session["PageSize_Stress"] = null;
        Session["PageSize_Stress2"] = null;
        Session["TabIndex_Stress"] = null;
        Session["DataRawTable_Stress"] = null;
        Session["RawGraph_Stress"] = null;

        Session["FromDateSleep"] = null;
        Session["ToDateSleep"] = null;
        Session["PageIndex_Sleep"] = null;
        Session["PageIndex_Sleep2"] = null;
        Session["PageSize_Sleep"] = null;
        Session["PageSize_Sleep2"] = null;
        Session["IndexTab_Sleep"] = null;
        Session["DataRawTable"] = null;
        Session["DataRawGraph"] = null;
    }
    private void ClearSessionDateTimeAllPage()
    {
        Session.Remove("FromDateBody");
        Session["FromDateBody"] = null;
        Session.Remove("ToDateBody");
        Session["ToDateBody"] = null;
        Session.Remove("ToDateStress");
        Session["ToDateStress"] = null;
        Session.Remove("FromDateStress");        
        Session["FromDateStress"] = null;
        Session.Remove("FromDateFitness");
        Session["FromDateFitness"] = null;
        Session.Remove("ToDateFitness");
        Session["ToDateFitness"] = null;
        Session.Remove("FromDateHeartRate");
        Session["FromDateHeartRate"] = null;
        Session.Remove("ToDateHeartRate");
        Session["ToDateHeartRate"] = null;
    }
    private void ShowData()
    {
        
            if (!String.IsNullOrEmpty(Request.QueryString["AuthorizedUser"]))
            {
                Username = Request.QueryString["AuthorizedUser"];
                dt = _db.GetInfo_UserAll_ByUserName(Username);

                if (dt.Rows.Count > 0)
                {
                    DataRow dr = dt.Rows[0];
                    lbNamehealth.Text = dr["Firstname"].ToString()+" " +dr["Lastname"].ToString();
                }
                else
                    lbNamehealth.Text = Username;
            }
       

    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        //Session["AuthorizedUser"] = null;
    }
    protected void btnglobalsettings_Click(object sender, EventArgs e)
    {
        if (!String.IsNullOrEmpty(Request.QueryString["AuthorizedUser"]))
        {
            AuthorizedUser = Request.QueryString["AuthorizedUser"];
        }
        if (AuthorizedUser != "")

            Response.Redirect("~/usertrackmyhealth_globalsetting.aspx?AuthorizedUser=" + AuthorizedUser);
        else

            Response.Redirect("~/usertrackmyhealth_globalsetting.aspx");
    }
    

    protected void ibtn_Click(object sender, ImageClickEventArgs e)
    {
            Response.Redirect("~/usertrackmyhealth_temperature.aspx");
    }
    protected void ImageButton1_Click(object sender, ImageClickEventArgs e)
    {

    }
}