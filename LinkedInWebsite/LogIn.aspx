<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="LogIn.aspx.cs" Inherits="LinkedIn_Website.LogIn" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Log In</title>
    <link href="Content/bootstrap.css" rel="stylesheet" />
    <script src="Scripts/jquery-3.5.1.js"></script>
    <script src="Scripts/bootstrap.js"></script>
</head>
<body>
     <form id="form1">
        <div>
            <div class="container-fluid">
                <div class="jumbotron shadow-sm" style="background-color:ghostwhite">
                    <img src="Images/LI-Logo.png" style="height:80px; width:auto"/>
                </div>
            </div>
        </div>
    </form>
    <div class="container">
        <form id="form2" class="d-flex justify-content-center" runat="server">
            <div class="form-group p-5 m-5 border shadow-sm" style="border-color:#0e76a8;">
                <div class="d-flex justify-content-center p-1">
                    <h2 style="color:#0e76a8">Please Sign In</h2>
                </div>
                <div class="p-1">
                    <label for="studentEmail" id="lblEmail" class="sr-only">Student Email</label>
                    <input type="email" runat="server" class="form-control shadow-sm" id="studentEmail" placeholder="Student Email" />
                </div>
                <div class="p-1">
                    <label for="studentPassword" class="sr-only">Password</label>
                    <input runat="server" type="password" class="form-control shadow-sm" id="studentPassword" placeholder="Password" />
                </div>
                <div>
                    <asp:Label ID="lblErrorMessage" CssClass="text-danger" runat="server" Text="" Enabled="False" Visible="true"></asp:Label>
                    <asp:Label ID="lblLockout" CssClass="text-danger" runat="server" Text="" Visible="false"></asp:Label>
                </div>
                <div class="d-flex justify-content-center pt-4">
                    <asp:Button ID="btnLogin" class="shadow-sm" runat="server" Text="Login" style="color:#0e76a8" OnClick="btnLogin_Click" CausesValidation="False"/>
                </div>
            </div>
        </form>
    </div>
     
</body>
</html>
