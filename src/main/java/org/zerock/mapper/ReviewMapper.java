package org.zerock.mapper;

import java.util.List;
import org.zerock.domain.ReviewVO;

public interface ReviewMapper {

    // 리뷰 삽입 (성공적으로 삽입된 행의 수 반환)
	int insertReview(ReviewVO reviewVO);

    // 특정 리뷰 조회 (리뷰 ID로 조회)
    ReviewVO getReviewById(Long rno);

    // 특정 휴대폰(vno)에 대한 리뷰 조회
    List<ReviewVO> getReviewsByPhone(Long vno);

    // 리뷰 + 사용자 이름 + 휴대폰 상세 정보 조회
    List<ReviewVO> getReviewWithDetails();

    // 모든 리뷰 조회
    List<ReviewVO> getAllReviews();
}
