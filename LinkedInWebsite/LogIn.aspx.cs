using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Text.RegularExpressions;

namespace LinkedIn_Website
{
    public partial class LogIn : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            //Uses the cookie on pageload for locking user out.
            HttpCookie loadNumber = Request.Cookies["countCookie"];
            if(loadNumber != null)
            {
                if(int.Parse(Request.Cookies["countCookie"].Value) >= 4)
                {
                    lblErrorMessage.Visible = false;
                    studentEmail.Disabled = true;
                    studentPassword.Disabled = true;
                    lblLockout.Visible = true;
                    lblLockout.Text = "Too many invalid attempts.\nLocked out.";
                }
            }
            studentEmail.Focus();
        }
        public void clearBoxes()
        {
            studentEmail.Value = "";
            studentPassword.Value = "";
            studentEmail.Focus();
        }
        protected void btnLogin_Click(object sender, EventArgs e)
        {
            //Read the data from the Users database and compare the passwords.
            string storedPassword = "", name = "";
            string email = this.studentEmail.Value;
            string password = this.studentPassword.Value;
            SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["UpdateDatabase"].ConnectionString);
            con.Open();
            string selectString = "Select Password, Name FROM Users WHERE Email= '" + email + "'";
            SqlCommand cmd = new SqlCommand(selectString, con);
            SqlDataReader reader = cmd.ExecuteReader();
            while (reader.Read())
            {
                storedPassword = reader[0].ToString();
                name = reader[1].ToString();

                //cookie for the name on post page.
                HttpCookie nameCookie = Request.Cookies["nameCookie"];
                Response.Cookies["nameCookie"].Value = name;
            }

            //Cookie for tracking log in attempts and locking out the user.
            HttpCookie numberCookie = Request.Cookies["countCookie"];

            if (numberCookie == null)
            {
                Response.Cookies["countCookie"].Value = "0";
            }
            else
            {
                int count = int.Parse(Request.Cookies["countCookie"].Value.ToString());
                ++count;
                Response.Cookies["countCookie"].Value = count.ToString();
                if (count >= 4)
                {
                    lblErrorMessage.Visible = false;
                    studentEmail.Disabled = true;
                    studentPassword.Disabled = true;
                    lblLockout.Visible = true;
                    lblLockout.Text = "Too many invalid attempts.\nLocked out.";
                }
            }
            //Check for empty input boxes and invlaid password.
            //Create regex
            Regex regex = new Regex(@"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$");
            if (email == "")
            {
                clearBoxes();
                lblErrorMessage.Text = "Please enter an email address.";
            }
            else if (password == "")
            {
                clearBoxes();
                lblErrorMessage.Text = "Please enter your password.";
            }
            else if (!regex.IsMatch(password))
            {
                clearBoxes();
                lblErrorMessage.Text = "Invalid password.";
            }
            else if (password != storedPassword)
            {
                clearBoxes();
                lblErrorMessage.Text = "Invalid password.";
            }
            else
            {
                Response.Cookies["countCookie"].Expires = DateTime.Now.AddSeconds(-30);
                Response.Redirect("PostsPage");
                con.Close();
            }
        }
    }
}