
<%

'正则显示帖子中图片链接
function dis_post_img(topic_Content)
	dis_post_img=topic_Content
	Set RegEx = New RegExp
    RegEx.Global = True
    RegEx.Pattern = "<img[^>]*src\s*=\s*['"&CHR(34)&"]?([\w/\-\:.]*)['"&CHR(34)&"]?[^>]*>" '
    If Regex.test(dis_post_img) Then
        Dim Matches
        Set Matches = RegEx.Execute(dis_post_img)
        For Each Match in Matches
			RetStr = Match.Value	
			temp_img= Match.SubMatches(0)	
				'response.Write("temp_img="&temp_img&"<br>")
				'response.Write("BBS_folder="&BBS_folder&"<br>")
				'response.End()
			if instr(temp_img,BBS_folder)=0  then
			'如果是本站图标，则不操作
				
				Set objfso = Server.CreateObject("Scripting.FileSystemObject")
				if instr(temp_img,"http://")=0 and left(temp_img,1)="/" then
				'response.Write("temp_img="&temp_img)
				'response.End()
					exit_temp_img=server.mappath(temp_img)
				else
					exit_temp_img=temp_img
				end if
				if objfso.fileexists(exit_temp_img) then
					temp_img_id=replace(temp_img,"/","")
					temp_img_id=replace(temp_img_id,".","")
					temp_img_id=left(temp_img_id,6)
					dis_post_img=replace(dis_post_img,RetStr,"<div class=""dis_img""><img src="""& temp_img &""" id="""& temp_img_id &""" /></div><div class=""image_control""><a href="""& Match.SubMatches(0) &""" target=""_blank"" title=""在新窗口中打开""><img src="""& BBS_folder &"img/new_img.png""></a><a onclick=""window.document.getElementById('"& temp_img_id &"').style.transform=window.document.getElementById('"& temp_img_id &"').style.transform+'rotate(-90deg)' ;"" href=""javascript:void(0)"" title=""点击左旋转90度""><img src="""& BBS_folder &"img/trun_left.png""></a><a href=""javascript:void(0)"" onclick=""window.document.getElementById('"& temp_img_id &"').style.transform=window.document.getElementById('"& temp_img_id &"').style.transform+'rotate(90deg)' ;""><img src="""& BBS_folder &"img/trun_right.png"" title=""点击右旋转90度""></a></div>")
				end if
			end if
		Next
    End If
	
end function


 '显示屏蔽信息
function dis_block_info(img_name,block_info)
	dis_block_info="<div class=""post_notdisplay""><img src="""& BBS_folder &"img/"& img_name &".gif"" />温馨提示："& block_info &"</div>"
end function

 function chk_post_hide(topic_Content,post_id)	
	if  instr(topic_Content,"[hide]")>0 and instr(topic_Content,"[/hide]")>0 then
		hide_Content1=split(topic_Content,"[hide]")
		if instr(hide_Content1(1),"[/hide]")>0 then
			hide_Content2=split(hide_Content1(1),"[/hide]")
			hide_div=dis_block_info("lock","（以下是本帖隐藏的内容，普通会员需要回复才能查看）<div class=hide_Content2>"& hide_Content2(0) &"</div>")
			if user_id<>session_user_id and session_admin_id=0 and user_state<4 then
				'检查本会员有没有回复
				sql_post="select id from BBS_Reply where topic_id="& post_id &" and user_id="& session_user_id &""
				set rs_post=bbsconn.execute(sql_post)
				temp_html="游客，如果您要查看本帖隐藏内容，请 "
				if session_user_id=0 then
					temp_html=temp_html&"<a href=javascript:void(0); onClick=display_login_div();>回复</a>"
				else
					temp_html=temp_html&"回复"
				end if
				temp_html=temp_html&" 才能查看"				
				if rs_post.eof then hide_div=dis_block_info("lock",temp_html)
			end if
			topic_Content=replace(topic_Content,"[hide]"&hide_Content2(0)&"[/hide]",hide_div)
		end if
	end if
	chk_post_hide=topic_Content
end function


'读取会员状态
sub chk_post_user_state(bbsset_post_times1,bbsset_post_times2,bbsset_post_times3user_state,user_id,session_admin_id,goto_url)	
	select case user_state
		case 1
			if session_admin_id=0 then
				this_user_addtime=chk_db("BBS_User","user_id",user_id,"user_addtime")
				if len(this_user_addtime)>0 and bbsset_post_times2>0 then call dperror("",0,datediff("s",this_user_addtime,thistime)<bbsset_post_times2,"抱歉，您是新会员，需要等到【"& formattime(DateAdd("s",bbsset_post_times2,thistime)) &"】时才能进行本操作",goto_url)
				
				'读取会员最近发表的帖子
				mypost_time=""
				sql_post="select top 1 topic_addtime from BBS_Topic where user_id="& user_id &" order by id desc"
				set rs_post=bbsconn.execute(sql_post)
				if not rs_post.eof then mypost_time=rs_post(0)
				sql_post="select top 1 reply_time from BBS_Reply where user_id="& user_id &""
				if len(mypost_time)>0 then sql_post=sql_post&" and reply_time>'"& mypost_time &"'"
				sql_post=sql_post&" order by id desc"
				set rs_post=bbsconn.execute(sql_post)
				if not rs_post.eof then mypost_time=rs_post(0)
				if len(mypost_time)>0 and bbsset_post_times1>0 then call dperror("",0,datediff("s",mypost_time,thistime)<bbsset_post_times1,"抱歉，您两次发表间隔少于 "& bbsset_post_times1 &" 秒，请稍候再发表",goto_url)
				
				if bbsset_post_times3>0 then
				'统计本会员当天已发贴总计
					my_post_totol=0
					sql_post="select count(id) from BBS_Topic where user_id="& user_id &""
					set rs_post=bbsconn.execute(sql_post)
					my_post_totol=chk_num(rs_post(0))
					sql_post="select count(id) from BBS_Reply where user_id="& user_id &""
					set rs_post=bbsconn.execute(sql_post)
					my_post_totol=my_post_totol+chk_num(rs_post(0))
					call dperror("",0,my_post_totol>=bbsset_post_times3,"抱歉，您今天的发贴数已超过系统【每个会员每天最多发 "& bbsset_post_times3 &" 贴】的限制，请明天再来",goto_url)
				end if
			end if
		case 2
			call dperror("",0,true,"您无权限发贴，已被禁言",goto_url)
		case 3
			call dperror("",0,true,"您无权限发贴，已被锁定",goto_url)
	end select
end sub



'过滤关键词
function replace_filter(filter_word,bbsset_Filter_word)
	replace_filter=filter_word
	if len(bbsset_Filter_word)>0 then
		if right(bbsset_Filter_word,1)="|" then bbsset_Filter_word=replace(bbsset_Filter_word&"++|","++|","")
		if instr(bbsset_Filter_word,"|") then
			temp1_word=Split(bbsset_Filter_word,"|")
			For i=0 To UBound(temp1_word)
				replace_filter=replace(replace_filter,temp1_word(i),"**")
			next
		end if
	end if
end function


'显示发贴按钮
function dis_pos_do(session_user_id,board_id)
	dis_pos_do="<div class=""topic_post"" >"		
		dis_pos_do=dis_pos_do&"<a "
		if session_user_id>0 then
			dis_pos_do=dis_pos_do&"href="""& index_url &"n"& board_id &".html"""
		else
			dis_pos_do=dis_pos_do&"href=""javascript:void(0);"" onClick=""display_login_div();"""
		end if
		dis_pos_do=dis_pos_do&" title=""发新贴""><img src=""img/pn_post.png""></a>"		   
	dis_pos_do=dis_pos_do&"</div>"
end function

'显示分类
sub dis_shopclass(board_id,board_belong)
	sql_belong="select * from BBS_Board where 1=1"
	sql_belong=sql_belong&" and board_belong="& board_id &" and board_id<>"& board_id &" order by board_order desc "
	set rs_belong=bbsconn.execute(sql_belong)
	do while not rs_belong.eof
		board_name_1=rs_belong("board_name")
		board_id_1=chk_num(rs_belong("board_id"))
		board_level=chk_num(rs_belong("board_level"))
		board_level_html=""
		for loop_i=2 to board_level
			board_level_html=board_level_html&"&nbsp;&nbsp;&nbsp;&nbsp;"
		next
		%><option value="<%=board_id_1%>" <%if board_belong=board_id_1 then%> selected <%end if%> ><%=board_level_html%><%=board_name_1%></option><%
		call dis_shopclass(board_id_1,board_belong)
		rs_belong.movenext
	loop
end sub


'列出该分类下属所有分类ID,
function dis_allmyclass(board_id)
	dim count,sql_class,rs_class,this_board_id
	count=""
	sql_class="select * from BBS_Board where board_belong="& board_id &""
	set rs_class=bbsconn.execute(sql_class)
	do while not rs_class.eof
		this_board_id=rs_class("board_id")
		count=count&this_board_id&","
		count=count&dis_allmyclass(this_board_id)&","
		rs_class.movenext
	loop
	dis_allmyclass=count&board_id&","
	if right(dis_allmyclass,1)="," then dis_allmyclass=replace(dis_allmyclass&"+",",+","")
end function

'读取当前所在版块		
function get_board_class_href(topic_no)
	loop_topic_no=topic_no
	do while loop_topic_no>0
		sql_class="select * from BBS_Board where board_id="& loop_topic_no &""
		set rs_class=bbsconn.execute(sql_class)
		if rs_class.eof then exit do
		loop_board_name=rs_class("board_name")
		loop_board_belong=rs_class("board_belong")
		get_board_class_href=" <span>></span> <a href="& index_url &"b"& loop_topic_no &".html>"& loop_board_name &"</a>"&get_board_class_href
		loop_topic_no=loop_board_belong		
	loop
end function

'显示审核的主题标题
function dis_posttitle(topic_title,topic_state)
	select case topic_state
		case 1
			dis_posttitle="[主题审核中...]"
		case 2
			dis_posttitle=topic_title
		case 3
			dis_posttitle="[该主题已被屏蔽...]"
	end select
end function

'显示用户头像
function get_userimg(user_id)
	if len(user_id)>0 then get_userimg=" src="""& chk_db("BBS_User","user_id",user_id,"user_img") &""" onerror=""this.src='"& BBS_folder &"img/user_logo.jpg'"""
end function

'格式化时间
function formattime(foo_time)
	formattime=foo_time
	if IsDate(formattime) then formattime=year(formattime)&"-"&right("0"&month(formattime),2)&"-"&right("0"&day(formattime),2)&" "&right("0"&hour(formattime),2)&":"&right("0"&minute(formattime),2)&":"&right("0"&second(formattime),2)
end function


'显示多久前访问的时间
Function howlong(This_time)
	howlong=""
	if len(This_time)>0 then
		cp_second=datediff("s",This_time,now())
		cp_day=datediff("d",This_time,now())
		displaytemp1=" "&right("00"&hour(This_time),2)&":"&right("00"&minute(This_time),2)		
		displaytemp2=month(This_time)&"月"&day(This_time)&"日"		
		select case true		
			case cp_second<0
				howlong="时间格式错误"
			case cp_second<=5
				howlong="刚刚"
			case cp_second<60
				howlong=cp_second&"秒钟前"
			case cp_second<3600
				howlong=int(cp_second/60)&"分钟前"
			case cp_day=0
				howlong="今天"&displaytemp1
			case cp_day=1
				howlong="昨天"&displaytemp1
			case year(This_time)=year(now())
				howlong=displaytemp2&displaytemp1
			case else
				howlong=year(This_time)&"年"&displaytemp2&displaytemp1
		end select
	end if
end Function


'显示分页
function bbs_page_no(page_no,page_end,page_url)
	
	page_end=chk_num(page_end)
	if page_end=0 then page_end=1
	page_no=chk_num(page_no)
	if page_no=0 then page_no=1
	if page_end>1 then
		if len(page_url)=0 then page_url=left(myurl,1)
        		
		bbs_page_no=bbs_page_no&"<li><a href="& index_url & page_url & topic_no &"-"& page_no-1 &".html title=上一页><img src=img/arw_l.gif></a></li>"
		loop_star=page_no-6
		if loop_star<1 then loop_star=1
		loop_end=page_no+6
		if loop_end>page_end then loop_end=page_end
		if loop_star>1 then bbs_page_no=bbs_page_no&"<li><a href="""& index_url & page_url & topic_no &".html"" title=""第1页"">1</a></li><li><a>&hellip;</a></li>"
		for page_i=loop_star to loop_end
			bbs_page_no=bbs_page_no&"<li"
			if page_i=page_no then bbs_page_no=bbs_page_no&" class=""active"""
			bbs_page_no=bbs_page_no&"><a href="""& index_url & page_url & topic_no &"-"& page_i &".html"" title=""第"& page_i &"页"" >"& page_i &"</a></li>"
		next	
		
		if loop_end<page_end then bbs_page_no=bbs_page_no&"<li><a>&hellip;</a></li><li><a href="""& index_url & page_url & topic_no &"-"& page_end &".html"" title=""第"& page_end &"页"">"& page_end &"</a></li>"	
		bbs_page_no=bbs_page_no&"<li><a href="""& index_url & page_url & topic_no &"-"& page_no+1 &".html"" title=""下一页"">下一页 <img src=img/arw_r.gif></a></li>"
		
	end if	
end function

function admin_page_no(page_no,page_end,page_url)
	
	page_end=chk_num(page_end)
	if page_end=0 then page_end=1
	page_no=chk_num(page_no)
	if page_no=0 then page_no=1
	if page_end>1 then
		if len(page_url)=0 then page_url=left(myurl,1)
		
		admin_page_no=admin_page_no&"<li><a href=""?"& page_url &""" title=""返回首页"">首页</a></li>"
		admin_page_no=admin_page_no&"<li><a href=""?"& page_url & "&page_no="& page_no-1 &""" title=""上一页""><</a></li>"
		loop_star=page_no-6
		if loop_star<1 then loop_star=1
		loop_end=page_no+6
		if loop_end>page_end then loop_end=page_end
		if loop_star>1 then admin_page_no=admin_page_no&"<li><a href=""?"& page_url &""" title=""第1页"">1</a></li><li><a>…</a></li>"
		for page_i=loop_star to loop_end
			admin_page_no=admin_page_no&"<li"
			if page_i=page_no then admin_page_no=admin_page_no&" class=""active"""
			admin_page_no=admin_page_no&"><a href=""?"& page_url &"&page_no="& page_i &""" title=""第"& page_i &"页"" >"& page_i &"</a></li>"
		next	
		
		if loop_end<page_end then admin_page_no=admin_page_no&"<li><a>…</a></li><li><a href=""?"& page_url &"&page_no="& page_end &""" title=""第"& page_end &"页"">"& page_end &"</a></li>"	
		admin_page_no=admin_page_no&"<li><a href=""?"& page_url &"&page_no="& page_no+1 &""" title=""下一页"">></a></li>"
		admin_page_no=admin_page_no&"<li><a href=""?"& page_url &"&page_no="& page_end &""" title=""最后一页"">尾页</a></li>"	
	end if	
end function



'读取数据库某一个字段，读取的参数必须是数字类型，如ID
function chk_db(db_name,chk_num1,chk_num2,chk_num3)
	sql4="select "& chk_num3 &" from "& db_name &" where "& chk_num1 &"="& chk_num2 &""
	set rs4=bbsconn.execute(sql4)
	chk_db=""
	if not rs4.eof then chk_db=rs4(chk_num3)
	set rs4=nothing
end function



'正则替换所有html代码
function RegExphtml(html)
RegExphtml=html
if len(RegExphtml)>0 then
set reg = new RegExp 
reg.IgnoreCase = True
reg.Global = True 
'过滤全部HTML代码 
reg.Pattern = "<[^>]*>" 
RegExphtml = reg.Replace(RegExphtml,"")
set reg=nothing
RegExphtml=replace(RegExphtml," ","")
RegExphtml=replace(RegExphtml,"&nbsp;","")
RegExphtml=replace(RegExphtml,CHR(13),"")
RegExphtml=replace(RegExphtml,CHR(10),"")
RegExphtml=replace(RegExphtml,CHR(32),"")
RegExphtml=replace(RegExphtml,CHR(9),"")
RegExphtml=replace(RegExphtml,CHR(34),"")

end if
end function


'还原过滤输入的字符
function trim_fun_3(fString)
	trim_fun_3=fString
	if len(trim_fun_3)>0 then
		trim_fun_3=trim(trim_fun_3)
		trim_fun_3=replace(trim_fun_3,"''+","'")	
		trim_fun_3=replace(trim_fun_3,"”+","""")	
		trim_fun_3=replace(trim_fun_3,"；+",";")
		trim_fun_3=replace(trim_fun_3,"—+","--")
	end if
end function


'过滤输入的字符
function trim_fun_2(fString)
	trim_fun_2=fString
	if len(trim_fun_2)>0 then
		trim_fun_2=trim(trim_fun_2)
		trim_fun_2=replace(trim_fun_2,"'","''+")	
		trim_fun_2=replace(trim_fun_2,"""","”+")	
		trim_fun_2=replace(trim_fun_2,";","；+")
		trim_fun_2=replace(trim_fun_2,"--","—+")
	end if
end function


'过滤输入的字符
function trim_fun(fString)
	trim_fun=fString
	if len(trim_fun)>0 then
		trim_fun=trim_fun_2(trim_fun)				
		trim_fun=RegExphtml(trim_fun)
		trim_fun=server.htmlencode(trim_fun)		
	end if
end function


'显示错误信息
function dperror(from_mobile_url,from_mobile,iffalse,disinfo,goto_url)
	'如果前面的条件为真,则显示后面的错误信息
	if iffalse=true then
		from_mobile=chk_num(from_mobile)
		if from_mobile=0 then
			if len(goto_url)=0 or isnull(goto_url) then goto_url=BBS_folder
			session("goto_url")=goto_url
			session("disinfo")=disinfo
			response.Redirect(index_url&"g1.html")
			response.end
		else
			call dperror_admin(true,disinfo,from_mobile_url)
		end if
	end if
end function
function dperror_admin(iffalse,disinfo,goto_url)
	'如果前面的条件为真,则显示后面的错误信息
	if len(goto_url)=0 or isnull(goto_url) then
		goto_url="window.history.back();"
	else
		goto_url="window.location.href='"& goto_url &"';"
	end if
	if iffalse=true then
		response.write"<SCRIPT language=JavaScript>alert('"& disinfo &"！');"& goto_url &"</script>"
		response.end
	end if
end function
function dperror_referrer(disinfo)
	response.write"<SCRIPT language=JavaScript>alert('"& disinfo &"！');window.location.href=document.referrer;</script>"
	response.end
end function
'显示错误信息

'检查是否是数字
function chk_num(num)
	if len(num)=0 or isnull(num) then
		chk_num=0
	else
		chk_num=cdbl(num)
	end if
end function
function chknum2(num)
	chknum2=chk_num(num)	
	chknum2=formatnumber(chknum2,2,-1,0,0)
end function

'删除缓存
sub del_cache()
	'删除站点参数信息缓存
	del_fileurl=DB_folder&"cache/webconfig.xml"
	Set objfso = Server.CreateObject("Scripting.FileSystemObject")
	del_fileurl=server.mappath(del_fileurl)
	if objfso.fileexists(del_fileurl) then objfso.DeleteFile(del_fileurl)
end sub
%>
<!-- #include file="../tpay/fun-tpay.asp" -->