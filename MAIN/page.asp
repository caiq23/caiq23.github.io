<!-- #include file="../inc/conn-bbs.asp" -->
<!-- #include file="../inc/myurl.asp" -->
<script src="inc/wdiii/index.js" type="text/javascript"></script>
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


<%
user_state=chk_num(session("user_state"))

	sql="select * from BBS_Switch"
	set rs=bbsconn.execute(sql)
	if not rs.eof then
		BBS_Switch=rs("BBS_Switch")
		close_tips=rs("close_tips")
	end if
	if chk_num(BBS_Switch)=3 then
		response.Write(dis_block_info("lock",close_tips))
		response.End()
	end if

'call dperror("",0,topic_no<=0,"��ҳ������","")

	
	
sql="select * from BBS_Topic where topic_id="& topic_no &""
set rs=server.CreateObject("adodb.recordset")
rs.open sql,bbsconn,1,3
if not rs.eof then
	user_id=rs("user_id")
	post_user_id=user_id
	topic_id=chk_num(rs("topic_id"))
	topic_title=rs("topic_title")
	topic_Content=rs("topic_Content")
	topic_addtime=rs("topic_addtime")
	lastedit_time=rs("lastedit_time")
	board_id=rs("board_id")
	topic_seetimes=chk_num(rs("topic_seetimes"))
	replay_count=chk_num(rs("replay_count"))
	topic_state=chk_num(rs("topic_state"))
	replay_cansee=chk_num(rs("replay_cansee"))
	board_top=chk_num(rs("board_top"))
	topic_title=dis_posttitle(topic_title,topic_state)
	rs("topic_seetimes")=topic_seetimes+1
	rs.update
	user_name=chk_db("BBS_User","user_id",user_id,"user_name")
end if
%>



<div class="topic_post">
	<%if session_user_id>0 then
    	%><a href="<%=index_url%>n<%=board_id%>.html" title="������"><img src="img/pn_post.png"></a><%
    else
    	%><a href="javascript:void(0);" onClick="display_login_div();" title="������"><img src="img/pn_post.png"></a><%
    end if%>
</div>



<%


   set rs=server.CreateObject("adodb.recordset") 
   sql="select * from BBS_Reply where topic_id="& topic_no &" order by id asc"  
   rs.open sql,bbsconn,1,1
	page_size=bbsset_topicpagesize	
	if not rs.eof then
		rs.PageSize=page_size		
		pagecount=rs.PageCount '��ȡ��ҳ�� 
		if page_no>pagecount then page_no=pagecount		
		rs.AbsolutePage=page_no '���ñ�ҳҳ�� 
		allRecordCount=rs.RecordCount
		
	end if
%><div class="pagination"><li><a href="<%=index_url%>b<%=board_id%>.html" title="�����б�"><img src=img/arw_l.gif> �����б�</a></li><%=bbs_page_no(page_no,pagecount,"")%></div>


<%if session_admin_id>0 then%>
    <div class="admin_topic_div">
    	<form name="form1" method="post" action="inc/admin_post_check.asp?mydo=move_to&modid=<%=topic_no%>">
        <a href="inc/admin_post_check.asp?mydo=del_topic&modid=<%=topic_no%>" onClick="return makesure('�Ƿ�ɾ��������?\n�����������⡢�ظ�һ��ɾ��');">ɾ������</a> | 
        <%select case topic_state
            case 1%>
                <a href="inc/admin_post_check.asp?mydo=checked&modid=<%=topic_no%>" onClick="return makesure('�Ƿ����?');">���</a>
            <%case 2%>
                <a href="inc/admin_post_check.asp?mydo=masking&modid=<%=topic_no%>" onClick="return makesure('�Ƿ�����?');">����</a>
            <%case 3%>
                <a href="inc/admin_post_check.asp?mydo=unmasking&modid=<%=topic_no%>" onClick="return makesure('�Ƿ�������?');">�������</a> 
        <%end select%>

         | 
        <%select case board_top
            case 0%>
                <a href="inc/admin_post_check.asp?mydo=set_top&modid=<%=topic_no%>&board_top=1" onClick="return makesure('�Ƿ���?');">����</a> | 
                <a href="inc/admin_post_check.asp?mydo=set_top&modid=<%=topic_no%>&board_top=2" onClick="return makesure('�Ƿ�ȫվ����?');">ȫվ����</a>
            <%case 1,2%>
                <a href="inc/admin_post_check.asp?mydo=set_top&modid=<%=topic_no%>&board_top=0" onClick="return makesure('�Ƿ�ȡ������?');">ȡ������</a>
        <%end select%>
         | 
        
            <select class="input_style" name="board_id" style="width:15%; ">
                <%call dis_shopclass(0,board_id)%>	
            </select>
            <input type="submit" class="submit_style" value="�ƶ�">
        </form>
    </div>
<%end if%>



<%
	
	
	
	if page_no=1 then call display_post(1,topic_id,1,"",user_id,topic_title,topic_addtime,topic_state,topic_Content,topic_seetimes,replay_count,lastedit_time,0,replay_cansee,post_user_id)

	allRecordCount=chk_num(allRecordCount)
	i=1
	whoami=""

   do while not rs.eof
   
	user_id=rs("user_id")
	reply_content=rs("reply_content")
	topic_state=chk_num(rs("topic_state"))
	replay_id=chk_num(rs("id"))
	from_reply_id=chk_num(rs("from_reply_id"))
	reply_time=rs("reply_time")
	lastedit_time=rs("lastedit_time")
	
	user_where=i+(page_no-1)*page_size
	select case user_where
		case 1
			user_where="ɳ��"
		case 2
			user_where="���"
		case else
			user_where=user_where&"¥"
	end select
	
	post_title=0
	if page_no>1 and i=1 then post_title=1


	call display_post(2,replay_id,post_title,user_where,user_id,"",reply_time,topic_state,reply_content,0,replay_count,lastedit_time,from_reply_id,replay_cansee,post_user_id)

	
	if i>=page_size then exit do  
	i=i+1  
	rs.movenext
	loop
%>

<%if session_admin_id>0 then%>
    <div class="admin_topic_div">
    	<form name="form1" method="post" action="inc/admin_post_check.asp?mydo=move_to&modid=<%=topic_no%>">
        <a href="inc/admin_post_check.asp?mydo=del_topic&modid=<%=topic_no%>" onClick="return makesure('�Ƿ�ɾ��������?\n�����������⡢�ظ�һ��ɾ��');">ɾ������</a> | 
        <%select case topic_state
            case 1%>
                <a href="inc/admin_post_check.asp?mydo=checked&modid=<%=topic_no%>" onClick="return makesure('�Ƿ����?');">���</a>
            <%case 2%>
                <a href="inc/admin_post_check.asp?mydo=masking&modid=<%=topic_no%>" onClick="return makesure('�Ƿ�����?');">����</a>
            <%case 3%>
                <a href="inc/admin_post_check.asp?mydo=unmasking&modid=<%=topic_no%>" onClick="return makesure('�Ƿ�������?');">�������</a>
        <%end select%>
         | 
        <%select case board_top
            case 0%>
                <a href="inc/admin_post_check.asp?mydo=set_top&modid=<%=topic_no%>&board_top=1" onClick="return makesure('�Ƿ���?');">����</a> | 
                <a href="inc/admin_post_check.asp?mydo=set_top&modid=<%=topic_no%>&board_top=2" onClick="return makesure('�Ƿ�ȫվ����?');">ȫվ����</a>
            <%case 1,2%>
                <a href="inc/admin_post_check.asp?mydo=set_top&modid=<%=topic_no%>&board_top=0" onClick="return makesure('�Ƿ�ȡ������?');">ȡ������</a>
        <%end select%>
         | 
            <select class="input_style" name="board_id" style="width:15%; ">
                <%call dis_shopclass(0,board_id)%>	
            </select>
            <input type="submit" class="submit_style" value="�ƶ�">
        </form>
    </div>
<%end if%>

<div class="pagination"><li><a href="<%=index_url%>b<%=board_id%>.html" title="�����б�"><img src=img/arw_l.gif> �����б�</a></li><%=bbs_page_no(page_no,pagecount,"")%></div>



<div class="topic_post">
	<%if session_user_id>0 then
    	%><a href="<%=index_url%>n<%=board_id%>.html" title="������"><img src="img/pn_post.png"></a><%
    else
    	%><a href="javascript:void(0);" onClick="display_login_div();" title="������"><img src="img/pn_post.png"></a><%
    end if%>
</div>




   	<div class="page_top">
        <div class="page_left">
        	<%if session_user_id>0 then%>
                <div class="page_left_menu2">
                    <a href="<%=index_url%>u<%=session_user_id%>.html"><%=session("user_name")%></a>
                </div>
                <div class="user_logo">
                    <img <%=get_userimg(session_user_id)%>>
                </div>
            <%end if%>
        </div>
        <div class="page_right">
<div class="topic_Content" style="padding-top:30px;">
<form action="inc/chk_replay.asp" method="post" name="post_form">	

    <div style=" float:left; width:70%; position:relative;">
	<%if session_user_id<=0 then%>
        <div class="notlogin_replay">
            ����Ҫ��¼��ſ��Ի���
            <a href="javascript:void(0);" onClick="display_login_div();" title="��¼��Ա">��¼</a> |
            <a href="<%=index_url%>r1.html">����ע��</a>
        </div>
    <%end if%>
    <textarea class="input_style" cols="50" role="50" name="topic_Content" style="  color:#000; width:100%; height:280px; visibility:hidden"></textarea>
    <input type="hidden" value="<%=topic_no%>" name="topic_id">
    </div>
    <div style=" float:left; width:28%; padding-left:2%;">
    <b>������</b>
    <div style="line-height:22px; text-indent:2em; font-size:12px;"><%=chk_db("BBS_Board","board_id",board_id,"board_law")%></div>
    </div>
    
<div class="topic_post_div">

    <div class="topic_post">
        <%if session_user_id>0 then
            %><input type="submit" class="submit_style" value="����ظ�"><%
        else
            %><input type="button" class="submit_style" value="����ظ�" onClick="display_login_div();"><%
        end if%>
    </div>


</div>
    
 </form>   
</div>

        	           
        </div>
<div style="clear:both;"></div>
   </div>
   
   
   
   <%
   '��ʾ����
	sub display_post(post_type,post_id,post_title,user_where,user_id,topic_title,topic_addtime,topic_state,topic_Content,topic_seetimes,replay_count,lastedit_time,from_reply_id,replay_cansee,post_user_id)
	
	
	topic_Content=trim_fun_3(topic_Content)
	if post_type=1 then topic_Content=chk_post_hide(topic_Content,post_id)
	topic_Content=dis_post_img(topic_Content)
  
	
	'��ȡ�û�Ա����
	sql_hy="select * from BBS_User where user_id="& user_id &""
	set rs_hy=bbsconn.execute(sql_hy)
	if not rs_hy.eof then
		user_name=rs_hy("user_name")
		user_tel=rs_hy("user_tel")
		user_qq=rs_hy("user_qq")
		user_sign=rs_hy("user_sign")
		
		user_sex=chk_num(rs_hy("user_sex"))		
	end if
	
	'��ȡ�������
	sql_hy="select * from BBS_Board where board_id=(select board_id from BBS_Topic where topic_id="& post_id &")"
	set rs_hy=bbsconn.execute(sql_hy)
	if not rs_hy.eof then
		board_name=rs_hy("board_name")		
		board_cansee=rs_hy("board_cansee")		
	end if
	board_cansee=chk_num(board_cansee)
%>

	<div class="page_top">
        <div class="page_left">
        	<%if post_title=1 then%>
                 <div class="page_left_menu1"> 
                    <%if post_type=1 then%>           
                        �鿴: <span><%=topic_seetimes%></span>
                        &nbsp;|&nbsp;
                        �ظ�: <span><%=replay_count%> </span>
                    <%end if%>
                </div>
            <%end if%>
            
            <div class="page_left_menu2">      	
        		
              <a href="<%=index_url%>u<%=user_id%>.html"><%=user_name%></a>
                
            </div>
            
            <div class="user_logo">
        		<img <%=get_userimg(user_id)%>>
            </div>
            
            
        </div>
        <div class="page_right">
        
        	<%if post_title=1 then%>
                <div class="page_right_menu1" title="<%=topic_title%>">
                    <%=left(topic_title,35)%>
                </div>
            <%end if%>
            <div class="page_right_where">
				<%if post_type=1 then%>
                    ¥��
                <%else%>
                	<%=user_where%>
                <%end if%>
            </div>
            <div class="page_right_menu2">
        		<img src="img/sex_<%=user_sex%>.gif"> ������ <%=howlong(topic_addtime)%>
            </div>
            <div class="topic_Content">
            <%select case topic_state
				case 1
					response.Write(dis_block_info("lock","����������У�ֻ�й���Ա���й���Ȩ�޵ĳ�Ա�ɼ�"))
				case 3
					response.Write(dis_block_info("lock","����������Ա���Σ�ֻ�й���Ա���й���Ȩ�޵ĳ�Ա�ɼ�"))
			 end select
			 if replay_cansee=1 and post_type=2 then response.Write(dis_block_info("lock","�����ظ�ֻ��ԭ���߿ɼ�"))
			 %> 
                           
              <%if topic_state=2 or session_admin_id>0 then%>
              	<div class="lastedit_time">
					<%if len(lastedit_time)>0 then%>
                        ��������� <%=user_name%> �� <%=howlong(lastedit_time)%> �༭
                    <%end if%>
              </div>
				  <%if from_reply_id>0 then
                      sql_from="select * from BBS_Reply where id="& from_reply_id &""
                      set rs_from=bbsconn.execute(sql_from)
                      if not rs_from.eof then
                            from_user_id=rs_from("user_id")
                            from_reply_time=howlong(rs_from("reply_time"))
                            from_reply_content=RegExphtml(rs_from("reply_content"))
                            from_topic_state=chk_num(rs_from("topic_state"))
                            if from_topic_state<>2 then
                                from_reply_content="��ʾ��ԭ�����ѱ�����Ա����"
                            else
                                if len(from_reply_content)>0 then from_reply_content=left(from_reply_content,50)
                            end if
                            from_user_name=chk_db("BBS_User","user_id",from_user_id,"user_name")
                      else
                            from_user_name="δ֪�û�"
                            from_reply_time=""
                            from_reply_content="��ʾ��ԭ�����ѱ�ɾ��"			
                      end if 
                  %>
                      <div class="post_quote_div">
                          <div class="post_quote_gif1"><img src="img/quote.gif"></div>
                          <div class="post_quote_gif2"><a href="<%=index_url%>p<%=topic_no%>.html"><%=from_user_name%> ������ <%=from_reply_time%></a><br><%=from_reply_content%></div>
                          <div class="post_quote_gif3"><img src="img/quote2.gif"></div>
                      </div>
                  <%end if%>
              
				  <%

				  
				  
				  select case board_cansee
                  		case 1
							if session_user_id=0 then topic_Content=dis_block_info("lock","�������Ҫ��¼����ܲ鿴")
                  		case 2
							if user_state<4 and session_admin_id=0 then topic_Content=dis_block_info("lock","�������Ҫ��VIP/��������Ȩ�޲��ܲ鿴")
                  		case 3
							if user_state<5 and session_admin_id=0 then topic_Content=dis_block_info("lock","�������Ҫ�г�������Ȩ�޲��ܲ鿴")
                  		case 4
							if session_admin_id=0 then topic_Content=dis_block_info("lock","�������Ҫ�й���ԱȨ�޲��ܲ鿴")
                  end select
				  if replay_cansee=1 and post_type=2 and session_user_id<>post_user_id and session_user_id<>user_id and session_admin_id=0 then topic_Content=""
				  %>
              	  <%=topic_Content%>
               <%end if%> 
               
              <div style="clear:both; height:120px;"></div>
              <div class="topic_edit_line_div">          
                  <%if len(user_sign)>0 then%><div class="topic_edit_line user_sign"><ul><li><%=user_sign%></li></ul></div><%end if%>
                
                  <div class="topic_edit_line">
                  	<ul>
                  		<li>
							 <%if post_type=2 and session_user_id<>user_id then%>
                                <%if session_user_id>0 then
                                    %><a href="<%=index_url%>q<%=post_id%>.html" title="�ظ�"><%
                                else
                                    %><a href="javascript:void(0);" onClick="display_login_div();" title="�ظ�"><%
                                end if%>
                                <img src="img/fastreply.gif">&nbsp;�ظ�</a>&nbsp;&nbsp;&nbsp;&nbsp;
                            <%end if%> 
                            <%if user_id=session_user_id then%>
                                <%if post_type=1 then%>
                                    <a href="<%=index_url%>z<%=post_id%>.html" title="�༭����"><img src="img/edit.gif">&nbsp;�༭</a>
                                <%else%>
                                    <a href="<%=index_url%>h<%=post_id%>.html" title="�༭�ظ�"><img src="img/edit.gif">&nbsp;�༭</a>
                                <%end if%> 
                                &nbsp;&nbsp;&nbsp;&nbsp;
                            <%end if%>
                            <%if session_admin_id>0 and post_type=2 then%>                               
                                <%select case topic_state
                                    case 1%>
                                        <a href="inc/admin_replay_check.asp?mydo=checked&modid=<%=post_id%>" onClick="return makesure('�Ƿ���˸ûظ�?');"><img src="img/lock.gif">&nbsp;���</a>
                                    <%case 2%>
                                        <a href="inc/admin_replay_check.asp?mydo=masking&modid=<%=post_id%>" onClick="return makesure('�Ƿ����θûظ�?');"><img src="img/lock.gif">&nbsp;����</a> 
                                    <%case 3%>
                                        <a href="inc/admin_replay_check.asp?mydo=unmasking&modid=<%=post_id%>" onClick="return makesure('�Ƿ������θûظ�?');"><img src="img/lock.gif">&nbsp;�������</a> 
                                <%end select%>
                                &nbsp;&nbsp;&nbsp;&nbsp;
                                 <a href="inc/admin_replay_check.asp?mydo=del_replay&modid=<%=post_id%>" onClick="return makesure('�Ƿ�ɾ���ûظ�?\nֻ��ɾ���ظ�����Ӱ������');"><img src="img/close2.gif">&nbsp;ɾ��</a>&nbsp;&nbsp;&nbsp;&nbsp;
                            <%end if%>
                        </li>
                     </ul>                      
                  </div>
                
              </div>
        	 </div>        
        </div>
<div style="clear:both;"></div>
   </div>
  <%end sub
  
  
  
  
  
  

  
  
  
  
  
  
  
  
  %> 
  
