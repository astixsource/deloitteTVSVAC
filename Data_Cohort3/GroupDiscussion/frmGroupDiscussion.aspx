<%@ Page Title="" Language="VB" MasterPageFile="~/Data_Cohort3/MasterPage/Site.master" AutoEventWireup="false" CodeFile="frmGroupDiscussion.aspx.vb" Inherits="frmGroupDiscussion" %>


<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="Server">
    <style type="text/css">
        .ui-dialog .ui-dialog-content {
            overflow-x: hidden !important;
        }
    </style>
    <%--<link href="../../CSS/jquery-ui.css" rel="stylesheet" />
    <script src="../../Scripts/jquery-ui.js"></script>--%>
    <script type="text/javascript">
        $(document).ready(function () {
            $("#li_5").hide();
        });
    </script>


    <script type="text/javascript">
        history.pushState(null, null, document.URL);
        window.addEventListener('popstate', function () {
            history.pushState(null, null, document.URL);
        });
        var SecondCounter = 0; var MinuteCounter = 0; var hours = 0; var IsUpdateTimer = 1; var flgChances = 1; var counter = 0; var counterAutoSaveTxt = 0;
        var TimerText = "Preparation Time Left : ";
        var isPrepTimeFinished = 1;
        f1();

        function f1() {
            $(document).ready(function () {
                var LngID = $("#hdnLngID").val();
                if (IsUpdateTimer == 1) {
                    if (parseInt(document.getElementById("ConatntMatter_hdnCounter").value) == 0 && parseInt(document.getElementById("ConatntMatter_hdnCounterRunTime").value) == 0) {

                        TimerText = "Discussion Time Left : ";
                        flgOpenGotoMeeting = 1;
                        isPrepTimeFinished = 0;
                        IsUpdateTimer = 0;
                        document.getElementById("theTime").innerHTML = TimerText + ":00:00:00";
                        window.clearInterval(sClearTime);
                        clearTimeout(sClearTime);
                        window.clearInterval(eventStartMeetingTimer);
                        clearTimeout(eventStartMeetingTimer);
                        alert("Your discussion time is over, Kindly click on 'Close Exercise' button to complete your exercise");
                        $("#btnSubmit").attr("disabled", false);
                        return false;
                    } else if (parseInt(document.getElementById("ConatntMatter_hdnCounter").value) == 0 && parseInt(document.getElementById("ConatntMatter_hdnCounterRunTime").value) > 0) {

                        TimerText = "Discussion Time Left : ";
                        document.getElementById("theTime").innerHTML = TimerText + ":00:00:00";
                        isPrepTimeFinished = 0;
                        IsUpdateTimer = 0;
                        window.clearInterval(sClearTime);
                        clearTimeout(sClearTime);
                        document.getElementById("ConatntMatter_hdnCounter").value = document.getElementById("ConatntMatter_hdnCounterRunTime").value;
                        document.getElementById("ConatntMatter_hdnCounterRunTime").value = 0;
                        fnUpdateActualStartEndTime(1, 2);
                        alert("Your preparation time is over. Please join the Microsoft teams invite to have a discussion with Assessor");
                       // fnGoToMeeting();
                        //eventStartMeetingTimer = setInterval("fnStartMeetingTimer()", 3000);
                        return false;
                    }
                }
                if (IsUpdateTimer == 0) { return; }
                SecondCounter = parseInt(document.getElementById("ConatntMatter_hdnCounter").value);
                if (SecondCounter <= 0) {
                    IsUpdateTimer = 0;
                    counter = 0;
                    return;
                }
                SecondCounter = SecondCounter - 1;
                hours = Math.floor(SecondCounter / 3600);
                Minutes = Math.floor((SecondCounter - (hours * 3600)) / 60);
                Seconds = SecondCounter - (hours * 3600) - (Minutes * 60);

                if (Seconds < 10 && Minutes < 10) {
                    document.getElementById("theTime").innerHTML = TimerText + ":0" + hours + ":" + "0" + Minutes + ":" + "0" + Seconds;
                }
                else if (Seconds < 10 && Minutes > 9) {
                    document.getElementById("theTime").innerHTML = TimerText + ":0" + hours + ":" + Minutes + ":" + "0" + Seconds;
                }
                else if (Seconds > 9 && Minutes < 10) {
                    document.getElementById("theTime").innerHTML = TimerText + ":0" + hours + ":" + "0" + Minutes + ":" + Seconds;
                }
                else if (Seconds > 9 && Minutes > 9) {
                    document.getElementById("theTime").innerHTML = TimerText + ":0" + hours + ":" + Minutes + ":" + Seconds;
                }
                document.getElementById("ConatntMatter_hdnCounter").value = SecondCounter;

                if (((hours * 60) + Minutes) == 5 && Seconds == 0) {
                    //  alert("hi")
                    $("#dvDialog")[0].innerHTML = "<center>Your Time Left : 0" + hours + ":" + "0" + Minutes + ":" + "0" + Seconds + " .</center>";
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
                }
                counter++;
                if (counter == 10) {//Auto Time Update
                    counter = 0;
                    fnUpdateElapsedTime();
                }

                if (SecondCounter == 0) {
                    if (parseInt(document.getElementById("ConatntMatter_hdnCounter").value) == 0 && parseInt(document.getElementById("ConatntMatter_hdnCounterRunTime").value) > 0) {
                        document.getElementById("ConatntMatter_hdnCounter").value = document.getElementById("ConatntMatter_hdnCounterRunTime").value;
                        document.getElementById("ConatntMatter_hdnCounterRunTime").value = 0;

                        TimerText = "Discussion Time Left : ";
                        document.getElementById("theTime").innerHTML = TimerText + ":00:00:00";
                        IsUpdateTimer = 0;
                        isPrepTimeFinished = 0;
                        fnUpdateElapsedTime();
                        fnUpdateActualStartEndTime(1, 2);

                        alert("Your preparation time is over. Please join the Microsoft teams invite to have a discussion with Assessor");
                        //fnGoToMeeting();
                        // eventStartMeetingTimer = setInterval("fnStartMeetingTimer()", 3000);
                        counter = 0;
                        return false;
                    } else if (parseInt(document.getElementById("ConatntMatter_hdnCounter").value) == 0 && parseInt(document.getElementById("ConatntMatter_hdnCounterRunTime").value) == 0) {
                        flgOpenGotoMeeting = 1;
                        window.clearInterval(sClearTime);
                        clearTimeout(sClearTime);
                        window.clearInterval(eventStartMeetingTimer);
                        clearTimeout(eventStartMeetingTimer);
                        document.getElementById("theTime").innerHTML = TimerText + ":00:00:00";
                        alert("Your discussion time is over, Kindly click on 'Close Exercise' button to complete your exercise");
                        fnUpdateElapsedTime();
                        $("#btnSubmit").attr("disabled", false);
                        return false;
                    }
                    else {
                        IsUpdateTimer = 0;
                        counter = 0;
                        fnUpdateElapsedTime();
                        return false;
                    }
                }
                sClearTime = setTimeout("f1()", 1000);
            });
        }
        var sClearTime;
        function fnUpdateElapsedTime() {
            var RspexerciseId = document.getElementById("ConatntMatter_hdnRSPExerciseID").value;
            var TotTimeElapsedSec = document.getElementById("ConatntMatter_hdnTimeElapsedSec").value
            PageMethods.fnUpdateTime(RspexerciseId, TotTimeElapsedSec, fnUpdateElapsedTimeSuccess, fnUpdateElapsedTimeFailed);
        }
        function fnUpdateElapsedTimeSuccess(result) {

        }
        function fnUpdateElapsedTimeFailed(result) {
            //    alert(result._message);
        }
        function fnGoToMeeting() {

            if (isPrepTimeFinished == "1") {

                alert("You have more preparation time left. You can click on Start Meeting upon completion of your pre defined preparation time")
                return false;
            }

            fnUpdateActualStartEndTime(1, 3);
            isPrepTimeFinished = 0;

            TimerText = "Discussion Time Left : ";
            document.getElementById("theTime").innerHTML = TimerText + ":00:00:00";
            IsUpdateTimer = 0;
            // eventStartMeetingTimer = setInterval("fnStartMeetingTimer()", 3000);
            var MeetingURL = document.getElementById("ConatntMatter_hdnGoToMeetingURL").value;
            //window.open(MeetingURL);
            $("#btnSubmit").attr("disabled", false);
        }

        function fnSubmit() {
            var ExerciseID = $("#ConatntMatter_hdnExerciseID").val();
            var RspExerciseId = $("#ConatntMatter_hdnRSPExerciseID").val();
            $("#dvDialog").html("Are you sure you have completed this exercise ?<br />Click OK if you have completed. <br />Click Cancel if you have NOT completed and join Microsoft teams to start your meeting.");
            $("#dvDialog").dialog({
                modal: true,
                title: "Alert",
                width: '55%',
                maxHeight: 'auto',
                minHeight: 150,
                buttons: {
                    "Ok": function () {

                        PageMethods.fnSubmit(ExerciseID, RspExerciseId, fnSubmitSuccess, fnUpdateResponsesFailed);
                        $(this).dialog("close");
                    },
                    "Cancel": function () {
                        $(this).dialog("close");
                    }
                },
                close: function () {
                    $(this).dialog("close");
                    $(this).dialog("destroy");
                }
            });
        }
        function fnSubmitSuccess(result) {

            if (result.split("^")[0] == "1") {

                window.location.href = "../Exercise/ExerciseMain.aspx?MenuId=6";

            }
        }
        function fnUpdateResponsesFailed(result) {
            alert(result.split("^")[1])
        }

        function fnPageLoad() {
            if (SecondCounter > -1) {
                setInterval(function () { FnUpdateTimer() }, 1000);
            }
        }

        $(document).ready(function () {
            var PrepStatus = $("#ConatntMatter_hdnPrepStatus").val();
            var MeetingStatus = $("#ConatntMatter_hdnMeetingStatus").val();
            if (PrepStatus == 0 && MeetingStatus == 0) {
                PrepStatus = PrepStatus == 0 ? 1 : PrepStatus;
                MeetingStatus = MeetingStatus == 0 ? 1 : MeetingStatus;
                fnUpdateActualStartEndTime(PrepStatus, MeetingStatus);
            }
            eventStartMeetingTimer = setInterval("fnStartMeetingTimer()", 5000);
        });

        function fnUpdateActualStartEndTime(UserTypeID, flgAction) {
            $("#loader").show();
            var RspExerciseID = $("#ConatntMatter_hdnRSPExerciseID").val();
            PageMethods.fnUpdateActualStartEndTime(RspExerciseID, UserTypeID, flgAction, function (result) {
                $("#loader").hide();
                if (result.split("|")[0] == "1") {
                    alert("Error-" + result.split("^")[1]);
                }
            }, function (result) {
                $("#loader").hide();
                alert("Error-" + result._message);
            });
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
    </script>

</asp:Content>

<asp:Content ID="ContentTimer" ContentPlaceHolderID="ContentTimer" runat="Server">
    <time id="theTime" class="fst-color">Time Left
        00: 00: 00</time>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ConatntMatter" runat="Server">
    <div class="position-relative mt-4 mb-3">
        <div class="left_block section-discussion_time">
            Preparation time: 30 minutes
            <br />
            Discussion time : 30 minutes
        </div>
        <div class="section-title">
            <h3 class="text-center">Role Based Case Discussion</h3>
            <div class="title-line-center"></div>
        </div>
        <%--<div class="right_block">
            <input type="button" id="btnGoToMeeting" class="btns btn-submit sm" style="Display:none;" value="MS Teams Meeting" onclick="fnGoToMeeting()" />
        </div>--%>
    </div>
   <div>

          <%-- <h4 class="text-decoration-underline fw-bold">Instructions for Participants</h4>

    <p>You will be given a case and assigned a specific role in the context of the case. Read the case and the individual role brief attentively. You are required to assume the assigned role and provide your views and points in coherence with the assigned role to reach a consensus at the end of the discussion as per the given case. </p>--%>
          <br />
    <h4 class="text-decoration-underline fw-bold">Case Brief:</h4>
    <p>XYZ Motors, a prominent two-wheeler manufacturer in India, is continually working towards refining its service ecosystem by elevating service training standards and incorporating digital innovations. The company has recently observed inconsistencies in service manual updates, gaps in service bulletins, and variations in service training effectiveness across regions. Additionally, with an increasing focus on cost optimization, market intelligence, and innovative service models, it has become imperative to ensure that Territory Service Managers (TSM) collaborate effectively to align regional service strategies with organizational goals.</p>
    <p>In a recent internal review, it was found that some service manuals were outdated, and technical content was not standardized across different service centers. Additionally, digital platforms for technical training and service updates were underutilized. The company also noticed that some regions had successfully implemented cost-effective service campaigns and innovative service models, while others struggled with customer retention and financial optimization.</p>
    <p>As part of a strategic initiative, XYZ Motors Head Office team has brought together a panel of five TSMs from different regions to explore ways to enhance service operations, streamline knowledge sharing, and strengthen training efforts. Each TSM will contribute insights from their region, highlighting key challenges and proposing solutions that balance standardization with regional adaptability, ultimately shaping a more efficient and cost-effective service approach.</p>
    
<div id="role_1" runat="server">
        <h4>TSM - North Region (Metro Cities, High-Tech Service Centers)</h4>
        <p><strong>Profile:</strong> Handles high-volume service centers in metro cities with strong digital infrastructure. Known for implementing AI-driven diagnostics and digital service tracking.</p>
        
        <div>
            <h5>Concerns and Discussion Points</h5>
            <ul>
                <li>You believe that enhancing service efficiency requires a shift toward real-time digital updates, ensuring that technicians have instant access to the latest guidelines and troubleshooting insights.</li>
                <li>You want to highlight the need for a more agile approach to updating service content, as the current process struggles to keep pace with evolving service requirements and customer expectations.</li>
                <li>You think that operational delays and customer dissatisfaction are often linked to inefficiencies in managing service documentation, making it essential to optimize both content creation and distribution.</li>

            </ul>
        </div>
</div>


<div id="role_2" runat="server">
        <h4>TSM - West Region (Industrial and Semi-Urban Belt, Cost Optimization Focus)</h4>
        <p><strong>Profile:</strong> Manages service networks in semi-urban and industrial areas, where digital infrastructure is limited but cost optimization is a priority.</p>
        <div>
            <h5>Concerns and Discussion Points </h5>
            <ul>
                <li>You believe that reducing the cost of developing and updating service manuals is crucial, with a continued need for printed versions in certain areas to ensure accessibility. </li>
                <li>You think that trainer development programs should focus on practical, cost-effective solutions, as advanced digital platforms may not always be feasible in semi-urban service centers.</li>
                <li>You want to emphasize the importance of using data-driven market insights to better forecast service needs and optimize resource allocation, balancing cost control with service efficiency.</li>
            </ul>
        </div>
</div>


<div id="role_3" runat="server">
      <h4>TSM - South Region (High Competition, Digitally Advanced)</h4>
      <p><strong>Profile:</strong> Manages service operations in a highly competitive market where digital adoption is high, and customer expectations are demanding.</p>
      
          <h5>Concerns and Discussion Points </h5>
          <ul>
              <li>You believe that transitioning to fully digital service manuals integrated with interactive troubleshooting tools is essential for improving technician efficiency and accuracy. </li>
              <li>You think that enhancing trainer capabilities with AI and VR-based simulations will modernize training, making it more effective and relevant for current service demands. </li>
              <li>You want to highlight the potential of introducing subscription-based service models to create additional revenue streams and improve customer retention by offering long-term value.</li>
          </ul>
  </div>


<div id="role_4" runat="server">
    <h4>TSM - East Region (Emerging Market, High Demand, Training Deficiencies)</h4>
    <p><strong>Profile:</strong>Handles service operations in a fast-growing two-wheeler market but struggles with workforce training and skill retention.</p>
  
        <h5>Concerns and Discussion Points </h5>
        <ul>
            <li>You believe that prioritizing trainer development is crucial, as many technicians still lack foundational service knowledge, making digital expansion less effective in your region.</li>
            <li>You think that printed service manuals and in-person workshops remain vital for effective training, as not all technicians are equipped for digital learning methods.</li>
            <li>You want to emphasize the need for region-specific training programs, as a standardized approach may not address the unique challenges of emerging markets and high technician turnover</li>
        </ul>
    
</div>


<div id="role_5" runat="server">
    <h4>TSM - Central Region (High Rural Demand, Service Affordability Challenges)</h4>
    <p><strong>Profile:</strong>Leads service initiatives in a primarily rural area, focusing on affordability, accessibility, and technician skill development.</p>
 
        <h5>Concerns and Discussion Points </h5>
        <ul>
            <li>You believe that simplifying service publications and translating them into regional languages is essential for improving technician comprehension, especially in rural areas.</li>
            <li>You think that low-cost, high-reach service models like mobile service units are key to addressing the unique needs of rural customers and ensuring accessible service.</li>
            <li>You want to emphasize the importance of hands-on mentoring in trainer development, as many rural technicians lack access to digital tools and platforms.</li>
        </ul>
   
</div>

        <div class="text-center mt-3 pb-4">
            <input type="button" id="btnSubmit" class="btns btn-submit" disabled value="Close Exercise" onclick="fnSubmit()">
        </div>
    </div>

    <div id="dvDialog" style="display: none"></div>
    <div id="loader" class="loader-outerbg" style="display: none">
        <div class="loader"></div>
    </div>

    <asp:HiddenField ID="hdnCounter" runat="server" Value="0" />
    <asp:HiddenField ID="hdnCounterRunTime" runat="server" Value="0" />
    <asp:HiddenField ID="hdnExerciseTotalTime" runat="server" Value="0" />
    <asp:HiddenField ID="hdnTimeElapsedMin" runat="server" Value="0" />
    <asp:HiddenField ID="hdnTimeElapsedSec" runat="server" Value="0" />
    <asp:HiddenField ID="hdnTimeLeft" runat="server" Value="0" />
    <asp:HiddenField ID="hdnRSPExerciseID" runat="server" Value="0" />
    <asp:HiddenField ID="hdnRspID" runat="server" Value="0" />
    <asp:HiddenField ID="hdnLoginID" runat="server" Value="0" />
    <asp:HiddenField ID="hdnExerciseID" runat="server" Value="0" />
    <asp:HiddenField ID="hdnGoToMeetingURL" runat="server" Value="0" />
    <asp:HiddenField ID="hdnPrepStatus" runat="server" Value="0" />
    <asp:HiddenField ID="hdnMeetingStatus" runat="server" Value="0" />
    <asp:HiddenField ID="hdnMeetingDefaultTime" runat="server" Value="0" />
</asp:Content>

