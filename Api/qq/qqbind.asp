<!--#include file="../../inc/conn.asp"-->
<!--#include file="../../Inc/md5.asp"-->
<!--#include file="config.asp"-->
<%
SET qc = New QqConnet
If Session("Access_Token") = "" Then
    CheckLogin=qc.CheckLogin()
	If CheckLogin=False Then
	   Call Alert ("没有返回数据,请重新登录!",SitePath)
	Else
	   Session("Access_Token")=qc.GetAccess_Token()
	End If
End If

Session("Openid")=qc.Getopenid()
UserInfoQQ=qc.GetUserInfo()
	nickname = qc.GetUserName(UserInfoQQ)(0)
	nickname = CheckStr(nickname)
	If len(nickname)<3 then nickname="qzuser"&RndNumber(99999,9999999999)
	sex = qc.GetUserName(UserInfoQQ)(1)
	icon = "http://qzapp.qlogo.cn/qzapp/"&qc.APP_ID&"/"&Session("Openid")&"/100"
Set qc=Nothing

   If sex="男" Then
      sex=1
   Else
      sex=0
   End If

'登录成功后调用登录函数进行登录
Sub DoLogin(userName,Password)
Dim UserRS:Set UserRS=Server.CreateObject("Adodb.RecordSet")
			 UserRS.Open "Select top 1 * From "&tbname&"_User Where UserName='" &UserName & "' And PassWord='" & PassWord & "'",Conn,1,3
			 If UserRS.Eof And UserRS.BOf Then
				UserRS.Close:Set UserRS=Nothing
				Call Alert ("您输入的账号不存在或是密码不正确，请重输!",-1)
			 'ElseIf UserRS("yn")=0 Then
				'Call Alert ("您的帐号还没有通过审核!",-1)
			 Else
				Dim RndPassword:RndPassword=md5("l"&"a"&"o"&"y"&RndNumber(1,9999999999),32)
				UserRS("LastIP") = GetIP
                UserRS("LastTime") = Now()
				UserRS("RndPassWord")=RndPassWord
                UserRS.Update
				Response.Cookies("Yao").path=SitePath
                Response.Cookies("Yao").Expires=Date+30 
				Response.Cookies("Yao")("UserName")=username
				Response.Cookies("Yao")("UserPass")=PassWord
				Response.Cookies("Yao")("RndPassword")=RndPassword
				Response.Cookies("Yao")("ID")=UserRS("ID")
			end if
			UserRS.Close : Set UserRS=Nothing
	If session("laoyqqurl")<>"" then
        Response.redirect session("laoyqqurl")
	else
	Response.redirect SitePath
	end if
End Sub

If Session("islaoy")=1 and IsUser=1 Then
	openid=session("openid")

		sql="select [username],[qqopenid] From ["&tbname&"_user] where qqopenid='"& openid &"'"
		set rs = server.CreateObject("adodb.recordset")
		rs.open sql,conn,1,1
		If Not Rs.eof Then 
			Call Alert ("此QQ已经绑定了帐号【"&rs("username")&"】!",SitePath&"User/UserAdd.asp?action=useredit")
		End if  
		Rs.Close:Set Rs = Nothing

	Conn.execute("update "&tbname&"_user set qqopenid='" & openid & "',UserFace='"&icon&"' where username='" & username & "'")
	Call Alert ("绑定成功,以后可使用QQ直接登录本站!",SitePath&"User/UserAdd.asp?action=useredit")
Else
		set rslogin=conn.execute("select top 1 * from "&tbname&"_user where qqopenid='" & CheckStr(session("openid")) & "'")
		if rslogin.eof and rslogin.bof then

		set rs=server.CreateObject("adodb.recordset")
		rs.open "select top 1 * from "&tbname&"_user where username='" & nickname & "'",conn,1,3
		if not rs.eof then
			nickname=nickname&RndNumber(99,99999)
		end if
		rpass=md5("laoy"&RndNumber(99,99999),16)
		RS.AddNew
		rs("UserName")			=nickname
		rs("PassWord")			=rpass
		rs("Sex")				=Sex
		rs("RegTime")			=Now()
		rs("LastTime")			=Now()
		rs("IP")				=GetIP&":"&Request.ServerVariables("REMOTE_PORT")
		rs("LastIP")			=GetIP
		rs("UserMoney")			=0
		rs("usergroupid")		=1
		rs("RndPassword")		=md5("l"&"a"&"o"&"y"&RndNumber(1,9999999999),32)
		rs("yn")				=userynoff
		rs("qqopenid")			=session("openid")
		rs("userface")			=icon
		
		rs.update
		'If userynoff=1 then
			Set SQLID=server.createobject("adodb.recordset")
			sql = "select ID,RndPassword from "&tbname&"_User where UserName='"&nickname&"'"
			SQLID.open sql,conn,1,1  
			If SQLID.eof and SQLID.bof then
			  LaoYSQLID=""
			  RndPassword=""
			Else
			  LaoYSQLID=SQLID("ID")
			  RndPassword=SQLID("RndPassword")
			End If
			SQLID.close
			Set SQLID=nothing
		Response.Cookies("Yao").path=SitePath
		Response.Cookies("Yao")("UserName")=nickname
		Response.Cookies("Yao")("UserPass")=rpass
		Response.Cookies("Yao")("ID")=LaoYSQLID
		Response.Cookies("Yao")("RndPassword")=RndPassword
		If session("laoyqqurl")<>"" then
        Response.redirect session("laoyqqurl")
		else
		Response.redirect SitePath
		end if
		'Call Alert ("恭喜你,注册成功",SitePath&"User/UserAdd.asp?action=useredit")
		'Else
		'Call Alert ("恭喜你,注册成功,请等待管理员审核!",SitePath)
		'End if
	rs.close
	Set rs=nothing


		else
			 Call DoLogin(rslogin("username"),rslogin("password"))
		end if
		set rslogin=nothing
End If
%>