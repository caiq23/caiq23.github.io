<!--#include file="../../inc/conn.asp"-->
<!--#include file="config.asp"-->
<%
If useroff=0 then Call Alert("网站目前已经关闭会员功能",SitePath)
Dim qc, url
    Session("Code")=""
    Session("Openid")=""
    Session("Access_Token")=""
    Session("Openid")=""
SET qc = New QqConnet
    Session("State")=qc.MakeRandNum()
    Session("laoyqqurl")=request.servervariables("HTTP_REFERER")
    url = qc.GetAuthorization_Code()
    Response.Redirect(url)
Set qc=Nothing
%>