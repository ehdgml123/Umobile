package org.zerock.service;

import java.util.List;
import org.zerock.domain.ReviewVO;

public interface ReviewService {

    // 리뷰 작성
    boolean createReview(ReviewVO reviewVO);

    // 특정 리뷰 조회
    ReviewVO read(Long rno);

    // 특정 휴대폰(vno)에 대한 리뷰 가져오기
    List<ReviewVO> getReviewsByPhone(Long vno);

    // 리뷰 + 사용자 이름 + 휴대폰 상세 정보 가져오기
    List<ReviewVO> getReviewsWithDetails();

    // 모든 리뷰 조회
    List<ReviewVO> getAll();
}
