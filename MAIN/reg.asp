<!-- #include file="../inc/conn-bbs.asp" -->
<!-- #include file="../inc/myurl.asp" -->
<script language="javascript" type="text/javascript" src="inc/main.js"></script>
<%
qq_OpenID=session("qq_OpenID")
wx_openid=session("wx_openid")
qq_UserName=session("qq_UserName")
%>
<script language="javascript" type="text/javascript" src="inc/reg_chk.js"></script>
<div id="bbsreg_div">
<%
call dperror("",0,bbsset_open_reghy=2,"��վ�ѹر�ע���Ա���ܣ��������Ա��ϵ","?")

if len(qq_OpenID)>0 or len(wx_openid) then
if len(qq_OpenID)>0 then session("reg_my_do")="qq_login"
if len(wx_openid)>0 then session("reg_my_do")="wx_login"

%>
    
    <div class="reg_title">
        �������ʺ�  
    
    </div>
    <div class="reg_content">
    	<form action="inc/chk_reg.asp" method="post" name="login" onSubmit="return Validator.Validate(this,3)">
    <table>
  <tbody>
  <%
if len(qq_OpenID)>0 then  %>
    <tr>
      <td style="text-align:right;" width="30%">��ǰ��ʹ��QQ��ݵ�¼��</td>
      <td  width="30%">
      <a href="inc/logout.asp?myurl=r1.html" style="color:red;">���QQ��ݵ�¼��Ϣ</a>
      </td>
      <td  width="40%"></td>
    </tr>
<%else%>
    <tr>
      <td style="text-align:right;" width="30%">��ǰ��ʹ��΢�ſ�ݵ�¼��</td>
      <td  width="30%">
      <a href="inc/logout.asp?myurl=r1.html" style="color:red;">���΢�ſ�ݵ�¼��Ϣ</a>
      </td>
      <td  width="40%"></td>
    </tr>
<%end if%>
    <tr>
      <td style="text-align:right;" width="30%">�û�����</td>
      <td  width="30%"><input type="text" name="user_num" placeholder="���û���" class="input_style" msg="������4-12λ��ĸ������!" dataType="Limit" min="4"></td>
      <td  width="40%"></td>
    </tr>
    <tr>
      <td style="text-align:right;">���룺</td>
      <td><input type="password" name="user_password" class="input_style" placeholder="��Ա����" msg="���������д!" min="1" dataType="Limit"></td>
      <td></td>
    </tr>
    
      
    
    <tr style=" height:100px;">
      <td ></td>
      <td>
      <input type="submit" class="submit_style" value="���ʺ�">
      <a href="inc/logout.asp?myurl=r1.html">ע�����˺�</a>
      </td>
      <td></td>
    </tr>
  </tbody>
</table>
</form>    
    </div>
    	
    <%else
	
	for i=1 to 100
		'�������6λ��
		Randomize Timer 
		user_id = Int(899999 * Rnd + 100000)
		user_id=right("123456789"&user_id,6)
		sql="select id from BBS_User where user_id="& user_id &""
		set rs=bbsconn.execute(sql)
		if rs.eof then exit for
		call dperror("",0,i>=100,"ϵͳ�����û�ID�������Ժ�������","?r.html")
	next
	
	%>
    <div class="reg_title">
        ����ע��
        <a href="javascript:void(0);" onClick="display_login_div();" title="��¼">�����ʺţ����ڵ�¼</a>    
    
    </div>
    <div class="reg_content">
    	<form action="inc/chk_reg.asp" method="post" name="login" onSubmit="return Validator.Validate(this,3)">
    <table>
  <tbody>
      <tr>
      <td colspan="3" style="">
      ��������
      </td>
      </tr>
    <tr>
      <td style="text-align:right;" width="30%">�û�ID��</td>
      <td  width="30%"><b><%=user_id%></b><input  name="user_id" type="hidden" class="input_style" value="<%=user_id%>" readonly></td>
      <td  width="40%"></td>
    </tr>
    <tr>
      <td style="text-align:right;" width="30%">�û�����</td>
      <td  width="30%"><input type="text" name="user_num" placeholder="�»�Ա�û���" class="input_style" msg="������4-12λ��ĸ������!" dataType="Limit" min="4" onBlur="document.getElementById('chk_use').src='inc/chk_user.asp?chk_type=hynumber&chk_value='+this.value;"></td>
      <td  width="40%"><span id="chk_hynumber" class="color_red">*</span>
      <iframe id="chk_use" name="chk_use" src="" style="display:none"></iframe>
      </td>
    </tr>
    <tr>
      <td style="text-align:right;">�ǳƣ�</td>
      <td><input type="text" name="user_name" class="input_style" placeholder="�»�Ա�ǳ�" msg="�ǳƱ�����д!" min="1" dataType="Limit"></td>
      <td><span class="color_red">*</span></td>
    </tr>
    <tr>
      <td style="text-align:right;">���룺</td>
      <td><input type="password" name="user_password" class="input_style" placeholder="�»�Ա����" msg="���������д!" min="1" dataType="Limit"></td>
      <td><span class="color_red">*</span></td>
    </tr>
    <tr>
      <td style="text-align:right;">ȷ�����룺</td>
      <td><input type="password" name="user_password2" class="input_style" placeholder="ȷ������" msg="ȷ�����������д!" min="1" dataType="Limit"></td>
      <td><span class="color_red">*</span></td>
    </tr>
      <tr>
      <td colspan="3" style="">
      ѡ������
      </td>
      </tr>
    <tr>
      <td style="text-align:right;">��ϵ�绰��</td>
      <td><input type="text" name="user_tel" class="input_style" placeholder="��ϵ�绰"></td>
      <td></td>
    </tr>
    <tr>
      <td style="text-align:right;">��ϵQQ��</td>
      <td><input type="text" name="user_qq" class="input_style" placeholder="��ϵQQ"></td>
      <td></td>
    </tr>
    <tr>
      <td style="text-align:right;">�Ա�</td>
      <td>
      <input type="radio" name="user_sex" value="1" checked>&nbsp;&nbsp;<img src="img/sex_1.gif"> ˧��
      &nbsp;&nbsp;&nbsp;&nbsp;
      <input type="radio" name="user_sex" value="2" >&nbsp;&nbsp;<img src="img/sex_2.gif"> ��Ů
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
    
    
    <tr style=" height:100px;">
      <td ></td>
      <td>
      <input type="submit" class="submit_style" value="����ע��">
      </td>
      <td></td>
    </tr>
  </tbody>
</table>
</form>    
    </div>
    
<%end if%>
    
</div>
