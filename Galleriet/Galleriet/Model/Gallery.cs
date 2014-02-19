using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text.RegularExpressions;
using System.Web;
using System.Drawing;
using System.Drawing.Imaging;


namespace Galleriet.Model
{
    public class Gallery
    {
        private static readonly Regex ApprovedExtensions, SanitizePath;
        private static readonly string PhysicalUploadedImagesPath;

        static Gallery()
        {
            ApprovedExtensions = new Regex("(.jpg|.gif|.png)", RegexOptions.IgnoreCase);
            var invalidChars = new string(Path.GetInvalidFileNameChars());
            SanitizePath = new Regex(string.Format("[{0}]", Regex.Escape(invalidChars)));
            PhysicalUploadedImagesPath = Path.Combine(AppDomain.CurrentDomain.GetData("APPBASE").ToString(), @"Content\Images");
        }

        // ger bildernas filnamn sorterade i bokstavsordning
        public IEnumerable<string> GetImageNames()
        {
            var di = new DirectoryInfo(PhysicalUploadedImagesPath);

            return (from fi in di.GetFiles()
                    where ApprovedExtensions.IsMatch(fi.Name)
                    orderby fi.Name ascending
                    select fi.Name);
        }

        // returnera true om en bild med angivet namn finns i katalogen för uppladdade bilder
        public static bool ImageExists(string name)
        {
            return File.Exists(Path.Combine(PhysicalUploadedImagesPath, name));
        }

        // returnera true om den uppladdade filens innehåll verkligen är av typen gif, jpeg eller png
        public static bool IsValidImage(Image image)
        {
            return image.RawFormat.Guid == ImageFormat.Gif.Guid
                || image.RawFormat.Guid == ImageFormat.Png.Guid
                || image.RawFormat.Guid == ImageFormat.Jpeg.Guid;
        }

        public string SaveImage(Stream stream, string fileName)
        {
            var image = Image.FromStream(stream);
            fileName = SanitizePath.Replace(fileName, String.Empty);

            if (!IsValidImage(image))
            {
                throw new ArgumentException("Filen är ej av rätt MIME-typ!");
            }

            int i = 2;
            // regex för att detektera tidigare namndubletter
            var sameName = new Regex("(\\([^\\)]+\\))");
            while (ImageExists(fileName))
            {
                fileName = sameName.Replace(fileName, "");
                fileName = String.Format("{0}{1}{2}{3}{4}", Path.GetFileNameWithoutExtension(fileName), "(", i++, ")", Path.GetExtension(fileName));
            }

            try
            {
                image.Save(Path.Combine(PhysicalUploadedImagesPath, fileName));

                var thumbnail = image.GetThumbnailImage(60, 32, null, System.IntPtr.Zero);
                thumbnail.Save(PhysicalUploadedImagesPath + @"\Thumbnails\" + fileName);
            }
            catch (Exception)
            {
                throw new ArgumentException("Det gick inte att spara filen.");
            }

            return fileName;
        }


    }
}