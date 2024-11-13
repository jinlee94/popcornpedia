package com.popcornpedia.member.controller;

import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.popcornpedia.common.email.MailSendController;
import com.popcornpedia.common.email.SHA256;
import com.popcornpedia.member.dto.MemberDTO;
import com.popcornpedia.member.service.MemberService;

@RestController("memberController")
@RequestMapping("/user")
public class MemberController {

    @Autowired
    private MemberService memberService;

    @Autowired
    private MailSendController mailSendController;

    // 회원가입 작성폼 이동
    @GetMapping(value = "/join")
    public ModelAndView formMember() throws Exception {
        ModelAndView mav = new ModelAndView("/common/join");
        return mav;
    }

    // 회원가입
    @PostMapping(value = "/join.do")
    public ModelAndView insertMember(@ModelAttribute MemberDTO memberDTO) throws Exception {
        ModelAndView mav;
        int result = memberService.insertMember(memberDTO);
        if (result == 1) { // 회원 가입 완료되었으면
            mav = new ModelAndView("/common/welcome");
            // [TODO] 이메일 인증 요청 필요
            // [DONE] 이메일 인증 요청 메일 보내기 (비동기 방식으로 호출되어 뷰 이동과 동시에 실행됨)
            mailSendController.sendMail(memberDTO.getMember_id(), memberDTO.getEmail());
        } else {
            mav = new ModelAndView("/common/error");
        }
        return mav;
    }

    // 중복검사 (아이디, 이메일, 별명 통합)
    @ResponseBody
    @GetMapping(value = "/join/{field}Check")
    public int checkDuplicateField(@PathVariable("field") String field, @RequestParam("value") String value) throws Exception {
        int isDuplicated = 0;
        // 중복검사 유형 확인 (아이디, 이메일 등)
        if (field.equals("id")) { // 아이디 중복검사
            isDuplicated = memberService.checkDuplicateId(value);
        } else if (field.equals("email")) { // 이메일 중복검사
            isDuplicated = memberService.checkDuplicateEmail(value);
        } else if (field.equals("nickname")) { // 닉네임 중복검사
            isDuplicated = memberService.checkDuplicateNickname(value);
        }
        return isDuplicated;
    }

    // 로그인창 이동
    @GetMapping(value = "/login")
    public ModelAndView formLogin() throws Exception {
        ModelAndView mav = new ModelAndView("/common/login");
        return mav;
    }

    // 로그인
    @PostMapping(value = "/login.do")
    public ResponseEntity<String> checkLogin(@RequestBody HashMap<String, Object> loginMap, HttpSession session) throws Exception {
        MemberDTO userDTO = memberService.checkLogin(loginMap);
        if (userDTO != null) {
            // 로그인 성공 시 세션에 사용자 정보 바인딩
            System.out.println(userDTO);
            session.setAttribute("user", userDTO);
            return new ResponseEntity<>(HttpStatus.OK);
        } else {
            return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    // 로그아웃
    @GetMapping(value = "/logout")
    public ModelAndView checkLogout(HttpSession session) throws Exception {
        session.invalidate();
        ModelAndView mav = new ModelAndView("/common/login");
        return mav;
    }

    // 인증 메일 보내기 요청
    @PostMapping(value = "/sendVerificationEmail.do")
    public ResponseEntity<String> sendVerificationEmail(@RequestBody HashMap<String, Object> emailMap) throws Exception {
        String member_id = emailMap.get("member_id").toString();
        String email = emailMap.get("email").toString();
        mailSendController.sendMail(member_id, email);
        return new ResponseEntity<>(HttpStatus.OK);
    }

    // 이메일 인증 확인
    @GetMapping(value = "/verifyEmail.do")
    public ModelAndView verifyEmail(
            @RequestParam("code") String code,
            @RequestParam("id") String member_id,
            HttpSession session
    ) throws Exception {
        ModelAndView mav;
        System.out.println("[MemberController] code : " + code);
        System.out.println("[MemberController] id : " + member_id);
        String userEmail = memberService.getEmailById(member_id);

        // 받아온 id에 저장된 이메일로 해쉬값을 만들어서 요청 url의 code와 같은지 확인
        boolean isRightCode = SHA256.getSHA256(userEmail).equals(code);
        if (isRightCode) {
            memberService.setEmailVerified(member_id);
            MemberDTO userDTO = (MemberDTO) session.getAttribute("user");
            String currentMember_id = null;
            if (userDTO != null) {
                currentMember_id = userDTO.getMember_id();
            }
            if (member_id.equals(currentMember_id)) {
                userDTO.setEmail_verified(true);
                session.setAttribute("user", userDTO);
            }
            System.out.println("[MemberController] 이메일 인증 완료");
            mav = new ModelAndView("/common/verifyEmail");
        } else {
            System.out.println("[MemberController] 이메일 인증 실패");
            mav = new ModelAndView("/common/error");
        }
        return mav;
    }

    // 이메일 바로 인증 처리하기(테스트)
    @GetMapping(value = "/verifyEmailTest.do")
    public ModelAndView verifyEmailTest(@RequestParam("id") String member_id, HttpSession session) throws Exception {
        ModelAndView mav;
        memberService.setEmailVerified(member_id);
        MemberDTO userDTO = (MemberDTO) session.getAttribute("user");
        if (userDTO != null) {
            userDTO.setEmail_verified(true);
            session.setAttribute("user", userDTO);
            System.out.println("[MemberController] 이메일 인증 완료");
            mav = new ModelAndView("redirect:/user/modMyInfo");
        } else {
            System.out.println("[MemberController] 이메일 인증 실패");
            mav = new ModelAndView("/common/error");
        }
        return mav;
    }

    // 이메일로 아이디 찾기
    @PostMapping(value = "/findId.do")
    public String findId(@RequestBody HashMap<String, Object> memberMap) throws Exception {
        String email = memberMap.get("email").toString();
        String member_id = memberService.getIdByEmail(email);
        return member_id; // 존재하지 않으면 null 반환
    }

    // 아이디, 이메일로 비밀번호 변경 메일 보내기
    @PostMapping(value = "/findPwd.do")
    public ResponseEntity<String> findPwd(@RequestBody HashMap<String, Object> memberMap) throws Exception {
        String member_id = memberMap.get("member_id").toString();
        String email = memberMap.get("email").toString();
        int result = memberService.isMemberExistByIdAndEmail(memberMap);
        if (result == 1) { // 회원이 존재하면
            // 이메일 보내기
            mailSendController.sendResetPwdMail(member_id, email);
            return new ResponseEntity<>(HttpStatus.OK);
        } else {
            // 존재하지 않으면 error 리턴
            return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    // 비밀번호 재설정 페이지 가기
    @GetMapping(value = "/resetPassword.go")
    public ModelAndView formResetPwd(@RequestParam("id") String member_id) throws Exception {
        ModelAndView mav;
        mav = new ModelAndView("/member/resetPwd");
        mav.addObject("member_id", member_id);
        return mav;
    }

    // 비밀번호 재설정 요청
    @PostMapping(value = "/resetPassword.do")
    public ModelAndView resetPwd(@ModelAttribute MemberDTO memberDTO) throws Exception {
        ModelAndView mav;
        int result = memberService.resetPwdById(memberDTO);
        if (result == 1) {
            mav = new ModelAndView("/common/resetPwdDone");
        } else {
            mav = new ModelAndView("/common/error");
        }
        return mav;
    }
}
