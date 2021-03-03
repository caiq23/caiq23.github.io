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
	if topic_no>0 then
	  sql_from="select * from BBS_Reply where id="& topic_no &""
	  set rs_from=bbsconn.execute(sql_from)
	  if not rs_from.eof then
			from_user_id=rs_from("user_id")
			from_topic_id=rs_from("topic_id")
			from_reply_time=howlong(rs_from("reply_time"))
			from_reply_content=RegExphtml(rs_from("reply_content"))
			from_topic_state=chk_num(rs_from("topic_state"))
			if from_topic_state<>2 then
				from_reply_content="提示：原内容已被管理员屏蔽"
			else
				if len(from_reply_content)>0 then from_reply_content=left(from_reply_content,50)
			end if
			from_user_name=chk_db("BBS_User","user_id",from_user_id,"user_name")
	  else
			from_user_name="未知用户"
			from_reply_time=""
			from_topic_id=0
			from_reply_content="提示：原内容已被删除"			
	  end if
	end if
%>
<form action="inc/chk_quote.asp?quote_id=<%=topic_no%>" method="post" name="post_form">
<div style="clear:both; padding-top:10px; padding-bottom:10px;">

<div style="color:#999;padding-bottom:15px;">
<a href="<%=index_url%>p<%=from_topic_id%>.html" target="_blank"><%=from_user_name%> 发表于 <%=from_reply_time%></a>
<br>
<%=from_reply_content%>
</div>
</div>

<textarea class="input_style" cols="50" role="50" name="topic_Content" style="  color:#000; width:99%; margin:auto; height:600px;visibility:hidden;"></textarea>

<div style="clear:both; padding-top:10px;"><input type="submit" class="submit_style" value="参与/回复主题"></div>
</form>
<%
else
%>
<div class="cannot_post">
您是游客，请 <a href="javascript:void(0);" onClick="display_login_div();" title="登录会员">登录会员</a> 后操作
</div>
<%
end if%>

            
