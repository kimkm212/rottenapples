<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
    import="member.MemberBean"%>
<%request.setCharacterEncoding("utf-8");%>
<jsp:useBean id="mdao" class="member.MemberDAO"/>
<%
  String hashCode = request.getParameter("hash");
  int check = mdao.getHash(hashCode);
  if(check==1){
   MemberBean mb = mdao.getMemberByHash(hashCode);
   session.setAttribute("email", mb.getEmail());
   session.setAttribute("nick_name", mb.getNick_name());
  }
%>
<script>
	if(<%=check%>==1){
		alert('인증이 완료 됐습니다.');
		location.href="../index.jsp";
	}else{
		alert('잘못된 접근입니다');
		location.href="../index.jsp";
	}
</script>
