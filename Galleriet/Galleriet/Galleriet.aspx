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
            <asp:Panel ID="UploadPanel" runat="server">
                <fieldset>
                    <legend>Ladda upp bild:</legend>
                    <%-- Messages --%>
                    <p>
                        <asp:Literal ID="Literal1" runat="server" Visible="false"></asp:Literal>
                    </p>
                    <asp:ValidationSummary ID="ValidationSummary" runat="server" HeaderText="Fel inträffade. Korrigera felet och försök igen!" />
                    <%-- Upload --%>
                    <asp:FileUpload ID="FileUpload1" runat="server" />
                    <asp:Button ID="UploadButton" runat="server" Text="Ladda upp" OnClick="UploadButton_Click" />
                </fieldset>
            </asp:Panel>
            <%-- Validation --%>
            <asp:RequiredFieldValidator Visible="True" ID="RequiredFieldValidator1" runat="server" Text="*" 
                ErrorMessage="En fil måste väljas." 
                ControlToValidate="FileUpload1" Display="Dynamic" SetFocusOnError="True"></asp:RequiredFieldValidator>
            <asp:RegularExpressionValidator Visible="True" ID="RegularExpressionValidator1" runat="server" Text="*" 
                ErrorMessage="Endast bilder av typen gif|jpg|png är tillåtna." ControlToValidate="FileUpload1" Display="Dynamic" 
                ValidationExpression="^.*\.(gif|jpg|png)$" SetFocusOnError="True"></asp:RegularExpressionValidator>
        </asp:Panel>    
    </div>
    </form>
</body>
</html>
