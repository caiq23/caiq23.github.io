<!--#include file="heck.asp"-->
<!--#include file ="md5.asp"-->
<%
'*****************************************
'���ߣ�guke
'QQ��6692103
'*****************************************
if request("pwd")=" �� �� " then
If request.form("pwd2") <> request.form("pwd3") then
Response.Write "<script>alert('�������벻��ͬ!');location='javascript:history.back(-1)'</SCRIPT>"
Response.End
end if
set rs=server.createobject("adodb.recordset")  
sql="select * from [admin] where id="&Request.Cookies("id")
rs.open sql,conn,1,3
If rs("passwd") <> md5(request.form("pwd1")) then
Response.Write "<script>alert('���������!');location='javascript:history.back(-1)'</SCRIPT>"
Response.End
end if
if len(request.form("pwd2"))<4 then
Response.Write "<script>alert('�û����벻������4λ!');location='javascript:history.back(-1)'</SCRIPT>"
Response.End
end if
rs("passwd")=md5(request.form("pwd2"))
rs.Update
response.write "<script>alert('�����ɹ�!');location='right.asp'</script>"
rs.close
end if
%>
<html>
<head>
<title></title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<link href="../images/css.css" rel="stylesheet" type="text/css" />
</head>
<script type="text/javascript">
function chk(theForm){
if (theForm.pwd1.value == ""){
                alert("�����������!");
                theForm.pwd1.focus();
                return (false);
        }
if (theForm.pwd2.value == ""){
                alert("������������!");
                theForm.pwd2.focus();
                return (false);
        }
if (theForm.pwd3.value == ""){
                alert("���ظ�����������!");
                theForm.pwd3.focus();
                return (false);
        }
}
</script>
<body>
<table width="100%" border="0" cellspacing="6" cellpadding="0" align="center">
 <form action="" method=post name=form1 onSubmit="return chk(this)">
    <tr> 
      <td height=25 colspan=2 align="center" bgcolor="#F9F9F9"><b>�� �� �� ��</b></td>
    </tr>
    <tr> 
      <td width="40%" align="right">�����룺</td>
      <td width="60%"><input name="pwd1" size="28" type="password" maxlength="26" /></td>
    </tr>
    <tr> 
      <td width="40%" align="right">�����룺</td>
      <td width="60%"><input name="pwd2" size="28" type="password" maxlength="26" /></td>
    </tr>
    <tr> 
      <td width="40%" align="right">�ظ����룺</td>
      <td width="60%"><input name="pwd3" size="28" type="password" maxlength="26" /></td>
    </tr>
    <tr> 
      <td width="40%" align="right">&nbsp;</td>
      <td width="60%"><input type="submit" name="pwd" value=" �� �� " /></td>
    </tr>
  </form>
</table>
</html>