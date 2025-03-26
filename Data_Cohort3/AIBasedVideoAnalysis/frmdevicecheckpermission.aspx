<%@ Page Title="" Language="VB" MasterPageFile="~/Data_Cohort3/MasterPage/SiteInstruction.master" AutoEventWireup="false" CodeFile="frmdevicecheckpermission.aspx.vb" Inherits="frmdevicecheckpermission" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="Server">
    <script>
        let IsProctoringEnabled = false;
        let IsScreenEnabled = false;
        let cnt = 0;
        async function checkPermission(name, elementId) {
            try {
                let result = await navigator.permissions.query({ name });
                document.getElementById(elementId).textContent = result.state;
                result.onchange = () => {
                    document.getElementById(elementId).textContent = result.state;
                };
                IsProctoringEnabled = true;
                cnt++;
            } catch (error) {
                IsProctoringEnabled = false;
                document.getElementById(elementId).textContent = "Not Supported";
            }
        }

        async function checkAllPermissions() {
            cnt = 0;
            await checkPermission("camera", "cameraStatus");
            await checkPermission("microphone", "micStatus");

            // Screen sharing doesn't support navigator.permissions.query, so we check manually
            document.getElementById("screenStatus").textContent = "Click 'Request Permissions' to check";
        }

        async function requestPermissions() {
            try {
                cnt = 0;
                // Request camera & microphone access
                let stream = await navigator.mediaDevices.getUserMedia({ video: true, audio: true });
                document.getElementById("cameraStatus").textContent = "granted";
                document.getElementById("micStatus").textContent = "granted";
                stream.getTracks().forEach(track => track.stop());
                cnt++;
                IsProctoringEnabled = true;
            } catch (error) {
                IsProctoringEnabled = false;
                document.getElementById("cameraStatus").textContent = "denied";
                document.getElementById("micStatus").textContent = "denied";
            }

            //try {
            //    // Request screen share access
            //    let screenStream = await navigator.mediaDevices.getDisplayMedia({ video: true });
            //    document.getElementById("screenStatus").textContent = "granted";
            //    screenStream.getTracks().forEach(track => track.stop());
            //    IsScreenEnabled = true;
            //    cnt++;
            //} catch (error) {
            //    IsScreenEnabled = false;
            //    document.getElementById("screenStatus").textContent = "denied";
            //}
        }

        checkAllPermissions();
        $(document).ready(function () {
             requestPermissions();
            setInterval(function () {
                if (IsProctoringEnabled == true) {
                    document.getElementById("ConatntMatter_btnSubmit").disabled = false;
                    $("#ConatntMatter_btnSubmit").prop("disabled", false);
                    $("#ConatntMatter_btnSubmit").removeAttr("disabled");
                }
            }, 300);
        });
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentTimer" runat="Server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ConatntMatter" runat="Server">
    <div class="section-title">
        <h3 class="text-center">AI Based Video Analysis</h3>
        <div class="title-line-center"></div>
    </div>
     <div class="mt-2">
         <h2>Check Device Permissions</h2>
    <p>Camera: <span id="cameraStatus">Checking...</span></p>
    <p>Microphone: <span id="micStatus">Checking...</span></p>
   <%-- <p>Screen Sharing: <span id="screenStatus">Checking...</span></p>--%>
     </div>
      <asp:HiddenField ID="hdnIsProctoringEnabled" runat="server" Value="0" />
    <div class="text-center">
          <asp:Button ID="btnBack" runat="server" CssClass="btns btn-submit" Text="Back" OnClick="btnBack_Click" />
        <asp:Button ID="btnSubmit" runat="server" Enabled="false" CssClass="btns btn-submit" Text="Next" />
    </div>
</asp:Content>

