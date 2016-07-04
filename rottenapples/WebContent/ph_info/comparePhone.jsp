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
String phone1 = request.getParameter("p1");
String phone2 = request.getParameter("p2");

PhoneBean p1_info = pdao.getPhoneInfo(phone1);
PhoneBean p2_info = pdao.getPhoneInfo(phone2);
ArrayList<Integer> comInt = pdao.comparePhone(p1_info, p2_info);

ArrayList<PhCommentBean> comments1 = pcdao.getCommentList(phone1, 1, 10);
ArrayList<PhCommentBean> comments2 = pcdao.getCommentList(phone2, 1, 10);

JSONArray arr = new JSONArray();

//date형식을 String으로
Date from1 = p1_info.getRelease_date();
SimpleDateFormat transFormat = new SimpleDateFormat("yyyy-MM-dd");
String to1 = transFormat.format(from1);

Date from2 = p2_info.getRelease_date();
SimpleDateFormat transFormat2 = new SimpleDateFormat("yyyy-MM-dd");
String to2 = transFormat2.format(from2);

JSONObject p1Obj = new JSONObject(); // 1번 폰정보 객체  arr[0]
  p1Obj.put("cn", p1_info.getCode_name());
  p1Obj.put("pn", p1_info.getPhone_name());
  p1Obj.put("mf", p1_info.getManufacturer());
  p1Obj.put("ds", p1_info.getDisplay_size());
  p1Obj.put("rs", p1_info.getResolution());
  p1Obj.put("os", p1_info.getOs());
  p1Obj.put("cpu", p1_info.getCpu());
  p1Obj.put("ram", p1_info.getRam());
  p1Obj.put("bc", p1_info.getBattery_capacity());
  p1Obj.put("we", p1_info.getWeight());
  p1Obj.put("rd", to1);
  p1Obj.put("il", p1_info.getImg_location());
  p1Obj.put("ra", pcdao.getRottenApples(phone1));
  arr.add(p1Obj);
JSONObject p2Obj = new JSONObject(); // 2번 폰정보 객체  arr[1]
  p2Obj.put("cn", p2_info.getCode_name());
  p2Obj.put("pn", p2_info.getPhone_name());
  p2Obj.put("mf", p2_info.getManufacturer());
  p2Obj.put("ds", p2_info.getDisplay_size());
  p2Obj.put("rs", p2_info.getResolution());
  p2Obj.put("os", p2_info.getOs());
  p2Obj.put("cpu", p2_info.getCpu());
  p2Obj.put("ram", p2_info.getRam());
  p2Obj.put("bc", p2_info.getBattery_capacity());
  p2Obj.put("we", p2_info.getWeight());
  p2Obj.put("rd", to2);
  p2Obj.put("il", p2_info.getImg_location());
  p2Obj.put("ra", pcdao.getRottenApples(phone2));
  arr.add(p2Obj);

//두 폰 비교 리턴값 리스트를 arr[2]에 넣음  
JSONObject comObj = new JSONObject();
  comObj.put("coDis",comInt.get(0));
  comObj.put("coResol",comInt.get(1));
  comObj.put("coOs",comInt.get(2));
  comObj.put("coCpu",comInt.get(3));
  comObj.put("coRam",comInt.get(4));
  comObj.put("coBat",comInt.get(5));
  comObj.put("coWe",comInt.get(6));
  arr.add(comObj);
//첫번째 폰 코멘트 10개를 얻어서 arr3번부터 arr12번까지 넣음

JSONArray p1coms = new JSONArray();
for(PhCommentBean e : comments1){
  JSONObject obj = new JSONObject();
  Timestamp from3 = e.getDate();
  SimpleDateFormat transFormat3 = new SimpleDateFormat("yyyy-MM-dd");
  String to3 = transFormat.format(from2);
  obj.put("nick_name", e.getNick_name());
  obj.put("content", e.getContent());
  obj.put("isLike", e.getIsLike());
  obj.put("date", to3);
  p1coms.add(obj);
} 
arr.add(p1coms);
//두번째 폰 코멘트 10개를 얻어서 arr13번부터 arr22번까지 넣음
JSONArray p2coms = new JSONArray();
for(PhCommentBean e : comments2){
  JSONObject obj2 = new JSONObject();
  Timestamp from4 = e.getDate();
  SimpleDateFormat transFormat4 = new SimpleDateFormat("yyyy-MM-dd");
  String to4 = transFormat.format(from2);
  obj2.put("nick_name", e.getNick_name());
  obj2.put("content", e.getContent());
  obj2.put("isLike", e.getIsLike());
  obj2.put("date", to4);
  p2coms.add(obj2);
} 
arr.add(p2coms);
%>
<%=arr%>
