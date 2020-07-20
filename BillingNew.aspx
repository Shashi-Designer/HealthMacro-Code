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


<%@ Page Title="" Language="C#" MasterPageFile="~/DiagSmartMaster.Master" AutoEventWireup="true" CodeBehind="BillingNew.aspx.cs" Inherits="DiagSmart.BillingNew" %>

<%@ Register Assembly="DevExpress.Web.v14.2, Version=14.2.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web" TagPrefix="dx" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script src="Scripts/jquery-1.9.1.js" type="text/javascript"></script>
    <script type="text/javascript" src="Scripts/notifIt.js"></script>
    <link type="text/css" href="CSS/notifIt.css" rel="stylesheet" />
    <script type="text/javascript">
        function SuccessNotify(message) {
            notif({
                msg: "<b>Success:</b>" + message,
                type: "success"

            });
           
        }
        function SuccessNotifyy(message) {
            notif({
                msg: message,
                type: "success"

            });

        }
        function ErrorNotifyy(message) {
            notif({
                msg: message,
                type: "warning"

            });

        }
        function FailureNotifyy(message) {
            notif({
                msg: message,
                type: "error"

            });

        }
        function DisableSubmitbutton() {
            document.getElementById("MainContent_tabContainerBilling_tabPnlCreateBill_btn_DiscountBill").disabled = true;
        }
        function AmountOwedToHospAndPat() {
            var advanceamount = document.getElementById('<%= TextBox_AdvnaceAmt.ClientID %>').value;
             var amtpayable = document.getElementById('<%= lblBillAmountPayable.ClientID %>').innerHTML;
             var OwedToHosp, OwedToPat;
             if ( parseFloat(advanceamount) > parseFloat(amtpayable)) {
                 OwedToPat = advanceamount - amtpayable;
                 document.getElementById('<%= txt_OwedToPat.ClientID %>').value = OwedToPat.toFixed(2);
                 document.getElementById('<%= txt_OwedToHosp.ClientID %>').value = "0.00";
             }
             else if (parseFloat(advanceamount) < parseFloat(amtpayable)) {
                 OwedToHosp = amtpayable - advanceamount;
                 document.getElementById('<%= txt_OwedToHosp.ClientID %>').value = OwedToHosp.toFixed(2);
               document.getElementById('<%= txt_OwedToPat.ClientID %>').value = "0.00";
           }
             else if (parseFloat(advanceamount) == parseFloat(amtpayable)) {
               document.getElementById('<%= txt_OwedToHosp.ClientID %>').value = "0.00";
                document.getElementById('<%= txt_OwedToPat.ClientID %>').value = "0.00";
            }
        }

        function BillAmountPaidChangedAmountOwedToHospAndPat() {
            var OwedToHosp = document.getElementById('<%= txt_OwedToHosp.ClientID %>').value;
            if (OwedToHosp >= "0.00") {
                document.getElementById('<%= txt_OwedToHosp.ClientID %>').value = document.getElementById('<%= lblBalance.ClientID %>').innerHTML;
                document.getElementById('<%= txt_OwedToPat.ClientID %>').value = "0.00";
            }
        }
        function BalancePaidChangedAmountOwedToHospAndPat() {
            var OwedToHosp = document.getElementById('<%= txt_OwedToHosp.ClientID %>').value;
            document.getElementById('<%= txt_OwedToHosp.ClientID %>').value = document.getElementById('<%= lblLeftBal.ClientID %>').innerHTML;
            document.getElementById('<%= txt_OwedToPat.ClientID %>').value = "0.00";
        }
        function BillItemRateChanged() {
            var grid = document.getElementById('<%=grdBillDetails.ClientID %>');
            var totalAmt = 0;
            for (var i = 0; i < grid.rows.length - 1 ; i++) {
                var txtRate = $("input[name$=txtRate]");
                var txtQty = $("input[name$=txtQty]");
                var hdnTotalAmtOfItem = $("input[name$=hdnTotalOfEachItem]");
                if (txtRate[i].value.trim() == "") {
                    txtRate[i].value = "0.00";
                }
                if (txtQty[i].value.trim() == "") {
                    txtQty[i].value = "1";
                }
                txtRate[i].value = (parseFloat(txtRate[i].value)).toFixed(2);
                //Multiply rate and quantity and put it in total amt of item label
                var totalOfParticularItemAmt = ((parseFloat(txtRate[i].value) * parseFloat(txtQty[i].value)).toFixed(2));
                hdnTotalAmtOfItem[i].value = totalOfParticularItemAmt;

                $('.lblTotalCss').eq(i).text(totalOfParticularItemAmt);

                totalAmt += parseFloat(totalOfParticularItemAmt);
            }
            document.getElementById('<%= lblBillSubTotal.ClientID %>').innerHTML = totalAmt.toFixed(2);
            document.getElementById('<%= hdnBillSubTotal.ClientID %>').value = totalAmt.toFixed(2);
            document.getElementById('<%= txtDiscount.ClientID %>').value = 0;
            document.getElementById('<%= lblDiscount.ClientID %>').innerHTML = "0.00";
            document.getElementById('<%= hdnDiscount.ClientID %>').value = "0.00";
           //document.getElementById('<%= txtBillTax.ClientID %>').value = 0;
           //document.getElementById('<%= lblBillTaxPercentage.ClientID %>').innerHTML = "0.00";
           //document.getElementById('<%= hdnBillTaxPercentage.ClientID %>').value = "0.00";
            if ('<%=rb_BillType.Visible%>' == 'True') {
                var selectedBillTypeVal = document.getElementsByName('<%=rb_BillType.UniqueID%>');
                if (selectedBillTypeVal[0].checked) {
                    var advanceamount = document.getElementById('<%= TextBox_AdvnaceAmt.ClientID %>').value;
                    if (totalAmt > advanceamount) {
                        var totalbillpayable = totalAmt - advanceamount;
                        document.getElementById('<%= lblBillAmountPayable.ClientID %>').innerHTML = totalAmt.toFixed(2);
                        document.getElementById('<%= hdnBillAmountPayable.ClientID %>').value = totalAmt.toFixed(2);
                        document.getElementById('<%= txtBillAmountPaid.ClientID %>').value = "0.00";


                        document.getElementById('<%= lblBalance.ClientID %>').innerHTML = totalbillpayable.toFixed(2);
                        document.getElementById('<%= hdnBalance.ClientID %>').value = totalbillpayable.toFixed(2);
                    }
                    else {
                        var totalbillpayable = advanceamount - totalAmt;
                        document.getElementById('<%= lblBillAmountPayable.ClientID %>').innerHTML = totalAmt.toFixed(2);
                        document.getElementById('<%= hdnBillAmountPayable.ClientID %>').value = totalAmt.toFixed(2);
                        document.getElementById('<%= txtBillAmountPaid.ClientID %>').value = totalAmt.toFixed(2);
                        document.getElementById('<%= lblBalance.ClientID %>').innerHTML = "0.00";
                        document.getElementById('<%= hdnBalance.ClientID %>').value = "0.00";
                    }
                }
                else {
                    document.getElementById('<%= lblBillAmountPayable.ClientID %>').innerHTML = totalAmt.toFixed(2);
                    document.getElementById('<%= hdnBillAmountPayable.ClientID %>').value = totalAmt.toFixed(2);
                    document.getElementById('<%= txtBillAmountPaid.ClientID %>').value = "0.00";
                    document.getElementById('<%= lblBalance.ClientID %>').innerHTML = totalAmt.toFixed(2);
                    document.getElementById('<%= hdnBalance.ClientID %>').value = totalAmt.toFixed(2);
                }
            }
            else {
                document.getElementById('<%= lblBillAmountPayable.ClientID %>').innerHTML = totalAmt.toFixed(2);
                document.getElementById('<%= hdnBillAmountPayable.ClientID %>').value = totalAmt.toFixed(2);
                document.getElementById('<%= txtBillAmountPaid.ClientID %>').value = "0.00";


                document.getElementById('<%= lblBalance.ClientID %>').innerHTML = totalAmt.toFixed(2);
                document.getElementById('<%= hdnBalance.ClientID %>').value = totalAmt.toFixed(2);
            }
           
            calculateDiscountAndTax();
            AmountOwedToHospAndPat();
        }
        function DisableSubmitbutton() {
            document.getElementById("MainContent_tabContainerBilling_tabPnlCreateBill_btn_DiscountBill").disabled = true;
        }

        
        function CorrectionBillItemRateChanged() {
            var grid = document.getElementById('<%=grdBillDetails_c.ClientID %>');
            var totalAmt = 0;
            for (var i = 0; i < grid.rows.length - 1 ; i++) {
                var txtRate = $("input[name$=txtRate_c]");
                var txtQty = $("input[name$=txtQty_c]");
                var txtprc = $("input[name$=txtprc_c]");
                var hdnTotalAmtOfItem = $("input[name$=hdnTotalOfEachItem_c]");
                if (txtRate[i].value.trim() == "") {
                    txtRate[i].value = "0.00";
                }
                //if (txtQty[i].value.trim() == "" || (parseFloat(txtQty[i].value)) < 1) {
                //    txtQty[i].value = "1";
                //}
                txtRate[i].value = (parseFloat(txtRate[i].value)).toFixed(2);
                //Multiply rate and quantity and put it in total amt of item label
                var totalOfParticularItemAmt = ((parseFloat(txtRate[i].value) * parseFloat(txtQty[i].value)).toFixed(2));
                hdnTotalAmtOfItem[i].value = totalOfParticularItemAmt;
                txtprc[i].value = totalOfParticularItemAmt;
                //$('.lblTotalCss_c').eq(i).text(totalOfParticularItemAmt);

                totalAmt += parseFloat(totalOfParticularItemAmt);             
            }
           // AmountOwedToHospAndPat();
            var totdec = parseFloat(totalAmt).toLocaleString('en'); // totamt.toLocaleString('en');
            var ttdc = 0;
            ttdc = totalAmt.toLocaleString('en-IN');
            var rt = 0;
            rt = Math.round(totalAmt);
            var tdc = 0;
            tdc = rt.toLocaleString('en-IN');
            document.getElementById('<%= lblTotal_C.ClientID %>').innerHTML = tdc + ".00";
            
        }
        
        function CorrectionAdvAmtChanged() {
            var grid = document.getElementById('<%=grdAdv.ClientID %>');
            var totalAmt = 0.00;
            for (var i = 0; i < grid.rows.length - 1 ; i++) {
                var txtRate = $("input[name$=txtAdamt]");
                if (txtRate[i].value.trim() == "") {
                    txtRate[i].value = "0.00";
                }
                txtRate[i].value = (parseFloat(txtRate[i].value)).toFixed(2);
                //Multiply rate and quantity and put it in total amt of item label
                var totalOfParticularItemAmt = (parseFloat(txtRate[i].value)).toFixed(2);
                totalAmt += parseFloat(totalOfParticularItemAmt);
            }
            ttdc = totalAmt.toLocaleString('en-IN');
            var tadv = 0;
            tadv = Math.round(totalAmt);
            var totaladv = tadv.toLocaleString('en-IN');
            document.getElementById('<%= AdvAmtTot.ClientID %>').innerHTML = totaladv + ".00";

        }

        function SearchCriteriaChange() {
            $('#MainContent_tabContainerBilling_tabPnlCreateBill_txtPatientBillSearch').val('');
        }

        function autoCompletePatientForbill_OnClientPopulating(sender, args) {
           
            if('<%=rb_BillType.Visible%>'== 'True')
            {
                var selectedBillTypeVal = document.getElementsByName('<%=rb_BillType.UniqueID%>');
                if (selectedBillTypeVal[1].checked) {
                    var selectedCriteriaVal = $('#MainContent_tabContainerBilling_tabPnlCreateBill_drpSearchCriteria').val();
                    var searchCriteria = '';
                    if (selectedCriteriaVal == 1) {
                        searchCriteria = 'PatientName';
                    }
                    else if (selectedCriteriaVal == 2) {
                        searchCriteria = 'MobileNo';
                    }
                    else if (selectedCriteriaVal == 3) {
                        searchCriteria = 'Email';
                    }
                    else {
                        searchCriteria = 'PatientRegNo';
                    }

                }
                else if (selectedBillTypeVal[0].checked) {
                    var selectedCriteriaVal = $('#MainContent_tabContainerBilling_tabPnlCreateBill_drpSearchCriteria').val();
                    var searchCriteria = '';
                    if (selectedCriteriaVal == 1) {
                        searchCriteria = 'PatientName_IP';
                    }
                    else if (selectedCriteriaVal == 2) {
                        searchCriteria = 'MobileNo_IP';
                    }
                    else if (selectedCriteriaVal == 3) {
                        searchCriteria = 'Email_IP';
                    }
                    else if (selectedCriteriaVal == 4) {
                        searchCriteria = 'PatientRegNo_IP';
                    }
                    else {
                        searchCriteria = 'IPCaseNum';
                    }


                }
            }
           
            else
                {
           
                var selectedCriteriaVal = $('#MainContent_tabContainerBilling_tabPnlCreateBill_drpSearchCriteria').val();
                var searchCriteria = '';
                if (selectedCriteriaVal == 1) {
                    searchCriteria = 'PatientName';

                }
                else if (selectedCriteriaVal == 2) {
                    searchCriteria = 'MobileNo';
                }
                else if (selectedCriteriaVal == 3) {
                    searchCriteria = 'Email';
                }
                else {
                    searchCriteria = 'PatientRegNo';
                }

            }
          

               
            
          
                sender.set_contextKey(searchCriteria);
               
                }
                
        //}
            
                // sender.set_contextKey(searchCriteria);
                //return flag;
        // var selectedBillTypeVal = document.getElementById('<%=rb_BillType.ClientID%>');
        //var AspRadio_ListItem = document.getElementsByTagName('input');
        function onPatientSelected(source, e) {
            $('#MainContent_tabContainerBilling_tabPnlCreateBill_hdnSelectedPatientID').val(e.get_value());
            $('#MainContent_tabContainerBilling_tabPnlCreateBill_btnSearchPatientRec').click();
        }

        function onDoctorSelected(source, e) {
            $('#MainContent_tabContainerBilling_tabPnlCreateBill_hdnRefDocID').val(e.get_value());
            $('#MainContent_tabContainerBilling_tabPnlCreateBill_txtBillRefDocName').attr("ReadOnly", "true");
            $('#MainContent_tabContainerBilling_tabPnlCreateBill_txtBillRefDocName').css("background-color", "#DEDEDE");
        }

        window.onload = calculateDiscountAndTax;
        //Calculate Discount and Tax
        function calculateDiscountAndTax() {
            if ($('#MainContent_tabContainerBilling_tabPnlCreateBill_txtDiscount').val().trim() == "") {
                $('#MainContent_tabContainerBilling_tabPnlCreateBill_txtDiscount').val('0.00');
            }
            if ($('#MainContent_tabContainerBilling_tabPnlCreateBill_txtBillTax').val().trim() == "") {
                $('#MainContent_tabContainerBilling_tabPnlCreateBill_txtBillTax').val('0.00');
            }
            //if ($('#MainContent_tabContainerBilling_tabPnlCreateBill_txtBillCGST').val().trim() == "") {
            //    $('#MainContent_tabContainerBilling_tabPnlCreateBill_txtBillCGST').val('0.00');
            //}
            //if ($('#MainContent_tabContainerBilling_tabPnlCreateBill_txtBillSGST').val().trim() == "") {
            //    $('#MainContent_tabContainerBilling_tabPnlCreateBill_txtBillSGST').val('0.00');
            //}
            //var CGSTEntered = $('#MainContent_tabContainerBilling_tabPnlCreateBill_txtBillCGST').val().trim();
            //var SGSTEntered = $('#MainContent_tabContainerBilling_tabPnlCreateBill_txtBillSGST').val().trim();
            var discountEntered = $('#MainContent_tabContainerBilling_tabPnlCreateBill_txtDiscount').val().trim();
            var taxEntered = $('#MainContent_tabContainerBilling_tabPnlCreateBill_txtBillTax').val().trim();

            var calculatedDiscount = 0;
            var calculatedTax = 0;
            var calculatedCGST = 0;
            var calculatedSGST = 0;
            var amtPayable = 0;
            var subTotal = parseFloat($("[id$=lblBillSubTotal]").text());
            if (discountEntered.trim() != "") {
                var discountType = $("[id$=ddlDiscountType]").val();
                if (discountType == "currency") {
                    if (parseFloat(discountEntered) > parseFloat(subTotal)) {
                        alert('Discount amount cannot be more than sub total');
                        $('#MainContent_tabContainerBilling_tabPnlCreateBill_txtDiscount').val('0.00');
                        return;
                    }
                    else {
                        calculatedDiscount = parseFloat(discountEntered).toFixed(2);
                    }
                }
                else {
                    if (discountEntered > 100) {
                        alert('Discount amount cannot be more than sub total');
                        $('#MainContent_tabContainerBilling_tabPnlCreateBill_txtDiscount').val('0.00');
                        return;
                    }
                    else {
                        calculatedDiscount = ((subTotal * parseFloat(discountEntered)) / 100).toFixed(2);
                    }
                }
            }
            if (taxEntered.trim() != "") {
                calculatedTax = ((subTotal * parseFloat(taxEntered)) / 100).toFixed(2);
            }
            //if (CGSTEntered.trim() != "") {
            //    calculatedCGST = ((subTotal * parseFloat(CGSTEntered)) / 100).toFixed(2);
            //}
            //if (SGSTEntered.trim() != "") {
            //    calculatedSGST = ((subTotal * parseFloat(SGSTEntered)) / 100).toFixed(2);
            //}
            amtPayable = ((parseFloat(subTotal) - parseFloat(calculatedDiscount)) + parseFloat(calculatedTax));
            $('#MainContent_tabContainerBilling_tabPnlCreateBill_lblDiscount').text(parseFloat(calculatedDiscount).toFixed(2));
            $('#MainContent_tabContainerBilling_tabPnlCreateBill_hdnDiscount').val(parseFloat(calculatedDiscount).toFixed(2));
            $('#MainContent_tabContainerBilling_tabPnlCreateBill_lblBillTaxPercentage').text(parseFloat(calculatedTax).toFixed(2));
            $('#MainContent_tabContainerBilling_tabPnlCreateBill_hdnBillTaxPercentage').val(parseFloat(calculatedTax).toFixed(2));

            //$('#MainContent_tabContainerBilling_tabPnlCreateBill_lblBillCGSTPercentage').text(parseFloat(calculatedCGST).toFixed(2));
            //$('#MainContent_tabContainerBilling_tabPnlCreateBill_hdnBillCGSTPercentage').val(parseFloat(calculatedCGST).toFixed(2));

            //$('#MainContent_tabContainerBilling_tabPnlCreateBill_lblBillSGSTPercentage').text(parseFloat(calculatedSGST).toFixed(2));
            //$('#MainContent_tabContainerBilling_tabPnlCreateBill_hdnBillSGSTPercentage').val(parseFloat(calculatedSGST).toFixed(2));
            if ('<%=rb_BillType.Visible%>' == 'True') {
                var selectedBillTypeVal = document.getElementsByName('<%=rb_BillType.UniqueID%>');
                if (selectedBillTypeVal[0].checked) {
                    var advanceamount = document.getElementById('<%= TextBox_AdvnaceAmt.ClientID %>').value;
                    if (parseFloat(amtPayable) < parseFloat(advanceamount)) {
                        var totalbillpayable = advanceamount - amtPayable;
                        $('#MainContent_tabContainerBilling_tabPnlCreateBill_lblBillAmountPayable').text(parseFloat(amtPayable).toFixed(2));
                        $('#MainContent_tabContainerBilling_tabPnlCreateBill_hdnBillAmountPayable').val(parseFloat(amtPayable).toFixed(2));

                        $('#MainContent_tabContainerBilling_tabPnlCreateBill_txtBillAmountPaid').val("0.00");
                        document.getElementById('<%= lblBalance.ClientID %>').innerHTML = "0.00";
                        document.getElementById('<%= hdnBalance.ClientID %>').value = "0.00";
                    }
                    else {


                        var totalbillpayable = amtPayable - advanceamount;
                        $('#MainContent_tabContainerBilling_tabPnlCreateBill_lblBillAmountPayable').text(parseFloat(amtPayable).toFixed(2));
                        $('#MainContent_tabContainerBilling_tabPnlCreateBill_hdnBillAmountPayable').val(parseFloat(amtPayable).toFixed(2));
                        document.getElementById('<%= txtBillAmountPaid.ClientID %>').value = "0.00";


                        document.getElementById('<%= lblBalance.ClientID %>').innerHTML = totalbillpayable.toFixed(2);
                        document.getElementById('<%= hdnBalance.ClientID %>').value = totalbillpayable.toFixed(2);
                    }
                }
                else {
                    $('#MainContent_tabContainerBilling_tabPnlCreateBill_lblBillAmountPayable').text(parseFloat(amtPayable).toFixed(2));
                    $('#MainContent_tabContainerBilling_tabPnlCreateBill_hdnBillAmountPayable').val(parseFloat(amtPayable).toFixed(2));
                    //$('#MainContent_tabContainerBilling_tabPnlCreateBill_txtBillAmountPaid').val(parseFloat(amtPayable).toFixed(2));
                    $('#MainContent_tabContainerBilling_tabPnlCreateBill_txtBillAmountPaid').val("0.00");
                    //$('#MainContent_tabContainerBilling_tabPnlCreateBill_lblBalance').text("0.00");
                    //$('#MainContent_tabContainerBilling_tabPnlCreateBill_hdnBalance').val("0.00");
                    $('#MainContent_tabContainerBilling_tabPnlCreateBill_lblBalance').text(parseFloat(amtPayable).toFixed(2));
                    $('#MainContent_tabContainerBilling_tabPnlCreateBill_hdnBalance').val(parseFloat(amtPayable).toFixed(2));
                }            
            }
            else {
                $('#MainContent_tabContainerBilling_tabPnlCreateBill_lblBillAmountPayable').text(parseFloat(amtPayable).toFixed(2));
                $('#MainContent_tabContainerBilling_tabPnlCreateBill_hdnBillAmountPayable').val(parseFloat(amtPayable).toFixed(2));
                //$('#MainContent_tabContainerBilling_tabPnlCreateBill_txtBillAmountPaid').val(parseFloat(amtPayable).toFixed(2));
                $('#MainContent_tabContainerBilling_tabPnlCreateBill_txtBillAmountPaid').val("0.00");
                //$('#MainContent_tabContainerBilling_tabPnlCreateBill_lblBalance').text("0.00");
                //$('#MainContent_tabContainerBilling_tabPnlCreateBill_hdnBalance').val("0.00");
                $('#MainContent_tabContainerBilling_tabPnlCreateBill_lblBalance').text(parseFloat(amtPayable).toFixed(2));
                $('#MainContent_tabContainerBilling_tabPnlCreateBill_hdnBalance').val(parseFloat(amtPayable).toFixed(2));
            }
            AmountOwedToHospAndPat();
        }

        //Calculate balance Amt
        function onTxtBillAmountPaidChanged() {
            var amtPaidTxt = $('#MainContent_tabContainerBilling_tabPnlCreateBill_txtBillAmountPaid').val().trim();
            if (amtPaidTxt == "") {
                $('#MainContent_tabContainerBilling_tabPnlCreateBill_txtBillAmountPaid').val('0.00');
                amtPaidTxt = '0.00';
            }
            $('#MainContent_tabContainerBilling_tabPnlCreateBill_txtBillAmountPaid').val(parseFloat(amtPaidTxt).toFixed(2))
            var txtBillAmtPaid = $('#MainContent_tabContainerBilling_tabPnlCreateBill_txtBillAmountPaid').val().trim();
            var lblAmtPayable = $('#MainContent_tabContainerBilling_tabPnlCreateBill_lblBillAmountPayable').text();
            if ('<%=rb_BillType.Visible%>' == 'True') {
                var selectedBillTypeVal = document.getElementsByName('<%=rb_BillType.UniqueID%>');
                 if (selectedBillTypeVal[0].checked) {
                     var advanceamount = document.getElementById('<%= TextBox_AdvnaceAmt.ClientID %>').value;
                            if (parseFloat(lblAmtPayable) < parseFloat(advanceamount)) {
                                document.getElementById('<%= lblBalance.ClientID %>').innerHTML = "0.00";
                            }
                            else {
                                var totalbillpayable = parseFloat(lblAmtPayable) - advanceamount ;
                                document.getElementById('<%= lblBalance.ClientID %>').innerHTML = totalbillpayable.toFixed(2);
                            }
                        }
                        else {
                            var bal = parseFloat(lblAmtPayable);
                            $('#MainContent_tabContainerBilling_tabPnlCreateBill_lblBalance').text(parseFloat(bal).toFixed(2));
                        }
                    }
                    else {
                        var bal = parseFloat(lblAmtPayable);
                        $('#MainContent_tabContainerBilling_tabPnlCreateBill_lblBalance').text(parseFloat(bal).toFixed(2));
                    }
            var balancepayable=$('#MainContent_tabContainerBilling_tabPnlCreateBill_lblBalance').text();
            if (txtBillAmtPaid == "") {
                $('#MainContent_tabContainerBilling_tabPnlCreateBill_lblBalance').text(lblAmtPayable);
                $('#MainContent_tabContainerBilling_tabPnlCreateBill_hdnBalance').val(lblAmtPayable);
            }
            else {
                if (parseFloat(txtBillAmtPaid) > parseFloat(balancepayable)) {
                    alert("Entered Amount Exceeds the Actual Amount");
                    $('#MainContent_tabContainerBilling_tabPnlCreateBill_txtBillAmountPaid').val('0.00');
                    return;
                  
                }
                else {
                    if ('<%=rb_BillType.Visible%>' == 'True') {
                        var selectedBillTypeVal = document.getElementsByName('<%=rb_BillType.UniqueID%>');
                         if (selectedBillTypeVal[0].checked) {
                             var advanceamount = document.getElementById('<%= TextBox_AdvnaceAmt.ClientID %>').value;
                     if (parseFloat(lblAmtPayable) < parseFloat(advanceamount)) {
                         document.getElementById('<%= lblBalance.ClientID %>').innerHTML = "0.00";
                                document.getElementById('<%= hdnBalance.ClientID %>').value = "0.00";
                            }
                            else {
                         var totalbillpayable = parseFloat(lblAmtPayable) - advanceamount - parseFloat(txtBillAmtPaid);
                                document.getElementById('<%= lblBalance.ClientID %>').innerHTML = totalbillpayable.toFixed(2);
                                document.getElementById('<%= hdnBalance.ClientID %>').value = totalbillpayable.toFixed(2);
                            }
                        }
                        else {
                            var bal = parseFloat(lblAmtPayable) - parseFloat(txtBillAmtPaid);
                            $('#MainContent_tabContainerBilling_tabPnlCreateBill_lblBalance').text(parseFloat(bal).toFixed(2));
                            $('#MainContent_tabContainerBilling_tabPnlCreateBill_hdnBalance').val(parseFloat(bal).toFixed(2));
                        }
                    }
                    else {
                        var bal = parseFloat(lblAmtPayable) - parseFloat(txtBillAmtPaid);
                        $('#MainContent_tabContainerBilling_tabPnlCreateBill_lblBalance').text(parseFloat(bal).toFixed(2));
                        $('#MainContent_tabContainerBilling_tabPnlCreateBill_hdnBalance').val(parseFloat(bal).toFixed(2));
                    }
                }
            }
            BillAmountPaidChangedAmountOwedToHospAndPat();
        }
        //Discount Authorisation tracker
        function UpdateBillDiscountPreventMultipleClicks(button) {
            var hdnfldVariable = $('#MainContent_tabContainerBilling_tabPnlCreateBill_hdnActiveDiscount').val().trim();
            if (hdnfldVariable == "True") {
                var Discountval = $('#MainContent_tabContainerBilling_tabPnlCreateBill_txtDicForBalAmt').val().trim();
                if (Discountval != 0 || Discountval != 0.00) {
                    var modal = $find("<%= MPEBillDiscount.ClientID %>");
                    modal.show();
                    
                    return false;
                }
            }
            return true;
        }

        function SaveBillPreventMultipleClicks(button) {
             $('#MainContent_tabContainerBilling_tabPnlCreateBill_hdnbasedonclick').val('Save');
            if ($('#MainContent_tabContainerBilling_tabPnlCreateBill_lblPatientFullName').text().trim() == "") {
                alert("Please Select Patient to Continue");
                $('#MainContent_tabContainerBilling_tabPnlCreateBill_txtPatientBillSearch').val("");
                $('#MainContent_tabContainerBilling_tabPnlCreateBill_txtPatientBillSearch').focus();
                return false;
            }
            var hdnfldVariable = $('#MainContent_tabContainerBilling_tabPnlCreateBill_hdnActiveDiscount').val().trim();
            if (hdnfldVariable == "True") {
                var Discountval = $('#MainContent_tabContainerBilling_tabPnlCreateBill_txtDiscount').val().trim();
                if (Discountval != 0 || Discountval != 0.00) {
                    var modal = $find("<%= MPEBillDiscount.ClientID %>");
                    modal.show();
                    return false;
                }
            }
            
            var txtBillAmtPaid = $('#MainContent_tabContainerBilling_tabPnlCreateBill_txtBillAmountPaid').val().trim();
            var lblAmtPayable = $('#MainContent_tabContainerBilling_tabPnlCreateBill_lblBillAmountPayable').text();
            if (parseFloat(txtBillAmtPaid) > parseFloat(lblAmtPayable)) {
                alert("Entered Amount Exceeds the Actual Amount");
                return false;
            }

            var selectedPaymentMode = $('#MainContent_tabContainerBilling_tabPnlCreateBill_ddlPaymentMode').val();
            if (selectedPaymentMode != "Cash") {
                if ($('#MainContent_tabContainerBilling_tabPnlCreateBill_txtBillPaymentModeRefNo').val().trim() == "") {
                    if (selectedPaymentMode == "Credit Card") {
                        alert("Please Enter The Credit Card No");
                        $('#MainContent_tabContainerBilling_tabPnlCreateBill_txtBillPaymentModeRefNo').focus();
                    }
                    else if (selectedPaymentMode == "Cheque") {
                        alert("Please Enter Cheque No");
                        $('#MainContent_tabContainerBilling_tabPnlCreateBill_txtBillPaymentModeRefNo').focus();
                    }
                    else if (selectedPaymentMode == "Debit Card") {
                        alert("Please Enter Debit Card No");
                        $('#MainContent_tabContainerBilling_tabPnlCreateBill_txtBillPaymentModeRefNo').focus();
                    }
                    else {
                        alert("Please Enter Reference No");
                        $('#MainContent_tabContainerBilling_tabPnlCreateBill_txtBillPaymentModeRefNo').focus();
                    }
                    return false;
                }

            }
            var selectedCustomerCategory = $('#MainContent_tabContainerBilling_tabPnlCreateBill_ddlCustomerCategory').val();
            if (selectedCustomerCategory == "CRP") {
                var selectedCorporate = $('#MainContent_tabContainerBilling_tabPnlCreateBill_ddlCorporates').val();
                if (selectedCorporate == "--Select Corporate--") {
                    alert('Please Select The Corporate');
                    return false;
                }
            }
            //Check entries "particular" drop down in billing grid is empty
            var grid = document.getElementById('<%=grdBillDetails.ClientID %>');
            for (var i = 0; i < grid.rows.length - 1 ; i++) {
                var ddlParticular = $("select[name$=ddlParticulars]");
                if (ddlParticular[i].value.trim() == '') {
                    alert('Particular Can Not Be Empty');
                    return false;
                }

            }
            DisableButton();
            //var control = button;
            //button.disabled = true;
            //return true;
        }
        function UpdateBillPreventMultipleClicks(button) {
            button.disabled = true;
            return true;
        }

        function DisableButton() {
            document.getElementById('<%= btnSaveBill.ClientID %>').disabled = "disabled";
            __doPostBack('<%= btnSaveBill.ClientID %>', '');
        }

        function checkAll(objRef) {
            var GridView = objRef.parentNode.parentNode.parentNode;
            var inputList = GridView.getElementsByTagName("input");
            for (var i = 0; i < inputList.length; i++) {
                //Get the Cell To find out ColumnIndex
                var row = inputList[i].parentNode.parentNode;
                if (inputList[i].type == "checkbox" && objRef != inputList[i]) {
                    if (objRef.checked) {
                        //If the header checkbox is checked
                        //check all checkboxes
                        //and highlight all rows
                        row.style.backgroundColor = "aqua";
                        inputList[i].checked = true;
                    }
                    else {
                        //If the header checkbox is checked
                        //uncheck all checkboxes
                        //and change rowcolor back to original
                        if (row.rowIndex % 2 == 0) {
                            //Alternating Row Color
                            row.style.backgroundColor = "#F8F8FF";
                        }
                        else {
                            row.style.backgroundColor = "white";
                        }
                        inputList[i].checked = false;
                    }
                }
            }
        }
        function Check_Click(objRef) {
            //Get the Row based on checkbox
            var row = objRef.parentNode.parentNode;
            if (objRef.checked) {
                //If checked change color to Aqua
                row.style.backgroundColor = "aqua";
            }
            else {
                //If not checked change back to original color
                if (row.rowIndex % 2 == 0) {
                    //Alternating Row Color
                    row.style.backgroundColor = "#F7F6F3";
                }
                else {
                    row.style.backgroundColor = "white";
                }
            }

            //Get the reference of GridView
            var GridView = row.parentNode;

            //Get all input elements in Gridview
            var inputList = GridView.getElementsByTagName("input");

            for (var i = 0; i < inputList.length; i++) {
                //The First element is the Header Checkbox
                var headerCheckBox = inputList[0];

                //Based on all or none checkboxes
                //are checked check/uncheck Header Checkbox
                var checked = true;
                if (inputList[i].type == "checkbox" && inputList[i] != headerCheckBox) {
                    if (!inputList[i].checked) {
                        checked = false;
                        break;
                    }
                }
            }
            headerCheckBox.checked = checked;
        }
        function Confirm_DeleteTest() {

            var Grid = document.getElementById('<%=grdBillDetails.ClientID %>');
            if (selectAtleastOne(Grid) == true) {
                if (confirm("Are you sure you want to Remove from the List?")) {
                    return true;
                }
                else {

                    return false;
                }
            }
            else {
                return false;
            }
            return true;
        }

        function selectAtleastOne(Grid) {
            var CheckForChecked = 0;
            var countChecked = 0;
            if (Grid != null) {
                for (i = 1; i < Grid.rows.length; i++) {
                    cell = Grid.rows[i].cells[0];
                    for (j = 0; j < cell.childNodes.length; j++) {
                        if (cell.childNodes[j].type == "checkbox") {
                            if (cell.childNodes[j].checked) {
                                CheckForChecked = 1;
                            }

                        }
                    }
                }
            }

            if (CheckForChecked == 0) {
                alert("Please select a row .");
                return false;
            }
            else {
                return true;
            }
        }

        function ReferenceNoVisible() {
            var selectedPaymentMode = $('#MainContent_tabContainerBilling_tabPnlCreateBill_ddlPaymentMode').val();
            $('#MainContent_tabContainerBilling_tabPnlCreateBill_txtBillPaymentModeRefNo').val('');
            if (selectedPaymentMode == "Cash") {
                $('#MainContent_tabContainerBilling_tabPnlCreateBill_txtBillPaymentModeRefNo').css("display", "none");
            }
            else if (selectedPaymentMode == "Credit Card") {
                $('#MainContent_tabContainerBilling_tabPnlCreateBill_txtBillPaymentModeRefNo').css("display", "block");
                $('#MainContent_tabContainerBilling_tabPnlCreateBill_txtBillPaymentModeRefNo').attr("placeholder", "Credit Card No");
            }
            else if (selectedPaymentMode == "Cheque") {
                $('#MainContent_tabContainerBilling_tabPnlCreateBill_txtBillPaymentModeRefNo').css("display", "block");
                $('#MainContent_tabContainerBilling_tabPnlCreateBill_txtBillPaymentModeRefNo').attr("placeholder", "Cheque No");
            }
            else if (selectedPaymentMode == "NEFT/RTGS") {
                $('#MainContent_tabContainerBilling_tabPnlCreateBill_txtBillPaymentModeRefNo').css("display", "block");
                $('#MainContent_tabContainerBilling_tabPnlCreateBill_txtBillPaymentModeRefNo').attr("placeholder", "NEFT/RTGS");
            }
            else if (selectedPaymentMode == "Debit Card") {
                $('#MainContent_tabContainerBilling_tabPnlCreateBill_txtBillPaymentModeRefNo').css("display", "block");
                $('#MainContent_tabContainerBilling_tabPnlCreateBill_txtBillPaymentModeRefNo').attr("placeholder", "Debit Card No");
            }

        }
        function VerifyRefNo() {
            var selectedPaymentMode = $('#MainContent_tabContainerBilling_tabPnlCreateBill_ddlPaymentMode').val();
            var refNo = $('#MainContent_tabContainerBilling_tabPnlCreateBill_txtBillPaymentModeRefNo').val();
            if (selectedPaymentMode == "Cash") {
                //do nothing
            }
            else if (selectedPaymentMode == "Credit Card") {
                if (refNo.trim().length > 6) {
                    alert('Credit Card Number Exceeds 6 digits');
                    $('#MainContent_tabContainerBilling_tabPnlCreateBill_txtBillPaymentModeRefNo').val('');
                    $('#MainContent_tabContainerBilling_tabPnlCreateBill_txtBillPaymentModeRefNo').focus();
                }
            }
            else if (selectedPaymentMode == "Debit Card") {
                if (refNo.trim().length > 6) {
                    alert('Debit Card Number Exceeds 6 digits');
                    $('#MainContent_tabContainerBilling_tabPnlCreateBill_txtBillPaymentModeRefNo').val('');
                    $('#MainContent_tabContainerBilling_tabPnlCreateBill_txtBillPaymentModeRefNo').focus();
                }
            }
            else if (selectedPaymentMode == "Cheque") {

            }
            else {
            }
        }
        function OnCustomerCategoryChange() {
            if ($('#MainContent_tabContainerBilling_tabPnlCreateBill_ddlCustomerCategory').val() == "WKIN") {
                $('#MainContent_tabContainerBilling_tabPnlCreateBill_txtWalkinCorporate').css('display', 'block');
                $('#MainContent_tabContainerBilling_tabPnlCreateBill_ddlCorporates').css('display', 'none');
            }
            else {

                if ($('#MainContent_tabContainerBilling_tabPnlCreateBill_ddlCorporates option').length > 1) {
                    $("#MainContent_tabContainerBilling_tabPnlCreateBill_ddlCorporates").val($("#MainContent_tabContainerBilling_tabPnlCreateBill_ddlCorporates option:first").val());
                    $('#MainContent_tabContainerBilling_tabPnlCreateBill_txtWalkinCorporate').css('display', 'none');
                    $('#MainContent_tabContainerBilling_tabPnlCreateBill_ddlCorporates').css('display', 'block');
                }
                else {
                    alert('Please Create Corporate Frist');
                    $('#MainContent_tabContainerBilling_tabPnlCreateBill_ddlCustomerCategory').val($("#MainContent_tabContainerBilling_tabPnlCreateBill_ddlCustomerCategory option:first").val())
                    $('#MainContent_tabContainerBilling_tabPnlCreateBill_txtWalkinCorporate').css('display', 'block');
                    $('#MainContent_tabContainerBilling_tabPnlCreateBill_ddlCorporates').css('display', 'none');
                    return false;
                }
            }
        }
        function onChangeBillListSearchCriteria() {
            $('#MainContent_tabContainerBilling_tabPnlListBills_ddlBillListStatus').val($('#MainContent_tabContainerBilling_tabPnlListBills_ddlBillListStatus option:first'));
            var billSearchCriteria = $('#MainContent_tabContainerBilling_tabPnlListBills_ddlBillListSearchCriteria').val();
            if (billSearchCriteria == "Bill Date") {
                $('#MainContent_tabContainerBilling_tabPnlListBills_lblBillListFrom').css('display', 'block');
                $('#MainContent_tabContainerBilling_tabPnlListBills_lblBillListTo').css('display', 'block');
                $('#MainContent_tabContainerBilling_tabPnlListBills_txtBillListFromDate').css('display', 'block');
                $('#MainContent_tabContainerBilling_tabPnlListBills_txtBillListToDate').css('display', 'block');

                $('#MainContent_tabContainerBilling_tabPnlListBills_TextBox_mobileno').css('display', 'none');
                $('#MainContent_tabContainerBilling_tabPnlListBills_Labelmobno').css('display', 'none');
                $('#MainContent_tabContainerBilling_tabPnlListBills_TextBox_regno').css('display', 'none');
                $('#MainContent_tabContainerBilling_tabPnlListBills_Labelregno').css('display', 'none');
                $('#MainContent_tabContainerBilling_tabPnlListBills_lblBillListBillNum').css('display', 'none');
                $('#MainContent_tabContainerBilling_tabPnlListBills_lblBillListPatintName').css('display', 'none');
                $('#MainContent_tabContainerBilling_tabPnlListBills_txtBillListBillNum').css('display', 'none');
                $('#MainContent_tabContainerBilling_tabPnlListBills_txtBillListPatintName').css('display', 'none');
            }
            else if (billSearchCriteria == "Patient Name") {
                $('#MainContent_tabContainerBilling_tabPnlListBills_lblBillListPatintName').css('display', 'block');
                $('#MainContent_tabContainerBilling_tabPnlListBills_txtBillListPatintName').css('display', 'block');

                $('#MainContent_tabContainerBilling_tabPnlListBills_TextBox_mobileno').css('display', 'none');
                $('#MainContent_tabContainerBilling_tabPnlListBills_Labelmobno').css('display', 'none');
                $('#MainContent_tabContainerBilling_tabPnlListBills_TextBox_regno').css('display', 'none');
                $('#MainContent_tabContainerBilling_tabPnlListBills_Labelregno').css('display', 'none');
                $('#MainContent_tabContainerBilling_tabPnlListBills_lblBillListFrom').css('display', 'none');
                $('#MainContent_tabContainerBilling_tabPnlListBills_lblBillListTo').css('display', 'none');
                $('#MainContent_tabContainerBilling_tabPnlListBills_txtBillListFromDate').css('display', 'none');
                $('#MainContent_tabContainerBilling_tabPnlListBills_txtBillListToDate').css('display', 'none');
                $('#MainContent_tabContainerBilling_tabPnlListBills_lblBillListBillNum').css('display', 'none');
                $('#MainContent_tabContainerBilling_tabPnlListBills_txtBillListBillNum').css('display', 'none');
            }
            else if (billSearchCriteria == "Registration No") {
                $('#MainContent_tabContainerBilling_tabPnlListBills_TextBox_regno').css('display', 'block');
                $('#MainContent_tabContainerBilling_tabPnlListBills_Labelregno').css('display', 'block');

                $('#MainContent_tabContainerBilling_tabPnlListBills_TextBox_mobileno').css('display', 'none');
                $('#MainContent_tabContainerBilling_tabPnlListBills_Labelmobno').css('display', 'none');                
                $('#MainContent_tabContainerBilling_tabPnlListBills_lblBillListPatintName').css('display', 'none');
                $('#MainContent_tabContainerBilling_tabPnlListBills_txtBillListPatintName').css('display', 'none');
                $('#MainContent_tabContainerBilling_tabPnlListBills_lblBillListFrom').css('display', 'none');
                $('#MainContent_tabContainerBilling_tabPnlListBills_lblBillListTo').css('display', 'none');
                $('#MainContent_tabContainerBilling_tabPnlListBills_txtBillListFromDate').css('display', 'none');
                $('#MainContent_tabContainerBilling_tabPnlListBills_txtBillListToDate').css('display', 'none');
                $('#MainContent_tabContainerBilling_tabPnlListBills_lblBillListBillNum').css('display', 'none');
                $('#MainContent_tabContainerBilling_tabPnlListBills_txtBillListBillNum').css('display', 'none');
            }
            else if (billSearchCriteria == "Mobile Number") {
                $('#MainContent_tabContainerBilling_tabPnlListBills_TextBox_mobileno').css('display', 'block');
                $('#MainContent_tabContainerBilling_tabPnlListBills_Labelmobno').css('display', 'block');

                $('#MainContent_tabContainerBilling_tabPnlListBills_TextBox_regno').css('display', 'none');
                $('#MainContent_tabContainerBilling_tabPnlListBills_Labelregno').css('display', 'none');
                $('#MainContent_tabContainerBilling_tabPnlListBills_lblBillListPatintName').css('display', 'none');
                $('#MainContent_tabContainerBilling_tabPnlListBills_txtBillListPatintName').css('display', 'none');
                $('#MainContent_tabContainerBilling_tabPnlListBills_lblBillListFrom').css('display', 'none');
                $('#MainContent_tabContainerBilling_tabPnlListBills_lblBillListTo').css('display', 'none');
                $('#MainContent_tabContainerBilling_tabPnlListBills_txtBillListFromDate').css('display', 'none');
                $('#MainContent_tabContainerBilling_tabPnlListBills_txtBillListToDate').css('display', 'none');
                $('#MainContent_tabContainerBilling_tabPnlListBills_lblBillListBillNum').css('display', 'none');
                $('#MainContent_tabContainerBilling_tabPnlListBills_txtBillListBillNum').css('display', 'none');
            }
            else {
                $('#MainContent_tabContainerBilling_tabPnlListBills_lblBillListBillNum').css('display', 'block');
                $('#MainContent_tabContainerBilling_tabPnlListBills_txtBillListBillNum').css('display', 'block');

                $('#MainContent_tabContainerBilling_tabPnlListBills_TextBox_mobileno').css('display', 'none');
                $('#MainContent_tabContainerBilling_tabPnlListBills_Labelmobno').css('display', 'none');
                $('#MainContent_tabContainerBilling_tabPnlListBills_TextBox_regno').css('display', 'none');
                $('#MainContent_tabContainerBilling_tabPnlListBills_Labelregno').css('display', 'none');
                $('#MainContent_tabContainerBilling_tabPnlListBills_lblBillListPatintName').css('display', 'none');
                $('#MainContent_tabContainerBilling_tabPnlListBills_txtBillListPatintName').css('display', 'none');
                $('#MainContent_tabContainerBilling_tabPnlListBills_lblBillListFrom').css('display', 'none');
                $('#MainContent_tabContainerBilling_tabPnlListBills_lblBillListTo').css('display', 'none');
                $('#MainContent_tabContainerBilling_tabPnlListBills_txtBillListFromDate').css('display', 'none');
                $('#MainContent_tabContainerBilling_tabPnlListBills_txtBillListToDate').css('display', 'none');
            }
        }

        function onPatientNameSelectedInListBills(source, e) {
            $('#MainContent_tabContainerBilling_tabPnlListBills_hdnBillSearchPatientID').val(e.get_value());
        }

        function onMobilenoSelectedInListBills(source, e) {
            $('#MainContent_tabContainerBilling_tabPnlListBills_HiddenField_mobileno').val(e.get_value());
        }

        function onRegnoSelectedInListBills(source, e) {
            $('#MainContent_tabContainerBilling_tabPnlListBills_HiddenField_regno').val(e.get_value());
        }

        function OnBalancePaidTextChange() {
            var tempBalAmtPaid = $('#MainContent_tabContainerBilling_tabPnlCreateBill_txtBalancePayable').val().trim();
            if (tempBalAmtPaid == "") {
                $('#MainContent_tabContainerBilling_tabPnlCreateBill_txtBalancePayable').val('0.00');
                tempBalAmtPaid = '0.00';
            }
            $('#MainContent_tabContainerBilling_tabPnlCreateBill_txtBalancePayable').val(parseFloat(tempBalAmtPaid).toFixed(2))
            var balAmtPaid = $('#MainContent_tabContainerBilling_tabPnlCreateBill_txtBalancePayable').val().trim();
            var balPayableAmt = $('#MainContent_tabContainerBilling_tabPnlCreateBill_lblBalance').text().trim();
            if (parseFloat(balAmtPaid) > parseFloat(balPayableAmt)) {
                alert('Amount Should not Exceed Balance Payable Amount');
                $('#MainContent_tabContainerBilling_tabPnlCreateBill_txtBalancePayable').val('0.00');
                $('#MainContent_tabContainerBilling_tabPnlCreateBill_lblLeftBal').text('');
                return;
            }
            else {
                var bal = parseFloat(balPayableAmt) - parseFloat(balAmtPaid);
                $('#MainContent_tabContainerBilling_tabPnlCreateBill_lblLeftBal').text(parseFloat(bal).toFixed(2));
            }
            BalancePaidChangedAmountOwedToHospAndPat();
        }
        function Confirm() {
            var confirm_value = document.createElement("INPUT");
            confirm_value.type = "hidden";
            confirm_value.name = "confirm_value";
            if (confirm("You are about to cancel a bill and the action cannot be reverted. Do you want to proceed?")) {
                confirm_value.value = "Yes";
            } else {
                confirm_value.value = "No";
            }
            document.forms[0].appendChild(confirm_value);
        }

        function HideModalpopupBillCancel() {
            $find("MPEBillCancellation").hide();
            //$find("MPE_ModifyBill").hide();
        }
        function ShowModalpopupBillCancel() {
            $find("MPEBillCancellation").show();
        }
        //function ShowModalpopupBillDiscount() {
        //    $find("MPEBillDiscount").show();
        //}
        //function HideModalpopupBillDiscount() {
        //    $find("MPEBillDiscount").hide();
        //}
        function OkButtonOfCancelBillMsgPopUp() {
            $find("MPECancelBillMsg").hide();
        }

        function HideModalpopupBillDelete() {
            $find("mpedeletingbill").hide();
        }

        function PreviousPadrticularDdlEmpty(button) {
            //Check entries "particular" drop down in billing grid is empty
            var grid = document.getElementById('<%=grdBillDetails.ClientID %>');
            var lastRowNum = grid.rows.length - 2
            if (lastRowNum >= 0) {
                var ddlParticular = $("select[name$=ddlParticulars]");
                if (ddlParticular[lastRowNum].value.trim() == '') {
                    alert('Particular is Empty in Last Row!! Please Create Particular or Select Different Service To Proceed');
                    return false;
                }             
            }
        }

        //when discount of balance is changed
        function onTextDisxountForBalAmtChange() {
            if ($('#MainContent_tabContainerBilling_tabPnlCreateBill_txtDicForBalAmt').val().trim() == "") {
                $('#MainContent_tabContainerBilling_tabPnlCreateBill_txtDicForBalAmt').val('0.00');
            }
            var discountEntered = $('#MainContent_tabContainerBilling_tabPnlCreateBill_txtDicForBalAmt').val().trim();
            var pendingBalAmt = $('#MainContent_tabContainerBilling_tabPnlCreateBill_lblPendingBalance').text().trim();
            if (parseFloat(discountEntered) > parseFloat(pendingBalAmt)) {
                alert('Discount amount cannot be more than sub total');
                $('#MainContent_tabContainerBilling_tabPnlCreateBill_txtDicForBalAmt').val('0.00');
                $('#MainContent_tabContainerBilling_tabPnlCreateBill_lblDicForBalAmt').text('0.00');
                $('#MainContent_tabContainerBilling_tabPnlCreateBill_hdnDicForBalAmt').val('0.00');

                $('#MainContent_tabContainerBilling_tabPnlCreateBill_lblBalance').text(parseFloat(pendingBalAmt).toFixed(2));
                $('#MainContent_tabContainerBilling_tabPnlCreateBill_hdnBalance').val(parseFloat(pendingBalAmt).toFixed(2));
                $('#MainContent_tabContainerBilling_tabPnlCreateBill_lblLeftBal').text(parseFloat(pendingBalAmt).toFixed(2));
                return;
            }
            else {
                var amtPayable = (parseFloat(pendingBalAmt) - parseFloat(discountEntered)).toFixed(2);

                $('#MainContent_tabContainerBilling_tabPnlCreateBill_lblDicForBalAmt').text(parseFloat(discountEntered).toFixed(2));
                $('#MainContent_tabContainerBilling_tabPnlCreateBill_hdnDicForBalAmt').val(parseFloat(discountEntered).toFixed(2));

                $('#MainContent_tabContainerBilling_tabPnlCreateBill_lblBalance').text(amtPayable);
                $('#MainContent_tabContainerBilling_tabPnlCreateBill_hdnBalance').val(amtPayable);

                $('#MainContent_tabContainerBilling_tabPnlCreateBill_txtBalancePayable').val('0.00');
                $('#MainContent_tabContainerBilling_tabPnlCreateBill_lblLeftBal').text(amtPayable);
            }
            BalancePaidChangedAmountOwedToHospAndPat();
        }
        function onCancelBillSubmit(button) {
            var paidAmt = $('#lblCancelAmtPaid').text();
            var refundAmt = $('#txtCancelRefundAmt').val();
            if (parseFloat(paidAmt) < parseFloat(refundAmt)) {
                alert('Refund amount cannot be more than paid amount');
                return false;
            }
            else {
                return true;
            }
        }

    </script>

    <%-- <style type="text/css">
body
{
    width: 100%;
    margin: 0;
    padding: 0;
    font-family: Arial;
}
.modal
{
    position: fixed;
    z-index: 999;
    height: 100%;
    width: 100%;
    top: 0;
    background-color: Black;
    filter: alpha(opacity=60);
    opacity: 0.6;
    -moz-opacity: 0.8;
}
.center
{
    z-index: 500;
    margin: 300px auto;
    padding: 10px;
    width: 60px;
    background-color: White;
    border-radius: 10px;
    filter: alpha(opacity=100);
    opacity: 1;
    -moz-opacity: 1;
}
.center img
{
    height: 50px;
    width: 50px;
}
</style>--%>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <div>

        <%--<asp:UpdateProgress ID="UpdateProgress1" runat="server" AssociatedUpdatePanelID="UpdatePanelFullBilling">
<ProgressTemplate>
    <div class="modal">
        <div class="center">
            <img alt="" src="Images/ajax-loader.gif" />
        </div>
    </div>
</ProgressTemplate>
</asp:UpdateProgress>--%>
                    <asp:UpdatePanel ID="UpdatePanelFullBilling" runat="server" UpdateMode="Conditional" >
                <ContentTemplate>
        <asp:Panel ID="pnlBilling" runat="server">

            <cc1:TabContainer ID="tabContainerBilling" runat="server" CssClass="ajax__myTabforBill" Width="100%"
                Height="750px" ActiveTabIndex="0">
                <cc1:TabPanel ID="tabPnlCreateBill" runat="server">
                    
                    <HeaderTemplate>
                        Create Bill
                    </HeaderTemplate>
                    
                    <ContentTemplate>
                        <table cellpadding="0px" cellspacing="0px" width="100%">
                            <tr>
                                <td style="width: 20%">
                                    <div class="TermsConditionHeader">
                                        <asp:Label ID="lblAddBill" runat="server" Text="Create Bill"></asp:Label>
                                        <asp:Label ID="lblUpdateBill" runat="server" Text="Update Bill" Visible="False"></asp:Label>
                                    </div>

                                </td>
                                <td style="width: 70%" align="left">
                                    <asp:RadioButtonList runat="server" ID="rb_BillType" AutoPostBack="True" RepeatColumns="2" Visible="False" 
                                        OnSelectedIndexChanged="rb_BillType_SelectedIndexChanged"  >
                                        <asp:ListItem Value="2">IP Bill</asp:ListItem>
                                        <asp:ListItem Selected="True" Value="1">OP Bill</asp:ListItem>
                                    </asp:RadioButtonList>

                                </td>

                                <td style="width: 10%">
                                    <asp:Button ID="btnUpdateBill" runat="server" Text="Update" Width="100px" Height="30px" CssClass="DivButton"
                                        ToolTip="Click to Here to Update" UseSubmitBehavior="False" ValidationGroup="validateUpdateBill"
                                        Visible="False" OnClick="btnUpdateBill_Click" OnClientClick="if(UpdateBillPreventMultipleClicks(this)==false) return;" />
                                    <asp:HiddenField ID="hdnDiagIDToUpdate" runat="server" />
                                    <asp:Button ID="btnSaveBill" runat="server" Text="Save & Print" Width="100px" 
                                        ValidationGroup="validateCreateBill" Height="30px" CssClass="DivButton" OnClick="SaveAndPrintBillClick"
                                        ToolTip="Click to Save Bill" UseSubmitBehavior="False" OnClientClick="if(SaveBillPreventMultipleClicks(this)==false) return;" />

                                    <td align="center">
                                        <asp:Button ID="btnBillCancel" runat="server" CssClass="DivButton" Height="30px" OnClick="CancelBillClick" Text="Cancel" ToolTip="Click to Cancel the Bill" Width="100px" />
                                    </td>

                                </td>
                            </tr>
                        </table>
                        <div style="border-bottom: 2px Solid #49B5D2; width: 100%; margin-top: 2px;">
                        </div>
                        <asp:UpdatePanel ID="updatePnlPatientInfo" runat="server" UpdateMode="Conditional">
                            <ContentTemplate>
                                <table cellpadding="0px" cellspacing="0px" width="100%">
                                    <tr>
                                        <td>
                                            <table cellpadding="0px" cellspacing="0px" width="100%" style="margin-top: 2px">
                                                <tr>
                                                    <td>
                                                        <div>
                                                            <asp:Label ID="Label1" runat="server" Style="margin-left: 10px;" Text="Search Criteria" Font-Size="Small" />

                                                        </div>
                                                    </td>
                                                    <td class="style1">
                                                        <asp:Label ID="Label2" runat="server" Text="Patient" Font-Size="Small"></asp:Label>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td style="width: 160px">
                                                        <asp:DropDownList ID="drpSearchCriteria" runat="server" Style="margin-left: 10px" Width="130px" onchange="SearchCriteriaChange()">
                                                            <asp:ListItem Value="1">Patient Name</asp:ListItem>
                                                            <asp:ListItem Value="2">Mobile No</asp:ListItem>
                                                            <asp:ListItem Value="3">Email ID</asp:ListItem>
                                                            <asp:ListItem Value="4">Registration No</asp:ListItem>
                                                            <asp:ListItem Value="5" Enabled="false" >IP Reg No</asp:ListItem>
                                                        </asp:DropDownList>
                                                    </td>
                                                    <td align="left">
                                                        <asp:TextBox ID="txtPatientBillSearch" runat="server" CssClass="TextboxCurve" Height="20px" Width="260px"
                                                            TabIndex="1" />
                                                        <asp:HiddenField ID="hdnSelectedPatientID" runat="server" />
                                                        <asp:HiddenField ID="hdnSelectedPatientIPID" runat="server" />
                                                        <cc1:AutoCompleteExtender ID="autoCmpEtndrPatientForbill" runat="server" TargetControlID="txtPatientBillSearch"
                                                            ServiceMethod="GetPatientsOnSearchCriteria" ServicePath="AutoCompleteSearch.asmx"
                                                            CompletionListCssClass="completionList" CompletionListItemCssClass="listItem"
                                                            CompletionListHighlightedItemCssClass="itemHighlighted" MinimumPrefixLength="1" EnableCaching="False"
                                                            OnClientPopulating="autoCompletePatientForbill_OnClientPopulating" UseContextKey="True" DelimiterCharacters="" Enabled="True"
                                                            ShowOnlyCurrentWordInCompletionListItem="True" OnClientItemSelected="onPatientSelected">
                                                        </cc1:AutoCompleteExtender>
                                                    </td>
                                                    <td>
                                                        <asp:ImageButton ID="btnSearchPatientRec" runat="server" ImageUrl="~/Images/search1.png" Width="0px"
                                                            Height="0px" ToolTip="Click to Search Patient" CssClass="imgButton" OnClick="btnSearchPatientRec_Click" />
                                                    </td>
                                   
                                                </tr>
                                                <tr id="tr5d">
                                                    <td class="style1">
                                                         <asp:Label ID="Label_GovtOPD" runat="server" Style="margin-left: 10px;" Text="Govt OPD No" Font-Size="Small" />
                                                    </td>
                                                    <td align="left">
                                                        <asp:TextBox ID="txtgovtopd" runat="server" CssClass="TextboxCurve" Height="20px" Width="260px" TabIndex="1" MaxLength="20" />
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td style="vertical-align: top;" align="right">
                                            <table cellpadding="0px" cellspacing="0px" style="vertical-align: top;">
                                                <tr>
                                                    <td style="vertical-align: middle; width: 280px">
                                                        <asp:Label ID="lblPatientFullName" runat="server" Style="vertical-align: middle" Font-Bold="True" Font-Size="Small" />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td style="vertical-align: middle">
                                                        <asp:Label ID="lblPatientGender" runat="server" Style="vertical-align: middle" Font-Bold="False" Font-Size="Small" />
                                                        <asp:Label ID="lblPatientAge" runat="server" Style="vertical-align: middle" Font-Bold="False" Font-Size="Small" />
                                                        <asp:Label ID="lblPtientID" runat="server" Style="vertical-align: middle" Font-Bold="False" Font-Size="Small" />

                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td style="vertical-align: middle">
                                                        <asp:Label ID="lblPatientMobileNo" runat="server" Style="vertical-align: middle" Font-Bold="False" Font-Size="Small"></asp:Label>
                                                        <asp:Label ID="lblPatientIPCaseNum" runat="server" Style="vertical-align: middle" Font-Bold="False" Font-Size="Small"/>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td style="vertical-align: middle">
                                                        <asp:Label ID="lblPatientMailID" runat="server" Style="vertical-align: middle" Font-Bold="False" Font-Size="Small"></asp:Label>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                </table>

                            </ContentTemplate>
                            <Triggers>
                                <asp:AsyncPostBackTrigger ControlID="btnSearchPatientRec" EventName="click" />
                            </Triggers>
                        </asp:UpdatePanel>
                        <div style="border-top: 2px Solid #49B5D2; width: 100%; margin-top: 2px; margin-bottom: 15px;">
                        </div>
                        <table cellpadding="0px" cellspacing="0px" style="margin-top: 2px; width: 100%">
                            <tr>
                                <td style="width: 100px">
                                    <asp:Label ID="Lbl_Referral" runat="server" Text="Referred By:" Style="margin-left: 10px;" ForeColor="#666666"
                                        Font-Size="Small" Font-Bold="True" />
                                </td>
                                <td style="width: 210px;">
                                    <asp:TextBox ID="txtBillRefDocName" runat="server" CssClass="TextboxCurve" Height="20px" Width="200px"
                                        TabIndex="2" />
                                    <asp:HiddenField ID="hdnRefDocID" runat="server" />
                                    <cc1:AutoCompleteExtender ID="aceRefDoc" runat="server" TargetControlID="txtBillRefDocName"
                                        ServiceMethod="GetDoctorsForAutoCompleteExtender" ServicePath="AutoCompleteSearch.asmx"
                                        CompletionListCssClass="completionList" CompletionListItemCssClass="listItem"
                                        CompletionListHighlightedItemCssClass="itemHighlighted" MinimumPrefixLength="1" EnableCaching="False"
                                        UseContextKey="True" DelimiterCharacters="" Enabled="True"
                                        ShowOnlyCurrentWordInCompletionListItem="True" OnClientItemSelected="onDoctorSelected">
                                    </cc1:AutoCompleteExtender>
                                </td>
                                <td align="right">
                                    <asp:Label ID="Label8" runat="server" Text="Customer Category" Style="color: #666666; font-size: Small; font-weight: bold; margin-left: 10px; padding-right: 15px;" />
                                </td>
                                <td align="left">
                                    <asp:DropDownList ID="ddlCustomerCategory" runat="server" Style="width: 130px"
                                        TabIndex="3" onchange="if(OnCustomerCategoryChange()==false) return;" AutoPostBack="True" OnSelectedIndexChanged="OnCorporateSelection">
                                    </asp:DropDownList>
                                </td>
                                <td align="left">
                                    <asp:TextBox ID="txtWalkinCorporate" runat="server" CssClass="TextboxCurve" Height="20px" Width="200px" />
                                    <asp:DropDownList ID="ddlCorporates" runat="server" Width="180px" Style="display: none;" AutoPostBack="True" OnSelectedIndexChanged="OnCorporateSelection" />
                                </td>
                            </tr>
                        </table>

                        <table cellpadding="0px" cellspacing="0px">
                            <tr>
                                <td>
                                    <asp:Label ID="Label19" runat="server" Text="Bill Details" Style="margin-left: 10px;" ForeColor="#666666"
                                        Font-Size="Small" Font-Bold="True"></asp:Label>
                                </td>
                                <td align="right">

                                    <asp:ImageButton ID="imgBtnAddNewBillItem" runat="server" ImageUrl="~/Images/add-icon.png"
                                        Height="20px" Width="30px" BorderWidth="0px" ToolTip="Click To Add Item" OnClientClick="return PreviousPadrticularDdlEmpty(this);"
                                        OnClick="AddBillItem" />
                                    <asp:ImageButton ID="imgBtnDeleteBillItem" runat="server" Height="20px" Width="30px" BorderWidth="0px" ToolTip="Click To Delete Item"
                                        ImageUrl="~/Images/delete-icon.png" OnClientClick="return Confirm_DeleteTest();" OnClick="DeleteBillItem" />
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2">

                                    <asp:Panel runat="server" Width="825px" ID="pnlAddBillItemsGrid" ScrollBars="Auto" Height="250px">
                                        <asp:UpdatePanel ID="updaePnlBillsGrid" runat="server" UpdateMode="Conditional">
                                            <ContentTemplate>
                                                <asp:GridView ID="grdBillDetails" runat="server" AutoGenerateColumns="False"
                                                    CssClass="GridViewStyle3" GridLines="None" Style="margin-left: 10px" Width="795px">
                                                    <AlternatingRowStyle BackColor="White" ForeColor="#284775" Height="25px" />
                                                    <Columns>
                                                        <asp:TemplateField>
                                                            <HeaderTemplate>
                                                                <asp:CheckBox ID="chkSelectAll" runat="server" onclick="checkAll(this)" Text="All" />
                                                            </HeaderTemplate>
                                                            <ItemTemplate>
                                                                <asp:CheckBox ID="chkIndividualItemSelect" runat="server" Onclick="Check_Click(this)" />
                                                            </ItemTemplate>
                                                            <HeaderStyle Height="2px" Width="50px" HorizontalAlign="Left" />
                                                            <ItemStyle Width="50px" />
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="#">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblbillslno" runat="server" Width="50px" Text="<%#Container.DataItemIndex+1  %>" />
                                                            </ItemTemplate>
                                                            <HeaderStyle Height="2px" Width="60px" HorizontalAlign="Left" />
                                                            <ItemStyle Width="60px" />
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Service">
                                                            <ItemTemplate>
                                                                <asp:DropDownList ID="ddlService" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ServiceChangeClick"
                                                                    Width="180px">
                                                                </asp:DropDownList>
                                                                <asp:HiddenField ID="hdnFieldForEachServices" runat="server" />
                                                            </ItemTemplate>
                                                            <HeaderStyle Height="2px" Width="200px" HorizontalAlign="Left" />
                                                            <ItemStyle Width="180px" />
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Particulars">
                                                            <ItemTemplate>
                                                                <asp:DropDownList ID="ddlParticulars" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ParticularChangeClick"
                                                                    Width="260px">
                                                                </asp:DropDownList>
                                                            </ItemTemplate>
                                                            <HeaderStyle Height="2px" Width="330px" HorizontalAlign="Left" />
                                                            <ItemStyle Width="260px" />
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Rate">
                                                            <ItemTemplate>
                                                                <asp:TextBox ID="txtRate" runat="server" onchange="BillItemRateChanged()" Style="text-align: right"
                                                                    MaxLength="10" Width="120px"></asp:TextBox>
                                                                <cc1:FilteredTextBoxExtender ID="flt_BillRate" runat="server" TargetControlID="txtRate" ValidChars="1234567890."
                                                                    FilterMode="ValidChars" Enabled="True">
                                                                </cc1:FilteredTextBoxExtender>
                                                            </ItemTemplate>
                                                            <HeaderStyle Height="2px" Width="100px" HorizontalAlign="Left" />
                                                            <ItemStyle Width="120px" HorizontalAlign="Right" />
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Qty">
                                                            <ItemTemplate>
                                                                <asp:TextBox ID="txtQty" runat="server" Style="text-align: right"
                                                                    MaxLength="10" Width="30px" onchange="BillItemRateChanged()" />
                                                                <cc1:FilteredTextBoxExtender ID="flt_Qty" runat="server" TargetControlID="txtQty" ValidChars="1234567890."
                                                                    Enabled="True"  FilterMode="ValidChars">
                                                                </cc1:FilteredTextBoxExtender>
                                                            </ItemTemplate>
                                                            <HeaderStyle Height="2px" Width="100px" HorizontalAlign="Left" />
                                                            <ItemStyle Width="30px" HorizontalAlign="Right" />
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Total">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblTotalOfEachItem" runat="server" Width="120px" CssClass="lblTotalCss" />
                                                                <asp:HiddenField ID="hdnTotalOfEachItem" runat="server" />

                                                            </ItemTemplate>
                                                            <HeaderStyle Height="2px" Width="100px" HorizontalAlign="Left" />

                                                            <ItemStyle Width="120px" HorizontalAlign="Right" />
                                                        </asp:TemplateField>
                                                    </Columns>
                                                    <FooterStyle CssClass="footerStyle3" Font-Bold="True" ForeColor="White" />
                                                    <HeaderStyle CssClass="HeaderStyle3" Font-Bold="True" ForeColor="White" Height="20px" />
                                                    <RowStyle BackColor="#F7F6F3" CssClass="RowStyle3" ForeColor="#333333" Height="25px" />
                                                    <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" Height="25px" />
                                                </asp:GridView>
                                            </ContentTemplate>
                                            <Triggers>
                                                <asp:AsyncPostBackTrigger ControlID="imgBtnAddNewBillItem" EventName="click" />
                                                <asp:AsyncPostBackTrigger ControlID="imgBtnDeleteBillItem" EventName="click" />
                                                <asp:AsyncPostBackTrigger ControlID="ddlCustomerCategory" EventName="SelectedIndexChanged" />
                                                <asp:AsyncPostBackTrigger ControlID="ddlCorporates" EventName="SelectedIndexChanged" />
                                            </Triggers>
                                        </asp:UpdatePanel>
                                    </asp:Panel>
                                </td>
                            </tr>
                        </table>
                        <div style="border-bottom: 2px Solid #49B5D2; width: 100%; margin-top: 4px;" ></div>
                        <div class="Outer">
                        <asp:Panel ID="pnl_BillDetails" runat="server">
                             <div class="InnerLeft" style="float:left;width:32%">
                                  <asp:Panel ID="pnl_Advnaceamt" runat="server">
                                      <asp:UpdatePanel ID="update_AdvanceAmout" runat="server">
                                          <ContentTemplate>
                                              <table>
                                            


                                        <tr>
                                           <%-- <td>
                                                <asp:CheckBox ID="chk_DOA" runat="server" Visible="false"/>
                                            </td>--%>
                                            <td>
                                                <asp:Label ID="lbl_IPDOA" runat="server" Text="DOA :" Font-Size="Small" Font-Bold="true" Visible="false" />
                                            </td>
                                            <td>
                                                <%--<asp:Label ID="lbl_IPDateofAdmission" runat="server"  Font-Size="Small" Font-Bold="true" Visible="false" />--%>
                                                <asp:TextBox ID="txt_IPDOA" runat="server" CssClass="textbox1" Visible="false" Enabled="false" Width="130px" />
                                            </td>
                                        </tr>
                                        <tr>
                                          <%--  <td>
                                                <asp:CheckBox ID="chk_DOD" runat="server" Visible="false" />
                                            </td>--%>
                                            <td>
                                                <asp:Label ID="lbl_DOD" runat="server" Text="DOD :" Font-Size="Small" Font-Bold="true" Visible="false" />
                                            </td>
                                            <td>
                                                <%--<asp:Label ID="lbl_IPDateofDischarge" runat="server"  Font-Size="Small" Font-Bold="true" Visible="false" />--%>
                                                <asp:TextBox ID="txt_IPDOD" runat="server" CssClass="textbox1" Visible="false" Enabled="false" Width="130px" />
                                            </td>
                                        </tr>
                                        <tr>
                                           <%-- <td>
                                                <asp:CheckBox ID="chk_AdvanceAmt" runat="server" Visible="false" />
                                            </td>--%>
                                            <td>
                                                <asp:Label ID="lbl_AdvanceAmt" runat="server" Text="Advance Amount :" Font-Size="Small" Font-Bold="true" Visible="false" />
                                            </td>
                                            <td>
                                                <%--<asp:Label ID="lbl_IPAdvAmt" runat="server"  Font-Size="Small" Font-Bold="true" Visible="false" />--%>
                                                <asp:TextBox ID="TextBox_AdvnaceAmt" runat="server" CssClass="textbox1" Visible="false"  Enabled="false" Width="130px" />
                                            </td>
                                        </tr>
                                                  <tr>
                                            <td>
                                                <asp:Label ID="lbl_OwedToHosp" runat="server" Text="Amount Owed To Hospital :" Font-Size="Small" Font-Bold="true" Visible="false" />
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txt_OwedToHosp" runat="server" CssClass="textbox1" Visible="false"  Enabled="false" Width="130px" />
                                            </td>
                                        </tr>
                                                  <tr>
                                            <td>
                                                <asp:Label ID="lbl_OwedToPat" runat="server" Text="Amount Owed To Patient :" Font-Size="Small" Font-Bold="true" Visible="false" />
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txt_OwedToPat" runat="server" CssClass="textbox1" Visible="false"  Enabled="false" Width="130px" />
                                            </td>
                                        </tr>
    </table>
                                              </ContentTemplate>
                                          </asp:UpdatePanel>
                                      </asp:Panel>
                                 </div>
                             <div class="InnerRight" style="float:right;width:68%;">
                             <asp:Panel ID="finalBillPanel" runat="server">
                            <asp:UpdatePanel runat="server" ID="updatePnl_BillDetails" UpdateMode="Conditional">
                                <ContentTemplate>
                                    <table width="100%">
                                        <tr>
                                            <%--<td style="width:50%">



                                                </td>--%>
                                            <td style="width:50%" align="right">
                                                <table>
                                                    <tr>
                                            <td align="right"></td>
                                            <td></td>
                                            <td align="right" colspan="4">
                                                <asp:Label ID="Label9" runat="server" Text="Sub Total:" ForeColor="#666666" Font-Size="Small" Font-Bold="True" />
                                            </td>
                                            <td align="right">
                                                <asp:Label ID="lblBillSubTotal" runat="server" Width="120px" />
                                                <asp:HiddenField ID="hdnBillSubTotal" runat="server" />
                                            </td>
                                            <td>

                                                <asp:Image ID="Image_SubTotal" runat="server" ImageUrl="~/Images/rupee.png" AlternateText="Rs" />
                                            </td>
                                        </tr>
                                                    
                                                    <tr>
                                            <td align="right" style="width: 100%" colspan="4">
                                                <asp:Label ID="Label12" runat="server" Text="Tax:" ForeColor="#666666" Font-Size="Small" Font-Bold="True" />
                                            </td>
                                            <td align="right">
                                                <asp:TextBox ID="txtBillTax" runat="server" Width="40px" Text="0" CssClass="TextboxCurve" MaxLength="6"
                                                    onchange="calculateDiscountAndTax()"  />
                                                <cc1:FilteredTextBoxExtender ID="fltTax" runat="server" TargetControlID="txtBillTax" ValidChars="1234567890."
                                                    Enabled="True">
                                                </cc1:FilteredTextBoxExtender>
                                            </td>
                                            <td align="center">
                                                <asp:Label ID="lblImagePercentageTax" runat="server" Text="%"></asp:Label>
                                            </td>
                                            <td align="right" style="padding-top: 5px">
                                                <asp:Label ID="lblBillTaxPercentage" runat="server" Text="0.00"></asp:Label>
                                                <asp:HiddenField ID="hdnBillTaxPercentage" runat="server" />

                                            </td>
                                            <td>
                                                <asp:Image ID="Image3" runat="server" ImageUrl="~/Images/rupee.png" AlternateText="Rs" />
                                            </td>
                                        </tr>
   <tr>
                                            <td align="right" style="width: 100%" colspan="4">
                                                <asp:Label ID="Label3" runat="server" Text="Discount:" ForeColor="#666666" Font-Size="Small" Font-Bold="True" />
                                            </td>
                                            <td align="right">
                                                <asp:TextBox ID="txtDiscount" runat="server" Width="40px" CssClass="TextboxCurve" Text="0" MaxLength="7"
                                                    Height="20px" onchange="calculateDiscountAndTax()" />
                                                <cc1:FilteredTextBoxExtender ID="fltDiscount" runat="server" TargetControlID="txtDiscount" ValidChars="1234567890."
                                                    Enabled="True">
                                                </cc1:FilteredTextBoxExtender>
                                            </td>
                                            <td align="center">
                                                <asp:DropDownList ID="ddlDiscountType" runat="server" Width="75px" onchange="calculateDiscountAndTax()">
                                                    <asp:ListItem>currency</asp:ListItem>
                                                    <asp:ListItem>%</asp:ListItem>
                                                </asp:DropDownList>
                                            </td>
                                            <td align="right" style="padding-top: 5px">
                                                <asp:Label ID="lblDiscount" runat="server" Text="0.00"></asp:Label>
                                                <asp:HiddenField ID="hdnDiscount" runat="server" />
                                                <asp:HiddenField ID="hdnActiveDiscount" runat="server" />

                                            </td>
                                            <td>
                                                <asp:Image ID="Image2" runat="server" ImageUrl="~/Images/rupee.png" AlternateText="Rs" />
                                            </td>
                                        </tr>
                                                    
                                                </table>
                                            </td>
                                        </tr>
                                                                           
                                    </table>
                                    <table width="100%">
                                          <tr>
                                            <td colspan="8" style="width: 100%;" align="right">
                                                <div style="border-bottom: 2px Solid #49B5D2; width: 400px;" >
                                                </div>
                                            </td>
                                        </tr>
                                        
                                        <tr>
                                            <td align="right" style="width: 100%" colspan="6">
                                                <asp:Label ID="Label13" runat="server" Text="Amount Payable:" ForeColor="#666666" Font-Size="Small" Font-Bold="True"></asp:Label>
                                            </td>
                                            <td align="right">
                                                <asp:Label ID="lblBillAmountPayable" runat="server"></asp:Label>
                                                <asp:HiddenField ID="hdnBillAmountPayable" runat="server" />
                                            </td>
                                            <td>
                                                <asp:Image ID="Image4" runat="server" ImageUrl="~/Images/rupee.png" AlternateText="Rs" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="right" style="width: 100%" colspan="6">
                                                <asp:Label ID="Label14" runat="server" Text="Amount Paid:" ForeColor="#666666" Font-Size="Small" Font-Bold="True" />
                                            </td>
                                            <td align="center">
                                                <asp:TextBox ID="txtBillAmountPaid" runat="server" CssClass="TextboxCurve"  style="height:20px;width: 90px;text-align: right;" onchange="onTxtBillAmountPaidChanged()" />
                                                <cc1:FilteredTextBoxExtender ID="fltBillAmountPaid" runat="server" TargetControlID="txtBillAmountPaid"
                                                    ValidChars="1234567890." Enabled="True">
                                                </cc1:FilteredTextBoxExtender>
                                            </td>
                                            <td>
                                                <asp:Image ID="Image5" runat="server" ImageUrl="~/Images/rupee.png" AlternateText="Rs" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="6"></td>
                                            <td colspan="3"></td>
                                        </tr>
                                        <tr>
                                            <td align="right" style="width: 100%" colspan="6">
                                                <asp:Label ID="Label_StaticPendingBalance" runat="server" Text="Pending Balance:" ForeColor="#666666"
                                                    Font-Size="Small" Font-Bold="True" Visible="False" />
                                            </td>
                                            <td align="right">
                                                <asp:Label ID="lblPendingBalance" runat="server" Visible="False" />

                                            </td>
                                            <td>
                                                <asp:Image ID="imgPendingBalance" runat="server" ImageUrl="~/Images/rupee.png" AlternateText="Rs" Visible="False" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="right" style="width: 100%" colspan="4">
                                                <asp:Label ID="lblStaticDicForBalAmt" runat="server" Text="Discount:" ForeColor="#666666"
                                                    Font-Size="Small" Font-Bold="True" Visible="false" />
                                            </td>
                                            <td align="right">
                                                <asp:TextBox ID="txtDicForBalAmt" runat="server" Width="40px" CssClass="TextboxCurve" Text="0" MaxLength="7"
                                                    Height="20px" onchange="onTextDisxountForBalAmtChange()" Visible="false" />
                                                <cc1:FilteredTextBoxExtender ID="FilteredTextBoxExtender2" runat="server" TargetControlID="txtDicForBalAmt" ValidChars="1234567890."
                                                    Enabled="True">
                                                </cc1:FilteredTextBoxExtender>
                                            </td>
                                            <td align="center">
                                                <asp:DropDownList ID="ddlPaymentModeDicForBalAmt" runat="server" Width="75px" Visible="false">
                                                    <asp:ListItem>currency</asp:ListItem>
                                                    <%--<asp:ListItem>%</asp:ListItem>--%>
                                                </asp:DropDownList>
                                            </td>
                                            <td align="right" style="padding-top: 5px">
                                                <asp:Label ID="lblDicForBalAmt" runat="server" Text="0.00" Visible="false"></asp:Label>
                                                <asp:HiddenField ID="hdnDicForBalAmt" Value="0.00" runat="server" />
                                                <br />

                                            </td>
                                            <td>
                                                <asp:Image ID="imgRSDicForBalAmt" runat="server" ImageUrl="~/Images/rupee.png" AlternateText="Rs" Visible="false" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="right" style="width: 100%">

                                                <asp:Label ID="Label18" runat="server" Text="Payment Mode:" ForeColor="#666666" Font-Size="Small" Width="100px"
                                                    Font-Bold="True" Style="margin-left: 10px;"></asp:Label>
                                            </td>
                                            <td>
                                                <div class="styled-select">
                                                    <asp:DropDownList ID="ddlPaymentMode" runat="server" CssClass="drp"
                                                        Width="100px" onchange="ReferenceNoVisible()">
                                                        <asp:ListItem Selected="True">Cash</asp:ListItem>
                                                        <asp:ListItem>Credit Card</asp:ListItem>
                                                        <asp:ListItem>Cheque</asp:ListItem>
                                                        <asp:ListItem>NEFT/RTGS</asp:ListItem>
                                                         <asp:ListItem>Debit Card</asp:ListItem>

                                                    </asp:DropDownList>
                                                </div>
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txtBillPaymentModeRefNo" runat="server" CssClass="TextboxCurve" autocommit="off" Style="display: none" Height="20px"
                                                    Width="100px" onchange="VerifyRefNo()" ></asp:TextBox>
                                            </td>
                                            <td></td>
                                            <td colspan="2" align="right">
                                                <asp:Label ID="lblBalanceStatic" runat="server" Text="Balance:" ForeColor="#666666" Font-Size="Small"
                                                    Font-Bold="True"></asp:Label>
                                            </td>
                                            <td align="right">
                                                <asp:Label ID="lblBalance" runat="server" />
                                                <asp:HiddenField ID="hdnBalance" runat="server" />
                                            </td>
                                            <td>
                                                <asp:Image ID="Image6" runat="server" ImageUrl="~/Images/rupee.png" AlternateText="Rs" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="right" style="width: 100%" colspan="6">
                                                <asp:Label ID="lblBalPayStatic" runat="server" Text="Balance Paid:" ForeColor="#666666" Font-Size="Small"
                                                    Visible="False" Font-Bold="True"></asp:Label>
                                            </td>
                                            <td align="center">
                                                <asp:Panel runat="server" ID="pnlUpdateText">
                                                    <asp:TextBox ID="txtBalancePayable" runat="server" CssClass="TextboxCurve"
                                                        Width="94%" Visible="False" Height="20px" Style="text-align: right" onchange="OnBalancePaidTextChange()" />
                                                    <cc1:FilteredTextBoxExtender ID="FilteredTextBoxExtender1" runat="server" TargetControlID="txtBalancePayable"
                                                        ValidChars="1234567890." Enabled="True">
                                                    </cc1:FilteredTextBoxExtender>
                                                </asp:Panel>
                                            </td>
                                            <td>
                                                <asp:Image ID="Img_balPaySymbol" runat="server" ImageUrl="~/Images/rupee.png" AlternateText="Rs" Visible="False" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="4"></td>
                                            <td colspan="4" align="right">
                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" ControlToValidate="txtBalancePayable"
                                                    ForeColor="Red" ValidationGroup="validateUpdateBill" ErrorMessage="Enter Balance Pay" Width="130px" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="right" style="width: 100%" colspan="6">
                                                <asp:Label ID="lblPaidBalStatic" runat="server" Text="Balance:" ForeColor="#666666" Font-Size="Small" Visible="False"
                                                    Font-Bold="True"></asp:Label>
                                            </td>
                                            <td align="right">
                                                <asp:Label ID="lblLeftBal" Visible="False" runat="server"></asp:Label>
                                            </td>
                                            <td>
                                                <asp:Image ID="Image_Leftbal" Visible="False" runat="server" ImageUrl="~/Images/rupee.png" AlternateText="Rs" />
                                            </td>
                                        </tr>
                                    </table>
                                </ContentTemplate>
                                <Triggers>
                                    <asp:AsyncPostBackTrigger ControlID="imgBtnAddNewBillItem" EventName="click" />
                                    <asp:AsyncPostBackTrigger ControlID="imgBtnDeleteBillItem" EventName="click" />
                                    <asp:AsyncPostBackTrigger ControlID="ddlCustomerCategory" EventName="SelectedIndexChanged" />
                                    <asp:AsyncPostBackTrigger ControlID="ddlCorporates" EventName="SelectedIndexChanged" />
                                </Triggers>
                            </asp:UpdatePanel>
                                 </asp:Panel>
                                 </div>
                        </asp:Panel>
                         </div>
                         
                       <asp:Button ID="btn_ShowPopup" runat="server" Style="display: none" />
                        <cc1:ModalPopupExtender ID="MPEBillDiscount" runat="server" PopupControlID="Pnl_BillDiscount"
                            BackgroundCssClass="modalBackgroundLogin" TargetControlID="btn_ShowPopup" CancelControlID="Img_btn_CloseAddApp"
                            DynamicServicePath="" Enabled="True">
                        </cc1:ModalPopupExtender>
                        <asp:Panel ID="Pnl_BillDiscount" runat="server" Style="margin: 0 auto; background-color: White; display: none; padding: 3px;"
                            DefaultButton="btn_DiscountBill" Width="420px" CssClass="PartnerLogin">
                            <table cellpadding="0" cellspacing="0" class="tablestyle" style="height: auto; width: 400px; margin-left: 1em">
                                <tr>
                                    <td valign="top" style="background-color: #FFFFFF;" rowspan="2">
                                        <div style="text-align: right">
                                            <asp:ImageButton ID="Img_btn_CloseAddApp" runat="server" Height="25px" Width="25px" ImageUrl="~/Images/CloseIcon.png" />
                                        </div>
                                        <div id="Div2" class="modalbackgroundAppointment">
                                            Discount Bill 
                                        </div>
                                        <div style="border-bottom: 2px Solid #49B5D2; width: 100%">
                                        </div>
                                        <table class="tablestyle" cellpadding="3px" cellspacing="3px" style="width: 400px;">
                                            <tr>
                                                <td style="width: 300px">
                                                                    <asp:Label ID="lbl_Authoriser" runat="server" CssClass="label1" Text="Name of Authoriser :" Width="300px" />
                                                                    <asp:TextBox ID="txt_Authoriser" runat="server" CssClass="multiLineTextbox" Style="height:23px;width:200px;" />
                                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ValidationGroup="validateBillDiscount"
                                                                        ControlToValidate="txt_Authoriser" Text="Enter Authoriser Name" ForeColor="Red" />
                                            </tr>
                                            <tr>
                                                                <td style="width: 300px">
                                                                    <asp:Label ID="Label20" runat="server" CssClass="label1" Text="Reason For Bill Discount:" Width="180px" />
                                                                    <asp:TextBox ID="txt_DiscountBill" runat="server" CssClass="multiLineTextbox" TextMode="MultiLine"
                                                                        Width="370px" Height="60px" />
                                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ValidationGroup="validateBillDiscount"
                                                                        ControlToValidate="txt_DiscountBill" Text="Enter bill Discount reason" ForeColor="Red" />
                                                                    <asp:HiddenField ID="hdnbasedonclick" runat="server" />
                                                                    <div style="text-align: center">
                                                                        <asp:Button ID="btn_DiscountBill" runat="server" ValidationGroup="validateBillDiscount" CssClass="BillDivButton"
                                                                            Text="Submit" Width="70px" Height="22px" UseSubmitBehavior="False" OnClick="btn_DiscountBill_Click" OnClientClick="DisableSubmitbutton();" />
                                                                    </div>
                                                                </td>
                                                            </tr>
                                                        </table>
                                    </td>
                                </tr>
                            </table>
                        </asp:Panel>
  
                    </ContentTemplate>


                </cc1:TabPanel>
                <cc1:TabPanel ID="tabPnlListBills" runat="server">
                    <HeaderTemplate>
                        Modify/Cancel/List Bills
                    
                    
                    </HeaderTemplate>


                    <ContentTemplate>
                        <table width="100%">
                            <tr>
                                <td align="left" style="width: 100%">
                                    <div class="TermsConditionHeader">
                                        Modify/Cancel/List Bills
                                    </div>
                                </td>
                                <td align="center"></td>
                                <td align="center">
                                    <asp:Button ID="btnSearchBills" runat="server" Text="Search" Width="100px" Height="30px" CssClass="DivButton"
                                        ToolTip="Click Here to Search" OnClick="SearchBillsClick" />


                                    <td align="center"></td>
                                    <td>
                                        <asp:Button ID="btnPrintListOfBills" runat="server" Text="Print" CssClass="DivButton" Style="height: 30px; width: 100px; margin-right: 20px;" ToolTip="Click here to Print Bills" OnClick="btnPrintListOfBills_Click" />


                                    </td>
                                </td>
                            </tr>
                        </table>
                        <div style="border-bottom: 2px Solid #49B5D2; width: 100%; margin-top: 2px;">
                        </div>
                        <table width="100%" style="margin-top: 2px">
                            <tr>
                                <td>
                                    <asp:Label ID="lblListBillSearchCriteria" runat="server" Style="margin-left: 10px;" Text="Search Criteria" Font-Size="Small" />


                                </td>

                                <td>
                                    <asp:Label ID="lblBillListBillNum" runat="server" Text="Bill Number" Font-Size="Small" />
                                    <asp:Label ID="Labelregno" runat="server" Text="Registration No" Font-Size="Small" style="display:none" />
                                     <asp:Label ID="Labelmobno" runat="server" Text="Mobile Number" Font-Size="Small" style="display:none" />

                                </td>

                                <td>
                                    <asp:Label ID="lblBillListPatintName" runat="server" Text="Patient Name" Font-Size="Small" />
                                    

                                </td>
                                <td>
                                    <asp:Label ID="lblBillListFrom" runat="server" Text="From" Font-Size="Small" />


                                </td>
                                <td>
                                    <asp:Label ID="lblBillListTo" runat="server" Text="To" Font-Size="Small" />


                                </td>
                              
                                <td>
                                    <asp:Label ID="lblBillListStatus" runat="server" Text="Status" Font-Size="Small" />


                                </td>
                            </tr>
                            <tr>
                                <td style="width: 120px;">
                                    <asp:DropDownList ID="ddlBillListSearchCriteria" runat="server" Style="margin-left: 10px"
                                        onchange="onChangeBillListSearchCriteria()" Width="107px" Height="25px">
                                        <asp:ListItem>Bill Date</asp:ListItem>
                                        <asp:ListItem>Patient Name</asp:ListItem>
                                        <asp:ListItem>Bill Number</asp:ListItem>
                                        <asp:ListItem>Mobile Number</asp:ListItem>
                                        <asp:ListItem>Registration No</asp:ListItem>
                                    </asp:DropDownList>


                                </td>
                                <td style="width: 105px;">
                                    <asp:TextBox ID="txtBillListBillNum" runat="server" Width="90px" CssClass="textbox1" />

                                     <asp:TextBox ID="TextBox_mobileno" runat="server" Height="18px" Width="170px" CssClass="textbox1"  style="display:none"/>
                                    <asp:HiddenField ID="HiddenField_mobileno" runat="server" />
                                    <cc1:AutoCompleteExtender ID="ACE_mobileno" runat="server" TargetControlID="TextBox_mobileno"
                                        ServiceMethod="GetPatientsOnSearchCriteria" ServicePath="AutoCompleteSearch.asmx"
                                        CompletionListCssClass="completionList" CompletionListItemCssClass="listItem"
                                        CompletionListHighlightedItemCssClass="itemHighlighted" MinimumPrefixLength="1" EnableCaching="False"
                                        UseContextKey="True" ContextKey="MobileNo" DelimiterCharacters="" Enabled="True"
                                        ShowOnlyCurrentWordInCompletionListItem="True" OnClientItemSelected="onMobilenoSelectedInListBills">
                                    </cc1:AutoCompleteExtender>

                                         <asp:TextBox ID="TextBox_regno" runat="server" Height="18px" Width="170px" CssClass="textbox1"  style="display:none"/>
                                    <asp:HiddenField ID="HiddenField_regno" runat="server" />
                                    <cc1:AutoCompleteExtender ID="ACE_regno" runat="server" TargetControlID="TextBox_regno"
                                        ServiceMethod="GetPatientsOnSearchCriteria" ServicePath="AutoCompleteSearch.asmx"
                                        CompletionListCssClass="completionList" CompletionListItemCssClass="listItem"
                                        CompletionListHighlightedItemCssClass="itemHighlighted" MinimumPrefixLength="1" EnableCaching="False"
                                        UseContextKey="True" ContextKey="PatientRegNo" DelimiterCharacters="" Enabled="True"
                                        ShowOnlyCurrentWordInCompletionListItem="True" OnClientItemSelected="onRegnoSelectedInListBills">
                                    </cc1:AutoCompleteExtender>

                                </td>

                                <td style="width: 175px;">
                                    <asp:TextBox ID="txtBillListPatintName" runat="server" Height="18px" Width="170px" CssClass="textbox1" />
                                    <asp:HiddenField ID="hdnBillSearchPatientID" runat="server" />
                                    <cc1:AutoCompleteExtender ID="aceBillsSearch" runat="server" TargetControlID="txtBillListPatintName"
                                        ServiceMethod="GetPatientsOnSearchCriteria" ServicePath="AutoCompleteSearch.asmx"
                                        CompletionListCssClass="completionList" CompletionListItemCssClass="listItem"
                                        CompletionListHighlightedItemCssClass="itemHighlighted" MinimumPrefixLength="1" EnableCaching="False"
                                        UseContextKey="True" ContextKey="PatientName" DelimiterCharacters="" Enabled="True"
                                        ShowOnlyCurrentWordInCompletionListItem="True" OnClientItemSelected="onPatientNameSelectedInListBills">
                                    </cc1:AutoCompleteExtender>

                                     

                                </td>
                                <td style="width: 125px;">
                                    <asp:TextBox ID="txtBillListFromDate" runat="server" Width="100px" autocomplete="off" CssClass="textbox1" />


                                    <cc1:CalendarExtender ID="CalendarExtender_FromDate" runat="server" Format="dd-MMM-yyyy"
                                        PopupPosition="BottomRight" TargetControlID="txtBillListFromDate" Enabled="True">
                                    </cc1:CalendarExtender>


                                </td>
                                <td style="width: 120px;">
                                    <asp:TextBox ID="txtBillListToDate" runat="server" Width="100px" autocomplete="off" CssClass="textbox1" />


                                    <cc1:CalendarExtender ID="CalendarExtender_ToDate" runat="server" Format="dd-MMM-yyyy"
                                        PopupPosition="BottomRight" TargetControlID="txtBillListToDate" Enabled="True">
                                    </cc1:CalendarExtender>


                                </td>
                                
                                <td style="width: 95px;">
                                    <asp:DropDownList ID="ddlBillListStatus" runat="server" Style="margin-left: 0px" Width="85px" Height="25px">
                                        <asp:ListItem Value="0" Selected="True">All</asp:ListItem>
                                        <asp:ListItem Value="1">Pending</asp:ListItem>
                                        <asp:ListItem Value="2">Paid</asp:ListItem>
                                        <asp:ListItem Value="3" Enabled="False">Credits</asp:ListItem>
                                        <asp:ListItem Value="4">Cancel</asp:ListItem>
                                    </asp:DropDownList>


                                </td>

                                
                            </tr>
                        </table>
                        <table cellpadding="0px" cellspacing="0px" width="100%" >
                            <tr>
                                <td align="center">
                                    <asp:Panel ID="pnlListBillsGrid" runat="server" ScrollBars="Auto" Width="850px" Height="482px">
                                        <dx:ASPxGridView ID="grdListOfBills" runat="server" Theme="Aqua" AutoGenerateColumns="False" Width="810px" 
                                            OnPageIndexChanged="grdListOfBills_PageIndexChanged" OnPageSizeChanged="grdListOfBills_PageSizeChanged">
                                            <Columns>
                                                <dx:GridViewDataTextColumn Caption="#" FieldName="SiNo" VisibleIndex="1" ShowInCustomizationForm="True">
                                                    <DataItemTemplate>
                                                        <dx:ASPxLabel ID="lblSiNo" runat="server" Text="<%#Container.ItemIndex+1 %>" />


                                                    </DataItemTemplate>
                                                </dx:GridViewDataTextColumn>
                                                <dx:GridViewDataColumn Caption="Patient Name" FieldName="PatientFullName" VisibleIndex="2" ShowInCustomizationForm="True">
                                                    <HeaderStyle HorizontalAlign="Center"></HeaderStyle>

                                                    <CellStyle HorizontalAlign="Left"></CellStyle>
                                                </dx:GridViewDataColumn>
                                                <dx:GridViewDataColumn Caption="Bill No." FieldName="BillNumber" VisibleIndex="3" ShowInCustomizationForm="True">
                                                    <DataItemTemplate>
                                                        <asp:LinkButton ID="BillNo" runat="server" Text='<%# Container.Text%>' OnClick="ViewBillReportClick" />
                                                    </DataItemTemplate>
                                                    <HeaderStyle HorizontalAlign="Center"></HeaderStyle>
                                                    <CellStyle HorizontalAlign="Left"></CellStyle>
                                                </dx:GridViewDataColumn>

                                                   <dx:GridViewDataColumn Caption="Bill Type" FieldName="BillingType" VisibleIndex="4" ShowInCustomizationForm="True">
                                                    <HeaderStyle HorizontalAlign="Center"></HeaderStyle>

                                                    <CellStyle HorizontalAlign="Left"></CellStyle>
                                                </dx:GridViewDataColumn>

                                                <dx:GridViewDataColumn Caption="Customer Type" FieldName="CustomerCategoryCode" VisibleIndex="5" ShowInCustomizationForm="True">
                                                    <HeaderStyle HorizontalAlign="Center"></HeaderStyle>
                                                    <CellStyle HorizontalAlign="Left"></CellStyle>
                                                    <DataItemTemplate>
                                                        <asp:Label ID="lblCustomerType" runat="server"></asp:Label>
                                                    </DataItemTemplate>
                                                </dx:GridViewDataColumn>

                                                <dx:GridViewDataColumn Caption="Bill Created Date" FieldName="BillCreatedDateTime" VisibleIndex="6" ShowInCustomizationForm="True">
                                                    <HeaderStyle HorizontalAlign="Center"></HeaderStyle>
                                                    <CellStyle HorizontalAlign="Left"></CellStyle>
                                                </dx:GridViewDataColumn>
                                                <dx:GridViewDataColumn Caption="COF Name" FieldName="CorporateName" VisibleIndex="7" ShowInCustomizationForm="True">
                                                    <HeaderStyle HorizontalAlign="Center"></HeaderStyle>
                                                    <CellStyle HorizontalAlign="Left"></CellStyle>
                                                </dx:GridViewDataColumn>
                                                <dx:GridViewDataColumn Caption="Ref Doctor" FieldName="RefDocName" VisibleIndex="8" ShowInCustomizationForm="True">
                                                    <HeaderStyle HorizontalAlign="Center"></HeaderStyle>
                                                    <CellStyle HorizontalAlign="Left"></CellStyle>
                                                </dx:GridViewDataColumn>
                                                <dx:GridViewDataColumn Caption="Amount" FieldName="BillAmount" VisibleIndex="9" ShowInCustomizationForm="True">
                                                    <HeaderStyle HorizontalAlign="Center"></HeaderStyle>
                                                    <CellStyle HorizontalAlign="Left"></CellStyle>
                                                </dx:GridViewDataColumn>
                                                <dx:GridViewDataColumn Caption="Amount Paid" FieldName="AmountRecieved" VisibleIndex="10" ShowInCustomizationForm="True" Visible="False">
                                                    <HeaderStyle HorizontalAlign="Center"></HeaderStyle>
                                                    <CellStyle HorizontalAlign="Left"></CellStyle>
                                                </dx:GridViewDataColumn>
                                                <dx:GridViewDataColumn Caption="Balance" FieldName="AmountBalance" VisibleIndex="11" ShowInCustomizationForm="True">
                                                    <HeaderStyle HorizontalAlign="Center"></HeaderStyle>
                                                    <CellStyle HorizontalAlign="Left"></CellStyle>
                                                </dx:GridViewDataColumn>
                                                <dx:GridViewDataColumn Caption="Status" FieldName="BillStatus" VisibleIndex="12" ShowInCustomizationForm="True">
                                                    <HeaderStyle HorizontalAlign="Center"></HeaderStyle>
                                                    <CellStyle HorizontalAlign="Left"></CellStyle>
                                                    <DataItemTemplate>
                                                        <asp:Label ID="lblStatus" runat="server"></asp:Label>
                                                    </DataItemTemplate>
                                                </dx:GridViewDataColumn>
                                                <dx:GridViewDataColumn Caption="Actions" FieldName="Actions" VisibleIndex="13" ShowInCustomizationForm="True">
                                                    <DataItemTemplate>
                                                        <asp:LinkButton ID="lnkEditBill" runat="server" Text="Edit" OnClick="EditBillClick" />
                                                        <asp:LinkButton ID="lnkCancelBill" runat="server" Text="Cancel" OnClick="CancelBillButtonClick" />
                                                       <%-- <asp:LinkButton ID="lnkdeleteBill" runat="server" Text="Delete" OnClick="lnkdeleteBill_Click" Visible="false" ToolTip="Click to Delete Bill Permanently"/>--%>
                                                        <asp:HiddenField ID="hdnDiagID" runat="server" />
                                                    </DataItemTemplate>
                                                    <HeaderStyle HorizontalAlign="Center"></HeaderStyle>
                                                    <CellStyle HorizontalAlign="Left"></CellStyle>
                                                </dx:GridViewDataColumn>

                                            </Columns>

                                        </dx:ASPxGridView>
                                    </asp:Panel>
                                </td>
                            </tr>
                        </table>
                        <asp:Button ID="btnShowPopup" runat="server" Style="display: none" />
                        <cc1:ModalPopupExtender ID="MPEBillCancellation" runat="server" PopupControlID="pnl_BillCancellation"
                            BackgroundCssClass="modalBackgroundLogin" TargetControlID="btnShowPopup" CancelControlID="ImageButton_CloseAddApp"
                            DynamicServicePath="" Enabled="True">
                        </cc1:ModalPopupExtender>
                        <asp:Panel ID="pnl_BillCancellation" runat="server" Style="margin: 0 auto; background-color: White; display: none; padding: 3px;"
                            DefaultButton="btn_CancelBillPayment" Width="420px" CssClass="PartnerLogin">
                            <table cellpadding="0" cellspacing="0" class="tablestyle" style="height: auto; width: 400px; margin-left: 1em">
                                <tr>
                                    <td valign="top" style="background-color: #FFFFFF;" rowspan="2">
                                        <div style="text-align: right">
                                            <asp:ImageButton ID="ImageButton_CloseAddApp" runat="server" Height="25px" Width="25px" ImageUrl="~/Images/CloseIcon.png" />
                                        </div>
                                        <div id="Div4" class="modalbackgroundAppointment">
                                            Bill Cancel
                                        </div>
                                        <div style="border-bottom: 2px Solid #49B5D2; width: 100%">
                                        </div>
                                        <cc1:CollapsiblePanelExtender ID="CPEConfirmCancelBill" runat="server" CollapseControlID="btn_ok"
                                            TargetControlID="panel_Cancel_Confirm" BehaviorID="cpeForBehavior" SuppressPostBack="True" Enabled="True" />
                                        <asp:Panel ID="panel_Cancel_Confirm" runat="server">
                                            <table class="tablestyle" cellpadding="3px" cellspacing="3px" style="width: 400px;">
                                                <tr>
                                                    <td colspan="4">
                                                        <asp:Label ID="Label_Success_Apppointment" runat="server" CssClass="label1" Text="You are about to cancel a bill and the action cannot be reverted. Do you want to proceed?" />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td align="right">
                                                        <asp:Button ID="btn_ok" runat="server" OnClientClick="ShowModalpopupBillCancel" CssClass="DivButton"
                                                            Text="Ok" Width="70px" Height="22px" />
                                                        <asp:Button ID="btn_Cancel" runat="server" OnClientClick="HideModalpopupBillCancel" CssClass="DivButton"
                                                            Text="Cancel" Width="70px" Height="22px" />
                                                    </td>
                                                </tr>
                                            </table>
                                        </asp:Panel>
                                        <table class="tablestyle" cellpadding="3px" cellspacing="3px" style="width: 400px;">
                                            <tr>
                                                <td>
                                                    <cc1:CollapsiblePanelExtender ID="CPESubmitCancelBill" runat="server" Collapsed="True" ExpandControlID="btn_ok"
                                                        TargetControlID="panel_Cancel_Remarks" BehaviorID="cpeForBehavior1" SuppressPostBack="True" Enabled="True" />
                                                    <asp:Panel ID="panel_Cancel_Remarks" runat="server">
                                                        <table>
                                                            <tr>
                                                                <td>
                                                                    <asp:Label ID="lblStatiCancelPaidAmt" runat="server" CssClass="label1" Text="Amount Paid:" />
                                                                    <asp:Label ID="lblCancelAmtPaid" ClientIDMode="Static" CssClass="label1" runat="server" />
                                                            </tr>
                                                            <tr>
                                                                <td>
                                                                    <asp:Label ID="lblStaticCancelRefundAmt" CssClass="label1" runat="server" Text="Refund Amount:" />

                                                                    <asp:TextBox ID="txtCancelRefundAmt" runat="server" ClientIDMode="Static" />
                                                                    <asp:RequiredFieldValidator ID="req_cancel_RefundAmt" runat="server" ValidationGroup="validateBillcancellation"
                                                                        ControlToValidate="txtCancelRefundAmt" Text="Enter refund amount" ForeColor="Red" />
                                                                    <cc1:FilteredTextBoxExtender ID="fteCancelRefund" runat="server" TargetControlID="txtCancelRefundAmt"
                                                                        ValidChars="1234567890." Enabled="True" />
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td style="width: 300px">
                                                                    <asp:Label ID="Label17" runat="server" CssClass="label1" Text="Reason For Bill Cancellation:" Width="180px" />
                                                                    <asp:TextBox ID="txt_Cancel_Remarks" runat="server" CssClass="multiLineTextbox" TextMode="MultiLine"
                                                                        Width="370px" Height="60px" />
                                                                    <asp:RequiredFieldValidator ID="req_cancel_remarks" runat="server" ValidationGroup="validateBillcancellation"
                                                                        ControlToValidate="txt_Cancel_Remarks" Text="Enter bill cancellation reason" ForeColor="Red" />
                                                                    <div style="text-align: center">
                                                                        <asp:Button ID="btn_CancelBillPayment" runat="server" ValidationGroup="validateBillcancellation" CssClass="BillDivButton"
                                                                            Text="Submit" Width="70px" Height="22px" OnClick="SubmitCancelBillClick" UseSubmitBehavior="False" OnClientClick="if(onCancelBillSubmit(this)==false) return;" />
                                                                    </div>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </asp:Panel>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                            </table>
                        </asp:Panel>

                        <asp:HiddenField ID="hdnTargetIDForPop" runat="server" />
                        <asp:HiddenField ID="hdnCancelIDForPop" runat="server" />
                        <cc1:ModalPopupExtender ID="MPECancelBillMsg" BehaviorID="MPE_RequestDemo_BehaviourID"
                            runat="server" PopupControlID="PnlCancelBillPopMsg" TargetControlID="hdnTargetIDForPop" BackgroundCssClass="modalBackgroundLogin"
                            CancelControlID="hdnCancelIDForPop" Enabled="True" DynamicServicePath="">
                        </cc1:ModalPopupExtender>
                        <asp:Panel ID="PnlCancelBillPopMsg" runat="server" Style="margin: 0 auto; background-color: White; display: none; border-width: 10px; border-style: solid; border-color: #f6f6f6; padding: 3px;"
                            CssClass="PartnerLogin" Width="400px">
                            <table cellpadding="0" cellspacing="0" class="tablestyle" style="height: 150px;">
                                <tr>
                                    <td valign="top" style="background-color: #FFFFFF;" rowspan="2">
                                        <div style="text-align: right">
                                        </div>
                                        <div style="text-align: left">
                                            Message:-
                                        </div>
                                        <br />
                                        <br />
                                        <br />
                                        <div>
                                            <center>
                                                <asp:Label ID="lblCancelMsg" runat="server" Font-Bold="True" />
                                            </center>
                                        </div>
                                        <br />
                                        <br />
                                        <br />
                                        <br />
                                        <div>
                                            <center>
                                                <asp:Button ID="btnOKSentReport" runat="server" Text="OK" Width="50px" CssClass="DivButton"
                                                    OnClientClick="OkButtonOfCancelBillMsgPopUp()" />
                                            </center>
                                        </div>
                                    </td>
                                </tr>
                            </table>
                        </asp:Panel>
                    
                    
                      <asp:Button ID="Btnpopup" runat="server" Style="display: none" />
                        <cc1:ModalPopupExtender ID="mpedeletingbill" runat="server" PopupControlID="pnl_Billdeletion"
                            BackgroundCssClass="modalBackgroundLogin" TargetControlID="Btnpopup" CancelControlID="btn_billdeletecancel"
                            DynamicServicePath="" Enabled="True">
                        </cc1:ModalPopupExtender>
                        <asp:Panel ID="pnl_Billdeletion" runat="server" Style="margin: 0 auto; background-color: White; display: none; padding: 3px;" Width="420px" CssClass="PartnerLogin">
                            <table cellpadding="0" cellspacing="0" class="tablestyle" style="height: auto; width: 400px; margin-left: 1em">
                                <tr>
                                    <td valign="top" style="background-color: #FFFFFF;" rowspan="2">
                                       <div style="text-align: right">
                                        </div>
                                        <div id="Div1" class="modalbackgroundAppointment">
                                            Bill Delete
                                        </div>
                                        <div style="border-bottom: 2px Solid #49B5D2; width: 100%">
                                        </div>
                                        <cc1:CollapsiblePanelExtender ID="Cpedeletionbill" runat="server" CollapseControlID="btn_billdeletecancel"
                                            TargetControlID="panel_Delete_Confirm" BehaviorID="cpeForBehavior2" SuppressPostBack="True" Enabled="True" />
                                        <asp:Panel ID="panel_Delete_Confirm" runat="server">
                                            <table class="tablestyle" cellpadding="3px" cellspacing="3px" style="width: 400px;">
                                                <tr>
                                                    <td colspan="4">
                                                        <asp:Label ID="Label_Warning" runat="server" CssClass="label1" Text="You are about to Delete a bill and the action is irreversible and permanent. Do you want to proceed?" />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td align="right">
                                                        <asp:Button ID="btn_billdelete" runat="server"  CssClass="DivButton" OnClick="btn_billdelete_Click"
                                                            Text="Ok" Width="70px" Height="22px" />
                                                        <asp:Button ID="btn_billdeletecancel" runat="server"  CssClass="DivButton" OnClientClick="HideModalpopupBillDelete"
                                                            Text="Cancel" Width="70px" Height="22px" />
                                                    </td>
                                                </tr>
                                            </table>
                                        </asp:Panel>
                                        </td></tr></table>
                    </asp:Panel>
                        
                    </ContentTemplate>
                </cc1:TabPanel>
                <cc1:TabPanel ID="TabPanelBulkAmt" runat="server">
                    <HeaderTemplate>
                        Deposits
                    </HeaderTemplate>
                    <ContentTemplate>
                        <%--<asp:UpdatePanel ID="uPnlBulkAmtMgmnt" runat="server">--%>
                        <%--<ContentTemplate>--%>
                        <asp:Panel ID="pnlViewDeposits" runat="server" ScrollBars="Auto" Width="850px" Height="530px">
                            <table width="100%">
                                <tr>
                                    <td align="left" style="width: 30%">
                                        <div class="TermsConditionHeader">
                                            <asp:Label ID="lblBulkAmtScreen" runat="server" Text="Bulk Amount Management"></asp:Label>
                                        </div>
                                    </td>
                                    <td align="right" style="width: 70%"></td>
                                </tr>
                            </table>
                            <div style="border-top: 2px Solid #49B5D2; padding-left: 3em; width: 800px; margin-bottom: 10px;"></div>
                            <div style="padding-left: 1.5em">
                                <div style="text-align: right; padding-right: 20px">
                                    <asp:ImageButton ID="btn_AddCorp" runat="server" CausesValidation="false" CssClass="imgButton"
                                        ImageAlign="Middle" ImageUrl="~/Images/add-icon.png"
                                        OnClick="btn_AddBulkAmount_Click" Style="height: 30px; width: 40px;" ToolTip="Click to Add Amount" />
                                </div>
                                <dx:ASPxGridView ID="grdDeposits" runat="server" AutoGenerateColumns="False"
                                    Width="800px" Theme="Aqua" OnPageIndexChanged="grdDeposits_PageIndexChanged"
                                    OnPageSizeChanged="grdDeposits_PageSizeChanged">
                                    <Columns>
                                        <dx:GridViewDataTextColumn Caption="#" ShowInCustomizationForm="True" VisibleIndex="1" Width="30px">
                                            <DataItemTemplate>
                                                <dx:ASPxLabel ID="SLNO" runat="server" Text="<%# Container.ItemIndex + 1 %>">
                                                </dx:ASPxLabel>
                                            </DataItemTemplate>
                                            <HeaderStyle HorizontalAlign="Center" />
                                            <CellStyle HorizontalAlign="Center"></CellStyle>
                                        </dx:GridViewDataTextColumn>
                                        <dx:GridViewDataColumn Caption="Corporate Name" FieldName="CorporateName" VisibleIndex="2" Width="10px">
                                            <HeaderStyle HorizontalAlign="Left" />
                                            <CellStyle HorizontalAlign="Left"></CellStyle>
                                        </dx:GridViewDataColumn>
                                        <dx:GridViewDataColumn Caption="Entry Date" FieldName="CreatedDateTime" VisibleIndex="3" Width="10px">
                                            <HeaderStyle HorizontalAlign="Left" />
                                            <CellStyle HorizontalAlign="Left"></CellStyle>
                                        </dx:GridViewDataColumn>
                                        <dx:GridViewDataColumn Caption="Amount" FieldName="Amount" VisibleIndex="4" Width="10px">
                                            <HeaderStyle HorizontalAlign="Left" />
                                            <CellStyle HorizontalAlign="Left"></CellStyle>
                                        </dx:GridViewDataColumn>
                                        <dx:GridViewDataColumn Caption="Payment Mode" FieldName="PaymentMode" VisibleIndex="5" Width="10px">
                                            <HeaderStyle HorizontalAlign="Left" />
                                            <CellStyle HorizontalAlign="Left"></CellStyle>
                                        </dx:GridViewDataColumn>
                                        <dx:GridViewDataColumn Caption="Remarks" FieldName="Remarks" VisibleIndex="6" Width="150px">
                                            <HeaderStyle HorizontalAlign="Left" />
                                            <CellStyle HorizontalAlign="Left"></CellStyle>
                                        </dx:GridViewDataColumn>

                                        <dx:GridViewDataColumn Caption="Actions" FieldName="Actions" VisibleIndex="7" Width="250px">
                                            <DataItemTemplate>
                                                <asp:LinkButton ID="btnCancelBulkAmt" runat="server" Text="Cancel" OnClick="CancelBulkAmtClick" />
                                                <asp:Label ID="lblBulkAmtCancelled" runat="server" />
                                                <asp:Label ID="lblCancelledReason" runat="server" />
                                            </DataItemTemplate>
                                        </dx:GridViewDataColumn>
                                        <dx:GridViewDataColumn Caption="Entry ID" FieldName="BulkAmtEntryID" VisibleIndex="8" Visible="false" Width="10px">
                                        </dx:GridViewDataColumn>
                                    </Columns>
                                    <%--<SettingsDataSecurity AllowDelete="False" AllowEdit="False" AllowInsert="False"></SettingsDataSecurity>--%>
                                </dx:ASPxGridView>
                            </div>
                            <asp:Panel ID="pnlDevPopupCancelBulkAmt" runat="server" Style="width: 425px; height: 130px">
                                <div style="text-align: center">
                                    <dx:ASPxPopupControl ID="dxPopupCancelBulkAmt" runat="server" AllowDragging="True" ClientInstanceName="popupControl_UpdateSucess"
                                        CloseAction="CloseButton" DragElement="Window" HeaderText="Cancellation Reason" Height="130px" Left="400" MaxHeight="600px" MinHeight="100px"
                                        Modal="True" ShowPageScrollbarWhenModal="False" Theme="Aqua" Top="200" Width="425px">
                                        <ModalBackgroundStyle BackColor="#CCCCCC">
                                        </ModalBackgroundStyle>
                                        <ContentCollection>
                                            <dx:PopupControlContentControl ID="popupControlCancelBulkAmt" runat="server" Height="130px" Width="425px">
                                                <table>
                                                    <tr>
                                                        <td style="width: 300px">
                                                            <asp:HiddenField ID="hdnSelectedBulkAmtEntryID" runat="server" />
                                                            <asp:Label ID="lblStaticCancelReason" runat="server" CssClass="label1" Text="Reason for cancellation:" Width="180px" />
                                                            <asp:TextBox ID="txtBulkAmtCancellationReason" runat="server" CssClass="multiLineTextbox" TextMode="MultiLine"
                                                                Width="370px" Height="60px" />
                                                            <asp:RequiredFieldValidator ID="reqCancelBulkAmtReason" runat="server" ValidationGroup="validateBulkAmtcancellation"
                                                                ControlToValidate="txtBulkAmtCancellationReason" Text="Enter cancellation reason" ForeColor="Red" />
                                                            <div style="text-align: center">
                                                                <asp:Button ID="btnSubmitBulkAmtCancellation" runat="server" ValidationGroup="validateBulkAmtcancellation" CssClass="BillDivButton"
                                                                    Text="Submit" Width="70px" Height="22px" OnClick="SubmitCancelBulkAmtClick" />
                                                            </div>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </dx:PopupControlContentControl>
                                        </ContentCollection>
                                    </dx:ASPxPopupControl>
                                </div>
                            </asp:Panel>
                        </asp:Panel>

                        <asp:Panel ID="pnlAddBulkAmt" runat="server" Visible="false">
                            <table width="100%">
                                <tr>
                                    <td align="left" style="width: 30%">
                                        <div class="TermsConditionHeader">
                                            <asp:Label ID="Label7" runat="server" Text="Add Amount"></asp:Label>
                                        </div>
                                    </td>
                                    <td align="right" style="width: 70%">
                                        <div>
                                            <asp:Button ID="btnSaveBulkAmt" runat="server" Text="Save" Width="100px" Height="30px" CssClass="DivButton" OnClick="SaveBulkAmountClick"
                                                ValidationGroup="validateSaveBulkAmt" ToolTip="Click to save the entered data" />
                                            <asp:Button ID="btnCancelAddBulkAmtScreen" runat="server" Text="Cancel" Width="100px" Height="30px" CssClass="DivButton"
                                                ToolTip="Click to Cancel" OnClick="CancelAddBulkAmtScreenClick" />
                                        </div>
                                    </td>
                                </tr>
                            </table>
                            <div style="border-top: 2px Solid #49B5D2; padding-left: 3em; width: 800px; margin-bottom: 40px;"></div>
                            <div class="PartBasicData" style="width: 790px;">
                                <table width="100%" style="width: 740px;">
                                    <tr>
                                        <td class="tdPartProfile">
                                            <asp:Label ID="staticlblCrp" runat="server" Text="Corporate" />
                                            <asp:Label ID="Label48" runat="server" Text="*" ForeColor="Red" Font-Size="20px" />
                                        </td>
                                        <td class="tdPartProfile">
                                            <asp:DropDownList ID="ddlCorporatesForBulkAmt" runat="server" CssClass="DropDownList" Width="235px">
                                            </asp:DropDownList>
                                            <asp:RequiredFieldValidator ID="RFVCorporateInBulkAmt" runat="server" ControlToValidate="ddlCorporatesForBulkAmt"
                                                ErrorMessage="Select Corporate" ValidationGroup="validateSaveBulkAmt" Font-Size="X-Small" ForeColor="Red"
                                                InitialValue="--Select Corporate--" />
                                        </td>

                                    </tr>
                                    <tr>
                                        <td class="tdPartProfile">
                                            <asp:Label ID="lblStaticAmt" runat="server" Text="Amount" />
                                            <asp:Label ID="Label4" runat="server" Text="*" ForeColor="Red" Font-Size="20px" />
                                        </td>
                                        <td class="tdPartProfile">
                                            <asp:TextBox ID="txtCrpBulkAmt" runat="server" CssClass="textbox1" Style="width: 230px;" />
                                            <cc1:FilteredTextBoxExtender ID="FTEBulkAmt" runat="server" ValidChars="0123456789" TargetControlID="txtCrpBulkAmt" />
                                            <asp:RequiredFieldValidator ID="RFVBulkAmtText" runat="server" ControlToValidate="txtCrpBulkAmt"
                                                ErrorMessage="Enter amount" ValidationGroup="validateSaveBulkAmt" Font-Size="X-Small" ForeColor="Red" />
                                        </td>

                                    </tr>
                                    <tr>
                                        <td class="tdPartProfile">
                                            <asp:Label ID="Label5" runat="server" Text="Payment Mode" />
                                            <asp:Label ID="Label10" runat="server" Text="*" ForeColor="Red" Font-Size="20px" />
                                        </td>
                                        <td class="tdPartProfile">

                                            <asp:DropDownList ID="ddlBulkAmtPaymentMode" runat="server" CssClass="drp"
                                                Width="100px">
                                                <asp:ListItem Selected="True">Cash</asp:ListItem>
                                                <asp:ListItem>Cheque</asp:ListItem>
                                            </asp:DropDownList>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="tdPartProfile">
                                            <asp:Label ID="lblStaticRemarks" runat="server" Text="Remarks" />
                                        </td>
                                        <td class="tdPartProfile">
                                            <asp:TextBox ID="txtBulkAmtRemarks" runat="server" TextMode="MultiLine" Height="50px"
                                                CssClass="multiLineTextbox" Style="width: 230px;" />
                                        </td>
                                    </tr>
                                </table>
                            </div>
                        </asp:Panel>
                        <%--</ContentTemplate>--%>
                        <%--</asp:UpdatePanel>--%>
                    </ContentTemplate>
                </cc1:TabPanel>

                 <cc1:TabPanel ID="TabPanel_BillCorrection" runat="server">
                    <HeaderTemplate>
                        Bill Correction
                    </HeaderTemplate>
                    <ContentTemplate>
                            <table cellpadding="0px" cellspacing="0px" width="100%">
                               <tr style="padding-top:0px; padding-bottom:0px;">
                                   <td>
                                       <div style="border-bottom: 2px; width: 100%; margin-top: 10px;"></div>
                                   </td>
                               </tr>
                            <tr>
                                
                                <td style="width: 20%">
                                    <div class="TermsConditionHeader">
                                        <asp:Label ID="Label6" runat="server" Text="Bill Correction"></asp:Label>
                                    </div>

                                </td>
                                <td style="width: 160px;">
                                    
                                    <asp:Label ID="lblbillcorrection" runat="server" Text="Bill Number" Font-Bold="true"></asp:Label>
                                    <br />
                                     <asp:TextBox ID="Bill_CorrectionSearch" runat="server" autocomplete="off" style="width:150px;margin-top: 0px;padding-top: 0px;" CssClass="textbox1" />
                                </td>
                                <td>
                                    <asp:Button ID="Btn_Search_BillCorr" runat="server" Text="Search" Width="80px" Height="30px" CssClass="DivButton"
                                        ToolTip="Click to Search Bill Number" UseSubmitBehavior="False" OnClick="Btn_Search_BillCorr_Click"/>
                                </td>
                                <td style="width: 10%; padding-left: 170px;" >
                                    <asp:Button ID="Btn_UpdateBillCorr" runat="server" Text="Update" Width="80px" Height="30px" CssClass="DivButton"
                                        ToolTip="Click to Update Bill" OnClick="Btn_UpdateBillCorr_Click" UseSubmitBehavior="False" 
                                        />
                                    <asp:HiddenField ID="HiddenField_BillType" runat="server" />

                                    <td>
                                        <asp:Button ID="Button_CancelCorrection" runat="server" CssClass="DivButton" Height="30px"  Text="Cancel" 
                                            ToolTip="Click to Cancel Bill Correction" Width="80px" OnClick="Button_CancelCorrection_Click" />
                                    </td>
                                </td>
                            </tr>
                        </table>
                            <div style="border-bottom: 2px Solid #49B5D2; width: 100%; margin-top: 2px;"></div>
                            <asp:Panel ID="billcorrpnl" runat="server" Visible="false">
                            <table>
                            <tr>
                                <td style="padding-left:10px;">
                                    <asp:Label ID="lbl_Bill" runat="server" Text="Bill No.:" Font-Bold="true" Font-Size="Large"></asp:Label>
                                    <asp:Label ID="lbl_BillNo" runat="server" Font-Bold="true" Font-Size="Large"></asp:Label>
                                    <asp:HiddenField ID="BillIDNo" runat="server" />
                                    <asp:HiddenField ID="DiagID" runat="server" />
                                </td>
                                <td style="padding-left:30px;">
                                    <asp:Label ID="lbl_PID" runat="server" Text="Patient No.:" Font-Bold="true" Font-Size="Large"></asp:Label>
                                    <asp:Label ID="lbl_PIDNo" runat="server" Font-Bold="true" Font-Size="Large"></asp:Label>
                                    <asp:HiddenField ID="IPIDNo" runat="server" />
                                </td>
                                <td style="padding-left:30px;">
                                    <asp:Label ID="lbl_PName" runat="server" Font-Bold="true" Font-Size="Large"></asp:Label>
                                </td>
                            </tr>
                        </table>
                            <div style="border-bottom: 2px Solid #49B5D2; height:0px; width: 100%; margin-top: 2px;"></div>
                            </asp:Panel>
                            <div style="border-bottom: 2px; height:10px; width: 100%; margin-top: 2px;"></div>
                            <asp:Panel ID="pnlgrdBillDetails_c" runat="server" >
                                <asp:Label ID="llblPert" runat="server" Text="Bill Services/ Items" Visible="false" style="padding-left:10px;" Font-Bold="true" ></asp:Label>
                                <asp:Panel ID="grdpnlbill" runat="server" ScrollBars="Auto" Height="250px">
                         <asp:GridView ID="grdBillDetails_c" runat="server" AutoGenerateColumns="False"
                                                    CssClass="GridViewStyle3" GridLines="None" Style="margin-left: 10px" Width="795px">
                                                    <AlternatingRowStyle BackColor="White" ForeColor="#284775" Height="25px" />
                                                    <Columns>
                                                       
                                                        <asp:TemplateField HeaderText="#">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblbillslno_c" runat="server" Width="50px" Text="<%#Container.DataItemIndex+1  %>" />
                                                            </ItemTemplate>
                                                            <HeaderStyle Height="2px" Width="60px" HorizontalAlign="Left" />
                                                            <ItemStyle Width="60px" />
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Service Head">
                                                            <ItemTemplate>
                                                                <asp:DropDownList ID="ddlService_c" runat="server" AutoPostBack="true" 
                                                                    Width="180px">
                                                                </asp:DropDownList>
                                                                <asp:HiddenField ID="hdnFieldForEachServices_c" runat="server" />
                                                            </ItemTemplate>
                                                            <HeaderStyle Height="2px" Width="200px" HorizontalAlign="Left" />
                                                            <ItemStyle Width="180px" />
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Service Item">
                                                            <ItemTemplate>
                                                                <asp:DropDownList ID="ddlParticulars_c" runat="server" AutoPostBack="true" 
                                                                    Width="260px">
                                                                </asp:DropDownList>
                                                            </ItemTemplate>
                                                            <HeaderStyle Height="2px" Width="330px" HorizontalAlign="Left" />
                                                            <ItemStyle Width="260px" />
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Rate">
                                                            <ItemTemplate>
                                                                <asp:TextBox ID="txtRate_c" runat="server" autocomplete="off" onchange="CorrectionBillItemRateChanged()"  Style="text-align: right"
                                                                    MaxLength="10" Width="120px"></asp:TextBox>
                                                                <cc1:FilteredTextBoxExtender ID="flt_BillRate" runat="server" TargetControlID="txtRate_c" ValidChars="1234567890."
                                                                    FilterMode="ValidChars" Enabled="True">
                                                                </cc1:FilteredTextBoxExtender>
                                                            </ItemTemplate>
                                                            <HeaderStyle Height="2px" Width="100px" HorizontalAlign="Left" />
                                                            <ItemStyle Width="120px" HorizontalAlign="Right" />
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Qty">
                                                            <ItemTemplate>
                                                                <asp:TextBox ID="txtQty_c" runat="server" Style="text-align: right"
                                                                    MaxLength="10" Width="30px" onchange="CorrectionBillItemRateChanged()"/>
                                                                <cc1:filteredtextboxextender id="flt_qty" runat="server" targetcontrolid="txtQty_c" validchars="1234567890."
                                                                    enabled="true">
                                                                </cc1:filteredtextboxextender>
                                                            </ItemTemplate>
                                                            <HeaderStyle Height="2px" Width="100px" HorizontalAlign="Left" />
                                                            <ItemStyle Width="30px" HorizontalAlign="Right" />
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Total">
                                                            <ItemTemplate>
                                                                <%--<asp:Label ID="lblTotalOfEachItem_c" runat="server" Width="120px" CssClass="lblTotalCss_c" />--%>
                                                                <asp:TextBox ID="txtprc_c" runat="server" autocomplete="off"  Style="text-align: right"
                                                                    MaxLength="10" Width="120px" Enabled="false"></asp:TextBox>
                                                                <asp:HiddenField ID="hdnTotalOfEachItem_c" runat="server" />

                                                            </ItemTemplate>
                                                            <HeaderStyle Height="2px" Width="100px" HorizontalAlign="Left" />

                                                            <ItemStyle Width="120px" HorizontalAlign="Right" />
                                                        </asp:TemplateField>
                                                    </Columns>
                                                    <FooterStyle CssClass="footerStyle3" Font-Bold="True" ForeColor="White" />
                                                    <HeaderStyle CssClass="HeaderStyle3" Font-Bold="True" ForeColor="White" Height="20px" />
                                                    <RowStyle BackColor="#F7F6F3" CssClass="RowStyle3" ForeColor="#333333" Height="25px" />
                                                    <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" Height="25px" />
                                                </asp:GridView>
                                    </asp:Panel>
                                <asp:Label ID="lbltotamt_C" runat="server" Text="Total of Items:" Font-Bold="true" Visible="false" style="padding-left:620px;"></asp:Label>
                        <asp:Label ID="lblTotal_C"  runat="server" Font-Bold="true"></asp:Label>
                                <asp:Image ID="Image7" runat="server" ImageUrl="~/Images/rupee.png" AlternateText="Rs" Visible="false"/>
                                </asp:Panel>
                        
                           <asp:Panel ID="pnlbilldetls" runat="server">
                                        <asp:Label ID="llblbill" runat="server" Text="Bill Details" Visible="false" Font-Bold="true" style="padding-left:10px;" ></asp:Label>
                            <asp:GridView ID="grdBillDet" runat="server" AutoGenerateColumns="False"
                                                    CssClass="GridViewStyle3" GridLines="None" Style="margin-left: 10px" Width="795px">
                                                    <AlternatingRowStyle BackColor="White" ForeColor="#284775" Height="25px" />
                                <Columns>
                                    <asp:TemplateField HeaderText="#">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblBillAmt_c" runat="server" Width="15px" Text="<%#Container.DataItemIndex+1  %>" />
                                                            </ItemTemplate>
                                                            <HeaderStyle Height="2px" Width="20px" HorizontalAlign="Center" />
                                                            <ItemStyle Width="20px" HorizontalAlign="Center" />
                                                        </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Bill Amt" HeaderStyle-Font-Bold="false">
                                                            <ItemTemplate>
                                                                 
                                                                <asp:TextBox ID="txtBillAmt" runat="server" autocomplete="off"  Style="text-align: right"
                                                                    MaxLength="10" Width="120px"></asp:TextBox>
                                                                <asp:HiddenField ID="hdnBillid" runat="server" />
                                                                <cc1:FilteredTextBoxExtender ID="flttxtBillAmt" runat="server" TargetControlID="txtBillAmt" ValidChars="1234567890."
                                                                    FilterMode="ValidChars" Enabled="True">
                                                                </cc1:FilteredTextBoxExtender>
                                                            </ItemTemplate>
                                                            <HeaderStyle Height="2px" Width="100px" HorizontalAlign="Right" />
                                                            <ItemStyle Width="120px" HorizontalAlign="Right" />
                                                        </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Amt Received" HeaderStyle-Font-Bold="false">
                                                            <ItemTemplate>
                                                                 
                                                                <asp:TextBox ID="txtAmtRecieved" runat="server" autocomplete="off" Style="text-align: right"
                                                                    MaxLength="10" Width="120px"></asp:TextBox>
                                                                <cc1:FilteredTextBoxExtender ID="flttxtAmtRecieved" runat="server" TargetControlID="txtAmtRecieved" ValidChars="1234567890."
                                                                    FilterMode="ValidChars" Enabled="True">
                                                                </cc1:FilteredTextBoxExtender>
                                                            </ItemTemplate>
                                                            <HeaderStyle Height="2px" Width="100px" HorizontalAlign="Right" />
                                                            <ItemStyle Width="120px" HorizontalAlign="Right" />
                                                        </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Amt Balance" HeaderStyle-Font-Bold="false">
                                                            <ItemTemplate>
                                                                 
                                                                <asp:TextBox ID="txtAmtBalance" runat="server" autocomplete="off" Style="text-align: right"
                                                                    MaxLength="10" Width="120px"></asp:TextBox>
                                                                <cc1:FilteredTextBoxExtender ID="flttxtAmtBalance" runat="server" TargetControlID="txtAmtBalance" ValidChars="1234567890."
                                                                    FilterMode="ValidChars" Enabled="True">
                                                                </cc1:FilteredTextBoxExtender>
                                                            </ItemTemplate>
                                                            <HeaderStyle Height="2px" Width="100px" HorizontalAlign="Right" />
                                                            <ItemStyle Width="120px" HorizontalAlign="Right" />
                                                        </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Discount" HeaderStyle-Font-Bold="false">
                                                            <ItemTemplate>
                                                                 
                                                                <asp:TextBox ID="txtDiscount" runat="server" autocomplete="off" Style="text-align: right"
                                                                    MaxLength="10" Width="120px"></asp:TextBox> 
                                                                <cc1:FilteredTextBoxExtender ID="fltDiscount" runat="server" TargetControlID="txtDiscount" ValidChars="1234567890."
                                                                    FilterMode="ValidChars" Enabled="True">
                                                                </cc1:FilteredTextBoxExtender>
                                                            </ItemTemplate>
                                                            <HeaderStyle Height="2px" Width="100px" HorizontalAlign="Right" />
                                                            <ItemStyle Width="120px" HorizontalAlign="Right" />
                                                        </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Bill Status" HeaderStyle-Font-Bold="false">
                                                            <ItemTemplate>
                                                                 
                                                                <asp:TextBox ID="txtBillStatus" runat="server" autocomplete="off" Style="text-align: right"
                                                                    MaxLength="10" Width="120px" Enabled="false"></asp:TextBox>
                                                                <%--<cc1:FilteredTextBoxExtender ID="flttxtBillStatus" runat="server" TargetControlID="txtBillStatus" ValidChars="1234567890."
                                                                    FilterMode="ValidChars" Enabled="True">
                                                                </cc1:FilteredTextBoxExtender>--%>
                                                            </ItemTemplate>
                                                            <HeaderStyle Height="2px" Width="100px" HorizontalAlign="Right" />
                                                            <ItemStyle Width="120px" HorizontalAlign="Right" />
                                                        </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Advance Amt" HeaderStyle-Font-Bold="false" Visible="false">
                                                            <ItemTemplate>
                                                                 
                                                                <asp:TextBox ID="txtAdvanceAmt" runat="server"  autocomplete="off"  Style="text-align: right"
                                                                    MaxLength="10" Width="120px"></asp:TextBox>
                                                                <cc1:FilteredTextBoxExtender ID="flttxtAdvanceAmt" runat="server" TargetControlID="txtAdvanceAmt" ValidChars="1234567890."
                                                                    FilterMode="ValidChars" Enabled="True">
                                                                </cc1:FilteredTextBoxExtender>
                                                            </ItemTemplate>
                                                            <HeaderStyle Height="2px" Width="100px" HorizontalAlign="Right" />
                                                            <ItemStyle Width="120px" HorizontalAlign="Right" />
                                                        </asp:TemplateField>
                                </Columns>
                                <FooterStyle CssClass="footerStyle3" Font-Bold="True" ForeColor="White" />
                                                    <HeaderStyle CssClass="HeaderStyle3" Font-Bold="True" ForeColor="White" Height="20px" />
                                                    <RowStyle BackColor="#F7F6F3" CssClass="RowStyle3" ForeColor="#333333" Height="25px" />
                                                    <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" Height="25px" />
                                </asp:GridView>
                        </asp:Panel>
                            <div style="border-bottom: 2px; height:10px; width: 100%; margin-top: 2px;"></div>
                            <asp:Panel ID="pnlgrdBillTxn" runat="server">
                                    <asp:Label ID="llblTxt" runat="server" Text="Bill Transaction Details" Visible="false" style="padding-left:10px;" Font-Bold="true" ></asp:Label>
                         <asp:GridView ID="grdBillTxn" runat="server" AutoGenerateColumns="False"
                                                    CssClass="GridViewStyle3" GridLines="None" Style="margin-left: 10px" Width="795px">
                                                    <AlternatingRowStyle BackColor="White" ForeColor="#284775" Height="25px" />
                                                    <Columns>
                                                            <asp:TemplateField HeaderText="#">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblbillstxn_c" Width="20px" runat="server"  Text="<%#Container.DataItemIndex+1  %>" />
                                                            </ItemTemplate>
                                                            <HeaderStyle Height="2px" Width="20px" HorizontalAlign="Center" />
                                                            <ItemStyle Width="20px" HorizontalAlign="Center"  />
                                                        </asp:TemplateField>
                                                         <asp:TemplateField HeaderText="Bill Amt" HeaderStyle-Font-Bold="false">
                                                            <ItemTemplate>
                                                                <asp:TextBox ID="txtTxnBillAmt" autocomplete="off" runat="server"  Style="text-align: right"
                                                                    MaxLength="10" Width="120px" ></asp:TextBox>
                                                                <asp:HiddenField ID="hdnTxnID" runat="server" />
                                                                <asp:HiddenField ID="hdnTxnNo" runat="server" />
                                                                <cc1:FilteredTextBoxExtender ID="flt_txtTxnBillAmt" runat="server" TargetControlID="txtTxnBillAmt" 
                                                                    ValidChars="1234567890." FilterMode="ValidChars" Enabled="True">
                                                                </cc1:FilteredTextBoxExtender>
                                                            </ItemTemplate>
                                                            <HeaderStyle Height="2px"  HorizontalAlign="Right" />
                                                            <ItemStyle  HorizontalAlign="Right" />
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Discount" HeaderStyle-Font-Bold="false">
                                                            <ItemTemplate>
                                                                <asp:TextBox ID="txtDiscount" runat="server" autocomplete="off"  Style="text-align: right"
                                                                    MaxLength="10" Width="90px" ></asp:TextBox>
                                                                <cc1:FilteredTextBoxExtender ID="flt_txtDiscount" runat="server" TargetControlID="txtDiscount" ValidChars="1234567890."
                                                                    FilterMode="ValidChars" Enabled="True">
                                                                </cc1:FilteredTextBoxExtender>
                                                            </ItemTemplate>
                                                            <HeaderStyle Height="2px"  HorizontalAlign="Right" />
                                                            <ItemStyle  HorizontalAlign="Right" />
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Amt Paid" HeaderStyle-Font-Bold="false">
                                                            <ItemTemplate>
                                                                <asp:TextBox ID="txtAmtPaid" runat="server" autocomplete="off" Style="text-align: right"
                                                                    MaxLength="10" Width="120px" ></asp:TextBox>
                                                                <cc1:FilteredTextBoxExtender ID="flt_txtAmtPaid" runat="server" TargetControlID="txtAmtPaid" ValidChars="1234567890."
                                                                    FilterMode="ValidChars" Enabled="True">
                                                                </cc1:FilteredTextBoxExtender>
                                                            </ItemTemplate>
                                                            <HeaderStyle Height="2px"  HorizontalAlign="Right" />
                                                            <ItemStyle  HorizontalAlign="Right" />
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Amt Balance" HeaderStyle-Font-Bold="false">
                                                            <ItemTemplate>
                                                                <asp:TextBox ID="txtAmtBal" runat="server" autocomplete="off" Style="text-align: right"
                                                                    MaxLength="10" Width="120px" ></asp:TextBox>
                                                                <cc1:FilteredTextBoxExtender ID="flt_txtAmtBal" runat="server" TargetControlID="txtAmtBal" ValidChars="1234567890."
                                                                    FilterMode="ValidChars" Enabled="True">
                                                                </cc1:FilteredTextBoxExtender>
                                                            </ItemTemplate>
                                                            <HeaderStyle Height="2px"  HorizontalAlign="Right" />
                                                            <ItemStyle  HorizontalAlign="Right" />
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Payment Mode" HeaderStyle-Font-Bold="false">
                                                            <ItemTemplate>
                                                                <asp:DropDownList ID="ddltxnPayMode" runat="server" CssClass="DropDownList" Style="width: 100px; margin-top: 0px; height: 21px;">
                                                                           <asp:ListItem Text="Cash" Value="0"></asp:ListItem>
                                                                            <asp:ListItem Text="Cheque" Value="1" />
                                                                            <asp:ListItem Text="Credit Card" Value="2" />
                                                                            <asp:ListItem Text="NEFT/RTGS" Value="3" />
                                                                     <asp:ListItem Text="Debit Card" Value="4" />

                                                                </asp:DropDownList>
                                                                <%--<asp:TextBox ID="txtPayMode" runat="server"  Style="text-align: right"
                                                                    MaxLength="10"  Enabled="false" Width="150px"></asp:TextBox>--%>
                                                               
                                                            </ItemTemplate>
                                                            
                                                            <HeaderStyle Height="2px"  HorizontalAlign="Right" />
                                                            <ItemStyle  HorizontalAlign="Right" />
                                                        </asp:TemplateField>
                                                         <asp:TemplateField HeaderText="Payment details" HeaderStyle-Font-Bold="false">
                                                            <ItemTemplate>
                                                                <asp:TextBox ID="txtTxnPaydet" runat="server" autocomplete="off" Style="text-align: right"
                                                                    MaxLength="10" Width="80px"></asp:TextBox>
                                                            </ItemTemplate>
                                                            <HeaderStyle Height="2px" Width="100px" HorizontalAlign="Right" />
                                                            <ItemStyle Width="120px" HorizontalAlign="Right" />
                                                        </asp:TemplateField>
                                                       

                                                    </Columns>
                                                    <FooterStyle CssClass="footerStyle3" Font-Bold="True" ForeColor="White" />
                                                    <HeaderStyle CssClass="HeaderStyle3" Font-Bold="True" ForeColor="White" Height="20px" />
                                                    <RowStyle BackColor="#F7F6F3" CssClass="RowStyle3" ForeColor="#333333" Height="25px" />
                                                    <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" Height="25px" />
                             </asp:GridView>
                                    </asp:Panel>
                            <div style="border-bottom: 2px; height:10px; width: 100%; margin-top: 2px;"></div>
                            <asp:Panel ID="pnlgrdAdv" runat="server" Visible="false">
                                            <asp:Label ID="llblAdv" runat="server" Text="Advance Details" Visible="false" Font-Bold="true" style="padding-left:10px;" ></asp:Label>
                                <asp:Panel ID="pnladvip" runat="server">
                         <asp:GridView ID="grdAdv" runat="server" AutoGenerateColumns="False"
                                                    CssClass="GridViewStyle3" GridLines="None" Style="margin-left: 10px" Width="300px">
                                                    <AlternatingRowStyle BackColor="White" ForeColor="#284775" Height="25px" />
                                                    <Columns>
                                                            <asp:TemplateField HeaderText="#">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblbillstxn_c" runat="server" Width="15px" Text="<%#Container.DataItemIndex+1  %>" />
                                                            </ItemTemplate>
                                                            <HeaderStyle Height="2px" Width="15px" HorizontalAlign="Center" />
                                                            <ItemStyle Width="15px" HorizontalAlign="Center" />
                                                        </asp:TemplateField>
                                                           <asp:TemplateField HeaderText="Payment Mode" HeaderStyle-Font-Bold="false">
                                                            <ItemTemplate>
                                                                <%--<asp:TextBox ID="txtPayMod" runat="server"  Style="text-align:left"
                                                                    MaxLength="10" Width="120px"></asp:TextBox>--%>
                                                               <asp:DropDownList ID="ddl_AdvancePaymentMode" runat="server" CssClass="DropDownList" Height="21px" style="margin-left:3px; margin-top:0px; margin-bottom:1px;" Width="160px">
                                                                            <asp:ListItem Text="Cash" Value="0"></asp:ListItem>
                                                                            <asp:ListItem Text="Cheque" Value="1" />
                                                                            <asp:ListItem Text="Credit Card" Value="2" />
                                                                            <asp:ListItem Text="NEFT/RTGS" Value="3" />
                                                                       <asp:ListItem Text="Debit Card" Value="4" />

                                                                 </asp:DropDownList>
                                                            </ItemTemplate>
                                                            <HeaderStyle Height="2px" Width="100px" HorizontalAlign="Right" />
                                                            <ItemStyle Width="120px" HorizontalAlign="Right" />
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Payment details" HeaderStyle-Font-Bold="false">
                                                            <ItemTemplate>
                                                                <asp:TextBox ID="txtAdamtPaydet" runat="server" autocomplete="off" Style="text-align: right"
                                                                    MaxLength="10" Width="120px"></asp:TextBox>
                                                            </ItemTemplate>
                                                            <HeaderStyle Height="2px" Width="100px" HorizontalAlign="Right" />
                                                            <ItemStyle Width="120px" HorizontalAlign="Right" />
                                                        </asp:TemplateField>
                                                           <asp:TemplateField HeaderText="Advance Amt" HeaderStyle-Font-Bold="false">
                                                            <ItemTemplate>
                                                                 
                                                                <asp:TextBox ID="txtAdamt" runat="server" autocomplete="off" Style="text-align: right"
                                                                    MaxLength="10" Width="120px" onchange="CorrectionAdvAmtChanged()"></asp:TextBox>
                                                                <asp:HiddenField ID="hdnAdvID" runat="server" />
                                                                <cc1:FilteredTextBoxExtender ID="fltAdvPt" runat="server" TargetControlID="txtAdamt" ValidChars="1234567890."
                                                                    FilterMode="ValidChars" Enabled="True">
                                                                </cc1:FilteredTextBoxExtender>
                                                            </ItemTemplate>
                                                            <HeaderStyle Height="2px" Width="100px" HorizontalAlign="Right" />
                                                            <ItemStyle Width="120px" HorizontalAlign="Right" />
                                                        </asp:TemplateField>
                                                        </Columns>
                                                    <FooterStyle CssClass="footerStyle3" Font-Bold="True" ForeColor="White" />
                                                    <HeaderStyle CssClass="HeaderStyle3" Font-Bold="True" ForeColor="White" Height="20px" />
                                                    <RowStyle BackColor="#F7F6F3" CssClass="RowStyle3" ForeColor="#333333" Height="25px" />
                                                    <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" Height="25px" />
                             </asp:GridView>
                                    </asp:Panel>
                                <%--<div style="border-bottom: 2px; height:10px; width: 100%; margin-top: 2px;"></div>--%>
                                <asp:Label ID="avdtot" runat="server" Text="Total Advance:" Font-Bold="true" style="padding-left:280px;"></asp:Label>
                                <asp:Label ID="AdvAmtTot" runat="server" Font-Bold="true"></asp:Label>
                                <asp:Image ID="Image1" runat="server" ImageUrl="~/Images/rupee.png" AlternateText="Rs"/>
                                            </asp:Panel>
                    </ContentTemplate>
                        </cc1:TabPanel>
            </cc1:TabContainer>
        </asp:Panel>
         </ContentTemplate>
                </asp:UpdatePanel>
    </div>

</asp:Content>
