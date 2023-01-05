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
        List<LibraryFileDTO> fileList = new ArrayList<LibraryFileDTO>();
        String uploadPath = "C:/testsite/";

        //위 경로의 폴더가 없으면 폴더 생성
        File file = new File(uploadPath);
        log.debug("첨부파일 절대경로 : {}", file);
        if(file.exists() == false) {
            log.debug("업로드 폴더 없어서 생성함");
            file.mkdir();
        }

        //파일 이름들을 iterator로 담음
        Iterator<String> iterator = mhsr.getFileNames();

        while(iterator.hasNext()) {
            //파일명으로 파일 리스트 꺼내오기
            List<MultipartFile> list = mhsr.getFiles(iterator.next());
            //파일 리스트 개수 만큼 리턴할 파일 리스트에 담아주고 생성
            for(MultipartFile mf : list) {
                LibraryFileDTO libraryFileDTO = new LibraryFileDTO();
                libraryFileDTO.setPostNum(postNum);
                libraryFileDTO.setFileSize((int) mf.getSize());
                libraryFileDTO.setOriginalFileName(mf.getOriginalFilename());
                libraryFileDTO.setFilePath(uploadPath);
                fileList.add(libraryFileDTO);
                file = new File(uploadPath + mf.getOriginalFilename());
                log.debug("호출된 첨부파일 경로+원본명 : {}", file);
                mf.transferTo(file);
            }
        }
        return fileList;
    }
}
