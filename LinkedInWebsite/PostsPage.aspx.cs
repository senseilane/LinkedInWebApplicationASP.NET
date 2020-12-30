using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Threading;

namespace LinkedIn_Website
{
    public partial class PostsPage : System.Web.UI.Page
    {
        string current = DateTime.Now.ToString();
        protected void Page_Load(object sender, EventArgs e)
        {
           lblName.Text = "Welcome back " + Request.Cookies["nameCookie"].Value + "!";
        }

        protected void btnPost_Click(object sender, EventArgs e)
        {
            //Inserts the name, date, and post text.
            if (txtPost.Value != "")
            {
                lblError.Text = string.Empty;
                try
                {
                    SqlDataSource1.InsertCommandType = SqlDataSourceCommandType.Text;
                    SqlDataSource1.InsertCommand = "Insert into Updates (Name, Date, Post) VALUES (@Name, @Date, @Post)";
                    SqlDataSource1.InsertParameters.Add("Name", Request.Cookies["nameCookie"].Value);
                    SqlDataSource1.InsertParameters.Add("Date", current);
                    SqlDataSource1.InsertParameters.Add("Post", txtPost.Value);
                    SqlDataSource1.Insert();
                    txtPost.Value = "";
                }
                catch
                {
                    lblError.Text = "Something went wrong.";
                }
            }
            else
            {
                lblError.Text = "Please write something before posting.";
            }
        }

        protected void gvPostUpdates_PreRender(object sender, EventArgs e)
        {
            if (gvPostUpdates.HeaderRow != null)
                gvPostUpdates.HeaderRow.TableSection = TableRowSection.TableHeader;
        }

        protected void btnLogout_Click(object sender, EventArgs e)
        {
            //Deletes the cookie and then redirects to login
            Response.Cookies["nameCookie"].Expires = DateTime.Now.AddSeconds(-30);
            Response.Redirect("LogIn");
        }
    }
}