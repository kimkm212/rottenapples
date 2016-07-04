<%@ page language="java" contentType="application/json; charset=UTF-8" pageEncoding="UTF-8"
	import ="phoneBoard.PhoneBean,
			 ph_comment.PhCommentBean,
			 java.util.ArrayList,
			 java.sql.Date,
			 java.sql.Timestamp,
			 java.text.SimpleDateFormat,
			 org.json.simple.JSONArray,
			 org.json.simple.JSONObject"%>
<jsp:useBean id="pc" class="ph_comment.PhCommentBean"/>
<jsp:useBean id="pcdao" class="ph_comment.PhCommentDAO"/>
<%
	String code_name = request.getParameter("code_name");
	int Cpage = Integer.parseInt(request.getParameter("page"));
	
	ArrayList<PhCommentBean> comments = pcdao.getCommentList(code_name, Cpage, 10);
		
	JSONArray arr = new JSONArray();
	
	for(PhCommentBean e : comments){
		JSONObject obj = new JSONObject();
		Timestamp from = e.getDate();
		SimpleDateFormat transFormat = new SimpleDateFormat("yyyy-MM-dd");
		String to = transFormat.format(from);
		obj.put("nick_name", e.getNick_name());
		obj.put("content", e.getContent());
		obj.put("isLike", e.getIsLike());
		obj.put("date", to);
		arr.add(obj);
	 }
%>
<%=arr%>