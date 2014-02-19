using Galleriet.Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;

namespace Galleriet
{
    public partial class Galleriet : System.Web.UI.Page
    {
        private Gallery _gallery;
        // return _gallery if not null, otherwise create new instance of Gallery
        private Gallery MyGallery { get { return _gallery ?? (_gallery = new Gallery()); } }

        protected void Page_Load(object sender, EventArgs e)
        {
            // Visa MainImage om det finns en QueryString i URL'en
            string qstr = Request.QueryString["name"];
            if (qstr != null)
            {
                MainImage.ImageUrl = "Content/Images/" + qstr;
                MainImage.Visible = true;
            }

            if (HasMessage)
            {
                Literal1.Visible = true;
                Literal1.Text = Message;
            }
        }

        // sessionsvariabel för felmeddelande
        public string Message
        {
            get
            {
                var message = Session["message"] as string;
                Session.Remove("message");
                return message;
            }

            set { Session["message"] = value; }
        }

        private bool HasMessage
        {
            get { return Session["message"] != null; }
        }

        protected void UploadButton_Click(object sender, EventArgs e)
        {
            if (IsValid)
            {
                try
                {
                    var file = MyGallery.SaveImage(FileUpload1.FileContent, FileUpload1.FileName);
                    Message = String.Format("Bilden {0} har sparats.", FileUpload1.FileName);
                    Response.Redirect(Request.Path + "?name=" + FileUpload1.FileName);
                }
                catch (Exception ex)
                {
                    ModelState.AddModelError(String.Empty, ex.Message);
                }
            }
        }

        public IEnumerable<System.String> Repeater1_GetData()
        {
            return MyGallery.GetImageNames();
        }
    }
}