
<%
'显示支付方式
function Get_paytype_name(pay_paytype)
	Get_paytype_name=""
	pay_paytype=chk_num(pay_paytype)
	select case pay_paytype
		case 1
			Get_paytype_name="支付宝扫码"			
		case 2
			Get_paytype_name="支付宝APP"
		case 3
			Get_paytype_name="微信扫码"			
		case 4
			Get_paytype_name="微信APP"
		case 5
			Get_paytype_name="微信公众号"
	end select
end function


'记录会员随机码
sub mark_remdon_num(num)	
	'if len(num)>0 and session_user_id>0 then
		'sql_rem="update BBS_User set random_num='"& num &"' where user_id="& session_user_id &""		
		'set rs_rem=bbsconn.execute(sql_rem)
	'end if
	session("remdon_num")=num
end sub
'读取会员随机码
function get_remdon_num()
	'sql_rem="select random_num from BBS_User where user_id="& session_user_id &""
	'set rs_rem=bbsconn.execute(sql_rem)
	'if not rs_rem.eof then get_remdon_num=rs_rem(0)
	get_remdon_num=session("remdon_num")
end function

'生成通路网快捷登录地址
function display_tlogin(tlogin_type)
	'login_idcode=get_remdon_num()
	'if len(login_idcode)=0 or isnull(login_idcode) then
		'login_idcode=remdon_num(4)
		'call mark_remdon_num(login_idcode)
	'end if
	display_tlogin="http://www.tlu5.com/tlu5/api/tlogin/?tlogin_type="&tlogin_type
	display_tlogin=display_tlogin&"&tlogin_openid="&bbsset_tlogin_openid
	display_tlogin=display_tlogin&"&tlogin_idcode="&dis_timenum()
end function

'生成14位数时间数字
function dis_timenum()
	dis_timenum=thistime
	dis_timenum=year(dis_timenum)&right("0"&month(dis_timenum),2)&right("0"&day(dis_timenum),2)&right("0"&hour(dis_timenum),2)&right("0"&minute(dis_timenum),2)&right("0"&second(dis_timenum),2)
end function

'随机生成数字
function remdon_num(num_long)
	Randomize
	remdon_num=int(3/Rnd()*1/3*10000000000)
	remdon_num="422235647842"&remdon_num
	remdon_num=right(remdon_num,num_long)
	remdon_num=chk_num(remdon_num)
	remdon_num="422235647842"&remdon_num
	remdon_num=right(remdon_num,num_long)
	remdon_num=chk_num(remdon_num)
end function

function read_xmlhttp(url,html_Charset)
	if len(url)>0 then
		Set Retrieval = CreateObject("Microsoft.XMLHTTP") 
		With Retrieval 
			.Open "Get", url, false ', "", "" 
			.Send 
			if .status=200 then read_xmlhttp = transhtml(.ResponseBody,html_Charset)
		End With 
		Set Retrieval = Nothing	
	end if
end function



'读取json里的健值
function read_json(json_name,json_html)
	read_json=""
	if instr(json_html,"<"& json_name &">")>0 then
		arr_1=split(json_html,"<"& json_name &">")
		if instr(arr_1(1),"</"& json_name &">")>0 then
			arr_2=split(arr_1(1),"</"& json_name &">")
			read_json=arr_2(0)				
		end if
	end if
end function


Function transhtml(body,html_Charset) 
	if len(body)>0 then
		dim objstream 
		set objstream = Server.CreateObject("adodb.stream") 
		objstream.Type = 1 
		objstream.Mode =3 
		objstream.Open 
		objstream.Write body 
		objstream.Position = 0 
		objstream.Type = 2 
		objstream.Charset = html_Charset
		transhtml = objstream.ReadText 
		objstream.Close 
		set objstream = nothing 
	end if
End Function 

%>