<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="viewport" content="initial-scale=1.0, user-scalable=no" />
    <style type="text/css">
	.BMap_cpyCtrl {  
    display: none;  
    }  
  
    .anchorBL {  
    display: none;  
    }  
     body, html{width: 100%;height: 100%;margin:0;font-family:"微软雅黑";font-size:14px;}
     #allmap{height:90%;width:80%;}
     #r-result{width:80%;} 
    </style>
	<link href="http://api.map.baidu.com/library/TrafficControl/1.4/src/TrafficControl_min.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="http://api.map.baidu.com/api?v=1.4&ak=jwTcIoGGL3WahiyCb2Hg7juZi1TGym0Y"></script>
	<script type="text/javascript" src="http://api.map.baidu.com/library/TrafficControl/1.4/src/TrafficControl_min.js"></script>
	<link rel="stylesheet" type="text/css" href="../Inc/Style/themes/default/easyui.css" />
    <link rel="stylesheet" type="text/css" href="../Inc/Style/themes/icon.css" />
	<link rel="stylesheet" type="text/css" href="../Inc/Style/themes/icon2.css" />
    <link rel="stylesheet" type="text/css" href="../Inc/Style/Style.css" />
    <link rel="stylesheet" type="text/css" href="../Inc/Style/video-js.css" >
	
    <script type="text/javascript" src="../Inc/JScript/jquery-1.6.min.js"></script>
    <script type="text/javascript" src="../Inc/JScript/jquery.easyui.min.js"></script>
    <script type="text/javascript" src="../Inc/JScript/locale/easyui-lang-zh_CN.js" charset="utf-8"></script>
	<script type="text/javascript" src="../JScript/upload.js"></script>
	<script src="http://echarts.baidu.com/build/dist/echarts-all.js"></script>
    <script type="text/javascript" src="../JScript/json2.js"></script>
    <script type="text/javascript" src="http://vjs.zencdn.net/5.18.4/video.min.js"></script>
    <title>流量信息</title>
</head>
<body>
	<div style="width:1500px; height:600px;">
    <table border="0" cellpadding="0" cellspacing="0" width="100%">
    <tr>
    <td>
	 <div id="allmap"  style="width: 650px; height: 840px"></div>
	</td>
	<td>
	 <div id="video" style="width:650px;height:840px;visibility:hidden">
	  <video id="my-video" class="video-js vjs-default-skin" controls="controls" preload="auto" title="无人机视频"  width="650px" height="840px"
		  poster="http://video-js.zencoder.com/oceans-clip.png" data-setup="{}">
			<source src="70b4b3719a47aad5bafd0a0f8b433b88.mp4" type="video/mp4">
			<p class="vjs-no-js">
			  To view this video please enable JavaScript, and consider upgrading to a web browser that
			  <a href="http://videojs.com/html5-video-support/" target="_blank">supports HTML5 video</a>
			</p>
		  </video>
		  <script type="text/javascript">
			videojs("my-video").ready(function(){
				var myPlayer = this;
				myPlayer.play();
			});
		</script>
	 </div>
	</td>
	<td>
		<div id="eCharts" style="width:340px;height:840px">
		    <table>  
		       <tr><td><div id="echarts1" style="width:340px;height:270px"></div></td></tr>  
		       <tr><td><div id="echarts2" style="width:340px;height:270px"></div></td></tr>   
		       <tr><td><div id="echarts3" style="width:340px;height:270px"></div></td></tr>   
		   </table> 
		</div>
	</td>
   </tr>
  </table>
 </div>
	
   
<!--    	<div>
	<input name="button1" type="button" value="京藏高速" onclick="goposition(107.405397,40.855578,111.340683,40.745054)"/>
	<input name="button2" type="button" value="京新高速" onclick="goposition(112.147918,40.91459,110.939024,40.672474)"/>
	<input name="button3" type="button" value="兴巴高速" onclick="goposition(111.374612,40.095626,112.191327,40.311541)"/>
	<input name="button4" type="button" value="荣乌高速" onclick="goposition(111.403213,39.816964,111.968356,39.813154)"/>
	<input name="button5" type="button" value="无人机1号" onclick="init()"/>
    </div>
 -->
</body>
</html>

<script type="text/javascript">
    // 百度地图API功能
    function G(id) {
        return document.getElementById(id);
    }

    var map = new BMap.Map("allmap");
    map.enableScrollWheelZoom(true);
    map.centerAndZoom(new BMap.Point(111.755933, 40.848919), 11);                   // 初始化地图,设置城市和地图级别。

	var ctrl = new BMapLib.TrafficControl({
		showPanel: true //是否显示路况提示面板
	});      
	map.addControl(ctrl);
	ctrl.setAnchor(BMAP_ANCHOR_BOTTOM_RIGHT);  
	
	var mapType1 = new BMap.MapTypeControl({mapTypes: [BMAP_NORMAL_MAP,BMAP_HYBRID_MAP]});
	map.addControl(mapType1);          //2D图，卫星图
	
    // 定义一个控件类,即function
    function ZoomControl() {
        this.defaultAnchor = BMAP_ANCHOR_TOP_LEFT;
        this.defaultOffset = new BMap.Size(10, 10);
    }

    // 通过JavaScript的prototype属性继承于BMap.Control
    ZoomControl.prototype = new BMap.Control();

    // 自定义控件必须实现自己的initialize方法,并且将控件的DOM元素返回
    // 在本方法中创建个div元素作为控件的容器,并将其添加到地图容器中
    ZoomControl.prototype.initialize = function(map){
      // 创建一个DOM元素
      var div = document.createElement("div");
      div.innerHTML = '<div id="r-result">搜索地址:<input type="text" id="suggestId" size="20" value="百度" style="width:150px;" /></div><div id="searchResultPanel" style="border:1px solid #C0C0C0;width:150px;height:auto; display:none;"></div>';

      // 添加DOM元素到地图中
      map.getContainer().appendChild(div);
      // 将DOM元素返回
      return div;
    }

    // 创建控件
    var myZoomCtrl = new ZoomControl();
    // 添加到地图当中
    map.addControl(myZoomCtrl);
	
    var ac = new BMap.Autocomplete(    //建立一个自动完成的对象
        {"input" : "suggestId"
        ,"location" : map
    });

    ac.addEventListener("onhighlight", function(e) {  //鼠标放在下拉列表上的事件
    var str = "";
        var _value = e.fromitem.value;
        var value = "";
        if (e.fromitem.index > -1) {
            value = _value.province +  _value.city +  _value.district +  _value.street +  _value.business;
        }
        str = "FromItem<br />index = " + e.fromitem.index + "<br />value = " + value;

        value = "";
        if (e.toitem.index > -1) {
            _value = e.toitem.value;
            value = _value.province +  _value.city +  _value.district +  _value.street +  _value.business;
        }
        str += "<br />ToItem<br />index = " + e.toitem.index + "<br />value = " + value;
        G("searchResultPanel").innerHTML = str;
    });

    var myValue;
    ac.addEventListener("onconfirm", function(e) {    //鼠标点击下拉列表后的事件
    var _value = e.item.value;
        myValue = _value.province +  _value.city +  _value.district +  _value.street +  _value.business;
        G("searchResultPanel").innerHTML ="onconfirm<br />index = " + e.item.index + "<br />myValue = " + myValue;

        setPlace();
    });

    function setPlace(){
        map.clearOverlays();    //清除地图上所有覆盖物
        function myFun(){
            var pp = local.getResults().getPoi(0).point;    //获取第一个智能搜索的结果
            map.centerAndZoom(pp, 14);
            map.addOverlay(new BMap.Marker(pp));    //添加标注
        }
        var local = new BMap.LocalSearch(map, { //智能搜索
          onSearchComplete: myFun
        });
        local.search(myValue);
    }
	
	function goposition(id,x1,y1,x2,y2){
	    map.clearOverlays();//清除图层覆盖物
	    var p1 = new BMap.Point(x1,y1);
	    var p2 = new BMap.Point(x2,y2);
		getUnmans(id);
		var driving = new BMap.DrivingRoute(map, {renderOptions:{map: map, panel : "results", autoViewport: true},
	        onPolylinesSet:function(routes) { 
	            searchRoute = routes[0].getPolyline();//导航路线
	            map.addOverlay(searchRoute); 
	        }, 
	        onMarkersSet:function(routes) {
	            map.removeOverlay(routes[0].marker); //删除起点
	            map.removeOverlay(routes[1].marker);//删除终点
	        }
	        
    });
 
    driving.search(p1, p2);
	}
		
	function deletePoint()
    {      //删除所有图钉函数
        var allOverlay = map.getOverlays();
		for (var i = 0; i < allOverlay.length -1; i++){
				map.clearOverlays();  //清除图钉函数
				return false;
		}		  
    }
    
    var time = ['', '', '', '', '', '', ''];
    var data1 = [0, 0, 0, 0, 0, 0, 0];
    var data2 = [0, 0, 0, 0, 0, 0, 0];
    var data3 = [0, 0, 0, 0, 0, 0, 0];
    time = ['11.10','11.11','11.12','11.13','11.14','11.15','11.16'];
	data1 = [211, 300, 190, 210, 220, 130, 333];
	data2 = [11, 11, 15, 13, 12, 13, 10];
   	data3 = [100, 101, 105, 99, 80, 102, 111]; 
	var option1 = {
	    title : {
	        text: '流量变化情况'
	    },
	    tooltip : {
	        trigger: 'axis'
	    },
	    calculable : true,
	    xAxis : [
	        {
	            type : 'category',
	            boundaryGap : false,
	            data : ['', '', '', '', '', '', '']
	        }
	    ],
	    yAxis : [
	        {
	            type : 'value',
	            axisLabel : {
	                formatter: '{value} V/h'
	            }
	        }
	    ],
	    series : [
	        {
	            name:'流量',
	            type:'line',
	            data:[211, 300, 190, 210, 220, 130, 333],
	            markPoint : {
	                data : [
	                    {type : 'max', name: '最大值'},
	                    {type : 'min', name: '最小值'}
	                ]
	            },
	            markLine : {
	                data : [
	                    {type : 'average', name: '平均值'}
	                ]
	            }
	        }
	    ]
	};
       
	var option2 = {
	    title : {
	        text: '雪阻变化情况'
	    },
	    tooltip : {
	        trigger: 'axis'
	    },
	    calculable : true,
	    xAxis : [
	        {
	            type : 'category',
	            boundaryGap : false,
	            data : ['', '', '', '', '', '', '']
	        }
	    ],
	    yAxis : [
	        {
	            type : 'value',
	            axisLabel : {
	                formatter: '{value} M'
	            }
	        }
	    ],
	    series : [
	        {
	            name:'雪阻',
	            type:'line',
	            data:[211, 300, 190, 210, 220, 130, 333],
	            markPoint : {
	                data : [
	                    {type : 'max', name: '最大值'},
	                    {type : 'min', name: '最小值'}
	                ]
	            },
	            markLine : {
	                data : [
	                    {type : 'average', name: '平均值'}
	                ]
	            }
	        }
	    ]
	};
       
	var option3 = {
	    title : {
	        text: '沙阻变化情况'
	    },
	    tooltip : {
	        trigger: 'axis'
	    },
	    calculable : true,
	    xAxis : [
	        {
	            type : 'category',
	            boundaryGap : false,
	            data : ['', '', '', '', '', '', '']
	        }
	    ],
	    yAxis : [
	        {
	            type : 'value',
	            axisLabel : {
	                formatter: '{value} M^2'
	            }
	        }
	    ],
	    series : [
	        {
	            name:'沙阻',
	            type:'line',
	            data:[211, 300, 190, 210, 220, 130, 333],
	            markPoint : {
	                data : [
	                    {type : 'max', name: '最大值'},
	                    {type : 'min', name: '最小值'}
	                ]
	            },
	            markLine : {
	                data : [
	                    {type : 'average', name: '平均值'}
	                ]
	            }
	        }
	    ]
	};
                   
	var myChart1 = echarts.init(document.getElementById('echarts1')); 
    myChart1.setOption(option1); 
    var myChart2 = echarts.init(document.getElementById('echarts2'));  
    myChart2.setOption(option2); 
    var myChart3 = echarts.init(document.getElementById('echarts3'));  
    myChart3.setOption(option3); 
    setECharts(echarts1);
	setECharts(echarts2);
	setECharts(echarts3);
    function getUnmans(id){
	  $.ajax({
           	 	type: "post", 
               	cache: false, 
             	dataType: 'json',
             	url: '/droneSystem/DroneServlet.do?method=1',
               	data:{Id:id},
            success: function(data){
            
               //map.panTo(new BMap.Point(data.drones[0].longitude, data.drones[0].latitude));
               
			    deletePoint();
				var marker = new Array();
				for(var i=0;i<data.drones.length;i++) { 
				    //var myIcon = new BMap.Icon("../images/drone.png", new BMap.Size(10,10));
			        marker[i]= new BMap.Marker(new BMap.Point(data.drones[i].longitude,data.drones[i].latitude));  // 创建标注点
				 	map.addOverlay(marker[i]); //添加标注
					//var label = new window.BMap.Label(data.drones[i].code, {offset: new window.BMap.Size(20, -10)}); //创建标签   
                    var label = new window.BMap.Label("无人机编号:"+data.drones[i].code,{offset: new window.BMap.Size(20, -10)});  // 创建文本标注对象
		                label.setStyle({
			                  color : "blue",
			                  fontSize : "12px",
			                  //height : "20px",
			                  lineHeight : "20px",
			                  fontFamily:"微软雅黑"
		                 });
		            marker[i].setLabel(label);  //添加标签
                    //var Content = '<div><p style="margin:0;line-height:1.5;font-size:13px;text-indent:2em"><br/>无人机编号：'+data.drones[0].code+'<br/>经度：'+data.drones[0].longitude+'<br/>纬度：'+data.drones[0].latitude+'<br/>速度<br/>点击图标播放视频：</p></div>' 
					//addMouseoverHandler(marker[i], Content);
					marker[i].addEventListener("click", function (){
						if(eCharts.style.visibility="hidden"){
	                   		eCharts.style.visibility="visible";
	                   	}
					  	myvideo = document.getElementById("video");  
	                   	if(myvideo.style.visibility="hidden"){
	                   		myvideo.style.visibility="visible";
	                   	}
	                   	else if(myvideo.style.visibility="visible")
	                   		myvideo.style.visibility="hidden";
	          			});					 					
						
					}	
		}	
		}); 	
    
	}
	
   function init() {	
  		getUnmans();
		setInterval("getUnmans()",60000) ;//设定每一分钟刷新一次
	} 

  
			
	

	

	
</script>


