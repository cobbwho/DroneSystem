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
<script type="text/javascript" src="../JScript/chart2.js"></script>
<script type="text/javascript" src="../JScript/json2.js"></script>
<script type="text/javascript" src="http://vjs.zencdn.net/5.18.4/video.min.js"></script>
<title>���ɹ����˻���Ŀ����ϵͳ-ɳ��</title>
</head>
<body>
<script type="text/javascript" src="../Inc/JScript/echarts.min.js" charset="UTF-8"></script>
<script type="text/javascript" src="../Inc/JScript/blue.js" charset="UTF-8"></script>

	<div class="head_area">
		<div class="fleft"><img src="../images/logo.png" /></div>
		<div class="head_left">
		<ul>
			<li><a href="Main.jsp">������Ϣ</a></li>
			<li><a href="Snow.jsp">ѩ����Ϣ</a></li>
			<li><a href="Sand.jsp" class="pagenow">ɳ����Ϣ</a></li>
			<li><a href="javascript:void(0)" onclick="ale()">������Ϣ</a></li>
			<li><a href="Inquiry.jsp">��ѯͳ��</a></li>
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
	<div class="overlay"></div>
	
	<p class="h128box"></p>
	
	<div class="fleft maparea">
		<h5 class="title_sample"><span>ɳ����Ϣ��ͼ</span></h5>
		<div id="allmap" style="width: 2021px; height: 1410px">
		</div>
	</div>
	
	<div class="fleft videoarea">
		<h5 class="title_sample"><span>ɳ����Ƶ</span></h5>
		<div id="video" style="width:2500px;height:1410px">
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
        <param name='mrl' value='rtsp://184.72.239.149/vod/mp4://BigBuckBunny_175k.mov' />
        <param name='volume' value='50' />
        <param name='autoplay' value='false' />
        <param name='loop' value='false' />
        <param name='fullscreen' value='false' />
    </object>
		</div>
		</div>
	</div>
	
	<div class="fleft timesarea">
		<h5 class="title_sample"><span>ʵʱɳ��仯���</span></h5>
		<div id="echarts1" style="width:960px;height:616px"></div>
	</div>
	<div class="fleft montharea">
		<h5 class="title_sample"><span>��ǰɳ���ܺ�</span></h5>
		<div id="echarts2" style="width:960px;height:616px"></div>
	</div>
	<div class="myclear"></div>
	
	<!--����001-->
	<div class="userlist" id="userlist">
		<h5 class="title_sample"><span>�û��б�</span><a id="userlist_close" href="javascript:void(0)" onclick="closeUserlist()"><img src="../images/cross.png" /></a></h5>
		<div class="fleft sousuolf"><a href="#"><img src="../images/addperson.png" /></a><a href="#"><img src="../images/delectperson.png" /></a></div>
		<div class="fright sousuort"><input type="text" /><button><img src="../images/searchicon.png" /></button></div>
		<div class="myclear"></div> 
		<!-------ÿҳ112������-------->
		<table width="100%" border="0" cellpadding="0" cellspacing="0" class="person_name">
		  <tr>
			<th scope="col" width="140">&nbsp;</th>
			<th scope="col">ID</th>
			<th scope="col">�û���</th>
			<th scope="col">��ʵ����</th>
			<th scope="col">����</th>
			<th scope="col">��ɫ</th>
			<th scope="col">�˺�״̬</th>
			<th scope="col">ע��ʱ��</th>
			<th scope="col">����ѡ��</th>
		  </tr>
		  <tr>
			<td><input type="checkbox" /></td>
			<td>17001</td>
			<td>33dfadsfd</td>
			<td>������</td>
			<td>��Ʋ���</td>
			<td>��ͨ����Ա</td>
			<td>����</td>
			<td>2017-05-22</td>
			<td><a href="#">�༭</a><a href="#">ɾ��</a></td>
		  </tr>
		   <tr>
			<td><input type="checkbox" /></td>
			<td>17001</td>
			<td>33dfadsfd</td>
			<td>������</td>
			<td>��Ʋ���</td>
			<td>��ͨ����Ա</td>
			<td>����</td>
			<td>2017-05-22</td>
			<td><a href="#">�༭</a><a href="#">ɾ��</a></td>
		  </tr>
		   <tr>
			<td><input type="checkbox" /></td>
			<td>17001</td>
			<td>33dfadsfd</td>
			<td>������</td>
			<td>��Ʋ���</td>
			<td>��ͨ����Ա</td>
			<td>����</td>
			<td>2017-05-22</td>
			<td><a href="#">�༭</a><a href="#">ɾ��</a></td>
		  </tr>
		   <tr>
			<td><input type="checkbox" /></td>
			<td>17001</td>
			<td>33dfadsfd</td>
			<td>������</td>
			<td>��Ʋ���</td>
			<td>��ͨ����Ա</td>
			<td>����</td>
			<td>2017-05-22</td>
			<td><a href="#">�༭</a><a href="#">ɾ��</a></td>
		  </tr>
		   <tr>
			<td><input type="checkbox" /></td>
			<td>17001</td>
			<td>33dfadsfd</td>
			<td>������</td>
			<td>��Ʋ���</td>
			<td>��ͨ����Ա</td>
			<td>����</td>
			<td>2017-05-22</td>
			<td><a href="#">�༭</a><a href="#">ɾ��</a></td>
		  </tr>
		   <tr>
			<td><input type="checkbox" /></td>
			<td>17001</td>
			<td>33dfadsfd</td>
			<td>������</td>
			<td>��Ʋ���</td>
			<td>��ͨ����Ա</td>
			<td>����</td>
			<td>2017-05-22</td>
			<td><a href="#">�༭</a><a href="#">ɾ��</a></td>
		  </tr>
		   <tr>
			<td><input type="checkbox" /></td>
			<td>17001</td>
			<td>33dfadsfd</td>
			<td>������</td>
			<td>��Ʋ���</td>
			<td>��ͨ����Ա</td>
			<td>����</td>
			<td>2017-05-22</td>
			<td><a href="#">�༭</a><a href="#">ɾ��</a></td>
		  </tr>
		   <tr>
			<td><input type="checkbox" /></td>
			<td>17001</td>
			<td>33dfadsfd</td>
			<td>������</td>
			<td>��Ʋ���</td>
			<td>��ͨ����Ա</td>
			<td>����</td>
			<td>2017-05-22</td>
			<td><a href="#">�༭</a><a href="#">ɾ��</a></td>
		  </tr>
		   <tr>
			<td><input type="checkbox" /></td>
			<td>17001</td>
			<td>33dfadsfd</td>
			<td>������</td>
			<td>��Ʋ���</td>
			<td>��ͨ����Ա</td>
			<td>����</td>
			<td>2017-05-22</td>
			<td><a href="#">�༭</a><a href="#">ɾ��</a></td>
		  </tr>
		   <tr>
			<td><input type="checkbox" /></td>
			<td>17001</td>
			<td>33dfadsfd</td>
			<td>������</td>
			<td>��Ʋ���</td>
			<td>��ͨ����Ա</td>
			<td>����</td>
			<td>2017-05-22</td>
			<td><a href="#">�༭</a><a href="#">ɾ��</a></td>
		  </tr>
		   <tr>
			<td><input type="checkbox" /></td>
			<td>17001</td>
			<td>33dfadsfd</td>
			<td>������</td>
			<td>��Ʋ���</td>
			<td>��ͨ����Ա</td>
			<td>����</td>
			<td>2017-05-22</td>
			<td><a href="#">�༭</a><a href="#">ɾ��</a></td>
		  </tr>
		</table>
		<p class="endpages"><a href="#">1</a><a href="#">2</a><a href="#">3</a><a href="#">4</a><a href="#">...</a><a href="#">49</a><a href="#">��һҳ</a><span>����<input type="text" />ҳ<button>ȷ��</button></span></p>
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
		var now = new Date();
		var len = 10;
		var res = [];
		while (len--) {
		res.unshift(now.toLocaleTimeString().replace(/^\D*/,''));
		    now = new Date(now - 2000);
		}
		var res1 = [];
		//var res2 = [];
		var len = 10;
		while (len--) {
		    res1.push(0);
		  
		}
		var xAxisData = res; //x������
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
		        data:['ɳ����'],
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
		            data:xAxisData
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
		           name : 'ɳ����M^2',
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
			        max: 1200,
           			min: 0,
		           boundaryGap: [0.2, 0.2],
		           
		      }
		  ],
		  series : [
		       {
		            name:"ɳ����",
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
		       }		       
		  ]
		};

    var axisData;
	var lastData = 0;
	clearInterval(app);
	var app = {};
	app.count = 11;
	myChart1.setOption(option1);
    $(window).resize(function(){
       myChart1.resize();
    });
    window.onresize = myChart1.resize();
	
    var opts = {
		width : 0,     // ��Ϣ���ڿ��
		height: 0,     // ��Ϣ���ڸ߶�
		title : "<span style='font-size:20px;color:#0099cc;background-color:#FFFFFF'>"+"ɳ����Ϣ����"+"</span>" , // ��Ϣ���ڱ���
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
			            var thepoint = data.drones[i]; 
			            marker.addEventListener("click", function (){
			            //map.panTo(point);		            
						showInfo(this, thepoint);//������Ϣ����
						test();
						/* videojs("my-video").ready(function(){
							var myPlayer = this;
							myPlayer.play();
						}); */
						getEcharts();
			            });
		            })();
		            		            		           		
				function showInfo(thisMarker,point){
			         //thisMarker.setAnimation(BMAP_ANIMATION_BOUNCE);
			         var content = 
					"<p style='margin:0;line-height:1.5;font-size:20px;text-indent:0em'>���˻���ţ� "+point.code+"<br/>���ȣ�"+point.longitude+" γ�ȣ�"+point.latitude+"</br>ѩ��Ԥ���ȼ��� 2</br>״̬�� 0</p>";
					 var infoWindow = new BMap.InfoWindow(content, opts);
					 thisMarker.openInfoWindow(infoWindow);
			       }	
			       function getEcharts(){
				          app.timeTicket = setInterval(function (){
						  var url = '/droneSystem/DroneServlet.do?method=6';
						  var paramData={type:3,videoId:5};
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
						          
						          //lastData = data.ts;
						          lastData = Math.round(Math.random() * 1000);
						        
						          }
						      }
						  }); 

						    axisData = (new Date()).toLocaleTimeString().replace(/^\D*/, '');
						    var data0 = option1.series[0].data;
						    //var data1 = option1.series[1].data;
						    data0.shift();
						    data0.push(Math.round(Math.random() * 1000));
						    //data1.shift();
						    //data1.push((Math.random() * 10 + 5).toFixed(1) - 0);
						    option1.xAxis[0].data.shift();
				    		option1.xAxis[0].data.push(axisData);
				    		option1.xAxis[1].data.shift();
                            option1.xAxis[1].data.push(app.count++);				    		
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
           	data:{type:2,inputStream:"D:\\test\\SZ.mp4"},
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
             	data:{type:2},
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
			data:{type:2,videoId:videoId},
			success: function(data){
			//alert(videoId);
            //alert(videoId + data.ts);
			}	
		}); 	
	    
	}


</script>

