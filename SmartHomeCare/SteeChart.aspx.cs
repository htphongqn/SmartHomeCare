﻿using System;
using System.Collections;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Web;
using System.Web.SessionState;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;
using Steema.TeeChart.Styles;
using System.IO;
using Steema.TeeChart.Web;

public partial class SteeChart : System.Web.UI.Page
{
    private int clickedX;
    private int clickedY;
    private string msgText;

    protected void Page_Load(object sender, EventArgs e)
    {
        clickedX = -1;
        clickedY = -1;
        msgText = "";
        // Put user code to initialize the page here
        // ****************************************************
        // The data load code for WebChart1 demostrates a technique to save 
        // data between page calls. The Chart is saved as a TeeChart template 
        // to a session variable.
        // ****************************************************
        Steema.TeeChart.Chart ch1 = WebChart1.Chart;
        MemoryStream tmpChart = new MemoryStream();

        if (Session["ch1"] == null)
        {
            //setup Chart
            if (ch1.Series.Count < 2)
            {
                ch1.Series.Add(new Steema.TeeChart.Styles.Points());
                ch1.Series.Add(new Steema.TeeChart.Styles.Points());
            }


            if (ch1.Tools.Count < 1)
            {
                ch1.Tools.Add(new Steema.TeeChart.Tools.ZoomTool());
                ch1.Tools.Add(new Steema.TeeChart.Tools.SeriesHotspot());
            }

            ((Steema.TeeChart.Tools.ZoomTool)ch1.Tools[0]).ZoomPenColor = Color.OliveDrab;
            ((Steema.TeeChart.Tools.SeriesHotspot)ch1.Tools[1]).Style = MarksStyles.LabelPercentTotal;
            ((Points)ch1.Series[0]).Pointer.Pen.Visible = false;
            ((Points)ch1.Series[0]).Pointer.HorizSize = 2;
            ((Points)ch1.Series[0]).Pointer.VertSize = 2;
            ((Points)ch1.Series[1]).Pointer.Pen.Color = Color.FromArgb(79, 79, 255);
            ((Points)ch1.Series[1]).Pointer.HorizSize = 2;
            ((Points)ch1.Series[1]).Pointer.VertSize = 2;

            ch1.Series[0].Color = Color.FromArgb(255, 199, 26);
            ch1.Series[1].Color = Color.FromArgb(106, 106, 255);

            ch1.Series[0].FillSampleValues(300);
            ch1.Series[1].FillSampleValues(300);
            //export Chart to a MemoryStream template
            ch1.Export.Template.Save(tmpChart);
            //save template to a Session variable
            Session.Add("ch1", tmpChart);
        }
        else
        {
            //retrieve the session stored Chart
            tmpChart = (MemoryStream)Session["ch1"];
            //set the Stream position to 0 as the last read/write
            //will have moved the position to the end of the stream
            tmpChart.Position = 0;
            //import saved Chart
            WebChart1.Chart.Import.Template.Load(tmpChart);

            //check whether zoom request is being sent
            CheckZoom(WebChart1);
        }
    }

    private void CheckZoom(WebChart wChart)
    {
        ArrayList zoomedState = (ArrayList)Session[wChart.ID + "Zoomed"];
        zoomedState = ((Steema.TeeChart.Tools.ZoomTool)wChart.Chart.Tools[0]).SetCurrentZoom(Request,
           zoomedState);
        if (zoomedState == null)
            Session.Remove(wChart.ID + "Zoomed");
        else
            Session.Add(wChart.ID + "Zoomed", zoomedState);
    }
    protected void DropDownList1_SelectedIndexChanged(object sender, EventArgs e)
    {
        //WebChart1.Chart.Series.RemoveAllSeries();
        
        //WebChart1.Chart.Series[0].FillSampleValues();
    }
    protected void WebChart1_GetAxisLabel(object sender, Steema.TeeChart.GetAxisLabelEventArgs e)
    {
        //if ((Steema.TeeChart.Axis)sender == WebChart1.Chart.Axes.Bottom)
        //{
        //    switch (e.LabelText.Substring(e.LabelText.Length - 1, 1))
        //    {
        //        case "0": e.LabelText = "init. 0"; break;
        //        case "1": e.LabelText = e.LabelText + "st"; break;
        //        case "2": e.LabelText = e.LabelText + "nd"; break;
        //        case "3": e.LabelText = e.LabelText + "rd"; break;
        //        default: e.LabelText = e.LabelText + "th"; break;
        //    }
        //}
    }
    protected void WebChart1_ClickAxis(object sender, ImageClickEventArgs e)
    {
        Steema.TeeChart.Axis axis = (Steema.TeeChart.Axis)sender;
        clickedX = e.X;
        clickedY = e.Y;
        double axisValue = 0;
        if (axis.Horizontal)
            axisValue = ((Steema.TeeChart.Axis)sender).CalcPosPoint(clickedX);
        else
            axisValue = ((Steema.TeeChart.Axis)sender).CalcPosPoint(clickedY);
        msgText = "Clicked Axis at:" + "\n\rValue: " + axisValue.ToString("#.00");
    }
    protected void WebChart1_AfterDraw(object sender, Steema.TeeChart.Drawing.Graphics3D g)
    {
        if (clickedX != -1)
        {
            g.Font.Color = Color.Maroon;
            g.TextOut(clickedX, clickedY, msgText);
        }      
    }
    protected void WebChart1_ClickSeries(object sender, Series s, int valueIndex, EventArgs e)
    {
        Steema.TeeChart.Chart tChart = ((WebChart)sender).Chart;

        clickedX = s.CalcXPos(valueIndex);
        clickedY = s.CalcYPos(valueIndex);
        msgText = "Clicked Series: " + tChart.Series.IndexOf(s).ToString() + "\n\rValue: " + s.YValues[valueIndex].ToString("#0.00");
    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        MessagesBox.jQueryShow(ClientScript, this.GetType(), TextBox1.Text, "Date");
    }
}