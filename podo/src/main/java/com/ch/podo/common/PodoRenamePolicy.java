package com.ch.podo.common;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;

import org.springframework.web.multipart.MultipartFile;

public class PodoRenamePolicy {
	
	public String rename(MultipartFile file, HttpServletRequest request) {
		String root = request.getSession().getServletContext().getRealPath("resources");
		String savePath = root + "/memberProfileImage";
		
		File folder = new File(savePath);	// 저장 folder를 한번 알아옴

		if (!folder.exists()) { // savePath 경로가 없으면 폴더 생성하기
			folder.mkdir();
		}

		String originFileName = file.getOriginalFilename();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
		String renameFileName = sdf.format(new Date(System.currentTimeMillis())) + "."
														+ originFileName.substring(originFileName.lastIndexOf(".") + 1); // .뒷자리부터 뽑아내기 위해 +1

		String renamePath = savePath + "/" + renameFileName;

		try {
			file.transferTo(new File(renamePath));	//수정명으로 파일 업로드
		} catch (IllegalStateException | IOException e) {
			e.printStackTrace();
		}	
		
		return renameFileName;
	}
	
}
