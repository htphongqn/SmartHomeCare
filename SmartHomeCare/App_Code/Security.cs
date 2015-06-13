using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.IO;
using System.Text;
using System.Security.Cryptography;
using System.Net;

/**
* \brief all security method.
*/
public class Security
{
	public Security()
	{

	}
    /**
     * Get version update
     */
    public static string GetVersion()
    {
        return "Last updated on: 1/17/2014 17:00 GTM+7" + "(by phong.huynh)";
    }
    /**
     * Encrypt 1 string
     * @see Encrypt()
     * @param key is key encrypt
     * @param toEncrypt is value encrypt
     */
    public string Encrypt(string key, string toEncrypt)
    {
        byte[] keyArray;
        byte[] toEncryptArray = UTF8Encoding.UTF8.GetBytes(toEncrypt);
        MD5CryptoServiceProvider hashmd5 = new MD5CryptoServiceProvider();
        keyArray = hashmd5.ComputeHash(UTF8Encoding.UTF8.GetBytes(key));
        TripleDESCryptoServiceProvider tdes =
        new TripleDESCryptoServiceProvider();
        tdes.Key = keyArray;
        tdes.Mode = CipherMode.ECB;
        tdes.Padding = PaddingMode.PKCS7;
        ICryptoTransform cTransform = tdes.CreateEncryptor();
        byte[] resultArray = cTransform.TransformFinalBlock(
            toEncryptArray, 0, toEncryptArray.Length);
        return Convert.ToBase64String(resultArray, 0, resultArray.Length);
    }
    /**
     * Decrypt 1 string
     * @see Decrypt()
     * @param key is key Decrypt
     * @param toEncrypt is value Decrypt
     */
    public string Decrypt(string key, string toDecrypt)
    {
        byte[] keyArray;
        byte[] toEncryptArray = Convert.FromBase64String(toDecrypt);

        MD5CryptoServiceProvider hashmd5 = new MD5CryptoServiceProvider();
        keyArray = hashmd5.ComputeHash(UTF8Encoding.UTF8.GetBytes(key));

        TripleDESCryptoServiceProvider tdes = new TripleDESCryptoServiceProvider();
        tdes.Key = keyArray;
        tdes.Mode = CipherMode.ECB;
        tdes.Padding = PaddingMode.PKCS7;
        ICryptoTransform cTransform = tdes.CreateDecryptor();
        byte[] resultArray = cTransform.TransformFinalBlock(
        toEncryptArray, 0, toEncryptArray.Length);
        return UTF8Encoding.UTF8.GetString(resultArray);
    }
    /**
     * create 1 string random
     * @see GenerateRandomCode()
     */
    public static string GenerateRandomCode()
    {
        //ACDEFGHJKLNPQRTUVXYZ2346789
        Random random = new Random();
        string s = "";
        for (int i = 0; i < 5; i++)
            s = String.Concat(s, random.Next(10).ToString());
        return s;
    }
    /**
     * get ip client(browser ip)
     * @see GetClientIP()
     */
    public static string GetClientIP()
    {
        string ip;
        ip = HttpContext.Current.Request.ServerVariables["REMOTE_ADDR"];
        return ip;
    }
    /**
     * get ip server(local ip)
     * @see GetServerIP()
     */
    public static string GetServerIP()
    {
        string ip;
        ip = HttpContext.Current.Request.ServerVariables["LOCAL_ADDR"];
        return ip;
    }
}