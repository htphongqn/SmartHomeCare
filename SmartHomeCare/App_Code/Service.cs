using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Xml;
using System.Xml.Serialization;

/**
* \brief  convert data for webservice
*/
public class Service : System.Web.Services.WebService
{
    private static Service servInstance = new Service();
    /**
     * convert object to XmlDocument
     * @see CreateSerializedObject()
     */
    public static XmlDocument CreateSerializedObject(object obj)
    {
        return servInstance.SerializeObjects(obj);
    }
    /**
     * convert object to XmlDocument
     * @see SerializeObject()
     */
    protected XmlDocument SerializeObject(object obj)
    {
        return this.SerializeObjects(obj);
    }
    /**
     * convert object array to XmlDocument
     * @see SerializeObjects()
     */
    protected XmlDocument SerializeObjects(params object[] objs)
    {
        var detailDocument = new XmlDocument();
        var detailDocument2 = new XmlDocument();

        try
        {
            // Serialise to the XML document

            var nav = detailDocument.CreateNavigator();

            var rootNode2 = detailDocument2.AppendChild(detailDocument2.CreateNode(XmlNodeType.Element, "ServiceResponse", ""));

            //nav.MoveToFirstChild();

            foreach (object obj in objs)
            {
                if (obj != null && obj.GetType() == typeof(Dictionary<string, List<DomainObject>>))
                {
                    Dictionary<string, List<DomainObject>> dict = (Dictionary<string, List<DomainObject>>)obj;

                    foreach (KeyValuePair<string, List<DomainObject>> kpv in dict)
                    {

                        detailDocument2 = this.AddObjectToDocument(detailDocument2, kpv.Key, kpv.Value);
                    }
                    //detailDocument.AppendChild(detailDocument.CreateNode(XmlNodeType.Element, kpv.Key, kpv.Value));*/
                }
                else
                    this.AddObjectToDocument(obj, nav);
            }

            // Memorise and remove the element we want

            if (detailDocument.DocumentElement != null)
            {
                XmlNode newNode = detailDocument2.ImportNode(detailDocument.FirstChild, true);
                detailDocument2.FirstChild.AppendChild(newNode);
            }

            /*XmlNode infoNode = detailDocument.FirstChild;
            if (infoNode != null)
                detailDocument.RemoveChild(infoNode);

            // Move into a root <detail> element
            //var rootNode2 = detailDocument.AppendChild(detailDocument.CreateNode(XmlNodeType.Element, "ServiceResponse", ""));
            if (infoNode != null)
                rootNode2.AppendChild(infoNode);*/

        }
        catch (NotSupportedException ex)
        {
            throw ex; // new Exception(ex.InnerException.Message);
        }

        return detailDocument2;
    }
    /**
     * add node to XmlDocument
     * @see AddObjectToDocument()
     * @param nodeName is key node
     * @param obj is value node
     */
    protected XmlDocument AddObjectToDocument(XmlDocument document, string nodeName, object obj)
    {
        var detailDocument = new XmlDocument();

        try
        {
            // Serialise to the XML document

            var nav = detailDocument.CreateNavigator();

            if (nav != null)
            {
                using (XmlWriter writer = nav.AppendChild())
                {
                    var ser = new XmlSerializer(obj.GetType());
                    ser.Serialize(writer, obj);

                }
            }

            XmlNode newNode = document.ImportNode(detailDocument.DocumentElement, true);
            newNode = this.RenameNode(newNode, "", nodeName);

            if (document.FirstChild != null)
                document.FirstChild.AppendChild(newNode);
            else
                document.AppendChild(newNode);
        }
        catch (NotSupportedException ex)
        {
            throw ex; // new Exception(ex.InnerException.Message);
        }

        return document;
    }
    /**
     * add node to XmlDocument
     * @see AddObjectToDocument()
     * @param nodeName is key node
     * @param obj is value node
     */
    private void AddObjectToDocument(object obj, System.Xml.XPath.XPathNavigator nav)
    {
        if (obj != null && nav != null)
        {
            using (XmlWriter writer = nav.AppendChild())
            {
                var ser = new XmlSerializer(obj.GetType());
                ser.Serialize(writer, obj);
            }
        }
    }
    /**
     * rename node of XmlDocument
     * @see RenameNode()
     * @param node need rename
     * @param qualifiedName is value new node
     */
    public XmlNode RenameNode(XmlNode node, string namespaceURI, string qualifiedName)
    {
        if (node.NodeType == XmlNodeType.Element)
        {
            XmlElement oldElement = (XmlElement)node;
            XmlElement newElement =
            node.OwnerDocument.CreateElement(qualifiedName, namespaceURI);

            while (oldElement.HasAttributes)
            {
                newElement.SetAttributeNode(oldElement.RemoveAttributeNode(oldElement.Attributes[0]));
            }

            while (oldElement.HasChildNodes)
            {
                newElement.AppendChild(oldElement.FirstChild);
            }

            if (oldElement.ParentNode != null)
            {
                oldElement.ParentNode.ReplaceChild(newElement, oldElement);
            }

            return newElement;
        }
        else
        {
            return null;
        }
    }
}