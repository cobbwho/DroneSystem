package com.droneSystem.netMsg;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

public class DateTimeUtils {
	
	public static Date convertString2Date(String dateStr) {
		Calendar c = Calendar.getInstance();
		int year, month, day, hour, min;
		
		year = Integer.parseInt(dateStr.substring(0, 2)) + 2000;
		month = Integer.parseInt(dateStr.substring(2, 4)) - 1;
		day = Integer.parseInt(dateStr.substring(4, 6));
		hour = Integer.parseInt(dateStr.substring(6, 8));
		min = Integer.parseInt(dateStr.substring(8, 10));
		
		c.set(year, month, day, hour, min, 0);
		Date date = c.getTime();
		
		return date;
	}
	
	public static void main(String[] args) {
		DateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		System.out.println(df.format(convertString2Date("1308051430")));
	}
	
}
