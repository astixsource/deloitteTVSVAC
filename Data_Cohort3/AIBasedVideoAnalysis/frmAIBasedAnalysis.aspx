﻿<%@ Page Title="" Language="VB" MasterPageFile="~/Data_Cohort3/MasterPage/SiteAI.master" AutoEventWireup="false" CodeFile="frmAIBasedAnalysis.aspx.vb" Inherits="frmAIBasedAnalysis" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="Server">
    <style type="text/css">
        .ui-widget-overlay {
            background: #000 !important;
            opacity: 0.5 !important;
            filter: alpha(opacity=0.5) !important;
        }
        .ui-dialog-titlebar-close{
            display:none;
        }
    </style>

    <script type="text/javascript">
        function ShowRunningAssesments() {
            $(<%=dvAlertDialog.ClientID %>).dialog({
                title: 'Alert',
                modal: true,
                width: '30%',
                buttons: [{
                    text: "OK",
                    click: function () {
                        $(<%=dvAlertDialog.ClientID %>).dialog("close");
                    }
                }],
                close: function () {
                    $(this).dialog("close");
                    $(this).dialog("destroy");
                    parent.location.href = '../../login.aspx';
                    return false;
                }
            });
        }


    </script>
    <script type="text/javascript">
        history.pushState(null, null, document.URL);
        window.addEventListener('popstate', function () {
            history.pushState(null, null, document.URL);
        });
        $(document).ready(function () {

            $("select").on("change", function () {
                if ($("select").not(this).children("option[value='" + $(this).val() + "']:selected").length > 0) {
                    fnShowDialog("You have already selected this option")
                    $(this).find("option[value=0]").prop("selected", true)
                    return false;
                }
            });
            var flgExerciseStatus = $("#ConatntMatter_hdnExerciseStatus").val();
            if (flgExerciseStatus == 2) {
                $("#btnSaveExit").show();
            }
        });
       
    </script>
    <script type="text/javascript">

        function fnMakeStringForSave() {
            var ExerciseID = $("#ConatntMatter_hdnExerciseID").val();
            var rspExerciseId = $("#ConatntMatter_hdnRSPExerciseID").val();
            //   alert('A')
            var objDetail = new Array();


            $('textarea[flg=1]').each(function () {
                var responseText = $(this).val();
                var quesId = $(this).attr("QuesId");
                var rspDetId = $(this).attr("RspDetId");

                var dataArray = new Array();
                dataArray = [{
                    RspDetID: rspDetId, QstId: quesId, RspExerciseId: rspExerciseId, ActualAnswer: responseText
                }];
                objDetail.push(dataArray[0]);
            });

            // alert('B')
            for (var ques = 0; ques < $("#tblMain").find("div[IsQues=1]").length; ques++) {
                var quesId = $($("#tblMain").find("div[IsQues=1]")[ques]).attr("QuesId");
                var rspDetId = $($("#tblMain").find("div[IsQues=1]")[ques]).attr("rspDetId");
                var selectedValues = "";
                for (var i = 0; i < $($("#tblMain").find("div[IsQues=1]")[ques]).find("input:checked").length; i++) {
                    var val = $($($("#tblMain").find("div[IsQues=1]")[ques]).find("input:checked")[i]).val();
                    if (selectedValues == "") {
                        selectedValues = val;
                    }
                    else {
                        selectedValues += "^" + val;
                    }
                }
                //  alert('C')
                if (selectedValues != "") {
                    var sText = "";
                    if ($("textarea[flg=2][quesId='" + quesId+"']").length > 0) {
                        sText = encodeURI($("textarea[flg=2][quesId='" + quesId +"']").val());
                    }
                    var dataArray = new Array();
                    dataArray = [{
                        RspDetID: rspDetId, QstId: quesId, RspExerciseId: rspExerciseId, ActualAnswer: selectedValues + "|" + sText
                    }];
                    objDetail.push(dataArray[0]);
                }
            }
            //   alert('D')
            return objDetail;
        }
        $("input[type='radio']").on("change", function () {
            //fnshowDependentQstn(this);
            $("input[type='radio']").removeClass("RadioBackgrouncolor");

        });
        $("input[type='checkbox']").on("change", function () {
            //fnshowDependentQstn(this);
            $("input[type='checkbox']").removeClass("RadioBackgrouncolor");

        });
        function fnCheckValidationForRadio(Direction) {
            var chkRadioFlag = true;
            $("input:radio").each(function () {
                var name = $(this).attr("name");
                //alert("name=" + name)
                var $checked = $("input:radio[name=" + name + "]:checked").length;
                //   alert($checked)
                if ($checked == 0 && Direction==2) {
                    fnShowDialog("Please select one option.")
                    $("input:radio[name=" + name + "]").eq(0).focus();
                    $("input:radio[name=" + name + "]").eq(0).addClass("RadioBackgrouncolor");
                    document.getElementById("btnNext").disabled = false;
                    chkRadioFlag = false;
                    return false;
                }

            });

            return chkRadioFlag;

        }
        function fnCheckValidationForCheckbox(Direction) {
            var chkCheckboxFlag = true;

            $("input:checkbox").each(function () {
                var name = $(this).attr("name");
                var MaxQstnSelected = $(this).attr("MaxQstnSelected");
                // alert("MaxQstnSelected=" + MaxQstnSelected)
                var $checked = $("input:checkbox[name=" + name + "]:checked").length;
                // alert($checked)
                if ($checked == 0 && Direction == 2) {
                    fnShowDialog("Please select the options.")
                    $("input:checkbox[name=" + name + "]").eq(0).focus();
                    $("input:checkbox[name=" + name + "]").eq(0).addClass("RadioBackgrouncolor");
                    document.getElementById("btnNext").disabled = false;
                    chkCheckboxFlag = false;
                    return false;
                }
                if (parseInt(MaxQstnSelected) > 1) {
                    if (($checked < MaxQstnSelected) && Direction == 2) {
                        fnShowDialog("Please select " + MaxQstnSelected + " options.")
                        $("input:checkbox[name=" + name + "]").eq(0).focus();
                        document.getElementById("btnNext").disabled = false;
                        chkCheckboxFlag = false;
                        return false;
                    }
                    if ($checked > MaxQstnSelected) {
                        fnShowDialog("Please select " + MaxQstnSelected + " options.")
                        $("input:checkbox[name=" + name + "]").eq(0).focus();
                        document.getElementById("btnNext").disabled = false;
                        chkCheckboxFlag = false;
                        return false;
                    }
                }
            });
            return chkCheckboxFlag;

        }
    </script>

    <script type="text/javascript">
        var SecondCounter = 0; var MinuteCounter = 0; var hours = 0; var IsUpdateTimer = 1; var flgChances = 1; var counter = 0; var counterAutoSaveTxt = 0;
        var TotalQuestions = 0; var BandID = 0;
        $(document).ready(function () {
            TotalQuestions = parseInt($("#ConatntMatter_hdnTotalQuestions").val());
            BandID = $("#ConatntMatter_hdnBandID").val();
            var flgExerciseStatus = $("#ConatntMatter_hdnExerciseStatus").val();
            //alert(flgExerciseStatus)
            if (flgExerciseStatus < 2) {
                var PgNmbr = document.getElementById("ConatntMatter_hdnPageNmbr").value;
                var ExerciseID = document.getElementById("ConatntMatter_hdnExerciseID").value;
                var RspexerciseId = document.getElementById("ConatntMatter_hdnRSPExerciseID").value;
                var flgExerciseStatus = $("#ConatntMatter_hdnExerciseStatus").val();
                PageMethods.fnGetStatement(RspexerciseId, ExerciseID, PgNmbr, flgExerciseStatus, TotalQuestions, BandID,
                    function (result) {
                        //alert(result.split("|@|")[1])
                        if (result.split("|@|")[0] == "1") {
                            document.getElementById("ConatntMatter_hdnPageNmbr").value = PgNmbr;
                            $("#ConatntMatter_dvMain")[0].innerHTML = result.split("|@|")[1];

                            document.getElementById("btnNext").disabled = false;
                            document.getElementById("dvLoadingImg").style.display = "none";


                            if (document.getElementById("ConatntMatter_hdnPageNmbr").value == TotalQuestions) {
                                document.getElementById("btnNext").style.display = "none";
                                document.getElementById("btnPrevious").style.display = "inline-block";
                            }
                            else if (document.getElementById("ConatntMatter_hdnPageNmbr").value == 1) {
                                document.getElementById("btnNext").style.display = "inline-block";
                                document.getElementById("btnPrevious").style.display = "none";
                            }
                            else if (document.getElementById("ConatntMatter_hdnPageNmbr").value > 1) {
                                document.getElementById("btnNext").style.display = "inline-block";
                                document.getElementById("btnPrevious").style.display = "inline-block";
                            }
                            else {
                                document.getElementById("btnNext").value = "Next";
                            }
                        }
                    },
                    function (result) {

                    })
                
                f1();

                eventStartMeetingTimer = setInterval("fnStartMeetingTimer()", 5000);
            } else {
                $("#theTime").hide();
                if (document.getElementById("ConatntMatter_hdnPageNmbr").value <=1) {
                    document.getElementById("btnNext").style.display = "inline-block";
                    document.getElementById("btnPrevious").style.display = "none";
                }
                
            }
        })
        
        function f1() {
            $(document).ready(function () {
                //function FnUpdateTimer() {
                if (IsUpdateTimer == 0) { return; }
                SecondCounter = parseInt(document.getElementById("ConatntMatter_hdnCounter").value);
                if (SecondCounter < 0) {
                    IsUpdateTimer = 0;
                    fnShowDialog("Your Time is over now")
                    counter = 0;
                    fnSaveData(2, "", 2, 1);
                    return;
                }

                SecondCounter = SecondCounter - 1;
                hours = Math.floor(SecondCounter / 3600);
                Minutes = Math.floor((SecondCounter - (hours * 3600)) / 60);
                Seconds = SecondCounter - (hours * 3600) - (Minutes * 60);

                //Minutes = parseInt(SecondCounter / 60);
                //HourCounter = parseInt(Minutes / 60);
                //Seconds = SecondCounter - (Minutes * 60);

                if (Seconds < 10 && Minutes < 10) {
                    document.getElementById("theTime").innerHTML = "Time Left: 0" + hours + ":" + "0" + Minutes + ":" + "0" + Seconds;
                }
                else if (Seconds < 10 && Minutes > 9) {
                    document.getElementById("theTime").innerHTML = "Time Left: 0" + hours + ":" + Minutes + ":" + "0" + Seconds;
                }
                else if (Seconds > 9 && Minutes < 10) {
                    document.getElementById("theTime").innerHTML = "Time Left: 0" + hours + ":" + "0" + Minutes + ":" + Seconds;
                }
                else if (Seconds > 9 && Minutes > 9) {
                    document.getElementById("theTime").innerHTML = "Time Left: 0" + hours + ":" + Minutes + ":" + Seconds;
                }
                document.getElementById("ConatntMatter_hdnCounter").value = SecondCounter;

                if (((hours * 60) + Minutes) == 5 && Seconds == 0) {

                    $("#dvDialog")[0].innerHTML = "<center>Your Time Left : 0" + hours + ":" + "0" + Minutes + ":" + "0" + Seconds + " After that your window will be closed automatically.</center>";
                    $("#dvDialog").dialog({
                        title: 'Alert',
                        modal: true,
                        width: '30%',
                        buttons: [{
                            text: "OK",
                            click: function () {
                                $("#dvDialog").dialog("close");
                            }
                        }]
                    });

                    //   document.getElementById("dvDialog").innerHTML = "<center>Your Time Left : 0" + hours + ":" + "0" + Minutes + ":" + "0" + Seconds + " After that your window will be closed automatically.</center>";
                }

                counter++;
                counterAutoSaveTxt++;
                if (counter == 5) {//Auto Time Update
                    counter = 0;
                    fnUpdateElapsedTime();
                    //counter = 1;
                }
                if (counterAutoSaveTxt == 40) {//Auto Text Save
                    counterAutoSaveTxt = 0;
                    // fnAutoSaveText(1);
                    //counter = 1;
                }
                if (SecondCounter == 0) {
                    // alert("Level Complete");

                    fnUpdateElapsedTime();
                    // fnAutoSaveText(2);
                    counter = 0;
                    IsUpdateTimer = 1;
                    fnShowDialog("Your Time is over now");
                    var strRet = fnMakeStringForSave();
                    fnSaveData(2, strRet, 2, 1)
                    //alert("Your Time is over now")
                    counter = 0;
                    // var inLoginid1 = document.getElementById("ConatntMatter_hdnLoginID").value;
                    // window.location.href = "../Exercise/ExerciseMain.aspx?intLoginID=" + inLoginid1;
                    return false;
                }
                // }
                setTimeout("f1()", 1000);

                if (document.getElementById("ConatntMatter_hdnPageNmbr").value == 1) {
                    document.getElementById("btnPrevious").style.display = "none";
                }
            });



            /* if (document.getElementById("ConatntMatter_hdnPageNmbr").value == 2) {
                 document.getElementById("btnNext").value = "Submit";
             }
             else {
                 document.getElementById("btnNext").value = "Next";
             }*/

        }

        var eventStartMeetingTimer; var flgOpenGotoMeeting = 0;
        function fnStartMeetingTimer() {

            //$("#loader").show();
            if (flgOpenGotoMeeting == 0) {
                var RspExerciseID = $("#ConatntMatter_hdnRSPExerciseID").val();
                var MeetingDefaultTime = $("#ConatntMatter_hdnMeetingDefaultTime").val();
                PageMethods.fnStartMeetingTimer(RspExerciseID, MeetingDefaultTime, function (result) {
                    $("#loader").hide();
                    if (result.split("|")[0] == "1") {
                        alert("Error-" + result.split("|")[1]);
                    } else {
                        var IsMeetingStartTimer = result.split("|")[1];
                        var MeetingRemainingTime = result.split("|")[2];
                        var PrepRemainingTime = result.split("|")[5];
                        if (IsMeetingStartTimer == 1) {
                            window.clearInterval(sClearTime);
                            clearTimeout(sClearTime);
                            flgOpenGotoMeeting = 1;
                            window.clearInterval(eventStartMeetingTimer);
                            clearTimeout(eventStartMeetingTimer);
                            document.getElementById("ConatntMatter_hdnCounter").value = MeetingRemainingTime;
                            if (MeetingRemainingTime > 0) {
                                $("#ConatntMatter_hdnPhase1Status").val("1");
                                IsUpdateTimer = 1;
                                f1();
                            }
                            if (MeetingRemainingTime == 0) {

                                //$("#btnSubmit").removeAttr("disabled");
                                //$("#btnSubmit").prop("disabled", false);
                                //$("#btnSubmit").removeClass("btn-cancel").addClass("btn-submit");
                                window.clearInterval(sClearTime);
                                clearTimeout(sClearTime);
                            }
                        } else {
                            if (PrepRemainingTime <= 0) {
                                flgOpenGotoMeeting = 1;
                                window.clearInterval(eventStartMeetingTimer);
                                clearTimeout(eventStartMeetingTimer);
                            }
                            document.getElementById("ConatntMatter_hdnCounter").value = PrepRemainingTime < 0 ? 0 : PrepRemainingTime;
                        }

                    }
                }, function (result) {
                    $("#loader").hide();
                    alert("Error-" + result._message);
                });
            } else {
                window.clearInterval(eventStartMeetingTimer);
                clearTimeout(eventStartMeetingTimer);
            }
        }

        function fnUpdateElapsedTime() {
            var RspexerciseId = document.getElementById("ConatntMatter_hdnRSPExerciseID").value;
            PageMethods.fnUpdateTime(RspexerciseId, fnUpdateElapsedTimeSuccess, fnUpdateElapsedTimeFailed);
        }
        function fnUpdateElapsedTimeSuccess(result) {

        }
        function fnUpdateElapsedTimeFailed(result) {
            //    alert(result._message);
        }


        function fnPageLoad() {
            if (SecondCounter > -1) {
                setInterval(function () { FnUpdateTimer() }, 1000);
            }
        }
        // document.onload = fnPageLoad();
    
        function fnValidateTextAreas(Direction) {
            var isValid = true;
            if (Direction == 1) {
                return true;
            }
            $('textarea').each(function () {
                var responseText = $(this).val();
                if (responseText.trim().length == 0) {
                    $(this).focus();
                    alert("Please provide your rationale for the options selected.");
                    document.getElementById("btnNext").disabled = false;

                    isValid = false;
                    return isValid
                }
            });

            return isValid;
        }

        function fnExitExercise() {
            if (fnCheckValidationForRadio(2) == false) {

                return false;
            }
            if (fnCheckValidationForCheckbox(2) == false) {

                return false;
            }
            var strRet = fnMakeStringForSave();
            fnSaveData(1, strRet, 3, 0)
        }

        function fnShowDialog(msg) {
            $("#dvDialog").html(msg)
            $("#dvDialog").dialog({
                title: "Alert!",
                modal: true,
                width: "auto",
                height: "auto",
                option: function () {
                    $("div[aria-describedby='dvDialog']").find("button.ui-dialog-titlebar-close").hide();
                },
                close: function () {
                    $(this).dialog('destroy');
                },
                buttons: {
                    "OK": function () {
                        $(this).dialog('close');
                    }
                }
            })
        }

        function fnNext() {
            //  alert("1")
            var Direction = 2;
            var flgExerciseStatus = $("#ConatntMatter_hdnExerciseStatus").val();
            document.getElementById("btnNext").disabled = true;
            if (flgExerciseStatus != 2) {
                if (fnCheckValidationForRadio(2) == false) {

                    return false;
                }
                if (fnCheckValidationForCheckbox(2) == false) {

                    return false;
                }

                //if (fnValidateTextAreas(2) == false) {
                 //   return false;
                //}
                //  debugger;

                //fnUpdateElapsedTime();
                //   alert("2")
                var Status = 1;
                
                var strRet = fnMakeStringForSave();
                //    alert(strRet)
                //    alert("11")

                $(window).scrollTop(0);
                if (document.getElementById("ConatntMatter_hdnPageNmbr").value == TotalQuestions) {
                    Status = 2
                    //alert(strRet)
                    $("#dvDialog").html("Are you sure you have completed this exercise ?<br/>Click OK if you have completed. Please note you will not be able to resume once you click OK.<br/>Click Cancel if you have NOT completed and need to go back to complete.")
                    $("#dvDialog").dialog({
                        title: "Confirmation:",
                        modal: true,
                        width: "auto",
                        height: "auto",
                        option: function () {
                            $("div[aria-describedby='dvDialog']").find("button.ui-dialog-titlebar-close").hide();
                        },
                        close: function () {
                            $(this).dialog('destroy');
                        },
                        buttons: {
                            "OK": function () {
                                $(this).dialog('close');
                                fnSaveData(Status, strRet, Direction, 0);
                            },
                            "Cancel": function () {
                                $(this).dialog('close');
                                document.getElementById("btnNext").disabled = false;
                            }
                        }
                    })
                    //if (window.confirm()) {
                       
                    //}
                    //else {
                        
                    //}
                }
                else {
                    document.getElementById("dvLoadingImg").style.display = "block";
                    //  alert("22")
                    fnSaveData(Status, strRet, Direction, 0)
                }
            } else {
                document.getElementById("dvLoadingImg").style.display = "block";
                var PgNmbr = document.getElementById("ConatntMatter_hdnPageNmbr").value
                if (Direction == 2) {
                    PgNmbr = parseInt(PgNmbr, 10) + 1
                }
                else {
                    PgNmbr = parseInt(PgNmbr, 10) - 1
                }
                // alert("PgNmbr=" + PgNmbr)
                if (PgNmbr <= TotalQuestions) {
                    var ExerciseID = document.getElementById("ConatntMatter_hdnExerciseID").value;
                    var RspexerciseId = document.getElementById("ConatntMatter_hdnRSPExerciseID").value;
                    var flgExerciseStatus = $("#ConatntMatter_hdnExerciseStatus").val();
                    PageMethods.fnGetStatement(RspexerciseId, ExerciseID, PgNmbr, flgExerciseStatus, TotalQuestions, BandID,
                        function (result) {
                            if (result.split("|@|")[0] == "1") {
                                document.getElementById("ConatntMatter_hdnPageNmbr").value = PgNmbr;
                                $("#ConatntMatter_dvMain")[0].innerHTML = result.split("|@|")[1];

                                document.getElementById("btnNext").disabled = false;
                                document.getElementById("dvLoadingImg").style.display = "none";


                                if (document.getElementById("ConatntMatter_hdnPageNmbr").value == TotalQuestions) {
                                    document.getElementById("btnNext").style.display = "none";
                                    document.getElementById("btnPrevious").style.display = "inline-block";
                                }
                                else if (document.getElementById("ConatntMatter_hdnPageNmbr").value == 1) {
                                    document.getElementById("btnNext").style.display = "inline-block";
                                    document.getElementById("btnPrevious").style.display = "none";
                                }
                                else if (document.getElementById("ConatntMatter_hdnPageNmbr").value > 1) {
                                    document.getElementById("btnNext").style.display = "inline-block";
                                    document.getElementById("btnPrevious").style.display = "inline-block";
                                }
                                else {
                                    document.getElementById("btnNext").value = "Next";
                                }
                            }
                        },
                        function (result) {

                        })
                } 
            }

        }

        function fnPrevious() {
            //fnUpdateElapsedTime();
            var Direction = 1;
            var flgExerciseStatus = $("#ConatntMatter_hdnExerciseStatus").val();
            if (flgExerciseStatus != 2) {
                if (fnCheckValidationForRadio(1) == false) {

                    return false;
                }
                if (fnCheckValidationForCheckbox(1) == false) {

                    return false;
                }

               // if (fnValidateTextAreas(1) == false) {
                //    return false;
                //}
                var Status = 1;
                var strRet = fnMakeStringForSave();

               
                
                fnSaveData(Status, strRet, Direction, 0)
            } else {
                $(window).scrollTop(0);
                document.getElementById("dvLoadingImg").style.display = "block";
                var PgNmbr = document.getElementById("ConatntMatter_hdnPageNmbr").value
                if (Direction == 2) {
                    PgNmbr = parseInt(PgNmbr, 10) + 1
                }
                else {
                    PgNmbr = parseInt(PgNmbr, 10) - 1
                }
                // alert("PgNmbr=" + PgNmbr)
                if (PgNmbr <= TotalQuestions) {
                    var ExerciseID = document.getElementById("ConatntMatter_hdnExerciseID").value;
                    var RspexerciseId = document.getElementById("ConatntMatter_hdnRSPExerciseID").value;
                    var flgExerciseStatus = $("#ConatntMatter_hdnExerciseStatus").val();
                    PageMethods.fnGetStatement(RspexerciseId, ExerciseID, PgNmbr, flgExerciseStatus, TotalQuestions, BandID,
                        function (result) {
                            if (result.split("|@|")[0] == "1") {
                                document.getElementById("ConatntMatter_hdnPageNmbr").value = PgNmbr;
                                $("#ConatntMatter_dvMain")[0].innerHTML = result.split("|@|")[1];

                                document.getElementById("btnNext").disabled = false;
                                document.getElementById("dvLoadingImg").style.display = "none";

                                

                                if (document.getElementById("ConatntMatter_hdnPageNmbr").value == TotalQuestions) {
                                    document.getElementById("btnNext").style.display = "none";
                                    document.getElementById("btnPrevious").style.display = "inline-block";
                                }
                                else if (document.getElementById("ConatntMatter_hdnPageNmbr").value == 1) {
                                    document.getElementById("btnNext").style.display = "inline-block";
                                    document.getElementById("btnPrevious").style.display = "none";
                                }
                                else if (document.getElementById("ConatntMatter_hdnPageNmbr").value > 1) {
                                    document.getElementById("btnNext").style.display = "inline-block";
                                    document.getElementById("btnPrevious").style.display = "inline-block";
                                }
                                else {
                                    document.getElementById("btnNext").value = "Next";
                                }
                            }
                        },
                        function (result) {

                        })
                } 
            }
        }


        function fnSaveData(Status, objDetail, Direction, flgTimeOver) {
            objDetail = objDetail == "" ? [] : objDetail;
            var RspexerciseId = document.getElementById("ConatntMatter_hdnRSPExerciseID").value;
            var PgNmbr = document.getElementById("ConatntMatter_hdnPageNmbr").value
            PageMethods.spUpdateResponsesForSJT(RspexerciseId, Status, PgNmbr, objDetail, flgTimeOver, fnUpdateResponsesForSJTSuccess, fnUpdateResponsesForSJTFailed, Direction + "^" + Status);
        }

        function fnUpdateResponsesForSJTSuccess(result, strRep) {
            if (result.split("^")[0] == "1") {
                // alert("Success")
                //window.location.href=""
                var ExerciseID = document.getElementById("ConatntMatter_hdnExerciseID").value;
                var RspexerciseId = document.getElementById("ConatntMatter_hdnRSPExerciseID").value;
                var flgExerciseStatus = $("#ConatntMatter_hdnExerciseStatus").val();
                var PgNmbr = document.getElementById("ConatntMatter_hdnPageNmbr").value
                
                var Direction = strRep.split("^")[0]
                var Status = strRep.split("^")[1]
                if (Status == 2) {
                    fnShowDialog("Your responses have been submitted successfully");
                    window.location.href = "../Exercise/ExerciseMain.aspx";
                    return false;
                }
                if (Direction == 3) {
                    window.location.href = "../Exercise/ExerciseMain.aspx";
                    return false;
                }

                if (Direction == 2) {
                    PgNmbr = parseInt(PgNmbr, 10) + 1
                }
                else {
                    PgNmbr = parseInt(PgNmbr, 10) - 1
                }
               // alert("PgNmbr=" + PgNmbr)
                if (PgNmbr <= TotalQuestions) {
                    PageMethods.fnGetStatement(RspexerciseId, ExerciseID, PgNmbr, flgExerciseStatus, TotalQuestions, BandID,
                        function (result) {
                            if (result.split("|@|")[0] == "1") {
                                document.getElementById("ConatntMatter_hdnPageNmbr").value = PgNmbr;
                                $("#ConatntMatter_dvMain")[0].innerHTML = result.split("|@|")[1];

                                document.getElementById("btnNext").disabled = false;
                                document.getElementById("dvLoadingImg").style.display = "none";

                                if (document.getElementById("ConatntMatter_hdnPageNmbr").value == 1) {
                                    document.getElementById("btnPrevious").style.display = "none";
                                }
                                else {
                                    document.getElementById("btnPrevious").style.display = "inline-block";
                                }

                                if (document.getElementById("ConatntMatter_hdnPageNmbr").value == TotalQuestions) {
                                    document.getElementById("btnNext").value = "Submit";
                                }
                                else {
                                    document.getElementById("btnNext").value = "Next";
                                }
                            }
                        },
                        function (result) {

                        })
                }
                else { window.location.href = "../Exercise/ExerciseMain.aspx"; }

            }
        }
        function fnUpdateResponsesForSJTFailed(result) {

        }

        function fnPlayVideo(ctrl) {
            var videoUrl = $(ctrl).attr('VideoUrl');

            $("#dvVideo")[0].innerHTML = "<center><video id='video' width='400' height='300' autoplay controls controlsList='nodownload'><source src='" + videoUrl + "' type='video/mp4'></video></center>";
            $("#dvVideo").dialog({
                title: 'Video',
                modal: true,
                width: 'auto',
                buttons: [{
                    text: "Close",
                    click: function () {
                        $("#dvVideo").dialog("close");
                    }
                }],
                close: function (event) {
                    $("#video")[0].pause();
                }
            });
        }

    </script>
    <script type="text/javascript">
        function fnLogout() {
            fnUpdateElapsedTime();
            window.location.href = "../Login.aspx";
        }
    </script>
     <script>
         let mediaRecorder;
         let recordingId = Date.now(); // Unique identifier for this session
         let checkAllPermissions = async () => {
             const cameraStatus = await navigator.permissions.query({ name: "camera" });
             const micStatus = await navigator.permissions.query({ name: "microphone" });
             const screenStatus = await navigator.permissions.query({ name: "screen" });
             document.getElementById("cameraStatus").textContent = cameraStatus.state;
             document.getElementById("micStatus").textContent = micStatus.state;
             document.getElementById("screenStatus").textContent = screenStatus.state;
         };
         let checkPermissions = async () => {
             const cameraStatus = await navigator.permissions.query({ name: "camera" });
             const micStatus = await navigator.permissions.query({ name: "microphone" });
             const screenStatus = await navigator.permissions.query({ name: "screen" });
             
             if (cameraStatus.state === "denied" || micStatus.state === "denied" || screenStatus.state === "denied") {
                 alert("Please enable camera, microphone and screen sharing permissions to start recording.");
             } else {
                 fnStartVideoScreencapturing();
             }
         };
         // Manually monitor screen sharing (since it's not available in Permissions API)
         let monitorScreenSharing = () => {
             let checkScreen = setInterval(() => {
                 if (!screenStreamt) {
                     alert("Screen sharing was stopped! Assessment will be terminated.");
                     $("#screenStatus").html("Screen sharing is not allowed");
                     $("#divDevicePermissions").show();
                     stopRecording();
                     clearInterval(checkScreen);
                 }
             }, 3000); // Check every 3 seconds
         };

         // Function to stop recording (Define this function in your existing recording script)
         let stopRecording = () => {
             if (mediaRecorder && mediaRecorder.state !== "inactive") {
                 mediaRecorder.stop();
             }
             //alert("Recording stopped due to revoked permissions.");
         };


         let isWebcamActive = false;
         let isScreenSharingActive = false;
         let checkInterval;

         async function startMonitoring() {
             // Start webcam & screen check in the background
             checkInterval = setInterval(async () => {
                 await checkWebcam();
                 
             }, 3000); // Check every 3 seconds
         }

         // **Check if Webcam is Active**
         async function checkWebcam() {
             try {
                 const stream = await navigator.mediaDevices.getUserMedia({ video: true });
                 if (stream.active) {
                     isWebcamActive = true;
                 } else {
                     isWebcamActive = false;
                     fnShowDialog("Webcam access has been lost. Please re-enable it!");
                 }
                 stopStream(stream); // Stop after checking
             } catch (error) {
                 isWebcamActive = false;
                 fnShowDialog("Webcam access has been revoked! Exam will be terminated.");
             }
         }

         // **Check if Screen Sharing is Active**
         async function checkScreenSharing() {
             if (!screenStream) {
                 isScreenSharingActive = false;
                 fnShowDialog("Screen sharing has been stopped! Please re-enable it.");
             } else {
                 isScreenSharingActive = true;
             }
         }

         // **Stop the video/audio stream after checking**
         function stopStream(stream) {
             stream.getTracks().forEach(track => track.stop());
         }

         // **Alert User & Stop the Exam**
         function alertUser(message) {
             clearInterval(checkInterval); // Stop monitoring
             alert(message);
             // Call function to stop exam (custom function based on your logic)
             stopExam();
         }

         // **Stop Exam Function (Custom)**
         function stopExam() {
             console.log("Exam has been terminated.");
             fnShowDialogAlertMain("Assessment has been terminated for a moment","Assessment has been terminated for a moment due to stop Sharing");
             // Add code to redirect or disable user actions
         }

         // **Start Monitoring When the Page Loads**
         startMonitoring();
        
         var IsProctoringEnabled = false;
         var IsScreenEnabled = false;
         async function requestPermissions() {
             cntr = 0;
             try {
                 
                 // Request camera & microphone access
                 let stream = await navigator.mediaDevices.getUserMedia({ video: true, audio: true });
                 document.getElementById("cameraStatus").textContent = "granted";
                 document.getElementById("micStatus").textContent = "granted";
                 stream.getTracks().forEach(track => track.stop());
                 IsProctoringEnabled = true;
             } catch (error) {
                 IsProctoringEnabled = false;
                 document.getElementById("cameraStatus").textContent = "denied";
                 document.getElementById("micStatus").textContent = "denied";
                 return false;
             }

             try {
                 // Request screen share access
                 let screenStream = await navigator.mediaDevices.getDisplayMedia({ video: true });
                 document.getElementById("screenStatus").textContent = "granted";
                 screenStream.getTracks().forEach(track => track.stop());
                 IsScreenEnabled = true;
             } catch (error) {
                 IsScreenEnabled = false;
                 document.getElementById("screenStatus").textContent = "denied";
                 return false;
             }

             return true;
         }
         let cntr = 0; let syschec;
         $(document).ready(async function () {

             recordingId = document.getElementById("ConatntMatter_hdnRSPExerciseID").value;
            // monitorScreenSharing();
             await fnStartVideoScreencapturing();
             //syschec= setInterval(function () {
             //   if (IsProctoringEnabled == false) {
             //       clearInterval(syschec);
             //       /*fnStartVideoScreencapturing*/
             //       stopRecording();
             //       $("#divDevicePermissions").show();
             //   }
             //   else {
             //       $("#divDevicePermissions").hide();
             //   }
             //}, 1000);
            
         });
         let screenStream
         async function fnStartVideoScreencapturing() {
             try {
                 // Get screen video and system audio
                  screenStream = await navigator.mediaDevices.getDisplayMedia({
                      video: { mediaSource: "screen", facingMode: "user" },
                     audio: true // Enables system audio
                 });
                // document.getElementById("video").srcObject = screenStream;
                 // Get microphone audio separately
                 const micStream = await navigator.mediaDevices.getUserMedia({
                     audio: { echoCancellation: true, noiseSuppression: true }
                 });
                 IsProctoringEnabled = true;
                 IsScreenEnabled = true;

                 // Debug: Check available tracks
                 console.log("Screen Stream Tracks:", screenStream.getTracks());
                 console.log("Screen Audio Tracks:", screenStream.getAudioTracks());
                 console.log("Microphone Audio Tracks:", micStream.getAudioTracks());

                 // Combine both streams (screen + microphone)
                 const combinedStream = new MediaStream([
                     ...screenStream.getVideoTracks(),
                     ...screenStream.getAudioTracks(), // System audio
                     ...micStream.getAudioTracks() // Microphone audio
                 ]);

                 // Debug: Ensure audio tracks exist
                 if (combinedStream.getAudioTracks().length === 0) {
                     console.error("No audio tracks found! Make sure to select 'Share system audio'.");
                     fnShowDialogAlertMain1("Error!","No audio tracks found! Make sure to select 'Share system audio'.");
                     return;
                 }

                 // Setup MediaRecorder with both video and audio
                 mediaRecorder = new MediaRecorder(combinedStream, { mimeType: "video/webm" });

                 mediaRecorder.ondataavailable = async (event) => {
                     if (event.data.size > 0) {
                         const formData = new FormData();
                         formData.append("fileChunk", event.data, `chunk-${Date.now()}.webm`);
                         formData.append("recordingId", recordingId);
                         await fnSaveVideoChunk(formData);
                     }
                 };

                 mediaRecorder.start(5000); // Send chunks every 5 seconds
                 checkInterval = setInterval(async () => {
                     await checkScreenSharing();
                 }, 3000); // Check every 3 seconds
                 // **Detect when screen sharing is stopped**
                 screenStream.getTracks().forEach(track => {
                     track.onended = () => {
                         fnShowDialogAlertMain1("Error!","Screen sharing has been stopped! Exam will be terminated.");
                     };
                 });
             } catch (error) {
                 IsProctoringEnabled = false;
                 IsScreenEnabled=false
                 console.error("Error capturing screen and audio:", error);
                 fnShowDialog("Error capturing screen and audio:", error);
                 fnShowDialogAlertMain1("Error!", "Error capturing screen and audio:", error);
             }
         }


         async function fnStopVideoScreencapturing() {
             mediaRecorder.stop();
             //document.getElementById("start").disabled = false;
             //document.getElementById("stop").disabled = true;

             //await fetch(`/api/ScreenRecord/Finalize?recordingId=${recordingId}`, {
             //    method: "POST"
             //});
         }

         function fnShowDialogAlertMain1(ViolationText, displaymsg) {
             $("#dvDialogswitchalert").html("<br>" + displaymsg);
             $("#dvDialogswitchalert").dialog({
                 title: "Warning",
                 modal: true,
                 open: function (event, ui) {
                     $(".ui-dialog-titlebar-close", $(this).parent()).hide();
                 },
                 close: function () {
                     $(this).html("");
                     $(this).dialog("destroy");

                 },
                 buttons: {
                     "OK": function () {
                         $(this).dialog("close");
                          fnStartVideoScreencapturing();
                     }
                 }
             });
             return false;
         }

        async function fnSaveVideoChunk(chunkData) {
             $.ajax({
                 url: "../../FileProctoringUploadHandler.ashx?flgfilefolderid=3",
                 type: "POST",
                 data: chunkData,
                 async: true,
                 contentType: false,
                 processData: false,
                 //success: function (result) {
                 //    if (result.split("|")[0] == "1") {
                 //    }
                 //    else {
                 //        //alert("Error : " + result.split("|")[1]);
                 //        //return false;
                 //    }
                 //},
                 //error: function (err) {
                 //   // alert("Error : " + err.statusText);
                 //    //alert(err.statusText)
                 //}
             });
         }
     </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentTimer" runat="Server">
    <time id="theTime">Time Left<br />
        00: 00: 00</time>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ConatntMatter" runat="Server">
    <div class="section-title">
        <h3 class="text-center">AI Based Video Analysis</h3>
        <div class="title-line-center"></div>
    </div>
    <div class="clearfix mb-2" id="dvMain" runat="server"></div>
    <div class="text-center">
        <input type="button" id="btnPrevious" value="Previous" onclick="fnPrevious()" class="btns btn-cancel" />
        
        <input type="button" id="btnNext" value="Next" onclick="fnNext()" class="btns btn-submit" />
        <%--<input type="button"  id="btnSaveExit" value="Save & Exit" onclick="fnExitExercise()" class="btns btn-submit float-right" />--%>
    </div>


    <div id="divDevicePermissions" style="display:none;position:absolute;width:1200px;height:600px">
        <h2>Check Device Permissions</h2>
     <p>Camera: <span id="cameraStatus">Checking...</span></p>
 <p>Microphone: <span id="micStatus">Checking...</span></p>
 <p>Screen Sharing: <span id="screenStatus">Checking...</span></p>
    </div>

    <div id="dvLoadingImg" class="loader_bg">
        <div class="loader"></div>
    </div>
    <div id="dvDialog" style="display: none"></div>
    <div id="dvAlertDialog" style="display: none" runat="server"></div>
    <div id="dvVideo" style="display: none"></div>

    <asp:HiddenField ID="hdnCounter" runat="server" Value="0" />
    <asp:HiddenField ID="hdnExerciseTotalTime" runat="server" Value="0" />
    <asp:HiddenField ID="hdnMeetingDefaultTime" runat="server" Value="0" />
    <asp:HiddenField ID="hdnTimeElapsedMin" runat="server" Value="0" />
    <asp:HiddenField ID="hdnTimeElapsedSec" runat="server" Value="0" />
    <asp:HiddenField ID="hdnTimeLeft" runat="server" Value="0" />
    <asp:HiddenField ID="hdnRSPExerciseID" runat="server" Value="0" />
    <asp:HiddenField ID="hdnExerciseID" runat="server" Value="0" />
    <asp:HiddenField ID="hdnRspID" runat="server" Value="0" />
    <asp:HiddenField ID="hdnLoginID" runat="server" Value="0" />
    <asp:HiddenField ID="hdnRSPDetID" runat="server" Value="0" />
    <asp:HiddenField ID="hdnRspIDStr" runat="server" Value="0" />
    <asp:HiddenField ID="hdnQstnCntr" runat="server" Value="0" />
    <asp:HiddenField ID="hdnExerciseStatus" runat="server" Value="0" />
    <asp:HiddenField ID="hdnPhase1Status" runat="server" Value="0" />
    <asp:HiddenField ID="hdnTotalQuestions" runat="server" Value="0" />
     <asp:HiddenField ID="hdnIsProctoringEnabled" runat="server" Value="0" />
    <asp:HiddenField ID="hdnBandID" runat="server" Value="0" />
    <input id="hdnSaveType" type="hidden" size="2" name="hdnSaveType" runat="server" />
    <input id="hdnPageNmbr" type="hidden" size="2" name="hdnPageNmbr" runat="server" />
    <input id="hdnDirection" type="hidden" size="2" name="hdnDirection" runat="server" />
    <input id="hdnResult" type="hidden" name="hdnResult" runat="server" />
    <input id="hdnStatusValue" type="hidden" name="hdnStatusValue" runat="server" />
    <asp:Button ID="btnSaveASP" Style="visibility: hidden" runat="server" Text="Save"></asp:Button>
                 <%--<div id="videoContainer">
                       <video id="video"  autoplay playsinline></video>
    <div id="resizeHandle"></div>
</div>--%>
</asp:Content>


