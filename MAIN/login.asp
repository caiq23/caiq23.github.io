<div id="login_div">
	<div class="login_div_title">用户登录</div>
    <form action="inc/chk_login.asp" method="post" name="login">
        <table>
            <tbody>
                <tr>
                    <td style="text-align:right;" width="25%">用户名：</td>
                    <td  width="45%"><input name="user_num" placeholder="用户名" class="input_style"></td>
                    <td  width="30%"><a href="<%=index_url%>r1.html">立即注册</a></td>
                    </tr>
                    <tr>
                    <td style="text-align:right;">密码：</td>
                    <td><input type="password" placeholder="密码" name="user_password" class="input_style"></td>
                    <td></td>
                    </tr>
                    <tr>
                    <td ></td>
                    <td>
                    <input type="hidden" name="re_myurl" value="<%=myurl%>">
                    <input type="submit" class="submit_style" value="登录"></td>
                    <td></td>
                </tr>
            </tbody>
        </table>
    </form>
	<div class="close_logindiv"><img src="img/close1.gif" onMouseOver="this.src='img/close2.gif'" onMouseOut="this.src='img/close1.gif'" title="关闭" onClick="window.document.getElementById('login_div').style.display='none';"></div>

    <div class="quickly_login_div">
    	快捷登录 :
        
        
		 <%if bbsset_open_wxlogin=1 then%>
             <a href="<%=display_tlogin(2)%>"><img src="<%=BBS_folder%>img/wx_login.gif"></a>
         <%end if%>
         <%if bbsset_open_qqlogin=1 then%>
             <a href="<%=display_tlogin(1)%>"><img src="<%=BBS_folder%>img/qq_login.gif"></a>
         <%end if%>
    </div>

</div>

