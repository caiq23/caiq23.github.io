<script language="jscript" runat="server">
function getjson(str){
        try{
           eval("var jsonStr = (" + str + ")");
        }catch(ex){
           var jsonStr = null;
        }
        return jsonStr;
}
</script>
<%
'==================================
'=类 名 称：QqConnet
'=功    能：QQ登录 For ASP
'=作    者：㊣FireFox㊣
'=Q      Q: 63572063
'=日    期：2012-01-02
'==================================
'转载时请保留以上内容！！
Class QqConnet
    Private QQ_OAUTH_CONSUMER_KEY
    Private QQ_OAUTH_CONSUMER_SECRET
	Private QQ_CALLBACK_URL
	Private QQ_SCOPE
        
    Private Sub Class_Initialize      
        QQ_OAUTH_CONSUMER_KEY = "0"				'你的APP ID
        QQ_OAUTH_CONSUMER_SECRET = "8fe40kd52a5e65d8209adf5c82e5467"		'你的APP KEY
        QQ_CALLBACK_URL = "http://你的域名/api/qq/qqbind.asp"		'返回地址，改域名即可
	QQ_SCOPE ="get_user_info,add_t,add_share,get_info,add_topic" 	'授权项 例如：QQ_SCOPE=get_user_info,list_album,upload_pic,do_like,add_t 
                                                '不传则默认请求对接口get_user_info进行授权。
                                                '建议控制授权项的数量，只传入必要的接口名称，因为授权项越多，用户越可能拒绝进行任何授权。
    End Sub
    Property Get APP_ID()    
        APP_ID = QQ_OAUTH_CONSUMER_KEY    
    End Property

	'生成Session("State")数据.
	Public Function MakeRandNum()
		Randomize
		Dim width : width = 6 '随机数长度,默认6位
		width = 10 ^ (width - 1)
		MakeRandNum = Int((width*10 - width) * Rnd() + width)
	End Function
	
	Private Function CheckXml()
        Dim oxml,Getxmlhttp
        On Error Resume Next
        oxml=array("Microsoft.XMLHTTP","Msxml2.ServerXMLHTTP.6.0","Msxml2.ServerXMLHTTP.5.0","Msxml2.ServerXMLHTTP.4.0","Msxml2.ServerXMLHTTP.3.0","Msxml2.ServerXMLHTTP","Msxml2.XMLHTTP.6.0","Msxml2.XMLHTTP.5.0","Msxml2.XMLHTTP.4.0","Msxml2.XMLHTTP.3.0","Msxml2.XMLHTTP")
        For i=0 to ubound(oxml)
           Set Getxmlhttp = Server.CreateObject(oxml(i))
           If Err Then
              Err.Clear
              CheckXml = False
           Else
              CheckXml = oxml(i) :Exit Function
           End if
       Next
     End Function

	
	'Get方法请求url,获取请求内容
	Private Function RequestUrl(url)
		Set XmlObj = Server.CreateObject("Msxml2.ServerXMLHTTP.3.0")
		XmlObj.open "GET",url, false
		XmlObj.send
		If XmlObj.Readystate=4 Then
	       RequestUrl = XmlObj.responseText
	    Else
	       Response.Write("xmlhttp请求超时！") 
		   Response.End()
	    End If
		Set XmlObj = nothing
	End Function
	
	'Post方法请求url,获取请求内容
	Private Function RequestUrl_post(url,data)
		Set XmlObj = Server.CreateObject("Msxml2.ServerXMLHTTP.3.0")
		XmlObj.open "POST", url, false
		XmlObj.setrequestheader "POST"," /t/add_t HTTP/1.1"
		XmlObj.setrequestheader "Host"," graph.qq.com "
		XmlObj.setrequestheader "content-length ",len(data)  
        XmlObj.setRequestHeader "Content-Type "," application/x-www-form-urlencoded "
		XmlObj.setrequestheader "Connection"," Keep-Alive"
        XmlObj.setrequestheader "Cache-Control"," no-cache"
        XmlObj.send(data)
		If XmlObj.Readystate=4 Then
	       RequestUrl_post = XmlObj.responseText
	    Else
	       Response.Write("xmlhttp请求超时！") 
		   Response.End()
	    End If
		Set XmlObj = nothing
	End Function
	
	
	Private Function CheckData(data,str)
		If Instr(data,str)>0 Then
		   CheckData = True
		Else
		   CheckData = False
		End If
	End Function
	

	
	'生成登录地址
	Public Function GetAuthorization_Code()
		Dim url, params
		url = "https://graph.qq.com/oauth2.0/authorize"
		params = "client_id=" & QQ_OAUTH_CONSUMER_KEY
		params = params & "&redirect_uri=" & QQ_CALLBACK_URL
		params = params & "&response_type=code"
		params = params & "&scope="&QQ_SCOPE
		params = params & "&state="&Session("State")
		url = url & "?" & params
		GetAuthorization_Code = (url)
	End Function
	
	
	'获取 access_token
	Public Function GetAccess_Token()
		Dim url, params,Temp
		Url="https://graph.qq.com/oauth2.0/token"
	    params = "client_id=" & QQ_OAUTH_CONSUMER_KEY
		params = params & "&client_secret=" & QQ_OAUTH_CONSUMER_SECRET
		params = params & "&redirect_uri=" & QQ_CALLBACK_URL
		params = params & "&grant_type=authorization_code"
		params = params & "&code="&Session("Code")
		params = params & "&state="&Session("State")
		url = Url & "?" & params
		Temp=RequestUrl(url)
		If CheckData(Temp,"access_token=") = True Then
           GetAccess_Token=CutStr(Temp,"access_token=","&")
		Else
		   Response.Write("获取 access_token 时发生错误，错误代码："&CutStr(Temp,"{""error"":",",")) 
		   Response.End()
		End If
	End Function
	
	'检测是否合法登录！
	Public Function CheckLogin()
		Dim Code,mState
		Code=Trim(Request.QueryString("code"))
		If Code<>"" Then
			CheckLogin = True
			Session("Code")=Code
		Else
			CheckLogin = False
		End If
	End Function
	
	'获取openid
	Public Function Getopenid()
		Dim url, params,Temp
		url = "https://graph.qq.com/oauth2.0/me"
		params = "access_token="&Session("Access_Token")
		url = Url & "?" & params
		Temp=RequestUrl(url)
		If Instr(Temp,"openid")>0 Then
		   set obj = getjson(CutStr(Temp,"(",")"))
		   if isobject(obj) Then
		       Getopenid=obj.openid
		   End If
		  set obj = Nothing
		Else
		   
		   set obj = getjson(CutStr(Temp,"(",")"))
		   if isobject(obj) Then
		       ret = obj.error
			   msg = obj.error_description
		   End If
		  set obj = Nothing
		    Response.Write("获取 openid 时发生错误，错误代码："&ret&" , 错误描述："&msg) 
		   Response.End()
		End If
	End Function
		
	'获取用户信息,得到一个json格式的字符串
	Public Function GetUserInfo()
		Dim url, params, result
		url = "https://graph.qq.com/user/get_user_info"
		params = "oauth_consumer_key=" & QQ_OAUTH_CONSUMER_KEY
		params = params & "&access_token=" & Session("Access_Token")
		params = params & "&openid=" & Session("Openid")
		url = url & "?" & params
		Temp = RequestUrl(url)
		If CheckData(Temp,"nickname") = False Then
		    set obj = getjson(Temp)
		   if isobject(obj) Then
		       ret = obj.ret
			   msg = obj.msg
		   End If
		  set obj = Nothing
		   Response.Write("获取用户信息时发生错误，错误代码："&ret&" , 错误描述："&msg) 
		   Response.End()
		End If
		GetUserInfo = Temp
	End Function
	
	'获取腾讯微博登录用户的用户资料,得到一个json格式的字符串
	Public Function Get_Info()
		Dim url, params, result
		url = "https://graph.qq.com/user/get_info"
		params = "oauth_consumer_key=" & QQ_OAUTH_CONSUMER_KEY
		params = params & "&access_token=" & Session("Access_Token")
		params = params & "&openid=" & Session("Openid")
		params = params & "&format=json"
		url = url & "?" & params
		Get_Info = RequestUrl(url)
	End Function

	
	'获取用户名字,性别,从json字符串里截取相关字符
	Public Function GetUserName(json)
	    Dim nickname,sex,obj
		set obj = getjson(json)
		   if isobject(obj) Then
		       nickname = obj.nickname
			   sex = obj.gender
		   End If
		  set obj = Nothing
	    GetUserName = Array(nickname,sex)
	End Function
	
	Public Function CutStr(data,s_str,e_str)
	    If Instr(data,s_str)>0 and Instr(data,e_str)>0 Then
		   CutStr = Split(data,s_str)(1)
		   CutStr = Split(CutStr,e_str)(0)
		Else
		   CutStr = ""
		End If
	End Function
	
End Class
%>