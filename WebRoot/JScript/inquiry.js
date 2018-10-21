
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

    

 

 

    /* ��һ��ͼ�� */

    

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
        		            data:y_data1,
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
        		            
        		            data:y_data2, 
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
        });

    }

 

    /* �ڶ���ͼ�� */

    // ����ͼ

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
		        data:['ѩ����'],
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
		           name : 'ѩ����M',
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
		            name:"ѩ����",
		            type:'bar',
		            //stack:'one',
		            data:y_data,
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
        }, true);

    }

 

    /* ������ͼ�� */

    // ����ͼ

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
		            data:y_data,
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

        }, true);

    }

    

    

    

    /* ���ĸ�ͼ�� */

    // ����׼���õ�dom����ʼ��echartsʵ��

    var dChart = echarts.init(document.getElementById('infraredechart'),'blue');

    // ָ��ͼ��������������

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
		            data:y_data,
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


