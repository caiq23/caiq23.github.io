
	
	//�������ť
	function openmenu(num){
		for (var i=0;i< document.getElementsByName("menu_small").length;i++) {
			document.getElementById("menu_"+(i+1)).style.display="none"; 
		}
		document.getElementById("menu_"+num).style.display="block"; 
	}   
			
			
	//�ұ�����ҳ������Ӧ�߶�
		function iFrameHeight() {               
			var ifm= document.getElementById("rightFrame"); 
			var subWeb = document.frames ? document.frames["rightFrame"].document : ifm.contentDocument;            
			if(ifm != null && subWeb != null) {
			ifm.height = subWeb.body.scrollHeight;
			ifm.width = subWeb.body.scrollWidth;
			} 
		} 


//��ʾ������DIV
function dis_div_block(div_id)
	{
		if(document.getElementById(div_id).style.display=='none'){
			document.getElementById(div_id).style.display='block';
			}else{
				document.getElementById(div_id).style.display='none';
				}
		}

//ɾ���Ȳ���ǰȷ��
	function makesure(alert_text)
	{
		return(confirm(alert_text))
	}
	
//��ʾ��������߲˵�
	function close_leftmenu()
	{
		dis_div_block('main_left');
		if(document.getElementById('main_left').style.display=='none'){
			document.getElementById('main_right').style.width='98%'
			}else{
				document.getElementById('main_right').style.width='85%'
				}
		
	}