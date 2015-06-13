using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Web.UI;
using System.IO;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;
using System.Web.Security;
using System.Text;
using System.Web.SessionState;

/**
 * \brief data processing , display on website
 */
public class BaseView
{
    
    public static void PrintWebControl(Control ctrl)
    {
        PrintWebControl(ctrl, string.Empty);
    }

    public static void PrintWebControl(Control ctrl, string Script)
    {
        StringWriter stringWrite = new StringWriter();
        System.Web.UI.HtmlTextWriter htmlWrite = new System.Web.UI.HtmlTextWriter(stringWrite);
        if (ctrl is WebControl)
        {
            Unit w = new Unit(100, UnitType.Percentage); ((WebControl)ctrl).Width = w;
        }
        Page pg = new Page();
        pg.EnableEventValidation = false;
        if (Script != string.Empty)
        {
            pg.ClientScript.RegisterStartupScript(pg.GetType(), "PrintJavaScript", Script);
        }
        HtmlForm frm = new HtmlForm();
        pg.Controls.Add(frm);
        frm.Attributes.Add("runat", "server");
        frm.Controls.Add(ctrl);
        pg.DesignerInitialize();
        pg.RenderControl(htmlWrite);
        string strHTML = stringWrite.ToString();
        HttpContext.Current.Response.Clear();
        HttpContext.Current.Response.Write(strHTML);
        HttpContext.Current.Response.Write("<script>window.print();</script>");
        HttpContext.Current.Response.End();
    }
    
    /**
     * select index event handler directory tree ( left menu )
     * @see SelectedTreeView()
     * @param tree control treeview of C#
     * @param parentnodeindex node parent of node selected
     * @param nodeindex node selected
     */
    public static void SelectedTreeView(TreeView tree,int parentnodeindex,int nodeindex = -1)
    {
        tree.Nodes[parentnodeindex].Expand();
        if (nodeindex != -1)
        {
            if (tree.Nodes[parentnodeindex].ChildNodes.Count > nodeindex)
            {
                tree.Nodes[parentnodeindex].ChildNodes[nodeindex].Selected = true;
            }
            else
            {
                tree.Nodes[parentnodeindex].ChildNodes[0].Selected = true;
            }
        }
        else
        {
            tree.Nodes[parentnodeindex].Selected = true;
        }
    }

    /**
     * bind data to dropdownlist
     * @see BindDataToDropdownList()
     * @param list control dropDownList of C#
     * @param data dataTable is source of dropdownlist
     * @param hasNone object(value: true or false) true: add dropdownlist 1 row none,false no add
     */
    public static void BindDataToDropdownList(DropDownList list, DataTable data, bool hasNone = true)
    {
        list.DataSource = data;
        list.DataBind();

        if (hasNone)
        {
            AddBlankDropdownItem(list, "0");
        }
    }
    /**
     * add 1 row to dropdownlist
     * @see AddBlankDropdownItem()
     * @param list control dropDownList of C#
     * @param value is dropdownlist
     */
    public static void AddBlankDropdownItem(DropDownList list, string value = "")
    {
        if (list.Items.FindByValue(value) != null)
        {
            list.Items.Remove(new ListItem("", value));
        }
        list.Items.Insert(0, new ListItem("", value));
    }
    /**
     * add 1 row to dropdownlist
     * @see AddBlankDropdownItem()
     * @param list control dropDownList of C#
     * @param text is dropdownlist
     * @param value is dropdownlist
     */
    public static void AddBlankDropdownItem(DropDownList list, string text, string value)
    {
        if (list.Items.FindByValue(value) != null)
        {
            list.Items.Remove(new ListItem(text, value));
        }
        list.Items.Insert(0, new ListItem(text, value));
    }
    /**
     * bind data to listbox
     * @see BindDataToListBox()
     * @param list control ListBox of C#
     * @param data dataTable is source of ListBox
     */
    public static void BindDataToListBox(ListBox list, DataTable data)
    {
        list.DataSource = data;
        list.DataBind();
    }
    /**
     * selected item of dropdownlist = object input
     * @see SelectDropdownItem()
     * @param list control DropDownList of C#
     * @param obj is value input
     */
    public static void SelectDropdownItem(DropDownList list, object obj)
    {
        string value = (obj != DBNull.Value ? Convert.ToString(obj) : "");

        ListItem item = list.Items.FindByValue(value);
        if (item != null)
        {
            item.Selected = true;
        }
    }
    /**
     * selected item of dropdownlist = object input
     * @see SelectDropdownItem()
     * @param list control DropDownList of C#
     * @param obj is value input
     */
    public static void SelectDropdownItem(DropDownList list, string obj)
    {
        string value = (obj != "" ? obj : "0");

        ListItem item = list.Items.FindByValue(value);
        if (item != null)
        {
            item.Selected = true;
        }
    }
    /**
     * selected item of dropdownlist = object input
     * @see SelectDropdownItem()
     * @param list control DropDownList of C#
     * @param obj is value input
     */
    public static bool SelectDropdownItem(DropDownList list, object obj, object enable)
    {
        SelectDropdownItem(list, obj);
        list.Enabled = (enable != DBNull.Value ? Convert.ToBoolean(enable) : false);
        return list.Enabled;
    }
    /**
     * check file is image
     * @see CheckImageFileType()
     * @param fileName is name image
     */
    public static bool CheckImageFileType(string fileName)
    {
        string ext = Path.GetExtension(fileName);

        switch (ext.ToLower())
        {
            case ".gif":
                return true;

            case ".png":
                return true;

            case ".jpg":
                return true;

            case ".jpeg":
                return true;

            default:
                return false;
        }
    }
    /**
     * convert text content from format html to text 
     * @see Html2Text()
     * @param value is text content
     */
    public static string Html2Text(string value)
    {
        return value.Replace("<br />", "\r");
    }
    /**
     * convert text content from format text to html 
     * @see Text2Html()
     * @param value is text content
     */
    public static string Text2Html(string value)
    {
        return value.Replace("\r", "<br />");
    }
    /**
     * get value in datarow with column name
     * @param row is datarow or datarowview 
     * @param FieldName column name
     */
    #region DataView

    public static object GetFieldValue(DataRowView row, string FieldName)
    {
        return (row.Row.Table.Columns.Contains(FieldName) ? row[FieldName] : null);
    }
    public static string GetStringFieldValue(DataRowView row, string FieldName)
    {
        return (row.Row.Table.Columns.Contains(FieldName) && row[FieldName] != DBNull.Value ? Convert.ToString(row[FieldName]) : "");
    }
    public static int GetIntFieldValue(DataRowView row, string FieldName)
    {
        return (row.Row.Table.Columns.Contains(FieldName) && row[FieldName] != DBNull.Value ? Convert.ToInt32(row[FieldName]) : 0);
    }
    public static float GetFloatFieldValue(DataRowView row, string FieldName)
    {
        return (row.Row.Table.Columns.Contains(FieldName) && row[FieldName] != DBNull.Value ? Convert.ToSingle(row[FieldName]) : 0);
    }
    public static bool GetBooleanFieldValue(DataRowView row, string FieldName)
    {
        return (row.Row.Table.Columns.Contains(FieldName) && row[FieldName] != DBNull.Value ? Convert.ToBoolean(row[FieldName]) : false);
    }
    public static DateTime GetDateTimeFieldValue(DataRowView row, string FieldName)
    {
        return (row.Row.Table.Columns.Contains(FieldName) && row[FieldName] != DBNull.Value ? Convert.ToDateTime(row[FieldName]) : DateTime.MinValue);
    }

    public static object GetFieldValue(DataRow row, string FieldName)
    {
        return (row.Table.Columns.Contains(FieldName) ? row[FieldName] : null);
    }
    public static string GetStringFieldValue(DataRow row, string FieldName)
    {
        return (row.Table.Columns.Contains(FieldName) && row[FieldName] != DBNull.Value ? Convert.ToString(row[FieldName]) : "");
    }
    public static int GetIntFieldValue(DataRow row, string FieldName)
    {
        return (row.Table.Columns.Contains(FieldName) && row[FieldName] != DBNull.Value ? Convert.ToInt32(row[FieldName]) : 0);
    }
    public static float GetFloatFieldValue(DataRow row, string FieldName)
    {
        return (row.Table.Columns.Contains(FieldName) && row[FieldName] != DBNull.Value ? Convert.ToSingle(row[FieldName]) : 0);
    }
    public static bool GetBooleanFieldValue(DataRow row, string FieldName)
    {
        return (row.Table.Columns.Contains(FieldName) && row[FieldName] != DBNull.Value ? Convert.ToBoolean(row[FieldName]) : false);
    }
    public static DateTime GetDateTimeFieldValue(DataRow row, string FieldName)
    {
        return (row.Table.Columns.Contains(FieldName) && row[FieldName] != DBNull.Value ? Convert.ToDateTime(row[FieldName]) : DateTime.MinValue);
    }
    #endregion
   
}