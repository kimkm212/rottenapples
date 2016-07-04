<%@ page language="java" contentType="application/json; charset=UTF-8" pageEncoding="UTF-8"
	import ="phoneBoard.PhoneBean,
			 ph_comment.PhCommentBean,
             org.json.simple.JSONArray,
             org.json.simple.JSONObject,
			 java.util.ArrayList,
			 java.sql.Date,
			 java.sql.Timestamp,
			 java.text.SimpleDateFormat"%>
<jsp:useBean id="pdao" class="phoneBoard.PhoneDAO"/>
<jsp:useBean id="pcdao" class="ph_comment.PhCommentDAO"/>
<%
String code_name=request.getParameter("code_name");
PhoneBean pb= pdao.getPhoneInfo(code_name);
ArrayList<PhCommentBean> comments= pcdao.getCommentList(code_name, 1, 10);
JSONArray arr = new JSONArray();

//date형식을 String으로
Date from = pb.getRelease_date();
SimpleDateFormat transFormat = new SimpleDateFormat("yyyy-MM-dd");
String to = transFormat.format(from);

//폰정보를 담아서 arr0번에 담음
JSONObject obj = new JSONObject();
obj.put("code_name", pb.getCode_name());
obj.put("phone_name", pb.getPhone_name());
obj.put("manufacturer", pb.getManufacturer());
obj.put("display_size", pb.getDisplay_size());
obj.put("resolution", pb.getResolution());
obj.put("os", pb.getOs());
obj.put("cpu", pb.getCpu());
obj.put("ram", pb.getRam());
obj.put("battery_capacity", pb.getBattery_capacity());
obj.put("weight", pb.getWeight());
obj.put("release_date", to);
obj.put("img_location", pb.getImg_location());
obj.put("rottenApples", pcdao.getRottenApples(code_name));
obj.put("comCount", pcdao.getComCount(code_name));
arr.add(obj);


//코멘트 10개를 얻어서 arr1번부터 arr10번까지 넣음
 for(PhCommentBean e : comments){
	JSONObject obj2 = new JSONObject();
	Timestamp from2 = e.getDate();
	SimpleDateFormat transFormat2 = new SimpleDateFormat("yyyy-MM-dd");
	String to2 = transFormat.format(from2);
	obj2.put("nick_name", e.getNick_name());
	obj2.put("content", e.getContent());
	obj2.put("isLike", e.getIsLike());
	obj2.put("date", to2);
	arr.add(obj2);
} 

%>
<%=arr%>
