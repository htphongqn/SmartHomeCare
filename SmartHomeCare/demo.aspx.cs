using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
public partial class demo : System.Web.UI.Page
{
    private DBClass _db = new DBClass();
    protected void Page_Load(object sender, EventArgs e)
    {
        loaddata();
    }
    private void loaddata()
    {
        DataSet ds = _db.GetList_BodyMeasurement_Datatable("tuan.nguyen", null,null);
        int width =0;
        string table = "";
        for (int i = 0; i < ds.Tables.Count; i++)
        {   
            DataTable dt = ds.Tables[i];
            string date = dt.Rows[0][2].ToString();
            table += "<table style='float:left;width:320px'>";
                table += "<tr>";
                    table += "<th>Value</th>";
                    table += "<th>Diagnose</th>";
                table += "</tr>";
            table += "<tr>";
            table += "<td class='value_body'>" + date + "</td>";
            table += "<td>...</td>";
            table += "</tr>";
            for (int j = 0; j < dt.Rows.Count; j++)
            {
                string value = dt.Rows[j]["Value"].ToString();
                string diagnose = dt.Rows[j]["Diagnose"].ToString();
                table += "<tr>";
                table += "<td class='value_body'>" + value + "</td>";
                table += "<td>"+ diagnose +"</td>";
                table += "</tr>";
            }
            table += "</table>";
            width += 320;
        }
        string tables = "<div class='data_main' style='width:" + width.ToString() + "px'>" +table +" </div>";
        //MessagesBox.ShowF5(tables);
        ld_data.Text = tables;
    }
}