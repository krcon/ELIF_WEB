package com.krcon.elif.batch;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import java.text.SimpleDateFormat;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.HashMap;
import java.util.List;

import com.krcon.elif.common.util.CommonUtils;
import com.krcon.elif.common.util.MailHandler;

import com.krcon.elif.service.MemberService;
import com.krcon.elif.vo.Member;

@Component
public class CommonScheduler {

    @Autowired
    private MemberService memberService;

    @Value("${sys.mail.address}")
    private String mailFrom;
    @Value("${sys.webdomain}")
    private String webdomain;

    @Autowired
    public JavaMailSender mailSender;

    Logger log = LoggerFactory.getLogger(this.getClass());

    /*
     * : 모든 값
     * ? : 설정 없음
     * , : 배열 설정 ex) 1,3,5
     * - : 범위 설정 ex) 3-5
     * / : 특정 값을 기준으로 특정값 마다 반복
     * 
     * 0 0 0 * * * : 매일 00시 00분 00초에 실행
     * 0 0 2 * * MON : 월요일 새벽 2시에 실행
     * 0/30 * * * * ? : 30초 마다 실행
     * 0 44 16 * * * : 매일 오후 4시 44분에 실행, 서울시간으로
     * 0 30 * * * * : 매 시간 30분에 실행
     */
    @Scheduled(cron = "0 10 14 * * *", zone = "Asia/Seoul") // 매일 오후 2시 00분에 실행, 서울시간으로
    public void dormancyEmailSchedule() throws Exception {
        Member memberVO = new Member();
        memberVO.setDormancy_date(-11);

        List<Member> list = memberService.selectMemberDormancy(memberVO);
        for (Member item : list) {

            String nowTime = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy. MM. dd HH:mm"));
            String nowDate = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy년 MM월 dd일"));
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy년 MM월 dd일");

            // 메일 보내기
            HashMap<String, Object> mapMail = new HashMap<String, Object>();
            mapMail.put("user_id", item.getUser_id());
            mapMail.put("user_nm", item.getUser_nm());
            mapMail.put("dormancy_dt", sdf.format(item.getDormancy_dt()));
            mapMail.put("date", nowDate);
            mapMail.put("time", nowTime);
            mapMail.put("domain", webdomain);

            String mailFile = "dormancy";
            MailHandler.getMailSend(mailSender, mailFrom, item.getEmail(), "[계룡 엘리프] 휴면계정 메일 알림", mailFile, mapMail);

            memberService.dormancyEmailMember(item);
        }
    }

    @Scheduled(cron = "0 10 14 * * *", zone = "Asia/Seoul") // 매일 오후 2시 10분에 실행, 서울시간으로
    public void dormancySchedule() throws Exception {
        Member memberVO = new Member();
        memberVO.setDormancy_date(-12);

        List<Member> list = memberService.selectMemberDormancy(memberVO);
        for (Member item : list) {
            memberService.dormancyMember(item);
        }
    }

}
