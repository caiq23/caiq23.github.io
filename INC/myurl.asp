<%

if bbsset_open_wap=1 then
	'判断是触屏用户是否想访问电脑版
	if_mobile_user=InStr(LCase(Request.ServerVariables("HTTP_USER_AGENT")),"mobile")
	if if_mobile_user>0 then
		if instr(LCase(Request.ServerVariables("HTTP_REFERER")),"wap/")>0 then session("i_want_pc")=1
		i_want_pc=chk_num(session("i_want_pc"))
		if i_want_pc>0 then if_mobile_user=0
	end if
end if




temp=myurl
temp=replace(temp,".html","")
temp=replace(temp,"b","")
'板块
temp=replace(temp,"p","")
'页面
temp=replace(temp,"u","")
'用户主页
temp=replace(temp,"n","")
'发新贴
temp=replace(temp,"q","")
'回复
temp=replace(temp,"r","")
'注册新会员
temp=replace(temp,"e","")
'修改会员资料
temp=replace(temp,"z","")
'修改主题贴
temp=replace(temp,"h","")
'修改回复贴
temp=replace(temp,"t","")
'最新TOP
temp=replace(temp,"g","")
'提示页面
temp=replace(temp,"m","")
'用户列表
temp=replace(temp,"a","")
'用户提醒

if instr(temp,"-")>0 then
	arr=split(temp,"-")
	topic_no=arr(0)
	page_no=arr(1)
else
	topic_no=temp
	page_no=1
end if


keyword=trim(request("keyword"))

if len(keyword)=0 and len(myurl)>0 then
	call dperror("",0,not(isnumeric(topic_no) and isnumeric(page_no)),"该页无内容，即将返回主页","?")
	topic_no=chk_num(topic_no)
	page_no=chk_num(page_no)
	if topic_no<=0 then topic_no=1
	if page_no<=0 then page_no=1	
else
	topic_no=1
	page_no=1	
end if








		
'下面开始处理myurl

site_keyword=bbsset_site_keyword
site_description=bbsset_site_description


select case left(myurl,1)
	case "a"		
		board_name=chk_db("BBS_User","user_id",topic_no,"user_name")		
		title=board_name&" 的提醒"		
		if page_no>1 then title=title&"-第"& page_no &"页"
		goto_file="user_alert"
	case "m"
		select case topic_no
			case 1
				title="最新注册用户"
			case 2
				title="最近登录用户"
			case 3
				title="活跃用户"
			case 4
				title="小黑屋"
			case 5
				title="超级版主"
			case 6
				title="有头像用户"
			case 7
				title="已绑定QQ快捷登录用户"
			case 8
				title="VIP用户"
		end select
		goto_file="user_list"	
	case "g"		
		title="系统提示"
		goto_file="display_error"
	case "k"		
		title="搜索与“"& keyword &"”有关的帖子"
		goto_file="board"
	case "p"		
		sql="select * from BBS_Topic where topic_id="& topic_no &""
		set rs=bbsconn.execute(sql)
		if not rs.eof then
			topic_title=rs("topic_title")
			board_id=rs("board_id")
			topic_state=chk_num(rs("topic_state"))
		end if		
		topic_title=left(topic_title,20)
		
		call dperror("",0,board_id<=0,"该页无内容","")
		sql="select board_name from BBS_Board where board_id="& board_id &""
		set rs=bbsconn.execute(sql)
		if not rs.eof then board_name=rs(0)
		topic_title=dis_posttitle(topic_title,topic_state)	
		title=topic_title			
		if page_no>1 then title=title&"-第"& page_no &"页"
		where_now=get_board_class_href(board_id)&" <span>></span> <a href="& index_url &"p"& topic_no &".html>"& topic_title &"</a>"
		goto_file="page"
		site_keyword=topic_title
		mobile_url="page.asp?topic_id="&topic_no		
		call dperror_admin(if_mobile_user>0 and bbsset_open_wap=1,"现在跳转到触屏版对应的页面",BBS_folder&"wap/page.asp?topic_id="&topic_no)
	case "b"
		sql="select board_name from BBS_Board where board_id="& topic_no &""
		set rs=bbsconn.execute(sql)
		if not rs.eof then board_name=rs(0)
		title=board_name		
		if page_no>1 then title=title&"-第"& page_no &"页"
		where_now=get_board_class_href(topic_no)
		goto_file="board"
		site_keyword=board_name
		mobile_url="index.asp?board_id="&topic_no
		call dperror_admin(if_mobile_user>0 and bbsset_open_wap=1,"现在跳转到触屏版对应的版块",BBS_folder&"wap/index.asp?board_id="&topic_no)
	case "u"		
		board_name=chk_db("BBS_User","user_id",topic_no,"user_name")		
		title=board_name&" 的贴子"		
		if page_no>1 then title=title&"-第"& page_no &"页"
		goto_file="board"
	case "q"	
		title="参与/回复主题"
		goto_file="quote"
	case "n"	
		title="发表新帖子"
		goto_file="post"
	case "r"
		if len(session("qq_OpenID"))>0 then	
			title="绑定帐号"
		else
			title="注册新会员"
		end if
		goto_file="reg"
		mobile_url="reg.asp"
		temp_noto_wap=1
	case "e"
		select case topic_no
			case 1			
				title="修改会员资料"
				goto_file="edit_userinfo"
				mobile_url="info.asp"
			case 2
				title="会员充值"
				goto_file="../TPay/recharge"
			case 3
				title="支付列表"
				goto_file="../TPay/pay_log"
		end select
	case "z"	
		title="编辑主题"
		goto_file="edit_topic"
	case "h"	
		title="编辑回复"
		goto_file="edit_replay"
	case "t"
		select case topic_no
			case 1
				title="最新主题"								
			case 2
				title="最新回复"
			case 3
				title="热门主题"
			case 4
				title="待审主题"
			case 5
				title="一周热门"
			case 6
				title="一月热门"
			case 7
				title="待审回复"
		end select
		goto_file="toplist"

	case else		
		title=bbsset_sitename&"-"&bbsset_site_name2
		board_name=""
		where_now=""
		goto_file="main"		
end select

temp_noto_wap=chk_num(temp_noto_wap)

call dperror_admin(if_mobile_user>0 and bbsset_open_wap=1 and temp_noto_wap=0,"您是手机用户，现在跳转到手机版首页",BBS_folder&"wap/")





%>