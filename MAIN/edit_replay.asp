<!-- #include file="../inc/conn-bbs.asp" -->
<!-- #include file="../inc/myurl.asp" -->
<!-- #include file="../inc/chk_session.asp" -->
<%
sql="select * from BBS_Reply where id="& topic_no &" and user_id="& session_user_id &""
set rs=bbsconn.execute(sql)
call dperror("",0,rs.eof,"您没有权限修改该回复","")
if not rs.eof then
	replay_user_id=rs("user_id")
	topic_id=rs("topic_id")
	reply_content=rs("reply_content")
end if

%>


	<link rel="stylesheet" href="inc/qingeditor/themes/default/default.css" />
	<link rel="stylesheet" href="inc/qingeditor/plugins/code/prettify.css" />
	<script charset="gb2312" src="inc/qingeditor/qingeditor-all.js"></script>
	<script charset="gb2312" src="inc/qingeditor/lang/zh-CN.js"></script>
	<script charset="gb2312" src="inc/qingeditor/plugins/code/prettify.js"></script>
	<script>
		qingeditor.ready(function(K) {
			var editor1 = K.create('textarea[name="reply_content"]', {
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
    


<form action="inc/chk_edit_replay.asp" method="post" name="post_form">
<div style="clear:both; padding-top:10px; padding-bottom:10px;">

修改主题：<%=chk_db("BBS_Topic","topic_id",topic_id,"topic_title")%>
<input type="hidden" name="replay_id" class="input_style" value="<%=topic_no%>" style="width:50%;">
<input type="hidden" name="replay_user_id" class="input_style" value="<%=replay_user_id%>" style="width:50%;">
</div>

<textarea class="input_style" cols="50" role="50" name="reply_content" style="  color:#000; width:99%; margin:auto; height:600px;visibility:hidden"><%=trim_fun_3(reply_content)%></textarea>

<div style="clear:both; padding-top:10px;"><input type="submit" class="submit_style" value="发表"></div>
</form>
