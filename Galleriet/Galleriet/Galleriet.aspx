<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Galleriet.aspx.cs" Inherits="Galleriet.Galleriet" ViewStateMode="Disabled" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml" lang="sv">
<head runat="server">
    <title>Galleriet</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <asp:Panel ID="ViewPanel" runat="server">
            <h1>Galleriet</h1>
            <%-- Errors --%>

            <%-- MainImage --%>
            <asp:Image ID="MainImage" runat="server" />
            <%-- Thumbnails --%>
            <asp:Panel ID="ThumbnailPanel" runat="server">
                <asp:Repeater ID="Repeater1" runat="server"></asp:Repeater>
            </asp:Panel>
            <%-- Upload --%>
            <asp:Panel ID="UploadPanel" runat="server">
                <asp:FileUpload ID="FileUpload1" runat="server" />
            </asp:Panel>
        </asp:Panel>    
    </div>
    </form>
</body>
</html>
