<%
if (len(session("admin_num"))=0 or isnull(session("admin_num"))) and (len(request.Cookies("xq_bbs")("admin_id"))=0 or isnull(request.Cookies("xq_bbs")("admin_id"))) then
%>
<script>
alert("��¼��ʱ��Ϊ��ȫ����������µ�¼�ٲ�����");
parent.window.location.href='../';
window.location.href='../';
</script>
<%
	response.End()
end if

%>