$(function(){

    map.setMapStyle({
    styleJson:[
        {
		"featureType": "land",
		"elementType": "geometry",
		"stylers": {
					"color": "#e7f7fc"
		}
		},
		{
		"featureType": "water",
		"elementType": "all",
		"stylers": {
					"color": "#96b5d6"
		}
		},
	    {
		"featureType": "green",
		"elementType": "all",
		"stylers": {
					"color": "#b0d3dd"
		}
		},
		{
		"featureType": "highway",
		"elementType": "geometry.fill",
		"stylers": {
					"color": "#a6cfcf"
		}
		},
		{
		"featureType": "highway",
		"elementType": "geometry.stroke",
		"stylers": {
					"color": "#7dabb3"
		}
		},
		{
		"featureType": "arterial",
		"elementType": "geometry.fill",
		"stylers": {
					"color": "#e7f7fc"
		}
		},
		{
		"featureType": "arterial",
		"elementType": "geometry.stroke",
		"stylers": {
					"color": "#b0d5d4"
		}
		},
        {
		"featureType": "local",
		"elementType": "labels.text.fill",
		"stylers": {
					"color": "#7a959a"
		}
		},
		{
		"featureType": "local",
		"elementType": "labels.text.stroke",
		"stylers": {
					"color": "#d6e4e5"
		}
		},
		{
		"featureType": "arterial",
		"elementType": "labels.text.fill",
		"stylers": {
					"color": "#374a46"
		}
		},
		{
		"featureType": "highway",
		"elementType": "labels.text.fill",
		"stylers": {
					"color": "#374a46"
		}
		},
		{
		"featureType": "highway",
		"elementType": "labels.text.stroke",
		"stylers": {
					"color": "#e9eeed"
		}
		}
     ]
    });
    //map.enableScrollWheelZoom(true);
    map.centerAndZoom(new BMap.Point(111.755933, 40.848919), 11);                   // 初始化地图,设置城市和地图级别。
    var top_left_control = new BMap.ScaleControl({anchor: BMAP_ANCHOR_TOP_LEFT});// 左上角，添加比例尺
	var top_left_navigation = new BMap.NavigationControl();  //左上角，添加默认缩放平移控件
	map.addControl(top_left_control);        
    map.addControl(top_left_navigation);  
	var ctrl = new BMapLib.TrafficControl({
		showPanel: true //是否显示路况提示面板
	});      
	
	map.addControl(ctrl);
	ctrl.setAnchor(BMAP_ANCHOR_BOTTOM_RIGHT);  
	ctrl.showTraffic({ predictDate: { hour: 15, weekday: 5 } });
	var mapType1 = new BMap.MapTypeControl({mapTypes: [BMAP_NORMAL_MAP,BMAP_HYBRID_MAP]});
	map.addControl(mapType1);          //2D图，卫星图
			
	/*function deletePoint()
    {      //删除所有图钉函数
        var allOverlay = map.getOverlays();
		for (var i = 0; i < allOverlay.length -1; i++){
				map.clearOverlays();  //清除图钉函数
				return false;
		}		  
    }*/
})