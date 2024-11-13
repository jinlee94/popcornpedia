package com.popcornpedia.member.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.popcornpedia.board.dto.BoardDTO;
import com.popcornpedia.common.dto.makePagingDTO;
import com.popcornpedia.member.dto.MemberDTO;
import com.popcornpedia.member.service.UserService;
import com.popcornpedia.movie.dto.StarRatingDTO;

@Controller("userController")
public class UserController {


    @Autowired
    private UserService userService;

    // 내 리뷰 보기
    @RequestMapping(value = "/user/myReviews.do")
    public ModelAndView selectMyReviews(HttpServletRequest request, HttpServletResponse response, HttpSession session)
            throws Exception {

        MemberDTO userDTO = (MemberDTO) session.getAttribute("user");

        String member_id = userDTO.getMember_id();
        ModelAndView mav = new ModelAndView("/member/myReviews");
        List reviewlist = userService.selectMyReviews(member_id);
        mav.addObject("reviewList", reviewlist);
        return mav;
    }

    // 마이페이지 가기
    @RequestMapping(value = "/user/myPage.do")
    public ModelAndView myPage(HttpServletRequest request, HttpServletResponse response) throws Exception {

        ModelAndView mav = new ModelAndView("/member/myPage");
        return mav;

    }


    // 유저페이지 가기
    @RequestMapping(value = "/user/userPage")
    public ModelAndView userPage(@RequestParam("nickname") String nickname) throws Exception {

        MemberDTO userDTO = userService.selectUserByNickname(nickname);

        String member_id = userDTO.getMember_id();

        double avgStarCnt = userService.avgMyStarRating(member_id);
        int reviewCnt = userService.countMyReviews(member_id);
        int articleCnt = userService.countMyArticles(member_id);
        int movieLikeCnt = userService.countWishMovie(member_id);

        ModelAndView mav = new ModelAndView("/member/userPage");
        mav.addObject("otherUser", userDTO);
        mav.addObject("avgStarCnt", avgStarCnt);
        mav.addObject("reviewCnt", reviewCnt);
        mav.addObject("articleCnt", articleCnt);
        mav.addObject("movieLikeCnt", movieLikeCnt);
        return mav;
    }


    // 내 게시물 보기
    @RequestMapping(value = "/user/myArticles.do")
    public ModelAndView selectMyArticles(@RequestParam(value = "num", required = false, defaultValue = "1") int num, HttpSession session)
            throws Exception {

        ModelAndView mav = new ModelAndView("/board/listBoard");

        MemberDTO userDTO = (MemberDTO) session.getAttribute("user");
        String member_id = userDTO.getMember_id();
        String nickname = userDTO.getNickname();

        int postNum = 15;
        System.out.println(postNum);

        if (userService.countMyArticles(member_id) == 0) {
            return mav;
        }


        makePagingDTO page = new makePagingDTO(num, userService.countMyArticles(member_id), postNum);

        Map<String, Object> myArticlesMap = new HashMap();

        myArticlesMap.put("member_id", member_id);
        myArticlesMap.put("displayPost", page.getDisplayPost());
        myArticlesMap.put("postNum", page.getPostNum());

        System.out.println(userService.countMyArticles(member_id));
        System.out.println(page.getDisplayPost());

        List boardList = userService.selectMyArticles(myArticlesMap);

        mav.addObject("boardList", boardList);
        mav.addObject("selectPageNum", num);
        mav.addObject("page", page);
        mav.addObject("myArticle", nickname);
        return mav;
    }

    // 유저 게시물 보기
    @RequestMapping(value = "/user/userArticles")
    public ModelAndView selectUserArticles(@RequestParam(value = "num", required = false, defaultValue = "1") int num, @RequestParam(value = "member_id", required = false) String member_id, @RequestParam(value = "nickname", required = false) String nickname) throws Exception {
        ModelAndView mav = new ModelAndView("/board/listBoard");

        int postNum = 15;
        System.out.println(postNum);
        if (nickname != null) {
            MemberDTO userDTO = userService.selectUserByNickname(nickname);
            member_id = userDTO.getMember_id();

        }

        if (userService.countMyArticles(member_id) == 0) {
            return mav;
        }

        makePagingDTO page = new makePagingDTO(num, userService.countMyArticles(member_id), postNum);

        Map<String, Object> myArticlesMap = new HashMap();

        myArticlesMap.put("member_id", member_id);
        myArticlesMap.put("displayPost", page.getDisplayPost());
        myArticlesMap.put("postNum", page.getPostNum());

        System.out.println(userService.countMyArticles(member_id));
        System.out.println(page.getDisplayPost());

        List<BoardDTO> boardList = userService.selectMyArticles(myArticlesMap);

        String nicknameParam = boardList.get(0).getNickname();


        mav.addObject("boardList", boardList);
        mav.addObject("selectPageNum", num);
        mav.addObject("page", page);
        mav.addObject("userArticle", nicknameParam);
        return mav;
    }

    // 내 정보 가기
    @RequestMapping(value = "/user/myInfo")
    public ModelAndView myInfo(HttpServletRequest request, HttpServletResponse response) throws Exception {
        ModelAndView mav = new ModelAndView("/member/myInfo");
        return mav;
    }

    // 내 정보 수정 페이지 가기
    @RequestMapping(value = "/user/modMyInfo")
    public ModelAndView modMyInfo(HttpServletRequest request, HttpServletResponse response) throws Exception {
        ModelAndView mav = new ModelAndView("/member/modMyInfo");
        return mav;
    }


    // 내 정보 수정 요청
    @RequestMapping(value = "/user/updateMyInfo.do")
    public ModelAndView updateMyInfo(@ModelAttribute("memberDTO") MemberDTO memberDTO, HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {
        ModelAndView mav = new ModelAndView("/member/myPage");

        MemberDTO userDTO = userService.updateMyInfo(memberDTO);
        if (userDTO != null) {
            session.setAttribute("user", userDTO);
        }


        return mav;
    }

    // 내 프로필 페이지 가기
    @RequestMapping(value = "/user/myProfile")
    public ModelAndView myProfile(HttpServletRequest request, HttpServletResponse Response) throws Exception {
        ModelAndView mav = new ModelAndView("/member/myProfile");

        return mav;
    }

    // 내 프로필 수정
    @RequestMapping(value = "/user/updateMyProfile")
    public ModelAndView updateMyProfile(@RequestParam("profileImg") MultipartFile file, @ModelAttribute("memberDTO") MemberDTO memberDTO,
                                        @RequestParam(value = "deleteFile", required = false, defaultValue = "false") boolean deleteFile,
                                        HttpSession session) throws Exception {


        MemberDTO userDTO = userService.updateMyProfile(file, memberDTO, deleteFile, session);

        ModelAndView mav = new ModelAndView("/member/myPage");
        if (userDTO != null) {
            session.setAttribute("user", userDTO);
        }


        return mav;
    }

    // 내 별점 페이지
    @RequestMapping(value = "/user/myStarRating.do")
    public ModelAndView myStarRating(HttpServletRequest request, HttpServletResponse Response, HttpSession session)
            throws Exception {

        MemberDTO userDTO = (MemberDTO) session.getAttribute("user");

        String member_id = userDTO.getMember_id();
        List<StarRatingDTO> starRatingList = userService.selectMyStarRatings(member_id);

        ModelAndView mav = new ModelAndView("member/myStarRating");
        mav.addObject("starRatingList", starRatingList);
        return mav;
    }

    // 유저 별점 페이지
    @RequestMapping(value = "/user/userStarRating.do")
    public ModelAndView userStarRating(@RequestParam("member_id") String member_id) throws Exception {
        List<StarRatingDTO> starRatingList = userService.selectMyStarRatings(member_id);

        ModelAndView mav = new ModelAndView("member/myStarRating");
        mav.addObject("starRatingList", starRatingList);
        return mav;
    }


    // 취향분석 페이지
    @RequestMapping(value = "/user/myTaste")
    public ModelAndView myTaste(@RequestParam("nickname") String nickname) throws Exception {

        MemberDTO userDTO = userService.selectUserByNickname(nickname);

        String member_id = userDTO.getMember_id();


        int starCnt = userService.countMyStarRatings(member_id);
        if (starCnt == 0) {
            ModelAndView mav = new ModelAndView("member/myTaste");
            return mav;
        }

        double starAvg = userService.avgMyStarRating(member_id);
        double starMax = userService.maxMyStarRating(member_id);
        // 별점 분석 차트에 쓸 데이터 json 으로 변환
        List<Map<String, Object>> tasteStarData = userService.tasteMyStarRating(member_id);
        ObjectMapper objectMapper = new ObjectMapper();
        String tasteStar = objectMapper.writeValueAsString(tasteStarData);

        List<Map<String, Object>> tasteMovieNation = userService.tasteMovieNation(member_id);
        List<Map<String, Object>> tasteMovieDirector = userService.tasteMovieDirector(member_id);
        List<Map.Entry<String, Integer>> tasteMovieActor = userService.tasteMovieActor(member_id);
        List<Map.Entry<String, Integer>> tasteMovieGenre = userService.tasteMovieGenre(member_id);

        int showTime = userService.countWatchTime(member_id);

        ModelAndView mav = new ModelAndView("member/myTaste");
        mav.addObject("starCnt", starCnt);
        mav.addObject("starAvg", starAvg);
        mav.addObject("starMax", starMax);
        mav.addObject("tasteStar", tasteStar);
        mav.addObject("showTime", showTime);
        mav.addObject("tasteMovieNation", tasteMovieNation);
        mav.addObject("tasteMovieDirector", tasteMovieDirector);
        mav.addObject("tasteMovieActor", tasteMovieActor);
        mav.addObject("tasteMovieGenre", tasteMovieGenre);
        return mav;
    }


    // 마이페이지 나의 리뷰 갯수
    @ResponseBody
    @RequestMapping(value = "/user/countMyReviews.do")
    public int countMyReviews(HttpSession session) throws Exception {
        MemberDTO userDTO = (MemberDTO) session.getAttribute("user");
        String member_id = userDTO.getMember_id();
        int result = userService.countMyReviews(member_id);

        return result;
    }

    // 마이페이지 나의 평균 별점
    @ResponseBody
    @RequestMapping(value = "user/avgMyStarRating.do")
    public double avgMyStarRating(HttpSession session) throws Exception {
        MemberDTO userDTO = (MemberDTO) session.getAttribute("user");
        String member_id = userDTO.getMember_id();
        double result = userService.avgMyStarRating(member_id);
        return result;
    }

    // 마이페이지 나의 게시글 수
    @ResponseBody
    @RequestMapping(value = "user/countMyArticles.do")
    public int countMyArticles(HttpSession session) throws Exception {
        MemberDTO userDTO = (MemberDTO) session.getAttribute("user");
        String member_id = userDTO.getMember_id();
        int result = userService.countMyArticles(member_id);
        return result;
    }

    @ResponseBody
    @PostMapping(value = "/user/updateEmail.do")
    public String updateEmail(@RequestBody HashMap<String, Object> emailMap, HttpSession session) throws Exception {
        userService.updateEmail(emailMap); // 이메일 변경하고 인증 해제
        String email = emailMap.get("email").toString();
        MemberDTO userDTO = (MemberDTO) session.getAttribute("user");
        userDTO.setEmail(email);
        userDTO.setEmail_verified(false);
        session.setAttribute("user", userDTO); // 변경된 유저 정보 세션에 반영
        return email; // 변경한 이메일 return
    }


    //마이페이지 보고싶은 영화 개수
    @ResponseBody
    @RequestMapping(value = "/user/countMyWishMovie.do")
    public int countMyWishMovie(HttpSession session) throws Exception {
        MemberDTO userDTO = (MemberDTO) session.getAttribute("user");
        String member_id = userDTO.getMember_id();
        int result = userService.countWishMovie(member_id);
        System.out.println("컨트롤러 result : " + result);
        return result;
    }


}
