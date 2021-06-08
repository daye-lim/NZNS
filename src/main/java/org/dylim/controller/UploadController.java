package org.dylim.controller;


import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.nio.file.Files;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.UUID;



import org.dylim.domain.AttachFileDTO;
import org.springframework.core.io.FileSystemResource;
import org.springframework.core.io.Resource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;



import lombok.extern.log4j.Log4j;
import net.coobird.thumbnailator.Thumbnailator;

@Controller
@Log4j

public class UploadController {

	
	// 업로드 된 파일이 이미지 파일인지 확인
	private boolean checkImageType(File file) {
		
		try {
			String contentType = Files.probeContentType(file.toPath());
			return contentType.startsWith("image");
		}catch (IOException e) {
			e.printStackTrace();
		}
		return false;
	}
	
	
	// 오늘 날짜의 경로를 문자열로 생성
	private String getFolder() {
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	Date date = new Date();
	String str = sdf.format(date);
	return str.replace("-", File.separator);
	//  생성된 경로는 폴더 경로로 수정 후 반환
	}
		
	
	@PostMapping(value = "/uploadAjaxAction", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public ResponseEntity<List<AttachFileDTO>> uploadAjaxPost(MultipartFile[] uploadFile) {

		List<AttachFileDTO> list = new ArrayList<>();
		String uploadFolder = "C:\\upload";
		
		String uploadFolderPath = getFolder();		

		File uploadPath = new File(uploadFolder, uploadFolderPath);

		// 생성된 경로의 폴더 경로가 있는지 검사하고 폴더를 생성
		// 이후 생성된 폴더로 파일을 저장
		if(uploadPath.exists() == false) {
			uploadPath.mkdirs();
		}
		
		// yyyy/MM/dd 폴더
		for (MultipartFile multipartFile : uploadFile) {
		AttachFileDTO attachDTO = new AttachFileDTO();
		String uploadFileName = multipartFile.getOriginalFilename();
		
		attachDTO.setFileName(uploadFileName);
		
	// 파일 이름 중복방지를위한 UUID적용
		UUID uuid = UUID.randomUUID();
	// 생성된 값은 원래 파일이름과 구분할수있도록 _ 를 추가
		uploadFileName = uuid.toString() + "_" + uploadFileName;
		
		
	//이미지 파일이면 섬네일 생성
		try {
			File saveFile = new File(uploadPath, uploadFileName);
			multipartFile.transferTo(saveFile);
			
			
			attachDTO.setUuid(uuid.toString());
			attachDTO.setUploadPath(uploadFolderPath);
			
			// check image type file
			if(checkImageType(saveFile)) {
				
				attachDTO.setImage(true);
				FileOutputStream thumbnail = new FileOutputStream(new File(uploadPath,"s_"+uploadFileName));
				
				Thumbnailator.createThumbnail(multipartFile.getInputStream(),thumbnail,100,100);
				thumbnail.close();
			}
			
			list.add(attachDTO);
			
		}catch (Exception e) {
			e.printStackTrace();
		}
						
		} // end for
		
		return new ResponseEntity<>(list, HttpStatus.OK);			
	}
	
	
	// 특정한 파일 이름 받아서 이미지 데이터 전송
		@GetMapping("/display")
		@ResponseBody
		public ResponseEntity<byte[]> getFile(String fileName){
		// 문자열로 파일의 경로가 포함된 fileName을 파라미터로 받고 byte[]를 전송
			
			log.info("fileName: "+fileName);
			
			File file = new File("c:\\upload\\"+fileName);
			log.info("file: "+file);
			
			ResponseEntity<byte[]> result = null;
			
			try {
				HttpHeaders header = new HttpHeaders();
				
				header.add("Content-Type", Files.probeContentType(file.toPath()));
		// probeContentType()을 이용해서 적절한 MIME 타입 데이터를 Http의 헤더 메시지에 포함될수있도록 처리
				result = new ResponseEntity<>(FileCopyUtils.copyToByteArray(file),
						header, HttpStatus.OK);
			}catch (IOException e) {
				e.printStackTrace();
			}			
			
			return result;
		}

		
		
		
		
		
		//첨부파일 다운로드
			@GetMapping(value = "/download", produces = MediaType.APPLICATION_OCTET_STREAM_VALUE)
				@ResponseBody
			public ResponseEntity<Resource> downloadFile(@RequestHeader("User-Agent") String userAgent, String fileName) {
				
				Resource resource = new FileSystemResource("c:\\upload\\"+fileName);

				// resourceOriginalName을 생성해서 UUID를 잘라낸 상태의 파일이름으로 저장되게한다
					if (resource.exists() == false) {
						return new ResponseEntity<>(HttpStatus.NOT_FOUND);
					}
				
				String resourceName = resource.getFilename();
				
				// remove UUID
				String resourceOriginalName = resourceName.substring(resourceName.indexOf("_")+1);
				
				HttpHeaders headers = new HttpHeaders();
				
				try {
					
					String downloadName = null;
					
					if(userAgent.contains("Trident")) {
						log.info("IE browser");
						
						downloadName = URLEncoder.encode(resourceOriginalName,"UTF-8").replaceAll("\\+", " ");
					
					} else if(userAgent.contains("Edge")) {
						
						log.info("Edge browser");
						downloadName = URLEncoder.encode(resourceOriginalName,"UTF-8");
						//log.info("Edge name: " + downloadName);
					
					} else {
						log.info("Chrome browser");
						downloadName = new String(resourceOriginalName.getBytes("UTF-8"), "ISO-8859-1");
					}
					
					log.info("downloadName: " + downloadName);
		// 다운로드시 저장되는 이름
					headers.add("Content-Disposition", "attachment; filename=" + downloadName);
					
				}catch (UnsupportedEncodingException e) {
					e.printStackTrace();
				}
				
				return new ResponseEntity<Resource>(resource, headers, HttpStatus.OK);
			}
			
			
			//등록화면에서 첨부파일 삭제
			@PostMapping("/deleteFile")
			@ResponseBody
			public ResponseEntity<String> deleteFile(String fileName, String type){
				// 브라우저에서 전송하는 파일이름/종류를 파라미터로 받아서 파일의 종류에 따라 다르게 동작함
				log.info("deleteFile: "+fileName);
				File file;
				
				try { // 일반파일의 경우 파일만을 삭제
					file = new File("c:\\upload\\" + URLDecoder.decode(fileName,"UTF-8"));
					file.delete();
					
					if(type.equals("image")) { // 이미지파일 경우 섬네일+원본이미지파일 함께 삭제
						String largeFileName = file.getAbsolutePath().replace("s_", "");
						log.info("largeFileName: "+largeFileName);
						file = new File(largeFileName);
						file.delete();
					}
				}catch (UnsupportedEncodingException e) {
					e.printStackTrace();
					return new ResponseEntity<>(HttpStatus.NOT_FOUND);
				}
				
				return new  ResponseEntity<String>("deleted",HttpStatus.OK);
			}

			
			

			
				
}
