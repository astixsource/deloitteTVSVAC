﻿<%@ Page Title="" Language="VB" MasterPageFile="~/Data_Cohort2/MasterPage/Site.master" AutoEventWireup="false" CodeFile="CaseStudyInstructions_Technical1.aspx.vb" Inherits="Set1_CaseStudy_CaseStudyInstructions" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="Server">


    <script type="text/javascript">      
        function fnMSG() {

            //$("#dvDialog").html("Are you sure you have download the template, If Yes, then click on 'Yes' button, if No, Please, download the templates first");
            //$("#dvDialog").dialog({
            //    modal: true,
            //    title: "Alert",
            //    width: '50%',
            //    maxHeight: 'auto',
            //    minHeight: 150,
            //    buttons: {
            //        "Yes": function () {
            var ExerciseID = '<%=ExerciseID%>'
            var ExerciseType = '<%=ExerciseType%>'
                        var TimeAlloted = '<%=TimeAlloted%>'
            var RspID = '<%=RspID%>'
            window.location.href = "CaseStudy_Technical1.aspx?ExerciseID=" + ExerciseID + "&RspId=" + RspID + "&ExerciseType=" + ExerciseType + "&TimeAlloted=" + TimeAlloted;

            //            $(this).dialog("close");
            //        },
            //        "No": function () {
            //            fnDownloadTemplates()
            //            $(this).dialog("close");
            //        }
            //    },
            //    close: function () {
            //        $(this).dialog("close");
            //        $(this).dialog("destroy");
            //    }
            //});

        }

        function download_files(files) {
            function download_next(i) {
                if (i >= files.length) {
                    return;
                }
                var a = document.createElement('a');
                a.href = files[i].download;
                a.target = '_parent';
                // Use a.download if available, it prevents plugins from opening.
                if ('download' in a) {
                    a.download = files[i].filename;
                }
                // Add a to the doc for click to work.
                (document.body || document.documentElement).appendChild(a);
                if (a.click) {
                    a.click(); // The click method is supported by most browsers.
                } else {
                    $(a).click(); // Backup using jquery
                }
                // Delete the temporary link.
                a.parentNode.removeChild(a);
                // Download the next file with a small timeout. The timeout is necessary
                // for IE, which will otherwise only download the first file.
                setTimeout(function () {
                    download_next(i + 1);
                }, 500);
            }
            // Initiate the first download.
            download_next(0);
        }

    </script>
    <script>
        // Here's a live example that downloads three test text files:
        function fnDownloadTemplates() {
            download_files([
                { download: "../../Templates/CaseStudy_Financials.xlsx", filename: "CaseStudy_Financials.xlsx" },
                { download: "../../Templates/CaseStudy_Template.pptx", filename: "CaseStudy_Template.pptx" },

            ]);
        };
    </script>
     <script>
         var SecondCounter = 0; var MinuteCounter = 0; var hours = 0; var IsUpdateTimer = 1; var flgChances = 1; var counter = 0; var counterAutoSaveTxt = 0;
         var TotalQuestions = 0; var BandID = 0;
         $(document).ready(function () {
             f1();
             eventStartMeetingTimer = setInterval("fnStartMeetingTimer()", 5000);
         })
         function f1() {
             $(document).ready(function () {
                 //function FnUpdateTimer() {
                 if (IsUpdateTimer == 0) { return; }
                 SecondCounter = parseInt(document.getElementById("ConatntMatter_hdnCounter").value);
                 if (SecondCounter < 0) {
                     IsUpdateTimer = 0;
                     $("#dvDialog").html("Your Time is over now");
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
                     counter = 0;
                     document.getElementById("theTime").innerHTML = "Time Left: 00:00:00";
                     // fnSaveData(2, "", 2, 1);
                     return;
                 }

                 SecondCounter = SecondCounter - 1;
                 hours = Math.floor(SecondCounter / 3600);
                 Minutes = Math.floor((SecondCounter - (hours * 3600)) / 60);
                 Seconds = SecondCounter - (hours * 3600) - (Minutes * 60);

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
                     // fnUpdateElapsedTime();
                     //counter = 1;
                 }

                 if (SecondCounter == 0) {
                     // alert("Level Complete");

                     //fnUpdateElapsedTime();
                     // fnAutoSaveText(2);
                     counter = 0;
                     IsUpdateTimer = 1;
                     $("#dvDialog").html("Your Time is over now");
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
                     document.getElementById("theTime").innerHTML = "Time Left: 00:00:00";
                     //alert("Your Time is over now")
                     counter = 0;
                     // var inLoginid1 = document.getElementById("ConatntMatter_hdnLoginID").value;
                     // window.location.href = "../Main/frmExerciseMain.aspx?intLoginID=" + inLoginid1;
                     return false;
                 }
                 // }
                 setTimeout("f1()", 1000);

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
<asp:Content ID="Content2" ContentPlaceHolderID="ContentTimer" runat="Server">
    <time id="theTime">Time Left<br />
        00: 00: 00</time>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ConatntMatter" runat="Server">
                <div class="section-title">
    <h3 class="text-center">Case Study</h3>
    <div class="title-line-center"></div>
</div>
    <div class="row">
       
        <div class="col-md-12">
            <div class="info-about mt-2">

              
                
                 <h4 class="text-decoration-underline fw-bold">Background:</h4>
                
                <p>
                    As an Area Manager (AM) overseeing multiple dealerships across different regions, you are responsible 
                    for ensuring that all locations meet customer satisfaction targets, improve Net Promoter Score (NPS), 
                    and optimize service operations. Your role is to create a scalable and sustainable framework that 
                    ensures consistent service excellence across your territory.
                </p>
                <p>
                    Currently, NPS across the region has dropped to 53% (against a target of 70%), with customer 
                    complaints rising by 18% YoY. The territory-wide customer dissatisfaction recovery rate is only 22%, 
                    indicating that even when complaints are addressed, customers remain dissatisfied.
                </p>

                <h4 class="text-decoration-underline fw-bold">Key Issues:</h4>

                <ol>
                    <li>nconsistent Service Quality Across Dealerships: While some dealerships achieve an NPS of over 
                        70%, others struggle to exceed 50%. This disparity stems from discrepancies in technician skill 
                        levels, adherence to standard operating procedures (SOPs), and inconsistent complaint-handling 
                        practices across locations. These variations have led to a lack of uniformity in customer 
                        experience and service reliability.
                    </li>

                    <li>Recurring Vehicle Performance Complaints (Avg. Satisfaction: 56%): Recurring vehicle 
                        performance complaints continue to impact customer satisfaction, with an average satisfaction 
                        score of just 56%. Persistent issues related to engine performance, braking systems, and fuel 
                        efficiency are frequently reported. While some locations have effectively addressed these 
                        concerns, others continue to receive repeated complaints, causing frustration among customers 
                        and eroding their trust in the brand.
                    </li>

                    <li>Low First-Time Fix Rate (FTFR) (Region avg. 61% vs. industry benchmark of 85%): High rework 
                        rates due to incorrect diagnoses or lack of parts availability lead to frequent repeat visits, further 
                        damaging brand trust. Customers often return for the same issue, resulting in increased service 
                        costs and a negative customer experience.
                    </li>

                    <li>High Carry Forward Ratio (50%): Many unresolved cases from previous service cycles continue to 
                        accumulate, creating long backlogs. Inefficiencies in service bay scheduling and underutilization 
                        of available service capacity further exacerbate delays, leading to extended customer wait times 
                        and lower operational efficiency.
                    </li>
                    <li>Underperforming Technicians and Training Gaps: Technician productivity and expertise vary 
                        across locations, impacting service turnaround times. 80% of customer complaints are linked to 
                        technician errors or communication gaps.
                    </li>

                    <li>Customer Complaint Handling and Recovery Gaps (Dissatisfaction Recovery: 22%): Some 
                        dealerships resolve complaints promptly, while others fail to recover dissatisfied customers. 
                        Poor communication and lack of structured follow-up affect customer retention.
                    </li>

                    <li>High Customer Complaints per 10,000 Vehicles (CC/10K: 180): Complaints per 10,000 vehicles 
                        exceed industry benchmarks (120 complaints/10K vehicles). Poor soft skills in service teams lead 
                        to negative customer experiences, even when technical service is done correctly.
                    </li>

                </ol>

                <p>
                    These issues have contributed to a low Net Promoter Score (NPS) and a high volume of customer 
                    complaints. The Territory Managers (TM) often have to intervene to resolve complaints, either by 
                    instructing the dealership staff over the phone or directly resolving issues during visits. As an Area 
                    Manager overseeing multiple dealerships your role is to develop a region-wide action plan that will align 
                    all dealerships, address root causes, and ensure sustainable improvement in customer satisfaction and 
                    NPS.
                </p>



                <%--<p class="text-danger"><b>As per the Development Centre rule, it is mandatory that all solution documents created should be DELETED from your system once the exercise is completed.</b></p>--%>
            </div>
        </div>
    </div>
    <asp:HiddenField ID="hdnCounter" runat="server" Value="0" />
    <asp:HiddenField ID="hdnRSPExerciseID" runat="server" Value="0" />
    <asp:HiddenField ID="hdnExerciseID" runat="server" Value="0" />
    <asp:HiddenField ID="hdnRspID" runat="server" Value="0" />
    <asp:HiddenField ID="hdnLoginID" runat="server" Value="0" />
    <asp:HiddenField ID="hdnExerciseStatus" runat="server" Value="0" />
     <asp:HiddenField ID="hdnMeetingDefaultTime" runat="server" Value="0" />
    <asp:HiddenField ID="hdnIsProctoringEnabled" runat="server" Value="0" />
    <div class="text-center">
        <%--<a href="###" id="btnDownloadTemplate" runat="server" class="btns btn-submit" onclick="fnDownloadTemplates()">Download Presentation and Excel Templates</a>--%>
        <asp:Button ID="btnBack" runat="server" CssClass="btns btn-submit" Text="Back" OnClick="btnBack_Click"/>
        <input type="button" id="btnSubmit" runat="server" value="Start" class="btns btn-submit" onclick="fnMSG()" />

    </div>
    <div id="dvDialog" style="display: none"></div>
</asp:Content>

