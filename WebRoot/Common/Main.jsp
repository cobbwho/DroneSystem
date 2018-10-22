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
<title>���ɹ����˻���Ŀ����ϵͳ-������</title>
</head>
<body>
<script type="text/javascript" src="../Inc/JScript/echarts.min.js" charset="UTF-8"></script>
<script type="text/javascript" src="../Inc/JScript/blue.js" charset="UTF-8"></script>

	<div class="head_area">
		<div class="fleft"><img src="../images/logo.png" /></div>
		<div class="head_left">
		<ul>
			<li><a href="Main.jsp" class="pagenow">������Ϣ</a></li>
			<li><a href="Snow.jsp">ѩ����Ϣ</a></li>
			<li><a href="Sand.jsp">ɳ����Ϣ</a></li>
			<li><a href="javascript:void(0)" onclick="ale()">������Ϣ</a></li>
			<li><a href="javascript:void(0)" onclick="ale()" >��ѯͳ��</a></li>
		</ul>
		</div>
		<div class="fright">
		 <a id="drop_down" href="javascript:void(0)" style="margin-right:29px">admin<img src="../images/down_sanjiao.png" /></a><a id="logout" href="javascript:void(0)" onclick="doLogout()" style="margin-left:0px"><img src="../images/lines10.png" />�˳�</a>
		 <div class="js_list001" id="drop_list">
			<p id="p1"><a href="#">�û��б�</a></p>
			<p id="p2"><a href="#">��ɫ�б�</a></p>
			<p id="p3"><a href="#">Ȩ���б�</a></p>
		</div> 
		</div>
	</div>
	<div class="myclear"></div>
	
	<p class="h128box"></p>
	
	<div class="fleft maparea">
		<h5 class="title_sample"><span>��������ͼ</span></h5>
		<div id="allmap" style="width: 2021px; height: 1410px">
		</div>
	</div>
	
	<div class="fleft videoarea">
		<h5 class="title_sample"><span>��������Ƶ</span></h5>
		<div id="video" style="width:2500px;height:1410px">
<!--			<video id="my-video" class="video-js vjs-default-skin" controls="controls" preload="auto" title="���˻���Ƶ"  width="2500px" height="1410px"
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
		<h5 class="title_sample"><span>ʵʱ�������仯���</span></h5>
		<div id="echarts1" style="width:960px;height:616px"></div>
	</div>
	<div class="fleft montharea">
		<h5 class="title_sample"><span>ÿ���ӳ������仯���</span></h5>
		<div id="echarts2" style="width:960px;height:616px"></div>
	</div>
	<div class="myclear"></div>
	<div class="overlay"></div>
	<!--����001-->
	<div class="userlist" id="userlist">
		<h5 class="title_sample"><span>�û��б�</span><a id="userlist_close" href="#" ><img src="../images/cross.png" /></a></h5>
		<div class="fleft sousuolf"><a href='javascript:$("#new_user").css("display","block");$("#submit_btn").attr("value","1");'><img src="../images/addperson.png" /></a></div>
		<div class="fright sousuort"><input type="text" /><button><img src="../images/searchicon.png" /></button></div>
		<div class="myclear"></div> 
		<table id="usertable" width="100%" border="0" cellpadding="0" cellspacing="0" class="person_name">
		</table>
		<p class="endpages" id="user"></p>
	</div> 
	<div id="new_user" style="position:absolute; z-index:101; left:2750px; top:500px; width:1250px; height:900px;display:none; background:url(../images/personbg.png) repeat-x top">
		<h5 class="title_sample"><span>����û�</span><a id="userlist_close" href="#" ><img src="../images/cross.png" /></a></h5>
		<form id="new_user_form" style="padding:10px 20px 10px 40px;margin-left:50px;margin-top:30px" method="post">
			<tr style="width:1000px;margin-left:auto;margin-right:auto;"><td>��&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;�� : </td><td><input type="text" name="Name" class="easyui-validatebox" required="true" style="width:70%;margin:25px;padding:10px 15px 10px 15px"></td></tr>
			<tr style="width:1000px;margin-left:auto;margin-right:auto;"><td>��&nbsp;&nbsp;&nbsp;��&nbsp;&nbsp;&nbsp;�� : </td><td><input type="text" name="userName" class="easyui-validatebox" required="true" style="width:70%;margin:25px;padding:10px 15px 10px 15px"></td></tr>
			<tr style="width:1000px;margin-left:auto;margin-right:auto;">
				<td>��&nbsp;��&nbsp;��&nbsp;�� : </td>
				<td>
					<select id="department" class="easyui-validatebox" name="DepartmentId" style="width:73%;margin:25px;padding:10px 15px 10px 15px" required="true">
						<option value="1">����</option>
						<option value="2">�շ���</option>
						<option value="3">ҵ������</option>
					</select>
				</td>
			</tr>
			<tr style="width:1000px;margin-left:auto;margin-right:auto;">
				<td>��&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;�� : </td>
				<td>
					<select class="easyui-validatebox" name="Gender" style="width:73%;margin:25px;padding:10px 15px 10px 15px" required="true">
						<option value="0">��</option>
						<option value="1">Ů</option>
					</select>
				</td>
			</tr>
			<tr style="width:1000px;margin-left:auto;margin-right:auto;"><td>��&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;�� : </td><td><input type="text" name="Password" class="easyui-validatebox" required="true" style="width:70%;margin:25px;padding:10px 15px 10px 15px"></td></tr>
			<tr><td><input style='display:none;' name='Id' class='easyui-validatebox' value='-1'></input></td></tr>
			<div style="padding:5px;text-align:center;margin-top:30px">
				<button id="submit_btn" class="easyui-linkbutton" icon="icon-ok" style="width:150px;height:60px;margin-right:20px" onclick="saveUser(this)" value="0">ȷ��</button>
				<button class="easyui-linkbutton" icon="icon-cancel" style="width:150px;height:60px" onclick='$("#new_user").css("display","none");'>ȡ��</button>
			</div>
		</form>
	</div>
	<!--����001����-->
	<!--����002-->
	<div class="userlist" id="rolelist">
		<h5 class="title_sample"><span>��ɫ�б�</span><a href="#"><img src="../images/cross.png" /></a></h5>
		<div class="fleft sousuolf"><a href="#"><img src="../images/addperson.png" /></a><a href="#"><img src="../images/delectperson.png" /></a></div>
		<div class="myclear"></div>
		<!-------����Ȩ��������������������û�취ȷ���Ŷ�����Ŀ�������Լ�����-------->
		<table width="100%" border="0" cellpadding="0" cellspacing="0" class="person_name">
		  <tr>
			<th scope="col" width="140">&nbsp;</th>
			<th scope="col">ID</th>
			<th scope="col">��ɫ����</th>
			<th scope="col">����Ȩ��</th>
			<th scope="col" width="30%">����Ȩ��</th>
			<th scope="col">����ʱ��</th>
			<th scope="col">����ѡ��</th>
		  </tr>
		  <tr>
			<td><input type="checkbox" /></td>
			<td>17001</td>
			<td>��������Ա</td>
			<td>�鿴����ҳ��</td>
			<td>�༭��������Ԥ����ɾ�������桢���͡���ԭ�������Ա����ӽ�ɫ�����Ȩ��</td>
			<td>2017-08-19</td>
			<td><a href="#">�༭</a><a href="#">ɾ��</a></td>
		  </tr>
		  <tr>
			<td><input type="checkbox" /></td>
			<td>17001</td>
			<td>��������Ա</td>
			<td>�鿴����ҳ��</td>
			<td>�༭��������Ԥ����ɾ�������桢���͡���ԭ�������Ա����ӽ�ɫ�����Ȩ��</td>
			<td>2017-08-19</td>
			<td><a href="#">�༭</a><a href="#">ɾ��</a></td>
		  </tr>
		  <tr>
			<td><input type="checkbox" /></td>
			<td>17001</td>
			<td>��������Ա</td>
			<td>�鿴����ҳ��</td>
			<td>�༭��������Ԥ����ɾ�������桢���͡���ԭ�������Ա����ӽ�ɫ�����Ȩ��</td>
			<td>2017-08-19</td>
			<td><a href="#">�༭</a><a href="#">ɾ��</a></td>
		  </tr>
		  <tr>
			<td><input type="checkbox" /></td>
			<td>17001</td>
			<td>��������Ա</td>
			<td>�鿴����ҳ��</td>
			<td>�༭��������Ԥ����ɾ�������桢���͡���ԭ�������Ա����ӽ�ɫ�����Ȩ��</td>
			<td>2017-08-19</td>
			<td><a href="#">�༭</a><a href="#">ɾ��</a></td>
		  </tr>
		  <tr>
			<td><input type="checkbox" /></td>
			<td>17001</td>
			<td>��������Ա</td>
			<td>�鿴����ҳ��</td>
			<td>�༭��������Ԥ����ɾ�������桢���͡���ԭ�������Ա����ӽ�ɫ�����Ȩ��</td>
			<td>2017-08-19</td>
			<td><a href="#">�༭</a><a href="#">ɾ��</a></td>
		  </tr>
		  <tr>
			<td><input type="checkbox" /></td>
			<td>17001</td>
			<td>��������Ա</td>
			<td>�鿴����ҳ��</td>
			<td>�༭��������Ԥ����ɾ�������桢���͡���ԭ�������Ա����ӽ�ɫ�����Ȩ��</td>
			<td>2017-08-19</td>
			<td><a href="#">�༭</a><a href="#">ɾ��</a></td>
		  </tr>
		  <tr>
			<td><input type="checkbox" /></td>
			<td>17001</td>
			<td>��������Ա</td>
			<td>�鿴����ҳ��</td>
			<td>�༭��������Ԥ�������Ȩ��</td>
			<td>2017-08-19</td>
			<td><a href="#">�༭</a><a href="#">ɾ��</a></td>
		  </tr>
		  <tr>
			<td><input type="checkbox" /></td>
			<td>17001</td>
			<td>��������Ա</td>
			<td>�鿴����ҳ��</td>
			<td>�༭��������Ԥ����ɾ�������Ȩ��</td>
			<td>2017-08-19</td>
			<td><a href="#">�༭</a><a href="#">ɾ��</a></td>
		  </tr>
		 </table>
		<p class="endpages"><a href="#">1</a><a href="#">2</a><a href="#">3</a><a href="#">4</a><a href="#">...</a><a href="#">49</a><a href="#">��һҳ</a><span>����<input type="text" />ҳ<button>ȷ��</button></span></p>
	</div>
	<!--����002����-->
	<!--����003-->
	<div class="userlist" id="privilegelist">
		<h5 class="title_sample"><span>Ȩ���б�</span><a href="#"><img src="../images/cross.png" /></a></h5>
		<div class="fleft sousuolf"><a href="#"><img src="../images/addperson.png" /></a><a href="#"><img src="../images/delectperson.png" /></a></div>
		<div class="fright sousuort"><input type="text" /><button><img src="../images/searchicon.png" /></button></div>
		<div class="myclear"></div>
		<!-------����Ȩ��������������������û�취ȷ���Ŷ�����Ŀ�������Լ�����-------->
		<table width="100%" border="0" cellpadding="0" cellspacing="0" class="person_name">
		  <tr>
			<th scope="col" width="140">&nbsp;</th>
			<th scope="col">ID</th>
			<th scope="col">Ȩ������</th>
			<th scope="col">����</th>
			<th scope="col" width="30%">Ȩ������</th>
			<th scope="col">����ʱ��</th>
			<th scope="col">����ѡ��</th>
		  </tr>
		  <tr>
			<td><input type="checkbox" /></td>
			<td>17001</td>
			<td>�鿴����</td>
			<td>����Ȩ��</td>
			<td>Ȩ������������Ȩ��������Ȩ������������Ȩ������������Ȩ������������Ȩ������������</td>
			<td>2017-08-19</td>
			<td><a href="#">�༭</a><a href="#">ɾ��</a></td>
		  </tr>
		  <tr>
			<td><input type="checkbox" /></td>
			<td>17001</td>
			<td>�鿴����</td>
			<td>����Ȩ��</td>
			<td>Ȩ������������Ȩ������������Ȩ������������Ȩ������������Ȩ������Ȩ������������Ȩ������������Ȩ������������Ȩ������������Ȩ������������</td>
			<td>2017-08-19</td>
			<td><a href="#">�༭</a><a href="#">ɾ��</a></td>
		  </tr>
		  <tr>
			<td><input type="checkbox" /></td>
			<td>17001</td>
			<td>�鿴����</td>
			<td>����Ȩ��</td>
			<td>Ȩ������������Ȩ������Ȩ������������Ȩ������������Ȩ������������Ȩ������������</td>
			<td>2017-08-19</td>
			<td><a href="#">�༭</a><a href="#">ɾ��</a></td>
		  </tr>
		  <tr>
			<td><input type="checkbox" /></td>
			<td>17001</td>
			<td>�鿴����</td>
			<td>����Ȩ��</td>
			<td>Ȩ������������Ȩ������������Ȩ������������Ȩ������������Ȩ������������Ȩ������������Ȩ������������Ȩ������������Ȩ������������Ȩ������������</td>
			<td>2017-08-19</td>
			<td><a href="#">�༭</a><a href="#">ɾ��</a></td>
		  </tr>
		  <tr>
			<td><input type="checkbox" /></td>
			<td>17001</td>
			<td>�鿴����</td>
			<td>����Ȩ��</td>
			<td>Ȩ������������Ȩ������������Ȩ������������Ȩ������������Ȩ������������Ȩ������������Ȩ������������Ȩ������������Ȩ������������Ȩ������������</td>
			<td>2017-08-19</td>
			<td><a href="#">�༭</a><a href="#">ɾ��</a></td>
		  </tr>
		 </table>
		<p class="endpages"><a href="#">1</a><a href="#">2</a><a href="#">3</a><a href="#">4</a><a href="#">...</a><a href="#">49</a><a href="#">��һҳ</a><span>����<input type="text" />ҳ<button>ȷ��</button></span></p>
	</div>
	<!--����003����-->
</body>
</html>	

<script type="text/javascript">
    // �ٶȵ�ͼAPI����
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
		var xAxisData1 = res; //x������
		var xAxisData2 = res2;
		var yAxisData = res1; //y������

	
	// ָ��ͼ��������������
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
		        data:['ʵʱ���г������仯', 'ʵʱ���г������仯'],
		        textStyle: {  
		            color: '#fff',          //legend������ɫ 
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
	            emphasis:{//����ʱ
	                iconStyle:{
	                    borderColor:"white"//ͼ�ε������ɫ
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
		        // �����������Ƿ���ʾ
			        splitLine: {
			                show: false, 
			                //  �ı�������ɫ
			                lineStyle: {
			                    // ʹ����ǳ�ļ��ɫ
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
		           name : '������V/h',
		           axisLabel: {        
		                show: true,
		                textStyle: {
		                    color: '#fff',
		                    fontSize:'20'
		                }
		            },
		        // �����������Ƿ���ʾ
			        splitLine: {
			                show: false, 
			                //  �ı�������ɫ
			                lineStyle: {
			                    // ʹ����ǳ�ļ��ɫ
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
		           name : '������V/h',
		           axisLabel: {        
		                show: true,
		                textStyle: {
		                    color: '#fff',
		                    fontSize:'20'
		                }
		            },
		        // �����������Ƿ���ʾ
			        splitLine: {
			                show: false, 
			                //  �ı�������ɫ
			                lineStyle: {
			                    // ʹ����ǳ�ļ��ɫ
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
		            name:"ʵʱ���г������仯",
		            type:'bar',
		            //stack:'one',
		            data:yAxisData,
		            markPoint : {
			                data : [
			                    {type : 'max', name: '���ֵ'},
			                    {type : 'min', name: '��Сֵ'}
			                ]
			            },
			            markLine : {
			                data : [
			                    {type : 'average', name: 'ƽ��ֵ'}
			                ]
			            }
		            
		       },
		       {
		            name:"ʵʱ���г������仯",
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
			                    {type : 'max', name: '���ֵ'},
			                    {type : 'min', name: '��Сֵ'}
			                ]
			            },
			            markLine : {
			                data : [
			                    {type : 'average', name: 'ƽ��ֵ'}
			                ]
			            }
		            
		       },
		       
		  ]
		};

 var option2 = {
				title: {
			        text: '',   
			        textstyle:{
			            fontWeight: 'normal',              //������ɫ
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
			        data:['ÿ�������г������仯', 'ÿ�������г������仯'],
			        textStyle: {  
			            color: '#fff',          //legend������ɫ 
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
			        emphasis:{//����ʱ
			            iconStyle:{
			                borderColor:"white"//ͼ�ε������ɫ
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
			        // �����������Ƿ���ʾ
				        splitLine: {
				                show: false, 
				                //  �ı�������ɫ
				                lineStyle: {
				                    // ʹ����ǳ�ļ��ɫ
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
			            name: '������V/h',
			            axisLabel: {        
			                show: true,
			                textStyle: {
			                    color: '#fff',
			                    fontSize:'20'
			                }
			            },
			            // �����������Ƿ���ʾ
			            splitLine: {
			                    show: false, 
			                    //  �ı�������ɫ
			                    lineStyle: {
			                        // ʹ����ǳ�ļ��ɫ
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
			            name: '������V/h',
			            axisLabel: {        
			                show: true,
			                textStyle: {
			                    color: '#fff',
			                    fontSize:'20'
			                }
			            },
			            // �����������Ƿ���ʾ
			            splitLine: {
			                    show: false, 
			                    //  �ı�������ɫ
			                    lineStyle: {
			                        // ʹ����ǳ�ļ��ɫ
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
			            name:'ÿ�������г������仯',
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
			                    {type : 'max', name: '���ֵ'},
			                    {type : 'min', name: '��Сֵ'}
			                ]
			            },
			            markLine : {
			                data : [
			                    {type : 'average', name: 'ƽ��ֵ'}
			                ]
			            }
			        },
			        {
			            name:'ÿ�������г������仯',
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
			                    {type : 'max', name: '���ֵ'},
			                    {type : 'min', name: '��Сֵ'}
			                ]
			            },
			            markLine : {
			                data : [
			                    {type : 'average', name: 'ƽ��ֵ'}
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
			width : 0,     // ��Ϣ���ڿ��
			height: 0,     // ��Ϣ���ڸ߶�
			title : "<span style='font-size:20px;color:#0099cc;background-color:#FFFFFF'>"+"������Ϣ����"+"</span>" , // ��Ϣ���ڱ���
			enableMessage:true//����������Ϣ�����Ͷ�Ϣ
		   };   
	getUnmans();
	setInterval("getUnmans()",60000) ;//�趨ÿһ����ˢ��һ��
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
			        var marker = new BMap.Marker(point,{ // ������ע��
							icon: icon
							});		
				 	map.addOverlay(marker); //��ӱ�ע
					//var label = new window.BMap.Label(data.drones[i].code, {offset: new window.BMap.Size(20, -10)}); //������ǩ   
                    var label = new window.BMap.Label("���˻����:"+data.drones[i].code,{offset: new window.BMap.Size(20, -10)});  // �����ı���ע����
		                label.setStyle({
			                  color : "#0099cc",
			                  fontSize : "20px",
			                  backgroundColor :"0.05",
			                  border:"0",			                  
			                  lineHeight : "20px",
			                  fontWeight :"bold" //����Ӵ�
		                 });
		            marker.setLabel(label);  //��ӱ�ǩ
		            (function(){
		             	var droneId = data.drones[i].droneId;
			            var thepoint = data.drones[i]; 
			           
			            marker.addEventListener("click", function (){
			            //map.panTo(point);		            
						showInfo(this, thepoint);//������Ϣ����
						
						test(droneId);
						
						getEcharts1(droneId);
						getEcharts2(droneId);
						var vlc = document.getElementById("vlc"); 
						var id = 0; 
						//id = vlc.playlist.add(videoUrl); //���mrl�������б�
						id = vlc.playlist.add("rtsp://184.72.239.149/vod/mp4://BigBuckBunny_175k.mov"); //���mrl�������б�						
						vlc.playlist.playItem(id);  //���Ų����б��������
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
					"<p style='margin:0;line-height:1.5;font-size:20px;text-indent:0em'>���˻���ţ� "+point.code+"<br/>���ȣ�"+point.longitude+" γ�ȣ�"+point.latitude+"</br>ѩ��Ԥ���ȼ��� 2</br>״̬�� 0</p>";
					 var infoWindow = new BMap.InfoWindow(content, opts);
					 thisMarker.openInfoWindow(infoWindow);
			       }	
			       function getEcharts1(droneId){
			              clearInterval(app1);
			              var app1 = {};
			              var lastData = 0;
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
						          
						          lastData = data.ts;
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
						    data1.push(0); 
						    option1.xAxis[0].data.shift();
				    		option1.xAxis[0].data.push(axisData);
				    		option1.xAxis[1].data.shift();
                            option1.xAxis[1].data.push(app1.count++);				    		
				    		myChart1.setOption(option1);
						  // ��̬���ݽӿ� addData
					      /* myChart1.addData([
					        [
					            0,        // ϵ������
					            lastData, // ��������
					            false,     // ���������Ƿ�Ӷ���ͷ������
					            false,    // �Ƿ����Ӷ��г��ȣ�false���Զ�ɾ��ԭ�����ݣ���ͷ����ɾ��β����β����ɾ��ͷ
					            axisData //��������
					        ]		       
						  ]); */
						}, 3000);
				     } 
				     
				     function getEcharts2(droneId){
			     		  clearInterval(app2);
			     		  var app2 = {};
			     		  var lastData1=0;
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
						          lastData1 = data.carNum;
						          //lastData = Math.round(Math.random() * 1000);
						        
						          }
						      }
						  }); 
  
						    
						    var axisData1;
						    axisData1 = (new Date()).toLocaleTimeString().replace(/^\D*/, ''); 
						    var data3 = option2.series[0].data;
						    var data4 = option2.series[1].data;
						    data3.shift();
						    data3.push(lastData1);
						    data4.shift();
						    data4.push(0);
						    option2.xAxis[0].data.shift();
				    		option2.xAxis[0].data.push(axisData1);
				    		option2.xAxis[1].data.shift();
                            option2.xAxis[1].data.push(app2.count++);				    		
				    		myChart2.setOption(option2);
						  // ��̬���ݽӿ� addData
					      /* myChart1.addData([
					        [
					            0,        // ϵ������
					            lastData, // ��������
					            false,     // ���������Ƿ�Ӷ���ͷ������
					            false,    // �Ƿ����Ӷ��г��ȣ�false���Զ�ɾ��ԭ�����ݣ���ͷ����ɾ��β����β����ɾ��ͷ
					            axisData //��������
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
           	data:{droneId:droneId, type:3,inputStream:"D:\\test\\MOV_0030.MOV"},
//			data:{droneId:droneId, type:3,inputStream:"D:\\test\\total_Receive_HDMI.h264"},
//			data:{droneId:droneId, type:3,inputStream:"rtsp://47.94.19.230:10554/gzrtsp.sdp"},

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
	
	
	/*��ҳ�û���ѯ���� */
	//ȫ�ֱ���
	var currentPage;
	var totalPage;
	var isInit = false;
	/* *
	 * @brief ����ҳҪ���ѯ�û�
	 * @params data ��Ų�ѯ�����û�������û�����json 
	 * @return null
	 * */
	function queryUser(data){
		//����б�
		$("#usertable").empty();	
		//�õ������json��������飬���磺{{"Id":"1","Name":"nick"....},{"Id":"2","Name":"barry"...}}
		data = data.rows;
		var tr = '<th scope="col" width="300">ID</th>' +
			'<th scope="col">�û���</th>' +
			'<th scope="col">��ʵ����</th>' +
			'<th scope="col">����</th>' +
			'<th scope="col">��ɫ</th>' +
			'<th scope="col">�˺�״̬</th>' +
			'<th scope="col">ע��ʱ��</th>' +
			'<th scope="col">����ѡ��</th>';
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
			tr += "<td><a href='#' onclick='modifyUser(this)'>�༭</a><a href='#' onclick='deleteUser(this)'>ɾ��</a></td>";   
			  										
			$("#usertable").append("<tr>"+tr+"</tr>");			
									
		});
	}
	
	/* *
	 * @brief ����ҳ����ʾ
	 * @params currentPage �����ҳ��
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
	 * @brief ��ʼ��ҳ��ؼ�
	 * @params  totalCntOfUser �û���������
	 * @return null
	 * */
	function initPage(totalCntOfUser){
		//�ж��Ƿ��ʼ����ҳ���ؼ�
		if(isInit){
			return;
		}
		isInit = true;
		
		totalPage = Math.ceil(totalCntOfUser / 10);
		var aLabel = '';
		if (totalPage >= 3) {
			aLabel += '<a class="change_page" href="#">��һҳ</a>'
			aLabel += '<a class="change_page" href="#">1</a>';
			aLabel += '<a href="#">...</a>';
			aLabel += '<a class="change_page" href="#">'+totalPage+'</a>';
			aLabel += '<a class="change_page" href="#">��һҳ</a><span>����<input id="switch_page" type="text" />ҳ<button id="confirm_page">ȷ��</button></span>'
			$("#user").append(aLabel);
		} else {
			aLabel += '<a class="change_page" href="#">��һҳ</a>'
			for(var i = 1; i <= totalPage; i++){
				aLabel += '<a class="change_page" href="#">'+i+'</a>';
			}
			aLabel += '<a class="change_page" href="#">��һҳ</a><span>����<input id="switch_page" type="text" />ҳ<button id="confirm_page">ȷ��</button></span>'
			$("#user").append(aLabel);
		}
		$(".change_page").click(function(){
			var temp = $(this).text();
			if(temp == "��һҳ" && currentPage > 1){
				currentPage--;
			} else if(temp == "��һҳ" && currentPage < totalPage){
				currentPage++;
			} else if(temp != "��һҳ" && temp != "��һҳ"){
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
	
	/*����û����� */
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
				//�޸��û���Ϣ
				$('#new_user_form').form({
					url:'/droneSystem/servlet/UserServlet.do?method=2',
					success:function(data){			
						console.log(data);		   			
					},
				});
				break;
		}
		//���ش���
		$("#new_user").css("display","none");
	}
	
	/*�༭�û���Ϣ�Ĺ���*/
	function modifyUser(element){
		var userId = $(element).parent().parent().find(".user_id").text();
		$("#new_user").css("display","block");
		$("#submit_btn").attr("value",""+userId);
		$("input[name='Id']").attr("value",""+userId);
	}
	
	/*ɾ���û��Ĺ���*/
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

