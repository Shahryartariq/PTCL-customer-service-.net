using System;
using System.IO;
using System.Web;
using System.Web.UI.WebControls;

namespace PtclCustomerService
{
    /// <summary>
    /// Saves uploaded pictures and attachments under ~/UploadFiles.
    /// Every file gets a new unique name, so two uploads called "1.jpg" don't overwrite each other.
    /// </summary>
    public static class Uploads
    {
        public const int MaxBytes = 2 * 1024 * 1024; // 2 MB

        public static readonly string[] Images = { ".jpg", ".jpeg", ".png" };
        public static readonly string[] ImagesAndPdf = { ".jpg", ".jpeg", ".png", ".pdf" };

        /// <summary>
        /// Returns the saved file name, or null when nothing was uploaded or the file was rejected
        /// (then error says why).
        /// </summary>
        public static string Save(FileUpload upload, string folder, string[] allowed, out string error)
        {
            error = null;
            if (upload == null || !upload.HasFile) return null;

            string extension = Path.GetExtension(upload.FileName).ToLowerInvariant();
            if (Array.IndexOf(allowed, extension) < 0)
            {
                error = "Only " + string.Join(", ", allowed).Replace(".", "").ToUpperInvariant() + " files are allowed";
                return null;
            }

            byte[] bytes = upload.FileBytes;
            if (bytes.Length > MaxBytes)
            {
                error = "The file must be 2 MB or smaller";
                return null;
            }
            if (!LooksLike(extension, bytes))
            {
                error = "The file is not a real " + extension.TrimStart('.').ToUpperInvariant() + " file";
                return null;
            }

            string fileName = Guid.NewGuid().ToString("N") + extension;
            string path = HttpContext.Current.Server.MapPath("~/UploadFiles/" + folder + "/" + fileName);
            Directory.CreateDirectory(Path.GetDirectoryName(path));
            File.WriteAllBytes(path, bytes);
            return fileName;
        }

        // checks the first bytes of the file, not just its name
        private static bool LooksLike(string extension, byte[] b)
        {
            switch (extension)
            {
                case ".png":
                    return b.Length > 4 && b[0] == 0x89 && b[1] == 0x50 && b[2] == 0x4E && b[3] == 0x47;
                case ".jpg":
                case ".jpeg":
                    return b.Length > 3 && b[0] == 0xFF && b[1] == 0xD8 && b[2] == 0xFF;
                case ".pdf":
                    return b.Length > 4 && b[0] == 0x25 && b[1] == 0x50 && b[2] == 0x44 && b[3] == 0x46;
                default:
                    return false;
            }
        }
    }
}
