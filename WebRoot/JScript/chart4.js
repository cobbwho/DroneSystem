$(function(){	
	var myChart2 = echarts.init(document.getElementById('echarts2'));
	var now = new Date();
	var len = 10;
	var res = [];
	while (len--) {
	res.unshift(now.toLocaleTimeString().replace(/^\D*/,''));
	    now = new Date(now - 2000);
	}
	var res1 = [];
	var res2 = [];
	var len = 10;
	while (len--) {
	    res1.push(0);
	  
	}
	var xAxisData = res; //x轴数据
	var yAxisData = res1; //y轴数据
	
	// 指定图表的配置项和数据
	var option1 = {
	title : {
	    text: '流量变化情况'
	},
	tooltip : {
	    trigger: 'axis'
	    },
	    legend: {
	        data:['车流量']
	    },
	    toolbox: {
	        show : true,
	        feature : {
	            dataView : {show: true, readOnly: false},
	            magicType : {show: true, type: ['line', 'bar']},
	            restore : {show: true},
	            saveAsImage : {show: true}
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
	            boundaryGap : true,
	            data:xAxisData
	        }
	   ],
	   yAxis : [
	      {
	           type : 'value',
	           scale: true,
	           name : '车流量V/h',
	           boundaryGap: [0.2, 0.2]
	      }
	  ],
	  series : [
	       {
	            name:'车流量',
	            type:'line',
	            lineStyle: {
	            normal: {
	              //color: '#4F2F4F',
	              width: 2
	              //type: solid
	            },
	            },
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
	            
	       }
	  ]
	};
	
	var option2 = {
			title : {
			    text: '流量变化情况'
			},
			tooltip : {
			        trigger: 'axis'
			    },
			    legend: {
			        data:['车流量']
			    },
			    toolbox: {
			        show : true,
			        feature : {
			            dataView : {show: true, readOnly: false},
			            magicType : {show: true, type: ['line', 'bar']},
			            restore : {show: true},
			            saveAsImage : {show: true}
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
			            boundaryGap : true,
			            data:xAxisData
			        }
			   ],
			   yAxis : [
			      {
			           type : 'value',
			           scale: true,
			           name : '车流量V/h',
			           boundaryGap: [0.2, 0.2]
			      }
			  ],
			  series : [
			       {
			            name:'车流量',
			            type:'line',
			            lineStyle: {
			            normal: {
			              //color: '#4F2F4F',
			              width: 2
			              //type: solid
			            },
			            },
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
			            
			       }
			  ]
			};
	
	

	myChart2.setOption(option2);
	
	   
})