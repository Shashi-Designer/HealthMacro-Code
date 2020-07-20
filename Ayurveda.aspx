<%@ Page Title="" Language="C#" MasterPageFile="~/DiagSmartMaster.Master" AutoEventWireup="true" CodeBehind="Ayurveda.aspx.cs" Inherits="DiagSmart.Ayurveda" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>

<%@ Register Assembly="DevExpress.Web.v14.2, Version=14.2.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
    Namespace="DevExpress.Web" TagPrefix="dx" %>

<%@ Register Assembly="DevExpress.Web.v14.2, Version=14.2.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
    Namespace="DevExpress.Web" TagPrefix="dx1" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <div style="border-top: 2px Solid #49B5D2; width: 850px; margin-top: 1px; margin-bottom: 0.5em;"></div>
    <table cellpadding="0px" cellspacing="0px" width="830px">
        <tr>
            <td style="width: 540px">
                <div class="TermsConditionHeader">Ayurveda</div>
            </td>
            <td style="padding-left: 114px;">
                <%--<asp:Button ID="Button_AddMedicineCatalogue" runat="server" CssClass="btn-login btn-login-primary"
                    Text="Add Medicine" Width="170px" OnClick="Button_AddMedicineCatalogue_Click" />--%>

            </td>
            <td style="padding-left: 11px;">
                <%--<asp:Button ID="Button_Print" runat="server" CssClass="btn-login btn-login-primary"
                    Text="Print" Width="170px" OnClick="Button_Print_Click" Style="width: 87px;" />--%>
            </td>
        </tr>
    </table>
    <div style="border-bottom: 2px Solid #49B5D2; width: 850px; margin-top: 1px; margin-bottom: 0.5em;"></div>
    <asp:Panel ID="emr_home_healthcare" runat="server">
        <div style="margin-left: 15px;">
            <table width="85%" style="width: 822px;">
                <tr>
                    <td style="width: 100px;">
                        <asp:Label runat="server" ID="Id1" Text="Name" Font-Size="13px" Font-Bold="true" />
                        <asp:Label runat="server" ID="Label_PTitle" Text="" Font-Size="13px" Font-Bold="true" />
                        <asp:Label runat="server" ID="Label_PSecondName" Text="" Font-Size="13px" Font-Bold="true" />
                    </td>
                    <td>
                        <asp:Label runat="server" ID="Label7" Text=":" Font-Size="13px" Font-Bold="true" /></td>
                    <td style="width: 303px;">
                        <asp:Label runat="server" ID="Label_PFirstName" Font-Size="13px" Font-Bold="true" />
                        <asp:Label ID="id_lbl" runat="server" Visible="false"></asp:Label>
                    </td>
                    <td style="width: 100px;">
                        <asp:Label runat="server" ID="Label6" Text="Patient ID" Font-Size="13px" Font-Bold="true" />
                        

                    </td>
                    <td>
                        <asp:Label runat="server" ID="Label15" Text=":" Font-Size="13px" Font-Bold="true" Visible="true" />
                    </td>
                    <td style="width: 303px;">
                        <asp:Label runat="server" ID="Label_RegNum" Font-Size="13px" Font-Bold="true" />
                        <asp:HiddenField ID="HiddenField1" runat="server" />
                        
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label runat="server" ID="Label1" Text="Gender" Font-Size="13px" Font-Bold="true" />
                    </td>
                    <td>
                        <asp:Label runat="server" ID="Label8" Text=":" Font-Size="13px" Font-Bold="true" /></td>
                    <td style="padding-right: 1px; width: 560px;">
                        <asp:Label runat="server" ID="Label_PGender" Font-Size="13px" Font-Bold="true" />
                    </td>
                    <td style="width: 113px; padding-left: 0px;">
                        <asp:Label runat="server" ID="Label5" Text="Phone Number" Font-Size="13px" Font-Bold="true" />
                    </td>
                    <td>
                        <asp:Label runat="server" ID="Label11" Text=":" Font-Size="13px" Font-Bold="true" /></td>
                    <td>
                        <asp:Label runat="server" ID="Label_PMobile" Font-Size="13px" Font-Bold="true" />
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label runat="server" ID="Label2" Text="Age" Font-Size="13px" Font-Bold="true" />
                    </td>
                    <td>
                        <asp:Label runat="server" ID="Label9" Text=":" Font-Size="13px" Font-Bold="true" /></td>
                    <td>
                        <asp:Label runat="server" ID="Label_BillAge" Font-Size="13px" Font-Bold="true" />
                        <asp:Label runat="server" ID="Label_BillMonth" Font-Size="13px" Font-Bold="true"></asp:Label>
                    </td>
                    <td>
                        <asp:Label runat="server" ID="PresentDate" Text="Date" Font-Size="13px" Font-Bold="true" Visible="false" />
                        
                    </td>
                    <td>
                        <asp:Label runat="server" ID="Label3" Text=":" Font-Size="13px" Font-Bold="true" Visible="false" />

                    </td>
                    
                    <td>
                        
                      <asp:Label ID="lbl_PresentDate" runat="server" Font-Bold="true" Font-Size="13px" Visible="false" />
                        
                    </td>
                </tr>
            </table>
        </div>
        <div style="border-bottom: 2px Solid #49B5D2; width: 100%; margin-top: 1px; margin-bottom: 0.5em;">
        </div>
    </asp:Panel>
</asp:Content>
