<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:useBean id="mdao" class="member.MemberDAO"/>
<%
request.setCharacterEncoding("utf-8");
String getEmail=request.getParameter("email");
String getPass=request.getParameter("password");
int check = mdao.deleteMember(getEmail, getPass);
%>
<!DOCTYPE HTML>
<html>
	<head>
		<meta charset=UTF-8>
		<title>Insert title here</title>
	</head>
    <script>
        if(<%=check%>==-1){
          alert("비밀번호가 틀립니다.");
          history.back();
        }else if(<%=check%>==1){
          <%session.invalidate();%>
          alert("탈퇴 완료");
          location.href="../index.jsp"
        }
      </script>
	<body>
		
	</body>
</html>