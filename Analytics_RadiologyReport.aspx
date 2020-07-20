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


<%@ Page Title="" Language="C#" MasterPageFile="~/DiagSmartMaster.Master" AutoEventWireup="true" CodeBehind="Analytics_RadiologyReport.aspx.cs" Inherits="DiagSmart.Analytics_RadiologyReport" %>

<%@ Register Assembly="DevExpress.Web.v14.2, Version=14.2.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
    Namespace="DevExpress.Web" TagPrefix="dx" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <asp:Panel runat="server" ID="Panel_ViewRadiology" Style="border-top: 1px solid #49B5D2;" >
          <table width="100%">
            <tr>
                <td align="left" style="width: 50%;">
                    <div class="TermsConditionHeader">
                        <asp:Label ID="lbl_DashBord" runat="server" Text="Radiology Analytics"></asp:Label>
                    </div>
                </td>
            </tr>
        </table>
        <div style="border-bottom: 2px Solid #49B5D2; width: 100%">
        </div>
         <asp:Panel ID="Pnl_RadRevenue" runat="server" BackColor="#A3AAAE"
                Height="30px" CssClass="PartprofileData">
                <div class="tdPartPreferenece">
                    <asp:Image ID="Image_Radiology" runat="server" Width="20px" Height="18px" ImageAlign="Middle" Style="margin-bottom: 7px; margin-right: 7px;" /><asp:Label
                        ID="Label_Rad" runat="server" Font-Size="14px" ForeColor="white" Text="Radiology"
                        Width="750px" />
                </div>
            </asp:Panel>
            <cc1:CollapsiblePanelExtender ID="CollapsiblePanelExtender_Radiology" runat="server" CollapseControlID="Pnl_RadRevenue"
                Collapsed="true" CollapsedText="Radiology Revenues" ExpandControlID="Pnl_RadRevenue"
                ExpandedText="Radiology Revenues" TargetControlID="panel_Rad_Main" TextLabelID="Label_Rad"
                ExpandedImage="~/Images/Collapse_minus.png" ImageControlID="Image_Radiology"
                CollapsedImage="~/Images/plus.png" CollapsedSize="0" />
            <asp:Panel ID="panel_Rad_Main" runat="server" Height="200px">
                <div>
                </div>
                <div class="PartprofileData" style="height: 400px">
                    <asp:Label ID="Label13" runat="server" Text="Select Year" Font-Bold="true" Font-Size="12px"
                        CssClass="tdPartProfile" Style="padding-right: 15px; padding-left: 33px" />
                    <asp:DropDownList ID="DropDownList1" runat="server"
                        AutoPostBack="true" Style="margin-bottom: 10px;" Width="60px">
                    </asp:DropDownList>
                   
                  <br />
                    <div id="div_Radiology" runat="server" class="verticalscroll" style="padding-top: 10px; padding-left: 15px;"> </div>
                       
                               <asp:Panel ID="pnl_gridview_Radiology" runat="server" ScrollBars="Auto" Style="overflow: auto; margin-left: 35px;">
                            <dx:ASPxGridView ID="ASPxGridView_Radiology" runat="server" AutoGenerateColumns="False"
                                Width="750px" Theme="Aqua">
                                <Columns>
                                    <dx:GridViewDataTextColumn Caption="Total"
                                        VisibleIndex="1" Width="10px" ShowInCustomizationForm="True">
                                        <Settings AutoFilterCondition="Contains"></Settings>
                                        <DataItemTemplate>
                                            <asp:Label ID="lbl_Radiology_Count_E" runat="server"></asp:Label>

                                        </DataItemTemplate>

                                        <HeaderStyle HorizontalAlign="Center" />

                                        <CellStyle HorizontalAlign="Center"></CellStyle>
                                    </dx:GridViewDataTextColumn>
                                    <dx:GridViewDataTextColumn Caption="Jan" Width="10px" ShowInCustomizationForm="True"
                                        VisibleIndex="1">
                                        <Settings AutoFilterCondition="Contains"></Settings>
                                        <DataItemTemplate>
                                            <asp:Label ID="lbl_Jan_Count_Rad" runat="server"></asp:Label>

                                        </DataItemTemplate>

                                        <HeaderStyle HorizontalAlign="Center" />

                                        <CellStyle HorizontalAlign="Center"></CellStyle>
                                    </dx:GridViewDataTextColumn>
                                    <dx:GridViewDataTextColumn Caption="Feb" Width="10px" ShowInCustomizationForm="True"
                                        VisibleIndex="1">
                                        <Settings AutoFilterCondition="Contains"></Settings>
                                        <DataItemTemplate>
                                            <asp:Label ID="lbl_FEB_Count_Rad" runat="server"></asp:Label>

                                        </DataItemTemplate>

                                        <HeaderStyle HorizontalAlign="Center" />

                                        <CellStyle HorizontalAlign="Center"></CellStyle>
                                    </dx:GridViewDataTextColumn>
                                    <dx:GridViewDataTextColumn Caption="Mar"
                                        VisibleIndex="1" Width="10px" ShowInCustomizationForm="True">
                                        <Settings AutoFilterCondition="Contains"></Settings>
                                        <DataItemTemplate>
                                            <asp:Label ID="lbl_Mar_Count_Rad" runat="server"></asp:Label>

                                        </DataItemTemplate>

                                        <HeaderStyle HorizontalAlign="Center" />

                                        <CellStyle HorizontalAlign="Center"></CellStyle>
                                    </dx:GridViewDataTextColumn>
                                    <dx:GridViewDataTextColumn Caption="Apr"
                                        VisibleIndex="1" Width="10px" ShowInCustomizationForm="True">
                                        <Settings AutoFilterCondition="Contains"></Settings>
                                        <DataItemTemplate>
                                            <asp:Label ID="lbl_Apr_Count_Rad" runat="server"></asp:Label>

                                        </DataItemTemplate>

                                        <HeaderStyle HorizontalAlign="Center" />

                                        <CellStyle HorizontalAlign="Center"></CellStyle>
                                    </dx:GridViewDataTextColumn>
                                    <dx:GridViewDataTextColumn Caption="May"
                                        VisibleIndex="1" Width="10px" ShowInCustomizationForm="True">
                                        <Settings AutoFilterCondition="Contains"></Settings>
                                        <DataItemTemplate>
                                            <asp:Label ID="lbl_May_Count_Rad" runat="server"></asp:Label>

                                        </DataItemTemplate>

                                        <HeaderStyle HorizontalAlign="Center" />

                                        <CellStyle HorizontalAlign="Center"></CellStyle>
                                    </dx:GridViewDataTextColumn>
                                    <dx:GridViewDataTextColumn Caption="Jun"
                                        VisibleIndex="1" Width="10px" ShowInCustomizationForm="True">
                                        <Settings AutoFilterCondition="Contains"></Settings>
                                        <DataItemTemplate>
                                            <asp:Label ID="lbl_Jun_Count_Rad" runat="server"></asp:Label>

                                        </DataItemTemplate>

                                        <HeaderStyle HorizontalAlign="Center" />

                                        <CellStyle HorizontalAlign="Center"></CellStyle>
                                    </dx:GridViewDataTextColumn>
                                    <dx:GridViewDataTextColumn Caption="July"
                                        VisibleIndex="1" Width="10px" ShowInCustomizationForm="True">
                                        <Settings AutoFilterCondition="Contains"></Settings>
                                        <DataItemTemplate>
                                            <asp:Label ID="lbl_Jul_Count_Rad" runat="server"></asp:Label>

                                        </DataItemTemplate>

                                        <HeaderStyle HorizontalAlign="Center" />

                                        <CellStyle HorizontalAlign="Center"></CellStyle>
                                    </dx:GridViewDataTextColumn>
                                    <dx:GridViewDataTextColumn Caption="Aug"
                                        VisibleIndex="1" Width="10px" ShowInCustomizationForm="True">
                                        <Settings AutoFilterCondition="Contains"></Settings>
                                        <DataItemTemplate>
                                            <asp:Label ID="lbl_Aug_Count_Rad" runat="server"></asp:Label>

                                        </DataItemTemplate>

                                        <HeaderStyle HorizontalAlign="Center" />

                                        <CellStyle HorizontalAlign="Center"></CellStyle>
                                    </dx:GridViewDataTextColumn>
                                    <dx:GridViewDataTextColumn Caption="Sep"
                                        VisibleIndex="1" Width="10px" ShowInCustomizationForm="True">
                                        <Settings AutoFilterCondition="Contains"></Settings>
                                        <DataItemTemplate>
                                            <asp:Label ID="lbl_Sep_Count_Rad" runat="server"></asp:Label>

                                        </DataItemTemplate>

                                        <HeaderStyle HorizontalAlign="Center" />

                                        <CellStyle HorizontalAlign="Center"></CellStyle>
                                    </dx:GridViewDataTextColumn>
                                    <dx:GridViewDataTextColumn Caption="Oct"
                                        VisibleIndex="1" Width="10px" ShowInCustomizationForm="True">
                                        <Settings AutoFilterCondition="Contains"></Settings>
                                        <DataItemTemplate>
                                            <asp:Label ID="lbl_Oct_Count_Rad" runat="server"></asp:Label>

                                        </DataItemTemplate>

                                        <HeaderStyle HorizontalAlign="Center" />

                                        <CellStyle HorizontalAlign="Center"></CellStyle>
                                    </dx:GridViewDataTextColumn>
                                    <dx:GridViewDataTextColumn Caption="Nov"
                                        VisibleIndex="1" Width="10px" ShowInCustomizationForm="True">
                                        <Settings AutoFilterCondition="Contains"></Settings>
                                        <DataItemTemplate>
                                            <asp:Label ID="lbl_Nov_Count_Rad" runat="server"></asp:Label>

                                        </DataItemTemplate>

                                        <HeaderStyle HorizontalAlign="Center" />

                                        <CellStyle HorizontalAlign="Center"></CellStyle>
                                    </dx:GridViewDataTextColumn>
                                    <dx:GridViewDataTextColumn Caption="Dec"
                                        VisibleIndex="1" Width="10px" ShowInCustomizationForm="True">
                                        <Settings AutoFilterCondition="Contains"></Settings>
                                        <DataItemTemplate>
                                            <asp:Label ID="lbl_Dec_Count_Rad" runat="server"></asp:Label>
                                        </DataItemTemplate>

                                        <HeaderStyle HorizontalAlign="Center" />

                                        <CellStyle HorizontalAlign="Center"></CellStyle>
                                    </dx:GridViewDataTextColumn>
                                </Columns>
                            </dx:ASPxGridView>
                                   </asp:Panel>
                        </asp:Panel>
        </asp:Panel>
                          
</asp:Content>
