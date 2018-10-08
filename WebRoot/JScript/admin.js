$(function(){
    showDate();
    $("#drop_down,#drop_list").mouseover(function(){
        $(".js_list001").show();         
    });
    $("#drop_down,#drop_list").mouseout(function(){
         $(".js_list001").hide();        
    });
    
    $("#p1").click(function(){
    	
    	 if($(".userlist").css("display")=="none"){
    	        $("#userlist").slideToggle("slow");
    	        $("#video").hide();
    	    }
    	 showBg();
    	 closewindow();
    });  
    
    $("#p2").click(function(){
   	 if($(".userlist").css("display")=="none"){
   	        $("#rolelist").slideToggle("slow");
   	        $("#video").hide();
   	    } 
   	showBg();
   	closewindow();
    });   
    
    $("#p3").click(function(){
      	 if($(".userlist").css("display")=="none"){
      	        $("#privilegelist").slideToggle("slow");
      	        $("#video").hide();
      	    }
      	showBg();
      	closewindow();     	 
    }); 
    
    $(".h128box").children("button").click(function(){
    	if($(".userlist").css("display")=="none"){
  	        $("#rescueplanlist").slideToggle("slow");
  	        $("#video").hide();
  	    }
    	showBg();
    	closewindow();
    });
   
 });
 
 function closewindow()
{	
	 $(".title_sample a img").click(function (){
	        
         $(this).parent().parent().parent().hide("slow");
         $(".overlay").fadeOut(200);
         $("#video").show();
 });
}

function showBg(){
	$(".overlay").height(document.body.scrollHeight);
  	 $(".overlay").width(document.body.scrollWidth);	
  	  $(".overlay").fadeTo(200, 0.5);
  	  $(window).resize(function(){
  	    $(".overlay").height(document.body.scrollHeight);
  	    $(".overlay").width(document.body.scrollWidth);
  	  });
}
function ale(){
	alert("该页面暂时未开放！");
 }

function change(obj){
	var xg=$(obj).html();
	if(xg=='编辑'){
		$('.edit').each(function(){
			var old=$(this).html();
			$(this).html("<input type='text' name='editname' class='text' value="+old+" >");
			});
			$(obj).html('保存');
			$(obj).css("color","4FCD74");
		}else if(xg=='保存'){
			$('input[name=editname]').each(function(){
				//var old=$(this).html();
				var newfont=$(this).parent('td').parent('tr').children().find('input').val();
				$(this).parent('td').html(newfont);
				});
				$(obj).html('编辑');
				
			}
}

 function showDate()
{
	var dt=new Date();
	var day;
	switch(dt.getDay())
	{
	case 0:
	day="日";
	break;
	case 1:
	day="一";
	break;
	case 2:
	day="二";
	break;
	case 3:
	day="三";
	break;
	case 4:
	day="四";
	break;
	case 5:
	day="五";
	break;
	case 6:
	day="六";
	break;
	}
	$("#myDate").text("星期"+day+" "+dt.getFullYear()+"-"+(dt.getMonth() + 1)+"-"+dt.getDate()+" "+dt.getHours()+":"+dt.getMinutes()+":"+dt.getSeconds());
}

function doLogout(){
	var result = confirm("弹出提示信息:是否确认退出本系统？");
	if(result == false){
		return false;
	}
	$.ajax({
		type: "post",
		url: "/droneSystem/UserServlet.do?method=5&time=" + new Date().getTime(),
		dataType: "json",	//服务器返回数据的预期类型
		beforeSend: function(XMLHttpRequest){
			//ShowLoading();
		},
		success: function(data, textStatus){
			window.location.href="/droneSystem/";
		},
		complete: function(XMLHttpRequest, textStatus){
			//HideLoading();
		},
		error: function(){
			//请求出错处理
		}
	});
}