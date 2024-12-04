<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<body>
   <div id="header">   
          <div class="logbox">
           <a href="/">
              <img class="logimg" src="${pageContext.request.contextPath}/resources/img/headerlogo.png">
              </a>
          </div>
         <div class="col-md-10">
			<ul class="lower-navbar">
				<li><a href="">유심/eSIM</a></li>
			    <li><a href="#" id="toggleLink">휴대폰</a></li>
			    <li><a href="">상품</a></li>
				<li><a href="#">이벤트/혜택</a></li>
				<li><a href="/user/notice">공지사항</a></li>
				<li><a href="#" id="toggleLink-1">내 정보</a></li>
				<li><a href="#">유모바일</a></li>			
			</ul>
			<div class="submenu">
			  <div class="submenus">
			      <div class="submenuimg">
			         <a href="#"><img src="${pageContext.request.contextPath}/resources/img/img-gnb-lo.png"></a>
			      </div>
			      <ul class="submeul">
			        <li class="submeli"><a href="/phone/phoneproduct">가입신청</a></li>
			        <li class="submeli"><a href="#">모델별 지원금</a></li>
			      </ul>
			  </div>
			  <div class="submenus">
			      <div class="submenuimg">
			         <a href="#"><img src="${pageContext.request.contextPath}/resources/img/img-gnb-lo1.png"></a>
			      </div>
			      <ul class="submeul">
			        <li class="submeli"><a href="#">가입신청</a></li>
			          
			      </ul>
			  </div>
			</div>
			<!-- 내 정보 서브 메뉴 시작  -->
			<div class="submenu-1">
			   <div class="submenus-1">
			       <ul class="submeul-1">
			           <li class="submeli-1"><a href="/user/checkdetails">신청 내역</a></li>
			       </ul>
			   </div>
			    <div class="submenus-1">
			       <ul class="submeul-1">
			           <li class="submeli-1"><a href="/user/Edit">정보 수정</a></li>
			       </ul>
			   </div>
			</div>
			
			<!-- 내 정보 서브 메뉴  끝 -->
		</div>
		
		<div class="top-util">
		    <div class="navlog">
		     <img class="navimg-t" src="${pageContext.request.contextPath}/resources/img/navlog1.png">
		    </div>
		      <div class="navlog">
          <a href="#" id="profileIcon"> <!-- 아이콘 클릭 시 모달 활성화 -->
        <img class="navimg" src="${pageContext.request.contextPath}/resources/img/navlog2.png">
          <b class="state" id="toggle" style="display: none;">ON</b>
        </a>
    <!-- 로그인 전 모달 -->
    <div class="navsub" style="display: none;"> <!-- 기본 숨김 -->
        <div class="info-basic">
            <button type="button" id="btnLogin" class="top-login" onclick="window.location.href = '/user/login';">로그인</button>
            <ul class="find-join">
                <li><a href="#">ID/비밀번호찾기</a></li>
                <li><a href="/user/join">회원가입</a></li>
            </ul>
        </div>
        <div class="info-func">
            <ul>
                <img src="${pageContext.request.contextPath}/resources/img/log-doc.svg">
                <li class="sodurwhgml"><a href="#">신청내역조회</a></li>
            </ul>
        </div>
    </div>
    <!-- 로그인 후 모달 -->
    <div class="loginboxs" style="display: none;"> <!-- 기본 숨김 -->
        <strong class="info-user">
            <span id="userName">${sessionScope.user.name}</span> 님
            <a href="/user/Edit" class="member-modify">회원정보수정</a>
        </strong>
        <div class="info-func">
						<ul class="func-btn">
							<li><a href="/user/checkdetails" class="member-modify2">신청내역
									조회</a></li>
							<li class="btnSBMB"><a href="/phone/comparison"
								class="btn-num-auth">견적 비교하기</a></li>
						</ul>

						<div class="guide-box pint-bx">
							<a href="#">
								<p>
									<strong>포인트</strong> <span id="gnbPoint">0P</span>
								</p>
							</a> <a href="#">
								<p id="ucashArea2">
									<strong>U폰 캐시</strong> <span id="gnbUcash">0C</span>
								</p>
							</a>
							<p class="fir">친구추천하고 특별한 혜택을 받으세요</p>
						</div>
						<p class="devcechg-txt">기기변경 상담 1661-0556 (유료)</p>
					</div>
        <div class="logbox-btm">
            <a href="/logout">
                <button class="btn-text-right-s btn-logout">로그아웃</button>
            </a>
        </div>
    </div>
</div>
		      <div class="navlog">
		       <a href="#">
		       <img class="navimg" src="${pageContext.request.contextPath}/resources/img/navlog3.png">
		      </a>
		    </div>
		</div>
    </div>
    
    <!-- 헤더 끝 -->
</body>
</html>
<script>
<!--메뉴 펼침 -->

$(document).ready(function() {
    let isSubmenuVisible = false; // .submenu 표시 상태 변수

    $('#toggleLink').click(function() {
        isSubmenuVisible = !isSubmenuVisible; // 상태 토글
        if (isSubmenuVisible) {
            $('.submenu').show(); // 표시
        } else {
            $('.submenu').hide(); // 숨김
        }
    });
});


 $(document).ready(function() {
    let isSubmenuVisible = false; // .submenu 표시 상태 변수

    $('#toggleLink-1').click(function() {
        isSubmenuVisible = !isSubmenuVisible; // 상태 토글
        if (isSubmenuVisible) {
            $('.submenu-1').show(); // 표시
        } else {
            $('.submenu-1').hide(); // 숨김
        }
    });
}); 

<!--메뉴 펼침 -->

<!-- 로그인 모달 -->
$(document).ready(function () {
    // 기본 상태 숨김
    $(".navsub, .loginboxs").hide();

    // 아이콘 클릭 이벤트
    $("#profileIcon").click(function () {
        if ($(".state").is(":visible")) {
            // 로그인 후 상태
            $(".loginboxs").toggle();
        } else {
            // 로그인 전 상태
            $(".navsub").toggle();
        }
    });

    // 화면 밖 클릭 시 모달 닫기
    $(document).click(function (e) {
        if (!$(e.target).closest("#profileIcon, .navsub, .loginboxs").length) {
            $(".navsub, .loginboxs").hide();
        }
    });
});

<!-- 로그인 모달 -->


/* 로그인 전, 후 보여주는   */
document.addEventListener("DOMContentLoaded", function () {
  const navSub = document.querySelector(".navsub");
  const loginBox = document.querySelector(".loginboxs");
  const navImg = document.querySelector(".navlog > a");
  const session = "${sessionScope.user}";
  const toggle = document.querySelector("#toggle");

  if (session !== null && session !== "") {
    // 로그인 상태일 경우
    navSub.style.display = "none";
    loginBox.style.display = "block";
    toggle.style.display = "block";
  } else {
    // 비로그인 상태일 경우
    navSub.style.display = "none"; // 모달창 숨김
    loginBox.style.display = "none";
    // 이미지는 그대로 보이게 함
    toggle.style.display = "none";
  }
});


</script>