<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
	import="member.MemberBean"%>
<jsp:useBean id="mdao" class="member.MemberDAO"/>
<%
	request.setCharacterEncoding("utf-8");
	String getEmail= request.getParameter("email");
	String getPass= request.getParameter("password");
	int check = mdao.userCheck(getEmail, getPass);
	if(check==1){
		MemberBean mb=mdao.getMember(getEmail);
		session.setAttribute("email", mb.getEmail());
		session.setAttribute("nick_name", mb.getNick_name());
		response.sendRedirect("../index.jsp");
	}
%>
<!-- ------------------------------------------------------------------------- -->
<script>
	if(<%=check%>==2){
		alert("이메일 인증이 되지 않았습니다. 가입하신 이메일을 확인해 주세요.");
		history.back();
  	}else if(<%=check%>==0){
		alert("비밀번호 틀림");
		history.back();
	}else if(<%=check%>==-1){
		alert("아이디 없음");
		history.back();
	}
</script>
