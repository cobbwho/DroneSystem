package com.droneSystem.netMsg;

import java.io.IOException;
import java.io.InputStream;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;
import java.util.Properties;

public class MapUtils {
	
	public static Map<String,String> getProperties(String path) {
		Properties p = new Properties();
		InputStream inputStream = MapUtils.class.getResourceAsStream(path);
		
		try {
			p.load(inputStream);
		} catch (IOException e1) {
			e1.printStackTrace();
		}
		
		Map<String,String> map = new HashMap<String,String>();
		Iterator<Object> it =p.keySet().iterator();
		String key="";
		while(it.hasNext()){
			key = it.next().toString();
			map.put(key, p.getProperty(key).trim());
		}
		return map;

	}
	
}
