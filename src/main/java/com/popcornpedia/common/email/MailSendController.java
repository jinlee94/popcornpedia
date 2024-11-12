package com.popcornpedia.common.email;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.MailSender;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Controller;

@Controller
public class MailSendController {
	@Autowired
	MailSender sender;
	
	@Async("customAsyncExecutor")
	public void sendMail(String member_id, String email) {
		String host = "http://localhost:8080/popcornpedia/user/verifyEmail.do";
		String from = "popcornpedia@gmail.com";
		String to = email;
		String content = "안녕하세요, 팝콘피디아입니다.\n"
				+ "아래 링크를 클릭하여 이메일 인증을 완료해주세요.\n"
				+ host + "?code="+new SHA256().getSHA256(to)+"&id="+member_id;
		SimpleMailMessage message = new SimpleMailMessage();
		message.setTo(to);
		message.setSubject("[팝콘피디아] 이메일 인증 요청 메일입니다.");
		message.setText(content);
		message.setFrom(from);
		sender.send(message);
	}
	
	@Async("customAsyncExecutor")
	public void sendResetPwdMail(String member_id, String email) {
		String host = "http://localhost:8080/popcornpedia/user/resetPassword.go";
		String from = "popcornpedia@gmail.com";
		String to = email;
		String content = "안녕하세요, 팝콘피디아입니다.\n아래 링크를 클릭하여 비밀번호를 변경해주세요.\n"+host+"?id="+member_id;
		
		SimpleMailMessage message = new SimpleMailMessage();
		message.setTo(to);
		message.setSubject("[팝콘피디아] 비밀번호 변경을 위한 메일입니다.");
		message.setText(content);
		message.setFrom(from);
		sender.send(message);
	}
}
