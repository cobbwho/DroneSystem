<%@ page contentType="text/html; charset=gb2312" language="java" import="com.droneSystem.util.*" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
   <meta http-equiv="Content-Type" content="text/html; charset=gb2312" />

    <title></title>
    <link rel="stylesheet" type="text/css" href="../Inc/Style/themes/default/easyui.css" />
    <link rel="stylesheet" type="text/css" href="../Inc/Style/themes/icon2.css" />
    <link rel="stylesheet" type="text/css" href="../Inc/Style/Style.css" />
    <script type="text/javascript" src="../Inc/JScript/jquery-1.6.min.js"></script>
    <script type="text/javascript" src="../Inc/JScript/jquery.easyui.min.js"></script>
	
<script type="text/javascript">
	
	
	function save()
	{
		$('#ff').form('submit',{
			//url:'/droneSystem/SysConfigServlet.do?method=0',
			onSubmit:function(){},
			success:function(data){
				var result = eval("("+data+")");
				if(result.IsOK){
					$.messager.alert('提示！','配置成功！','info');
				}else{
					$.messager.alert('错误！',result.msg,'error');
				}
			}
		});
		
	}	
</script>
</head>
<body>
<DIV class="droneSystemMainLayoutDiv">

	<DIV class="droneSystemCenterLayoutDIV">
    <div align="center" style="padding:20px;" bgcolor="#CAD7F7">

	
    <form id="ff" method="post">

	<table cellspacing="20" bgcolor="#CAD7F7">
	    
		<tr>
			<td >参数1：</td>
			<td align="left"><input style="width:155px"  type="text" id="SecondLoginPeriod" name="SecondLoginPeriod" class="easyui-numberbox" value="<%=SystemCfgUtil.getSecondLoginPeriod() %>" /></td>
		</tr>
        <tr>
			<td >参数2：</td>
			<td align="left"><input style="width:155px"  type="text" id="DonglePID" name="DonglePID" value="<%=SystemCfgUtil.getDonglePID() %>" /></td>
		</tr>
        <tr>
			<td >参数3：</td>
			<td align="left"><input style="width:155px"  type="text" id="DonglePIN" name="DonglePIN" value="<%=SystemCfgUtil.getDonglePIN() %>" /></td>
		</tr>
		<tr>
			<td >***：</td>
			<td align="left"><input style="width:155px"  type="text" id="DonglePIN" name="DonglePIN" value="<%=SystemCfgUtil.getMsgIpAddress() %>" /></td>
		</tr>
		<tr>
			<td >***：</td>
			<td align="left"><input style="width:155px"  type="text" id="DonglePIN" name="DonglePIN" value="<%=SystemCfgUtil.getMsgPort() %>" /></td>
		</tr>
		<tr>
			<td >***：</td>
			<td align="left"><input style="width:155px"  type="text" id="DonglePIN" name="DonglePIN" value="<%=SystemCfgUtil.getMsgUserName() %>" /></td>
		</tr>
		<tr>
			<td >***：</td>
			<td align="left"><input style="width:155px"  type="text" id="DonglePIN" name="DonglePIN" value="<%=SystemCfgUtil.getMsgPwd() %>" /></td>
		</tr>
		
	</table>
	</form>
	</div>

	<div id="dlg-buttons" align="center">
		<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-edit" onclick="save()">确认修改</a>
	</div>

</DIV>
</DIV>
</body>
</html>