package org.zerock.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.zerock.domain.ReviewVO;
import org.zerock.mapper.ReviewMapper;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class ReviewServiceImpl implements ReviewService {

    private final ReviewMapper reviewMapper;

    // 리뷰 생성
    @Override
    public boolean createReview(ReviewVO reviewVO) {
        // 리뷰 삽입 성공 여부 반환
        return reviewMapper.insertReview(reviewVO) > 0;
    }

    // 특정 리뷰 조회
    @Override
    public ReviewVO read(Long rno) {
        return reviewMapper.getReviewById(rno);
    }

    // 특정 휴대폰(vno)에 대한 리뷰 가져오기
    @Override
    public List<ReviewVO> getReviewsByPhone(Long vno) {
        return reviewMapper.getReviewsByPhone(vno);
    }

    // 리뷰 + 사용자 이름 + 휴대폰 상세 정보 가져오기
    @Override
    public List<ReviewVO> getReviewsWithDetails() {
        return reviewMapper.getReviewWithDetails();
    }

    // 모든 리뷰 가져오기
    @Override
    public List<ReviewVO> getAll() {
        return reviewMapper.getAllReviews();
    }
}
