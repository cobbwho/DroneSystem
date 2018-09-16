$(function(){
    showDate();
    $("#drop_down,#drop_list").mouseover(function(){//鼠标移动到select栏中的操作
        $(".js_list001").show();//使下拉的option选项show出来                
    });
    $("#drop_down,#drop_list").mouseout(function(){//鼠标移开后select的行为
         $(".js_list001").hide();        
    });
    
    $("#p1").click(function(){
    	
    	 if($(".userlist").css("display")=="none"){
    	        $("#userlist").slideToggle("slow");
    	      
    	    }
    	 $(".overlay").height(document.body.scrollHeight);
    	 $(".overlay").width(document.body.scrollWidth);
    	 console.log(document.body.scrollWidth);
    	  // fadeTo第一个参数为速度，第二个为透明度
    	  // 多重方式控制透明度，保证兼容性，但也带来修改麻烦的问题
    	  $(".overlay").fadeTo(200, 0.5);
    	  // 解决窗口缩小时放大后不全屏遮罩的问题
    	  // 简单来说，就是窗口重置的问题
    	  $(window).resize(function(){
    	    $(".overlay").height(document.body.scrollHeight);
    	    $(".overlay").width(document.body.scrollWidth);
    	  });
    	 closewindow();
    });  
    
    $("#p2").click(function(){
   	 if($(".userlist").css("display")=="none"){
   	        $("#rolelist").slideToggle("slow");
   	        
   	    } 
   	showBg();
   	closewindow();
    });   
    
    $("#p3").click(function(){
      	 if($(".userlist").css("display")=="none"){
      	        $("#privilegelist").slideToggle("slow");
      	     
      	    }
      	$(".overlay").height(document.body.scrollHeight);
   	 $(".overlay").width(document.body.scrollWidth);
   	 console.log(document.body.scrollWidth);
   	  // fadeTo第一个参数为速度，第二个为透明度
   	  // 多重方式控制透明度，保证兼容性，但也带来修改麻烦的问题
   	  $(".overlay").fadeTo(200, 0.5);
   	  // 解决窗口缩小时放大后不全屏遮罩的问题
   	  // 简单来说，就是窗口重置的问题
   	  $(window).resize(function(){
   	    $(".overlay").height(document.body.scrollHeight);
   	    $(".overlay").width(document.body.scrollWidth);
   	  });
   	 closewindow();
      	 
    }); 
   
 })
 
 function closewindow()
{	
	 $(".title_sample a img").click(function (){
	        
         $(this).parent().parent().parent().hide("slow");
         $(".overlay").fadeOut(200);
 });
}

function showBg(){
	var bh=$("body").height();
	var bw=$("body").width();
	$(".overlay").css({
		height:bh,
		width:bw,
		display:"block",
	});
}
function ale(){
	alert("该页面暂时未开放！");
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