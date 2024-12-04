package org.zerock.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.zerock.domain.NoticeVO;
import org.zerock.service.NoticeService;

import java.util.List;

@Controller
@RequestMapping("/notice")
public class NoticeController {

    @Autowired
    private NoticeService service;

    // 공지사항 목록
    @GetMapping("/list")
    public String list(@RequestParam(defaultValue = "0") int page, Model model) {
        int limit = 10; // 한 페이지당 표시할 항목 수
        int offset = page * limit;
        List<NoticeVO> notices = service.getAllWithPaging(offset,limit);
        
        model.addAttribute("noticeList", notices);
        model.addAttribute("currentPage", page);
        return "noticeList";
    }
    
    // 공지사항 검색
    @GetMapping("/search")
    public String search(@RequestParam("keyword") String keyword,
                         @RequestParam(defaultValue = "0") int page,
                         Model model) {
        int limit = 10;
        int offset = page * limit;
        List<NoticeVO> searchResults = service.searchPosts(keyword, offset, limit);

        model.addAttribute("notices", searchResults);
        model.addAttribute("currentPage", page);
        model.addAttribute("keyword", keyword);
        return "notice/list";
    }
    
    // 공지사항 등록 페이지
    @GetMapping("/create")
    public String createForm(Model model) {
        model.addAttribute("notice", new NoticeVO());
        return "admin/create";
    }

    // 공지사항 작성 처리
    @PostMapping("/create")
    public String create(NoticeVO notice) {
        service.create(notice);
        return "redirect:/admin/Adminmain";
    }

    // 공지사항 상세보기
    @GetMapping("/read/{nno}")
    public String read(@PathVariable Long nno, Model model) {
        NoticeVO notice = service.read(nno);
        model.addAttribute("notice", notice);
        return "admin/read";
    }

    // 공지사항 수정 페이지
    @GetMapping("/update/{nno}")
    public String updateForm(@PathVariable Long nno, Model model) {
        NoticeVO notice = service.read(nno);
        model.addAttribute("notice", notice);
        return "notice/update";
    }

    // 공지사항 수정 처리
    @PostMapping("/modify")
    public String update(NoticeVO notice) {
        service.update(notice);
        return "redirect:/admin/Adminmain";
    }

    // 공지사항 삭제 처리
    @PostMapping("/delete/{nno}")
    public String delete(@PathVariable Long nno) {
        service.delete(nno);
        return "redirect:/admin/notice";
    }
}