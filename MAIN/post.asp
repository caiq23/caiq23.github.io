<!-- #include file="../inc/conn-bbs.asp" -->
<!-- #include file="../inc/myurl.asp" -->

<script language="javascript" type="text/javascript" src="inc/main.js"></script>

	<link rel="stylesheet" href="inc/qingeditor/themes/default/default.css" />
	<link rel="stylesheet" href="inc/qingeditor/plugins/code/prettify.css" />
	<script charset="gb2312" src="inc/qingeditor/qingeditor-all.js"></script>
	<script charset="gb2312" src="inc/qingeditor/lang/zh-CN.js"></script>
	<script charset="gb2312" src="inc/qingeditor/plugins/code/prettify.js"></script>
	<script>
		qingeditor.ready(function(K) {
			var editor1 = K.create('textarea[name="topic_Content"]', {
				cssPath : 'inc/qingeditor/plugins/code/prettify.css',
				uploadJson : 'inc/qingeditor/asp/upload_json.asp',
				fileManagerJson : 'inc/qingeditor/asp/file_manager_json.asp',
				allowFileManager : true,
				afterCreate : function() {
					var self = this;
					K.ctrl(document, 13, function() {
						self.sync();
						K('form[name=post_form]')[0].submit();
					});
					K.ctrl(self.edit.doc, 13, function() {
						self.sync();
						K('form[name=post_form]')[0].submit();
					});
				}
			});
			prettyPrint();
		});
	</script>


<%if session_user_id>0 then

sql="select * from BBS_User where user_id="& session_user_id &""
set rs=bbsconn.execute(sql)
if not rs.eof then user_state=chk_num(rs("user_state"))


'��ȡ����Ƿ��ֹ����
this_html=""
sql="select * from BBS_Board where board_id="& topic_no &""
set rs=bbsconn.execute(sql)
if not rs.eof then
	board_can_post=chk_num(rs("board_can_post"))
	select case board_can_post
		case 2
			if user_state<>4 and session_admin_id=0 then this_html="����������û���㹻��Ȩ���ڱ���鷢��"
		case 3
			if session_admin_id=0 then this_html="����������û���㹻��Ȩ���ڱ���鷢��"
		case 10
			this_html="�������󣺱�����ֹ�������������Ա��ϵ"
	end select
end if
call dperror("",0,len(this_html)>0,this_html,"?b"& topic_no &".html")


%>
<form action="inc/chk_post.asp" method="post" name="post_form">
<div style="clear:both; padding-top:10px; padding-bottom:10px;">

���⣺<input type="text" name="topic_title" class="input_style" placeholder="����" value="<%=session("topic_title")%>" style="width:50%;">
��飺
<select class="input_style" name="board_id" style="width:15%;">
	<%call dis_shopclass(0,topic_no)%>	
</select>

</div>

<textarea class="input_style" cols="50" role="50" name="topic_Content" style="  color:#000; width:99%; margin:auto; height:600px;visibility:hidden;"><%=session("topic_Content")%></textarea>

<div class="post_select">
	<div class="title">����ѡ��</div>
	<input type="checkbox" name="replay_cansee" value="1" class="input_style_checkbox"> ���������߿ɼ�&nbsp;&nbsp;&nbsp;&nbsp;
    <input type="checkbox"  name="if_reply_cansee" value="1" class="input_style_checkbox" onClick="if(this.checked==true){document.getElementById('reply_cansee_div').style.display='block';}else{document.getElementById('reply_cansee_div').style.display='none';}"> ���ûظ��ɼ����� 
    
    <div id="reply_cansee_div">
    	<div class="title">��������������ݣ�������Ա��Ҫ�ظ����ܲ鿴��<span>��Ҳ����ֱ����������ӱ�� [hide] �������� [/hide] ��</span></div>
        <textarea class="input_style" name="reply_cansee_Content" cols="50" role="50" style="  color:#000; width:100%; margin:auto; height:150px;"><%=session("reply_cansee_Content")%></textarea>
    
    </div>   
</div>

<div style="clear:both; padding-top:10px;"><input type="submit" class="submit_style" value="��������"></div>
</form>
<%
else
%>
<div class="cannot_post">
�����οͣ��� <a href="javascript:void(0);" onClick="display_login_div();" title="��¼��Ա">��¼��Ա</a> �����
</div>
<%
end if%>

            
