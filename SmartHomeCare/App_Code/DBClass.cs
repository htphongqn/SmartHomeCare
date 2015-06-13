using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Microsoft.ApplicationBlocks.Data;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Web.Services;

/**
* \brief select, insert, update, delete database sql server
*/
public class DBClass : BaseServ
{
    private int result;
	public DBClass()
	{
        this.result = 0;
    }

    #region sqlHelp
    /**
     * execute procedure insert, update, delete
     * @see ExecuteScalar()
     * @return object
     */
    public virtual object ExecuteScalar(string ProcedureName, params object[] Parameters)
    {
        return SqlHelper.ExecuteScalar(dbConnString, ProcedureName, Parameters);
    }
    /**
     * execute procedure insert, update, delete
     * @see ExecuteNonQuery()
     * @return int
     */
    public virtual int ExecuteNonQuery(string ProcedureName, params object[] Parameters)
    {
        return SqlHelper.ExecuteNonQuery(dbConnString, ProcedureName, Parameters);
    }
    /**
     * get data by procedure
     * @see GetDataRow()
     * @return DataRow
     */
    public virtual DataRow GetDataRow(string ProcedureName, params object[] Parameters)
    {
        return GetDataRow(0, ProcedureName, Parameters);
    }
    /**
     * get datarow in datatable by rowindex
     * @see GetDataRow()
     * @return DataRow
     */
    public virtual DataRow GetDataRow(int RowIndex, string ProcedureName, params object[] Parameters)
    {
        DataTable dt = GetDataTable(0, ProcedureName, Parameters);
        DataRow dr = null;

        if (dt != null)
        {
            if (RowIndex >= 0 && RowIndex < dt.Rows.Count)
            {
                dr = dt.Rows[RowIndex];
            }
            dt.Dispose();
        }
        return dr;
    }
    /**
     * get datatable in dataset by tableindex
     * @see GetDataTable()
     * @return DataTable
     */
    public static DataTable GetDataTable(int TableIndex, string ProcedureName, params object[] Parameters)
    {
        DataSet ds = GetDataSet(ProcedureName, Parameters);
        DataTable dt = null;
        if (ds != null && ds.Tables.Count > 0)
        {
            if (TableIndex >= 0 && TableIndex < ds.Tables.Count)
                dt = ds.Tables[TableIndex];

            ds.Dispose();
        }
        return dt;
    }
    /**
     * get datatable by procedure
     * @see GetDataTable()
     * @return DataTable
     */
    public static DataTable GetDataTable(string ProcedureName, params object[] Parameters)
    {
        DataSet ds = GetDataSet(ProcedureName, Parameters);
        DataTable dt = null;
        if (ds != null && ds.Tables.Count > 0)
        {
            dt = ds.Tables[0];
            ds.Dispose();
        }
        return dt;
    }
    /**
     * get dataset by procedure
     * @see GetDataSet()
     * @return DataSet
     */
    public static DataSet GetDataSet(string ProcedureName, params object[] Parameters)
    {
       return SqlHelper.ExecuteDataset(dbConnString, ProcedureName, Parameters);
    }
    public object GetValueFromDB(string sql)
    {
        return SqlHelper.ExecuteScalar(dbConnString, CommandType.Text, sql);
    }

    #endregion

    #region userinfo
    /**
     * change password user
     * @see ChangePassword()
     * @param username need change password
     * @param pascurrent password current
     * @param passnew password new need change
     * @return value 1 success, 0 failure
     */
    [WebMethod]
    public int ChangePassword(string username, string passcurrent, string passnew, string passhint)
    {
        object result = ExecuteScalar("spChangePassword", username, passcurrent, passnew, passhint);
        return ToSQL.SQLToInt(result);
    }
    /**
     * delete user authorize by id
     * @see Delete_UsersAuthorizes_ById()
     * @param autoid id user authorize need delete
     * @return value 1 success, 0 failure
     */
    [WebMethod]
    public int Delete_UsersAuthorizes_ById(int autoid)
    {
        result = ExecuteNonQuery("spDelete_UserAuthorizes_ById", autoid);
        return result;
    }
    /**
     * insert, update user
     * @see InsertUpdate_Users()
     * @param username if username exist then update, else insert 
     * @return value 1 success, 0 failure
     */
    [WebMethod]
    public int InsertUpdate_Users(string username, string userpass, string passhint, int usertypeid,bool isactive)
    {
        result = ExecuteNonQuery("spInsertUpdate_Users", username, userpass, passhint, usertypeid, isactive);
        return result;
    }
    /**
     * insert, update user contact
     * @see InsertUpdate_UsersContact()
     * @param username if username exist then update, else insert 
     * @return value 1 success, 0 failure
     */
    [WebMethod]
    public int InsertUpdate_UsersContact(string username, string name, string email, string phone, string address,bool IsMain)
    {
        result = ExecuteNonQuery("spInsertUpdate_UserContact", username, name, email, phone, address, IsMain);
        return result;
    }
    /**
     * insert, update user info
     * @see InsertUpdate_UsersInfo()
     * @param username if username exist then update, else insert 
     * @return value 1 success, 0 failure
     */
    [WebMethod]
    public int InsertUpdate_UsersInfo(string username, string firstname, string lastname, DateTime? dateofbirth, bool isgender,
                                string emailaddress, string streetaddress, string citycode, string statecode, string zipcode,
                                string county, string countrycode, string homephone, string mobilephone, string registrationcode)
    {
        result = ExecuteNonQuery("spInsertUpdate_UserInfo", username, firstname, lastname, dateofbirth, isgender,
                                 emailaddress, streetaddress, citycode, statecode, zipcode, county, countrycode, homephone, mobilephone, registrationcode);
        return result;
    }

    /**
     * get user info by username
     * @see GetInfo_UsersAll_ByUserName()
     * @return datarow info user
     */
    public DataRow GetInfo_UsersAll_ByUserName(string username)
    {
        return GetDataRow("spGetInfo_UserAll_ByUserName", username);
    }
    /**
     * get list member type
     * @see GetList_MemberType()
     * @return datatable
     */
    [WebMethod]
    public DataTable GetList_MemberType()
    {
        return GetDataTable("spGetList_MemberType");
    }
    /**
     * get info rule by username
     * @see GetInfo_Rule_ByUserName()
     * @return datarow
     */
    public DataRow GetInfo_Rule_ByUserName(string username)
    {
          return GetDataRow("spGetInfo_Rule_ByUserName", username);
    }
    /**
     * get list billing type
     * @see GetList_BillingAccountTypes()
     * @return datatable
     */
    [WebMethod]
    public DataTable GetList_BillingAccountTypes()
    {
        return GetDataTable("spGetList_BillingAccountTypes");
    }
    /**
     * get info user contact by username
     * @see GetInfo_UsersContact_ByUserName()
     * @return datarow
     */
    public DataRow GetInfo_UsersContact_ByUserName(string username)
    {
        return GetDataRow("spGetInfo_UserContact_ByUserName", username);
    }
    /**
     * get list user authorize
     * @see GetList_AuthorizedUser()
     * @return dataset
     */
    [WebMethod]
    public DataSet GetList_AuthorizedUser(string username)
    {
        return GetDataSet("spGetList_AuthorizedUser", username);
    }
    /**
     * get list couontry
     * @see GetList_Countries()
     * @return dataset
     */
    [WebMethod]
    public DataSet GetList_Countries()
    {
        return GetDataSet("spGetList_Countries");
    }
    /**
     * get list states
     * @see GetList_CountryStates()
     * @return dataset
     */
    [WebMethod]
    public DataSet GetList_CountryStates()
    {
        return GetDataSet("spGetList_CountryStates");
    }
    /**
     * get list card type
     * @see GetList_CreditCardType()
     * @return dataset
     */
    public DataSet GetList_CreditCardType()
    {
        return GetDataSet("spGetList_CreditCardType");
    }
    /**
     * get list states by country code
     * @see GetList_CountryStates_ByCountryCode()
     * @return dataset
     */
    [WebMethod]
    public DataSet GetList_CountryStates_ByCountryCode(string countrycode)
    {
        return GetDataSet("spGetList_CountryStates_ByCountryCode", countrycode);
    }
    /**
     * insert user authorize
     * @see Insert_UsersAuthorizes()
     * @return datarow
     */
    public DataRow Insert_UsersAuthorizes(string username, string authorizeduser)
    {
        return GetDataRow("spInsert_UserAuthorizes", username, authorizeduser);//always 1 row
    }
    /**
     * login website
     * @see Login_Website()
     * @return datarow info user login
     */
    public DataRow Login_Website(string username, string userpass, string loginfromcomputerip)
    {
        return GetDataRow("spLogin_Website", username, userpass, loginfromcomputerip);
    }
    /**
     * register new user
     * @see Register_Account_Users()
     * @return datarow user info register
     */
    public DataRow Register_Account_Users(string username, string userpass, string passhint,string firstname, string lastname, 
                                DateTime? dateofbirth, bool isgender, string emailaddress, string streetaddress, string citycode,
                                string statecode, string zipcode, string county, string countrycode, string homephone, string mobilephone, string registeredip, string registrationcode)
    {
        return GetDataRow("spRegister_Account_User", username, userpass, passhint,firstname, lastname, dateofbirth, isgender,
                                 emailaddress, streetaddress, citycode, statecode, zipcode, county, countrycode, homephone, mobilephone, registeredip, registrationcode);//always 1 row
    }
    /**
     * check username register
     * @see Register_Validation_UserName()
     * @return object value 1 username validation, 0 unvalidation
     */
    [WebMethod]
    public object Register_Validation_UserName(string username)
    {
        return ExecuteScalar("spRegister_Validation_UserName", username);// 1 = ok 
    }
    /**
     * check email is exist
     * @see IsExists_Email()
     * @return object value 1 exist, 0 not exist
     */
    public object IsExists_Email(string email)
    {
        return ExecuteScalar("spIsExists_Email", email);// 1 = exist || 0 = no 
    }
    /**
     * check info user forgot password
     * @see Submit_Forgot_Password()
     * @return datarow
     */
    public DataRow Submit_Forgot_Password(string username, DateTime? dateofbirth)
    {
        return GetDataRow("spSubmit_Forgot_Password", username, dateofbirth);//always 1 row
    }
    /**
     * check info user forgot username
     * @see Submit_Forgot_UserName()
     * @return datarow
     */
    public DataRow Submit_Forgot_UserName(string firstname, string lastname, DateTime? dateofbirth, string zipcode)
    {
        return GetDataRow("spSubmit_Forgot_UserName", firstname, lastname, dateofbirth, zipcode);//always 1 row
    }
    /**
     * get list parameter
     * @see GetList_Paramaters()
     * @return dataset
     */
    [WebMethod]
    public DataSet GetList_Paramaters(int Id,string ParaCode,string Description)
    {
        return GetDataSet("spGetList_Paramaters",Id,ParaCode,Description);
    }
    /**
     * get list message, admin message
     * @see GetList_AdminMessages()
     * @return dataset
     */
    [WebMethod]
    public DataSet GetList_AdminMessages(int Id,string Code, string Title)
    {
        return GetDataSet("spGetList_AdminMessages",Id, Code, Title);
    }
    /**
     * insert message, admin message
     * @see InsertUpdate_AdminMessages()
     * @return int value 1 success, 0 failure
     */
    [WebMethod]
    public int InsertUpdate_AdminMessages(int Id, string Code, string Title,string TitleVN,bool Approved,string Note)
    {
        return ToSQL.SQLToInt(ExecuteNonQuery("spInsertUpdate_AdminMessages", Id, Code, Title, TitleVN, Approved, Note));
    }
    /**
     * get list all user
     * @see GetList_Users_Admin()
     * @return dataset
     */
    [WebMethod]
    public DataSet GetList_Users_Admin(string UserName,string LastName,string FirstName,DateTime? FromDateOfBirth,DateTime? ToDateOfBirth)
    {
        return GetDataSet("spGetList_User_Admin",UserName,LastName,FirstName,FromDateOfBirth,ToDateOfBirth);
    }
    /**
     * get list user
     * @see GetList_Users()
     * @return datatable
     */
    [WebMethod]
    public DataTable GetList_Users(int userid, string username, bool? isactive, string email, DateTime? createdatefrom, DateTime? createdateto)
    {
        return GetDataTable("spGetList_Users", userid, username, isactive, email, createdatefrom, createdateto);
    }
    /**
     * get list code register
     * @see GetList_RegisterCodes()
     * @return datatable
     */
    [WebMethod]
    public DataTable GetList_RegisterCodes(string Rule,bool? IsUsing,bool? Disable)
    {
        return GetDataTable("spGetList_RegisterCodes",Rule,IsUsing,Disable);
    }
    /**
     * get list user login website
     * @see GetList_User_Login()
     * @return datatable
     */
    [WebMethod]
    public DataTable GetList_User_Login(string Username, DateTime? LoginDateFrom, DateTime? LogindDateTo)
    {
        return GetDataTable("spGetList_User_Login",Username, LoginDateFrom, LogindDateTo);
    }
    /**
     * active 1 array id
     * @see IsActive_User_ByIds()
     * @parame ids array id
     * @param isactive true active, false deavtive
     * @return int value 1 success, 0 failure
     */
    [WebMethod]
    public int IsActive_User_ByIds(string Ids, bool isActive)
    {
        return ExecuteNonQuery("spIsActive_User_ByIds", Ids, isActive);
    }
    /**
     * insert update parameter
     * @see InsertUpdate_Paramaters()
     * @return int value 1 success, 0 failure
     */
    [WebMethod]
    public int InsertUpdate_Paramaters(int Id, string ParamCode, string Description, string Value, bool Active,string Note)
    {
        return ToSQL.SQLToInt(ExecuteNonQuery("spInsertUpdate_Paramaters",Id, ParamCode, Description, Value, Active,Note));
    }
    /**
     * delete parameter by id
     * @see DeleteParamaters()
     * @return int value 1 success, 0 failure
     */
    [WebMethod]
    public int DeleteParamaters(int AutoId)
    {
        return Convert.ToInt32(ExecuteNonQuery("spDeleteParamaters", AutoId));
    }
    /**
     * delete parameter by id
     * @see DeleteParamaters()
     * @return int value 1 success, 0 failure
     */
    [WebMethod]
    public int Set_RegisterCode_Using(string Code)
    {
        return Convert.ToInt32(ExecuteNonQuery("spSet_RegisterCode_Using", Code));
    }
    /**
     * sent mail from user to user
     * @see Insert_MessageCenter()
     * @return datarow
     */
    public DataRow Insert_MessageCenter(string MailFrom, string Subject, string MailTo, string MessageCenter)
    {
        return GetDataRow("spInsert_MessageCenter", MailFrom, MailTo, Subject, MessageCenter);
    }
    /**
     * delete message by array id
     * @see Delete_MessageCenter_ByIds()
     * @return datarow
     */
    public DataRow Delete_MessageCenter_ByIds(string MessageIds)
    {
        return GetDataRow("spDelete_MessageCenter_ByIds", MessageIds);
    }
    /**
     * delete message trash by array trash id
     * @see Delete_MessageCenter_Trash_ByIds()
     * @return datarow
     */
    public DataRow Delete_MessageCenter_Trash_ByIds(string MessageIds)
    {
        return GetDataRow("spDelete_MessageCenter_Trash_ByIds", MessageIds);
    }
    /**
     * get info pay bill card
     * @see GetInfo_PayBill_CreditCard()
     * @return datarow
     */
    public DataRow GetInfo_PayBill_CreditCard(string username)
    {
        return GetDataRow("spGetInfo_PayBill_CreditCard", username);//always 1 row
    }
    /**
     * get info billing account
     * @see GetInfo_PayBill_CreditCard()
     * @return datatable
     */
    [WebMethod]
    public DataTable GetInfo_BillingAccounts(string username)
    {
        return GetDataTable("spGetInfo_BillingAccounts", username);//always 1 row
    }
    /**
     * get info billing account user
     * @see GetInfo_BillingAccounts_User()
     * @return datarow
     */
    public DataRow GetInfo_BillingAccounts_User(string username)
    {
        return GetDataRow("spGetInfo_BillingAccounts", username);//always 1 row
    }
    /**
     * get list billing account details
     * @see GetList_BillingAccountDetails()
     * @return datatable
     */
    [WebMethod]
    public DataTable GetList_BillingAccountDetails(string AccountNumber)
    {
        return GetDataTable("spGetList_BillingAccountDetails", AccountNumber);
    }
    /**
     * get list billing payment
     * @see GetList_BillingPayments()
     * @return datatable
     */
    [WebMethod]
    public DataTable GetList_BillingPayments(string AccountNumber)
    {
        return GetDataTable("spGetList_BillingPayments", AccountNumber);
    }
    /**
     * get list message inbox
     * @see GetList_MessageCenter_Inbox()
     * @return datatable
     */
    [WebMethod]
    public DataTable GetList_MessageCenter_Inbox(string UserName)
    {
        return GetDataTable("spGetList_MessageCenter_Inbox", UserName);
    }
    /**
     * get list message alarm
     * @see GetList_MessageCenter_Alarm()
     * @return datatable
     */
    [WebMethod]
    public DataTable GetList_MessageCenter_Alarm(string UserName)
    {
        return GetDataTable("spGetList_MessageCenter_Alarm", UserName);
    }
    /**
     * get list message sent
     * @see GetList_MessageCenter_Sent()
     * @return datatable
     */
    [WebMethod]
    public DataTable GetList_MessageCenter_Sent(string UserName)
    {
        return GetDataTable("spGetList_MessageCenter_Sent", UserName);
    }
    /**
     * get list message trash
     * @see GetList_MessageCenter_Trash()
     * @return datatable
     */
    [WebMethod]
    public DataTable GetList_MessageCenter_Trash(string UserName)
    {
        return GetDataTable("spGetList_MessageCenter_Trash", UserName);
    }
    /**
     * get info message by id
     * @see GetInfo_MessageCenter_ById()
     * @return datarow
     */
    public DataRow GetInfo_MessageCenter_ById(int MessageId)
    {
        return GetDataRow("spGetInfo_MessageCenter_ById", MessageId);
    }
    /**
     * get email by username
     * @see GetEmail_ByUserName()
     * @return object value is email
     */
    public object GetEmail_ByUserName(string UserName)
    {
        return ExecuteScalar("spGetEmail_ByUserName", UserName);
    }
    /**
     * update global setting
     * @see UpdateGlobalSetting()
     * @return int value 1 success, 0 failure
     */
    [WebMethod]
    public int UpdateGlobalSetting(string UserName)
    {
        return ExecuteNonQuery("spUpdateGlobal", UserName);
    }
    /**
     * get list user temperature
     * @see GetList_UserTemperature()
     * @return datatable
     */
    [WebMethod]
    public DataTable GetList_UserTemperature(string UserName, DateTime? FromDate, DateTime? ToDate)
    {
        return GetDataTable("spGetList_UserTemperature", UserName, FromDate, ToDate);
    }

    /**
     * get list user default temperature
     * @see GetList_UserTemperature()
     * @return datatable
     */
    [WebMethod]
    public DataTable GetList_Temperature_Default(string UserName)
    {
        return GetDataTable("spGetList_Temperature_Default", UserName);
    }

    /**
     * insert update color for user
     * @see InsertUpdate_UserSettingColor()
     * @return int value 1 success, 0 failure
     */
    [WebMethod]
    public int InsertUpdate_UserSettingColor(string UserName, int SkinTempColorId, int AmbTempColorId, int BackgroundColorId)
    {
        return ExecuteNonQuery("spInsertUpdate_UserSettingColor", UserName, SkinTempColorId, AmbTempColorId, BackgroundColorId);
    }
    /**
     * update billing account
     * @see Update_BillingAccount_Management()
     * @return int value 1 success, 0 failure
     */
    [WebMethod]
    public int Update_BillingAccount_Management(string AccountNumber, int BillingTypeId, DateTime? EffDate, decimal AmountCharge,bool IsPayBill,string Notes)
    {
        return ExecuteNonQuery("spUpdate_BillingAccount_Management", AccountNumber, BillingTypeId, EffDate, AmountCharge,IsPayBill,Notes);
    }
    /**
     * add manual billing account
     * @see AddManual_BillingAccount_Management()
     * @return int value 1 success, 0 failure
     */
    [WebMethod]
    public int AddManual_BillingAccount_Management(string AccountNumber, DateTime? Date, decimal AmountCharge,  string Notes)
    {
        return ExecuteNonQuery("spAddManual_BillingAccount_Management", AccountNumber,  Date, AmountCharge,  Notes);
    }
    /**
     * get info color by username
     * @see GetInfo_UserSettingColor()
     * @return datarow info color by username
     */
    public DataRow GetInfo_UserSettingColor(string UserName)
    {
        return GetDataRow("spGetInfo_UserSettingColor", UserName);
    }
    /**
     * get info track health measurement by username
     * @see GetInfo_UserTrackMyHealth_Measurement()
     * @return datarow info track health measurement
     */
    public DataRow GetInfo_UserTrackMyHealth_Measurement(string UserName)
    {
        return GetDataRow("spGetInfo_UserTrackMyHealth_Measurement", UserName);
    }
    /**
     * insert update track health measurement
     * @see InsertUpdate_UserTrackMyHealth_Measurement()
     * @return int value 1 success, 0 failure
     */
    [WebMethod]
    public int InsertUpdate_UserTrackMyHealth_Measurement(string UserName, bool Metric, bool US)
    {
        return ExecuteNonQuery("spInsertUpdate_UserTrackMyHealth_Measurement", UserName, Metric, US);
    }
    /**
     * get list uset track others by username
     * @see GetList_UserTrackOthers()
     * @return datatable
     */
    [WebMethod]
    public DataTable GetList_UserTrackOthers(string UserName)
    {
        return GetDataTable("spGetList_UserTrackOthers", UserName);
    }
    /**
     * get info user by username
     * @see GetInfo_UserAll_ByUserName()
     * @return datatable
     */
    [WebMethod]
    public DataTable GetInfo_UserAll_ByUserName(string UserName)
    {
        return GetDataTable("spGetInfo_UserAll_ByUserName", UserName);
    }
    /**
     * get info billing by payment id
     * @see GetInfo_BillingInfo_ById()
     * @return datatable
     */
    [WebMethod]
    public DataTable GetInfo_BillingInfo_ById(string PaymentId)
    {
        return GetDataTable("spGetInfo_BillingInfo_ById", PaymentId);
    }
    /**
     * get list email templete
     * @see GetList_EmailTemplates()
     * @return datatable
     */
    [WebMethod] 
    public DataTable GetList_EmailTemplates()
    {
        return GetDataTable("spGetList_EmailTemplates");
    }
    /**
     * get info email templete
     * @see GetInfo_EmailTemplates()
     * @return datatable
     */
    [WebMethod]
    public DataTable GetInfo_EmailTemplates(int Id)
    {
        return GetDataTable("spGetInfo_EmailTemplates", Id);
    }
    /**
     * get info email templete
     * @see InsertUpdate_EmailTemplates()
     * @return int value 1 success, 0 failure
     */
    [WebMethod]
    public int InsertUpdate_EmailTemplates(int id, string code, string subject,string body, string note)
    {
        return ExecuteNonQuery("spInsertUpdate_EmailTemplates", id, code, subject, body, note);
    }
    /**
     * active user register by webcode
     * @see IsActive_User_ByWebCode()
     * @return bool value 1 success, 0 failure
     */
    [WebMethod]
    public bool IsActive_User_ByWebCode(string WebCode)
    {
        return Convert.ToBoolean(ExecuteScalar("spIsActive_User_ByWebCode", WebCode));
    }
    /**
     * insert billing 
     * @see Insert_BillingInfo()
     * @return string
     */
    [WebMethod]
    public string Insert_BillingInfo(string NameCard, string Address, string AddressLine2, string City, string StateCode, string ZIPCode, string CountryCode, string Phone, string Email, int CardTypeId, string CardNumber, string ExpirationMonth, string ExpirationYear, string SercurityCode, string AccountNumber, decimal AmountPay)
    {
        return ToSQL.EmptyNull(ExecuteScalar("spInsert_BillingInfo", NameCard, Address, AddressLine2, City, StateCode, ZIPCode, CountryCode, Phone, Email, CardTypeId, CardNumber, ExpirationMonth,ExpirationYear, SercurityCode, AccountNumber, AmountPay));      
    }
    /**
     * get info user overview by username 
     * @see GetInfo_UserOverview()
     * @return datarow
     */
    public DataRow GetInfo_UserOverview(string Username)
    {
        return GetDataRow("spGetInfo_UserOverview",Username);
    }
    /**
     * update user overview
     * @see Update_UserOverview()
     * @return int value 1 success, 0 failure
     */
    [WebMethod]
    public int Update_UserOverview(string UserNameOld, string UserNameNew, string Email, string Warning, string Password)
    {
        return ExecuteNonQuery("spUpdate_UserOverview", UserNameOld, UserNameNew, Email, Warning, Password);
    }
    /**
     * get value parameter by code
     * @see GetValue_Paramter_ByCode()
     * @return int value code
     */
    [WebMethod]
    public int GetValue_Paramter_ByCode(string code)
    {
        return ToSQL.SQLToInt(ExecuteScalar("spGetValue_Paramter_ByCode", code));
    }
    /**
     * invite member type
     * @see Invite_Membertype()
     * @return string
     */
    [WebMethod]
    public string Invite_Membertype(string memberType)
    {
        return ToSQL.EmptyNull(ExecuteScalar("spInvite_Membertype", memberType));
    }
    /**
     * check register code exist
     * @see Invalid_RegistrationCode()
     * @return datarow
     */
    public DataRow Invalid_RegistrationCode(string registercode)
    {
        return GetDataRow("spInvalid_RegistrationCode", registercode);
    }
    #endregion

    #region function
    /**
     * check webcode when register
     * @see IsAllowCheckStatusRegistrationCodeInSendEmail()
     * @return int value 1 success, 0 failure
     */
    public int IsAllowCheckStatusRegistrationCodeInSendEmail()
    {
        string sql = "select dbo.fnGetValueInt_Paramter_ByCode ('IsAllowCheckStatusRegistrationCodeInSendEmail') ";
        object obj = GetValueFromDB(sql);
        return ToSQL.SQLToInt(obj);
    }
    /**
     * get total amount due by account number
     * @see Get_TotalAmountDue_ByAccountNumber()
     * @return decimal value
     */
    public decimal Get_TotalAmountDue_ByAccountNumber(string AccountNumber)
    {
        string sql = "select dbo.fnGet_TotalAmountDue_ByAccountNumber (" + ToSQL.SQLString(AccountNumber) + ")";
        object obj = GetValueFromDB(sql);
        return ToSQL.SQLToDecimal(obj);
    }
    /**
     * get total email trash by username
     * @see GetCount_EmailTrash_ByUserName()
     * @return int value
     */
    public int GetCount_EmailTrash_ByUserName(string UserName)
    {
        string sql = "select dbo.fnGetCount_EmailTrash_ByUserName (" + ToSQL.SQLString(UserName) + ")";
        object obj = GetValueFromDB(sql);

        return ToSQL.SQLToInt(obj);
    }
    /**
     * get total email send by username
     * @see GetCount_EmailSent_ByUserName()
     * @return int value
     */
    public int GetCount_EmailSent_ByUserName(string UserName)
    {
        string sql = "select dbo.fnGetCount_EmailSent_ByUserName (" + ToSQL.SQLString(UserName) + ")";
        object obj = GetValueFromDB(sql);

        return ToSQL.SQLToInt(obj);
    }
    /**
     * get total email alarm by username
     * @see GetCount_EmailAlarm_ByUserName()
     * @return int value
     */
    public int GetCount_EmailAlarm_ByUserName(string UserName)
    {
        string sql = "select dbo.fnGetCount_EmailAlarm_ByUserName (" + ToSQL.SQLString(UserName) + ")";
        object obj = GetValueFromDB(sql);

        return ToSQL.SQLToInt(obj);
    }
    /**
     * get total email new by username
     * @see GetCount_EmailNew_ByUserName()
     * @return int value
     */
    public int GetCount_EmailNew_ByUserName(string UserName)
    {
        string sql = "select dbo.fnGetCount_EmailNew_ByUserName (" + ToSQL.SQLString(UserName) + ")";
        object obj = GetValueFromDB(sql);

        return ToSQL.SQLToInt(obj);
    }
    /**
     * get string code by membertype
     * @see Get_RegistrationCode_ByMemberType()
     * @return string value
     */
    public string Get_RegistrationCode_ByMemberType(string membertype)
    {
        string sql = "select dbo.fnGet_RegistrationCode_ByMemberType (" + ToSQL.SQLString(membertype) + ")";
        object obj = GetValueFromDB(sql);

        return ToSQL.EmptyNull(obj);
    }
    /**
     * get string register code automatic
     * @see Get_RegistrationCode_Automatic()
     * @return string value
     */
    public string Get_RegistrationCode_Automatic()
    {
        string sql = "select dbo.fnGet_RegistrationCode_Automatic ()";
        object obj = GetValueFromDB(sql);

        return ToSQL.EmptyNull(obj);
    }
    /**
     * check user is US
     * @see Get_IsUS_UserTrackMyHealth_ByUserName()
     * @return bool value
     */
    public bool Get_IsUS_UserTrackMyHealth_ByUserName(string username)
    {
        string sql = "select dbo.fnGet_IsUS_UserTrackMyHealth_ByUserName (" + ToSQL.SQLString(username) + ")";
        object obj = GetValueFromDB(sql);

        return ToSQL.SQLToBool(obj);
    }
    /**
     * check email by username, change email address
     * @see IsInvalid_EmailAddress()
     * @return bool value
     */
    public bool IsInvalid_EmailAddress(string username,string emailaddress)
    {
        string sql = "select dbo.fnIsInvalid_EmailAddress (" + ToSQL.SQLString(username) + "," + ToSQL.SQLString(emailaddress) + ")";
        object obj = GetValueFromDB(sql);

        return ToSQL.SQLToBool(obj);
    }
    #endregion 

    #region message
    /**
     * message box confirm delete
     * @see Cornfirm_Delete()
     * @return string value
     */
    public string Cornfirm_Delete()
    {
        return GetMessageByCode2("delete_message");
    }
    /**
     * message box confirm edit
     * @see Edit_Success()
     * @return string value
     */
    public string Edit_Success()
    {
        return GetMessageByCode2("edit_success");
    }
    /**
     * get message by code
     * @see GetMessageByCode()
     * @return datarow value
     */
    public virtual DataRow GetMessageByCode(string message_code)
    {
        return GetDataRow("spGetTitle_AdminMessages_ByCode", message_code);
    }
    /**
     * get message by code
     * @see GetMessageByCode2()
     * @return string value
     */
    public static string GetMessageByCode2(string message_code)
    {
        return ToSQL.EmptyNull((new DBClass()).ExecuteScalar("spGetTitle_AdminMessages_ByCode", message_code));
    }
    #endregion

    #region Track Health
    /**
     * get list time 
     * @see GetList_UnitTime()
     * @return datatable value
     */
    public DataTable GetList_UnitTime()
    {
        return GetDataTable("spGetList_UnitTime");
    }
    /**
     * get list date 
     * @see GetList_UnitDate()
     * @return datatable value
     */
    public DataTable GetList_UnitDate()
    {
        return GetDataTable("spGetList_UnitDate");
    }

    #region Temperature
    /**
     * insert update track health threshold
     * @see InsertUpdate_UserTrackMyHealth_Threshold()
     * @return int value 1 success, 0 failure
     */
    [WebMethod]
    public int InsertUpdate_UserTrackMyHealth_Threshold(string UserName, decimal? Samplerate, int? SampleRateId, decimal? LowValue, decimal? HighValue, decimal? VeryHighValue)
    {
        return ExecuteNonQuery("spInsertUpdate_UserTrackMyHealth_Threshold", UserName, Samplerate, SampleRateId, LowValue, HighValue, VeryHighValue);
    }
    /**
     * get info track health by username
     * @see GetInfo_UserTrackMyHealth()
     * @return datarow info track health by username
     */
    public DataRow GetInfo_UserTrackMyHealth(string UserName)
    {
        return GetDataRow("spGetInfo_UserTrackMyHealth", UserName);
    }
    /**
     * get list track health temperature 
     * @see GetList_Temperature_Datetime()
     * @return datatable 
     */
    public DataTable GetList_Temperature_Datetime(string Username, DateTime? FromDate, DateTime? ToDate)
    {
        return GetDataTable("spGetList_Temperature_Datetime", Username, FromDate, ToDate);
    }
   
    #endregion

    #region BodyMeasurement
    /**
     * get list BF Type measurement method
     * @see GetList_BodyBFType()
     * @return datatable 
     */
    public DataTable GetList_BodyBFType()
    {
        return GetDataTable("spGetList_BodyBFType");
    }
    /**
     * get list BMR Type measurement method
     * @see GetList_BodyBMRType()
     * @return datatable 
     */
    public DataTable GetList_BodyBMRType()
    {
        return GetDataTable("spGetList_BodyBMRType");
    }
    /**
     * get list datetime measurement method
     * @see GetList_Datetime_BodyMeasurement()
     * @return datatable 
     */
    public DataTable GetList_Datetime_BodyMeasurement(string username,DateTime? fromdate,DateTime? todate)
    {
        return GetDataTable("spGetList_Datetime_BodyMeasurement", username, fromdate, todate);
    }
    /**
     * get list data measurement follow table display
     * @see GetList_BodyMeasurement_Table()
     * @return datatable 
     */
    public DataTable GetList_BodyMeasurement_Table(string username, DateTime? date)
    {
        return GetDataTable("spGetList_BodyMeasurement_Table", username, date);
    }
    /**
     * get list data measurement follow table display
     * @see GetList_BodyMeasurement_Datatable()
     * @return datatable 
     */
    [WebMethod]
    public DataSet GetList_BodyMeasurement_Datatable(string username, DateTime? fromdate, DateTime? todate)
    {
        return GetDataSet("spGetList_BodyMeasurement_Datatable", username, fromdate, todate);
    }
    public DataTable GetList_BodyMeasurement_Datatable_Default(string username)
    {
        return GetDataTable("spGetList_BodyMeasurement_Table_Default", username);
    }
    /**
     * get list body fateval
     * @see GetList_BodyFatEval()
     * @return datatable 
     */
    public DataTable GetList_BodyFatEval()
    {
        return GetDataTable("spGetList_BodyFatEval");
    }
    /**
     * get list body iw type
     * @see GetList_BodyIWType()
     * @return datatable 
     */
    public DataTable GetList_BodyIWType()
    {
        return GetDataTable("spGetList_BodyIWType");
    }
    /**
     * get list body activity factor type
     * @see GetList_BodyActivityFactorType()
     * @return datatable 
     */
    public DataTable GetList_BodyActivityFactorType()
    {
        return GetDataTable("spGetList_BodyActivityFactorType");
    }
    /**
     * get info body measurement by username
     * @see GetInfo_BodyMeasurement()
     * @return datatable 
     */
    public DataRow GetInfo_BodyMeasurement(string username)
    {
        return GetDataRow("spGetInfo_BodyMeasurement", username);
    }
    /**
     * insert update body measurement follow format US
     * @see InsertUpdate_BodyMeasurement_US()
     * @return int
     */
    public int InsertUpdate_BodyMeasurement_US(int autoId, string username, int? iwtypeid, int? bftypeid, int? bmrtypeid, int? fatevalid, int? activityfactortypeid, decimal? weight, decimal? heightfeet, decimal? heightinch, decimal? waist, decimal? hip, decimal? neck)
    {
        return ExecuteNonQuery("spInsertUpdate_BodyMeasurement_US", autoId, username, iwtypeid, bftypeid, bmrtypeid, fatevalid, activityfactortypeid, weight, heightfeet, heightinch, waist, hip, neck);
    }
    /**
     * insert update body measurement follow format Metric
     * @see InsertUpdate_BodyMeasurement_Metric()
     * @return int
     */
    public int InsertUpdate_BodyMeasurement_Metric(int autoId, string username, int? iwtypeid, int? bftypeid, int? bmrtypeid, int? fatevalid, int? activityfactortypeid, decimal? weight, decimal? height, decimal? waist, decimal? hip, decimal? neck)
    {
        return ExecuteNonQuery("spInsertUpdate_BodyMeasurement_Metric", autoId, username, iwtypeid, bftypeid, bmrtypeid, fatevalid, activityfactortypeid, weight, height, waist, hip, neck);
    }
    /**
     * get info body measurement give graph
     * @see GetInfo_BodyMeasurement_Graph()
     * @return datatable
     */
    public DataTable GetInfo_BodyMeasurement_Graph(string username)
    {
        return GetDataTable("spGetInfo_BodyMeasurement_Graph", username);
    }
    /**
     * get list body measurement give graph
     * @see GetList_BodyMeasurement_Graph()
     * @return datatable
     */
    public DataTable GetList_BodyMeasurement_Graph(string UserName, DateTime? fromdate, DateTime? todate)
    {
        return GetDataTable("spGetList_BodyMeasurement_Graph", UserName, fromdate, todate);
    }

    /**
     * get list body measurement default give graph
     * @see GetList_BodyMeasurement_Graph()
     * @return datatable
     */
    public DataTable GetList_BodyMeasurement_Graph_Default(string UserName)
    {
        return GetDataTable("spGetList_BodyMeasurement_Graph_Default", UserName);
    }

    #endregion

    #region HeartRate
    /**
     * get list heart rate hrest type
     * @see GetList_HeartRateHREstType()
     * @return datatable
     */
    public DataTable GetList_HeartRateHREstType()
    {
        return GetDataTable("spGetList_HeartRateHREstType");
    }
    /**
     * get list heartrate datetime
     * @see GetList_HeartRate_Datetime()
     * @return datatable
     */
    public DataTable GetList_HeartRate_Datetime(string UserName, DateTime? FromDate, DateTime? ToDate)
    {
        return GetDataTable("spGetList_HeartRate_Datetime", UserName, FromDate, ToDate);
    }
    /**
     * get list BPM
     * @see GetList_UnitBPM()
     * @return datatable
     */
    public DataTable GetList_UnitBPM()
    {
        return GetDataTable("spGetList_UnitBPM");
    }
    /**
     * get info heart rate by username
     * @see GetInfo_HeartRate()
     * @return datarow
     */
    public DataRow GetInfo_HeartRate(string username)
    {
        return GetDataRow("spGetInfo_HeartRate", username);
    }
    /**
     * insert update heart rate
     * @see InsertUpdate_HeartRate()
     * @return int
     */
    public int InsertUpdate_HeartRate(int autoId, string username, decimal? samplerate, int? srUnitTimeId, int? maxHREstimationId, int? highRestHR, int? lowRestHR, decimal? hrvanalysisInteral, int? hrvUnitTimeId)
    {
        object b = ExecuteScalar("spInsertUpdate_HeartRate", autoId,  username, samplerate, srUnitTimeId, maxHREstimationId, highRestHR, lowRestHR, hrvanalysisInteral, hrvUnitTimeId);
        return ToSQL.SQLToInt(b);
    }
    /**
     * get list heart rate give table
     * @see GetList_HeartRate_Table()
     * @return datatable
     */
    public DataTable GetList_HeartRate_Table(string username, DateTime? fromdate, DateTime? todate)
    {
        return GetDataTable("spGetList_HeartRate_Table", username, fromdate, todate);
    }
    public DataTable spGetList_HeartRate_HRV_Table_Default(string username)
    {
        return GetDataTable("spGetList_HeartRate_HRV_Table_Default");
    }
    /**
     * get list heart rate hrv give table
     * @see GetList_HeartRate_HRV_Table()
     * @return dataset
     */
    public DataSet GetList_HeartRate_HRV_Table(string username, DateTime? fromdate, DateTime? todate)
    {
        return GetDataSet("spGetList_HeartRate_HRV_Table", username, fromdate,todate);
    }
    /**
     * get list heart rate hrv give graph
     * @see GetList_HeartRate_HRV_Graph()
     * @return dataset
     */
    public DataSet GetList_HeartRate_HRV_Graph(string UserName, DateTime? fromdate, DateTime? todate)
    {
        return GetDataSet("spGetList_HeartRate_HRV_Graph", UserName, fromdate, todate);
    }
    /**
     * get list heart rate dafault give graph
     * @see GetList_HeartRate_Graph()
     * @return datatable
     */
    public DataTable GetList_HeartRate_Default(string UserName)
    {
        return GetDataTable("spGetList_HeartRate_Default", UserName);
    }
    
    /**
     * get list heart rate  give graph
     * @see GetList_HeartRate_Graph()
     * @return datatable
     */
    public DataTable GetList_HeartRate_Graph(string UserName, DateTime? fromdate, DateTime? todate)
    {
        return GetDataTable("spGetList_HeartRate_Graph", UserName, fromdate, todate);
    }

    /**
     * get list heart rate HRV Default give graph
     * @see GetList_HeartRate_Graph()
     * @return datatable
     */
    public DataTable GetList_HeartRate_HRV_Default(string UserName)
    {
        return GetDataTable("spGetList_HeartRate_Default", UserName);
    }

    #endregion

    #region SpO2
    /**
     * get info oxygen tracking mode type by id
     * @see GetInfo_SpO2_TrackingModeType()
     * @return datarow
     */
    public DataRow GetInfo_SpO2_TrackingModeType(int Id)
    {
        return GetDataRow("spGetInfo_SpO2_TrackingModeType", Id);
    }
    /**
     * get info oxygen by username
     * @see GetInfo_SpO2()
     * @return datarow
     */
    public DataRow GetInfo_SpO2(string username)
    {
        return GetDataRow("spGetInfo_SpO2", username);
    }
    /**
     * get list oxygen tracking mode type
     * @see GetList_SpO2_TrackingModeType()
     * @return datatable
     */
    public DataTable GetList_SpO2_TrackingModeType()
    {
        return GetDataTable("spGetList_SpO2_TrackingModeType");
    }
    /**
     * insert update oxygen
     * @see InsertUpdate_SpO2()
     * @return object
     */
    public object InsertUpdate_SpO2(int autoId, string username, decimal? SampleRate, int? SampleRateId, int? TrackingTypeId, decimal? Threshold, decimal? MeasurementValue, int? MeasurementId)
    {
        return ExecuteScalar("spInsertUpdate_SpO2", autoId, username, SampleRate, SampleRateId, TrackingTypeId, Threshold, MeasurementValue, MeasurementId);
    }
    /**
     * get list oxygen give table
     * @see GetList_SpO2_Table()
     * @return datatable
     */
    public DataTable GetList_SpO2_Table(string UserName, DateTime? fromdate, DateTime? todate)
    {
        return GetDataTable("spGetList_SpO2_Table", UserName, fromdate, todate);
    }
    /**
     * get list oxygen give graph
     * @see GetList_SpO2_Graph()
     * @return datatable
     */
    public DataTable GetList_SpO2_Graph(string UserName, DateTime? fromdate, DateTime? todate)
    {
        return GetDataTable("spGetList_SpO2_Graph", UserName, fromdate, todate);
    }

    /**
     * get list oxygen give Default graph
     * @see GetList_SpO2_Graph()
     * @return datatable
     */
    public DataTable GetList_SpO2_Default(string UserName)
    {
        return GetDataTable("spGetList_SpO2_Default", UserName);
    }

    /**
     * get list oxygen
     * @see GetList_SpO2_Datetime()
     * @return datatable
     */
    public DataTable GetList_SpO2_Datetime(string UserName, DateTime? FromDate, DateTime? ToDate)
    {
        return GetDataTable("spGetList_SpO2_Datetime", UserName, FromDate, ToDate);
    }

    #endregion

    #region Fitness
    /**
     * get list fitness hrexercise type
     * @see GetList_Fitness_HRExerciseType()
     * @return datatable
     */
    public DataTable GetList_Fitness_HRExerciseType()
    {
        return GetDataTable("spGetList_Fitness_HRExerciseType");
    }
    /**
     * get list fitness datetime
     * @see GetList_Fitness_Datetime()
     * @return datatable
     */
    public DataTable GetList_Fitness_Datetime(string UserName, DateTime? FromDate, DateTime? ToDate)
    {
        return GetDataTable("spGetList_Fitness_Datetime", UserName, FromDate, ToDate);
    }
    /**
     * get list fitness hr target type
     * @see GetList_Fitness_HRTargetType()
     * @return datatable
     */
    public DataTable GetList_Fitness_HRTargetType()
    {
        return GetDataTable("spGetList_Fitness_HRTargetType");
    }
    /**
     * get list fitness hr target type mutil
     * @see GetList_Fitness_HRTargetType_Mutil()
     * @return datatable
     */
    public DataTable GetList_Fitness_HRTargetType_Mutil()
    {
        return GetDataTable("spGetList_Fitness_HRTargetType_Mutil");
    }
    /**
     * get list fitness hr target type single
     * @see GetList_Fitness_HRTargetType_Single()
     * @return datatable
     */
    public DataTable GetList_Fitness_HRTargetType_Single()
    {
        return GetDataTable("spGetList_Fitness_HRTargetType_Single");
    }
    /**
     * get list fitness pm target type
     * @see GetList_Fitness_PMTargetType()
     * @return datatable
     */
    public DataTable GetList_Fitness_PMTargetType()
    {
        return GetDataTable("spGetList_Fitness_PMTargetType");
    }
    /**
     * get list fitness pm remind type
     * @see GetList_Fitness_PMRemindType()
     * @return datatable
     */
    public DataTable GetList_Fitness_PMRemindType()
    {
        return GetDataTable("spGetList_Fitness_PMRemindType");
    }
    /**
     * get list fitness pm calory burn type
     * @see GetList_Fitness_PMCaloryBurnType()
     * @return datatable
     */
    public DataTable GetList_Fitness_PMCaloryBurnType()
    {
        return GetDataTable("spGetList_Fitness_PMCaloryBurnType");
    }
    /**
     * get info fitness by username
     * @see GetInfo_Fitness()
     * @return datarow
     */
    public DataRow GetInfo_Fitness(string username)
    {
        return GetDataRow("spGetInfo_Fitness", username);
    }
    /**
     * insert update fitness
     * @see InsertUpdate_Fitness()
     * @return int
     */
    public int InsertUpdate_Fitness(int autoId, string username, int? HRExerciseId, int? HRTargetId, int? PMTargetId, int? PMRemindId, int? PMCaloryBurnId)
    {
        object b = ExecuteScalar("spInsertUpdate_Fitness", autoId, username, HRExerciseId, HRTargetId, PMTargetId, PMRemindId, PMCaloryBurnId);
        return ToSQL.SQLToInt(b);
    }
    /**
     * get list fitness pedometer give table
     * @see GetList_Fitness_Pedometer_Table()
     * @return datatable
     */
    public DataTable GetList_Fitness_Pedometer_Table(string UserName, DateTime? fromdate, DateTime? todate)
    {
        return GetDataTable("spGetList_Fitness_Pedometer_Table", UserName, fromdate, todate);
    }
    public DataTable GetList_Fitness_Pedometer_Default(string UserName)
    {
        return GetDataTable("spGetList_Fitness_Pedometer_Default", UserName);
    }
    /**
     * get list fitness hrexercise give table
     * @see GetList_Fitness_HRExercise_Table()
     * @return datatable
     */
    public DataTable GetList_Fitness_HRExercise_Table(string UserName, DateTime? fromdate, DateTime? todate)
    {
        return GetDataTable("spGetList_Fitness_HRExercise_Table", UserName, fromdate, todate);
    }
    public DataTable GetList_Fitness_HRExercise_Default(string UserName)
    {
        return GetDataTable("spGetList_Fitness_HRExercise_Default", UserName);
    }
    /**
     * get list fitness pedometer graph by parameter code
     * @see GetList_Fitness_Pedometer_Graph_ByParameterCode()
     * @return datatable
     */
    public DataTable GetList_Fitness_Pedometer_Graph_ByParameterCode(string UserName, DateTime? FromDate, DateTime? ToDate, string ParameterCode)
    {
        return GetDataTable("spGetList_Fitness_Pedometer_Graph_ByParameterCode", UserName, FromDate, ToDate, ParameterCode);
    }

    /**
     * get list fitness pedometer default graph by parameter code
     * @see GetList_Fitness_Pedometer_Graph_ByParameterCode()
     * @return datatable
     */
    public DataTable GetList_Fitness_Pedometer_Graph_Default(string UserName, string ParameterCode)
    {
        return GetDataTable("spGetList_Fitness_Pedometer_Graph_Default", UserName, ParameterCode);
    }

    /**
     * get info fitness hrexercise program by fitness id
     * @see GetInfo_Fitness_HRExercise_Program_ByFitnessId()
     * @return datarow
     */
    public DataRow GetInfo_Fitness_HRExercise_Program_ByFitnessId(int fitnessId)
    {
        return GetDataRow("spGetInfo_Fitness_HRExercise_Program_ByFitnessId", fitnessId);
    }
    /**
     * get info fitness hrexercise program by fitness program id
     * @see GetInfo_Fitness_HRExercise_Program_ByFitnessHRProgramId()
     * @return datatable
     */
    public DataTable GetInfo_Fitness_HRExercise_Program_ByFitnessHRProgramId(int fitnessHRProgramId)
    {
        return GetDataTable("spGetInfo_Fitness_HRExercise_Program_ByFitnessHRProgramId", fitnessHRProgramId);
    }
    /**
     * get list fitness zone type
     * @see GetList_Fitness_ZoneType()
     * @return datatable
     */
    public DataTable GetList_Fitness_ZoneType()
    {
        return GetDataTable("spGetList_Fitness_ZoneType");
    }
    /**
     * insert update fitness hrexercise program
     * @see InsertUpdate_Fitness_HRExercise_Program()
     * @return int
     */
    public int InsertUpdate_Fitness_HRExercise_Program(int fitnessId, string userName, int? numberOfStage, string programName, string transitionAudio)
    {
        object obj = ExecuteScalar("spInsertUpdate_Fitness_HRExercise_Program", fitnessId, userName, numberOfStage, programName, transitionAudio);
        return ToSQL.SQLToInt(obj);
    }
    /**
     * insert update fitness hrexercise program details
     * @see InsertUpdate_Fitness_HRExercise_Program_Details()
     * @return int
     */
    public int InsertUpdate_Fitness_HRExercise_Program_Details(int fitnessHRProgramId, string stages, string zoneIds, string timeValues, string timeIds)
    {
        return ExecuteNonQuery("spInsertUpdate_Fitness_HRExercise_Program_Details", fitnessHRProgramId, stages, zoneIds, timeValues, timeIds);
    }
    #endregion

    #region Stress
    /**
     * get info stress by username
     * @see GetInfo_Stress()
     * @return datarow
     */
    public DataRow GetInfo_Stress(string username)
    {
        return GetDataRow("spGetInfo_Stress", username);
    }
    /**
     * insert update stress
     * @see InsertUpdate_Stress()
     * @return int
     */
    public int InsertUpdate_Stress(int autoId, string username, decimal? MeasureDuration, int? MDUnitTimeId, decimal? HRSampleRate, int? HRSRUnitTimeId, decimal? GSRSampleRate, int? GSRSRUnitTimeId, decimal? AccelSampleRate, int? ASRUnitTimeId)
    {
        object b = ExecuteScalar("spInsertUpdate_Stress", autoId, username, MeasureDuration, MDUnitTimeId, HRSampleRate, HRSRUnitTimeId, GSRSampleRate, GSRSRUnitTimeId, AccelSampleRate, ASRUnitTimeId);
        return ToSQL.SQLToInt(b);
    }
    /**
     * get list stress give table
     * @see GetList_Stress_Rawdata_Table()
     * @return datatable
     */
    public DataTable GetList_Stress_Rawdata_Table(string UserName, DateTime? fromdate, DateTime? todate)
    {
        return GetDataTable("spGetList_Stress_Rawdata_Table", UserName, fromdate, todate);
    }
    /**
     * get list stress give table
     * @see GetList_Stress_Table()
     * @return datatable
     */
    public DataTable GetList_Stress_Table(string UserName, DateTime? FromDate, DateTime? ToDate)
    {
        return GetDataTable("spGetList_Stress_Table", UserName, FromDate, ToDate);
    }

    /**
     * get list stress give default table
     * @see GetList_Stress_Table()
     * @return datatable
     */
    public DataTable GetList_Stress_Default(string UserName)
    {
        return GetDataTable("spGetList_Stress_Default", UserName);
    }

    /**
     * get list stress give graph
     * @see GetList_Stress_Rawdata_Graph()
     * @return datatable
     */
    public DataTable GetList_Stress_Rawdata_Graph(string UserName, DateTime? fromdate, DateTime? todate)
    {
        return GetDataTable("spGetList_Stress_Rawdata_Graph", UserName, fromdate, todate);
    }

    /**
     * get list stress give raw data default graph
     * @see spGetList_Stress_RawData_Default()
     * @return datatable
     */
    public DataTable GetList_Stress_RawData_Default(string UserName)
    {
        return GetDataTable("spGetList_Stress_RawData_Default", UserName);
    }

    /**
     * get list stress
     * @see GetList_Stress_Datetime()
     * @return datatable
     */
    public DataTable GetList_Stress_Datetime(string UserName, DateTime? FromDate, DateTime? ToDate)
    {
        return GetDataTable("spGetList_Stress_Datetime", UserName, FromDate, ToDate);
    }

    #endregion

    #region Fertility
    /**
     * get info Fertility by username
     * @see GetInfo_Fertility()
     * @return datarow
     */
    public DataRow GetInfo_Fertility(string username)
    {
        return GetDataRow("spGetInfo_Fertility", username);
    }
    /**
     * insert update Fertility
     * @see InsertUpdate_Fertility()
     * @return object
     */
    public object InsertUpdate_Fertility(int AutoId, string username, bool IsInputAuto)
    {
        return ExecuteScalar("spInsertUpdate_Fertility", AutoId, username, IsInputAuto);
    }
    /**
     * get list Fertility give table
     * @see GetList_Fertility_Table()
     * @return datatable
     */
    public DataTable GetList_Fertility_Table(string UserName, DateTime? FromDate, DateTime? ToDate)
    {
        return GetDataTable("spGetList_Fertility_Table", UserName, FromDate, ToDate);
    }
    /**
     * get list Fertility tempertaure
     * @see GetList_Fertility_Temperature()
     * @return datatable
     */
    public DataTable GetList_Fertility_Temperature(string UserName, DateTime FromDate, DateTime ToDate)
    {
        return GetDataTable("spGetList_Fertility_Temperature", UserName, FromDate, ToDate);
    }
    /**
     * get list Fertility give graph
     * @see GetList_Fertility_Graph()
     * @return datatable
     */
    public DataTable GetList_Fertility_Graph(string UserName, DateTime FromDate, DateTime ToDate)
    {
        return GetDataTable("spGetList_Fertility_Graph", UserName, FromDate, ToDate);
    }

    #endregion

    #region Position
    /**
     * get info Position by username
     * @see GetInfo_Position()
     * @return datarow
     */
    public DataRow GetInfo_Position(string username)
    {
        return GetDataRow("spGetInfo_Position", username);
    }
    /**
     * insert update Position
     * @see InsertUpdate_Position()
     * @return int
     */
    public int InsertUpdate_Position(int autoId, string username, decimal? SampleRate, int? SampleRateId, bool IsSupine, bool IsProne, bool IsLeft, bool IsRight, bool IsUp, bool IsDown)
    {
        object b = ExecuteScalar("spInsertUpdate_Position",autoId, username, SampleRate, SampleRateId, IsSupine, IsProne, IsLeft, IsRight, IsUp, IsDown);
        return ToSQL.SQLToInt(b);
    }
    /**
     * get list data Position give table
     * @see GetList_Position_Table()
     * @return datatable
     */
    public DataTable GetList_Position_Table(string UserName, DateTime? fromdate, DateTime? todate)
    {
        return GetDataTable("spGetList_Position_Table", UserName, fromdate, todate);
    }
    /**
     * get list Position give graph
     * @see GetList_Position_Graph()
     * @return datatable
     */
    public DataTable GetList_Position_Graph(string UserName, DateTime? FromDate, DateTime? ToDate)
    {
        return GetDataTable("spGetList_Position_Graph", UserName, FromDate, ToDate);
    }

    /**
     * get list Position default give graph
     * @see spGetList_Position_Default()
     * @return datatable
     */
    public DataTable GetList_Position_Default(string UserName)
    {
        return GetDataTable("spGetList_Position_Default", UserName);
    }

    /**
     * get list Position give table
     * @see GetList_Position_XYZ_Rawdata_Table()
     * @return datatable
     */
    public DataTable GetList_Position_XYZ_Rawdata_Table(string UserName, DateTime? fromdate, DateTime? todate)
    {
        return GetDataTable("spGetList_Position_XYZ_Rawdata_Table", UserName, fromdate, todate);
    }

    /**
     * get list Position give table
     * @see GetList_Position_XYZ_Rawdata_Graph()
     * @return datatable
     */
    public DataTable GetList_Position_XYZ_Rawdata_Graph(string UserName, DateTime? fromdate, DateTime? todate)
    {
        return GetDataTable("spGetList_Position_XYZ_Rawdata_Graph", UserName, fromdate, todate);
    }

    /**
     * get list Position give table
     * @see GetList_Position_XYZ_Rawdata_Graph_Default()
     * @return datatable
     */
    public DataTable GetList_Position_XYZ_Rawdata_Graph_Default(string UserName)
    {
        return GetDataTable("spGetList_Position_XYZ_Rawdata_Graph_Default", UserName);
    }

    /**
     * get list Position datetime
     * @see GetList_Position_Datetime()
     * @return datatable
     */
    public DataTable GetList_Position_Datetime(string UserName, DateTime? FromDate, DateTime? ToDate)
    {
        return GetDataTable("spGetList_Position_Datetime", UserName, FromDate, ToDate);
    }
 
    #endregion

    #region Sleep

    /**
     * get list sleep datetime
     * @see GetList_Sleep_Datetime()
     * @return datatable
     */
    public DataTable GetList_Sleep_Datetime(string UserName, DateTime? FromDate, DateTime? ToDate)
    {
        return GetDataTable("spGetList_Sleep_Datetime", UserName, FromDate, ToDate);
    }
    /**
     * get info sleep by username
     * @see GetInfo_Sleep()
     * @return datarow
     */
    public DataRow GetInfo_Sleep(string username)
    {
        return GetDataRow("spGetInfo_Sleep", username);
    }
    /**
     * insert update sleep
     * @see InsertUpdate_Sleep()
     * @return int
     */
    public int InsertUpdate_Sleep(int autoId, string username, decimal? HRSampleRate, int? HRSampleRateId, decimal? GSRSampleRate, int? GSRSampleRateId, decimal? AccSampleRate, int? AccSampleRateId, decimal? SkinTempSampleRate, int? SkinTempSampleRateId, bool IsAlarmSetting, decimal? SleepDuration, int? SleepDurationId)
    {
        object b = ExecuteScalar("spInsertUpdate_Sleep", autoId, username, HRSampleRate, HRSampleRateId, GSRSampleRate, GSRSampleRateId, AccSampleRate, AccSampleRateId, SkinTempSampleRate, SkinTempSampleRateId, IsAlarmSetting, SleepDuration, SleepDurationId);
        return ToSQL.SQLToInt(b);
    }
    /**
     * get list sleep manual by id
     * @see GetList_Sleep_Manual_BySleepId()
     * @return datatable
     */
    public DataTable GetList_Sleep_Manual_BySleepId(int SleepId)
    {
        return GetDataTable("spGetList_Sleep_Manual_BySleepId", SleepId);
    }
    /**
     * insert update sleep manual
     * @see InsertUpdate_Sleep_Manual()
     * @return int
     */
    public int InsertUpdate_Sleep_Manual(int sleepId, string names, string unitDateIds, string unitTimeValues, string unitTimeIds)
    {
        object b = ExecuteScalar("spInsertUpdate_Sleep_Manual", sleepId, names, unitDateIds, unitTimeValues, unitTimeIds);
        return ToSQL.SQLToInt(b);
    }
    /**
     * get list sleep
     * @see GetList_Sleep_Rawdata()
     * @return datatable
     */
    public DataTable GetList_Sleep_Rawdata(string UserName, DateTime? fromdate, DateTime? todate)
    {
        return GetDataTable("spGetList_Sleep_Rawdata", UserName, fromdate, todate);
    }

    /**
     * get list sleep raw data default
     * @see GetList_Sleep_Rawdata()
     * @return datatable
     */
    public DataTable GetList_Sleep_Rawdata_Default(string UserName)
    {
        return GetDataTable("spGetList_Sleep_Rawdata_Default", UserName);
    }

    #endregion

    #endregion
}