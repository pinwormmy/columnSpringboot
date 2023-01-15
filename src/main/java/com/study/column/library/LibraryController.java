package com.study.column.library;

import com.study.column.util.FileUtils;
import com.study.column.util.IpService;
import com.study.column.util.PageDTO;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.FileSystemResource;
import org.springframework.core.io.Resource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.util.CollectionUtils;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import javax.servlet.http.HttpServletRequest;
import java.io.UnsupportedEncodingException;
import java.nio.charset.StandardCharsets;
import java.util.List;

@Controller
@Slf4j
@RequestMapping("/library")
public class LibraryController {
    
    @Autowired
    LibraryService libraryService;

    @GetMapping(value = "/list")
    public String library(PageDTO page, Model model) throws Exception {
        model.addAttribute("fullNoticeList", libraryService.showFullNoticeList());
        model.addAttribute("selfNoticeList", libraryService.showSelfNoticeList());
        model.addAttribute("page", libraryService.pageSetting(page));
        model.addAttribute("postList", libraryService.showPostList(page));
        log.debug(page.toString());
        return "library/library";
    }

    @RequestMapping("/readPost")
    @Transactional
    public String post(Model model, HttpServletRequest request) throws Exception {
        int postNum = Integer.parseInt(request.getParameter("postNum"));
        checkIpAndUpdateViews(request, postNum);
        model.addAttribute("post", libraryService.readPost(postNum));
        model.addAttribute("fileList", libraryService.showFileListInPost(postNum));
        return "library/readPost";
    }
    private void checkIpAndUpdateViews(HttpServletRequest request, int postNum) throws Exception {
        String ip = IpService.getRemoteIP(request);
        if(libraryService.checkViewUserIp(postNum, ip) == 0) {
            libraryService.saveViewUserIp(postNum, ip);
            libraryService.updateViews(postNum);
        }
    }

    @RequestMapping("/writePost")
    public String writePost() {
        return "library/writePost";
    }

    @RequestMapping("/submitPost")
    public String submitPost(LibraryDTO libraryDTO, HttpServletRequest request,
                             MultipartHttpServletRequest multipartHttpServletRequest) throws Exception {
        log.debug("글 등록 처리");
        int postNum = libraryService.getPostNumBeforeInsert();
        FileUtils fileUtils = new FileUtils();
        log.debug("게시물번호 확인 : {}", postNum);
        List<LibraryFileDTO> fileList = fileUtils.parseFileInfo(postNum, request, multipartHttpServletRequest);
        if(!CollectionUtils.isEmpty(fileList)) {
            log.debug("첨부파일 관련 쿼리 구현해야함");
            libraryService.insertBoardFileList(fileList);
        }
        libraryService.submitPost(libraryDTO);
        return "redirect:/library/list";
    }

    @RequestMapping("/deletePost")
    public String deletePost(int postNum) throws Exception {
        libraryService.deletePost(postNum);
        return "redirect:/library/list";
    }

    @RequestMapping(value = "/modifyPost")
    public String modifyPost(Model model, int postNum) throws Exception {
        model.addAttribute("post", libraryService.readPost(postNum));
        return "library/modifyPost";
    }

    @RequestMapping(value = "/submitModifyPost")
    public String submitModifyPost(LibraryDTO post) throws Exception {
        libraryService.submitModifyPost(post);
        return "redirect:/library/readPost?postNum=" + post.getPostNum();
    }

    @RequestMapping(value = "/addComment")
    @ResponseBody
    public void addComment(@RequestBody LibraryCommentDTO comment) throws Exception {
        log.debug("댓글 인수 확인(댓글내용) : {}", comment.getContent());
        libraryService.addComment(comment);
    }

    @RequestMapping(value = "/commentPageSetting")
    @ResponseBody
    public PageDTO commentPageSetting(@RequestBody PageDTO page) throws Exception {
        return libraryService.pageSetting(page);
    }

    @RequestMapping(value = "/showCommentList")
    @ResponseBody
    public List<LibraryCommentDTO> showCommentList(@RequestBody PageDTO page) throws Exception {
        return libraryService.showCommentList(page);
    }

    @RequestMapping(value = "/deleteComment")
    @ResponseBody
    public void deleteComment(int commentNum) throws Exception {
        libraryService.deleteComment(commentNum);
    }

    @RequestMapping(value = "/updateCommentCount")
    @ResponseBody
    public void updateCommentCount(int postNum) throws Exception {
        libraryService.updateCommentCount(postNum);
    }

    @RequestMapping(value="/fileDownload")
    @ResponseBody
    public ResponseEntity<Resource> fileDown(@RequestParam("fileName") String fileName,
                                             HttpServletRequest request) {
        // 뜬금포로 rest api개념을 넣게 됨. 여기에만 적용하는 것이 가능하면 그대로 적용하기
        log.debug("다운로드 컨트롤러 진입");
        String path = "C:\\testsite\\upload/";
        Resource resource = new FileSystemResource(path + fileName);
        log.debug("다운로드할 파일이름 확인 : {}", resource);
        String resourceName = resource.getFilename();
        log.debug("다운로드 시 인식된 파일이름 : {}", resourceName);
        //Http헤더에 옵션을 추가하기 위해서 헤더 변수 선언
        HttpHeaders headers = new HttpHeaders();
        //헤더에 파일명으로 첨부파일 추가
        headers.add("Content-Disposition", "attachment; filename=" + new String(resourceName.getBytes(StandardCharsets.UTF_8),
                StandardCharsets.ISO_8859_1));
        return new ResponseEntity<>(resource, headers, HttpStatus.OK);
    }
}