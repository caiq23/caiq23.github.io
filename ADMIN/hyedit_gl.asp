<!-- #include file="../inc/conn-bbs.asp" -->
<!-- #include file="../inc/check_admin_session.asp" -->

<!Doctype html>
<html>
<%

		modid=CHK_num(trim(request("modid")))		
%>
<head>
<meta charset="gb2312">
<title>�޸�����</title>   
<link href="../inc/wdiii/common.css" rel="stylesheet">
   <link href="../inc/wdiii/table.css" rel="stylesheet">
   <script src="../inc/wdiii/index.js" type="text/javascript"></script>
   
    
<script language="javascript" type="text/javascript" src="../inc/reg_chk.js"></script>

</head>



<body>
<div class="alert alert-warning">
    ��ʾ���޸ĺ���ȷ�������ܱ�����Ч
   
</div>

<%
sql="select * from BBS_User where user_id="& modid &""
set rs=bbsconn.execute(sql)
if not rs.eof then
	user_num=rs("user_num")
	user_name=rs("user_name")
	user_id=rs("user_id")
	user_state=rs("user_state")
	login_times=rs("login_times")
	user_password=rs("user_password")
	user_addtime=rs("user_addtime")
end if
user_state=CHK_num(user_state)
%>

<FORM name="form2" action="hyedit_gl_check.asp?mydo=modok&modid=<%=modid%>" method="post" onSubmit="return Validator.Validate(this,3)">
<table class="table table-bordered table-responsive td_title">
  <thead><tr>
    <th colspan="2" class="right_title">�޸Ļ�Ա����</th>
  </tr></thead>


    <tr>
        <td align="right" width="30%">��¼�ʺ�:</td>
        <td align="left" width="70%"><%=user_num%></td>
    </tr>
    
    <tr>    
        <td align="right">�ǳ�:</td>
        <td align="left"><input class=" form-control" name="user_name" type="text" msg="�ǳƱ���!" min="1" dataType="Limit" value="<%=user_name%>"></td>
    </tr>    
    
    <tr>    
        <td align="right">����:</td>
        <td align="left"><input class="form-control" name="user_password" type="password" value="<%=user_password%>" msg="���벻��С��4λ��!" min="4" dataType="Limit">
        <input class="form-control" name="user_password_old" type="hidden" value="<%=user_password%>">
        </td>
    </tr>
    <tr>    
        <td align="right">״̬:</td>
        <td align="left">
        <select name="user_state" class=" form-control">
        	<option value="1">����</option>
            <option value="2" <%if user_state=2 then response.Write(" selected")%> >����</option>
            <option value="3" <%if user_state=3 then response.Write(" selected")%> >����</option>
        </select>
        </td>
    </tr>
    
        <tr>    
        <td style="height:50px;" align="right"></td>
        <td align="left"><input class="btn btn-primary" type="submit" name="Submit" value="ȷ���޸�"></td>
    </tr>

  
  </table>
</FORM>
</body>
</html>