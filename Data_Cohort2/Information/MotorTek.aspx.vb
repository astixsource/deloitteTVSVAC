﻿Imports System.Data
Imports System.Data.SqlClient
Partial Class Data_Information_MotorTek
    Inherits System.Web.UI.Page
    Dim intLoginID As Integer = 0
    Dim AssessmentType As Integer
    Protected Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load
        If (Session("LoginId") Is Nothing) Then
            Response.Redirect("../Login.aspx")
            Return
        End If



        Dim Objcon2 As New SqlConnection(Convert.ToString(HttpContext.Current.Application("DbConnectionString")))
        Dim objCom2 As New SqlCommand("spPreExerciseUpdateStatus", Objcon2)
        objCom2.Parameters.Add("@LoginID", SqlDbType.Int).Value = Session("LoginId")
        objCom2.Parameters.Add("@EmpNodeID", SqlDbType.Int).Value = Session("NodeId")
        objCom2.Parameters.Add("@flgStage", SqlDbType.Int).Value = 1
        objCom2.Parameters.Add("@flgStatus", SqlDbType.Int).Value = 1

        objCom2.CommandType = CommandType.StoredProcedure
        objCom2.CommandTimeout = 0
        Dim strReturn As String = ""

        Try
            Objcon2.Open()
            Dim dr As SqlDataReader
            dr = objCom2.ExecuteReader
            dr.Read()
            hdnCounter.Value = IIf(IsNothing(dr.Item("BackGroundTimeRemaining")), 0, dr.Item("BackGroundTimeRemaining"))
        Catch ex As Exception
            strReturn = "2^"
        Finally
            objCom2.Dispose()
            Objcon2.Close()
            Objcon2.Dispose()
        End Try

    End Sub

    'Private Sub btnSubmit_Click(sender As Object, e As EventArgs) Handles btnSubmit.Click



    '    Dim hdnAssessment As HiddenField
    '    hdnAssessment = DirectCast(Page.Master.FindControl("hdnAssmntType"), HiddenField)
    '    AssessmentType = hdnAssessment.Value

    '    If AssessmentType = 0 Then
    '        AssessmentType = 1
    '    End If

    '    If AssessmentType = 1 Then
    '        Response.Redirect("../Exercise/ExerciseMain_L4.aspx?intLoginID=" & Session("LoginId"))
    '    Else
    '        Response.Redirect("../Exercise/ExerciseMain_L3.aspx?intLoginID=" & Session("LoginId"))
    '    End If


    'End Sub


End Class

