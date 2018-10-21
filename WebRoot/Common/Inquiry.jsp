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
<script type="text/javascript" src="../Inc/JScript/jquery-1.6.min.js"></script>
<script type="text/javascript" src="../Inc/JScript/jquery.easyui.min.js"></script>
<script type="text/javascript" src="../Inc/JScript/locale/easyui-lang-zh_CN.js" charset="utf-8"></script>
<script type="text/javascript" src="../JScript/upload.js"></script>
<script type="text/javascript" src="../JScript/admin.js"></script>
<script type="text/javascript" src="../JScript/inquiry.js"></script>
<script type="text/javascript" src="../JScript/json2.js"></script>
<title>内蒙古无人机项目管理系统-查询统计</title>
</head>
<body>
<script type="text/javascript" src="../Inc/JScript/echarts.min.js" charset="UTF-8"></script>
<script type="text/javascript" src="../Inc/JScript/blue.js" charset="UTF-8"></script>

	<div class="head_area">
		<div class="fleft"><img src="../images/logo.png" /></div>
		<div class="head_left">
		<ul>
			<li><a href="Main.jsp">流量信息</a></li>
			<li><a href="Snow.jsp">雪阻信息</a></li>
			<li><a href="Sand.jsp">沙阻信息</a></li>
			<li><a href="javascript:void(0)" onclick="ale()">红外信息</a></li>
			<li><a href="Inquiry.jsp" class="pagenow">查询统计</a></li>
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
	
	<p class="h128box"></p>
	
	<div class="fleft maparea" >
		<h5 class="title_sample"><span>无人机视频列表</span></h5>
		<table border="0" cellspacing="0" cellpadding="0" class="person_name">
		  <tr>
			<th align="center" width="10%" style="height:93px">编号</th>
			<th align="center" width="16%">无人机编号</th>
			<th align="center" width="16%">视频文件名类型</th>
			<th align="center" width="16%">时间</th>
			<th align="center" width="16%">状态</th>
			<th align="center" width="16%">算法类型</th>
			<th align="center" width="10%"></th>
		  </tr>
		</table>
		<div style=" height:1323px; overflow-y:auto; background:#092E64">
		<table width="100%" border="0" cellspacing="0" cellpadding="0" class="person_name"  id="videolist">
		
		</table>
		</div>
	</div>
	
	<!-- <div class="fleft videoarea">
		<h5 class="title_sample"><span>无人机视频算法图表</span></h5>
		<div id="echarts" style="width:2500px;height:1410px">
		
		</div>
	</div> -->

	
	<div class="fleft trafficarea">
		<h5 class="title_sample"><span>车流量查询统计结果</span></h5>
		<div id="trafficechart" style="width:1460px;height:616px"></div>
	</div>
	<div class="fleft snowarea">
		<h5 class="title_sample"><span>雪阻查询统计结果</span></h5>
		<div id="snowechart" style="width:1460px;height:616px"></div>
	</div>
	<div class="fleft sandarea">
		<h5 class="title_sample"><span>沙阻查询统计结果</span></h5>
		<div id="sandechart" style="width:1460px;height:616px"></div>
	</div>
	<div class="fleft infraredarea">
		<h5 class="title_sample"><span>红外查询统计结果</span></h5>
		<div id="infraredechart" style="width:1460px;height:616px"></div>
	</div>
	<div class="myclear"></div>	
	
	
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
</body>
</html>	

<script type="text/javascript">
	function totable3(data){
		data = data.rows;
		$.each(data,function (index,item) {    
			//alert(index+item.userName);
			var tr;  				
			tr = "<td><input type='checkbox' /></td>"; 	
			tr += "<td>" + item.Id + "</td>";   
			tr += "<td>" + item.userName + "</td>";  
			tr += "<td>" + item.Name + "</td>";       
			tr += "<td>" + item.JobTitle + "</td>"; 
			tr += "<td>" + item.Education  + "</td>";     
			tr += "<td>" + item.Status + "</td>";    
			tr += "<td>" + item.CancelDate + "</td>";     					
			tr += "<td><a href='#'>编辑</a><a href='#'>删除</a></td>";   
			  										
			$("#usertable").append("<tr>"+tr+"</tr>");			
									
		});
	    
	}

	
	user();
	function user(){
		$.ajax({
			type: "post", 
			cache: false, 
			dataType: 'json',
			url: '/droneSystem/UserServlet.do?method=0',
			data:{},
			success: function(data){
//				totable1(data);
//				totable2(data);
				totable3(data);
				//totable4(data);
		
			}
		}); 	
	    
	}

	

    video();
	function video(){
		$.ajax({
			type: "post", 
			cache: false, 
			dataType: 'json',
			url: '/droneSystem/VideoServlet.do?method=0',
			data:{},
			success: function(data){
				      alert(data);
				      console.log(data);
                    for(var i=0;i<data.length;i++){     
                        var tr="";    				
						tr += "<td width='10%'>" + data[i].code + "</td>";   
						tr += "<td width='16%'>" + data[i].drone + "</td>";  
						tr += "<td width='16%'>" + data[i].video + "</td>";       
						tr += "<td width='16%'>" + data[i].time + "</td>"; 
						tr += "<td width='16%'>" + data[i].status + "</td>";
						tr += "<td width='16%'>" + data[i].type  + "</td>";
						tr += "<td width='10%'><a id='trafficbutton' href='javascript:void(0)'>查看</a></th>";
                        $("#videolist").append("<tr>"+tr+"</tr>");
	                    }
                   	
                    
			       /*  data = data.rows;
		            $.each(data,function (item) {    			      
					var tr;  				
					tr += "<td width='10%'>" + item.code + "</td>";   
					tr += "<td width='16%'>" + item.drone + "</td>";  
					tr += "<td width='16%'>" + item.video + "</td>";       
					tr += "<td width='16%'>" + item.time + "</td>"; 
					tr += "<td width='16%'>" + item.status  + "</td>";
					tr += "<td width='16%'>" + item.type  + "</td>";
					tr += "<td width='10%'><a id='trafficbutton' href='javascript:void(0)'>查看</a></th>";				 										
					$("#videolist").append("<tr>"+tr+"</tr>");		 
									
		});
			

		*/	
			}
		}); 	
	    
	}
</script>

