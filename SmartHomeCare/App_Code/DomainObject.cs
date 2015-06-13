using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/**
* \brief class interface of DataRecord
*/
public interface IDataRecord
{
}
/**
* \brief class interface of DomainObject
*/
public interface IDomainObject
{
    string Id { get; set; }
    string Name { get; set; }

    IDataRecord CreateDataRecord();
}
/**
* \brief class build property
*/
public class DomainObject : IDomainObject
{
    private string _Id;
    private string _Name;

    public string Id { get { return this._Id; } set { this._Id = value; } }
    public string Name { get { return this._Name; } set { this._Name = value; } }

    public IDataRecord CreateDataRecord() { throw new NotImplementedException(); }

    public static List<T> Combine<T>(params List<T>[] objs) where T : IDomainObject, new()
    {
        if (objs.Length == 0)
            return new List<T>();

        List<T> baseObjs = objs.SelectMany(p => p).GroupBy(p => p.Id).Select(p => p.First()).ToList();

        return baseObjs;
    }

    private static List<T> IntersectCore<T>(bool isExclusive, params List<T>[] objs) where T : IDomainObject, new()
    {
        if (objs.Length == 0)
            return new List<T>();

        List<T> baseObjs = null;

        foreach (List<T> nextList in objs)
        {
            if (baseObjs != null && (isExclusive || nextList.Count > 0))
            {
                baseObjs = baseObjs.Where(p => nextList.Select(o => o.Id).Contains(p.Id)).ToList();
            }
            else if (nextList.Count > 0 || isExclusive)
            {
                baseObjs = nextList;
            }
        }

        if (baseObjs == null)
            baseObjs = new List<T>();

        return baseObjs;
    }

    public static List<T> Intersect<T>(params List<T>[] objs) where T : IDomainObject, new()
    {
        return IntersectCore<T>(false, objs);
    }

    public static List<T> IntersectExclusive<T>(params List<T>[] objs) where T : IDomainObject, new()
    {
        return IntersectCore<T>(true, objs);
    }

}
/**
* \brief property default null
*/
public class NullObject : IDomainObject
{
    public string Id { get { return ""; } set { } }
    public string Name { get { return ""; } set { } }

    public IDataRecord CreateDataRecord() { return null; }
}
/**
* \brief create property
*/
public class Domain
{
    public static T Create<T>(string id, string name) where T : IDomainObject, new()
    {
        T obj = new T();
        obj.Id = id;
        obj.Name = name;
        return obj;
    }
}