<%
'****************************************************
' 老Y文章管理系统 Power by laoy.net
' Web: http://www.laoy.net
' Copyright (C) 2008-2013 laoy.net All Rights Reserved.
'****************************************************
call fsoinit()
Function Mydb(MySqlstr,MyDBType)
	Select Case MyDBType
	Case 0 : Conn.Execute(MySqlstr) : Dataquery = Dataquery + 1
	Case 1 : Set Mydb = Conn.Execute(MySqlstr) : Dataquery = Dataquery + 1
	Case 2 : Set Mydb = Server.CreateObject("Adodb.Recordset") : Mydb.Open MySqlstr,Conn,1,1 : Dataquery = Dataquery + 1
	case 3:
		set db = server.createobject("Adodb.Recordset")
		db.open sqlstr, conn, 1, 3
	End Select
End Function
	
Function CheckStr(str) 
	CheckStr=replace(replace(replace(replace(str,"<","&lt;"),">","&gt;"),chr(13),"")," ","") 
	CheckStr=replace(replace(replace(replace(CheckStr,"'",""),"and",""),"insert",""),"set","") 
	CheckStr=replace(replace(replace(replace(CheckStr,"select",""),"update",""),"delete",""),chr(34),"")
	CheckStr=replace(replace(replace(replace(CheckStr,"*",""),"=",""),"mid",""),"count","")
	CheckStr=replace(replace(replace(replace(replace(CheckStr,"%",""),",",""),"union",""),"where",""),"loop","")
	CheckStr=replace(replace(replace(replace(replace(CheckStr,"(",""),")",""),Chr(0),""),"+",""),";","")
end Function

Function pagere(str) 
	pagere=replace(replace(replace(replace(str,"<","&lt;"),">","&gt;"),chr(13),"")," ","") 
	pagere=replace(replace(replace(replace(pagere,"'",""),"and",""),"insert",""),"set","") 
	pagere=replace(replace(replace(pagere,"select",""),"update",""),"delete","")
	pagere=replace(replace(replace(pagere,"*",""),"mid",""),"count","")
	pagere=replace(replace(replace(replace(pagere,",",""),"union",""),"where",""),"loop","")
	pagere=replace(replace(replace(replace(replace(pagere,"(",""),")",""),Chr(0),""),"+",""),";","")
end Function

Function LaoYRequest(ParaName)
     Dim ParaValue
     ParaValue = trim(ParaName)
	 If ParaValue="" Then Exit Function
        If Not isNumeric(ParaValue) Then
		    Response.Write "<li>  参数类型不合法"
			Response.end
	    Else
           LaoYRequest = ParaValue
        End If
End Function

Function ScriptTime()
	ScriptTime = "执行时间：" & FormatNumber((Timer() - laoystime)*1000, 3) & " ms "
End Function

Function GetIP() 
	Dim strIPAddr 
	If Request.ServerVariables("HTTP_X_FORWARDED_FOR") = "" Or InStr(Request.ServerVariables("HTTP_X_FORWARDED_FOR"), "unknown") > 0 Then 
		strIPAddr = Request.ServerVariables("REMOTE_ADDR") 
	ElseIf InStr(Request.ServerVariables("HTTP_X_FORWARDED_FOR"), ",") > 0 Then 
		strIPAddr = Mid(Request.ServerVariables("HTTP_X_FORWARDED_FOR"), 1, InStr(Request.ServerVariables("HTTP_X_FORWARDED_FOR"), ",")-1) 
	ElseIf InStr(Request.ServerVariables("HTTP_X_FORWARDED_FOR"), ";") > 0 Then 
		strIPAddr = Mid(Request.ServerVariables("HTTP_X_FORWARDED_FOR"), 1, InStr(Request.ServerVariables("HTTP_X_FORWARDED_FOR"), ";")-1)
	Else 
		strIPAddr = Request.ServerVariables("HTTP_X_FORWARDED_FOR") 
	End If 
	getIP = Checkstr(Trim(Mid(strIPAddr, 1, 30)))
	If getIP="" then getIP="127.0.0.1"
End Function

Function ShowAD(id)
	if id = "" or isnull(id) then
		ShowAD = ""
	else
		Sqld = "Select * from "&tbname&"_AD where yn = 1 And title = '" & id &"'"
		Set rsd = conn.execute(Sqld)
		if not rsd.eof then
			ShowAD = laoy(rsd("Content"))
		else
			ShowAD = ""
		end if
		rsd.close
	end if
End function

Function Label(id)
	if id = "" or isnull(id) then
		Label = ""
	else
		Sqld = "Select Content from "&tbname&"_Label where ID = " & id
		Set rsd = conn.execute(Sqld)
		if not rsd.eof then
			Label = rsd(0)
			If id=2 and not laoyvip then Label="	<li>P"&"o"&"w"&"e"&"r"&"e"&"d"&" b"&"y <b>"&"l"&"a"&"o"&"y"&"!"&" <a href=""ht"&"tp:"&"/"&"/"&"ww"&"w."&"l"&"a"&"o"&"y"&".n"&"et""  target=""_blank"">"&Version&"</a></b></li>"&Label '注意：免费用户禁止修改以上版权显示，违者必究！
		else
			Label = ""
		end if
		rsd.close
	end if
End function

Function LoseHtml(ContentStr)
 Dim ClsTempLoseStr,regEx
	ClsTempLoseStr = Cstr(ContentStr)
	Set regEx = New RegExp
	regEx.Pattern = "<(.[^>]*)>"
	regEx.IgnoreCase = True
	regEx.Global = True
	ClsTempLoseStr = regEx.Replace(ClsTempLoseStr,"")
	RegEx.Pattern = "(&.+?;)"
	ClsTempLoseStr = RegEx.Replace(ClsTempLoseStr, "")
	ClsTempLoseStr = Replace(ClsTempLoseStr,VbCrlf,"")
	ClsTempLoseStr = Replace(ClsTempLoseStr,VbCr,"")
	ClsTempLoseStr = Replace(ClsTempLoseStr,VbLf,"")
	ClsTempLoseStr = Replace(ClsTempLoseStr,"  ","")
	ClsTempLoseStr = Replace(ClsTempLoseStr,"","")
	ClsTempLoseStr = Replace(ClsTempLoseStr,"""","'")
	ClsTempLoseStr = Replace(ClsTempLoseStr,"[code]","")
	ClsTempLoseStr = Replace(ClsTempLoseStr,"<!--","")
	ClsTempLoseStr = Trim(ClsTempLoseStr)
 LoseHtml = ClsTempLoseStr
End Function

Function dvHTMLEncode(fString)
if not isnull(fString) then
    fString = replace(fString, ">", "&gt;")
    fString = replace(fString, "<", "&lt;")

    fString = Replace(fString, CHR(32), "&nbsp;")
    fString = Replace(fString, CHR(9), "&nbsp;")
    fString = Replace(fString, CHR(34), "&quot;")
    fString = Replace(fString, CHR(39), "&#39;")
    fString = Replace(fString, CHR(13), "")
    fString = Replace(fString, CHR(10) & CHR(10), "</P><P> ")
    fString = Replace(fString, CHR(10), "<BR> ")

    dvHTMLEncode = fString
end if
end Function

Function HasChinese(str) 
HasChinese = false 
dim i 
for i=1 to Len(str) 
if Asc(Mid(str,i,1)) < 0 then 
HasChinese = true 
exit for 
end if 
next 
end Function

Function replacecolor(Str)
	Dim re,s
	S=Str
	Set re=new RegExp
	re.IgnoreCase =True
	re.Global=True
	re.Pattern="("& KeyWord &")"
	s=re.Replace(s,"<font color='red'>"& KeyWord &"</font>")
	Set Re=Nothing
	replacecolor=s
End Function

Function iparray(ipstr)
 dim t,ipx,ipfb
 if not isnull(ipstr) then
        t = 0
 ipx=""
 ipfb = split(ipstr, ".",4)
  for t = 0 to 2
  ipx = ipx&ipfb(t)&"."
  next
 iparray = ipx&"*"
 end if
end Function

function fsoinit()
	if not isobject(fso) then set fso = server.createobject(strobjectfso)
end function

'判断数字奇偶
Function isEven(num)
if not isNumeric(num) then
isEven="这不是一个数字啊"
exit Function
end if
if num mod 2 = 0 then
isEven=0
else
isEven=1
end if
end Function

Function FormatDate(DateAndTime,para,red)
	On Error Resume Next
	Dim y, m, d, h, mi, s, strDateTime
	FormatDate = DateAndTime
	
	If Not IsNumeric(para) Then Exit Function
	If Not IsDate(DateAndTime) Then Exit Function
	y = CStr(Year(DateAndTime))
	m = CStr(Month(DateAndTime))
	If Len(m) = 1 Then m = "0" & m
	d = CStr(Day(DateAndTime))
	If Len(d) = 1 Then d = "0" & d
	h = CStr(Hour(DateAndTime))
	If Len(h) = 1 Then h = "0" & h
	mi = CStr(Minute(DateAndTime))
	If Len(mi) = 1 Then mi = "0" & mi
	s = CStr(Second(DateAndTime))
	If Len(s) = 1 Then s = "0" & s
	
	Select Case para
		Case "1"
			strDateTime = y & "-" & m & "-" & d & " " & h & ":" & mi & ":" & s
		Case "2"
			strDateTime = y & "-" & m & "-" & d
		Case "3"
			strDateTime = y & "/" & m & "/" & d
		Case "4"
			strDateTime = y & "年" & m & "月" & d & "日"
		Case "5"
			strDateTime = m & "-" & d
		Case "6"
			strDateTime = m & "/" & d
		Case "7"
			strDateTime = m & "月" & d & "日"
		Case "8"
			strDateTime = y & "年" & m & "月"
		Case "9"
			strDateTime = y & "-" & m
		Case "10"
			strDateTime = y & "/" & m
		Case "11"
			strDateTime = y & "-" & m & "-" & d
		Case "12"
			strDateTime = y & m & d & "_" & h & mi & s			
		Case Else
			strDateTime = DateAndTime
		End Select
	
	If red=0 then	
	FormatDate = strDateTime
	else
		If datediff("d",DateAndTime,Now())=0 then
		FormatDate = "<font color=#ff0000>"&strDateTime&"</font>"
		else
		FormatDate = strDateTime
		End if
	End if
End Function

'=================================================
'过程名：BbbImg
'作  用：鼠标滚轮控制图片大小的函数
'参  数：strText
'=================================================
Function BbbImg(strText)
         Dim s,re
         Set re=New RegExp
         re.IgnoreCase = true
         re.Global = true		 
         s=strText
		 
		'去掉图片中的脚本代码
		re.Pattern="<IMG.[^>]*SRC(=| )(.[^>]*)>"
		If mouserimg=1 then
		s=re.replace(s,"<img src=$2 onload=""javascript:resizeimg(this,575,600)"">")
		elseIf mouserimg=2 then
		s=re.replace(s,"<img src=$2 onload=""javascript:DrawImage(this,310)"">")
		else
		s=re.replace(s,"<img src=$2 onload=""javascript:DrawImage(this,600)"">")
		End if
		BbbImg = ChkBadWords(s)
	    Set re=Nothing
End Function

Sub Echo(ByVal t0)
	Response.Write t0
End Sub

'脏话过滤
Function ChkBadWords(Str)
		If IsNull(Str) Then Exit Function
		On Error Resume Next
		Dim i,rBadWord,BadWord
		BadWord	= BadWord1
		BadWord = Split(BadWord,"|||")
		For i = 0 To Ubound(BadWord)
			rBadWord = Split(BadWord(i),"=")
			Str = Replace(Str,rBadWord(0),rBadWord(1))
		Next
		ChkBadWords = Str
End Function

'用户名检测
Function ChkRegName(str)
	ChkRegName = True
	On Error Resume Next
	For i=0 To Ubound(Split(userWord,","))
		If Instr(Str,Split(userWord,",")(i)) > 0 Then
			ChkRegName = False
			Exit Function
		End If
	Next
End Function

'# IIF
Function IIF(A,B,C)
	If A Then IIF = B Else IIF = C
End Function

Function laoy(block)
	if not isnull(block) then
    block = Replace(block, "{$SitePath}", SitePath)
    laoy = block
	end if
End Function

'搜索蜘蛛
Function spiderbot()
	dim agent
	agent = lcase(request.servervariables("http_user_agent"))
	dim Bot: Bot = ""
	
	'百度
	if instr(agent, "baiduspider") > 0 then Bot = "百度"
	if instr(agent, "baiduspider-image") > 0 then Bot = "百度图片"
	if instr(agent, "baiducustomer") > 0 then Bot = "百度"
	if instr(agent, "baidu-thumbnail") > 0 then Bot = "百度"
	if instr(agent, "baiduspider-mobile-gate") > 0 then Bot = "百度"
	if instr(agent, "baidu-transcoder/1.0.6.0") > 0 then Bot = "百度"
	'谷歌google
	if instr(agent, "googlebot/2.1") > 0 then Bot = "谷歌"
	if instr(agent, "googlebot-image/1.0") > 0 then Bot = "谷歌"
	if instr(agent, "feedfetcher-google") > 0 then Bot = "谷歌"
	if instr(agent, "mediapartners-google") > 0 then Bot = "谷歌"
	if instr(agent, "adsbot-google") > 0 then Bot = "谷歌"
	if instr(agent, "googlebot-mobile/2.1") > 0 then Bot = "谷歌"
	if instr(agent, "googlefriendconnect/1.0") > 0 then Bot = "谷歌"
	'雅虎yahoo
	if instr(agent, "yahoo! slurp;") > 0 then Bot = "雅虎"
	if instr(agent, "yahoo! slurp/3.0") > 0 then Bot = "雅虎"
	if instr(agent, "yahoo! slurp china") > 0 then Bot = "雅虎"
	if instr(agent, "yahoofeedseeker/2.0") > 0 then Bot = "雅虎"
	if instr(agent, "yahoo-blogs") > 0 then Bot = "雅虎"
	if instr(agent, "yahoo-mmcrawler") > 0 then Bot = "雅虎"
	if instr(agent, "yahoo contentmatch crawler") > 0 then Bot = "雅虎"
	'微软bing
	if instr(agent, "msnbot/1.1") > 0 then Bot = "微软bing"
	if instr(agent, "msnbot/2.0b") > 0 then Bot = "微软bing"
	if instr(agent, "msrabot/2.0/1.0") > 0 then Bot = "微软bing"
	if instr(agent, "msnbot-media/1.0") > 0 then Bot = "微软bing"
	if instr(agent, "msnbot-products") > 0 then Bot = "微软bing"
	if instr(agent, "msnbot-academic") > 0 then Bot = "微软bing"
	if instr(agent, "msnbot-newsblogs") > 0 then Bot = "微软bing"
	'360
	if instr(agent, "360spider") > 0 then Bot = "360搜索"
	'腾讯搜搜soso
	if instr(agent, "sosospider") > 0 then Bot = "腾讯搜搜"
	if instr(agent, "sosoblogspider") > 0 then Bot = "腾讯搜搜"
	if instr(agent, "sosoimagespider") > 0 then Bot = "腾讯搜搜"
	'网易有道
	if instr(agent, "youdaobot/1.0") > 0 then Bot = "网易有道"
	if instr(agent, "yodaobot-image/1.0") > 0 then Bot = "网易有道"
	if instr(agent, "yodaobot-reader/1.0") > 0 then Bot = "网易有道"
	'搜狐搜狗
	if instr(agent, "sogou web robot") > 0 then Bot = "搜狗"
	if instr(agent, "sogou web spider/3.0") > 0 then Bot = "搜狗"
	if instr(agent, "sogou web spider/4.0") > 0 then Bot = "搜狗"
	if instr(agent, "sogou head spider/3.0") > 0 then Bot = "搜狗"
	if instr(agent, "sogou-test-spider/4.0") > 0 then Bot = "搜狗"
	if instr(agent, "sogou orion spider/4.0") > 0 then Bot = "搜狗"
	'Alexa
	if instr(agent, "ia_archiver") > 0 then Bot = "Alexa"
	if instr(agent, "iaarchiver") > 0 then Bot = "Alexa"
	'奇虎
	if instr(agent, "qihoo") > 0 then Bot = "Qihoo"
	'ASK.com
	if instr(agent, "ask jeeves/teoma") > 0 then Bot = "Ask Jeeves/Teoma"
	if len(Bot) > 0 then
		set rs = server.CreateObject ("adodb.recordset")
		sql="select [Botname],[LastDate] From ["&tbname&"_Bots] Where [Botname]='" & Bot & "'"
		rs.open sql,conn,1,3
		if rs.eof and rs.bof then
		rs.AddNew 
		rs(0) = Bot
		rs(1) = now()
		else
		rs(1) = now()
		end if
		rs.update
		rs.close: set rs = nothing
	end if
end Function

function createfile(byval content,byval filedir)
	filedir = replace(filedir, "\", "/") : filedir = replace(filedir, "//", "/")
	if right(filedir, 1) = "/" then filedir = filedir & "index.html"
	call createfolder(filedir)
	on error resume next
	dim obj : set obj = server.createobject(strobjectads)
	obj.type = 2
	obj.open
	obj.charset = "GB2312"
	obj.position = obj.Size
	obj.writeText = content
	obj.savetofile server.mappath(filedir), 2
	obj.close
	if err then err.clear: createfile = false else createfile = true
	set obj = nothing
end function
' 创建文件夹
function createfolder(byval dirpath)
	dirpath = replace(dirpath, "\", "/") : dirpath = replace(dirpath, "//", "/")
		dim subpath, pathdeep, i
		dirpath = replace(server.mappath(dirpath), server.mappath("/"), "")
		subpath = split(dirpath, "\")
		pathdeep = pathdeep & server.mappath("/")
		for i = 1 to ubound(subpath) - 1
			pathdeep = pathdeep & "/" & subpath(i)
			if not fso.folderexists(pathdeep) then fso.createfolder pathdeep
		next
end function
' 删除文件
function deletefile(byval filedir)
	if len(filedir) = 0 or isnull(filedir) then exit function
	filedir = replace(filedir, "\", "/") : filedir = replace(filedir, "//", "/")
	if right(filedir, 1) = "/" then
		eletefile = deletefolder(filedir)
	else
		on error resume next
		fso.deletefile server.mappath(filedir)
		if err then err.clear: deletefile = false else deletefile = true
	end if
end function
' 删除文件夹
function deletefolder(byval dirpath)
	on error resume next
	fso.deletefolder server.mappath(dirpath)
	if err then err.clear: deletefolder = false else deletefolder = true
end function
'计算字数，一个汉字算2个
function getLen(str)
	l=len(str)
	t=0
	for i=1 to l
	c=Abs(Asc(Mid(str,i,1)))
	if c>255 then
	t=t+2
	else
	t=t+1
	end if
	next
	getLen=t
end function
'水印
function laoy_draw(byval ImgfileUrl)
	if not IsobjInstalled("Persits.Jpeg") then exit function
	Dim Jpeg,logo,picwatermarkimg
	picwatermarkimg=sitepath&"images/watermark.png"
	Set Jpeg = Server.CreateObject("Persits.Jpeg") 
	Set logo = Server.CreateObject("Persits.Jpeg")
	on error resume next
	Jpeg.Open Server.MapPath(ImgfileUrl)
	logo.Open Server.MapPath(picwatermarkimg) 
	
	If jpeg.width>280 and jpeg.height>200 then
		If aspjpegtype=1 then
		
			if jpeg.width>logo.width and jpeg.height>logo.height then
			Jpeg.Interpolation=1
			draw_x=drawimage_x(jpeg.width,logo.width,15)
			draw_y=drawimage_y(jpeg.height,logo.height,15)
			Jpeg.Canvas.DrawPNG draw_x, draw_y,Server.MapPath(picwatermarkimg)
			end if
		
		Else
			draw_x=drawimage_x(Jpeg.width,getLen(Fonttext)*FontSize/2 ,10)
			draw_y=drawimage_y(Jpeg.height,FontSize,10)	
			Jpeg.Canvas.Font.Color = "&H"&""&Color1&""
			Jpeg.Canvas.Font.Size = ""&FontSize&""
			Jpeg.Canvas.Font.Family = ""&FontFamily&""
			Jpeg.Canvas.Font.ShadowColor = "&H"&""&Color2&""
			Jpeg.Canvas.Font.ShadowXoffset = 1
			Jpeg.Canvas.Font.ShadowYoffset = 1 
			'Jpeg.Canvas.Font.Quality = 1
			Jpeg.Canvas.Font.Bold = False
			Jpeg.Canvas.Print draw_x,draw_y,""&Fonttext&""
		End If
		
		Jpeg.save Server.mappath(ImgfileUrl)
	End if
	Set Jpeg = Nothing
	Set logo = Nothing
end function

	'x轴坐标边缘距离
	function drawimage_x(byval t0,byval t1,byval t2)
		select Case jpeg_position
			case "0"
				drawimage_x=t2
			case "1"
				drawimage_x=t2
			case "2"
				drawimage_x=(t0-t1)/2
			case "3"
				drawimage_x=t0-t1-t2
			case "4"
				drawimage_x=t0-t1-t2
			case else
				drawimage_x=0
		end select
	end function

	'y轴坐标边缘距离
	function drawimage_y(byval t0,byval t1,byval t2)
		select case jpeg_position
			case "0"
				drawimage_y=t2
			case "1"
				drawimage_y=t0-t1-t2
			case "2"
				drawimage_y=(t0-t1)/2
			case "3"
				drawimage_y=t2
			case "4"
				drawimage_y=t0-t1-t2
			case else
				drawimage_y=0
		end select
	end function
	
'显示相关文章
'P_ConID:数值型，当前文章ID
'P_Key:字符型，当前文章关健字
'P_Row:数值型，要显示相关文章的条数
'P_ICO:字符型，标题前图标，可以图片也可为字符
'P_Time:数值型，显示时间，０为不显示，否则为时间格式

Function ShowMutualityArticle(P_ConID,P_Key,P_Row,P_ICO,P_Time)
    dim pRs,pSql
	dim i,TempKeyWord
	
	if P_Row > 0 then
		pSql = "Select TOP "& P_Row
	else
		pSql = "Select "
	end if
	pSql = pSql & " ID,Title,ClassId,DateAndTime From ["&tbname&"_Article] Where ID <> "& P_ConID &" And "	
	if Instr(P_Key,"|") > 0 then
		P_Key = Split(P_Key,"|")
		TempKeyWord = TempKeyWord &"("
		For i = 0 to Ubound(P_Key)
			TempKeyWord = TempKeyWord &" KeyWord like '%"& P_Key(i) &"%' or KeyWord like '%|"& P_Key(i) &"|%' or KeyWord like '%"& P_Key(i) &"|%' or KeyWord like '%|"& P_Key(i) &"%' "
			if i = Ubound(P_Key) then
				TempKeyWord = TempKeyWord &") And "
			else
				TempKeyWord = TempKeyWord &" Or "
			end if
		Next
	else
		TempKeyWord = TempKeyWord &" KeyWord like '%"& P_Key &"%' And "
	end if
	pSql = pSql & TempKeyWord &" yn = 0 Order By Id Desc"
	
    Set pRs = Server.CreateObject("Adodb.recordset")
	pRs.open pSql,conn,1,3
	if not(pRs.bof and pRs.eof) then
		Do While Not pRs.eof
			if pRs(0) <> P_ConID Then
				ShowMutualityArticle = ShowMutualityArticle & "<li>"&P_ICO&"<a href="""&apath(pRs(0),0)&""">"&pRs(1)&"</a>"
				If P_Time>0 then
				ShowMutualityArticle = ShowMutualityArticle &"　　"&FormatDate(pRs(3),P_Time,1)&""
				End if
				ShowMutualityArticle = ShowMutualityArticle &"</li>" & VbCrLf
			end if
			pRs.movenext
		Loop
	else
		ShowMutualityArticle = ShowMutualityArticle & "<li>没有相关文章</li>"
	end if
	pRs.close:set pRs = nothing
End Function

'图片文章调用
'ClassID:数值型，栏目ID
'N:数值型，要显示文章条数
'T:数值型，显示时间，０为不显示，否则为时间格式
'Z:标题字数
'msql:增强条件
'P:排序方式

Sub ShowImgArticle(ClassID,N,Z,msql,P,w,h,t)
	set rs1=server.createobject("ADODB.Recordset")
	SQL1="select Top "&N&" ID,Title,ClassID,DateAndTime,Images,ArtDescription from "&tbname&"_Article where yn = 0 and Images<>''"
	
	If ClassID<>0 then
		If Yao_MyID(ClassID)="0" then
			SQL1=SQL1&" and ClassID="&ClassID&""
		else
			MyID = Replace(""&Yao_MyID(ClassID)&"","|",",")
			SQL1=SQL1&" and ClassID in ("&MyID&")"
		End if
	End if
	
	If msql<>"no" then
			SQL1=SQL1&" and "&msql&""
	End if
	
	SQL1=SQL1&" Order by "&P&""
	
	rs1.open sql1,conn,1,3
	If Not rs1.Eof Then 
	do while not (rs1.eof or err)
	If t=1 then
	Echo "<dl>"
	Echo "<dt><a href="""&apath(rs1(0),0)&""" target=""_blank""><img src="""&rs1("Images")&""" alt="""&rs1("Title")&""" style=""border:1px solid #ccc;padding:2px;width:"&w&"px;height:"&h&"px;""></a></dt>"
	Echo "<dd><h2><a href="""&apath(rs1(0),0)&""" target=""_blank"">"&rs1("Title")&"</a></h2><div>"&left(LoseHtml(rs1("ArtDescription")),Z)&"</div></dd>"
	Echo "</dl>"
	'Echo "<div ic=""clear""></div>"
	else
	Response.Write("<li><a href="""&apath(rs1(0),0)&""" target=""_blank"">")
    Response.Write("<img src="""&rs1("Images")&""" alt="""&rs1("Title")&""" style=""border:1px solid #ccc;padding:2px;width:"&w&"px;height:"&h&"px;""></a>")
	Response.Write("<br>")
	Response.Write("<a href="""&apath(rs1(0),0)&""" target=""_blank"">"&rs1("Title")&"</a>")
	Response.Write("</li>") & VbCrLf
	End if
	rs1.movenext
	loop
	'else
	'Response.Write("<li>没有</li>")
	end if
	rs1.close
	set rs1=nothing
End Sub

'文章调用
'ClassID:数值型，栏目ID
'N:数值型，要显示文章条数
'T:数值型，显示时间，０为不显示，否则为时间格式
'ICO:字符型，标题前图标，可以图片也可为字符
'Z:标题字数
'msql:增强条件
'P:排序方式
'ClassName 数值型,1为显示栏目名称,0为不显示
'target 数值型,1为在新窗口打开
'标题前续号,1为显示,0不显示

Sub ShowArticle(ClassID,N,T,ICO,Z,msql,P,ClassName,target,LaoyNoI)
	set rs1=server.createobject("ADODB.Recordset")
	SQL1="select Top "&N&" ID,Title,ClassID,DateAndTime,TitleFontColor,IsHot from "&tbname&"_Article where yn = 0"
	
	If ClassID<>0 then
		If Yao_MyID(ClassID)="0" then
			SQL1=SQL1&" and ClassID="&ClassID&""
		else
			MyID = Replace(""&Yao_MyID(ClassID)&"","|",",")
			SQL1=SQL1&" and ClassID in ("&MyID&")"
		End if
	End if
	
	If msql<>"no" then
			SQL1=SQL1&" and "&msql&""
	End if
	
	SQL1=SQL1&" Order by "&P&""
	
	rs1.open sql1,conn,1,3
	If Not rs1.Eof Then 
	NoIx=0
	do while not (rs1.eof or err)
	NoIx=NoIx+1
	Response.Write("<li>")
	If T<>0 then
		Response.Write("<span style=""float:right;font-style:italic;font-family:Arial; "">"&FormatDate(rs1(3),T,1)&"</span>")
	end if
	If ClassName=1 then
		Response.Write("[<a href="""&cpath(rs1(2),0)&""">"&getclass(rs1(2),"classname")&"</a>]")
	End if
	If LaoyNoI=1 then
		If NoIx<4 then
		Response.Write("<font class='laoynoi1'>")
		Else
		Response.Write("<font class='laoynoi2'>")
		End if
		Response.Write(""&right("0" & NoIx, 2)&"</font>.")
	End if
	Response.Write(""&ICO&"<a href="""&apath(rs1(0),0)&"""")
	If target=1 then
	Response.Write(" target=""_blank""")
	End if
	Response.Write(" >")
	If rs1(4)<>"" then
	Response.Write("<font style=""color:"&rs1(4)&""">"&left(rs1(1),Z)&"</font></a>")
	else
	Response.Write(""&left(rs1(1),Z)&"</a>")
	end if
	Response.Write("</li>") & VbCrLf
	rs1.movenext
	loop
	else
	Response.Write("<li>没有</li>")
	end if
	rs1.close
	set rs1=nothing
End Sub

Function Yao_MyID(a)
Yao_MyID=""
 Dim rs1,sql1
 set rs1=server.createobject("ADODB.Recordset")
 sql1="select ID from "&tbname&"_Class where TopID = "&a&""
 rs1.open sql1,conn,1,3
 If Not rs1.Eof Then 
 do while not (rs1.eof or err)

If Yao_MyID = "" then
	Yao_MyID = rs1("ID")
else
	Yao_MyID = Yao_MyID &"|"& rs1("ID")
End if
 rs1.movenext
 loop
 else
Yao_MyID = "0"
 end if
 rs1.close
 set rs1=nothing
End Function

Function getclass(id,datafield)
	if id = "" or isnull(id) then
		getclass = ""
	else
		Sqld = "Select * from "&tbname&"_Class where ID = " & id
		Set rsd = conn.execute(Sqld)
		if not rsd.eof then
			getclass = rsd(datafield)
		else
			getclass = ""
		end if
		rsd.close
	end if
End Function

Function checkpost(byval back)
	dim server_v1, server_v2
	server_v1 = cstr(request.servervariables("http_referer"))
	server_v2 = cstr(request.servervariables("server_name"))
	if Mid(server_v1, 8, len(server_v2)) <> server_v2 then
		if not back then
			response.write lang_errorpost : response.end
		else
			checkpost = false
		end if
	else
		checkpost = true
	end if
end Function

Function Alert(message,gourl) 
    message = replace(message,"'","\'")
    If gourl="-1" then
        Response.Write ("<script language=javascript>alert('" & message & "');history.go(-1)</script>")
    ElseIf gourl="-2" then
        Response.Write ("<script language=javascript>alert('" & message & "');history.go(-2)</script>")
    ElseIf gourl="Close" then
		Response.Write ("<script language=javascript>alert('" & message & "');window.opener=null;window.close();</script>")
	Else
        Response.Write ("<script language=javascript>alert('" & message & "');location='" & gourl &"'</script>")
    End If
    Response.End()
End Function

Function Info(message)
	Response.Redirect ""&SitePath&""&SiteAdmin&"/Info.asp?Info=" & message & ""
    Response.End()
End Function

Function UserInfo(id,Num)
	if id = "" or isnull(id) Then Exit Function
	UserInfo = 0
	Sqld = "Select usergroupid,yn,username from "&tbname&"_User where ID = " & id
	Set rsd = conn.execute(Sqld)
	if not rsd.eof then
		UserInfo 	=rsd(Num)
	end if
	rsd.close
	set rsd=nothing
End Function

'过滤指定html标签

Function lFilterBadHTML(byval strHTML,byval strTAGs)  
  Dim objRegExp,strOutput  
  Dim arrTAG,i
  arrTAG=Split(strTAGs,",")  
  Set objRegExp = New Regexp   
  strOutput=strHTML   
  objRegExp.IgnoreCase = True  
  objRegExp.Global = True  
  For i=0 to UBound(arrTAG)  
    objRegExp.Pattern = "<"&arrTAG(i)&"[\s\S]+</"&arrTAG(i)&"*>"  
    strOutput = objRegExp.Replace(strOutput, "")   
  Next  
  Set objRegExp = Nothing  
  lFilterBadHTML = strOutput   
End Function 

'函数名：EditUserMn
'作用：操作后，给相应用户加分
'参数：str1（被操作的用户名)
'      str2(积分)
'		P_MnType(操作类型，1增加，0减少)
Function EditUserMn(str1,str2,P_MnType)
	dim rs,sql,rs2

	dim EditorTmp,MoneyStr
	sql = "Select UserName From ["&tbname&"_Article] Where ID = "&str1
	Set rs2 = Conn.Execute(sql)
	if not(rs2.eof And rs2.bof) then
		EditorTmp = rs2(0)

		sql = "Select UserMoney From ["&tbname&"_User] Where UserName = '"&EditorTmp&"'"
		Set rs = Server.CreateObject("adodb.recordset")
		rs.open sql,connstr,1,3
		if not(rs.bof and rs.eof) then
			If P_MnType = 1 then
				rs(0) = LaoYRequest(rs(0)) + LaoYRequest(str2)
			else
				rs(0) = LaoYRequest(rs(0)) - LaoYRequest(str2)
			end if
			rs.update
		end if
		rs.close:set rs=nothing
	end if
	
	rs2.close:set rs2=nothing
End Function

'ClassID 链接分类,0为所有
'NUM     调用个数,0为不限
'logo    是否调用logo,1为logo,0为文字
'ClassName是否显示分类名，1为显示

Sub Link(ClassID,Num,logo,ClassName)
	set rs1=server.createobject("ADODB.Recordset")
	SQL1="select"
	If Num<>0 then
		SQL1=SQL1&" top "&Num&""
	End if
	SQL1=SQL1&" ID,Title,ClassID,LinkUrl,LogoUrl,Num from "&tbname&"_Link where yn <> 0 and "
	If IsSqlDataBase = 1 Then
	SQL1=SQL1&"datediff(dd,GetDate(),AddTime) <= 0 and datediff(dd,GetDate(),LastTime) > 0"
	Else
	SQL1=SQL1&"datediff('d',Now(),AddTime) <= 0 and datediff('d',Now(),LastTime) > 0"
	End if
	If ClassID<>0 then
		SQL1=SQL1&" And ClassID = "&ClassID&""
	End if
	If logo=1 then
		SQL1=SQL1&" And LogoUrl <> ''"
	else
		SQL1=SQL1&" And LogoUrl = ''"
	End if
	SQL1=SQL1&" order by num asc,id asc"	
	rs1.open sql1,conn,1,3
	If Not rs1.Eof Then
	If ClassName=1 then 
		Response.Write("<b>"&linkclassname(rs1("ClassID"))&"：</b>")
	End if
	do while not (rs1.eof or err)
	Response.Write("<a href="""&rs1("LinkUrl")&""" target=""_blank"">")
	If rs1("logourl")<>"" then
		Response.Write("<img src="""&rs1("logourl")&""" width=""88"" height=""31"" alt="""&rs1("Title")&""">")
	Else
		Response.Write(""&rs1("Title")&"")
	End if
	Response.Write("</a>") & VbCrLf
	rs1.movenext
	loop
	end if
	rs1.close
	set rs1=nothing
End Sub

Function linkclassname(id)
	if id = "" or isnull(id) then
		linkclassname = ""
	else
		Sqld = "Select LinkName from "&tbname&"_LinkClass where ID = " & id
		Set rsd = conn.execute(Sqld)
		if not rsd.eof then
			linkclassname = rsd(0)
		else
			linkclassname = ""
		end if
		rsd.close
		set rsd=nothing
	end if
End Function

Function showFace(Str)
	for i = 1 to PingNum
	Str=replace(Str,"[laoy:"&i&"]","<img src="""&SitePath&"images/faces/"&i&".gif""></img>")
	Next
	showFace=Str
End Function

Function laoyface(str)
	Dim faceurl
	faceurl=str
	If left(faceurl,4)="http" then
	laoyface=faceurl
	else
	laoyface=SitePath&SiteUp&"/UserFace/"&faceurl
	End if
End Function

Function ReplaceshowFace(Str)
	for i = 1 to PingNum
	Str=replace(Str,"[laoy:"&i&"]","")
	Next
	ReplaceshowFace=Str
End Function

Function RndNumber(Min,Max) 
Randomize 
RndNumber=Int((Max - Min + 1) * Rnd() + Min) 
End Function

Sub ShowVote(t0)
sqlVote="select top 1 id,title,vote,result,stype from "&tbname&"_vote Where yn = 1"
if clng(t0)<>0 then sqlVote=sqlVote&" And id="&clng(t0)&""
sqlVote=sqlVote&" order by id desc"
set rsVote=conn.execute(sqlVote)
if rsVote.eof then
Response.Write ""
else
   if rsVote(4)=1 then
   v_type="radio"
   else
   v_type="checkbox"
   end if
   Response.Write "<form action="""&SitePath&"Vote.asp?action=add&id="&rsVote(0)&""" method=""post"" target=""vote"">" & vbNewLine
   Response.Write "<li><h5 title="""&rsVote(1)&""">"&rsVote(1)&"</h5></li>" & vbNewLine
   'result=split(rsVote(3),"|")
   'for i=0 to ubound(result)
   'next
   vote=split(rsVote(2),"|")
   for ii=0 to ubound(vote)-1
   Response.Write "<li><input type="""&v_type&"""  name=""vote"" value="""&ii&""">"&vote(ii)&"</li>"   & vbNewLine
   next
   Response.Write "<li><input type=""submit"" value=""投票"" class=""artsubmit"">  <input type=""button"" onclick=""window.open('"&SitePath&"Vote.asp?action=see&id="&rsVote(0)&"')"" value=""查看"" class=""artsubmit""></li>" & vbNewLine
   Response.Write "</form>" & vbNewLine
end if
RsVote.Close:Set RsVote = Nothing	
End Sub

Function ShowVoteList(P_VoteID)
	dim oRs
	Set oRs = Conn.Execute("Select ID,Title from "&tbname&"_Vote Order by Px asc,ID desc")
	If Not(oRs.eof And oRs.bof) Then
		Do While Not oRs.eof
			ShowVoteList = ShowVoteList &"<option value='"&oRs("ID")&"'"
			if Instr(","& P_VoteID &",",","& oRs("ID") &",") > 0 Then ShowVoteList = ShowVoteList &" selected"
			ShowVoteList = ShowVoteList &">" & oRs("Title")&"</option>" & vbNewLine
			oRs.movenext
		Loop
	Else
		ShowVoteList = "没有!"
	End If
	oRs.Close:Set oRs = Nothing	
End Function

Function ShowVoteList2(P_VoteID)
		dim oRs,b
		Set oRs = Conn.Execute("Select ID,Title from "&tbname&"_Vote Where ID in("&P_VoteID&")")
			b=split(P_VoteID,",")
			For i = 0 to Ubound(b)
			Response.Write("<div class=""artvote"">") & VbCrLf
			Response.Write("	<ul>") & VbCrLf
				Call ShowVote(b(i))
			Response.Write("	</ul>") & VbCrLf
			Response.Write("</div>") & VbCrLf
			Next
		oRs.Close:Set oRs = Nothing	
End Function

Function ChkSB(str)
	ChkSB = True
	For i=0 To Ubound(Split(KillWord,","))
		If Instr(Str,Split(KillWord,",")(i)) > 0 Then
			ChkSB = False
			Exit Function
		End If
	Next
End Function

Function IsObjInstalled(strClassString)
	On Error Resume Next
	IsObjInstalled = False
	Err = 0
	Dim xTestObj
	Set xTestObj = Server.CreateObject(strClassString)
	If Err = 0 Then IsObjInstalled = True
	If Err = -2147352567 Then IsObjInstalled = True
	Set xTestObj = Nothing
	Err = 0
End Function

Sub Web_Style()
   Dim Sqlp,Rsp,TempStr
   Sqlp ="Select ID,Title from "&tbname&"_Css"   
   Set Rsp=server.CreateObject("adodb.recordset")   
   rsp.open sqlp,conn,1,1 
   If Rsp.Eof and Rsp.Bof Then
      Response.Write("<option value="""">请先添加风格</option>")
   Else
      Do while not Rsp.Eof   
         Response.Write("<option value=""" & Rsp("ID") & """")
		 If int(css)=Rsp("ID") then
				Response.Write(" selected" ) 
		 End if
         Response.Write(">" & Rsp("Title") & "</option>") & VbCrLf
      Rsp.Movenext   
      Loop
   End if
   Rsp.Close:Set Rsp=nothing
End Sub
	
Function ReplaceKey(ByVal Str)
		If IsNull(Str) Then Exit Function
		Dim RsKeyword
		sql="Select * From ["&tbname&"_Key] Order By [Num] Desc"
		Set RsKeyword=Conn.Execute(sql)
		do while not (RsKeyword.eof or err)
		If InStr(Str,RsKeyword("Title")) > 0 Then
			oReplace = RsKeyword("Replace")
			If oReplace=0 then oReplace=-1
			Str = p_replace(Str,RsKeyword("Title"),"<a href="""&RsKeyword("Url")&""" target=""_blank"">"&RsKeyword("Title")&"</a>",1,oReplace,1)
		End if	
		RsKeyword.movenext
		loop
		ReplaceKey = Str
		RsKeyword.Close:Set RsKeyword=nothing
End Function

Function p_replace(byval content,byval asp,byval htm,byval aa,byval Rnum,byval bb)
dim Matches,objRegExp,strs,i
strs=content
Set objRegExp = New Regexp
objRegExp.Global = True
objRegExp.IgnoreCase = True
objRegExp.Pattern = "(\<a[^<>]+\>.+?\<\/a\>)|(\<img[^<>]+\>)"'
Set Matches =objRegExp.Execute(strs)
i=0
Dim MyArray()
For Each Match in Matches
ReDim Preserve MyArray(i)
MyArray(i)=Mid(Match.Value,1,len(Match.Value))
strs=replace(strs,Match.Value,"<"&i&">",1,Rnum,1)
i=i+1
Next
if i=0 then
 content=replace(content,asp,htm,1,Rnum,1)
 p_replace=content
 exit Function
end if
strs=replace(strs,asp,htm,1,Rnum,1)
for i=0 to ubound(MyArray)
strs=replace(strs,"<"&i&">",MyArray(i),1,Rnum,1)
next
p_replace=strs
end Function

Function RandReg(str)
	if str = "" then
		RandReg = ""
	else
		RReg=split(str,CHR(10))
		for i=0 to ubound(RReg)
			RReg1 = RReg(i)
		next
		RandReg = RReg1
	end if
End function

Function ShowlevelOption(P_GroupID)
	dim oRs
	Set oRs = Conn.Execute("Select UserGroupID,GroupName from "&tbname&"_UserGroup order by usergroupid")
	If Not(oRs.eof And oRs.bof) Then
		ShowlevelOption = ShowlevelOption &"<option value='0'"
		if Instr(","& P_GroupID &",",",0,") > 0 Then ShowlevelOption = ShowlevelOption &" selected"
		ShowlevelOption = ShowlevelOption &">游客</option>" & vbNewLine
		Do While Not oRs.eof
			ShowlevelOption = ShowlevelOption &"<option value='"&oRs("UserGroupID")&"'"
			if Instr(","& P_GroupID &",",","& oRs("UserGroupID") &",") > 0 Then ShowlevelOption = ShowlevelOption &" selected"
			ShowlevelOption = ShowlevelOption &">" & oRs("GroupName")&"</option>" & vbNewLine
			oRs.movenext
		Loop
	Else
		ShowlevelOption = "用户组数据丢失,须重新建立用户组"
	End If
	oRs.Close:Set oRs = Nothing	
End Function

Function ShowlevelOption2(P_GroupID)
	dim oRs
	Set oRs = Conn.Execute("Select UserGroupID,GroupName from "&tbname&"_UserGroup order by usergroupid")
	If Not(oRs.eof And oRs.bof) Then
		if Instr(","& P_GroupID &",",",0,") > 0 Then ShowlevelOption2 = "<font color=red>游客</font>"
		Do While Not oRs.eof
			if Instr(","& P_GroupID &",",","& oRs("UserGroupID") &",") > 0 Then
			ShowlevelOption2 = ShowlevelOption2 &" " & oRs("GroupName")&" "
			End if
			oRs.movenext
		Loop
	Else
		ShowlevelOption2 = "用户组数据丢失,须重新建立用户组"
	End If
	oRs.Close:Set oRs = Nothing	
End Function

Function UserGroupInfo(id,num)
	if id = "" or isnull(id) Then
	UserGroupInfo = 0
	Exit Function
	end if
	Sqld = "Select GroupName,UserGroupID,UserPowers,GroupPic,postyn,uploadyn from "&tbname&"_UserGroup where UserGroupID = " & id
	Set rsd = conn.execute(Sqld)
	if not rsd.eof then
		UserGroupInfo 	=rsd(num)
	else
		UserGroupInfo 	=0
	end if
	rsd.close
	set rsd=nothing
End function

Function chkAdmin(byval Level)
	If yaoadmintype<>1 then
		if instr(","&yaomight&",",","& lcase(Level) &",") = 0 then
		Call Info("没有权限")
		End if
	End if
End Function

'广告管理权限
Function chkadAdmin(byval Level)
	If yaoadmintype<>1 then
		if instr(","&yaoadpower&",",","& lcase(Level) &",") = 0 then
		Call Info("没有权限")
		End if
	End if
End Function

'文章管理权限
Function chkArtAdmin(byval Level)
	If yaoadmintype<>1 then
		if instr(","&yaoadpower&",",","& lcase(Level) &",") = 0 then
		Call Info("没有权限")
		End if
	End if
End Function

Function GetImg(str)
set objregEx = new RegExp
objregEx.IgnoreCase = true
objregEx.Global = true
zzstr="src=(.+?).(jpg|gif|png|bmp)"
objregEx.Pattern = zzstr
set matches = objregEx.execute(str)
for each match in matches
retstr = retstr &"|"& Match.Value
next
if retstr<>"" then
Imglist=split(retstr,"|")
GetImg=Imglist(1)
GetImg=replace(GetImg,left(GetImg,5),"")
else
GetImg=""
end if
end function

Function laoyvip()
	laoyvip = False
	If instr(version,"vip")>0 then
	laoyvip = True
	Else
	laoyvip = False
	End if
End Function

	'================================================
	'函数名：URLDecode
	'作  用：URL解码
	'================================================
	Function URLDecode(ByVal urlcode)
		Dim start,final,length,char,i,butf8,pass
		Dim leftstr,rightstr,finalstr
		Dim b0,b1,bx,blength,position,u,utf8
		On Error Resume Next
	
		b0 = Array(192,224,240,248,252,254)
		urlcode = Replace(urlcode,"+"," ")
		pass = 0
		utf8 = -1
	
		length = Len(urlcode) : start = InStr(urlcode,"%") : final = InStrRev(urlcode,"%")
		If start = 0 Or length < 3 Then URLDecode = urlcode : Exit Function
		leftstr = Left(urlcode,start - 1) : rightstr = Right(urlcode,length - 2 - final)
	
		For i = start To final
			char = Mid(urlcode,i,1)
			If char = "%" Then
				bx = URLDecode_Hex(Mid(urlcode,i + 1,2))
				If bx > 31 And bx < 128 Then
					i = i + 2
					finalstr = finalstr & ChrW(bx)
				ElseIf bx > 127 Then
					i = i + 2
					If utf8 < 0 Then
						butf8 = 1 : blength = -1 : b1 = bx
						For position = 4 To 0 Step -1
							If b1 >= b0(position) And b1 < b0(position + 1) Then
								blength = position
								Exit For
							End If
						Next
						If blength > -1 Then
							For position = 0 To blength
								b1 = URLDecode_Hex(Mid(urlcode,i + position * 3 + 2,2))
								If b1 < 128 Or b1 > 191 Then butf8 = 0 : Exit For
							Next
						Else
							butf8 = 0
						End If
						If butf8 = 1 And blength = 0 Then butf8 = -2
						If butf8 > -1 And utf8 = -2 Then i = start - 1 : finalstr = "" : pass = 1
						utf8 = butf8
					End If
					If pass = 0 Then
						If utf8 = 1 Then
							b1 = bx : u = 0 : blength = -1
							For position = 4 To 0 Step -1
								If b1 >= b0(position) And b1 < b0(position + 1) Then
									blength = position
									b1 = (b1 xOr b0(position)) * 64 ^ (position + 1)
									Exit For
								End If
							Next
							If blength > -1 Then
								For position = 0 To blength
									bx = URLDecode_Hex(Mid(urlcode,i + 2,2)) : i = i + 3
									If bx < 128 Or bx > 191 Then u = 0 : Exit For
									u = u + (bx And 63) * 64 ^ (blength - position)
								Next
								If u > 0 Then finalstr = finalstr & ChrW(b1 + u)
							End If
						Else
							b1 = bx * &h100 : u = 0
							bx = URLDecode_Hex(Mid(urlcode,i + 2,2))
							If bx > 0 Then
								u = b1 + bx
								i = i + 3
							Else
								If Left(urlcode,1) = "%" Then
									u = b1 + Asc(Mid(urlcode,i + 3,1))
									i = i + 2
								Else
									u = b1 + Asc(Mid(urlcode,i + 1,1))
									i = i + 1
								End If
							End If
							finalstr = finalstr & Chr(u)
						End If
					Else
						pass = 0
					End If
				End If
			Else
				finalstr = finalstr & char
			End If
		Next
		URLDecode = leftstr & finalstr & rightstr
	End Function
	
Function URLDecode_Hex(ByVal h)
	On Error Resume Next
	h = "&h" & Trim(h) : URLDecode_Hex = -1
	If Len(h) <> 4 Then Exit Function
	If isNumeric(h) Then URLDecode_Hex = cInt(h)
End Function

Function apath(aid,page)
apath=sitepath
If page>1 then
	If html=1 then
	apath=apath&"list.asp?id="&aid&"&page="&page&""
	elseif html=2 then
	apath=apath&"html/?"&aid&"_"&page&".html"
	elseif html=3 then
	apath=apath&"html/"&aid&"_"&page&".html"
	End if
else
	If html=1 then
	apath=apath&"list.asp?id="&aid&""
	elseif html=2 then
	apath=apath&"html/?"&aid&".html"
	elseif html=3 then
	apath=apath&"html/"&aid&".html"
	End if
end if
End function

Function cpath(cid,page)
cpath=sitepath
If page>1 then
	If html=3 then
	cpath=cpath&"class_"&cid&"_"&page&".html"
	else
	cpath=cpath&"class.asp?id="&cid&"&page="&page&""
	End if
else
	If html=3 then
	cpath=cpath&"class_"&cid&".html"
	else
	cpath=cpath&"class.asp?id="&cid&""
	End if
end if
End function
%>