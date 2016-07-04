<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
	import="java.sql.Timestamp" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%request.setCharacterEncoding("utf-8");%>
<jsp:useBean id="hash" class="mail.Sha_256"/>
<jsp:useBean id="gomail" class="mail.goMail"/>
<jsp:useBean id="mb" class="member.MemberBean"/>
<jsp:setProperty property="*" name="mb"/>
<jsp:useBean id="mdao" class="member.MemberDAO"/>
<%
 
	mb.setRegi_date(new Timestamp(System.currentTimeMillis()));
	mb.setLevel(0);
	String receiver = request.getParameter("email");
	String convHash=hash.emailToSHA256(receiver);
    mb.setHash(convHash);
    
	mdao.insertMember(mb);
	int check=gomail.sendMail(receiver);
 %>

 <!-- ------------------------------------------------------------------------------------------------- -->
<script>
	if(<%=check%>==1){
		alert('인증 Email이 발송 되었습니다. 메일을 확인해 주세요');
		location.href="../index.jsp";
	}else{
		alert('Email발송 실패 이메일 주소를 다시 확인해 주세요');
		location.href="../index.jsp";
	}
</script>