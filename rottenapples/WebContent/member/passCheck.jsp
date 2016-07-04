<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:useBean id="mdao" class="member.MemberDAO"/>
<%
	String getEmail=request.getParameter("email");
	String getPass=request.getParameter("password");
	int check = mdao.userCheck(getEmail, getPass);
	out.print(check);
%>
