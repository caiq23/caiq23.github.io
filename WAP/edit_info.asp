<!-- #include file="../inc/conn-bbs.asp" -->
<!-- #include file="inc/wap-fun.asp" -->
<!-- #include file="inc/wap_session.asp" -->
<!DOCTYPE html>
<html>
	<head>
		<meta charset="gb2312">
        
<title>�޸����� - <%=bbsset_sitename%></title>
		<meta name="viewport" content="width=device-width, initial-scale=1,maximum-scale=1,user-scalable=no">
		<meta name="apple-mobile-web-app-capable" content="yes">
		<meta name="apple-mobile-web-app-status-bar-style" content="black">
        
        <link rel="stylesheet" href="inc/wap_css.css">
        <link rel="stylesheet" href="inc/ios_css.css">
	</head>
<%
sql="select * from BBS_User where user_id="& session_user_id &""
set rs=bbsconn.execute(sql)
if not rs.eof then
	user_num=rs("user_num")
	user_name=rs("user_name")
	user_id=rs("user_id")
	user_state=rs("user_state")
	login_times=rs("login_times")
	user_password=rs("user_password")
	user_addtime=rs("user_addtime")	
	user_img=rs("user_img")
	user_tel=rs("user_tel")
	user_qq=rs("user_qq")
	user_sign=rs("user_sign")
	qq_OpenID=rs("qq_OpenID")
	user_sex=chk_num(rs("user_sex"))
	msg_open=chk_num(rs("msg_open"))
end if
user_state=CHK_num(user_state)
user_sign=trim_fun_3(user_sign)
%>
	<body> 
    <%this_page="edit_info"%>   
	<!-- #include file="inc/top.asp" --> 


 
<form name="login" method="post" action="../inc/chk_edit_userinfo.asp?from_mobile=1&mydo=modok">
<div class="post_title">�޸�����</div>
<div class="edit_title">�˺���Ϣ</div>
    <div class="info_div" style=" margin:0px;">  
    	<li>
            <div class="left">�˺�</div>
            <div class="right"><%=user_num%></div>
        </li>
        <li>
            <div class="left">վ����Ϣ</div>
            <div class="right"><div class="tg-list-item"><input name="msg_open" value="1" <%if msg_open=1 then response.Write(" checked")%> class="tgl tgl-ios" id="msg_open" type="checkbox"><label class="tgl-btn" for="msg_open"></label></div></div>            
        </li>
    	<li>
            <div class="left">ע������</div>
            <div class="right"><%=howlong(user_addtime)%></div>
        </li>
    </div>
<div class="edit_title">�޸�ͷ��</div>
    <div class="info_div" style=" margin:0px;">	
        
            <li style="text-align:center; padding-top:10px; padding-bottom:10px;" >                    
                <img id="user_img" class="user_img" height="120" width="120" title="���ͷ����Ը���" onClick="document.getElementById('uploadpic_iframe').contentWindow.document.getElementById('file1').click();" <%=get_userimg(user_id)%>>
                <iframe id="uploadpic_iframe" name="uploadpic_iframe" src="../main/upload_pic.asp?upload_type=2&pic_size=500&modid=<%=user_id%>" style="display:none"></iframe>                    
            </li>
    </div>
<div class="edit_title">�˻���Ϣ</div>

    <div class="info_div" style=" margin:0px;">  
    	<li>
            <div class="left">�ǳ�</div>
            <div class="right"><input name="user_name" value="<%=user_name%>" class="input_wap_edit"></div>
        </li>
    	<li>
            <div class="left">����</div>
            <div class="right"><input name="user_password" type="password" value="<%=user_password%>" class="input_wap_edit"></div>
            <input class="input_wap" name="user_password_old" type="hidden" value="<%=user_password%>">
        </li>
    	<li>
            <div class="left">ȷ������</div>
            <div class="right"><input name="user_password2" type="password" value="<%=user_password%>" class="input_wap_edit"></div>
        </li>
        <%if bbsset_open_qqlogin=1 then%>
    	<li>
            <div class="left">QQ��¼</div>
            <div class="right">
			<%if len(qq_OpenID)>0 then%>
                ��ǰ�Ѱ󶨣�<a href="../inc/chk_edit_userinfo.asp?mydo=cancel_qq&from_mobile=1" onClick="return makesure('�Ƿ�ȡ����QQ��ݵ�¼?\n�´���Ҫ���°�');" style="color:red;">������</a>
            <%else%>
                <%session("login_idcode")=remdon_num(4)%>            
            <a href="http://www.tlu5.com/tlu5/api/tlogin/qqlogin/?<%=bbsset_tlu_openid_qq%><%=session("login_idcode")%>"><img src="../img/qq_login.gif"></a>
            <%end if%>
            </div>
        </li>
        <%end if%> 
    </div>



<div class="edit_title">��ϵ��ʽ</div>

    <div class="info_div" style=" margin:0px;">  
    	<li>
            <div class="left">��ϵ�绰</div>
            <div class="right"><input name="user_tel" value="<%=user_tel%>" class="input_wap_edit"></div>
        </li>
    	<li>
            <div class="left">��ϵQQ</div>
            <div class="right"><input name="user_qq" value="<%=user_qq%>" class="input_wap_edit"></div>            
        </li>
    </div>
    

    
<div class="edit_title">�Ա�</div>

    <div class="info_div" style=" margin:0px;" >  
    	<label for="male">
        	<li style="border-bottom:1px #eee solid;">            
                <div class="left">��</div>
                <div class="right">
                    <input name="user_sex" type="radio" id="male" class="ios_radio" value="1" <%if user_sex=1 then response.Write(" checked")%>><label for="male"></label>
                </div>
        	</li>
        </label>
    	<label for="female">
        	<li style="border-bottom:1px #eee solid;">            
                <div class="left">Ů</div>
                <div class="right">
                    <input name="user_sex" type="radio" id="female" class="ios_radio" value="2" <%if user_sex=2 then response.Write(" checked")%>><label for="female"></label>
                </div>
        	</li>
        </label>
    </div>
    
    
    
<div class="edit_title">����ǩ��</div>
<textarea name="user_sign" class="input_wap_post_textarea" style="height:120px;"><%=user_sign%></textarea>


	  
  
    <!-- #include file="inc/end.asp" -->     
        
      </form>    
	</body>

</html>