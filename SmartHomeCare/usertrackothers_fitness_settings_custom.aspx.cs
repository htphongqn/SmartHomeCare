using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

public partial class usertrackothers_fitness_settings_custom : System.Web.UI.Page
{
    private DBClass _db = new DBClass();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["User"] == null)
        {
            Response.Redirect("~/home.aspx");
        } 
        if (Session["AuthorizedUser"] == null)
        {
            Response.Redirect("~/usertrackothers.aspx");
        }
        //siteuser _siteuser = (siteuser)this.Master;
        //TreeView treeview = _siteuser.treeview;
        //BaseView.SelectedTreeView(treeview, siteuser.REPORTS, siteuser.TRACKOTHERS);

        if (string.IsNullOrEmpty(Request.QueryString["Id"]))
        {
            Response.Redirect("~/usertrackothers_fitness_settings.aspx");
        }
        if (!IsPostBack)
        {
            DataRow rowcurrentuser = (DataRow)Session["AuthorizedUser"];
            lbNameHealth
                .Text = BaseView.GetStringFieldValue(rowcurrentuser, "FullName");
            ViewState["fitnessHRProgram"] = new DataTable();
            LoadInfo();
        }
    }
    private void LoadInfo()
    {
        int fitnessId = ToSQL.SQLToInt(Request.QueryString["Id"]);
        DataRow dr = _db.GetInfo_Fitness_HRExercise_Program_ByFitnessId(fitnessId);
        if (dr != null)
        {
            txtnumberofstages.Text = BaseView.GetStringFieldValue(dr, "NumberOfStage");
            txttransitionaudio.Text = BaseView.GetStringFieldValue(dr, "TransitionAudio");
            txtprogramname.Text = BaseView.GetStringFieldValue(dr, "ProgramName");
            int fitnessHRProgramId = BaseView.GetIntFieldValue(dr, "FitnessHRProgramId");
            DataTable dt = _db.GetInfo_Fitness_HRExercise_Program_ByFitnessHRProgramId(fitnessHRProgramId);
            ViewState["fitnessHRProgram"] = dt;
            //if (dt.Rows.Count > 0)
            //{
            //    tblfitnessprogram.Rows.Add(fitnessRowTitle());
            //    for (int i = 0; i < dt.Rows.Count; i++)
            //    {
            //        tblfitnessprogram.Rows.Add(fitnessRow(BaseView.GetStringFieldValue(dt.Rows[i], "Stage"), BaseView.GetIntFieldValue(dt.Rows[i], "ZoneId"), BaseView.GetStringFieldValue(dt.Rows[i], "TimeValue"), BaseView.GetIntFieldValue(dt.Rows[i], "TimeId")));
            //    }
            //}
        }
    }
    private TableRow fitnessRowTitle()
    {
        TableRow row = new TableRow();
        TableCell cell;

        cell = new TableCell();
        cell.Text = "Stage";
        row.Cells.Add(cell);

        cell = new TableCell();
        cell.Text = "Target HR";
        row.Cells.Add(cell);

        cell = new TableCell();
        cell.Text = "Time";
        row.Cells.Add(cell);

        return row;
    }
    private TableRow fitnessRow(string stage, int zoneId, string timeValue, int timeId)
    {
        TextBox txtStage = new TextBox();
        txtStage.Text = stage;
        txtStage.Width = 100;
        txtStage.CssClass = "form-control";

        DropDownList ddlZone = new DropDownList();
        ddlZone.DataTextField = "Name";
        ddlZone.DataValueField = "AutoId";
        ddlZone.CssClass = "form-control";
        ddlZone.Width = 80;
        BaseView.BindDataToDropdownList(ddlZone, _db.GetList_Fitness_ZoneType());
        BaseView.SelectDropdownItem(ddlZone, zoneId);

        TextBox txtTime = new TextBox();
        txtTime.Text = timeValue;
        txtTime.Width = 50;
        txtTime.CssClass = "form-control";
        txtTime.Attributes.Add("onKeyPress", "return digits(this, event, true, true);"); 

        DropDownList ddlTime = new DropDownList();
        ddlTime.DataTextField = "Name";
        ddlTime.DataValueField = "AutoId";
        ddlTime.CssClass = "form-control";
        ddlTime.Width = 60;
        BaseView.BindDataToDropdownList(ddlTime, _db.GetList_UnitTime());
        BaseView.SelectDropdownItem(ddlTime, timeId);

        TableRow row = new TableRow();
        TableCell cell;


        cell = new TableCell();
        cell.Controls.Add(txtStage);
        row.Cells.Add(cell);

        cell = new TableCell();
        cell.Controls.Add(ddlZone);
        row.Cells.Add(cell);

        cell = new TableCell();
        cell.Controls.Add(txtTime);
        cell.Controls.Add(ddlTime);
        row.Cells.Add(cell);

        return row;
    }
    protected void btnSave_Click(object sender, EventArgs e)
    {
        int fitnessId = ToSQL.SQLToInt(Request.QueryString["Id"]);
        DataRow rowcurrentuser = (DataRow)Session["AuthorizedUser"];
        string username = BaseView.GetStringFieldValue(rowcurrentuser, "Username");
        int fitnessHRProgramId = _db.InsertUpdate_Fitness_HRExercise_Program(fitnessId, username, ToSQL.SQLToInt(txtnumberofstages.Text), txtprogramname.Text, txttransitionaudio.Text);
        string stages = ""; string zoneIds = ""; string timeValues = ""; string timeIds = "";
        for (int i = 1; i < tblfitnessprogram.Rows.Count; i++)
        {
            TableRow item = tblfitnessprogram.Rows[i];
            TextBox txtStage = (TextBox)item.Cells[0].Controls[0];
            stages += txtStage.Text + ",";
            DropDownList ddlZone = (DropDownList)item.Cells[1].Controls[0];
            zoneIds += ddlZone.SelectedValue + ",";
            TextBox txtTime = (TextBox)item.Cells[2].Controls[0];
            timeValues += txtTime.Text + ",";
            DropDownList ddlTime = (DropDownList)item.Cells[2].Controls[1];
            timeIds += ddlTime.SelectedValue + ",";
        }
        _db.InsertUpdate_Fitness_HRExercise_Program_Details(fitnessHRProgramId, stages, zoneIds, timeValues, timeIds);
        //LoadInfo();
        Response.Redirect("~/usertrackothers_fitness_settings.aspx");
    }
    protected override void OnLoad(EventArgs e)
    {
        base.OnLoad(e);
        DataTable dt = (DataTable)ViewState["fitnessHRProgram"];
        tblfitnessprogram.Rows.Clear();
        int countRow = dt.Rows.Count;
        int numberofstages = ToSQL.SQLToInt(txtnumberofstages.Text.Trim());
        if (numberofstages > 0)
        {
            tblfitnessprogram.Rows.Add(fitnessRowTitle());
        }
        if (countRow == 0)
        {
            for (int i = 0; i < numberofstages; i++)
            {
                tblfitnessprogram.Rows.Add(fitnessRow("", 0, "", 0));
            }
        }
        else
        {
            if (numberofstages > countRow)
            {
                int balance = numberofstages - countRow;
                for (int i = 0; i < countRow; i++)
                {
                    tblfitnessprogram.Rows.Add(fitnessRow(BaseView.GetStringFieldValue(dt.Rows[i], "Stage"), BaseView.GetIntFieldValue(dt.Rows[i], "ZoneId"), BaseView.GetStringFieldValue(dt.Rows[i], "TimeValue"), BaseView.GetIntFieldValue(dt.Rows[i], "TimeId")));
                }
                for (int i = 0; i < balance; i++)
                {
                    tblfitnessprogram.Rows.Add(fitnessRow("", 0, "", 0));
                }
            }
            else
            {
                for (int i = 0; i < numberofstages; i++)
                {
                    tblfitnessprogram.Rows.Add(fitnessRow(BaseView.GetStringFieldValue(dt.Rows[i], "Stage"), BaseView.GetIntFieldValue(dt.Rows[i], "ZoneId"), BaseView.GetStringFieldValue(dt.Rows[i], "TimeValue"), BaseView.GetIntFieldValue(dt.Rows[i], "TimeId")));
                }
            }
        }
    }
    protected void txtnumberofstages_TextChanged(object sender, EventArgs e)
    {

    }
}