<%@ page contentType="text/html; charset=gbk" language="java" import="com.droneSystem.hibernate.*,com.droneSystem.util.*" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link type="text/css" rel="stylesheet" href="../css/systemPu.css" />
<link href="http://api.map.baidu.com/library/TrafficControl/1.4/src/TrafficControl_min.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="http://api.map.baidu.com/api?v=2.0&ak=jwTcIoGGL3WahiyCb2Hg7juZi1TGym0Y" charset="utf-8"></script>
<script type="text/javascript" src="http://api.map.baidu.com/library/TrafficControl/1.4/src/TrafficControl_min.js" charset="utf-8"></script>
<link rel="stylesheet" type="text/css" href="../Inc/Style/themes/default/easyui.css" />
<link rel="stylesheet" type="text/css" href="../Inc/Style/Style.css" />
<link rel="stylesheet" type="text/css" href="../Inc/Style/video-js.css" >
<script type="text/javascript" src="../Inc/JScript/jquery-1.6.min.js"></script>
<script type="text/javascript" src="../Inc/JScript/jquery.easyui.min.js"></script>
<script type="text/javascript" src="../Inc/JScript/locale/easyui-lang-zh_CN.js" charset="utf-8"></script>
<script type="text/javascript" src="../JScript/upload.js"></script>
<script type="text/javascript" src="../JScript/admin.js"></script>
<script type="text/javascript" src="../JScript/map.js"></script>
<script type="text/javascript" src="../JScript/chart1.js"></script>
<script type="text/javascript" src="../JScript/chart2.js"></script>
<script type="text/javascript" src="../JScript/json2.js"></script>
<script type="text/javascript" src="http://vjs.zencdn.net/5.18.4/video.min.js"></script>
<title>内蒙古无人机项目管理系统-雪阻</title>
</head>
<body>
<script type="text/javascript" src="../Inc/JScript/echarts.min.js" charset="UTF-8"></script>
<script type="text/javascript" src="../Inc/JScript/blue.js" charset="UTF-8"></script>

	<div class="head_area">
		<div class="fleft"><img src="../images/logo.png" /></div>
		<div class="head_left">
		<ul>
			<li><a href="Main.jsp">流量信息</a></li>
			<li><a href="Snow.jsp"  class="pagenow">雪阻信息</a></li>
			<li><a href="Sand.jsp">沙阻信息</a></li>
			<li><a href="javascript:void(0)" onclick="ale()">红外信息</a></li>
			<li><a href="javascript:void(0)" onclick="ale()">查询统计</a></li>
		</ul>
		</div>
		<div class="fright">
		 <a id="drop_down" href="javascript:void(0)">admin<img src="../images/down_sanjiao.png" /></a><a id="logout" href="javascript:void(0)" onclick="doLogout()"><img src="../images/lines10.png" />退出</a>
		 <div class="js_list001" id="drop_list">
			<p id="p1"><a href="#">用户列表</a></p>
			<p id="p2"><a href="#">角色列表</a></p>
			<p id="p3"><a href="#">权限列表</a></p>
		</div> 
		</div>
	</div>
	<div class="myclear"></div>
	
	<p class="h128box"><button>应急响应资源配置方案</button></p>
	
	<div class="fleft maparea">
		<h5 class="title_sample"><span>雪阻地图</span></h5>
		<div id="allmap" style="width: 2021px; height: 1410px">
		</div>
	</div>
	
	<div class="fleft videoarea">
		<h5 class="title_sample"><span>雪阻视频</span></h5>
		<div id="video" style="width:2500px;height:1410px">
<!--			<video id="my-video" class="video-js vjs-default-skin" controls="controls" preload="auto" title="无人机视频"  width="2500px" height="1410px"
			poster="http://video-js.zencoder.com/oceans-clip.png" data-setup="{}">
			<source src="../Inc/MOV_0030.MOV" type="video/mp4">
				 <source src="rtmp://live.hkstv.hk.lxdns.com/live/hks" type="rtmp/flv">
				<p class="vjs-no-js">
					To view this video please enable JavaScript, and consider upgrading to a web browser that
				<a href="http://videojs.com/html5-video-support/" target="_blank">supports HTML5 video</a>
				</p>
			</video>
			-->
		<object type='application/x-vlc-plugin' id='vlc' events='True' width="2500px" height="1410px" pluginspage="http://www.videolan.org" codebase="http://downloads.videolan.org/pub/videolan/vlc-webplugins/2.0.6/npapi-vlc-2.0.6.tar.xz">
        <param name='mrl' value='../Inc/XZ.mp4' />
        <param name='volume' value='50' />
        <param name='autoplay' value='true' />
        <param name='loop' value='false' />
        <param name='fullscreen' value='false' />
    </object>
		</div>
	</div>
	
	<div class="fleft timesarea">
		<h5 class="title_sample"><span>实时雪阻变化情况</span></h5>
		<div id="echarts1" style="width:960px;height:616px"></div>
	</div>
	<div class="fleft montharea">
		<h5 class="title_sample"><span>当前雪阻量总和</span></h5>
		<div id="echarts2" style="width:960px;height:616px"></div>
	</div>
	<div class="myclear"></div>
	<div class="overlay"></div>
	
	<!--弹框001-->
	<div class="userlist">
		<h5 class="title_sample"><span>用户列表</span><a id="userlist_close" href="javascript:void(0)" onclick="closeUserlist()"><img src="../images/cross.png" /></a></h5>
		<div class="fleft sousuolf"><a href="#"><img src="../images/addperson.png" /></a><a href="#"><img src="../images/delectperson.png" /></a></div>
		<div class="fright sousuort"><input type="text" /><button><img src="../images/searchicon.png" /></button></div>
		<div class="myclear"></div> 
		<!-------每页112条数据-------->
		<table width="100%" border="0" cellpadding="0" cellspacing="0" class="person_name">
		  <tr>
			<th scope="col" width="140">&nbsp;</th>
			<th scope="col">ID</th>
			<th scope="col">用户名</th>
			<th scope="col">真实姓名</th>
			<th scope="col">部门</th>
			<th scope="col">角色</th>
			<th scope="col">账号状态</th>
			<th scope="col">注册时间</th>
			<th scope="col">操作选择</th>
		  </tr>
		  <tr>
			<td><input type="checkbox" /></td>
			<td>17001</td>
			<td>33dfadsfd</td>
			<td>张天翼</td>
			<td>审计部门</td>
			<td>普通管理员</td>
			<td>可用</td>
			<td>2017-05-22</td>
			<td><a href="#">编辑</a><a href="#">删除</a></td>
		  </tr>
		   <tr>
			<td><input type="checkbox" /></td>
			<td>17001</td>
			<td>33dfadsfd</td>
			<td>张天翼</td>
			<td>审计部门</td>
			<td>普通管理员</td>
			<td>可用</td>
			<td>2017-05-22</td>
			<td><a href="#">编辑</a><a href="#">删除</a></td>
		  </tr>
		   <tr>
			<td><input type="checkbox" /></td>
			<td>17001</td>
			<td>33dfadsfd</td>
			<td>张天翼</td>
			<td>审计部门</td>
			<td>普通管理员</td>
			<td>可用</td>
			<td>2017-05-22</td>
			<td><a href="#">编辑</a><a href="#">删除</a></td>
		  </tr>
		   <tr>
			<td><input type="checkbox" /></td>
			<td>17001</td>
			<td>33dfadsfd</td>
			<td>张天翼</td>
			<td>审计部门</td>
			<td>普通管理员</td>
			<td>可用</td>
			<td>2017-05-22</td>
			<td><a href="#">编辑</a><a href="#">删除</a></td>
		  </tr>
		   <tr>
			<td><input type="checkbox" /></td>
			<td>17001</td>
			<td>33dfadsfd</td>
			<td>张天翼</td>
			<td>审计部门</td>
			<td>普通管理员</td>
			<td>可用</td>
			<td>2017-05-22</td>
			<td><a href="#">编辑</a><a href="#">删除</a></td>
		  </tr>
		   <tr>
			<td><input type="checkbox" /></td>
			<td>17001</td>
			<td>33dfadsfd</td>
			<td>张天翼</td>
			<td>审计部门</td>
			<td>普通管理员</td>
			<td>可用</td>
			<td>2017-05-22</td>
			<td><a href="#">编辑</a><a href="#">删除</a></td>
		  </tr>
		   <tr>
			<td><input type="checkbox" /></td>
			<td>17001</td>
			<td>33dfadsfd</td>
			<td>张天翼</td>
			<td>审计部门</td>
			<td>普通管理员</td>
			<td>可用</td>
			<td>2017-05-22</td>
			<td><a href="#">编辑</a><a href="#">删除</a></td>
		  </tr>
		   <tr>
			<td><input type="checkbox" /></td>
			<td>17001</td>
			<td>33dfadsfd</td>
			<td>张天翼</td>
			<td>审计部门</td>
			<td>普通管理员</td>
			<td>可用</td>
			<td>2017-05-22</td>
			<td><a href="#">编辑</a><a href="#">删除</a></td>
		  </tr>
		   <tr>
			<td><input type="checkbox" /></td>
			<td>17001</td>
			<td>33dfadsfd</td>
			<td>张天翼</td>
			<td>审计部门</td>
			<td>普通管理员</td>
			<td>可用</td>
			<td>2017-05-22</td>
			<td><a href="#">编辑</a><a href="#">删除</a></td>
		  </tr>
		   <tr>
			<td><input type="checkbox" /></td>
			<td>17001</td>
			<td>33dfadsfd</td>
			<td>张天翼</td>
			<td>审计部门</td>
			<td>普通管理员</td>
			<td>可用</td>
			<td>2017-05-22</td>
			<td><a href="#">编辑</a><a href="#">删除</a></td>
		  </tr>
		   <tr>
			<td><input type="checkbox" /></td>
			<td>17001</td>
			<td>33dfadsfd</td>
			<td>张天翼</td>
			<td>审计部门</td>
			<td>普通管理员</td>
			<td>可用</td>
			<td>2017-05-22</td>
			<td><a href="#">编辑</a><a href="#">删除</a></td>
		  </tr>
		</table>
		<p class="endpages"><a href="#">1</a><a href="#">2</a><a href="#">3</a><a href="#">4</a><a href="#">...</a><a href="#">49</a><a href="#">下一页</a><span>到第<input type="text" />页<button>确定</button></span></p>
	</div> 
	<!--弹框001结束-->
	<!--弹框002-->
	<div class="userlist" id="rolelist">
		<h5 class="title_sample"><span>角色列表</span><a href="#"><img src="../images/cross.png" /></a></h5>
		<div class="fleft sousuolf"><a href="#"><img src="../images/addperson.png" /></a><a href="#"><img src="../images/delectperson.png" /></a></div>
		<div class="myclear"></div>
		<!-------由于权限描述字数不定，所以没办法确定放多少条目，开发自己斟酌-------->
		<table width="100%" border="0" cellpadding="0" cellspacing="0" class="person_name">
		  <tr>
			<th scope="col" width="140">&nbsp;</th>
			<th scope="col">ID</th>
			<th scope="col">角色名称</th>
			<th scope="col">基本权限</th>
			<th scope="col" width="30%">操作权限</th>
			<th scope="col">创建时间</th>
			<th scope="col">操作选择</th>
		  </tr>
		  <tr>
			<td><input type="checkbox" /></td>
			<td>17001</td>
			<td>超级管理员</td>
			<td>查看所有页面</td>
			<td>编辑、发布、预览、删除、保存、推送、还原、添加人员、添加角色、添加权限</td>
			<td>2017-08-19</td>
			<td><a href="#">编辑</a><a href="#">删除</a></td>
		  </tr>
		  <tr>
			<td><input type="checkbox" /></td>
			<td>17001</td>
			<td>超级管理员</td>
			<td>查看所有页面</td>
			<td>编辑、发布、预览、删除、保存、推送、还原、添加人员、添加角色、添加权限</td>
			<td>2017-08-19</td>
			<td><a href="#">编辑</a><a href="#">删除</a></td>
		  </tr>
		  <tr>
			<td><input type="checkbox" /></td>
			<td>17001</td>
			<td>超级管理员</td>
			<td>查看所有页面</td>
			<td>编辑、发布、预览、删除、保存、推送、还原、添加人员、添加角色、添加权限</td>
			<td>2017-08-19</td>
			<td><a href="#">编辑</a><a href="#">删除</a></td>
		  </tr>
		  <tr>
			<td><input type="checkbox" /></td>
			<td>17001</td>
			<td>超级管理员</td>
			<td>查看所有页面</td>
			<td>编辑、发布、预览、删除、保存、推送、还原、添加人员、添加角色、添加权限</td>
			<td>2017-08-19</td>
			<td><a href="#">编辑</a><a href="#">删除</a></td>
		  </tr>
		  <tr>
			<td><input type="checkbox" /></td>
			<td>17001</td>
			<td>超级管理员</td>
			<td>查看所有页面</td>
			<td>编辑、发布、预览、删除、保存、推送、还原、添加人员、添加角色、添加权限</td>
			<td>2017-08-19</td>
			<td><a href="#">编辑</a><a href="#">删除</a></td>
		  </tr>
		  <tr>
			<td><input type="checkbox" /></td>
			<td>17001</td>
			<td>超级管理员</td>
			<td>查看所有页面</td>
			<td>编辑、发布、预览、删除、保存、推送、还原、添加人员、添加角色、添加权限</td>
			<td>2017-08-19</td>
			<td><a href="#">编辑</a><a href="#">删除</a></td>
		  </tr>
		  <tr>
			<td><input type="checkbox" /></td>
			<td>17001</td>
			<td>超级管理员</td>
			<td>查看所有页面</td>
			<td>编辑、发布、预览、添加权限</td>
			<td>2017-08-19</td>
			<td><a href="#">编辑</a><a href="#">删除</a></td>
		  </tr>
		  <tr>
			<td><input type="checkbox" /></td>
			<td>17001</td>
			<td>超级管理员</td>
			<td>查看所有页面</td>
			<td>编辑、发布、预览、删除、添加权限</td>
			<td>2017-08-19</td>
			<td><a href="#">编辑</a><a href="#">删除</a></td>
		  </tr>
		 </table>
		<p class="endpages"><a href="#">1</a><a href="#">2</a><a href="#">3</a><a href="#">4</a><a href="#">...</a><a href="#">49</a><a href="#">下一页</a><span>到第<input type="text" />页<button>确定</button></span></p>
	</div>
	<!--弹框002结束-->
	<!--弹框003-->
	<div class="userlist" id="privilegelist">
		<h5 class="title_sample"><span>权限列表</span><a href="#"><img src="../images/cross.png" /></a></h5>
		<div class="fleft sousuolf"><a href="#"><img src="../images/addperson.png" /></a><a href="#"><img src="../images/delectperson.png" /></a></div>
		<div class="fright sousuort"><input type="text" /><button><img src="../images/searchicon.png" /></button></div>
		<div class="myclear"></div>
		<!-------由于权限描述字数不定，所以没办法确定放多少条目，开发自己斟酌-------->
		<table width="100%" border="0" cellpadding="0" cellspacing="0" class="person_name">
		  <tr>
			<th scope="col" width="140">&nbsp;</th>
			<th scope="col">ID</th>
			<th scope="col">权限名称</th>
			<th scope="col">性质</th>
			<th scope="col" width="30%">权限描述</th>
			<th scope="col">创建时间</th>
			<th scope="col">操作选择</th>
		  </tr>
		  <tr>
			<td><input type="checkbox" /></td>
			<td>17001</td>
			<td>查看数据</td>
			<td>基本权限</td>
			<td>权限描述性文字权限描述性权限描述性文字权限描述性文字权限描述性文字权限描述性文字</td>
			<td>2017-08-19</td>
			<td><a href="#">编辑</a><a href="#">删除</a></td>
		  </tr>
		  <tr>
			<td><input type="checkbox" /></td>
			<td>17001</td>
			<td>查看数据</td>
			<td>基本权限</td>
			<td>权限描述性文字权限描述性文字权限描述性文字权限描述性文字权限描字权限描述性文字权限描述性文字权限描述性文字权限描述性文字权限描述性文字</td>
			<td>2017-08-19</td>
			<td><a href="#">编辑</a><a href="#">删除</a></td>
		  </tr>
		  <tr>
			<td><input type="checkbox" /></td>
			<td>17001</td>
			<td>查看数据</td>
			<td>基本权限</td>
			<td>权限描述性文字权限文字权限描述性文字权限描述性文字权限描述性文字权限描述性文字</td>
			<td>2017-08-19</td>
			<td><a href="#">编辑</a><a href="#">删除</a></td>
		  </tr>
		  <tr>
			<td><input type="checkbox" /></td>
			<td>17001</td>
			<td>查看数据</td>
			<td>基本权限</td>
			<td>权限描述性文字权限描述性文字权限描述性文字权限描述性文字权限描述性文字权限描述性文字权限描述性文字权限描述性文字权限描述性文字权限描述性文字</td>
			<td>2017-08-19</td>
			<td><a href="#">编辑</a><a href="#">删除</a></td>
		  </tr>
		  <tr>
			<td><input type="checkbox" /></td>
			<td>17001</td>
			<td>查看数据</td>
			<td>基本权限</td>
			<td>权限描述性文字权限描述性文字权限描述性文字权限描述性文字权限描述性文字权限描述性文字权限描述性文字权限描述性文字权限描述性文字权限描述性文字</td>
			<td>2017-08-19</td>
			<td><a href="#">编辑</a><a href="#">删除</a></td>
		  </tr>
		 </table>
		<p class="endpages"><a href="#">1</a><a href="#">2</a><a href="#">3</a><a href="#">4</a><a href="#">...</a><a href="#">49</a><a href="#">下一页</a><span>到第<input type="text" />页<button>确定</button></span></p>
	</div>
	<!--弹框003结束-->
</body>
</html>	

<script type="text/javascript">
    // 百度地图API功能
    var map = new BMap.Map("allmap");
    var timer=1;
	var videoId = 0;
	var axisData;
	var lastData = 0;
	clearInterval(app);
	var app = {};
	var opts = {
		width : 0,     // 信息窗口宽度
		height: 0,     // 信息窗口高度
		title : "<span style='font-size:20px;color:#0099cc;background-color:#FFFFFF'>"+"雪阻信息窗口"+"</span>" , // 信息窗口标题
		enableMessage:true//设置允许信息窗发送短息
	    };    
	getUnmans();
	setInterval("getUnmans()",60000) ;//设定每一分钟刷新一次
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
			                  fontSize : "20px",
			                  backgroundColor :"0.05",
			                  border:"0",			                  
			                  lineHeight : "20px",
			                  fontWeight :"bold" //字体加粗
		                 });
		            marker.setLabel(label);  //添加标签
		            
		            (function(){
			            var thepoint = data.drones[i]; 
			            marker.addEventListener("click", function (){
			            //map.panTo(point);		            
						showInfo(this, thepoint);//开启信息窗口
						test();
						videojs("my-video").ready(function(){
							var myPlayer = this;
							myPlayer.play();
						});
						getEcharts();
			            });
		            })();		            		           		
				}	
		}	
		}); 	
    
	}
	
	
	
	 function showInfo(thisMarker,point){
         //thisMarker.setAnimation(BMAP_ANIMATION_BOUNCE);
         var content = 
		"<p style='margin:0;line-height:1.5;font-size:20px;text-indent:0em'>无人机编号： "+point.code+"<br/>经度："+point.longitude+" 纬度："+point.latitude+"</br>雪阻预警等级： 2</br>状态： 0</p>";
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
		          //lastData = Math.round(Math.random() * 1000);
		        
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
     
	 function test(){
	  $.ajax({
       	 	type: "post", 
           	cache: false, 
           	dataType: 'json',
           	url: '/droneSystem/DroneServlet.do?method=3',
           	data:{type:1,inputStream:"D:\\test\\XZ.mp4"},
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
             	data:{type:1},
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
			data:{type:1,videoId:videoId},
			success: function(data){
			//alert(videoId);
            //alert(videoId + data.ts);
			}	
		}); 	
	    
	}


</script>

