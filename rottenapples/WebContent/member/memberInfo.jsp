<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	String sessionName=(String)session.getAttribute("nick_name");
	if(sessionName==null){
		response.sendRedirect("loginForm.jsp");
	}
%>	
<!-- ------------------------------------------------------------------------------------- -->
<!DOCTYPE HTML>
<html>
	<head>
		<meta charset=UTF-8>
		<title>Insert title here</title>
	    <link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css">
    	<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.0/jquery.min.js"></script>
    	<script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>
	</head>
	<body>
		<%=sessionName%>님 로그인 하셨습니다.
		<input type="button" value="로그아웃" onclick="location.href='logout.jsp'"><br>
		<a href="info.jsp">회원정보조회</a> <br>
		<a href="update.jsp">회원정보수정</a> <br>
		<a href="delete.jsp">회원정보삭제</a> <br>
	</body>
</html>