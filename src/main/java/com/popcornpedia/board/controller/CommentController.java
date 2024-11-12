package com.popcornpedia.board.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;

import com.popcornpedia.board.dto.CommentDTO;

public interface CommentController {
	// 댓글 기본 CRUD
	public ResponseEntity<List<CommentDTO>> selectComment(@PathVariable("articleNO") int articleNO) throws Exception;
	public ResponseEntity<String> insertComment(@RequestBody CommentDTO commentDTO) throws Exception;
	public ResponseEntity<String> updateComment(@RequestBody HashMap<String, Object> commentMap) throws Exception;
	public ResponseEntity<String> deleteComment(@RequestBody HashMap<String, Object> commentMap) throws Exception;
	public ResponseEntity<Map<String, Object>> selectPageComment(@PathVariable("articleNO") int articleNO, int num) throws Exception; 
}
