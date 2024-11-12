package com.popcornpedia.board.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.http.ResponseEntity;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.popcornpedia.board.dto.BoardDTO;

public interface BoardController {
	// 게시글 기본 CRUD

	public ModelAndView viewArticle(@RequestParam("id") int articleNO, HttpSession session) throws Exception;
	public ModelAndView insertArticle(@RequestParam("imgFile") MultipartFile multipartFile, @ModelAttribute BoardDTO boardDTO) throws Exception;
	public ModelAndView updateArticle(@RequestParam("imgFile") MultipartFile file, boolean deleteFile, boolean updateFile, @ModelAttribute BoardDTO boardDTO) throws Exception;
	public String deleteArticle(@RequestParam(value="id", required=false, defaultValue="0") int articleNO) throws Exception;
	
	// 새글 작성폼, 수정폼 이동
	public String formArticle() throws Exception;
	public String formModArticle(@RequestParam("id") int articleNO, Model model) throws Exception;
	
	// 게시글 검색
	public ModelAndView searchArticle(@RequestBody HashMap<String, Object> searchMap, int num) throws Exception;
	
	// 게시글 추천
	public int updateLikeArticle(int articleNO, String member_id, int likeCheck) throws Exception;
	public int likeCheck(int articleNO, String member_id) throws Exception;
	
	public ModelAndView selectPageArticle(int num) throws Exception;
}
