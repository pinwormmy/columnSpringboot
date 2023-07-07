package com.study.column.member;

public interface EmailService {
    String sendSimpleMessage(String recipient) throws Exception;

    void sendNewPasswordMessage(String recipient, String newPassword) throws Exception;

    void sendPasswordResetLink(String email, String token) throws Exception;
}
