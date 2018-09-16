package com.droneSystem.util;

/**
 * 系统中一些常用字符串的助手类
 * @author zhan
 *
 */
public class SysStringUtil {
	/**
	 * 后台处理前台请求信息返回的ContentType的类型
	 * @author zhan
	 *
	 */
	public static class ResponseContentType{
		public static final String Type_FormSubmit = "text/html;charset=utf-8";	//Form提交时返回信息的ContentType，即response.setContentType("text/html;charset=utf-8");
		public static final String Type_AjaxSubmit = "text/json;charset=utf-8";	//Ajax提交，且前台Ajax需要设置返回的格式为json
		public static final String Type_EasyUIDatagrid = "text/json;charset=utf-8";	//使用easyui datagrid请求数据
		public static final String Type_EasyUICombobox = "text/json;charset=gbk";	//使用easyui combobox请求数据
	}
	
}
