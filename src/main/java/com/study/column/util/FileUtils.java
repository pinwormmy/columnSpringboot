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

        //서버의 절대 경로 얻기 => 여기서 로컬 경로와 서버 경로가 갈리면서 절대 경로 의미 상실해서 오류 발생;
        String root_path = request.getSession().getServletContext().getRealPath("/");
        log.debug("root_path 확인 : {}", root_path);
        String attach_path = "/upload/";

        //위 경로의 폴더가 없으면 폴더 생성
        File file = new File(root_path + attach_path);
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
                libraryFileDTO.setFilePath(root_path + attach_path);
                fileList.add(libraryFileDTO);
                file = new File(root_path + attach_path + mf.getOriginalFilename());
                log.debug("호출된 첨부파일 경로+원본명 : {}", file);
                mf.transferTo(file);
            }
        }
        return fileList;
    }
}
