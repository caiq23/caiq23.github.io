<!--#include file="../Inc/conn.asp"-->
<!--#include file="../Inc/md5.asp"-->
<!--#include file="../Inc/ValidateClass.asp"-->
<%
If useroff=0 then Call Alert("网站目前已经关闭会员功能","../")
ValidateObj.checkValidate()
Dim UserName
UserName = LoseHtml(trim(request.form("UserName")))
set rs = server.CreateObject ("adodb.recordset")
sql="select * From ["&tbname&"_User] where username='"&UserName&"'"
rs.open sql,conn,1,3
if not rs.eof and not rs.bof then
rs.close
set rs=nothing
Call Alert ("错误：对不起,该用户已存在，请选择新的用户名!","-1")
elseif Not ChkRegName(UserName) then 
Call Alert ("注册失败，你想要注册的用户中含有本站禁止注册的字符!","-1")
else
dim sql,rs

UserName = 		CheckStr(trim(request.form("UserName")))
PassWord = 		trim(request.form("UserPassWord"))
Sex = 			trim(request.form("UserSex"))
Email = 		trim(request.form("UserEmail"))
QQ = 			trim(request.form("UserQQ"))
TrueName = 		trim(request.form("TrueName"))
myyear=			LaoYRequest(request("year"))
mymonth=		LaoYRequest(request("month"))
myday=			LaoYRequest(request("day"))
Birthday = 		myyear&"-"&mymonth&"-"&myday
Province = 		request.form("Province")
City = 			request.form("City")

		if UserName="" then
			Call Alert ("请填写用户名!","-1")
		elseif len(UserName)<2 then
			Call Alert ("用户名不得少于2个字!","-1")
		elseif PassWord="" then
			Call Alert ("请填写密码!","-1")
		elseif myyear="" or mymonth="" or myday="" then
			Call Alert ("请选择出生日期!","-1")
		elseif Province="" or City="" then
			Call Alert ("请选择籍贯!","-1")
		elseif Email="" then
			Call Alert ("请填写Email!","-1")
		'elseif QQ="" then
			'Call Alert ("请填写QQ!","-1")
		end if
		If Not Checkpost(True) Then Call Alert("禁止外部提交!","-1")
		rs.AddNew 
		rs("UserName")			=UserName
		rs("PassWord")			=md5(PassWord,16)
		rs("Sex")				=Sex
		rs("Email")				=Email
		'rs("UserQQ")			=QQ
		rs("TrueName")			=TrueName
		rs("Birthday")			=Birthday
		rs("Province")			=Province
		rs("City")				=City
		rs("RegTime")			=Now()
		rs("LastTime")			=Now()
		rs("IP")				=GetIP
		rs("LastIP")			=GetIP
		rs("UserMoney")			=0
		rs("usergroupid")		=1
		rs("RndPassword")		=md5("l"&"a"&"o"&"y"&RndNumber(1,9999999999),32)
		rs("yn")				=userynoff
		rs("QQOpenID")			=""
		rs.update
		If userynoff=1 then
			Set SQLID=server.createobject("adodb.recordset")
			sql = "select ID,RndPassword from "&tbname&"_User where UserName='"&username&"'"
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
		Response.Cookies("Yao")("UserName")=username
		Response.Cookies("Yao")("UserPass")=md5(PassWord,16)
		Response.Cookies("Yao")("ID")=LaoYSQLID
		Response.Cookies("Yao")("RndPassword")=RndPassword
		Call Alert ("恭喜你,注册成功","UserAdd.asp?action=useredit")
		Else
		Call Alert ("恭喜你,注册成功,请等待管理员审核!","../")
		End if
	rs.close
	Set rs=nothing
End if
%>