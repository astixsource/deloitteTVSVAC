﻿<%@ Page Title="" Language="VB" MasterPageFile="~/Data_Cohort1/MasterPage/Panel.master" AutoEventWireup="false" CodeFile="ORG.aspx.vb" Inherits="Data_Information_ORG" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="Server">
    <link href="../../CSS/jquery-ui.css" rel="stylesheet" />
    <script src="../../Scripts/jquery-ui.js"></script>
    <script type="text/javascript">
        function fnGoBack() {
            window.location.href = "LeadershipPresence.aspx";
        }
    </script>
    <script type="text/javascript">
        //(function ($) {
        $.fn.blink = function (options) {
            var defaults = {
                delay: 500
            };
            var options = $.extend(defaults, options);
            var obj = $(this);
            setInterval(function () {
                $(obj).fadeOut().fadeIn();
            }, options.delay);
        }
        //}(jQuery))
    </script>
    <script type="text/javascript">
        var SecondCounter = 0; var MinuteCounter = 0; var hours = 0; var IsUpdateTimer = 1; var flgChances = 1; var counter = 0; var counterAutoSaveTxt = 0;
        function f1() {

            if (IsUpdateTimer == 0) { return; }
            SecondCounter = parseInt(document.getElementById("ConatntMatterRight_hdnCounter").value);
            if (SecondCounter <= 0) {
                IsUpdateTimer = 0;

                $("#theTime").addClass("blinkmsg");

                $('.blinkmsg').blink({
                    delay: "1500"
                });

                return;
            }
            SecondCounter = SecondCounter - 1;
            hours = Math.floor(SecondCounter / 3600);
            Minutes = Math.floor((SecondCounter - (hours * 3600)) / 60);
            Seconds = SecondCounter - (hours * 3600) - (Minutes * 60);


            if (Seconds < 10 && Minutes < 10) {
                document.getElementById("theTime").innerHTML = "Reading Time Left : 0" + hours + ":" + "0" + Minutes + ":" + "0" + Seconds;
            }
            else if (Seconds < 10 && Minutes > 9) {
                document.getElementById("theTime").innerHTML = "Reading Time Left : 0" + hours + ":" + Minutes + ":" + "0" + Seconds;
            }
            else if (Seconds > 9 && Minutes < 10) {
                document.getElementById("theTime").innerHTML = "Reading Time Left : 0" + hours + ":" + "0" + Minutes + ":" + Seconds;
            }
            else if (Seconds > 9 && Minutes > 9) {
                document.getElementById("theTime").innerHTML = "Reading Time Left : 0" + hours + ":" + Minutes + ":" + Seconds;
            }
            document.getElementById("ConatntMatterRight_hdnCounter").value = SecondCounter;

            if (((hours * 60) + Minutes) == 5 && Seconds == 0) {

                $("#dvDialog")[0].innerHTML = "<center>Reading Time Left : 0" + hours + ":" + "0" + Minutes + ":" + "0" + Seconds + " </center>";
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
            counterAutoSaveTxt++;
            if (counter == 10) {//Auto Time Update
                counter = 0;

            }
            if (counterAutoSaveTxt == 30) {//Auto Text Save
                counterAutoSaveTxt = 0;

            }

            if (SecondCounter == 0) {
                // alert("Level Complete");
                IsUpdateTimer = 0;
                counter = 0;


                $("#theTime").addClass("blinkmsg");


            }
            // }
            setTimeout("f1()", 1000);
        }
    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentTimer" runat="Server">
    <time id="theTime" class="fst-color" style='display: none'>Reading Time Left 00: 00: 00</time>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ConatntMatterRight" runat="Server">
    <div class="section-title">
        <h3 class="text-center">Your Role</h3>
        <div class="title-line-center"></div>
    </div>
    
   
    <p>You are Shashi Agarwal, the regional after sales service head for your region. You head all after sales service operations and are responsible for developing strategies for after sales services within your region. Your region generates the highest revenue compared to all other regions in the country.</p>
    <p>In line with the CEOs strategy to provide customised services to NextGen Motors customers, and NextGen Motors&rsquo;s aggressive market expansion endeavours in Southeast Asia, your voice within the Leadership has become increasingly important.</p>
    <p>You are painfully aware that budgets are not enough for strategic investments and as a result, you must maintain a good balance while developing strategies to invest in initiatives that provide immediate returns, and those that provide more long term returns to the company.</p>
      <div class="section-title">
        <h3 class="text-center">Organisation Structure</h3>
        <div class="title-line-center"></div>
    </div>
         <div class="text-center">
                        <img src="../../Images/mt-background-1.jpg" class="img-thumbnail mb-3" />
                    </div>
   <%-- <ol>
        <li>MotorTek India Ltd (MIL) is  headed by Ashish Malhotra, the Chairman.</li>
        <li>Gautam  Venkatesh, the Managing Director is responsible for 7 core departments. Each  department is led by the respective Department Head.
                    <div class="text-center">
                        <img src="../../Images/mt-background-1.jpg" class="img-thumbnail mb-3" />
                    </div>
        </li>
        <li>MotorTek Research &amp; Development Pvt. Ltd.  (MRDL) is headed by Sanjeev Ghani, the Managing Director.
                    <div class="text-center">
                        <img src="../../Images/mt-background-2.jpg" class="img-thumbnail" />
                    </div>
        </li>
    </ol>--%>

    <asp:HiddenField ID="hdnCounter" runat="server" Value="0" />
    <div id="dvDialog" style="display: none"></div>
</asp:Content>

