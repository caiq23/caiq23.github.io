<!-- #include file="../inc/conn-bbs.asp" -->
<!-- #include file="../inc/myurl.asp" -->
<!-- #include file="../inc/chk_session.asp" -->
<%
sql="select * from BBS_Topic where topic_id="& topic_no &" and user_id="& session_user_id &""
set rs=bbsconn.execute(sql)
call dperror("",0,rs.eof,"您没有权限修改该主题","")
if not rs.eof then
	topic_user_id=rs("user_id")
	topic_title=rs("topic_title")
	topic_Content=rs("topic_Content")
	replay_cansee=rs("replay_cansee")
end if
replay_cansee=chk_num(replay_cansee)
%>



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

    


<form action="inc/chk_edit_topic.asp" method="post" name="post_form">
<div style="clear:both; padding-top:10px; padding-bottom:10px;">

标题：<input type="text" name="topic_title" class="input_style" placeholder="标题" value="<%=topic_title%>" style="width:50%;">
<input type="hidden" name="topic_id" class="input_style" value="<%=topic_no%>" style="width:50%;">
<input type="hidden" name="topic_user_id" class="input_style" value="<%=topic_user_id%>" style="width:50%;">
</div>

<textarea class="input_style" cols="50" role="50" name="topic_Content" style="  color:#000; width:99%; margin:auto; height:600px; visibility:hidden"><%=trim_fun_3(topic_Content)%></textarea>

<div class="post_select">
	<div class="title">附加选项</div>
	<input type="checkbox" name="replay_cansee" value="1" <%if replay_cansee=1 then response.Write(" checked")%> class="input_style_checkbox"> 回帖仅作者可见
</div>

<div style="clear:both; padding-top:10px;"><input type="submit" class="submit_style" value="发表"></div>
</form>
