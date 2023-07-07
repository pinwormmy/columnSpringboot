package com.study.column.member;

import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.MailException;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;

import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import java.util.Random;


@Slf4j
@Service
public class EmailServiceImpl implements EmailService {

    @Autowired
    private JavaMailSender emailSender;

    private MimeMessage createMessage(String recipient, String verificationCode) throws Exception {
        log.info("Recipient: {}", recipient);
        log.info("Verification code: {}", verificationCode);
        MimeMessage message = emailSender.createMimeMessage();
        MimeMessageHelper helper = new MimeMessageHelper(message, true, "utf-8");

        helper.setTo(recipient);
        helper.setSubject("컬럼사이트 이메일 인증");
        helper.setText(generateEmailContent(verificationCode), true);
        helper.setFrom(new InternetAddress("mealchelin@gmail.com", "admin"));

        return message;
    }

    private String generateEmailContent(String verificationCode) {

        return "<div style='margin:20px;'>" +
                "<h2> 안녕하세요 컬럼사이트 이메일 인증입니다. </h2>" +
                "<br>" +
                "<p>아래 코드를 회원가입 이메일 인증칸에 입력해주세요<p>" +
                "<br>" +
                "<p>감사합니다.<p>" +
                "<br>" +
                "<div align='center' style='border:1px solid black; font-family:verdana';>" +
                "<h3 style='color:blue;'>이메일 인증코드</h3>" +
                "<div style='font-size:130%'>" +
                "CODE : <strong>" +
                verificationCode +
                "</strong><div><br/> " +
                "</div>";
    }

    public static String createVerificationCode() {
        StringBuilder key = new StringBuilder();
        Random rnd = new Random();

        for (int i = 0; i < 8; i++) {
            int index = rnd.nextInt(3);

            switch (index) {
                case 0:
                    key.append((char) (rnd.nextInt(26) + 97));
                    break;
                case 1:
                    key.append((char) (rnd.nextInt(26) + 65));
                    break;
                case 2:
                    key.append(rnd.nextInt(10));
                    break;
            }
        }

        return key.toString();
    }

    @Override
    public String sendSimpleMessage(String recipient) throws Exception {
        String verificationCode = createVerificationCode();
        MimeMessage message = createMessage(recipient, verificationCode);

        try {
            emailSender.send(message);
        } catch (MailException e) {
            log.error("Email sending error", e);
            throw new IllegalArgumentException();
        }

        return verificationCode;
    }

    public void sendNewPasswordMessage(String recipient, String newPassword) throws Exception {
        MimeMessage message = createNewPasswordMessage(recipient, newPassword);

        try {
            emailSender.send(message);
        } catch (MailException e) {
            log.error("Email sending error", e);
            throw new IllegalArgumentException();
        }
    }

    @Override
    public void sendPasswordResetLink(String email, String token) throws Exception {
        MimeMessage message = createResetLinkMessage(email, token);

        try {
            emailSender.send(message);
        } catch (MailException e) {
            log.error("Email sending error", e);
            throw new IllegalArgumentException();
        }
    }

    private MimeMessage createResetLinkMessage(String recipient, String token) throws Exception {
        MimeMessage message = emailSender.createMimeMessage();
        MimeMessageHelper helper = new MimeMessageHelper(message, true, "utf-8");

        helper.setTo(recipient);
        helper.setSubject("컬럼사이트에서 보낸 비밀번호 재설정 링크");
        helper.setText(generateResetLinkEmailContent(token), true);
        helper.setFrom(new InternetAddress("mealchelin@gmail.com", "admin"));

        return message;
    }

    private String generateResetLinkEmailContent(String token) {
        String resetUrl = "http://yourwebsite.com/reset-password?token=" + token; // 나중에 설정파일 연동해서 동적 주소로 바꾸기

        return "<h2>컬럼사이트에서 보내드립니다. 비밀번호 재설정 링크입니다</h2>" +
                "<p>아래의 링크를 클릭하여 비밀번호를 재설정해주세요: </p>" +
                "<a href=\"" + resetUrl + "\">비밀번호 재설정하기</a>" +
                "<p>만약 비밀번호 재설정을 요청하지 않으셨다면, 이 이메일을 무시하시면 됩니다.</p>";
    }


    private MimeMessage createNewPasswordMessage(String recipient, String newPassword) throws Exception {
        MimeMessage message = emailSender.createMimeMessage();
        MimeMessageHelper helper = new MimeMessageHelper(message, true, "utf-8");

        helper.setTo(recipient);
        helper.setSubject("컬럼사이트에서 보낸 임시 비밀번호");
        helper.setText(generateNewPasswordEmailContent(newPassword), true);
        helper.setFrom(new InternetAddress("mealchelin@gmail.com", "admin"));

        return message;
    }

    private String generateNewPasswordEmailContent(String newPassword) {

        return "<h2>컬럼사이트에서 보내드립니다. 임시 비밀번호입니다</h2>" +
                "<p>아래의 임시 비밀번호로 로그인 해주세요: <strong>" +
                newPassword +
                "</strong></p>" +
                "<p>로그인 후 반드시 비밀번호를 변경해주세요.</p>";
    }

}