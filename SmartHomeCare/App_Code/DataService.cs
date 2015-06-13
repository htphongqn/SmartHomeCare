using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Xml;
using System.Web.Services;

/// <summary>
/// Summary description for DataService
/// </summary>
[WebService(Namespace = "http://tempuri.org/")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
// To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
// [System.Web.Script.Services.ScriptService]
public class DataService : Service
{
    private DBClass _db = new DBClass();
    #region userinfo

    [WebMethod]
    public int ChangePassword(string username, string passcurrent, string passnew, string passhint)
    {
        return _db.ChangePassword(username, passcurrent, passnew, passhint);
    }
    //[WebMethod]
    public int Delete_UsersAuthorizes_ById(int autoid)
    {
        return _db.Delete_UsersAuthorizes_ById(autoid);
    }
    [WebMethod]
    public int InsertUpdate_Users(string username, string userpass, string passhint, int usertypeid, bool isactive)
    {
        return _db.InsertUpdate_Users(username, userpass, passhint, usertypeid, isactive);
    }
    [WebMethod]
    public int InsertUpdate_UsersContact(string username, string name, string email, string phone, string address, bool IsMain)
    {
        return _db.InsertUpdate_UsersContact(username, name, email, phone, address, IsMain);
    }
    [WebMethod]
    public int InsertUpdate_UsersInfo(string username, string firstname, string lastname, DateTime? dateofbirth, bool isgender,
                                string emailaddress, string streetaddress, string citycode, string statecode, string zipcode,
                                string county, string countrycode, string homephone, string mobilephone, string registrationcode)
    {
        return _db.InsertUpdate_UsersInfo(username, firstname, lastname, dateofbirth, isgender,
                                 emailaddress, streetaddress, citycode, statecode, zipcode, county, countrycode, homephone, mobilephone, registrationcode);
    }
    public XmlDocument GetInfo_UsersAll_ByUserName(string username)
    {
        return this.SerializeObject(_db.GetInfo_UserAll_ByUserName(username));
    }
    [WebMethod]
    public XmlDocument GetList_MemberType()
    {
        return this.SerializeObject(_db.GetList_MemberType());
    }
    [WebMethod]
    public XmlDocument GetInfo_Rule_ByUserName(string username)
    {
        return this.SerializeObject(_db.GetInfo_Rule_ByUserName(username).Table);
    }
    [WebMethod]
    public XmlDocument GetList_BillingAccountTypes()
    {
        return this.SerializeObject(_db.GetList_BillingAccountTypes());
    }
    [WebMethod]
    public XmlDocument GetInfo_UsersContact_ByUserName(string username)
    {
        return this.SerializeObject(_db.GetInfo_UsersContact_ByUserName(username));
    }
    [WebMethod]
    public XmlDocument GetList_AuthorizedUser(string username)
    {
        return this.SerializeObject(_db.GetList_AuthorizedUser(username));
    }
    [WebMethod]
    public XmlDocument GetList_Countries()
    {
        return this.SerializeObject(_db.GetList_Countries());
    }
    [WebMethod]
    public XmlDocument GetList_CountryStates()
    {
        return this.SerializeObject(_db.GetList_CountryStates());
    }
    public XmlDocument GetList_CreditCardType()
    {
        return this.SerializeObject(_db.GetList_CreditCardType());
    }
    [WebMethod]
    public XmlDocument GetList_CountryStates_ByCountryCode(string countrycode)
    {
        return this.SerializeObject(_db.GetList_CountryStates_ByCountryCode(countrycode));
    }
    [WebMethod]
    public XmlDocument Insert_UsersAuthorizes(string username, string authorizeduser)
    {
        return this.SerializeObject(_db.Insert_UsersAuthorizes( username, authorizeduser));//always 1 row
    }
    [WebMethod]
    public XmlDocument Login_Website(string username, string userpass, string loginfromcomputerip)
    {
        return this.SerializeObject(_db.Login_Website(username, userpass, loginfromcomputerip));//always 1 row

    }
    [WebMethod]
    public XmlDocument Register_Account_Users(string username, string userpass, string passhint, string firstname, string lastname,
                                DateTime? dateofbirth, bool isgender, string emailaddress, string streetaddress, string citycode,
                                string statecode, string zipcode, string county, string countrycode, string homephone, string mobilephone, string registeredip, string registrationcode)
    {
        return this.SerializeObject(_db.Register_Account_Users(username, userpass, passhint, firstname, lastname, dateofbirth, isgender,
                                 emailaddress, streetaddress, citycode, statecode, zipcode, county, countrycode, homephone, mobilephone, registeredip, registrationcode));//always 1 row
    }
    [WebMethod]
    public object Register_Validation_UserName(string username)
    {
        return _db.Register_Validation_UserName( username);// 1 = ok or 0 = exist
    }
    [WebMethod]
    public object IsExists_Email(string email)
    {
        return  _db.IsExists_Email( email);// 1 = exist || 0 = 
    }
    [WebMethod]
    public XmlDocument Submit_Forgot_Password(string username, DateTime? dateofbirth)
    {
        return this.SerializeObject(_db.Submit_Forgot_Password( username, dateofbirth));//always 1 row
    }
    [WebMethod]
    public XmlDocument Submit_Forgot_UserName(string firstname, string lastname, DateTime? dateofbirth, string zipcode)
    {
        return this.SerializeObject(_db.Submit_Forgot_UserName(firstname, lastname, dateofbirth, zipcode));//always 1 row
    }
    [WebMethod]
    public XmlDocument GetList_Paramaters(int Id, string ParaCode, string Description)
    {
        return this.SerializeObject(_db.GetList_Paramaters(Id, ParaCode, Description));
    }
    [WebMethod]
    public XmlDocument GetList_AdminMessages(int Id, string Code, string Title)
    {
        return this.SerializeObject(_db.GetList_AdminMessages( Id, Code, Title));
    }
    [WebMethod]
    public int InsertUpdate_AdminMessages(int Id, string Code, string Title, string TitleVN, bool Approved, string Note)
    {
        return _db.InsertUpdate_AdminMessages(Id, Code, Title, TitleVN, Approved, Note);
    }
    [WebMethod]
    public XmlDocument GetList_Users_Admin(string UserName, string LastName, string FirstName, DateTime? FromDateOfBirth, DateTime? ToDateOfBirth)
    {
        return this.SerializeObject(_db.GetList_Users_Admin(UserName, LastName, FirstName, FromDateOfBirth, ToDateOfBirth));
    }
    [WebMethod]
    public XmlDocument GetList_Users(int userid, string username, bool? isactive, string email, DateTime? createdatefrom, DateTime? createdateto)
    {
        return this.SerializeObject(_db.GetList_Users(userid, username, isactive, email, createdatefrom, createdateto));
    }
    [WebMethod]
    public XmlDocument GetList_RegisterCodes(string Rule, bool? IsUsing, bool? Disable)
    {
        return this.SerializeObject(_db.GetList_RegisterCodes(Rule, IsUsing, Disable));
    }
    [WebMethod]
    public XmlDocument GetList_User_Login(string Username, DateTime? LoginDateFrom, DateTime? LogindDateTo)
    {
        return this.SerializeObject(_db.GetList_User_Login(Username, LoginDateFrom, LogindDateTo));
    }
    [WebMethod]
    public int IsActive_User_ByIds(string Ids, bool isActive)
    {
        return _db.IsActive_User_ByIds(Ids, isActive);
    }
    [WebMethod]
    public int InsertUpdate_Paramaters(int Id, string ParamCode, string Description, string Value, bool Active, string Note)
    {
        return ToSQL.SQLToInt(_db.InsertUpdate_Paramaters(Id, ParamCode, Description, Value, Active, Note));
    }
    //[WebMethod]
    public int DeleteParamaters(int AutoId)
    {
        return Convert.ToInt32(_db.DeleteParamaters(AutoId));
    }
    [WebMethod]
    public int Set_RegisterCode_Using(string Code)
    {
        return Convert.ToInt32(_db.Set_RegisterCode_Using(Code));
    }
    [WebMethod]
    public XmlDocument Insert_MessageCenter(string MailFrom, string Subject, string MailTo, string MessageCenter)
    {
        return this.SerializeObject(_db.Insert_MessageCenter(MailFrom, MailTo, Subject, MessageCenter));
    }
    //[WebMethod]
    public XmlDocument Delete_MessageCenter_ByIds(string MessageIds)
    {
        return this.SerializeObject(_db.Delete_MessageCenter_ByIds(MessageIds));
    }
    //[WebMethod]
    public XmlDocument Delete_MessageCenter_Trash_ByIds(string MessageIds)
    {
        return this.SerializeObject(_db.Delete_MessageCenter_Trash_ByIds(MessageIds));
    }
    [WebMethod]
    public XmlDocument GetInfo_PayBill_CreditCard(string username)
    {
        return this.SerializeObject(_db.GetInfo_PayBill_CreditCard(username).Table);//always 1 row
    }
    [WebMethod]
    public XmlDocument GetInfo_BillingAccounts(string username)
    {
        return this.SerializeObject(_db.GetInfo_BillingAccounts(username));//always 1 row
    }
    [WebMethod]
    public XmlDocument GetInfo_BillingAccounts_User(string username)
    {
        return this.SerializeObject(_db.GetInfo_BillingAccounts(username));//always 1 row
    }
    [WebMethod]
    public XmlDocument GetList_BillingAccountDetails(string AccountNumber)
    {
        return this.SerializeObject(_db.GetList_BillingAccountDetails(AccountNumber));
    }
    [WebMethod]
    public XmlDocument GetList_BillingPayments(string AccountNumber)
    {
        return this.SerializeObject(_db.GetList_BillingPayments(AccountNumber));
    }
    [WebMethod]
    public XmlDocument GetList_MessageCenter_Inbox(string UserName)
    {
        return this.SerializeObject(_db.GetList_MessageCenter_Inbox(UserName));
    }
    [WebMethod]
    public XmlDocument GetList_MessageCenter_Alarm(string UserName)
    {
        return this.SerializeObject(_db.GetList_MessageCenter_Alarm(UserName));
    }
    [WebMethod]
    public XmlDocument GetList_MessageCenter_Sent(string UserName)
    {
        return this.SerializeObject(_db.GetList_MessageCenter_Sent(UserName));
    }
    [WebMethod]
    public XmlDocument GetList_MessageCenter_Trash(string UserName)
    {
        return this.SerializeObject(_db.GetList_MessageCenter_Trash(UserName));
    }
    [WebMethod]
    public XmlDocument GetInfo_MessageCenter_ById(int MessageId)
    {
        return this.SerializeObject(_db.GetInfo_MessageCenter_ById(MessageId).Table);
    }
    [WebMethod]
    public object GetEmail_ByUserName(string UserName)
    {
        return _db.GetEmail_ByUserName(UserName);
    }
    [WebMethod]
    public int UpdateGlobalSetting(string UserName)
    {
        return _db.UpdateGlobalSetting(UserName);
    }
    [WebMethod]
    public XmlDocument GetList_UserTemperature(string UserName, DateTime? FromDate, DateTime? ToDate)
    {
        return this.SerializeObject(_db.GetList_UserTemperature(UserName, FromDate, ToDate));
    }
    [WebMethod]
    public int InsertUpdate_UserSettingColor(string UserName, int SkinTempColorId, int AmbTempColorId, int BackgroundColorId)
    {
        return _db.InsertUpdate_UserSettingColor(UserName, SkinTempColorId, AmbTempColorId, BackgroundColorId);
    }
    [WebMethod]
    public int Update_BillingAccount_Management(string AccountNumber, int BillingTypeId, DateTime? EffDate, decimal AmountCharge, bool IsPayBill, string Notes)
    {
        return _db.Update_BillingAccount_Management(AccountNumber, BillingTypeId, EffDate, AmountCharge, IsPayBill, Notes);
    }
    //[WebMethod]
    public int AddManual_BillingAccount_Management(string AccountNumber, DateTime? Date, decimal AmountCharge, string Notes)
    {
        return _db.AddManual_BillingAccount_Management(AccountNumber, Date, AmountCharge, Notes);
    }
    [WebMethod]
    public XmlDocument GetInfo_UserTrackMyHealth(string UserName)
    {
        return this.SerializeObject(_db.GetInfo_UserTrackMyHealth(UserName));
    }
    [WebMethod]
    public XmlDocument GetInfo_UserSettingColor(string UserName)
    {
        return this.SerializeObject(_db.GetInfo_UserSettingColor(UserName));
    }
    [WebMethod]
    public XmlDocument GetInfo_UserTrackMyHealth_Measurement(string UserName)
    {
        return this.SerializeObject(_db.GetInfo_UserTrackMyHealth_Measurement(UserName));
    }
    [WebMethod]
    public int InsertUpdate_UserTrackMyHealth_Measurement(string UserName, bool Metric, bool US)
    {
        return _db.InsertUpdate_UserTrackMyHealth_Measurement(UserName, Metric, US);
    }
    [WebMethod]
    public int InsertUpdate_UserTrackMyHealth_Threshold(string UserName, decimal? Samplerate, int? SampleRateId, decimal? LowValue, decimal? HighValue, decimal? VeryHighValue)
    {
        return _db.InsertUpdate_UserTrackMyHealth_Threshold(UserName, Samplerate, SampleRateId, LowValue, HighValue, VeryHighValue);
    }
    [WebMethod]
    public XmlDocument GetList_UserTrackOthers(string UserName)
    {
        return this.SerializeObject(_db.GetList_UserTrackOthers(UserName));
    }
    [WebMethod]
    public XmlDocument GetInfo_UserAll_ByUserName(string UserName)
    {
        return this.SerializeObject(_db.GetInfo_UserAll_ByUserName(UserName));
    }
    [WebMethod]
    public XmlDocument GetInfo_BillingInfo_ById(string PaymentId)
    {
        return this.SerializeObject(_db.GetInfo_BillingInfo_ById(PaymentId));
    }
    [WebMethod]
    public XmlDocument GetList_EmailTemplates()
    {
        return this.SerializeObject(_db.GetList_EmailTemplates());
    }
    //[WebMethod]
    public XmlDocument GetInfo_EmailTemplates(int Id)
    {
        return this.SerializeObject(_db.GetInfo_EmailTemplates(Id));
    }
    [WebMethod]
    public int InsertUpdate_EmailTemplates(int id, string code, string subject, string body, string note)
    {
        return _db.InsertUpdate_EmailTemplates(id, code, subject, body, note);
    }
    [WebMethod]
    public bool IsActive_User_ByWebCode(string WebCode)
    {
        return _db.IsActive_User_ByWebCode(WebCode);
    }
    [WebMethod]
    public string Insert_BillingInfo(string NameCard, string Address, string AddressLine2, string City, string StateCode, string ZIPCode, string CountryCode, string Phone, string Email, int CardTypeId, string CardNumber, string ExpirationMonth, string ExpirationYear, string SercurityCode, string AccountNumber, decimal AmountPay)
    {
        return _db.Insert_BillingInfo(NameCard, Address, AddressLine2, City, StateCode, ZIPCode, CountryCode, Phone, Email, CardTypeId, CardNumber, ExpirationMonth, ExpirationYear, SercurityCode, AccountNumber, AmountPay);
    }
    [WebMethod]
    public XmlDocument GetInfo_UserOverview(string Username)
    {
        return this.SerializeObject(_db.GetInfo_UserOverview(Username).Table);
    }
    [WebMethod]
    public int Update_UserOverview(string UserNameOld, string UserNameNew, string Email, string Warning, string Password)
    {
        return _db.Update_UserOverview( UserNameOld, UserNameNew, Email, Warning, Password);
    }
    [WebMethod]
    public int GetValue_Paramter_ByCode(string code)
    {
        return _db.GetValue_Paramter_ByCode(code);
    }
    [WebMethod]
    public string Invite_Membertype(string memberType)
    {
        return _db.Invite_Membertype(memberType);
    }
    [WebMethod]
    public XmlDocument Invalid_RegistrationCode(string registercode)
    {
        return this.SerializeObject(_db.Invalid_RegistrationCode(registercode));
    }
    #endregion
}
