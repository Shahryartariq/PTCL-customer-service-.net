using System;
using System.Security.Cryptography;
using System.Text;
using Konscious.Security.Cryptography;

namespace PtclCustomerService
{
    /// <summary>
    /// Argon2id password hashing for customers and admins.
    /// New hashes get their own random salt and are stored as "v2$salt$hash".
    /// Hashes made with the old fixed salt still work and are upgraded on the next login.
    /// </summary>
    public static class PasswordHasher
    {
        private const string Prefix = "v2$";
        private const string OldSalt = "SherryBSSE40";

        public static string Hash(string password)
        {
            byte[] salt = new byte[16];
            using (RandomNumberGenerator rng = RandomNumberGenerator.Create())
            {
                rng.GetBytes(salt);
            }
            return Prefix + Convert.ToBase64String(salt) + "$" + Convert.ToBase64String(Compute(password, salt));
        }

        public static bool Verify(string password, string storedHash)
        {
            if (string.IsNullOrEmpty(password) || string.IsNullOrEmpty(storedHash)) return false;

            byte[] salt;
            byte[] expected;
            try
            {
                if (storedHash.StartsWith(Prefix))
                {
                    string[] parts = storedHash.Substring(Prefix.Length).Split('$');
                    if (parts.Length != 2) return false;
                    salt = Convert.FromBase64String(parts[0]);
                    expected = Convert.FromBase64String(parts[1]);
                }
                else
                {
                    salt = Encoding.UTF8.GetBytes(OldSalt);
                    expected = Convert.FromBase64String(storedHash);
                }
            }
            catch (FormatException)
            {
                return false;
            }

            byte[] actual = Compute(password, salt);
            if (actual.Length != expected.Length) return false;

            // compare every byte so the time taken doesn't depend on where they differ
            int diff = 0;
            for (int i = 0; i < actual.Length; i++)
            {
                diff |= actual[i] ^ expected[i];
            }
            return diff == 0;
        }

        /// <summary>True for hashes made with the old fixed salt.</summary>
        public static bool IsOldHash(string storedHash)
        {
            return storedHash == null || !storedHash.StartsWith(Prefix);
        }

        private static byte[] Compute(string password, byte[] salt)
        {
            var argon2 = new Argon2id(Encoding.UTF8.GetBytes(password));
            argon2.Salt = salt;
            argon2.DegreeOfParallelism = 8;
            argon2.Iterations = 4;
            argon2.MemorySize = 8194;
            return argon2.GetBytes(16);
        }
    }
}
