$(function(){
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
		var xAxisData = res; //x轴数据
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
			    trigger: 'axis'
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
			            magicType : {show: true, type: ['line', 'bar']},
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
			                    //color:'ellow',
			                    //width:2
			                }
			            },

			            boundaryGap : true,
			            data:xAxisData
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
			           boundaryGap: [0.2, 0.2]
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
			           boundaryGap: [0.2, 0.2]
			      }
			  ],
			  series : [
			       {
			            name:"实时上行车流量变化",
			            type:'line',
			            
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
			       
			  ]
			};

    myChart1.setOption(option1);
    $(window).resize(function(){
       myChart1.resize();
    });
    window.onresize = myChart1.resize();
	
	
});

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
	          //newcharts();
	          axisData = (new Date()).toLocaleTimeString().replace(/^\D*/, '');
	          lastData = data.ts;
	          //lastData = Math.round(Math.random() * 1000);
	        
	          }
	      }
	  }); 
	  // 动态数据接口 addData
      myChart1.addData([
        [
            0,        // 系列索引
            lastData, // 新增数据
            false,     // 新增数据是否从队列头部插入
            false,    // 是否增加队列长度，false则自定删除原有数据，队头插入删队尾，队尾插入删队头
            axisData //横轴数据
        ]		       
	  ]);

	}, 3000);
	}


