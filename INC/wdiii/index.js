
	
	//左边栏按钮
	function openmenu(num){
		for (var i=0;i< document.getElementsByName("menu_small").length;i++) {
			document.getElementById("menu_"+(i+1)).style.display="none"; 
		}
		document.getElementById("menu_"+num).style.display="block"; 
	}   
			
			
	//右边套入页面自适应高度
		function iFrameHeight() {               
			var ifm= document.getElementById("rightFrame"); 
			var subWeb = document.frames ? document.frames["rightFrame"].document : ifm.contentDocument;            
			if(ifm != null && subWeb != null) {
			ifm.height = subWeb.body.scrollHeight;
			ifm.width = subWeb.body.scrollWidth;
			} 
		} 


//显示、隐藏DIV
function dis_div_block(div_id)
	{
		if(document.getElementById(div_id).style.display=='none'){
			document.getElementById(div_id).style.display='block';
			}else{
				document.getElementById(div_id).style.display='none';
				}
		}

//删除等操作前确认
	function makesure(alert_text)
	{
		return(confirm(alert_text))
	}
	
//显示、隐藏左边菜单
	function close_leftmenu()
	{
		dis_div_block('main_left');
		if(document.getElementById('main_left').style.display=='none'){
			document.getElementById('main_right').style.width='98%'
			}else{
				document.getElementById('main_right').style.width='85%'
				}
		
	}