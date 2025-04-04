﻿<%@ Page Title="" Language="VB" MasterPageFile="~/Data_Cohort2/MasterPage/Site.master" AutoEventWireup="false" CodeFile="CaseStudy_Business2.aspx.vb" Inherits="CaseStudy" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="Server">
    <script src="../../Scripts/webcamV5Main.js"></script>
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
        function fnExitExercise() {
            window.location.href = "../Exercise/ExerciseMain.aspx";
        }

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
                    if ($("textarea[flg=2][quesId='" + quesId + "']").length > 0) {
                        sText = encodeURI($("textarea[flg=2][quesId='" + quesId + "']").val());
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
                if ($checked == 0 && Direction == 2) {
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

                f1();

                eventStartMeetingTimer = setInterval("fnStartMeetingTimer()", 5000);
            } else {
                $("#theTime").hide();
                if (document.getElementById("ConatntMatter_hdnPageNmbr").value <= 1) {
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
                    // window.location.href = "../Main/frmExerciseMain.aspx?intLoginID=" + inLoginid1;
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
                            if (result.split("@")[0] == "1") {
                                document.getElementById("ConatntMatter_hdnPageNmbr").value = PgNmbr;
                                $("#ConatntMatter_dvMain")[0].innerHTML = result.split("@")[1];

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
                            if (result.split("@")[0] == "1") {
                                document.getElementById("ConatntMatter_hdnPageNmbr").value = PgNmbr;
                                $("#ConatntMatter_dvMain")[0].innerHTML = result.split("@")[1];

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
                            if (result.split("@")[0] == "1") {
                                document.getElementById("ConatntMatter_hdnPageNmbr").value = PgNmbr;
                                $("#ConatntMatter_dvMain")[0].innerHTML = result.split("@")[1];

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

        function fnCaseExercise() {
            window.location.href = "CaseStudyInstructions_Business2.aspx?RspID=" + $("#ConatntMatter_hdnRspID").val() + "&ExerciseID=" + $("#ConatntMatter_hdnExerciseID").val() + "&intLoginID=" + $("#ConatntMatter_hdnLoginID").val();
            //$("#divCaseStudy").dialog({
            //    title: 'Case Study ',
            //    modal: true,
            //    width: '80%',
            //    height: '500',
            //    buttons: [{
            //        text: "Close",
            //        click: function () {
            //            $("#divCaseStudy").dialog("close");
            //        }
            //    }],
            //    close: function (event) {
            //        $("#divCaseStudy").dialog("destroy");
            //    }
            //});
        }
    </script>
    <script type="text/javascript">
        function fnLogout() {
            fnUpdateElapsedTime();
            window.location.href = "../Login.aspx";
        }
    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentTimer" runat="Server">
    <time id="theTime">Time Left<br />
        00: 00: 00</time>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ConatntMatter" runat="Server">
    <div class="section-title">
        <h3 class="text-center">Business Case Study</h3>
        <div class="title-line-center"></div>
    </div>
    <div class="clearfix mb-2" id="dvMain" runat="server"></div>
    <div class="text-center">
        <input type="button" id="btnPrevious" value="Previous" onclick="fnPrevious()" class="btns btn-cancel" />
        
        <input type="button" id="btnNext" value="Next" onclick="fnNext()" class="btns btn-submit" />
        <input type="button" style="display: None" id="btnSaveExit" value="Exit" onclick="fnExitExercise()" class="btns btn-submit" />
        <input type="button" style="float:right" id="btnCaseStudy" value="Go to Case Study" onclick="fnCaseExercise()" class="btns btn-submit" />
    </div>

    <div id="dvLoadingImg" class="loader_bg">
        <div class="loader"></div>
    </div>
    <div id="dvDialog" style="display: none"></div>
    <div id="dvAlertDialog" style="display: none" runat="server"></div>
    <div id="dvVideo" style="display: none"></div>

    <div id="divCaseStudy"  style="display: none">
         <div class="section-title">
        <h3 class="text-center">Instructions for Participants</h3>
        <div class="title-line-center"></div>
    </div>
       <div class="row">
        <%--  <div class="col-md-4">
            <div class="about-img-one">
                <img src="../../Images/instruction.jpg" />
            </div>
        </div>--%>
        <div class="col-md-12">
            <div class="info-about mt-2">
                <p>
                    In the following case study, you will be presented with a scenario related to a fictitious organization. Your 
                  task is to read through the case study carefully, paying attention to the challenges faced by the 
organization. Based on the details provided in the case study, you will be asked to select the most 
appropriate course of action for addressing the identified issues.
                </p>

                <div class="section-title">
        <h3 class="text-center">Case Study</h3>
        <div class="title-line-center"></div>
    </div>

                <h4 class="text-decoration-underline fw-bold">Background:</h4>
                <p>
                    AutoMax Motors, a leading automotive dealership, is facing challenges in its service business, which is 
crucial to retaining customers and driving consistent revenue growth across its multi-territory operations. 
Despite the company’s solid sales performance, the service department has been struggling to keep pace. 
Customer satisfaction levels have been steadily declining, particularly after the warranty period expires, 
and many customers are opting for competitors' service providers after their free service period ends, 
leading to significant revenue loss. Customer retention and loyalty have become a major concern, with a 
noticeable decline in post-warranty repeat business. In addition, upselling of value-added services such 
as extended warranties, maintenance plans, and premium diagnostics has not been effectively integrated 
into service processes, further limiting revenue opportunities.
                </p>
                <p>
                    Operational inefficiencies are increasing across AutoMax’s service centers. Some locations experience 
delays due to understaffing, while others face overcapacity due to poor resource allocation and inaccurate 
demand forecasting. The absence of an automated inventory management system causes delays in spare 
parts procurement and diagnostics, which results in prolonged service times. Inconsistent job card 
systems and manual scheduling processes also cause administrative errors, contributing to poor 
turnaround times. Many service advisors and technicians rely on paper-based systems, causing 
miscommunication, delays in tracking work, and an overall lack of coordination between service staff.
                </p>

                <p>
                    Despite efforts to enhance digital capabilities, resistance to digital transformation continues to be a 
challenge across various territories. While some territories have successfully adopted cloud-based 
solutions for scheduling and tracking services, others have been slow to transition from legacy systems, 
resulting in operational inconsistency across locations. The company has yet to implement a centralized 
Customer Relationship Management (CRM) system, leaving customer feedback, service history, and 
follow-up tasks unmanaged. This lack of integration prevents service teams from providing personalized 
follow-ups and tracking customer needs and preferences over time, hindering efforts to retain customers 
after their warranty period expires.
                </p>
                <p>
                    In addition to operational inefficiencies, there is a significant gap in workforce capabilities. Employee 
turnover, particularly among technicians and service advisors, has been high due to inadequate training 
programs, poor career development opportunities, and limited employee engagement initiatives. The 
service advisors often lack the necessary skills to handle customer complaints effectively and upsell 
service packages. Furthermore, there is no performance tracking or incentive structure in place to 
motivate the staff. As a result, service advisors primarily focus on routine tasks rather than promoting 
high-margin services or improving the customer experience. Additionally, the lack of clear career 
progression paths has resulted in lower employee morale, contributing to the high turnover rate.
                </p>

                <p>
                    The growing competition from independent multi-brand service centers, third-party service providers, 
and emerging mobile service startups offering doorstep servicing is increasing the pressure on AutoMax 
Motors' service department. Competitors are leveraging technology to offer transparent pricing, faster 
turnarounds, and convenient service booking through user-friendly apps, which are attracting a growing 
number of price-sensitive customers. AutoMax Motors’ service centers are struggling to provide similar
convenience and competitive pricing, making it difficult to retain existing customers and attract new ones.
                </p>

                <p>
                    Furthermore, the marketing efforts to increase customer visits have been successful in bringing more 
customers to the service centers, but the lack of streamlined service operations and capacity planning is 
preventing these visits from translating into long-term relationships. Without a structured plan to improve 
service quality, address customer concerns, and enhance overall operational efficiency, the service 
department's performance continues to underperform relative to other industry players.
                </p>

                <p>
                    Senior leadership expects a measurable increase in service revenue and customer retention within a year, 
but large-scale investments are not feasible. The challenge lies in implementing cost-effective, strategic 
changes that will result in tangible improvements across all territories under your management.
                </p>
                <p>
                    As an Area Manager (AM), responsible for overseeing multiple service territories, your role requires close 
coordination with Territory Managers (TMs) to ensure alignment with business objectives and the 
successful implementation of strategies that improve service business outcomes while maintaining 
operational excellence.
                </p>


            </div>
        </div>
    </div>

    </div>

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

</asp:Content>


