<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>상품 등록 페이지</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            font-family: 'Arial', sans-serif;
            background-color: #fff;
            padding: 20px;
        }

        .container {
            max-width: 600px;
            margin: 0 auto;
        }

        /* 이미지 업로드 박스 */
        .upload-container {
            display: flex;
            align-items: center;
            justify-content: center;
            border: 1px dashed #d3d3d3;
            width: 120px;
            height: 120px;
            border-radius: 8px;
            cursor: pointer;
            margin-bottom: 20px;
            position: relative;
            background-color: #f9f9f9;
        }

        .upload-container img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            border-radius: 8px;
        }

        .upload-text {
            color: #888;
            font-size: 0.9rem;
            text-align: center;
        }

        /* 카테고리 선택 박스 */
        .category-box {
            height: 150px;
            overflow-y: scroll;
            border: 1px solid #d3d3d3;
            border-radius: 5px;
            padding: 10px;
            margin-bottom: 20px;
            background-color: transparent;
        }

        .category-item {
            padding: 8px;
            border-bottom: 1px solid #e1e1e1;
            cursor: pointer;
            font-size: 0.9rem;
        }

        .category-item:last-child {
            border-bottom: none;
        }

        .category-item:hover {
            background-color: #f9f9f9;
        }

        .category-item.active {
            background-color: #f1f1f1;
            font-weight: bold;
            border-left: 3px solid #000;
        }

        /* 유의사항 입력 박스 */
        .notice-box {
            padding: 10px;
            border: 1px solid #d3d3d3;
            border-radius: 5px;
            margin-bottom: 20px;
            color: #666;
            font-size: 0.9rem;
            line-height: 1.5;
            background-color: #f9f9f9;
            cursor: text;
        }

        /* 상품상태 버튼 */
        .product-status-btn {
            padding: 12px 25px;
            border-radius: 30px;
            border: 2px solid #d3d3d3;
            margin-right: 10px;
            cursor: pointer;
            font-size: 1rem;
            font-weight: bold;
        }

        .selected {
            background-color: #00c73c;
            color: white;
            border: 2px solid #00c73c;
        }

        /* 라디오 버튼 및 체크박스 커스텀 */
        .form-check {
            position: relative;
            padding-left: 35px;
            margin-bottom: 10px;
        }

        .form-check-input {
            position: absolute;
            opacity: 0;
            cursor: pointer;
        }

        .form-check-label::before {
            content: '';
            position: absolute;
            left: 0;
            top: 50%;
            transform: translateY(-50%);
            width: 20px;
            height: 20px;
            border: 1px solid #d3d3d3;
            border-radius: 50%;
            background-color: white;
        }

        .form-check-input:checked~.form-check-label::before {
            background-color: #00c73c;
            border-color: #00c73c;
            background-image: url('https://via.placeholder.com/20x20?text=✓');
            background-size: 80%;
            background-position: center;
            background-repeat: no-repeat;
        }

        /* 배송비 관련 */
        .shipping-method {
            margin-top: 20px;
            display: none;
        }

        .shipping-method.show {
            display: block;
        }

        /* 판매가격 입력 필드 */
        .price-input-container {
            display: flex;
            align-items: center;
            justify-content: space-between;
            margin-bottom: 20px;
        }

        .price-input {
            flex: 1;
            padding: 10px;
            border: 1px solid #d3d3d3;
            border-radius: 5px;
            margin-right: 10px;
        }

        .price-input:focus {
            outline: none;
            border: 1px solid #000;
        }

        /* 무료나눔 체크박스 */
        .free-giveaway {
            display: flex;
            align-items: center;
            white-space: nowrap;
        }

        .free-giveaway input {
            margin-right: 5px;
        }

        /* 등록 버튼 */
        .btn-submit {
            background-color: #000;
            color: white;
            padding: 15px;
            border-radius: 30px;
            margin-top: 30px;
            width: 100%;
            font-size: 1.1rem;
            font-weight: bold;
            border: none;
            cursor: pointer;
        }

        .btn-submit:hover {
            background-color: #333;
        }

        /* 유의사항 안내 */
        .info-text {
            font-size: 0.8rem;
            color: #888;
            margin-top: 20px;
        }

        /* 반응형 디자인 */
        @media (max-width: 768px) {
            .product-status-btn {
                padding: 10px 20px;
                font-size: 0.9rem;
            }

            .btn-submit {
                padding: 12px;
                font-size: 1rem;
            }

            .upload-container {
                width: 80px;
                height: 80px;
            }

            .category-box {
                height: 100px;
            }
        }
    </style>
</head>

<body>

    <div class="container mt-5">
        <form>
            <!-- 이미지 업로드 -->
            <div class="mb-3">
                <div class="upload-container" id="uploadContainer">
                    <span class="upload-text">0/10</span>
                </div>
                <input type="file" id="fileInput" class="d-none" accept="image/*" multiple>
            </div>

            <!-- 상품명 입력 -->
            <div class="mb-3">
                <input type="text" class="form-control" placeholder="상품명">
            </div>

            <!-- 카테고리 선택 -->
            <div class="mb-3">
                <div class="category-box">
                    <div class="category-item">수입명품</div>
                    <div class="category-item">패션의류</div>
                    <div class="category-item">패션잡화</div>
                    <div class="category-item">뷰티</div>
                    <div class="category-item">출산/유아동</div>
                    <div class="category-item">모바일/태블릿</div>
                </div>
            </div>

            <!-- 판매가격 입력 및 무료나눔 -->
            <div class="mb-3 price-input-container">
                <input type="text" class="form-control price-input" placeholder="₩ 판매가격">
                <div class="free-giveaway">
                    <input type="checkbox" id="freeGiveaway">
                    <label for="freeGiveaway">무료나눔</label>
                </div>
            </div>

            <!-- 유의사항 텍스트박스 -->
            <div class="mb-3">
                <textarea class="form-control notice-box" id="noticeBox" rows="4" onclick="clearPlaceholder(this)">
                    - 상품명(브랜드)
- 구매 시기
- 사용 기간
- 하자 여부

* 실제 촬영한 사진과 함께 상세 정보를 입력해주세요.
                </textarea>
                <div class="text-end mt-2"><span id="charCount">0</span> / 1000</div>
            </div>

            <!-- 상품상태 -->
            <div class="mb-3 d-flex">
                <div class="product-status-btn selected" id="usedBtn">중고</div>
                <div class="product-status-btn" id="newBtn">새상품</div>
            </div>

            <!-- 거래방법 -->
            <div class="mb-3">
                <div class="form-check">
                    <input class="form-check-input" type="radio" name="dealMethod" id="delivery" value="택배거래">
                    <label class="form-check-label" for="delivery">택배거래</label>
                </div>
                <div class="form-check">
                    <input class="form-check-input" type="radio" name="dealMethod" id="direct" value="직거래">
                    <label class="form-check-label" for="direct">직거래</label>
                </div>
            </div>

            <!-- 배송비 추가 박스 -->
            <div class="shipping-method" id="shippingMethod">
                <div class="shipping-label">배송비:</div>
                <div class="form-check">
                    <input class="form-check-input" type="radio" name="shippingFee" id="shippingSeparate" value="별도">
                    <label class="form-check-label" for="shippingSeparate">배송비 별도</label>
                </div>
                <div class="form-check">
                    <input class="form-check-input" type="radio" name="shippingFee" id="shippingIncluded" value="포함">
                    <label class="form-check-label" for="shippingIncluded">배송비 포함</label>
                </div>
            </div>

            <!-- 등록 버튼 -->
            <button type="submit" class="btn-submit">등록</button>

            <!-- 안내문 -->
            <div class="info-text">
                체크 후 Pay 거부 시 서비스 제한 처리될 수 있어요. <a href="#">바로가기</a>
            </div>
        </form>
    </div>

    <script>

const uploadContainer = document.getElementById('uploadContainer');
        const fileInput = document.getElementById('fileInput');

        uploadContainer.addEventListener('click', () => {
            fileInput.click();
        });

        fileInput.addEventListener('change', function () {
            const files = Array.from(this.files);
            if (files.length > 0) {
                const reader = new FileReader();
                reader.onload = function (e) {
                    uploadContainer.innerHTML = `<img src="${e.target.result}" alt="이미지">`;
                };
                reader.readAsDataURL(files[0]);
            }
        });
        // 유의사항 박스 클릭 시 placeholder처럼 동작
        function clearPlaceholder(element) {
            if (element.value.startsWith('- 상품명')) {
                element.value = '';
            }
        }

        // 상품상태 버튼 클릭 시 색상 변경
        const usedBtn = document.getElementById('usedBtn');
        const newBtn = document.getElementById('newBtn');

        usedBtn.addEventListener('click', () => {
            usedBtn.classList.add('selected');
            newBtn.classList.remove('selected');
        });

        newBtn.addEventListener('click', () => {
            newBtn.classList.add('selected');
            usedBtn.classList.remove('selected');
        });

        // 거래방법 선택 시 배송비 옵션 표시
        const delivery = document.getElementById('delivery');
        const direct = document.getElementById('direct');
        const shippingMethod = document.getElementById('shippingMethod');

        delivery.addEventListener('change', () => {
            if (delivery.checked) {
                shippingMethod.classList.add('show');
            }
        });

        direct.addEventListener('change', () => {
            if (direct.checked) {
                shippingMethod.classList.remove('show');
            }
        });

        // 문자수 카운터
        const textarea = document.getElementById('noticeBox');
        const charCount = document.getElementById('charCount');

        textarea.addEventListener('input', () => {
            charCount.textContent = textarea.value.length;
        });
    </script>

</body>

</html>
