package mail;

import javax.mail.*;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import java.util.Properties;
import mail.Sha_256;

public class goMail {
	
	 public int sendMail(String receiver){
		 
		 Sha_256 hash = new Sha_256();
		 String hashCode = hash.emailToSHA256(receiver);
		 
		 String sender = "kimkm212@naver.com";
		 String subject = "RottenApples 가입인증 메일 입니다.";
		 String content= "안녕하세요<br>"
		 		+ "다음 링크를 누르시면 인증이 완료 됩니다.<br>"
		 		+ "<a href=\"http://192.168.80.234:8080/rottenapples/member/hashAuth.jsp?hash="+hashCode
		 		+"\">www.rottenapples.com</a>"
		 		;
		
		 int result = 0;
		 
		 Properties p = new Properties();
	
		p.put("mail.smtp.user", "kimkm212");
		p.put("mail.smtp.host", "smtp.naver.com");
		p.put("mail.smtp.port", "465");
		p.put("mail.smtp.starttls.enable", "true");
		p.put("mail.smtp.auth", "true");
		p.put("mail.smtp.debug", "true");
		p.put("mail.smtp.socketFactory.port", "465");
		p.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
		p.put("mail.smtp.socketFactory.fallback", "false");
		try {
		    Authenticator auth = new SMTPAuthenticator();
		    Session ses = Session.getInstance(p, auth);
	
		    // 메일을 전송할 때 상세한 상황을 콘솔에 출력한다.
		    ses.setDebug(true);
		        
		    // 메일의 내용을 담기 위한 객체
		    MimeMessage msg = new MimeMessage(ses);
	
		    // 제목 설정
		    msg.setSubject(subject);
		        
		    // 보내는 사람의 메일주소
		    Address fromAddr = new InternetAddress(sender);
		    msg.setFrom(fromAddr);
		        
		    // 받는 사람의 메일주소
		    Address toAddr = new InternetAddress(receiver);
		    msg.addRecipient(Message.RecipientType.TO, toAddr);
		        
		    // 메시지 본문의 내용과 형식, 캐릭터 셋 설정
		    msg.setContent(content, "text/html;charset=UTF-8");
		        
		    // 발송하기
		    Transport.send(msg);
		    
		    result = 1;
		        
		} catch (Exception mex) {
		    mex.printStackTrace();
		    result = 0;
		}
		return result;
 	}
}

