package com.study.column.util;

import com.study.column.library.LibraryFileDTO;
import lombok.extern.slf4j.Slf4j;
import org.springframework.util.ObjectUtils;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

@Slf4j
public class FileUtils {

    public List<LibraryFileDTO> parseFileInfo(int postNum, HttpServletRequest request,
                                              MultipartHttpServletRequest mhsr) throws IOException {
        log.debug("FileUtils 클래스 작동");
        if(ObjectUtils.isEmpty(mhsr)) {
            log.debug("FileUtils 클래스 작동했지만, 첨부없어서 패스~");
            return null;
        }
        List<LibraryFileDTO> fileList = new ArrayList<>();
        String uploadPath = "C:\\testsite\\upload/";
        File file = new File(uploadPath);
        log.debug("첨부파일 절대경로 : {}", file);
        if(!file.exists()) {
            log.debug("업로드 폴더 없어서 생성함");
            file.mkdir();
        }
        Iterator<String> iterator = mhsr.getFileNames();
        
        // 코드 정리 필요
        while(iterator.hasNext()) {
            List<MultipartFile> list = mhsr.getFiles(iterator.next());
            for(MultipartFile mf : list) {
                if(mf.getSize() > 0) {
                    LibraryFileDTO libraryFileDTO = new LibraryFileDTO();
                    libraryFileDTO.setPostNum(postNum);
                    libraryFileDTO.setFileSize((int) mf.getSize());
                    libraryFileDTO.setOriginalFileName(mf.getOriginalFilename());
                    libraryFileDTO.setFilePath(uploadPath);
                    log.debug("단일파일 정보 입력 확인 : {}", libraryFileDTO);
                    fileList.add(libraryFileDTO);
                    file = new File(uploadPath + mf.getOriginalFilename());
                    log.debug("호출된 첨부파일 경로+원본명 : {}", file);
                    mf.transferTo(file);
                }else {
                    fileList = null;
                }
            }
        }
        return fileList;
    }
}
