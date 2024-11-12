package com.popcornpedia.common.file;

import java.io.File;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.StandardCopyOption;
import java.util.HashMap;

import javax.servlet.ServletContext;

import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

@Service("boardFileService")
public class BoardFileService implements FileService {
	
	// servletContext 를 사용하기 위해 객체 주입
	@Autowired
    private ServletContext servletContext;
	
	// 파일을 저장할 기본 Root 디렉토리 지정
	String rootdir = "/resources/images/board/";

	@Override
	public void uploadFile(MultipartFile file, HashMap<String, Object> fileMap) {
		// 파일을 저장할 디렉토리 지정
		String articleNO = fileMap.get("articleNO").toString();
		File savedir = getSavedir(articleNO);
		
		// 디렉토리 생성
		makeDirectory(savedir);
		
		// 파일 저장하기
		File saveFile = new File(savedir, file.getOriginalFilename());
		Path filePath = saveFile.toPath();
		try {
			Files.copy(file.getInputStream(), filePath, StandardCopyOption.REPLACE_EXISTING);
		}
		catch(Exception e) {e.printStackTrace();}
	}
	
	@Override
	public void deleteFileOrDirectory(HashMap<String, Object> fileMap) { // 파일 or 디렉토리 삭제
		// 파일을 삭제할 디렉토리와 파일 이름 지정
		String articleNO = fileMap.get("articleNO").toString();
		String fileName = "";
		if(fileMap.get("fileName") != null) { // 파일 이름까지 있는지 확인
			fileName = fileMap.get("fileName").toString();
		}
		if(!(fileName.isEmpty())) { // 파일 이름까지 있으면
			File savedir = getSavedir(articleNO, fileName);	
			// 파일 삭제하기
			savedir.delete();
		} else { // 디렉토리 이름만 있으면
			File savedir = getSavedir(articleNO);
			// 디렉토리 삭제하기
			deleteDirectory(savedir);
		}
	}

	@Override
	public void makeDirectory(File savedir) {
		// 경로로 된 디렉토리가 없으면 새로 생성
		if(!savedir.exists()) {
			if(savedir.mkdirs()) {
				System.out.println("[BoardFileService] 폴더 생성 : "+savedir);
			} else {
				System.out.println("[BoardFileService] 폴더 생성 실패 : "+savedir);
			}
		}
	}

	@Override
	public void deleteDirectory(File savedir) {
		// 경로로 된 디렉토리가 있으면 삭제
		if(savedir.exists()) {
			try {
				FileUtils.deleteDirectory(savedir);
				System.out.println("[BoardFileService] 폴더 삭제 : "+savedir);
			}
			catch(Exception e) {e.printStackTrace();}
		}
	}

	// 파일을 저장할 디렉토리 또는 파일의 File 객체 생성
	@Override
	public File getSavedir(String path, String fileName) {
		File savedir = new File(servletContext.getRealPath(rootdir + path + "/" + fileName));
		return savedir;
	}
	
	@Override
	public File getSavedir(String path) {
		File savedir = new File(servletContext.getRealPath(rootdir + path));
		return savedir;
	}
}
