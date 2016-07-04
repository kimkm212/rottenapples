<%@page import="java.sql.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("utf-8"); %>
<jsp:useBean id="pb" class="phoneBoard.PhoneBean"/>
<jsp:setProperty property="code_name" name="pb"/>
<jsp:setProperty property="phone_name" name="pb"/>
<jsp:setProperty property="manufacturer" name="pb"/>
<jsp:setProperty property="resolution" name="pb"/>
<jsp:setProperty property="os" name="pb"/>
<jsp:setProperty property="cpu" name="pb"/>
<jsp:setProperty property="img_location" name="pb"/>
<jsp:setProperty property="battery_capacity" name="pb"/>
<jsp:setProperty property="weight" name="pb"/>
<jsp:setProperty property="ram" name="pb"/>
<jsp:setProperty property="display_size" name="pb"/>
<jsp:useBean id="pdao" class="phoneBoard.PhoneDAO"/> 
<%
String date=request.getParameter("release_date");
Date parseDate=java.sql.Date.valueOf(date);
pb.setRelease_date(parseDate);
pdao.insertPhone(pb);
%>

<!DOCTYPE HTML>
<html>
	<head>
		<meta charset=UTF-8>
		<title>Insert title here</title>
		<script>
			location.href="ph_infoWriteForm.jsp";
		</script>
	</head>
	<body>
		<%=pb.getCode_name() %><br>
		<%=pb.getPhone_name() %><br>
		<%=pb.getManufacturer()%><br>
		<%=pb.getDisplay_size() %><br>
		<%=pb.getResolution()%><br>
		<%=pb.getOs() %><br>
		<%=pb.getCpu() %><br>
		<%=pb.getRam() %><br>
		<%=pb.getBattery_capacity() %><br>
		<%=pb.getWeight() %><br>
		<%=pb.getRelease_date()%><br>
		<%=pb.getImg_location()%><br>
	</body>
</html>