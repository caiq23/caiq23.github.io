<!-- #include file="../inc/conn-bbs.asp" -->
<!-- #include file="../inc/check_admin_session.asp" -->
<!-- #include file="../inc/fun-admin.asp" -->
<!Doctype html>
<html>
<head>
<meta charset="gb2312">
<title><%=this_title%>会员</title>
</head>
<body>
<%
		page_no=chk_num(trim_fun(request("page_no")))
		modid=chk_num(trim_fun(request("modid")))
		mydo=trim_fun(request("mydo"))
		call dperror_admin(len(modid)=0 or isnull(modid),"读取用户ID出错，请退出登录重新操作","")

  select case mydo
  
	  case "del_user_img"
	  	'删除会员图片
		sql="select * from BBS_User where user_id="& modid &""
		set rs=bbsconn.execute(sql)
		if not rs.eof then
			user_img=rs("user_img")
			call del_userimg(user_img)
		end if
		temp_i=del_user_all_postimg(modid)		
		call dperror_referrer(temp_i)
  	  case "vip"
	  	'VIP会员	  	
		sql="update BBS_User set user_state=4 where user_id="& modid &""
		set rs=bbsconn.execute(sql)
		call dperror_referrer("设置vip成功")
	  case "unvip"
	  	'解除VIP会员	  	
		sql="update BBS_User set user_state=1 where user_id="& modid &""
		set rs=bbsconn.execute(sql)
		call dperror_referrer("解除VIP成功")
  	  case "pass"
	  	'超级版主	  	
		sql="update BBS_User set user_state=5 where user_id="& modid &""
		set rs=bbsconn.execute(sql)
		call dperror_referrer("任命超级版主成功")
	  case "unpass"
	  	'解除超级版主	  	
		sql="update BBS_User set user_state=1 where user_id="& modid &""
		set rs=bbsconn.execute(sql)
		call dperror_referrer("解除超级版主成功")
	  case "gag"
	  	'禁言会员	  	
		sql="update BBS_User set user_state=2 where user_id="& modid &""
		set rs=bbsconn.execute(sql)
		call dperror_referrer("禁言成功")
	  case "ungag"
	  	'解除禁言	  	
		sql="update BBS_User set user_state=1 where user_id="& modid &""
		set rs=bbsconn.execute(sql)
		call dperror_referrer("解除禁言成功")
	  case "lock"
	  	'锁定会员	  	
		sql="update BBS_User set user_state=3 where user_id="& modid &""
		set rs=bbsconn.execute(sql)
		call dperror_referrer("锁定成功")
	  case "unlock"
	  	'解锁会员
		sql="update BBS_User set user_state=1 where user_id="& modid &""
		set rs=bbsconn.execute(sql)
		call dperror_referrer("解锁成功")
	  case "del_user_post"
	  	'删除会员	
		call del_user_post(modid)
		
		call dperror_referrer("删除所有帖子成功")
	  case "del_user"
	  	'删除会员
		sql="select * from BBS_User where user_id="& modid &""
		set rs=bbsconn.execute(sql)
		if not rs.eof then
			user_img=rs("user_img")
			call del_userimg(user_img)
		end if			
		call del_user(modid)
		call dperror_referrer("删除会员成功")
  end select


%>

</body>
</html>