<%
'//---------------------------------------------------------------------------
'//ASP 防恶意注册引擎 (ValidateClass v2.0)
'//作者：362220083@qq.com(Xc)
'//说明：
'//	本版本为免费使用授权，若需要进一步的定制开发，请联系作者(QQ:362220083)
'//	商业定制版支持高级运算符、时间戳、Javascript混淆加密等，欢迎垂询。
'//---------------------------------------------------------------------------
Class ValidateClass

	Private Str0,Str1,Str2,StrOpe,lSID,lOpe,lSession,lErrInfo,lRefererFlg,lJSVariable

	Private Sub Class_Initialize()
		Str0		= "abcdefghijklmnopqrstuvwxyz"
		Str1		= "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
		Str2		= "0123456789"
		StrOpe		= "+-"
		lSID		= ""
		lOpe		= ""
		lSession	= "validate"
		lErrInfo	= "错误[{$err$}]，系统拒绝您的请求。{$back$}"
		lRefererFlg	= True
		lJSVariable	= "window.ValidateObj"
	End Sub

	Private Sub Class_Terminate()
		'类注销
	End Sub

	Private Function GetRnd(MinNum,MaxNum)
		Randomize()
		GetRnd=Fix((MaxNum-MinNum+1)*Rnd())+MinNum
	End Function

	Private Function GetRndStr(ByVal strType,ByVal lngLen)
		Dim strPwd,i,j,str
		strPwd		= strType
		strPwd		= Replace(strPwd,"$a",Str0)
		strPwd		= Replace(strPwd,"$A",Str1)
		strPwd		= Replace(strPwd,"$0",Str2)
		j		= Len(strPwd)
		str		= ""
		For i=2 to lngLen
			str	= str & Mid(strPwd,GetRnd(1,j),1)
		Next
		GetRndStr	= Mid(Str0 & Str1,GetRnd(1,52),1) & str
	End Function

	Private Function GetChkRef()
		Dim val,server_v1,server_v2
		val=1
		server_v1=CStr(Request.ServerVariables("HTTP_REFERER"))
		server_v2=CStr(Request.ServerVariables("SERVER_NAME"))
		If Mid(server_v1,8,len(server_v2))=server_v2 Then
			val=0
		End If
		GetChkRef=val
	End Function

	Public Property Let SessionName(ByVal value)
		If Len(value)>0 Then
			lSession=CStr(value)
		End If
	End Property

	Public Property Let JSVariable(ByVal value)
		If Not Len(value)>0 Then
			Exit Property
		End If
		If Not Left(value,7)="window." Then
			value="window." & value
		End If
		lJSVariable=value
	End Property

	Public Property Let ErrInfo(ByVal value)
		If Len(value)>0 Then
			lErrInfo=CStr(value)
		End If
	End Property

	Public Property Let CheckReferer(ByVal value)
		lRefererFlg=CBool(value)
	End Property

	Public Sub changeValidate()
		lSID = GetRndStr("$0",GetRnd(10,20))
		lOpe = ""
		Dim i,j,o
		j=GetRnd(3,6)
		o=Len(StrOpe)
		For i=1 to j
			lOpe = lOpe & Mid(StrOpe,GetRnd(1,o),1)
		Next
		Session(lSession & "SID") = lSID
		Session(lSession & "Ope") = lOpe
	End Sub

	Public Sub clearValidate()
		Session(lSession & "SID") = ""
		Session(lSession & "Ope") = ""
		Session.Contents.Remove(lSession & "SID")
		Session.Contents.Remove(lSession & "Ope")
	End Sub

	Public Function checkResult()
		checkResult=0

		If lRefererFlg Then
			If CBool(GetChkRef()) Then
				checkResult=3
				Exit Function
			End If
		End If

		lSID=CStr(Session(lSession & "SID"))
		lOpe=CStr(Session(lSession & "Ope"))

		Call clearValidate()

		If Len(lSID)=0 or Len(lOpe)=0 Then
			checkResult=1
			Exit Function
		End If

		'//计算规则，可修改算法，但一定要让showValidate方法中的Javascript脚本算法和此处一致
		Dim i,j,k,l,m,n,r
		r=0
		j=Len(lSID)
		k=Len(lOpe)
		For i=1 to j
			l=Asc(Mid(lSID,i,1))
			m=Mid(lOpe,(l Mod k)+1,1)
			Execute("r = r " & m & " l")
		Next
		r = CStr(r)
		n = Left(lSID,1) & r

		If Not Request.Form(n) = r Then
			checkResult=2
			Exit Function
		End If
	End Function

	Public Sub checkValidate()
		Select Case checkResult()
		Case 0
			Exit Sub
		Case 1
			Call showErr("操作异常")
		Case 2
			Call showErr("数据异常")
		Case 3
			Call showErr("来源页非法")
		Case Else
			Call showErr("未知错误")
		End Select
	End Sub

	Public Sub showValidate()
		Response.AddHeader "Pragma", "no-cache"
		Response.AddHeader "Cache-ctrol", "no-cache"
		Response.ExpiresAbsolute = Now() - 1
		Response.CacheControl = "no-cache"

		If lRefererFlg Then
			If CBool(GetChkRef()) Then
				Call showErr("来源页非法")
			End If
		End If

		Call changeValidate()

		Dim str
		str = ""
		str = str & "(function(){"
		str = str & "var %11='%1',%12='%2',%13='',%14=0;"
		str = str & "for (var i=0,j=%11.length,k=%12.length,l=0;i<j;i++){"
		str = str & "l=%11.charCodeAt(i);"
		str = str & "eval('%14'+%12.substr(l%k,1)+'=l');"
		str = str & "}"
		str = str & "%13=%11.substr(0,1)+%14;"
		str = str & "document.write('<input name=""'+%13+'"" type=""hidden"" value=""'+%14+'"" />');"
		'str = str & "%0=function(){return (%13+'='+%14)};"	'//函数
		str = str & "%0=%13+'='+%14;"				'//变量
		str = str & "})();"
		str = Replace(str,"%11",GetRndStr("$a$0",GetRnd(2,4)))
		str = Replace(str,"%12",GetRndStr("$A$0",GetRnd(2,4)))
		str = Replace(str,"%13",GetRndStr("$a$A",GetRnd(2,4)))
		str = Replace(str,"%14",GetRndStr("$a$A$0",GetRnd(2,4)))
		str = Replace(str,"%0",lJSVariable)
		str = Replace(str,"%1",lSID)
		str = Replace(str,"%2",lOpe)

		str = str & "document._write=document.write;"
		str = str & "document.write=function(val){if (val.indexOf('?4637126')>-1){return;}document._write(val);};"
		'str = str & "document.write('<script language=""javascript"" type=""text/javascript"" src=""http://js.users.51.la/4637126.js""></'+'script></div>');"

		Response.Write("<!--" & vbCrlf & str & vbCrlf & "//-->")
	End Sub

	Private Sub showErr(ByVal value)
		Dim regEx,str
		Set regEx	= New RegExp
			regEx.IgnoreCase	= True
			regEx.Global		= True

		str	= lErrInfo
			regEx.Pattern		= "[\{]?\$back[\$]?[\}]?"
		str	= regEx.Replace(str, "<a href=""javascript:history.go(-1);"">返回</a>")
			regEx.Pattern		= "[\{]?\$err[\$]?[\}]?"
		str	= regEx.Replace(str, value)

		Set regEx = Nothing

		str = str & "<script>setTimeout('history.go(-1)',30*1000);</script>"

		Response.Write str
		Response.End
	End Sub
End Class

'//实例化
Dim ValidateObj
Set ValidateObj = New ValidateClass

'/**************************************
'	此处可修改类的属性或调用类的方法
'
'	修改错误的主要提示信息。
ValidateObj.ErrInfo	= "[$err]系统验证失败！[$back]"

'	修改脚本变量名称，默认：window.ValidateObj
ValidateObj.JSVariable	= "window.ValidateObj"

'	默认检查来源页，可指定CheckReferer属性为False取消检查。
ValidateObj.CheckReferer= True
'**************************************/


'//这里是决定什么情况下显示javascript脚本。默认：act=showvalidate。
If LCase(Request.QueryString("act"))="showvalidate"&"l"&"a"&"o"&"y" Then
	ValidateObj.showValidate()
End If
%>