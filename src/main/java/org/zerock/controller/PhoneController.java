package org.zerock.controller;

import java.util.Comparator;
import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.zerock.domain.OrderVO;
import org.zerock.domain.ProductVO;
import org.zerock.domain.ReviewVO;
import org.zerock.domain.UserVO;
import org.zerock.service.OrderService;
import org.zerock.service.ProductService;
import org.zerock.service.ReviewService;

import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/phone/*")
@RequiredArgsConstructor
public class PhoneController {

	private final ProductService productService;
	private final OrderService orderService;
	private final ReviewService reviewService;

	// 휴대폰 상품 페이지
	@GetMapping("/phoneproduct")
	public void phoneProductPage(Model model) {
		List<ProductVO> products = productService.getProduct();
		products.sort(Comparator.comparing(ProductVO::getRegdate).reversed());
		
		log.info("products => " + products);
		
		model.addAttribute("products", products);
	}

	// 휴대폰 상세 페이지 (상세 정보 + 리뷰 데이터 통합)
	@GetMapping("/PhoneDetail")
	public String phoneProductDetail(@RequestParam("cno") Long cno, Model model) {

		ProductVO product = productService.read(cno);
		List<ReviewVO> reviews = reviewService.getReviewsByPhone(cno);
		model.addAttribute("product", product);
		model.addAttribute("reviews", reviews);
		return "phone/PhoneDetail";
	}

	// 휴대폰 추가
	@PostMapping("/phone/add")
	public String phoneAdd(@RequestParam("uno") long uno, 
			@RequestParam("cno") long cno,
			@RequestParam("phonecolor") String color, 
			@RequestParam("installment") String installment,
			@RequestParam("vatPrice") double vatPrice, 
			Model model) {

		OrderVO orderVO = new OrderVO();

		orderVO.setUno(uno);
		orderVO.setCno(cno);
		orderVO.setColor(color);
		orderVO.setInstallment(installment);
		orderVO.setVatPrice(vatPrice);

		orderService.addPhone(orderVO);

		return "redirect:/user/checkdetails";
	}

	// 사용자 로그인 페이지(비회원이 신청했을 시 이동)
	@GetMapping("/user/login")
	public String userLogin() {
		return "user/login";
	}

	// 1대 1비교
	@GetMapping("/comparison")
	public String phoneComparison(Model model) {
		List<ProductVO> productList = productService.getProduct();
		model.addAttribute("productList", productList);
		return "phone/comparison";
	}

}
