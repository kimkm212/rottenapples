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
	request.setCharacterEncoding("utf-8");
	String code_name = request.getParameter("code_name");
	String nick_name = request.getParameter("nick_name");
	String content = request.getParameter("content");
	int isLike = Integer.parseInt(request.getParameter("isLike"));
	pc.setCode_name(code_name);
	pc.setNick_name(nick_name);
	pc.setContent(content);
	pc.setIsLike(isLike);
	pc.setDate(new Timestamp(System.currentTimeMillis()));
	
	pcdao.insertComment(pc);
	
	ArrayList<PhCommentBean> comments= pcdao.getCommentList(code_name, 1, 10);
	
	JSONArray arr = new JSONArray();
	
	JSONObject obj = new JSONObject();
	obj.put("rottenApples", pcdao.getRottenApples(code_name));
	obj.put("comCount", pcdao.getComCount(code_name));
	arr.add(obj);
	
	 for(PhCommentBean e : comments){
		JSONObject obj2 = new JSONObject();
		Timestamp from = e.getDate();
		SimpleDateFormat transFormat = new SimpleDateFormat("yyyy-MM-dd");
		String to = transFormat.format(from);
		obj2.put("nick_name", e.getNick_name());
		obj2.put("content", e.getContent());
		obj2.put("isLike", e.getIsLike());
		obj2.put("date", to);
		arr.add(obj2);
	 }
%>
<%=arr%>
