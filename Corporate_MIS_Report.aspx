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


<%@ Page Title="" Language="C#" MasterPageFile="~/DiagSmartMaster.Master" AutoEventWireup="true"
    CodeBehind="Corporate_MIS_Report.aspx.cs" Inherits="DiagSmart.Corporate_MIS_Report" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%@ Register Assembly="DevExpress.Web.v14.2, Version=14.2.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
    Namespace="DevExpress.Web" TagPrefix="dx" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <%-- <table>
        <td align="left" style="width: 100%">
            <div class="TermsConditionHeader">
                Corporate MIS Reports
            </div>
        </td>
    </table>--%>
    

    <asp:Panel ID="Corporatemisreport_pnl" runat="server" Width="100%" Height="570px" ScrollBars="Auto" Style="border-top: 1px solid #49B5D2;">
    <table cellpadding="0px" cellspacing="0px" width="850px" >
                        <tr>
                            <td align="left" style="width: 100%">
                                <div class="TermsConditionHeader">
                                      Corporate MIS Reports
                                </div>
                            </td>
                        </tr>
                    </table>
    
    <div style="border-bottom: 2px Solid #49B5D2; width: 100%; margin-top: 2px;"></div>  
    <asp:Panel ID="panel_Corporate_Rate" runat="server" BackColor="#A3AAAE" Height="30px"
        Width="700px" CssClass="PartRegNumpnl">
        <div class="tdPartPreferenece">
            <asp:Image ID="Image_Corporate_Rate" runat="server" Width="20px" Height="18px" ImageAlign="Middle" Style="margin-bottom: 7px; margin-right: 7px;" />
            <asp:Label ID="Label_Corporate_Rate" runat="server" Font-Size="14px" ForeColor="white" Text="Corporate Rate Bill Summary" Width="300px" />
        </div>
    </asp:Panel>
    <cc1:CollapsiblePanelExtender ID="CollapsiblePanelExtender_Corporate_Rate" runat="server" CollapseControlID="panel_Corporate_Rate"
        Collapsed="true" CollapsedText="Corporate Detailed Bill Summary" ExpandControlID="panel_Corporate_Rate" ExpandedText="Corporate Detailed Bill Summary"
        TargetControlID="panel_CorporateRate" TextLabelID="Label_Corporate_Rate" ExpandedImage="~/Images/Collapse_minus.png"
        ImageControlID="Image_Corporate_Rate" CollapsedImage="~/Images/plus.png" />

    <asp:Panel ID="Panel_CorporateRate" runat="server">
        <div class="PartReport" style="height: 120px;">

            <asp:Label ID="Label30" runat="server" Style="padding-left: 45px;"></asp:Label>
            <table cellpadding="0px" cellspacing="0px" width="700px" style="margin-top: 10px; margin-left: 10px">

                <tr>
                    <td>
                        <%-- -------------------------------------------------------------------------%>
                        <asp:Label ID="Label31" runat="server" Text="CRP Detailed Bill Summary" Font-Size="Small" Width="120px"></asp:Label>
                    </td>
                    <td>
                        <asp:TextBox ID="txtCorporateRateFromDt" runat="server" Width="130px" CssClass="textbox1" autocomplete="off" placeholder="From Date"></asp:TextBox>
                        <cc1:CalendarExtender ID="ceCorporateRateFromDt" runat="server" Animated="True" Format="dd-MMM-yyyy" PopupPosition="BottomRight"
                            TargetControlID="txtCorporateRateFromDt">
                        </cc1:CalendarExtender>
                    </td>

                    <td style="width: 125px; padding-left: 10px;">
                        <asp:TextBox ID="txtCorporateRateToDt" runat="server" Width="130px" CssClass="textbox1" autocomplete="off" placeholder="To Date"></asp:TextBox>
                        <cc1:CalendarExtender ID="ceCorporateRateToDt" runat="server" Animated="True" Format="dd-MMM-yyyy" PopupPosition="BottomRight"
                            TargetControlID="txtCorporateRateToDt">
                        </cc1:CalendarExtender>
                    </td>
                    <td style="padding-left: 5px">
                        <asp:DropDownList ID="ddlDetailedCorporateBills" runat="server" Width="140px" Height="26px">
                        </asp:DropDownList>

                    </td>
                    <td>
                        <asp:RequiredFieldValidator ID="rfvCorporate" runat="server" InitialValue="--Select Corporate--" ErrorMessage="*"
                            ControlToValidate="ddlDetailedCorporateBills" Width="4px" Font-Size="Large" ForeColor="Red" ValidationGroup="corporateDetailed">

                        </asp:RequiredFieldValidator>
                    </td>
                    <td align="left" style="width: 125px" valign="top">
                        <asp:Button ID="btnCorporateRate" runat="server" Text="Generate Report" Width="120px" Height="28px"
                            CssClass="DivButton" ValidationGroup="corporateDetailed"
                            UseSubmitBehavior="False"
                            Style="margin-left: 15px; margin-bottom: 15px" OnClick="GetDetailedCorpoarteBillsClick" />

                    </td>
                </tr>
                <tr>
                    <td></td>
                    <td>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator14" runat="server" ControlToValidate="txtCorporateRateFromDt"
                            ForeColor="Red" ValidationGroup="corporateDetailed" ErrorMessage="Select From Date" />
                    </td>
                    <td><asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtCorporateRateToDt"
                            ForeColor="Red" ValidationGroup="corporateDetailed" ErrorMessage="Select To Date" /></td>
                    <td style="padding-left: 15px;">
                        
                    </td>
                    <td style="width: 100%"></td>
                </tr>
            </table>

        </div>
    </asp:Panel>

    <asp:Panel ID="pnlCorporateLedgerHeader" runat="server" BackColor="#A3AAAE" Height="30px"
        Width="700px" CssClass="PartRegNumpnl">
        <div class="tdPartPreferenece">
            <asp:Image ID="imgCorporateLedger" runat="server" Width="20px" Height="18px" ImageAlign="Middle" Style="margin-bottom: 7px; margin-right: 7px;" />
            <asp:Label ID="lblCorporateLedger" runat="server" Font-Size="14px" ForeColor="white" Text="Corporate Ledger" Width="300px" />
        </div>
    </asp:Panel>
    <cc1:CollapsiblePanelExtender ID="CPECorporateLedger" runat="server" CollapseControlID="pnlCorporateLedgerHeader"
        Collapsed="true" CollapsedText="Corporate Ledger" ExpandControlID="pnlCorporateLedgerHeader" ExpandedText="Corporate Ledger"
        TargetControlID="pnlCorporateLedger" TextLabelID="lblCorporateLedger" ExpandedImage="~/Images/Collapse_minus.png"
        ImageControlID="imgCorporateLedger" CollapsedImage="~/Images/plus.png" />
    <asp:Panel ID="pnlCorporateLedger" runat="server">
        <div class="PartReport" style="height: 120px;">

            <asp:Label ID="Label34" runat="server" Style="padding-left: 45px;"></asp:Label>
            <table cellpadding="0px" cellspacing="0px" width="700px" style="margin-top: 10px; margin-left: 10px">

                <tr>
                    <td>
                        <asp:Label ID="Label35" runat="server" Text="Corporate Ledger" Font-Size="Small" Width="120px"></asp:Label>
                    </td>
                    <td>
                        <asp:TextBox ID="txtCorporateLedgerFromDt" runat="server" Width="130px" CssClass="textbox1" autocomplete="off" placeholder="From Date"></asp:TextBox>
                        <cc1:CalendarExtender ID="CECorporateLedgerFromDt" runat="server" Animated="True" Format="dd-MMM-yyyy" PopupPosition="BottomRight"
                            TargetControlID="txtCorporateLedgerFromDt">
                        </cc1:CalendarExtender>
                    </td>

                    <td style="width: 125px; padding-left: 10px;">
                        <asp:TextBox ID="txtCorporateLedgerToDt" runat="server" Width="130px" CssClass="textbox1" autocomplete="off" placeholder="To Date"></asp:TextBox>
                        <cc1:CalendarExtender ID="CECorporateLedgerToDt" runat="server" Animated="True" Format="dd-MMM-yyyy" PopupPosition="BottomRight"
                            TargetControlID="txtCorporateLedgerToDt">
                        </cc1:CalendarExtender>
                    </td>
                    <td style="padding-left: 5px">
                        <asp:DropDownList ID="ddlCorporateLedger" runat="server" Width="140px" Height="26px">
                        </asp:DropDownList>

                    </td>
                    <td></td>
                    <td align="left" style="width: 125px" valign="top">
                        <asp:Button ID="btnorporateLedger" runat="server" Text="Generate Report" Width="120px" Height="28px"
                            CssClass="DivButton" ValidationGroup="validateCorporateLedger"
                            UseSubmitBehavior="False"
                            Style="margin-left: 15px; margin-bottom: 15px" OnClick="GetCorporateLedgerReportClick" />

                    </td>
                </tr>
                <tr>
                    <td></td>
                    <td>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator17" runat="server" ControlToValidate="txtCorporateLedgerFromDt"
                            ForeColor="Red" ValidationGroup="validateCorporateLedger" ErrorMessage="Select From Date" />
                    </td>

                    <td style="padding-left: 21px;">
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator18" runat="server" ControlToValidate="txtCorporateLedgerToDt"
                            ForeColor="Red" Display="Dynamic" ValidationGroup="validateCorporateLedger" ErrorMessage="Select To Date" />
                        <%--<asp:CompareValidator ID="CompareValidatorCorporateLeger" runat="server" ControlToValidate="txtCorporateLedgerFromDt"
                                                        ControlToCompare="txtCorporateLedgerToDt" Type="Date" ValidationGroup="validateCorporateLedger" 
                                                        Operator="LessThan" ForeColor="Red" Display="Dynamic" ErrorMessage="To date can't be less than From date"></asp:CompareValidator>--%>
                    </td>
                    <td style="width: 100%"></td>
                </tr>
            </table>

        </div>
        
    </asp:Panel>
    </asp:Panel>
</asp:Content>
