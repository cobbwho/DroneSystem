<%@ page language="java" pageEncoding="UTF-8"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
	<HEAD>
	<%if(request.getParameter("log")!=null){
		if(request.getParameter("log").equals("0")){
		%>
		<script>
			$.messager.alert('提示','该账号已经登录','info');
			</script>
	<%		
		}
		if(request.getParameter("log").equals("1")){
	 %>
	 <script>
	 		$.messager.alert('提示','用户名或密码错误','info');
	 	</script>
	 	<%}
	 	 }%>
		<TITLE>内蒙古高速公路无人机业务系统   —— 登 录</TITLE>
		<META http-equiv=Content-Type content="text/html; charset=UTF-8">
		<LINK href="css/login.css" type=text/css rel=STYLESHEET>
		<link rel="stylesheet" type="text/css" href="Inc/Style/themes/default/easyui.css" />
		<link rel="stylesheet" type="text/css" href="Inc/Style/themes/icon2.css" />

		<script type="text/javascript" src="Inc/JScript/jquery-1.6.min.js"></script>
		<script type="text/javascript" src="Inc/JScript/jquery.easyui.min.js"></script>
		<script>
		var loginInputForm;
		$(function() {
			
			loginInputForm = $('#form1').form({
					url:'/droneSystem/servlet/UserServlet.do?method=4',
					success : function(data) {
						var result = eval("("+data+")");
			   			
			   			if(result.IsOK){
			   				window.parent.location.href="/droneSystem/Common/Main.jsp";
			   			}
			   			else{
			   				$.messager.alert('提示',result.msg,'error');
			   			}	
					},
					onSubmit : function() {
						return check();
					}
				});
				
			loginInputForm.find('input').keydown(function(e){ /* 增加回车提交功能 */
		            var curKey = e.which; 
		            if(curKey == 13){
						loginInputForm.submit();
				}
			});
			
			//$.messager.alert('提示','此版本是正式系统，如需测试，请转到http://10.132.192.59:8080/droneSystem/','info');		
			
		});
			function check(){
				var frm = document.form1; 
				if(frm.userName.value==""){
					$.messager.alert('提示','用户名不能为空!','info');
					document.form1.userName.focus();
					return false;
				}else if(frm.password.value==""){
					$.messager.alert('提示','登录密码不能为空!','info');
				    frm.password.focus();
				    return false;
				}else {
					return true;
				}				
				//request.setAttribute("pwd",frm.password.value);
				//request.setAttribute("userId",frm.userName.value);
				//response.sendRedirect("/TPM/sm/UserServlet.do"); 
				
			}
			
			function login(){
				$('#form1').submit();
			}
			
			function forget(){
			   	$.messager.alert('提示','请联系管理员','info');			 
			}
		</script>
		
	</HEAD>
	<body bgcolor="#ffffff" onload="javascript:document.form1.userName.focus();">
		<center>
			
			<div id="content" style="
								    width: 3100px;
								    height: 1100px;
								    margin-top: 400px;
								    margin-bottom: 80px;
								">
				<div class="module_darkgray" style="
												    height: 1100px;
												">
					<div class="bottomedge_darkgray" style="
														    height: 1100px;
														">
						<div class="topleft_darkgray" style="
														    width: 40px;
														    height: 40px;
														"></div>
						<div class="topright_darkgray" style="
														    width: 40px;
														    height: 40px;
														"></div>
						<div class="moduleborder" style="
													    padding-left: 24px;
													    padding-top: 24px;
													    padding-right: 24px;
													    padding-bottom: 24px;
													    height: 1052px;
													">
							<div class="module_inset_darkgray" style="
																    height: 1052px;
																">
								<div class="bottomedge_inset_darkgray" style="
																		    height: 1052px;
																		">
									<div class="topleft_inset_darkgray" style="
																			    width: 40px;
																			    height: 40px;
																			"></div>
									<div class="topright_inset_darkgray" style="
																			    width: 40px;
																			    height: 40px;
																			"></div>
									<div style="LEFT: 735px;PADDING-TOP: 5px;POSITION: absolute;left: 2900px;padding-top: 20px;width: 64px;height: 80px;">
										<img height="20" src="images/white_lock.gif" width="14" border="0" style="
																											    width: 64px;
																											    height: 80px;
																											">									</div>
									<div style="PADDING-LEFT: 35px;PADDING-BOTTOM: 20px;PADDING-TOP: 40px;align: left;padding-top: 60px;padding-bottom: 50px;">
									<!-- <IMG src="images/text_dotmaclogin.png" border=0>			 -->						</div>
									<div style="PADDING-RIGHT: 15px;PADDING-LEFT: 35px;height: 816px;padding-left: 140px;padding-right: 60px;">
										<table cellspacing="0" cellpadding="0" width="689" border="0" style="
																										    width: 2852px;
																										    height: 816px;
																										">
											<tbody>
												<tr>
													<td style="PADDING-RIGHT: 20px;width: 1376px;padding-right: 80px;" width="318">
														<table cellspacing="0" cellpadding="0" border="0" style="
																											    width: 1322px;
																											    height: 200px;
																											">
															<tbody>
																<tr>
																	<td style="MARGIN-BOTTOM: 10px" valign="top" height="15">
																		<font size="44"><strong>用户登录</strong></font>																</td>
																</tr>
																<tr>
																	<td class="content_gray_bold" height="30">
																		<font size="44">请输入您的用户名和密码登录系统。</font>																</td>
																</tr>
															</tbody>
														</table>
														<!-- Begin Form -->
														<form method="post" id="form1" name="form1" theme="simple" style="
																												    height: 600px;
																												">
															<table cellspacing="0" cellpadding="0" width="318" border="0" style="
																																    height: 608px;
																																    width: 1370px;
																																">
																<tbody>
																	<tr>
																		<td height="60">																		</td>
																	</tr>
																	<tr>
																		<td align="left">
																			<span class="content_black_bold"><font size="44">用户名</font></span>
																			<br>
																			<br>
																			<font class="form"><input class="form" value="" autocomplete="off" style="WIDTH: 250px;width: 1290px;height: 70px;border-top-width: 8px;border-right-width: 8px;border-left-width: 8px;border-bottom-width: 8px;padding-top: 4px;padding-bottom: 4px;font-size:44px" maxlength="28" name="userName" id="username" required="true"> </font>
																			<font color="red"></font>																		</td>
																	</tr>
																	<tr>
																		<td height="32">																		</td>
																	</tr>
																	<tr>
																		<td align="left">
																			<span class="content_black_bold"><font size="44">密码</font></span>
																			<br>
																			<br>
																			<font class="form"><input class="form" value="" style="WIDTH: 250px;border-left-width: 8px;border-top-width: 8px;border-right-width: 8px;border-bottom-width: 8px;padding-bottom: 4px;padding-top: 4px;width: 1290px;height: 70px;font-size:44px" type="password" maxlength="32" name="password" minlength="6" required="true"> </font>																		</td>
																	</tr>
																	<tr>
																		<td height="40">
																			<img height="40" alt="" src="images/spacer.gif" width="4" border="0">																		</td>
																	</tr>
																	<tr>
																		<td class="content_gray" valign="top" align="left">
																			<a href="javascript:forget()" style="font-size:44px">忘记密码?</a>
																		</td>
																	</tr>

																	<tr>
																		<td nowrap="" align="right" style="padding-right:68px">
																			<input type="button" id="loginbtn" iconcls="icon-ok" href="javascript:void(0)" onclick="login()" value="登陆" style="
																																														    width: 144px;
																																														    padding-left: 24px;
																																														    padding-right: 24px;
																																														    padding-top: 4px;
																																														    padding-bottom: 4px;
																																														    border-top-width: 8px;
																																														    border-bottom-width: 8px;
																																														    border-right-width: 8px;
																																														    border-left-width: 8px;font-size:44px                         
																																														">
																		</td>
																	</tr>
																</tbody>
															</table>
														</form>													</td>
													<!-- End Form -->
													<td valign="top">
														<table cellspacing="0" cellpadding="0" border="0">
															<tbody>
																<tr>
																	<td style="BACKGROUND-COLOR: #e3e3e3" width="2" height="200"></td>
																</tr>
															</tbody>
														</table>													</td>
													<td style="PADDING-LEFT: 30px;width: 1473px;" valign="top" width="318">
														<!-- Message 2 -->
														<table cellspacing="0" cellpadding="0" border="0" id="table1" style="
    width: 1397px;
    height: 816px;
">
															<tbody>
																<tr>
																	<td class="content_gray" valign="top" style="
    height: 840px;
">
																		<param name="wmode" value="transparent">
																		<embed width="1390" height="750" src="images/banner.swf" menu="false" type="application/octet-stream" wmode="transparent" style="
    height: 720px;
">
																		<p style="margin-top:20px;font-size:44px;height: 80px;">
																		为了更合理的管理业务,让员工可以轻松高效地完成工作,促进信息化
																		<br>
																		<br>
																		<br>
																		社会的发展
																		</p>
																																			</td>
																</tr>
															</tbody>
														</table>													</td>
												</tr>
											</tbody>
										</table>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
			<div>
				<table cellspacing="0" cellpadding="0" width="776" align="center" border="0">
					<tbody>
						<tr>
							<td valign="top" align="center" width="776" style="font-size:44px">
								无人机业务管理系统							</td>
						</tr>
					</tbody>
				</table>
			</div>
			<!-- END content_gray -->
			<table cellspacing="0" cellpadding="0" width="100%" border="0">
				<tbody>
					<tr>
						<td align="center">
							<font class="disclaimer" face="Geneva, Verdana, Arial, Helvetica" color="#999999" style="font-size:44px">©&nbsp;Copyright 2018 .NJUST 623
								All rights reserved.</font>
							<br>
							<br>						</td>
					</tr>
				</tbody>
			</table>
		</center>
<!--     <object CLASSID="clsid:2A3D0646-E5FD-4D18-9DD1-59FB5E9855E0"
        CODEBASE="/droneSystem/Dongle/files/ET299.cab#Version=1,00,0000"
        BORDER="0" VSPACE="0" HSPACE="0" ALIGN="TOP" HEIGHT="0" WIDTH="0">
    </object> -->
	


</body>
</HTML>

