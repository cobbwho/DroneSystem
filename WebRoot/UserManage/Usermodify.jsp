<%@ page contentType="text/html; charset=gb2312" language="java"
	import="java.sql.*" errorPage=""%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>�ޱ����ĵ�</title>
<link rel="stylesheet" type="text/css"
	href="../Inc/Style/themes/default/easyui.css" />
<link rel="stylesheet" type="text/css"
	href="../Inc/Style/themes/icon2.css" />

<script type="text/javascript" src="../Inc/JScript/jquery-1.6.min.js"></script>
<script type="text/javascript" src="../Inc/JScript/jquery.easyui.min.js"></script>

<script type="text/javascript">
$(function() {
	function savereg(){
		$('#ff').form('submit',{
			url:'/droneSystem/servlet/UserServlet.do?method=2',
			success:function(data){			
				var result = eval("("+data+")");		   			
			   	if(result.IsOK){
			   		window.parent.location.href="/droneSystem/Common/Main.jsp";
			   	}
			   	else{
			   		$.messager.alert('��ʾ',result.msg,'error');
			   	}
			},
			onSubmit:function(){
				return $(this).form('validate');
			}
		});
	}
	function cancel(){
      	alert("222");
	    form.name.value="";
		form.name.focus();
    }
});
</script>
</head>

<body>
	<div align="center" style="padding:20px;">
		<h2>���޸��û���Ϣ</h2>
		<form id="ff" action="/ProcessServlet" method="post">

			<table>
				<tr>
					<td bgcolor="#CAD7F7">�� &nbsp; &nbsp;��:</td>
					<td><input style="width:155px;" name="name"
						class="easyui-validatebox" required="true" />
					</td>
				</tr>

				<tr>
					<td bgcolor="#CAD7F7">��������:</td>
					<td><select id="cc" class="easyui-combobox" name="department"
						style="width:155px;" required="true">
							<option value="dpt1">����</option>
							<option value="dpt2">�շ���</option>
							<option value="dpt3">ҵ������</option>
					</select></td>
				</tr>
			</table>
		</form>
	</div>
	<div id="dlg-buttons" align="center">
		<a href="#" class="easyui-linkbutton" iconCls="icon-ok"
			onclick="savereg()">ȷ��</a> <a href="#" class="easyui-linkbutton"
			iconCls="icon-cancel" onclick="cancel()">����</a>
	</div>
</body>
</html>
