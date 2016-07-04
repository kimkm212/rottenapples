<%@ page language="java" contentType="application/json; charset=UTF-8" pageEncoding="UTF-8"
  import ="phoneBoard.PhoneBean,
           ph_comment.PhCommentBean,
           org.json.simple.JSONArray,
           org.json.simple.JSONObject,
           java.util.ArrayList"%>
<jsp:useBean id="pdao" class="phoneBoard.PhoneDAO"/>
<%
  String getsearch = request.getParameter("search");
  ArrayList<PhoneBean> phoneList = pdao.getSearch(getsearch);
  
  JSONArray arr = new JSONArray();
  for(PhoneBean e: phoneList){
	JSONObject obj = new JSONObject();
    obj.put("img_location", e.getImg_location());
    obj.put("code_name", e.getCode_name());
    obj.put("phone_name", e.getPhone_name());
    obj.put("manufacturer", e.getManufacturer());
    arr.add(obj);
  }
%>

<%=arr%>