package com.study.column.member;

import com.study.column.mapper.MemberMapper;
import org.junit.jupiter.api.Test;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.Mockito;
import org.springframework.boot.test.context.SpringBootTest;

import static org.junit.jupiter.api.Assertions.assertTrue;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.doNothing;
import static org.mockito.Mockito.when;

@SpringBootTest
public class MemberServiceTest {

    @Mock
    private EmailService emailService;

    @Mock
    private MemberMapper memberMapper;

    @InjectMocks
    private MemberServiceImpl memberService;

    @Test
    public void testFindCredentials() throws Exception {
        String email = "test@example.com";
        Mockito.doAnswer(invocation -> null).when(emailService).sendSimpleMessage(email);

        // Set up the behaviour of the findByEmail and updatePassword methods
        when(memberMapper.findByEmail(any(String.class))).thenReturn(new MemberDTO());
        doNothing().when(memberMapper).updatePassword(any(MemberDTO.class));

        boolean result = memberService.findCredentials(email);

        assertTrue(result);
        // More assertions as per your requirements...
    }
}
