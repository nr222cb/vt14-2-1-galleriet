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
            <asp:Image ID="MainImage" runat="server" Visible="false" />
            <%-- Thumbnails --%>
            <asp:Panel ID="ThumbnailPanel" runat="server">
                <asp:Repeater ID="Repeater1" runat="server" ItemType="System.String" SelectMethod="Repeater1_GetData">
                    <ItemTemplate>
                        <asp:HyperLink ID="HyperLink1" runat="server" 
                            Text='<%#: Item%>' ImageUrl='<%#"~/Content/Images/Thumbnails/"+Item %>' 
                            NavigateUrl='<%# "?name=" + Item%>'>
                        </asp:HyperLink>
                    </ItemTemplate>
                </asp:Repeater>
            </asp:Panel>
            <%-- Upload --%>
            <asp:Panel ID="UploadPanel" runat="server">
                <asp:FileUpload ID="FileUpload1" runat="server" />
                <asp:Button ID="UploadButton" runat="server" Text="Ladda upp" OnClick="UploadButton_Click" />
            </asp:Panel>
        </asp:Panel>    
    </div>
    </form>
</body>
</html>
