using System;
using System.Collections.Generic;
using System.Text;
using System.Globalization;

/**
* \brief  convert data 
*/
public class ToSQL
{
    /**
     * convert object to string
     * @see EmptyNull()
     */
    public static string EmptyNull(object Obj)
    {
        try
        {
            return Obj.ToString().Trim();
        }
        catch
        { }
        return "";
    }
    /**
     * convert object to int
     * @see SQLToInt()
     */
    public static int SQLToInt(object Obj)
    {
        int i = 0;
        try
        {
            i = Convert.ToInt32(Obj);
        }
        catch
        { }
        return i;
    }
    /**
     * convert object to int
     * @see SQLToIntNull()
     */
    public static int? SQLToIntNull(object Obj)
    {
        int? i = null;
        if (SQLToInt(Obj) != 0)
            i = SQLToInt(Obj);
        return i;
    }
    /**
     * convert object to decimal
     * @see SQLToDecimal()
     */
    public static decimal SQLToDecimal(object Obj)
    {
        decimal i = 0;
        try
        {
            i = Convert.ToDecimal(Obj);
        }
        catch
        { }
        return i;
    }
    /**
     * convert object to decimal
     * @see SQLToDecimalNull()
     */
    public static decimal? SQLToDecimalNull(object Obj)
    {
        decimal? i = null;
        if (SQLToDecimal(Obj) != 0)
            i = SQLToDecimal(Obj);
        return i;
    }
    /**
     * convert object to double
     * @see SQLToDouble()
     */
    public static double SQLToDouble(object Obj)
    {
        double i = 0;
        try
        {
            i = Convert.ToDouble(Obj);
        }
        catch
        { }
        return i;
    }
    /**
     * convert object to bool
     * @see SQLToBool()
     */
    public static bool SQLToBool(object Obj)
    {
        bool i = false;
        try
        {
            i = Convert.ToBoolean(Obj);
        }
        catch
        { }
        return i;
    }
    /**
     * convert object to date
     * @see SQLToDateTime()
     */
    public static DateTime SQLToDateTime(object Obj)
    {
        try
        {   
            return Convert.ToDateTime(Obj);
        }
        catch(Exception x)
        {
            //MessagesBox.ShowF5(x.Message);
        }
        return DateTime.MinValue;
    }
    /**
     * check object is numberic
     * @see IsNumberic()
     */
    public static bool IsNumberic(object Obj)
    {
        bool b = false;
        try
        {
            double d = Convert.ToDouble(Obj);
            b = true;
        }
        catch
        { }
        return b;
    }
    /**
     * check object is date
     * @see IsDate()
     */
    public static bool IsDate(object Obj)
    {
        bool b = false;
        try
        {
            DateTime d = Convert.ToDateTime(Obj);
            b = true;
        }
        catch
        { }
        return b;
    }
    /**
     * convert object to string
     * @see SQLString()
     */
    public static string SQLString(object Obj)
    {
        string s = EmptyNull(Obj);
        if (s == "") return " NULL ";
        return " '" + s.Replace("'", "''") + "' ";
    }
    /**
     * convert object to string
     * @see SQLUString()
     */
    public static string SQLUString(object Obj)
    {
        string s = EmptyNull(Obj);
        if (s == "") return " NULL ";
        return " N'" + s.Replace("'", "''") + "' ";
    }
    /**
     * convert object to string
     * @see SQLLikeString()
     */
    public static string SQLLikeString(object Obj)
    {
        string s = EmptyNull(Obj);
        if (s == "") return " NULL ";
        return " N'%" + s.Replace("'", "''") + "%' ";
    }
    /**
     * convert object to string
     * @see SQLNumeric()
     */
    public static string SQLNumeric(object Obj)
    {
        if (IsNumberic(Obj))
        {
            return EmptyNull(Obj).Replace(",", "");
        }
        return " NULL ";
    }
    /**
     * convert object to string
     * @see SQLBit()
     */
    public static string SQLBit(object Obj)
    {
        string s = EmptyNull(Obj).ToUpper();
        if (s == "TRUE" || s == "1" || s == "YES") return " 1 ";
        return " 0 ";
    }
    /**
     * convert object to string
     * @see SQLBitNull()
     */
    public static string SQLBitNull(object Obj)
    {
        try
        {
            string s = EmptyNull(Obj.ToString().ToUpper());
            if (s == "TRUE" || s == "1" || s == "YES")
                return " 1 ";
        }
        catch { }
        return " 0 ";
    }
    /**
     * convert date to string
     * @see SQLDate()
     */
    public static string SQLDate(DateTime? Obj)
    {
        if (IsDate(Obj))
        {
            DateTime obj = Convert.ToDateTime(Obj);
            string s = " '" + obj.Year.ToString() + "/" + obj.Month.ToString() + "/" + obj.Day.ToString() + " ";
            s += obj.Hour.ToString() + ":" + obj.Minute.ToString() + ":" + obj.Second.ToString() + "' ";

            return s;
        }
        return " NULL ";
    }
    /**
     * convert string to date
     * @see SQLToDateTime24H()
     */
    public static DateTime SQLToDateTime24H(string Obj)
    {
        try
        {   string pattern = "0:MM/dd/yy H:mm:ss ";
            DateTime parsedDate;
            DateTime.TryParseExact(Obj, pattern, null,DateTimeStyles.None , out parsedDate);
            return parsedDate;
        }
        catch(Exception x)
        {
            //MessagesBox.ShowF5(x.Message);
        }
        return DateTime.MinValue;
    }
    /**
     * convert date to string
     * @see SQLDateNonHour()
     */
    public static string SQLDateNonHour(DateTime Obj)
    {
        if (IsDate(Obj))
        {
            Obj = Convert.ToDateTime(Obj);
            return " '" + Obj.Year.ToString() + "/" + Obj.Month.ToString() + "/" + Obj.Day.ToString() + "' ";
        }
        return " NULL ";
    }

}
