using System;
using System.Net.Mail;

/// <summary>
/// Summary description for Email
/// </summary>
public class Email
{
    public Email()
    {
        //
        // TODO: Add constructor logic here
        //
    }

    public static bool SendEmail(string toadd, string subject, string msg, string cc = "", string bcc = "", string attachedfile = null)
    {
        MailMessage message = new MailMessage();
        SmtpClient client = new SmtpClient();
        try
        {
            string SendingEmail = "", MailServer = "", SendingPassword = "";
            SendingEmail = "muhammadshehryart@gmail.com";
            MailServer = "smtp.gmail.com"; //If use Hotmail/outlook then change the server name accordingly
            SendingPassword = "Pakistan123_";
            int ServerPort = 587;

            message.IsBodyHtml = true;

            message.From = new MailAddress(SendingEmail, "Noreply");

            message.To.Add(new MailAddress(toadd));

            if (cc != "")
            {
                message.CC.Add(new MailAddress(cc.ToString()));
            }

            if (bcc != "")
            {
                message.Bcc.Add(new MailAddress(bcc.ToString()));
            }
            //if (attachedfile != null)
            //{
            //    Attachment attach = null;
            //    string[] attachArr = attachedfile.Split('*');
            //    foreach (string obj in attachArr)
            //    {
            //        attach = new System.Net.Mail.Attachment(obj);
            //        message.Attachments.Add(attach);
            //    }
            //}
            message.Body = msg;
            message.Subject = subject;

            client.Host = MailServer;
            client.Port = ServerPort;
            client.EnableSsl = true;
            client.UseDefaultCredentials = true;
            client.Credentials = new System.Net.NetworkCredential(SendingEmail, SendingPassword);
            client.DeliveryMethod = SmtpDeliveryMethod.Network;
            client.Send(message);
            return true;
        }
        catch (Exception ex)
        {
            return false;
        }
        finally
        {
            message = null;
            client = null;
        }
    }
}