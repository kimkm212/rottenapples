<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%request.setCharacterEncoding("utf-8");%>
<jsp:useBean id="mb" class="member.MemberBean"/>
<jsp:setProperty property="*" name="mb"/>
<jsp:useBean id="mdao" class="member.MemberDAO"/>
<%int check = mdao.updateMember(mb);%>
<!-- ---------------------------------------------------------------------------------------------- -->
<!DOCTYPE HTML>
<html>
	<head>
		<meta charset=UTF-8>
		<title>Insert title here</title>
	</head>
	<body>
		<script>
			if(<%=check%>==1){
				<%session.setAttribute("nick_name", request.getParameter("nick_name"));%>
				alert('수정 완료');
				location.href='../index.jsp';
			}else {
				alert('오류 발생');
			}
		</script>
	</body>
</html>