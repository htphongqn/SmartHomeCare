using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Configuration;
using System.Web.Services;

[WebService(Namespace = "http://tempuri.org/")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
// To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
// [System.Web.Script.Services.ScriptService]

/**
 * \brief initialize the connection string to sql server
 */
public class BaseServ : System.Web.Services.WebService
{
    protected static string dbConnString;
	public BaseServ()
	{
        dbConnString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
	}
}