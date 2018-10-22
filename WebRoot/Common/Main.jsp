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
<link rel="stylesheet" type="text/css" href="../Inc/Style/video-js.css" />
<script type="text/javascript" src="../Inc/JScript/jquery-1.6.min.js"></script>
<script type="text/javascript" src="../Inc/JScript/jquery.easyui.min.js"></script>
<script type="text/javascript" src="../Inc/JScript/locale/easyui-lang-zh_CN.js" charset="utf-8"></script>
<script type="text/javascript" src="../JScript/upload.js"></script>
<script type="text/javascript" src="../JScript/admin.js"></script>
<script type="text/javascript" src="../JScript/map.js"></script>
<!-- <script type="text/javascript" src="../JScript/chart1.js"></script> -->
<!-- <script type="text/javascript" src="../JScript/chart2.js"></script> -->
<script type="text/javascript" src="../JScript/json2.js"></script>
<script type="text/javascript" src="http://vjs.zencdn.net/5.18.4/video.min.js"></script>
<title>内蒙古无人机项目管理系统-车流量</title>
</head>
<body>
<script type="text/javascript" src="../Inc/JScript/echarts.min.js" charset="UTF-8"></script>
<script type="text/javascript" src="../Inc/JScript/blue.js" charset="UTF-8"></script>

	<div class="head_area">
		<div class="fleft"><img src="../images/logo.png" /></div>
		<div class="head_left">
		<ul>
			<li><a href="Main.jsp" class="pagenow">流量信息</a></li>
			<li><a href="Snow.jsp">雪阻信息</a></li>
			<li><a href="Sand.jsp">沙阻信息</a></li>
			<li><a href="javascript:void(0)" onclick="ale()">红外信息</a></li>
			<li><a href="Inquiry.jsp">查询统计</a></li>
		</ul>
		</div>
		<div class="fright">
		 <a id="drop_down" href="javascript:void(0)" style="margin-right:29px">admin<img src="../images/down_sanjiao.png" /></a><a id="logout" href="javascript:void(0)" onclick="doLogout()" style="margin-left:0px"><img src="../images/lines10.png" />退出</a>
		 <div class="js_list001" id="drop_list">
			<p id="p1"><a href="#">用户列表</a></p>
			<p id="p2"><a href="#">角色列表</a></p>
			<p id="p3"><a href="#">权限列表</a></p>
		</div> 
		</div>
	</div>
	<div class="myclear"></div>
	
	<p class="h128box"></p>
	
	<div class="fleft maparea">
		<h5 class="title_sample"><span>车流量地图</span></h5>
		<div id="allmap" style="width: 2021px; height: 1410px">
		</div>
	</div>
	
	<div class="fleft videoarea">
		<h5 class="title_sample"><span>车流量视频</span></h5>
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
<!-- <param name='mrl' value='../Inc/MOV_0030.MOV' /> -->        
		<param name='mrl' value='rtsp://47.94.19.230:10554/gzrtsp.sdp' />
        <param name='volume' value='50' />
        <param name='autoplay' value='false' />
        <param name='loop' value='false' />
        <param name='fullscreen' value='false' />
    </object>
		</div>
	</div>
	
	<div class="fleft timesarea">
		<h5 class="title_sample"><span>实时车流量变化情况</span></h5>
		<div id="echarts1" style="width:960px;height:616px"></div>
	</div>
	<div class="fleft montharea">
		<h5 class="title_sample"><span>每分钟车流量变化情况</span></h5>
		<div id="echarts2" style="width:960px;height:616px"></div>
	</div>
	<div class="myclear"></div>
	<div class="overlay"></div>
	<!--弹框001-->
	<div class="userlist" id="userlist">
		<h5 class="title_sample"><span>用户列表</span><a id="userlist_close" href="#" ><img src="../images/cross.png" /></a></h5>
		<div class="fleft sousuolf"><a href='javascript:$("#new_user").css("display","block");$("#submit_btn").attr("value","1");'><img src="../images/addperson.png" /></a></div>
		<div class="fright sousuort"><input type="text" /><button><img src="../images/searchicon.png" /></button></div>
		<div class="myclear"></div> 
		<table id="usertable" width="100%" border="0" cellpadding="0" cellspacing="0" class="person_name">
		</table>
		<p class="endpages" id="user"></p>
	</div> 
	<div id="new_user" style="position:absolute; z-index:101; left:2750px; top:500px; width:1250px; height:900px;display:none; background:url(../images/personbg.png) repeat-x top">
		<h5 class="title_sample"><span>添加用户</span><a id="userlist_close" href="#" ><img src="../images/cross.png" /></a></h5>
		<form id="new_user_form" style="padding:10px 20px 10px 40px;margin-left:50px;margin-top:30px" method="post">
			<tr style="width:1000px;margin-left:auto;margin-right:auto;"><td>姓&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;名 : </td><td><input type="text" name="Name" class="easyui-validatebox" required="true" style="width:70%;margin:25px;padding:10px 15px 10px 15px"></td></tr>
			<tr style="width:1000px;margin-left:auto;margin-right:auto;"><td>用&nbsp;&nbsp;&nbsp;户&nbsp;&nbsp;&nbsp;名 : </td><td><input type="text" name="userName" class="easyui-validatebox" required="true" style="width:70%;margin:25px;padding:10px 15px 10px 15px"></td></tr>
			<tr style="width:1000px;margin-left:auto;margin-right:auto;">
				<td>所&nbsp;属&nbsp;部&nbsp;门 : </td>
				<td>
					<select id="department" class="easyui-validatebox" name="DepartmentId" style="width:73%;margin:25px;padding:10px 15px 10px 15px" required="true">
						<option value="1">财务部</option>
						<option value="2">收发室</option>
						<option value="3">业务管理科</option>
					</select>
				</td>
			</tr>
			<tr style="width:1000px;margin-left:auto;margin-right:auto;">
				<td>性&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;别 : </td>
				<td>
					<select class="easyui-validatebox" name="Gender" style="width:73%;margin:25px;padding:10px 15px 10px 15px" required="true">
						<option value="0">男</option>
						<option value="1">女</option>
					</select>
				</td>
			</tr>
			<tr style="width:1000px;margin-left:auto;margin-right:auto;"><td>密&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;码 : </td><td><input type="text" name="Password" class="easyui-validatebox" required="true" style="width:70%;margin:25px;padding:10px 15px 10px 15px"></td></tr>
			<tr><td><input style='display:none;' name='Id' class='easyui-validatebox' value='-1'></input></td></tr>
			<div style="padding:5px;text-align:center;margin-top:30px">
				<button id="submit_btn" class="easyui-linkbutton" icon="icon-ok" style="width:150px;height:60px;margin-right:20px" onclick="saveUser(this)" value="0">确认</button>
				<button class="easyui-linkbutton" icon="icon-cancel" style="width:150px;height:60px" onclick='$("#new_user").css("display","none");'>取消</button>
			</div>
		</form>
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
	 	
     var myChart1 = echarts.init(document.getElementById('echarts1'),'blue');  
     var myChart2 = echarts.init(document.getElementById('echarts2'),'blue'); 
		var time1 = new Date();
		var time2 = new Date();
		var len = 10;
		var res = [];
		var res1 = [];
		var res2 = [];
		while (len--) {
		res.unshift(time1.toLocaleTimeString().replace(/^\D*/,''));
	    time1 = new Date(time1 - 3000);
	    res2.unshift(time2.toLocaleTimeString().replace(/^\D*/,''));
	    time2 = new Date(time2 - 60000);
		}
		
		var len = 10;
		while (len--) {
		    res1.push(0);
		  
		}
		var xAxisData1 = res; //x轴数据
		var xAxisData2 = res2;
		var yAxisData = res1; //y轴数据

	
	// 指定图表的配置项和数据
	var option1 = {
			title : {
			    text: '',
			    textstyle:{
			    	"fontSize":"20",
		            "fontWeight": "bolder"
		    },
			},
			tooltip : {
			    trigger: 'axis', 
		        axisPointer: {
		            type: 'cross',
		            label: {
		            //    backgroundColor: 'F2F2F2'
		            }
		        }
			 },
		    legend: {
		        data:['实时上行车流量变化', '实时下行车流量变化'],
		        textStyle: {  
		            color: '#fff',          //legend字体颜色 
		            fontSize:'22'

		        }
		    },
		    toolbox: {
		        show : true,
		        feature : {
		            dataView : {show: true, readOnly: false},
		           // magicType : {show: true,  type:['line', 'bar']},
		            restore : {show: true},
		            saveAsImage : {show: true}
		        },
		        
	            itemSize:'22',
	            emphasis:{//触发时
	                iconStyle:{
	                    borderColor:"white"//图形的描边颜色
	                }
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
		            axisLabel: {        
		                show: true,
		                textStyle: {
		                    color: '#fff',
		                    fontSize:'20'
		                }
		            },
		        // 控制网格线是否显示
			        splitLine: {
			                show: false, 
			                //  改变轴线颜色
			                lineStyle: {
			                    // 使用深浅的间隔色
			                    color: ['white']
			                }                            
			        },
		            axisLine:{
		                lineStyle:{
		                    color:'#FFFFFF',
		                    width:1
		                }
		            },
		            axisPointer: {
	                type: 'shadow'
	                },

		            boundaryGap : true,
		            data:xAxisData1
		        },
		         {
		            type: 'category',
		            boundaryGap: true,
		            data: (function (){
		                var res = [];
		                var len = 10;
		                while (len--) {
		                    res.push(10 - len - 1);
		                }
		                return res;
		            })()
		        }
		   ],
		   yAxis : [
		      {
		           type : 'value',
		           scale: true,
		           name : '车流量V/h',
		           axisLabel: {        
		                show: true,
		                textStyle: {
		                    color: '#fff',
		                    fontSize:'20'
		                }
		            },
		        // 控制网格线是否显示
			        splitLine: {
			                show: false, 
			                //  改变轴线颜色
			                lineStyle: {
			                    // 使用深浅的间隔色
			                    color: ['white']
			                }                            
			        },
			        max: 20,
           			min: 0,
		           boundaryGap: [0.2, 0.2],
		           
		      },
		      {
		           type : 'value',
		           scale: true,
		           name : '车流量V/h',
		           axisLabel: {        
		                show: true,
		                textStyle: {
		                    color: '#fff',
		                    fontSize:'20'
		                }
		            },
		        // 控制网格线是否显示
			        splitLine: {
			                show: false, 
			                //  改变轴线颜色
			                lineStyle: {
			                    // 使用深浅的间隔色
			                    color: ['white']
			                }                            
			        },
			        max: 20,
           			min: 0,
		           boundaryGap: [0.2, 0.2],
		           
		      }
		  ],
		  series : [
		       {
		            name:"实时上行车流量变化",
		            type:'bar',
		            //stack:'one',
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
		            
		       },
		       {
		            name:"实时下行车流量变化",
		            type:'line',
		           // stack:'one',
		            
		            data:(function (){
			                var res = [];
			                var len = 0;
			                while (len < 10) {
			                    res.push(0);
			                    len++;
			                }
			                return res;
			            })(),
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
		            
		       },
		       
		  ]
		};

 var option2 = {
				title: {
			        text: '',   
			        textstyle:{
			            fontWeight: 'normal',              //标题颜色
			            color: 'FFFFFF',
			            fontSize:'25'
			    }
			    },
			    tooltip: {
			        trigger: 'axis',
			        axisPointer: {
			            type: 'cross',
			            label: {
			            //    backgroundColor: 'F2F2F2'
			            }
			        }
			    },
			    legend: {
			        data:['每分钟上行车流量变化', '每分钟下行车流量变化'],
			        textStyle: {  
			            color: '#fff',          //legend字体颜色 
			            fontSize:'22'
			
			        }
			
			      
			    },
			    toolbox: {
			        show: true,
			        feature: {
			            dataView: {readOnly: false},
			           // magicType : {show: true, type: ['line', 'bar']},
			            restore: {},
			            saveAsImage: {}
			        },
			        itemSize:'22',
			        emphasis:{//触发时
			            iconStyle:{
			                borderColor:"white"//图形的描边颜色
			            }
			        }
			    },
			    dataZoom: {
			        show: true,
			        start: 0,
			        end: 100
			    },
			    xAxis: [
			        {
			            type: 'category',
			            axisLabel: {        
			                show: true,
			                textStyle: {
			                    color: '#fff',
			                    fontSize:'20'
			                }
			            },
			        // 控制网格线是否显示
				        splitLine: {
				                show: false, 
				                //  改变轴线颜色
				                lineStyle: {
				                    // 使用深浅的间隔色
				                    color: ['white']
				                }                            
				        },
			            axisLine:{
			                lineStyle:{
			                    color:'#FFFFFF',
			                    width:2
			                }
			            },
			
			
			            boundaryGap: true,
			            data: (function (){
				                var now = new Date();
				                var res = [];
				                var len = 10;
				                while (len--) {
				                    res.unshift(now.toLocaleTimeString().replace(/^\D*/,''));
				                    now = new Date(now - 60000);
				                }
				                return res;
				            })()
			        },
			        {
			            type: 'category',
			            boundaryGap: true,
			            data: (function (){
			                var res = [];
			                var len = 10;
			                while (len--) {
			                    res.push(10 - len - 1);
			                }
			                return res;
			            })()
			        }
			    ],
			    yAxis: [
			        {
			            type: 'value',
			            scale: true,
			            name: '车流量V/h',
			            axisLabel: {        
			                show: true,
			                textStyle: {
			                    color: '#fff',
			                    fontSize:'20'
			                }
			            },
			            // 控制网格线是否显示
			            splitLine: {
			                    show: false, 
			                    //  改变轴线颜色
			                    lineStyle: {
			                        // 使用深浅的间隔色
			                        color: ['white']
			                    }                            
			            },
			            max: 100,
			            min: 0,
			            boundaryGap: [0.2, 0.2]
			        },
			        {
			            type: 'value',
			            scale: true,
			            name: '车流量V/h',
			            axisLabel: {        
			                show: true,
			                textStyle: {
			                    color: '#fff',
			                    fontSize:'20'
			                }
			            },
			            // 控制网格线是否显示
			            splitLine: {
			                    show: false, 
			                    //  改变轴线颜色
			                    lineStyle: {
			                        // 使用深浅的间隔色
			                        color: ['white']
			                    }                            
			            },
			            max: 100,
			            min: 0,
			            boundaryGap: [0.2, 0.2]
			        }
			       
			    ],
			    series: [
			        {
			            name:'每分钟上行车流量变化',
			            type:'bar',
			            xAxisIndex: 1,
			            yAxisIndex: 1,   
			            data:
			             (function (){
			                var res = [];
			                var len = 10;
			                while (len--) {
			                    res.push(0);
			                }
			                return res;
			            })() ,
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
			        },
			        {
			            name:'每分钟下行车流量变化',
			            type:'bar',
			            data:(function (){
			                var res = [];
			                var len = 0;
			                while (len < 10) {
			                    res.push(0);
			                    len++;
			                }
			                return res;
			            })(),
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
		

    
	myChart1.setOption(option1);
	myChart2.setOption(option2);
    $(window).resize(function(){
       myChart1.resize();
       myChart2.resize();
    });
    window.onresize = myChart1.resize();
    window.onresize = myChart2.resize();
	
	
	
	 var opts = {
			width : 0,     // 信息窗口宽度
			height: 0,     // 信息窗口高度
			title : "<span style='font-size:20px;color:#0099cc;background-color:#FFFFFF'>"+"流量信息窗口"+"</span>" , // 信息窗口标题
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
		             	var droneId = data.drones[i].droneId;
			            var thepoint = data.drones[i]; 
			           
			            marker.addEventListener("click", function (){
			            //map.panTo(point);		            
						showInfo(this, thepoint);//开启信息窗口
						
						test(droneId);
						
						getEcharts1(droneId);
						
						getEcharts2(droneId);
						var vlc = document.getElementById("vlc"); 
						var id = 0; 
						//id = vlc.playlist.add(videoUrl); //添加mrl到播放列表
						id = vlc.playlist.add("rtsp://47.94.19.230:10554/stream0.sdp"); //添加mrl到播放列表						
						vlc.playlist.playItem(id);  //播放播放列表里的序列
						/* videojs("my-video").ready(function(){
							var myPlayer = this;
							myPlayer.play();
						}); 
						 */
						
						
			            });
		            })();	
		            function showInfo(thisMarker,point){
			         //thisMarker.setAnimation(BMAP_ANIMATION_BOUNCE);
			         var content = 
					"<p style='margin:0;line-height:1.5;font-size:20px;text-indent:0em'>无人机编号： "+point.code+"<br/>经度："+point.longitude+" 纬度："+point.latitude+"</br>雪阻预警等级： 2</br>状态： 0</p>";
					 var infoWindow = new BMap.InfoWindow(content, opts);
					 thisMarker.openInfoWindow(infoWindow);
			       }	
			       function getEcharts1(droneId){
			              clearInterval(app1);
			              var app1 = {};
			              var lastData = 0;
			              var lastData1 = 0;
	                      app1.count = 10;
				          app1.timeTicket = setInterval(function (){
						  var url = '/droneSystem/DroneServlet.do?method=6';
						  var paramData={type:3,droneId:droneId};
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
						          
						          lastData = data.tsLeft;
						          lastData1 = data.tsRight;
						          //lastData = Math.round(Math.random() * 1000);
						        
						          }
						      }
						  }); 

						    var axisData;	
						    axisData = (new Date()).toLocaleTimeString().replace(/^\D*/, '');
						    var data0 = option1.series[0].data;
						    var data1 = option1.series[1].data;
						    data0.shift();
						    data0.push(lastData);
						    //data0.push(Math.round(Math.random() * 1000));
						    data1.shift();
						    data1.push(lastData1); 
						    option1.xAxis[0].data.shift();
				    		option1.xAxis[0].data.push(axisData);
				    		option1.xAxis[1].data.shift();
                            option1.xAxis[1].data.push(app1.count++);				    		
				    		myChart1.setOption(option1);
						  // 动态数据接口 addData
					      /* myChart1.addData([
					        [
					            0,        // 系列索引
					            lastData, // 新增数据
					            false,     // 新增数据是否从队列头部插入
					            false,    // 是否增加队列长度，false则自定删除原有数据，队头插入删队尾，队尾插入删队头
					            axisData //横轴数据
					        ]		       
						  ]); */
						}, 3000);
				     } 
				     
				     function getEcharts2(droneId){
			     		  clearInterval(app2);
			     		  var app2 = {};
			     		  var lastData2=0;
			     		  var lastData3=0;
	 					  app2.count = 10;
				          app2.timeTicket = setInterval(function (){
						  var url = '/droneSystem/DroneServlet.do?method=7';
						  var paramData={type:3,droneId:droneId};
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
						          lastData2 = data.carNumLeft;
						          lastData3 = data.carNumRight;
						          //lastData = Math.round(Math.random() * 1000);
						        
						          }
						      }
						  }); 
  
						    
						    var axisData1;
						    axisData1 = (new Date()).toLocaleTimeString().replace(/^\D*/, ''); 
						    var data3 = option2.series[0].data;
						    var data4 = option2.series[1].data;
						    data3.shift();
						    data3.push(lastData2);
						    data4.shift();
						    data4.push(lastData3);
						    option2.xAxis[0].data.shift();
				    		option2.xAxis[0].data.push(axisData1);
				    		option2.xAxis[1].data.shift();
                            option2.xAxis[1].data.push(app2.count++);				    		
				    		myChart2.setOption(option2);
						  // 动态数据接口 addData
					      /* myChart1.addData([
					        [
					            0,        // 系列索引
					            lastData, // 新增数据
					            false,     // 新增数据是否从队列头部插入
					            false,    // 是否增加队列长度，false则自定删除原有数据，队头插入删队尾，队尾插入删队头
					            axisData //横轴数据
					        ]		       
						  ]); */
						}, 60000);
				     }             		           		
				}	
		}	
		}); 	
    
	}
         
     
     
	 function test(droneId){
	  $.ajax({
       	 	type: "post", 
           	cache: false, 
           	dataType: 'json',
           	url: '/droneSystem/DroneServlet.do?method=3',
//           	data:{droneId:droneId, type:3,inputStream:"D:\\test\\MOV_0030.MOV"},
//			data:{droneId:droneId, type:3,inputStream:"D:\\test\\total_Receive_HDMI.h264"},
//			data:{droneId:droneId, type:3,inputStream:"rtsp://47.94.19.230:10554/gzrtsp.sdp"},
			data:{droneId:droneId, type:3,inputStream:"rtsp://47.94.19.230:10554/stream0.sdp"},
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
            //alert(videoId + data.ts);
			}	
		}); 	
	    
	}
	
	
	/*分页用户查询功能 */
	//全局变量
	var currentPage;
	var totalPage;
	var isInit = false;
	/* *
	 * @brief 按分页要求查询用户
	 * @params data 存放查询到的用户对象和用户数的json 
	 * @return null
	 * */
	function queryUser(data){
		//清空列表
		$("#usertable").empty();	
		//得到存放着json对象的数组，例如：{{"Id":"1","Name":"nick"....},{"Id":"2","Name":"barry"...}}
		data = data.rows;
		var tr = '<th scope="col" width="300">ID</th>' +
			'<th scope="col">用户名</th>' +
			'<th scope="col">真实姓名</th>' +
			'<th scope="col">部门</th>' +
			'<th scope="col">角色</th>' +
			'<th scope="col">账号状态</th>' +
			'<th scope="col">注册时间</th>' +
			'<th scope="col">操作选择</th>';
		$("#usertable").append("<tr>"+tr+"</tr>");
		
		$.each(data,function (index,item) {    
			var tr;  				
			tr = "<td class='user_id'>" + item.Id + "</td>";   
			tr += "<td>" + item.userName + "</td>";  
			tr += "<td>" + item.Name + "</td>";       
			tr += "<td>" + item.JobTitle + "</td>"; 
			tr += "<td>" + item.Education  + "</td>";     
			tr += "<td>" + item.Status + "</td>";    
			tr += "<td>" + item.CancelDate + "</td>";     					
			tr += "<td><a href='#' onclick='modifyUser(this)'>编辑</a><a href='#' onclick='deleteUser(this)'>删除</a></td>";   
			  										
			$("#usertable").append("<tr>"+tr+"</tr>");			
									
		});
	}
	
	/* *
	 * @brief 更换页面显示
	 * @params currentPage 点击的页数
	 * @return null
	 * */
	function changePage(page){
		if(page < 1 || page > totalPage){
			return;
		}
		currentPage = page;
		var queryJson = {};
		queryJson.page = page;
		queryJson.rows = 10;
		$.ajax({
			type: "post", 
			cache: false, 
			dataType: 'json',
			url: '/droneSystem/UserServlet.do?method=0',
			data: queryJson,
			success: function(data){
				initPage(data.total);
				queryUser(data);
			}
		});
	}
	changePage(1);
	
	/* *
	 * @brief 初始化页面控件
	 * @params  totalCntOfUser 用户的总数量
	 * @return null
	 * */
	function initPage(totalCntOfUser){
		//判断是否初始化过页数控件
		if(isInit){
			return;
		}
		isInit = true;
		
		totalPage = Math.ceil(totalCntOfUser / 10);
		var aLabel = '';
		if (totalPage >= 3) {
			aLabel += '<a class="change_page" href="#">上一页</a>'
			aLabel += '<a class="change_page" href="#">1</a>';
			aLabel += '<a href="#">...</a>';
			aLabel += '<a class="change_page" href="#">'+totalPage+'</a>';
			aLabel += '<a class="change_page" href="#">下一页</a><span>到第<input id="switch_page" type="text" />页<button id="confirm_page">确定</button></span>'
			$("#user").append(aLabel);
		} else {
			aLabel += '<a class="change_page" href="#">上一页</a>'
			for(var i = 1; i <= totalPage; i++){
				aLabel += '<a class="change_page" href="#">'+i+'</a>';
			}
			aLabel += '<a class="change_page" href="#">下一页</a><span>到第<input id="switch_page" type="text" />页<button id="confirm_page">确定</button></span>'
			$("#user").append(aLabel);
		}
		$(".change_page").click(function(){
			var temp = $(this).text();
			if(temp == "上一页" && currentPage > 1){
				currentPage--;
			} else if(temp == "下一页" && currentPage < totalPage){
				currentPage++;
			} else if(temp != "上一页" && temp != "下一页"){
				currentPage = temp;
			}
			changePage(currentPage);
		});
		$("#confirm_page").click(function(){
			var switchPage = $("#switch_page").val();
			currentPage = switchPage;
			changePage(switchPage);
		});
	}
	
	/*添加用户功能 */
	function saveUser(element){
		var flag = $(element).attr('value');
		switch(flag){
			case "1":
				$('#new_user_form').form({
					url:'/droneSystem/servlet/UserServlet.do?method=1',
					success:function(data){			
						console.log(data);		   			
					}
				});
				break;
			default:
				//修改用户信息
				$('#new_user_form').form({
					url:'/droneSystem/servlet/UserServlet.do?method=2',
					success:function(data){			
						console.log(data);		   			
					},
				});
				break;
		}
		//隐藏窗口
		$("#new_user").css("display","none");
	}
	
	/*编辑用户信息的功能*/
	function modifyUser(element){
		var userId = $(element).parent().parent().find(".user_id").text();
		$("#new_user").css("display","block");
		$("#submit_btn").attr("value",""+userId);
		$("input[name='Id']").attr("value",""+userId);
	}
	
	/*删除用户的功能*/
	function deleteUser(element){
		var deleteJson = {};
		deleteJson.id = $(element).parent().parent().find(".user_id").text();
		$(element).parent().parent().remove();
		$.ajax({
			type: "post", 
			dataType: 'json',
			url: '/droneSystem/UserServlet.do?method=8',
			data: deleteJson,
			success: function(data){
				console.log(data);
			}
		});
	}
	
</script>

