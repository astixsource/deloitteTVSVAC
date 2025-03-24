
Partial Class frmSelfAssessmentInstruction
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load

        If (Session("LoginId") Is Nothing) Then
            Response.Redirect("../../Login.aspx")
            Return
        End If



    End Sub

    Protected Sub btnSubmit_Click(sender As Object, e As EventArgs)
        Response.Redirect("frmSelfAssessmentRating.aspx")
    End Sub

    Protected Sub btnBack_Click(sender As Object, e As EventArgs)
        Response.Redirect("~/Data_Cohort" & Convert.ToString(Session("BandID")) & "/Exercise/ExerciseMain.aspx")
    End Sub
End Class
