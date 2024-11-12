package com.popcornpedia.common.file;

import java.io.File;
import java.util.HashMap;

import org.springframework.web.multipart.MultipartFile;

public interface FileService {
	// fileMap : 업로드를 및 삭제를 위한 여러 정보(ex. 저장 경로)를 담은 HashMap
	void uploadFile(MultipartFile file, HashMap<String, Object> fileMap);
	void deleteFileOrDirectory(HashMap<String, Object> fileMap);
	void makeDirectory(File savedir);
	void deleteDirectory(File savedirPath);
	
	// rootdir 뒤에 내용을 붙여 저장 경로를 담은 File 객체를 완성
	File getSavedir(String path);
	File getSavedir(String path, String fileName);
}
