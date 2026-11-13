using System;
using System.Web;
using System.Web.Security;

namespace PtclCustomerService
{
    /// <summary>
    /// "Remember me" cookie for users and admins.
    /// The cookie value is encrypted and signed with the machine key, so it
    /// cannot be edited to log in as another user or admin.
    /// </summary>
    public static class AuthCookie
    {
        private const string CookieName = "PCS";

        public static void Save(HttpResponse response, string role, int id, string name, int days)
        {
            var ticket = new FormsAuthenticationTicket(1, role + "|" + id, DateTime.Now,
                DateTime.Now.AddDays(days), true, name ?? "");

            var cookie = new HttpCookie(CookieName, FormsAuthentication.Encrypt(ticket));
            cookie.HttpOnly = true;
            cookie.Expires = ticket.Expiration;
            response.Cookies.Add(cookie);
        }

        public static bool TryRead(HttpRequest request, string role, out int id, out string name)
        {
            id = 0;
            name = null;

            HttpCookie cookie = request.Cookies[CookieName];
            if (cookie == null || string.IsNullOrEmpty(cookie.Value)) return false;

            FormsAuthenticationTicket ticket;
            try
            {
                ticket = FormsAuthentication.Decrypt(cookie.Value);
            }
            catch (Exception)
            {
                return false; // old or edited cookie
            }
            if (ticket == null || ticket.Expired) return false;

            string[] parts = ticket.Name.Split('|');
            if (parts.Length != 2 || parts[0] != role || !int.TryParse(parts[1], out id)) return false;

            name = ticket.UserData;
            return true;
        }
    }
}
