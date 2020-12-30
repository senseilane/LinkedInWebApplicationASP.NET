<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PostsPage.aspx.cs" Inherits="LinkedIn_Website.PostsPage" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Updates</title>
    <link href="Content/bootstrap.css" rel="stylesheet" />
    <script src="Scripts/jquery-3.5.1.js"></script>
    <script src="Scripts/bootstrap.js"></script>
    <style type="text/css">
     /*   .fixedHeader
        {
           overflow: auto;
           height: 150px;
        }
        table th
        {
           border-width: 4px;
           border-color: Black;
           background-color: ghostwhite;
           color: #0E76A8;
           position: relative;
           top: expression(this.parentNode.parentNode.
                           parentNode.scrollTop-1);
        }*/
    </style>
</head>
<body>
    <form id="form1">
        <div>
            <div class="container-fluid">
                <div class="jumbotron shadow-sm" style="background-color:ghostwhite;">
                    <img src="Images/LI-Logo.png" style="height:80px; width:auto"/>
                    <div style="padding:1em 1em 0em 0em; color:#0E76A8"><h2><asp:Label ID="lblName" runat="server" Text=""></asp:Label></h2></div>
                </div>
            </div>
        </div>
    </form>
    <form id="form2" runat="server" class="container align-self-center">
        <%--<div class="fixedHeader">
            <table style="width: 100%;">
                <tr>
                    <th scope="col">Name</th>
                    <th scope="col">Date</th>
                    <th scope="col">Post</th>
                </tr>
            </table>
        </div>--%>
        <div id="grid" class="form-group col-md-7 mx-sm-auto" style="height:500px; overflow: scroll; overflow:auto;"> <!--I used the auto to attempt to make the gridview scroll automatically-->
            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:UpdateDatabase %>" SelectCommand="SELECT [Name], [Date], [Post] FROM [Updates]"></asp:SqlDataSource>
            <asp:GridView ID="gvPostUpdates" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource1" AllowSorting="False" 
                CssClass="table table-bordered table-condensed" OnPreRender="gvPostUpdates_PreRender" HorizontalAlign="Center" BorderStyle="None">
                <Columns>
                    <asp:BoundField DataField="Name" HeaderText="Name" SortExpression="Name"></asp:BoundField>
                    <asp:BoundField DataField="Date" HeaderText="Date" SortExpression="Date"></asp:BoundField>
                    <asp:BoundField DataField="Post" HeaderText="Post" SortExpression="Post"></asp:BoundField>
                    
                </Columns>
                <HeaderStyle HorizontalAlign="Center" ForeColor="#0E76A8" />
            </asp:GridView>
        </div>
        <div class="col-md-7 mx-sm-auto">
            
            <div class="justify-content-center">
                <textarea runat="server" id="txtPost" name="S1" placeholder="Post here..." class="w-100"></textarea>
            </div>
            <div class="d-flex justify-content-center">
                <asp:Button ID="btnPost" runat="server" Text="Post" style="color:#0e76a8; margin-right:.2em; padding:0 1em 0 1em;" CausesValidation="False" OnClick="btnPost_Click" />
                <asp:Button ID="btnLogout" runat="server" Text="Log Out" style="color:#0e76a8; margin-left:.2em;" OnClick="btnLogout_Click" />
            </div>
            <div>
                <asp:Label ID="lblError" runat="server" Text="" CssClass="text-danger"></asp:Label>
            </div>
        </div>
    </form>
    <%--This is the JavaScript code that automatically scrolls the gridview to the bottom.--%>
    <script>
        var d = $('#grid');
        d.scrollTop(d.prop("scrollHeight"))
    </script>
</body>
</html>
