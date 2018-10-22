
$(function() {

    $("#trafficbutton").click(function() {

 

        $('#trafficechart').show();

        $('#snowechart').hide();

        $('#infraredechart').hide();

        $('#sandechart').hide();

 

    });

 

    $("#snowbutton").click(function() {

 

        $('#trafficechart').hide();

        $('#infraredechart').hide();

        $('#snowechart').show();

        $('#sandechart').hide();

    });

    $("#sandbutton").click(function(){

 

        $('#trafficechart').hide();

        $('#snowechart').hide();

        $('#infraredechart').hide();

        $('#sandechart').show();

 

    });

    $("#infraredbutton").click(function(){

 

        $('#trafficechart').hide();

        $('#infraredechart').show();

        $('#snowechart').hide();

        $('#sandechart').hide();

 

    });

    

 

 

    /* 第一个图表 */

    

    var aChart = echarts.init(document.getElementById("trafficechart"),'blue');

    function aFun(x_data, y_data1, y_data2) {

        aChart.setOption({
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
        		           // magicType : {show: true,  type:['line', 'bar']},
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
        		        show : true,
        		        start : 0,
        		        end : 50
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
        		                    color:'#FFFFFF',
        		                    width:1
        		                }
        		            },
        		            axisPointer: {
        	                type: 'shadow'
        	                },

        		            boundaryGap : true,
        		            data:x_data
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
        			        max: 20,
                   			min: 0,
        		           boundaryGap: [0.2, 0.2],
        		           
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
        			        max: 20,
                   			min: 0,
        		           boundaryGap: [0.2, 0.2],
        		           
        		      }
        		  ],
        		  series : [
        		       {
        		            name:"实时上行车流量变化",
        		            type:'bar',
        		            //stack:'one',
        		            data:y_data1,
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
        		           // stack:'one',
        		            
        		            data:y_data2, 
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
        });

    }

 

    /* 第二个图表 */

    // 折线图

    var bChart = echarts.init(document.getElementById("snowechart"),'blue');

    function bFun(x_data, y_data) {

        bChart.setOption({

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
		        data:['雪阻量'],
		        textStyle: {  
		            color: '#fff',          //legend字体颜色 
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
		                    color:'#FFFFFF',
		                    width:1
		                }
		            },
		            axisPointer: {
	                type: 'shadow'
	                },

		            boundaryGap : true,
		            data:x_data
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
		           name : '雪阻量M',
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
			        max: 1200,
           			min: 0,
		           boundaryGap: [0.2, 0.2],
		           
		      }
		  ],
		  series : [
		       {
		            name:"雪阻量",
		            type:'bar',
		            //stack:'one',
		            data:y_data,
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
        }, true);

    }

 

    /* 第三个图表 */

    // 折线图

    var cChart = echarts.init(document.getElementById("sandechart"),'blue');

    function cFun(x_data, y_data) {

        cChart.setOption({

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
		        data:['沙阻量'],
		        textStyle: {  
		            color: '#fff',          //legend字体颜色 
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
		                    color:'#FFFFFF',
		                    width:1
		                }
		            },
		            axisPointer: {
	                type: 'shadow'
	                },

		            boundaryGap : true,
		            data:x_data
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
		           name : '沙阻量M^2',
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
			        max: 1200,
           			min: 0,
		           boundaryGap: [0.2, 0.2],
		           
		      }
		  ],
		  series : [
		       {
		            name:"沙阻量",
		            type:'bar',
		            //stack:'one',
		            data:y_data,
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

        }, true);

    }

    

    

    

    /* 第四个图表 */

    // 基于准备好的dom，初始化echarts实例

    var dChart = echarts.init(document.getElementById('infraredechart'),'blue');

    // 指定图表的配置项和数据

    function dFun(x_data,y_data) {

        dChart.setOption({
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
		        data:['沙阻量'],
		        textStyle: {  
		            color: '#fff',          //legend字体颜色 
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
		                    color:'#FFFFFF',
		                    width:1
		                }
		            },
		            axisPointer: {
	                type: 'shadow'
	                },

		            boundaryGap : true,
		            data:x_data
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
		           name : '沙阻量M^2',
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
			        max: 1200,
           			min: 0,
		           boundaryGap: [0.2, 0.2],
		           
		      }
		  ],
		  series : [
		       {
		            name:"沙阻量",
		            type:'bar',
		            //stack:'one',
		            data:y_data,
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
            });

    }

 

    
    var url = '/droneSystem/DroneServlet.do?method=6';
	  var paramData={type:3};
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
        	aFun("[]","[]");
        	bFun("[]","[]");
        	cFun("[]","[]");
        	dFun("[]");
        	

           /* 

            var status = data.returnData.status;

            status.echatX == ''?aFun("[]","[]"):aFun(status.echatX,status.echatY);

            

            var hb = data.returnData.heartBreath;

            if(hb.echatX == ''){

                bFun("[]","[]");

                cFun("[]","[]");

            }else{

                bFun(hb.echatX, hb.echatY);

                cFun(hb.echatX, hb.echatY2);

            }

            

            var move = data.returnData.move;

            dFun(move);

            */

        },

    });

 

});


