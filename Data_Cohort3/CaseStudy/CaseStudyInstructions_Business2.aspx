﻿<%@ Page Title="" Language="VB" MasterPageFile="~/Data_Cohort3/MasterPage/Site.master" AutoEventWireup="false" CodeFile="CaseStudyInstructions_Business2.aspx.vb" Inherits="Set1_CaseStudy_CaseStudyInstructions" %>

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
           window.location.href = "CaseStudy_Business2.aspx?ExerciseID=" + ExerciseID + "&RspId=" + RspID + "&ExerciseType=" + ExerciseType + "&TimeAlloted=" + TimeAlloted;

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
  
    <div class="row">
       
        <div class="col-md-12">
            <div class="info-about mt-2">
              

 <div class="section-title">
        <h3 class="text-center">Case Study</h3>
        <div class="title-line-center"></div>
    </div>
                <h4 class="text-decoration-underline fw-bold">Background:</h4>

                <p>"M/s Star Motors, an established TVS dealership in a medium-sized town, has experienced consistent growth due to the town’s expanding economy and rising population. The town's increased economic activity has led to a surge in demand for consumer goods, including automobiles, electronics, and other consumer durables. As a result, new dealerships have been set up in the newly developed areas of the town, increasing competition in the local market. Despite the favorable business environment, M/s Star Motors has been facing a stagnation in service revenue over the past year. This issue has become more pronounced as the dealership has been unable to capitalize on the growth in the town's population and its expanding infrastructure.</p>


                <p>
                   While the sales department has continued to thrive, the service department has failed to see a similar increase in revenue. One of the main challenges facing the service department is the reliance on outdated systems and manual processes for service tracking, customer engagement, and diagnostics. These legacy systems have resulted in operational inefficiencies, with slow response times and poor customer service, which in turn have led to a decrease in customer satisfaction.


                <p>
                    Moreover, there is no CRM system in place, making it difficult to track customer interactions, manage appointments, or capture valuable feedback. The service department has also struggled with employee morale, as technicians are accustomed to working with older systems and have shown reluctance to adopt new technologies, further exacerbating operational inefficiencies.
                </p>

                <p>
                    The town’s rapid expansion has led to a rise in competition, with new service centers opening up, offering faster and more efficient services. This has increased the pressure on M/s Star Motors to improve service delivery and meet the heightened customer expectations. However, despite these challenges, the management team has been hesitant to make large-scale investments in the service department, preferring instead to seek cost-effective, incremental changes that will improve performance without disrupting operations. There has also been a lack of coordination between the sales and service departments, causing gaps in customer service and limiting opportunities for cross-selling and after-sales service. Additionally, while marketing campaigns have been launched to attract more customers to the service department, the service team has not been adequately prepared to handle the increase in demand.
                </p>

                <p>
                    Given these challenges, M/s Star Motors is under pressure to improve the performance of its service department, especially as it faces increased competition and the need to align its service offerings with the growing town population.  
You have been tasked with improving the service department’s performance, your role is to develop an actionable plan to address the given issues.
M/s Star Motors' financial data highlights the pressing need to revamp its service department to remain competitive in the growing local market. While vehicle sales continue to contribute nearly 80% of total dealership revenue, service-related earnings have stagnated, accounting for only 18% of overall profitability—falling short of the industry benchmark of 25-30%. Over the past year, post-warranty customer retention rates have declined by 10%, leading to a significant loss of recurring revenue opportunities. Additionally, inefficiencies caused by outdated service tracking systems and manual processes have increased operational costs, with technician overtime expenses rising by 15% due to scheduling and workflow inefficiencies. The lack of a centralized CRM system has further compounded challenges, resulting in missed follow-ups, inconsistent customer engagement, and lower service conversions. As new competitors enter the market, offering faster and more technologically advanced service options, M/s Star Motors faces mounting pressure to enhance its service delivery. However, with financial resources prioritized for dealership expansion and sales growth, senior management is reluctant to approve large-scale investments without clear, data-driven projections on return on investment (ROI). This makes it imperative to identify targeted, cost-effective solutions that improve operational efficiency, enhance customer retention, and drive service department profitability."

                </p>


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

    <div class="text-center mb-2">
        <%--<a href="###" id="btnDownloadTemplate" runat="server" class="btns btn-submit" onclick="fnDownloadTemplates()">Download Presentation and Excel Templates</a>--%>
        <asp:Button ID="btnBack" runat="server" CssClass="btns btn-submit" Text="Back" OnClick="btnBack_Click"/>
        <input type="button" id="btnSubmit" runat="server" value="Start" class="btns btn-submit" onclick="fnMSG()" />

    </div>
    <div id="dvDialog" style="display: none"></div>
</asp:Content>

