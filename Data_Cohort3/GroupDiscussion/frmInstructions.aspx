<%@ Page Title="" Language="VB" MasterPageFile="~/Data_Cohort3/MasterPage/SiteInstruction.master" AutoEventWireup="false" CodeFile="frmInstructions.aspx.vb" Inherits="SJT_frmSJTInstructions" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="Server">
    <%--<script src="../../Scripts/webcamV5Main.js"></script>--%>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentTimer" runat="Server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ConatntMatter" runat="Server">
    <div class="section-title">
        <h3 class="text-center">Role Based Case Discussion</h3>
        <div class="title-line-center"></div>
    </div>
            <h4 class="text-decoration-underline fw-bold">Instructions for Participants</h4>

<p>You will be given a case and assigned a specific role in the context of the case. Read the case and the individual role brief attentively. You are required to assume the assigned role and provide your views and points in coherence with the assigned role to reach a consensus at the end of the discussion as per the given case. </p>


      <asp:HiddenField ID="hdnIsProctoringEnabled" runat="server" Value="0" />
    <div class="text-center">
          <asp:Button ID="btnBack" runat="server" CssClass="btns btn-submit" Text="Back" OnClick="btnBack_Click" />
        <asp:Button ID="btnSubmit" runat="server" CssClass="btns btn-submit" Text="Next" />
    </div>
</asp:Content>

