<%--//******************************************************************************************************************************
// Author       : 
// Created Date : 
// Updated Date : 22 April 2019
// Updated by   : Muniraj 
// Description  : Added Copyright Message
// @ HEALTHMACRO TECHNOLOGIES PVT LTD 
//******************************************************************************************************************************
//Copyright(c) HealthMacro Technologies Pvt.Ltd.

//* NOTICE: All information contained herein is, and remains the property of HealthMacro Technologies Pvt.Ltd.
//* The intellectual and technical concepts contained herein are proprietary to HealthMacro Technologies Pvt.Ltd. and are protected by copyright law.
//* Dissemination of this information or reproduction of this material is strictly forbidden unless prior written permission is obtained
//* from HealthMacro Technologies Pvt.Ltd --%>


<%@ Page Title="" Language="C#" MasterPageFile="~/DiagSmartMaster.Master" AutoEventWireup="true" CodeBehind="Audit_logs.aspx.cs" Inherits="DiagSmart.Audit_logs" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script type='text/javascript' src='Scripts/jquery-1.4.1.js'></script>
    <script type='text/javascript' src='Scripts/jquery-1.4.1.min.js'></script>
    <script type='text/javascript' src='Scripts/jquery-1.4.1-vsdoc.js'></script>
    <script type='text/javascript' src='Scripts/jquery-1.7.1.min.js'></script>
    <script src="Scripts/jquery-1.9.1.js" type="text/javascript"></script>
    <script src="Scripts/jquery-ui.min.js" type="text/javascript"></script>
    <script src="Scripts/jquery.timepicker.js" type="text/javascript"></script>
    <link href="CSS/ui-lightness/jquery-ui-1.8.19.custom.css" rel="stylesheet" type="text/css" />
    <link href="CSS/jquery.timepicker.css" rel="stylesheet" type="text/css" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <div style="border-top: 2px Solid #49B5D2; padding-left: 3em; width: 800px"></div>
    <div class="TermsConditionHeader">
        <asp:Label ID="lbl_auditlog" runat="server" Text="Audit Logs" CssClass=""></asp:Label>
    </div>

    <div style="border-top: 2px Solid #49B5D2; padding-left: 3em; width: 800px">

        <br />
    </div>
    <asp:Panel ID="pnl_auditlog" runat="server" Style="padding-left: 5px; padding-right: 16px;" >
        <table>
            <tr>
                <td>
                    <asp:Label ID="lbl_selectstaff" runat="server" Text="Admin/Staff Name" Style="padding-left: 4px;"></asp:Label>
                </td>
                <td>
                    <asp:Label ID="lbl_from" runat="server" Text="From" Style="padding-left: 16px;"></asp:Label>
                </td>
                <td>
                    <asp:Label ID="lbl_to" runat="server" Text="To" Style="padding-left: 25px;"></asp:Label>
                </td>
            </tr>
            <tr>
                <td>
                    <asp:DropDownList ID="ddl_selectadminstaff" runat="server" CssClass="" Width="180px" Height="23px" >
                        <asp:ListItem Text ="Select" Selected="True"  ></asp:ListItem>
                        <asp:ListItem Text="All"></asp:ListItem>
                    </asp:DropDownList>
                </td>
                <td>
                    <asp:TextBox ID="txt_FromDate" runat="server" Style="width: 130px; margin-left: 10px;" CssClass="textbox1" placeholder="From Date"></asp:TextBox>
                    <cc1:CalendarExtender ID="CalendarExtender_fromdate_PD" runat="server" Animated="True" Format="dd-MMM-yyyy" PopupPosition="BottomRight"
                        TargetControlID="txt_FromDate">
                    </cc1:CalendarExtender>
                </td>
                <td>
                    <asp:TextBox ID="txt_todate" runat="server" Style="width: 130px; margin-left: 20px;" CssClass="textbox1" placeholder="To Date"></asp:TextBox>
                    <cc1:CalendarExtender ID="CalendarExtender_todate_PD" runat="server" Animated="True" Format="dd-MMM-yyyy" PopupPosition="BottomRight"
                        TargetControlID="txt_todate">
                    </cc1:CalendarExtender>
                </td>
                <td align="left" style="width: 290px" valign="middle">
                <asp:ImageButton ID="ImageButton_Search_auditLog" runat="server" CssClass="imgButton" Height="30px" OnClick="ImageButton_Search_auditLog_Click"
                   ImageUrl="~/Images/search1.png" ToolTip="Click to search login details" Width="40px" 
                      BorderStyle="None" />
                    <asp:Label ID="lbl_displayerror_auditlog" runat="server" Font-Size="Small" BackColor="White" ForeColor="Red" Visible="False" Style="margin-left: 20px"></asp:Label>
                 </td>
            </tr>
        </table>
        <table>
            <tr>
                <td>
                    <asp:TextBox ID="txt_Partner_EventLogDetails" runat="server" TextMode="MultiLine" Width="835px" ReadOnly="true"
                        Height="520px" Enabled="true" ></asp:TextBox>
                </td>
            </tr>
        </table>
    </asp:Panel>

</asp:Content>
