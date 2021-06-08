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

	
	// ���ε� �� ������ �̹��� �������� Ȯ��
	private boolean checkImageType(File file) {
		
		try {
			String contentType = Files.probeContentType(file.toPath());
			return contentType.startsWith("image");
		}catch (IOException e) {
			e.printStackTrace();
		}
		return false;
	}
	
	
	// ���� ��¥�� ��θ� ���ڿ��� ����
	private String getFolder() {
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	Date date = new Date();
	String str = sdf.format(date);
	return str.replace("-", File.separator);
	//  ������ ��δ� ���� ��η� ���� �� ��ȯ
	}
		
	
	@PostMapping(value = "/uploadAjaxAction", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public ResponseEntity<List<AttachFileDTO>> uploadAjaxPost(MultipartFile[] uploadFile) {

		List<AttachFileDTO> list = new ArrayList<>();
		String uploadFolder = "C:\\upload";
		
		String uploadFolderPath = getFolder();		

		File uploadPath = new File(uploadFolder, uploadFolderPath);

		// ������ ����� ���� ��ΰ� �ִ��� �˻��ϰ� ������ ����
		// ���� ������ ������ ������ ����
		if(uploadPath.exists() == false) {
			uploadPath.mkdirs();
		}
		
		// yyyy/MM/dd ����
		for (MultipartFile multipartFile : uploadFile) {
		AttachFileDTO attachDTO = new AttachFileDTO();
		String uploadFileName = multipartFile.getOriginalFilename();
		
		attachDTO.setFileName(uploadFileName);
		
	// ���� �̸� �ߺ����������� UUID����
		UUID uuid = UUID.randomUUID();
	// ������ ���� ���� �����̸��� �����Ҽ��ֵ��� _ �� �߰�
		uploadFileName = uuid.toString() + "_" + uploadFileName;
		
		
	//�̹��� �����̸� ������ ����
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
	
	
	// Ư���� ���� �̸� �޾Ƽ� �̹��� ������ ����
		@GetMapping("/display")
		@ResponseBody
		public ResponseEntity<byte[]> getFile(String fileName){
		// ���ڿ��� ������ ��ΰ� ���Ե� fileName�� �Ķ���ͷ� �ް� byte[]�� ����
			
			log.info("fileName: "+fileName);
			
			File file = new File("c:\\upload\\"+fileName);
			log.info("file: "+file);
			
			ResponseEntity<byte[]> result = null;
			
			try {
				HttpHeaders header = new HttpHeaders();
				
				header.add("Content-Type", Files.probeContentType(file.toPath()));
		// probeContentType()�� �̿��ؼ� ������ MIME Ÿ�� �����͸� Http�� ��� �޽����� ���Եɼ��ֵ��� ó��
				result = new ResponseEntity<>(FileCopyUtils.copyToByteArray(file),
						header, HttpStatus.OK);
			}catch (IOException e) {
				e.printStackTrace();
			}			
			
			return result;
		}

		
		
		
		
		
		//÷������ �ٿ�ε�
			@GetMapping(value = "/download", produces = MediaType.APPLICATION_OCTET_STREAM_VALUE)
				@ResponseBody
			public ResponseEntity<Resource> downloadFile(@RequestHeader("User-Agent") String userAgent, String fileName) {
				
				Resource resource = new FileSystemResource("c:\\upload\\"+fileName);

				// resourceOriginalName�� �����ؼ� UUID�� �߶� ������ �����̸����� ����ǰ��Ѵ�
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
		// �ٿ�ε�� ����Ǵ� �̸�
					headers.add("Content-Disposition", "attachment; filename=" + downloadName);
					
				}catch (UnsupportedEncodingException e) {
					e.printStackTrace();
				}
				
				return new ResponseEntity<Resource>(resource, headers, HttpStatus.OK);
			}
			
			
			//���ȭ�鿡�� ÷������ ����
			@PostMapping("/deleteFile")
			@ResponseBody
			public ResponseEntity<String> deleteFile(String fileName, String type){
				// ���������� �����ϴ� �����̸�/������ �Ķ���ͷ� �޾Ƽ� ������ ������ ���� �ٸ��� ������
				log.info("deleteFile: "+fileName);
				File file;
				
				try { // �Ϲ������� ��� ���ϸ��� ����
					file = new File("c:\\upload\\" + URLDecoder.decode(fileName,"UTF-8"));
					file.delete();
					
					if(type.equals("image")) { // �̹������� ��� ������+�����̹������� �Բ� ����
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