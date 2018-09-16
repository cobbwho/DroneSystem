<%@ page contentType="text/html; charset=gb2312" language="java" import="java.sql.*" errorPage="" %>
<%@ page import="java.sql.*,com.droneSystem.hibernate.*"%>
<%
	SysUser loginuser = (SysUser)request.getSession().getAttribute("LOGIN_USER");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>无标题文档</title>


	<link rel="stylesheet" id="easyuiTheme" type="text/css" href="../Inc/Style/themes/default/easyui.css" />
	<link rel="stylesheet" type="text/css" href="../Inc/Style/themes/icon2.css" />
    <link rel="stylesheet" type="text/css" href="../Inc/Style/Style.css" />
	
    <script type="text/javascript" src="../Inc/JScript/jquery-1.6.min.js"></script>
    <script type="text/javascript" src="../Inc/JScript/jquery.easyui.min.js"></script>
	<script type="text/javascript" src="../Inc/JScript/locale/easyui-lang-zh_CN.js" charset="utf-8"></script>	
	<script type="text/javascript" src="../JScript/upload.js"></script>
	<link rel="stylesheet" type="text/css" href="../uploadify/uploadify.css" />
	<script type="text/javascript" src="../uploadify/jquery.uploadify.v2.1.4.js"></script>
	 <script type="text/javascript" src="../Inc/JScript/unback.js"></script>

	<script>
	$(function(){
		
		$('#table').datagrid({
			//title:'通知',
			singleSelect:true, 
			fit: true,
			nowrap: false,
			striped: true,
			border:false,
			url:'/droneSystem/TaskServlet.do?method=0',
			rownumbers:true,
//			sortName: 'userid',
// 			sortOrder: 'desc',
			remoteSort: true,	//默认按服务器的排序
//			idField:'id',
			columns:[
				[
					{field:'Type',title:'任务类型',width:100,align:'center'},
					{field:'TaskTime',title:'接收时间',width:100,align:'center'},
					{field:'Content',title:'内容',width:290,align:'left', 
						formatter:function(value, rowData, rowIndex){
							if(rowData.Url==""){
								return value;
							}else{
								return "<a style='text-decoration:underline' href='"+rowData.Url+"' target='_self'  ><span style='color: #0033FF'>"+value+"</span></a>"
							}
						}}
					
				]
			],
			pagination:true
		});
		
		$('#uploaded_file_table1').datagrid({		
			iconCls:'icon-tip',
			idField:'_id',
			fit:true,
			border:false,
			rownumbers:true,
			singleSelect:true,			
			columns:[[
				{field:"filename",title:"文件名",width:200,align:"left", 
					formatter : function(value,rowData,rowIndex){
						return "<a style='text-decoration:underline' href='/droneSystem/FileDownloadServlet.do?method=0&FileId="+rowData._id+"&FileType="+rowData.filetype+ "' target='_blank' title='点击下载该文件' ><span style='color: #0033FF'>"+value+"</span></a>"
					}
				},
				{field:"length",title:"大小",width:60,align:"left"},
				{field:"uploadDate",title:"上传时间",width:120,align:"left"},
				{field:"uploadername",title:"上传人",width:60,align:"left"}
			]],
			pagination:true
	
		});
	
	});
	//安全退出系统
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
				window.parent.location.href="/droneSystem/";
			},
			complete: function(XMLHttpRequest, textStatus){
				//HideLoading();
			},
			error: function(){
				//请求出错处理
			}
		});
	}
	
	</script>
	<style type="text/css">

	.right_title{
			background:url(rightbg01.gif) repeat-x;
			color:#595a5b;
			text-align:left;
			line-height:23px;
			font-weight:bold;
			padding-top:2px;
			width:99%;
			border-top:0px solid #d6e9fc;
			border-left:0px solid #d6e9fc;
			border-right:0px solid #d6e9fc;
			float:left;
			
	}	
	
	.right_con{
		float:left;
			width:100%;
			border-bottom:0px solid #d6e9fc;
			border-left:0px solid #d6e9fc;
			border-right:0px solid #d6e9fc;
			margin-bottom:10px;
			padding-bottom:0px;
			padding-top:10px;
	}
	
	.right_con div{
		float:left;
		width:80px;
		text-align:center;
	}
	
	.right_con a{
		color:#666;
		text-decoration:none;
	}
	
	.right_con img{
		border:0 none;
		height:50px;
		width:50px;
	}
	
	span.CountStatistic {color:blue}
</style>
</head>
<body>
	<div id="portal" >
	<table >
	<tr height="80px" style="padding-bottom:10px">
		<td colspan="2">
			 <div id="p4" class="easyui-panel" style="width:1042px;"
				title="常用快捷方式" collapsible="false"  closable="false" scroll="no">

				<div class="right_con">
					<div><a href="/droneSystem/SFGL/wtd/CommissionSheet.jsp" target="_self"><img src="../images/test-management.png" title="新建强检强检委托单"/></a><br />
					<a href="/droneSystem/SFGL/wtd/CommissionSheet.jsp" target="_self">新建强检强检委托单</a></div>
		
					<div ><a href="/droneSystem/SFGL/wtd/XCCommissionSheet.jsp" target="_self"><img src="../images/train-design.png" title="现场检测业务管理"/></a><br />
					<a href="/droneSystem/SFGL/wtd/XCCommissionSheet.jsp" id="linkOnlineUsers" target="_self">现场检测业务管理</a></div>	
					
					<div><a href="/droneSystem/SFGL/wtd/CXCommissionSheet.jsp" target="_self"><img src="../images/pen.png" title="完工确认"/></a><br />					
					<a href="/droneSystem/SFGL/wtd/CXCommissionSheet.jsp" target="_self">完工确认</a></div>	
		
					<div><a href="/droneSystem/FeeManage/GenerateDetailList.jsp" target="_self"><img src="../images/train-result.png" title="生成费用清单"/></a><br />
					<a href="/droneSystem/FeeManage/GenerateDetailList.jsp" target="_self">生成费用清单</a></div>	
					
					<div><a href="/droneSystem/FeeManage/Checkout2.jsp" target="_self"><img src="../images/resource-1.png" title="结账管理"/></a><br />
					<a href="/droneSystem/FeeManage/Checkout2.jsp" target="_self">结账管理</a></div>	 
							
					<div><a href="/droneSystem/TaskManage/VehicleSchedule.jsp" target="_self"><img src="../images/zhiliang-management.png" title="车辆调度安排"/></a><br />
					<a href="/droneSystem/TaskManage/VehicleSchedule.jsp" target="_self">车辆调度安排</a></div>	
					
					<div><a href="/droneSystem/FeeManage/Quotation.jsp" target="_self"><img src="../images/txt.png" title="新增报价单"/></a><br />
					<a href="/droneSystem/FeeManage/Quotation.jsp" target="_self">新增报价单</a></div>	
					
					<div><a href="/droneSystem/TaskManage/TaskTime.jsp" target="_self"><img src="../images/search_project.png" title="修改登录密码" alt="我未完成的检验任务" /></a><br />
					<a href="/droneSystem/TaskManage/TaskTime.jsp" id="linkAlarmRuleManager" target="_self">我未完成的检验任务</a></div>	    		  
		
					<div><a href="/droneSystem/TaskManage/VerifyTask.jsp" target="_self"><img src="../images/3.png" title="核验任务列表"/></a><br />
					<a href="/droneSystem/TaskManage/VerifyTask.jsp" target="_self">核验任务列表</a></div>
					

					<div><a href="/droneSystem/TaskManage/AuthorizeTask.jsp" target="_self"><img src="../images/record-1.png" title="我的授权签字任务列表"/></a><br />
					<a href="/droneSystem/TaskManage/AuthorizeTask.jsp" target="_self">我的授权签字任务列表</a></div>	
								
					<div><a href="/droneSystem/StatisticLook/MissionLookByCommissionSheetCode.jsp" target="_self"><img src="../images/chongyong-management.png" title="根据强检强检委托单号查询业务"/></a><br />
					<a href="/droneSystem/StatisticLook/MissionLookByCommissionSheetCode.jsp" target="_self">根据强检强检委托单号查询业务</a></div>	
					
					<div><a href="javascript:void(0)" onclick="doLogout()" target="_top" ><img src="../images/logout1.png" title="安全退出"/></a><br />
					<a  href="javascript:void(0)" onclick="doLogout()"  target="_top" >安全退出</a></div>	    
		
				</div>
			</div>
		</td>
	</tr>
	<tr height="300px">
		<td height="300px">
			<div id="p2" class="easyui-panel" style="width:520px;height:300px;"
				title="我的任务列表" collapsible="false"  closable="false" scroll="no">
				
					<table id="table" class="easyui-datagrid" ></table>
						
		    </div>	
		</td>
		<td height="300px">
			<div id="p1" class="easyui-panel" style="width:520px;height:300px;"
				title="最近上传的共享文件" collapsible="false"  closable="false" scroll="no">
					<!-- 这里的filesetname是自动生成的字符串，必须和filesharingfolder表中的根目录字段filesetname的值相同 -->
					<table  class="easyui-datagrid" id="uploaded_file_table1" url="/droneSystem/FileDownloadServlet.do?method=1&FileType=105&FilesetName=20151203202949195_0232"></table>
						
		    </div>
		</td>
	</tr>
	
	<tr height="172px" valign="top">
		<td height="150px">
			<div id="p3" class="easyui-panel" style="width:520px;height:150px;padding-top:10px;padding-left:10px"
				title="登录信息" collapsible="false"  closable="false" scroll="no">
				<!--<table>
				<tr>
					<td colspan="2">
						欢迎您，${sessionScope.LOGIN_USER.name}
					</td>
				</tr>
				<tr>
					<td >
						◆您上次登陆的时间：${sessionScope.LastLoginTime}
					</td>
					<td>
					    ◆您上次登陆的IP地址：${sessionScope.LastLoginIp}
					</td>					
				</tr>
				<tr>
					<td >
						◆您本次登陆的时间：${sessionScope.LoginTime}
					</td>
					<td>
					    ◆您本次登陆的IP地址：${sessionScope.LoginIp}
					</td>		
				</tr>
				</table>-->
					<div style="height:22px">欢迎您，${sessionScope.LOGIN_USER.name}</div>
					<div style="height:22px;wight:120px">◆您上次登陆的时间：${sessionScope.LastLoginTime}</div>
					<div style="height:22px;wight:120px">◆您上次登陆的IP地址：${sessionScope.LastLoginIp}</div>				
					<div style="height:22px;wight:120px">◆您本次登陆的时间：${sessionScope.LoginTime}</div>
					<div style="height:22px;wight:120px">◆您本次登陆的IP地址：${sessionScope.LoginIp}</div>					
				  	
		    </div>
	
		</td>
		<td height="150px">
			<div id="p4" class="easyui-panel" style="width:520px;height:150px;padding-top:10px;padding-left:10px"
				title="系统信息" collapsible="false"  closable="false" scroll="no">
				 <!--   <div style="height:35px">●本系统旨在更合理的管理所内业务,让员工可以轻松高效地完成工作,促进本所信息化建设的<br/>&nbsp;&nbsp;发展.</div> -->
				    <div style="height:25px">●推荐分辨率1280*800及以上，推荐使用IE7或以上版本的浏览器</div> 
				    <div style="height:25px">●友情链接：</div> 
					
					<div style="height:20px;padding-left:20px">◆靖江质监网：<a style='text-decoration:underline' href="http://www.txzj.gov.cn/" target="_blank"><span style='color: #0033FF'>http://www.jjzj.gov.cn/</span></a></div>
					<div style="height:20px;padding-left:20px">◆江苏省质监局：<a style='text-decoration:underline' href="http://www.jsqts.gov.cn/" target="_blank"><span style='color: #0033FF'>http://www.jsqts.gov.cn/</span></a></div>
<!--					<div style="height:20px;padding-left:20px">◆常州市人民政府：<a style='text-decoration:underline' href="http://www.changzhou.gov.cn/" target="_blank"><span style='color: #0033FF'>http://www.changzhou.gov.cn/</span></a></div>-->
					<div style="height:20px;padding-left:20px">◆国家质量检疫总局：<a style='text-decoration:underline' href="http://www.aqsiq.gov.cn/" target="_blank"><span style='color: #0033FF'>http://www.aqsiq.gov.cn/</span></a></div>
		    </div>
		</td>
		
	</tr>
	
	
	
	
    </table>
 </div>
 			
</body>
</html>
