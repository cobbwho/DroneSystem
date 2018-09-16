<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>

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
    <script type="text/javascript" src="http://api.map.baidu.com/api?v=2.0&ak=jwTcIoGGL3WahiyCb2Hg7juZi1TGym0Y" charset="utf-8"></script>
	<script type="text/javascript" src="http://api.map.baidu.com/library/TrafficControl/1.4/src/TrafficControl_min.js" charset="utf-8"></script>
	<link rel="stylesheet" type="text/css" href="../Inc/Style/themes/default/easyui.css" />
    <link rel="stylesheet" type="text/css" href="../Inc/Style/themes/icon.css" />
	<link rel="stylesheet" type="text/css" href="../Inc/Style/themes/icon2.css" />
    <link rel="stylesheet" type="text/css" href="../Inc/Style/Style.css" />
    <link rel="stylesheet" type="text/css" href="../Inc/Style/video-js.css" >
	
    <script type="text/javascript" src="../Inc/JScript/jquery-1.6.min.js"></script>
    <script type="text/javascript" src="../Inc/JScript/jquery.easyui.min.js"></script>
    <script type="text/javascript" src="../Inc/JScript/locale/easyui-lang-zh_CN.js" charset="utf-8"></script>
	<script type="text/javascript" src="../JScript/upload.js"></script>
	<script src="http://echarts.baidu.com/build/dist/echarts-all.js" charset="UTF-8"></script>
    <script type="text/javascript" src="../JScript/json2.js"></script>
    <script type="text/javascript" src="http://vjs.zencdn.net/5.18.4/video.min.js"></script>
    <title>流量信息</title>
</head>
<body>
	<div style="width:2150px; height:650px;">
    <table border="0" cellpadding="0" cellspacing="0" width="100%">
    <tr>
    <td>
	 <div id="allmap"  style="width: 650px; height: 650px"></div>
	</td>
	<td>
	 <div id="video" style="width:650px;height:650px">
	  <video id="my-video" class="video-js vjs-default-skin" controls="controls" preload="auto" title="无人机视频"  width="650px" height="650px"
		  poster="http://video-js.zencoder.com/oceans-clip.png" data-setup="{}">
		 <source src="../Inc/test.mp4" type="video/mp4">
				<!-- <source src="rtmp://live.hkstv.hk.lxdns.com/live/hks" type="rtmp/flv">-->
			<p class="vjs-no-js">
			  To view this video please enable JavaScript, and consider upgrading to a web browser that
			  <a href="http://videojs.com/html5-video-support/" target="_blank">supports HTML5 video</a>
			</p>
		  </video>
		 

<!-- 	<object type='application/x-vlc-plugin' id='vlc' events='True' width="650" height="650" pluginspage="http://www.videolan.org" codebase="http://downloads.videolan.org/pub/videolan/vlc-webplugins/2.0.6/npapi-vlc-2.0.6.tar.xz">
        <param name='mrl' value='rtsp://localhost:8554/123' />
        <param name='volume' value='50' />
        <param name='autoplay' value='true' />
        <param name='loop' value='false' />
        <param name='fullscreen' value='false' />
    </object>
 -->
	 </div>
	</td>
	<td>
		<div id="eCharts" style="width:850px;height:650px;" >
		    <table>  
		       <tr><td><div id="echarts1" style="width:850px;height:650px"></div></td></tr>   
		   </table> 
		</div>
	</td>
   </tr>
  </table>
 </div>
</body>
</html>

<script type="text/javascript">
    // 百度地图API功能
    function G(id) {
        return document.getElementById(id);
    }
    var timer=1;
	var videoId = 0;
	init();
    var map = new BMap.Map("allmap");
   map.setMapStyle({
    styleJson:[
          {
                    "featureType": "land",
                    "elementType": "geometry",
                    "stylers": {
                              "color": "#e7f7fc"
                    }
          },
          {
                    "featureType": "water",
                    "elementType": "all",
                    "stylers": {
                              "color": "#96b5d6"
                    }
          },
          {
                    "featureType": "green",
                    "elementType": "all",
                    "stylers": {
                              "color": "#b0d3dd"
                    }
          },
          {
                    "featureType": "highway",
                    "elementType": "geometry.fill",
                    "stylers": {
                              "color": "#a6cfcf"
                    }
          },
          {
                    "featureType": "highway",
                    "elementType": "geometry.stroke",
                    "stylers": {
                              "color": "#7dabb3"
                    }
          },
          {
                    "featureType": "arterial",
                    "elementType": "geometry.fill",
                    "stylers": {
                              "color": "#e7f7fc"
                    }
          },
          {
                    "featureType": "arterial",
                    "elementType": "geometry.stroke",
                    "stylers": {
                              "color": "#b0d5d4"
                    }
          },
          {
                    "featureType": "local",
                    "elementType": "labels.text.fill",
                    "stylers": {
                              "color": "#7a959a"
                    }
          },
          {
                    "featureType": "local",
                    "elementType": "labels.text.stroke",
                    "stylers": {
                              "color": "#d6e4e5"
                    }
          },
          {
                    "featureType": "arterial",
                    "elementType": "labels.text.fill",
                    "stylers": {
                              "color": "#374a46"
                    }
          },
          {
                    "featureType": "highway",
                    "elementType": "labels.text.fill",
                    "stylers": {
                              "color": "#374a46"
                    }
          },
          {
                    "featureType": "highway",
                    "elementType": "labels.text.stroke",
                    "stylers": {
                              "color": "#e9eeed"
                    }
          }
     ]
    });
    map.enableScrollWheelZoom(true);
    map.centerAndZoom(new BMap.Point(111.755933, 40.848919), 11);                   // 初始化地图,设置城市和地图级别。

	var ctrl = new BMapLib.TrafficControl({
		showPanel: true //是否显示路况提示面板
	});      
	
	map.addControl(ctrl);
	ctrl.setAnchor(BMAP_ANCHOR_BOTTOM_RIGHT);  
	ctrl.showTraffic({ predictDate: { hour: 15, weekday: 5 } });
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
    
var myChart = echarts.init(document.getElementById('echarts1'));
var now = new Date();
var len = 10;
var res = [];
while (len--) {
res.unshift(now.toLocaleTimeString().replace(/^\D*/,''));
    now = new Date(now - 2000);
}
var res1 = [];
var res2 = [];
var len = 10;
while (len--) {
  res1.push(0);
  
}
var xAxisData = res; //x轴数据
var yAxisData = res1; //y轴数据

// 指定图表的配置项和数据
var option = {
title : {
    text: '流量变化情况'
},
tooltip : {
        trigger: 'axis'
    },
    legend: {
        data:['车流量']
    },
    toolbox: {
        show : true,
        feature : {
            dataView : {show: true, readOnly: false},
            magicType : {show: true, type: ['line', 'bar']},
            restore : {show: true},
            saveAsImage : {show: true}
        }
    },
    dataZoom : {
        show : false,
        start : 0,
        end : 100
    },
    xAxis : [
        {
            type : 'category',
            boundaryGap : true,
            data:xAxisData
        }
   ],
   yAxis : [
      {
           type : 'value',
           scale: true,
           name : '车流量V/h',
           boundaryGap: [0.2, 0.2]
      }
  ],
  series : [
       {
            name:'车流量',
            type:'line',
            lineStyle: {
            normal: {
              //color: '#4F2F4F',
              width: 2
              //type: solid
            },
            },
            data:yAxisData,
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

var axisData;
var lastData = 0;
clearInterval(app);
var app = {};

myChart.setOption(option);
var opts = {
				width : 0,     // 信息窗口宽度
				height: 0,     // 信息窗口高度
				title : "<span style='font-size:15px;color:#0099cc;background-color:#FFFFFF'>"+"流量信息窗口"+"</span>" , // 信息窗口标题
				enableMessage:true//设置允许信息窗发送短息
			   };   
   
    function getUnmans(id){
	  $.ajax({
           	 	type: "post", 
               	cache: false, 
             	dataType: 'json',
             	url: '/droneSystem/DroneServlet.do?method=0',
               	data:{Id:id},
            success: function(data){
            
               //map.panTo(new BMap.Point(data.drones[0].longitude, data.drones[0].latitude));
               
			   // deletePoint();
				

				for(var i=0;i<data.drones.length;i++) { 
				    //var myIcon = new BMap.Icon("../images/drone.png", new BMap.Size(10,10));
				    //alert(i);
				    var icon = new BMap.Icon('..//images//camera.png', new BMap.Size(100, 100),{
				   
				    anchor:new BMap.Size(0,0),
                    imageOffset:new BMap.Size(0,0)});
                    icon.setImageSize(new BMap.Size(24, 24));
			        var point = new BMap.Point(data.drones[i].longitude,data.drones[i].latitude);  
			        var marker = new BMap.Marker(point,{ // 创建标注点
							icon: icon
							});		
				 	map.addOverlay(marker); //添加标注
					//var label = new window.BMap.Label(data.drones[i].code, {offset: new window.BMap.Size(20, -10)}); //创建标签   
                    var label = new window.BMap.Label("无人机编号:"+data.drones[i].code,{offset: new window.BMap.Size(20, -10)});  // 创建文本标注对象
		                label.setStyle({
			                  color : "#0099cc",
			                  fontSize : "14px",
			                  backgroundColor :"0.05",
			                  border:"0",			                  
			                  lineHeight : "20px",
			                  //fontWeight :"bold" //字体加粗
		                 });
		            marker.setLabel(label);  //添加标签
		            (function(){
		            var thepoint = data.drones[i];
		            marker.addEventListener("click", function (){
		            
		            map.panTo(point);
		            
					showInfo(this, thepoint);//开启信息窗口
					test();
					videojs("my-video").ready(function(){
						var myPlayer = this;
						myPlayer.play();
					});
					getEcharts();
		            });
		            })();
		            
		            function showInfo(thisMarker,point){
		             //thisMarker.setAnimation(BMAP_ANIMATION_BOUNCE);
		             var content = 
					"<p style='margin:0;line-height:1.5;font-size:13px;text-indent:0em'>无人机编号： "+point.code+"<br/>经度："+point.longitude+" 纬度："+point.latitude+"</br>雪阻预警等级： 2</br>状态： 0</p>";
					 var infoWindow = new BMap.InfoWindow(content, opts);
					 thisMarker.openInfoWindow(infoWindow);
		            }
		            
		            function getEcharts(){
		            app.timeTicket = setInterval(function (){
							  var url = '/droneSystem/DroneServlet.do?method=6';
							  var paramData={type:1};
							  $.ajax({
							      url: url,
							      type: 'post',
							      data: paramData,
							      dataType: 'json',
							      cache: false,
							      error:function(){
							          console.log("get redis error!!!");
							      },
							      success: function(data){
							          if(data != null){
							          //alert(data.ts);
							          axisData = (new Date()).toLocaleTimeString().replace(/^\D*/, '');
							          lastData = data.ts;
							         // lastData = Math.round(Math.random() * 1000);
							        
							          }
							      }
							  }); 
							    // 动态数据接口 addData
							    myChart.addData([
							        [
							            0,        // 系列索引
							            lastData, // 新增数据
							            false,     // 新增数据是否从队列头部插入
							            false,    // 是否增加队列长度，false则自定删除原有数据，队头插入删队尾，队尾插入删队头
							            axisData //横轴数据
							        ]
							       
							    ]);
							}, 2000);
		               }		
					}	
		}	
		}); 	
    
	}
	
	
	 function test(){
	  $.ajax({
       	 	type: "post", 
           	cache: false, 
           	dataType: 'json',
           	url: '/droneSystem/DroneServlet.do?method=3',
           	data:{type:3,inputStream:"D:\\test\\LL.mp4"},
            success: function(data){
            //alert(321);
         		videoId = data.videoId;
			}	
		}); 	
    
	}
	
	function test1(){
		  $.ajax({
           	 	type: "post", 
               	cache: false, 
             	dataType: 'json',
             	url: '/droneSystem/DroneServlet.do?method=5',
             	data:{type:3},
            	success: function(data){
            		//alert(data.ts);
					timer ++;
//         			alert(data.Scale);
				}	
			}); 	
	    
		}

		function test2(){
		  $.ajax({
           	 	type: "post", 
               	cache: false, 
             	dataType: 'json',
             	url: '/droneSystem/DroneServlet.do?method=6',
             	data:{type:3,videoId:videoId},
            	success: function(data){
            	//alert(videoId);
 //           		alert(videoId + data.ts);
				}	
			}); 	
	    
	}
   function init() {	
  		getUnmans();
		setInterval("getUnmans()",60000) ;//设定每一分钟刷新一次
	} 

  	
			
	

	

	
</script>


