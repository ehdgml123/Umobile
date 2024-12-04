<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>핸드폰 견적 비교</title>
<link href="${path}/resources/csss/index.css" rel="stylesheet"/> 
<link href="${path}/resources/csss/comparison.css" rel="stylesheet"/> 
</head>
<body>
<%@ include file="../includes/header.jsp" %>

<div class="pt_cart">
   <div class="contents">
      <div class="cart-wrap">
        <div class="cart-top">
             <div class="row flex-no-gutters">
                 <div class="cart-group-list col-12">
                    <div class="cart-top-title">
                       <div class="flex flex-align-center display-show-pc">
                         <p class="title display-small-none">핸드폰 견적비교</p>
                       </div>
                        <div class="cart-list checkout-list">
                            <div class="list-sort-name flex flex-justify-center flex-align-center flex-no-gutters">
                                <div class="col-md-7">
                                   <div class="flex flex-no-gutters checked-all-wrap">
                                        <span class="col">핸드폰 이름</span>
								   </div>
                                </div>
                                <div class="col-md-3" style="font-size: 20px">시리얼 넘버</div>                             
                            </div>
                           <!-- 핸드폰 목록 반복 -->
							<c:forEach var="product" items="${productList}">
							    <div class="cart-list-item cart-item product-opt_cart">
							       <div class="flex flex-no-gutters flex-justify-start">
							          <div class="item-dec col-md-7 col-12">
							             <div class="flex flex-align-start">
							                <div class="check_wrap">
							                    <!-- 체크박스 ID를 각 핸드폰의 고유 ID로 설정 -->
							                    <input type="checkbox" id="check_btn_${product.cno}" 
							                           onclick="updateSelection(this, '${product.phone_Name}', {
							                               phone_Name: '${product.phone_Name}',
							                               giga: '${product.giga}',
							                               phone_Size: '${product.phone_Size}',
							                               phone_Weight: '${product.phone_Weight}',
							                               camera: '${product.camera}',
							                               battery: '${product.battery}',
							                               memory: '${product.memory}',
							                               security: '${product.security}',
							                               waterproof: '${product.waterproof}'
							                           })"/>
							                    <label for="check_btn_${product.cno}"></label>
							                </div>
							                <div class="item-detail">
							                   <!-- 핸드폰 이름 링크 -->
							                   <a class="link-underline name">${product.phone_Name}</a>
							                </div>
							             </div>
							          </div>
							          <div class="item-price col-md-3 col-6 flex-align-center flex-justify-center">
							             <!-- 시리얼 넘버 표시 -->
							             <span class="serialnumber">${product.serial}</span>
							          </div>
							       </div>
							    </div>
							</c:forEach>
							<!-- 핸드폰 목록 반복 끝 -->
                        </div>
                    </div>
                 </div>                  
             </div>
        </div>
      </div> 
   </div>
</div>

<div class="bottom-layer-pop">
   <div class="bottom-container" id="paymentdetail">
       <div class="show-conts">
           <div class="selectbox" id="selected-items">
           </div>
           <button class="btns md-ripples ripples-light" type="button" id="comparison" onclick="showComparisonModal()">
             휴대폰 비교하기
           </button>
       </div>
   </div> 
</div>

<!--  모달 창 -->
<div id="comparison-modal" class="modal" style="display: none;">
    <div class="modal-content">
        <span class="close-btn" onclick="closeModal()">&times;</span>
        <h2>휴대폰 견적 비교</h2>
        <table class="comparison-table">
            <thead>
                <tr>
                    <th>항목</th>
                    <th id="phone1-name">휴대폰 1</th>
                    <th id="phone2-name">휴대폰 2</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td>GIGA</td>
                    <td id="phone1-giga">-</td>
                    <td id="phone2-giga">-</td>
                </tr>
                <tr>
                    <td>PHONE SIZE</td>
                    <td id="phone1-size">-</td>
                    <td id="phone2-size">-</td>
                </tr>
                <tr>
                    <td>PHONE WEIGHT</td>
                    <td id="phone1-weight">-</td>
                    <td id="phone2-weight">-</td>
                </tr>
                <tr>
                    <td>CAMERA</td>
                    <td id="phone1-camera">-</td>
                    <td id="phone2-camera">-</td>
                </tr>
                <tr>
                    <td>BATTERY</td>
                    <td id="phone1-battery">-</td>
                    <td id="phone2-battery">-</td>
                </tr>
                <tr>
                    <td>MEMORY</td>
                    <td id="phone1-memory">-</td>
                    <td id="phone2-memory">-</td>
                </tr>
                <tr>
                    <td>SECURITY</td>
                    <td id="phone1-security">-</td>
                    <td id="phone2-security">-</td>
                </tr>
                <tr>
                    <td>WATERPROOF</td>
                    <td id="phone1-waterproof">-</td>
                    <td id="phone2-waterproof">-</td>
                </tr>
            </tbody>
        </table>
    </div>
</div>

<script>
function updateSelection(checkbox, phoneName, details) {
    const selectedItemsContainer = document.getElementById("selected-items");

    if (checkbox.checked) {
        const newItem = document.createElement("div");
        newItem.classList.add("selected-item");
        newItem.textContent = phoneName;
        newItem.setAttribute("data-details", JSON.stringify(details));
        selectedItemsContainer.appendChild(newItem);
    } else {
        const items = selectedItemsContainer.querySelectorAll(".selected-item");
        items.forEach((item) => {
            if (item.textContent === phoneName) {
                selectedItemsContainer.removeChild(item);
            }
        });
    }
}

function showComparisonModal() {
    const selectedItems = document.querySelectorAll("#selected-items .selected-item");
    if (selectedItems.length < 2) {
        alert("비교를 위해 두 개의 상품을 선택하세요.");
        return;
    }

    const phone1Details = JSON.parse(selectedItems[0].getAttribute("data-details"));
    const phone2Details = JSON.parse(selectedItems[1].getAttribute("data-details"));

    document.getElementById("phone1-name").textContent = phone1Details.phone_Name;
    document.getElementById("phone2-name").textContent = phone2Details.phone_Name;

    document.getElementById("phone1-giga").textContent = phone1Details.giga;
    document.getElementById("phone2-giga").textContent = phone2Details.giga;

    document.getElementById("phone1-size").textContent = phone1Details.phone_Size;
    document.getElementById("phone2-size").textContent = phone2Details.phone_Size;

    document.getElementById("phone1-weight").textContent = phone1Details.phone_Weight;
    document.getElementById("phone2-weight").textContent = phone2Details.phone_Weight;

    document.getElementById("phone1-camera").textContent = phone1Details.camera;
    document.getElementById("phone2-camera").textContent = phone2Details.camera;

    document.getElementById("phone1-battery").textContent = phone1Details.battery;
    document.getElementById("phone2-battery").textContent = phone2Details.battery;

    document.getElementById("phone1-memory").textContent = phone1Details.memory;
    document.getElementById("phone2-memory").textContent = phone2Details.memory;

    document.getElementById("phone1-security").textContent = phone1Details.security;
    document.getElementById("phone2-security").textContent = phone2Details.security;

    document.getElementById("phone1-waterproof").textContent = phone1Details.waterproof;
    document.getElementById("phone2-waterproof").textContent = phone2Details.waterproof;

    const modal = document.getElementById("comparison-modal");
    modal.style.display = "block";
}

function closeModal() {
    const modal = document.getElementById("comparison-modal");
    modal.style.display = "none";
}
</script>

</body>
</html>
