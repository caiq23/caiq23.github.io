<%select case this_page%>
<%case "main","page"%>
    <div class="top_menu_com all_top_menu">
        <div class="logo" onClick="window.location.href='<%=BBS_folder%>wap/index.asp'">
            <%=bbsset_sitename%>
        </div>                
        <div class="right" style="width:50%;">					           
            <div class="search_div">	
                <form name="search" method="get" action="<%=BBS_folder%>wap/list.asp" onSubmit="if(key_word.value==''){alert('ÇëÊäÈë¹Ø¼ü´Ê');return false}">
                    <input class="search_input" id="key_word" type="search" name="key_word" placeholder="ÊäÈë¹Ø¼ü´Ê" value="<%=key_word%>" >
                    
                </form>
            </div>      
        </div>            
    </div>
    
    <div class="both_55"></div>   
<%case "board"%>
    <div class="top_menu_com top_menu_search">
		<div class="search_div">	
            <form name="search" method="get" action="<%=BBS_folder%>wap/list.asp" onSubmit="if(key_word.value==''){alert('ÇëÊäÈë¹Ø¼ü´Ê');return false}">
                <input class="search_input" id="key_word" type="search" name="key_word" placeholder="ÊäÈë¹Ø¼ü´Ê" value="<%=key_word%>" >
                
            </form>
        </div>            
    </div>
    
    <div class="both_55"></div> 
<%case "list"%>
    <div class="top_menu_com top_menu_back">
		<div class="left">	
           <a href="index.asp?bt_show=0"><img src="img/back_w.png" height="25"></a>
        </div> 
        <div class="center">	
           <%=title%>
        </div>
        <div class="right">	
           
        </div>           
    </div>
    
    <div class="both_55"></div>
<%end select%>