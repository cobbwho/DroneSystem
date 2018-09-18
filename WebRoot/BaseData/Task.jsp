<%@ page contentType="text/html; charset=gbk" language="java" import="java.sql.*" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk" />
<title>机构名称管理</title>
	<link rel="stylesheet" type="text/css" href="../Inc/Style/themes/default/easyui.css" />
    <link rel="stylesheet" type="text/css" href="../Inc/Style/themes/icon.css" />
	<link rel="stylesheet" type="text/css" href="../Inc/Style/themes/icon2.css" />
    <link rel="stylesheet" type="text/css" href="../Inc/Style/Style.css" />
	<script type="text/javascript" src="../Inc/JScript/jquery-1.6.min.js"></script>
	<script type="text/javascript" src="../Inc/JScript/jquery.easyui.min.js"></script>
	<script type="text/javascript"  src="../Inc/JScript/locale/easyui-lang-zh_CN.js" charset="utf-8"></script>
	<script>
		$(function(){			
			$('#table2').datagrid({
				title:'任务管理',
				width:900,
				height:500,
				singleSelect:false, 
                nowrap: false,
                striped: true,
				url:'',
				//sortName: 'Id',
				remoteSort: false,
				singleSelect:true, 
				idField:'Id',
				frozenColumns:[[
	                {field:'ck',checkbox:true}
				]],
				columns:[[
					{field:'Code',title:'任务编号',width:80,align:'center'},
					{field:'Highway',title:'所在公路',width:100,align:'center'},
					{field:'StartPoint',title:'任务起点',width:100,align:'center'},
					{field:'EndPoint',title:'任务终点',width:80,align:'center'},
					{field:'DroneCode',title:'无人机编号',width:80,align:'center'},
					{field:'StartTime',title:'开始时间',width:80,align:'center'},
					{field:'EndTime',title:'结束时间',width:80,align:'center'},
					{field:'Description',title:'描述信息',width:250,align:'center'}
				]],
				pagination:false,
				rownumbers:true,
				toolbar:[{
						text:'新增',
						iconCls:'icon-add',
						handler:function(){
							$('#edit').window('open');
							$('#form1').show();
							$('#form1').form('clear');
							var clickname="新增";
							$('#edit').panel({title:clickname});
						}
					},'-',{
						text:'修改',
						iconCls:'icon-edit',
						handler:function(){
							var select = $('#table2').datagrid('getSelected');
							if(select){
								$('#edit').window('open');
								$('#form1').show();
								var clickname="修改";
								$('#edit').panel({title:clickname});
								$('#form1').form('load',select);
								$('#form1').form('validate');
						}else{
							$.messager.alert('提示','请选择一行数据','warning');
							}
						}
				},'-',{
						text:'注销',
						iconCls:'icon-remove',
						handler:function(){
							var select = $('#table2').datagrid('getSelected');
							if(select){
								$.messager.confirm('提示','确认注销吗？',function(r){
								if(r){
									$.ajax({
									type:'POST',
									url:'/jlyw/AddressServlet.do?method=5',
									data:"id="+select.Id,
									dataType:"html",
									success:function(data){
										$('#table2').datagrid('reload');
									}
								});
								}
							});	
							}
							else
							{
								$.messager.alert('提示','请选择一行数据','warning');
							}
						}
				}]
			});
			
		});
		
		function Submit(){
			$('#form1').form('submit',{
				url: '/jlyw/AddressServlet.do?method=4',
				onSubmit:function(){ return $('#form1').form('validate');},
		   		success:function(data){
		   			var result = eval("("+data+")");
		   			$.messager.alert('提示',result.msg,'info');
		   			if(result.IsOK)
		   				closed();
					$('#table2').datagrid('reload');
		   		 }
			});
		}
		
		function closed(){
			$('#edit').dialog('close');
		}
			
		</script>

</head>

<body>
<DIV class="JlywMainLayoutDiv">
	<DIV class="JlywCenterLayoutDIV">
	<div style="width:900px"  region="center">
		
		<table id="table2" style="height:500px; width:900px"></table>
		
		<div id="edit" class="easyui-window" title="修改" style="padding: 10px;width: 540px;height: 280px;"
		iconCls="icon-edit" closed="true" maximizable="false" minimizable="false" collapsible="false" modal="true">
			<form id="form1" method="post">
				<div>
					<table id="table3" iconCls="icon-edit" >
					<input id="Id" name="Id" type="hidden"/>
						<tr>
							<td align="right">高速公路：</td>
							<td align="left"><input id="Highway" name="Highway" class="easyui-combobox" required="true"/></td>
							<td align="right">无人机：</td>
							<td align="left"><input id="Drone" name="Drone" class="easyui-combobox" required="true"/></td>
						</tr>
						<tr>
							<td align="right">任务起点：</td>
							<td align="left"><input id="StartPoint" name="StartPoint" class="easyui-combobox" required="true"/></td>
                            <td align="right">任务终点：</td>
							<td align="left"><input id="EndPoint" name="EndPoint" class="easyui-combobox" required="true"/></td>
						</tr>
						<tr>
							<td align="right">任务描述:</td>
							<td colspan='3'><textarea id="Description" style="width:370px;height:100px"  name="Description"  ></textarea></td>
						</tr>
						
						<tr height="50px">	
							<td></td>
							<td><a class="easyui-linkbutton" iconCls="icon-ok" href="javascript:void(0)" onclick="Submit()">提交</a></td>
							<td></td>
							<td><a class="easyui-linkbutton" iconCls="icon-cancel" href="javascript:void(0)" onclick="closed()">取消</a></td>
						</tr>
					</table>
				</div>
			</form>
		</div>
	</div>
</DIV>
</DIV>
</body>
</html>
