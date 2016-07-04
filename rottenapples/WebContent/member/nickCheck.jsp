<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:useBean id="mdao" class="member.MemberDAO"/>
<%
	String getNick=request.getParameter("nick_name");
	int check = mdao.nickCheck(getNick);
	out.print(check);
%>