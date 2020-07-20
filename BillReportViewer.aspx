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


<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="BillReportViewer.aspx.cs" Inherits="DiagSmart.BillReportViewer1" %>
<%@ Register assembly="CrystalDecisions.Web, Version=13.0.2000.0, Culture=neutral, PublicKeyToken=692fbea5521e1304" namespace="CrystalDecisions.Web" tagprefix="CR" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>HealthMacro Report</title>
     <script src="Scripts/jquery-1.9.1.js" type="text/javascript"></script>
    <script type="text/javascript">
        function DisposeCRObject() {
            var unID = document.getElementById('<%=UniqueID.ClientID%>').innerText;

            PageMethods.DisposeMISCrystalReportObjs(unID);
       }
       function MakeUnloadFalse() {
           window.onunload = null;
       }

    </script>
</head>
   
<body onunload="DisposeCRObject()">
    <form id="form1" runat="server">
        <asp:ScriptManager ID="scrtMgr1" runat="server" EnablePageMethods="true"></asp:ScriptManager>
        <asp:ImageButton ID="ImageButton1" runat="server" OnClick="ImageButton1_Click" ImageUrl="~/Images/printer2.png"  OnClientClick="MakeUnloadFalse()" />
            <asp:ImageButton ID="Button1" runat="server" OnClick="Button1_Click" ImageUrl="~/Images/pdf.jpg" />
            <asp:ImageButton ID="Button2" runat="server" OnClick="Button2_Click" ImageUrl="~/Images/Excel.jpg" />
            <asp:ImageButton ID="Button3" runat="server" OnClick="Button3_Click" ImageUrl="~/Images/word.jpg" />
        <asp:Label ID="UniqueID" runat="server" Font-Size="0px" ></asp:Label>
        <br />
        <CR:CrystalReportViewer ID="CrystalReportViewer1" runat="server" DisplayToolbar="true" HasPrintButton="False" 
            GroupTreeImagesFolderUrl="" Height="1202px" ReportSourceID="CrystalReportSource1" ToolbarImagesFolderUrl="" 
            ToolPanelWidth="200px" Width="1104px" EnableDatabaseLogonPrompt="False" EnableDrillDown="False" EnableParameterPrompt="False" 
            DisplayStatusbar="False" HasCrystalLogo="False" HasDrilldownTabs="False" HasDrillUpButton="False" HasExportButton="False" HasSearchButton="False"
            HasToggleGroupTreeButton="False" HasToggleParameterPanelButton="False" HasZoomFactorList="False" ToolPanelView="None" 
            OnNavigate="CrystalReportViewer1_Navigate"  />
        <CR:CrystalReportSource ID="CrystalReportSource1" runat="server">
          </CR:CrystalReportSource>
    <div>
    
    </div>
    </form>
</body>
</html>
