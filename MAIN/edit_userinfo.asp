<!-- #include file="../inc/conn-bbs.asp" -->
<!-- #include file="../inc/myurl.asp" -->
<!-- #include file="../inc/chk_session.asp" -->
<script src="inc/wdiii/index.js" type="text/javascript"></script>
<link rel="stylesheet" href="inc/wdiii/common.css">
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
	wx_OpenID=rs("wx_OpenID")
	user_sex=chk_num(rs("user_sex"))
	bbs_account_cash=rs("bbs_account_cash")
end if
user_state=CHK_num(user_state)
user_sign=trim_fun_3(user_sign)
bbs_account_cash=chk_num(bbs_account_cash)
%>
<script language="javascript" type="text/javascript" src="inc/reg_chk.js"></script>
<div id="bbsreg_div">
    <div class="reg_title">�༭����</div>
    <div class="reg_content">
    	<form action="inc/chk_edit_userinfo.asp?mydo=modok" method="post" name="edit" onSubmit="return Validator.Validate(this,3)">
    <table>
  <tbody>
    <tr>
      <td style="text-align:right;" width="30%">�û�����</td>
      <td  width="30%"><%=user_num%>
      </td>
      <td  width="40%">
      </td>
    </tr>
    <tr>
      <td style="text-align:right;" width="30%">��ǰ�ʻ���</td>
      <td  width="30%">
	  <font color="red"><%=chknum2(bbs_account_cash)%></font>
      <a href="<%=index_url%>e2.html" class="btn btn-success">��ֵ</a> 
      <a href="<%=index_url%>e3.html" class="btn btn-info">��¼</a>     
      </td>
      <td  width="40%">
      </td>
    </tr>

<%session("login_idcode")=remdon_num(4)%>
<%if bbsset_open_qqlogin=1 then%>
    <tr>
      <td style="text-align:right;" width="30%">QQ��ݵ�¼��</td>
      <td colspan="2">
        <%if len(qq_OpenID)>0 then%>
        ��ǰ�Ѱ�QQ��ݵ�¼��������<a href="inc/chk_edit_userinfo.asp?mydo=cancel_qq" onClick="return makesure('�Ƿ�ȡ����QQ��ݵ�¼?\n�´���Ҫ���°�');" style="color:red;">���QQ��ݵ�¼</a>
        <%else%>
        ����δ��QQ��ݵ�¼��������            
            <a href="<%=display_tlogin(1)%>"><img src="img/qq_login.gif"></a>
        <%end if%>
      </td>
      </tr>
<%end if%>
<%if bbsset_open_wxlogin=1 then%>
    <tr>
      <td style="text-align:right;" width="30%">΢�ſ�ݵ�¼��</td>
      <td colspan="2">
        <%if len(wx_OpenID)>0 then%>
        ��ǰ�Ѱ�΢�ſ�ݵ�¼��������<a href="inc/chk_edit_userinfo.asp?mydo=cancel_wx" onClick="return makesure('�Ƿ�ȡ����΢�ſ�ݵ�¼?\n�´���Ҫ���°�');" style="color:red;">���΢�ſ�ݵ�¼</a>
        <%else%>
        ����δ��΢�ſ�ݵ�¼��������           
            <a href="<%=display_tlogin(2)%>"><img src="img/wx_login.gif"></a>
        <%end if%>
      </td>
      </tr>
<%end if%>
    <tr>
      <td style="text-align:right;">ͷ��</td>
      <td class="user_logo" align="center">
      <img id="user_img" class="user_img" title="���ͷ����Ը���" onClick="document.getElementById('uploadpic_iframe').contentWindow.document.getElementById('file1').click();" <%=get_userimg(user_id)%>>
      
      
      </td>
      <td>
      <br><--���ͷ����Ը�����<br>&nbsp;&nbsp;&nbsp;&nbsp;��������Ϊ120*120<br>&nbsp;&nbsp;&nbsp;&nbsp;������500kb��ͼƬ
      <iframe id="uploadpic_iframe" name="uploadpic_iframe" src="main/upload_pic.asp?upload_type=2&pic_size=500&modid=<%=user_id%>" style="display:none"></iframe>
      </td>
    </tr>
    <tr>
      <td style="text-align:right;">�ǳƣ�</td>
      <td><input type="text" name="user_name" class="input_style" value="<%=user_name%>" msg="�ǳƱ�����д!" min="1" dataType="Limit"></td>
      <td><span class="color_red">*</span></td>
    </tr>
    <tr>
      <td style="text-align:right;">���룺</td>
      <td><input type="password" name="user_password" class="input_style" value="<%=user_password%>" msg="���������д!" min="1" dataType="Limit">
      <input class="form-control" name="user_password_old" type="hidden" value="<%=user_password%>">
      </td>
      <td><span class="color_red">*</span></td>
    </tr>
    <tr>
      <td style="text-align:right;">ȷ�����룺</td>
      <td><input type="password" name="user_password2" class="input_style" value="<%=user_password%>" msg="ȷ�����������д!" min="1" dataType="Limit"></td>
      <td><span class="color_red">*</span></td>
    </tr>
    <tr>
      <td style="text-align:right;">��ϵ�绰��</td>
      <td><input type="text" name="user_tel" class="input_style" value="<%=user_tel%>"></td>
      <td></td>
    </tr>
    <tr>
      <td style="text-align:right;">��ϵQQ��</td>
      <td><input type="text" name="user_qq" class="input_style" value="<%=user_qq%>"></td>
      <td></td>
    </tr>
    <tr>
      <td style="text-align:right;">�Ա�</td>
      <td>
      <input type="radio" name="user_sex" value="1" <%if user_sex=1 then response.Write(" checked")%>>&nbsp;&nbsp;<img src="img/sex_1.gif"> ˧��
      &nbsp;&nbsp;&nbsp;&nbsp;
      <input type="radio" name="user_sex" value="2" <%if user_sex=2 then response.Write(" checked")%>>&nbsp;&nbsp;<img src="img/sex_2.gif"> ��Ů
      </td>
      <td></td>
    </tr>
    <tr>
      <td style="text-align:right;">����ǩ����</td>
      <td>
      <textarea name="user_sign" class="input_style" style="height:150px;"><%=user_sign%></textarea>
      </td>
      <td>&nbsp;&nbsp;������120��</td>
    </tr>
    <tr>
      <td ></td>
      <td><input type="submit" class="submit_style" value="ȷ���޸�"></td>
      <td></td>
    </tr>
  </tbody>
</table>
</form>    
    </div>
</div>
