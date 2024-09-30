<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>ìí ë±ë¡ íì´ì§</title>
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

        /* ì´ë¯¸ì§ ìë¡ë ë°ì¤ */
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

        /* ì¹´íê³ ë¦¬ ì í ë°ì¤ */
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

        /* ì ìì¬í­ ìë ¥ ë°ì¤ */
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

        /* ìíìí ë²í¼ */
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

        /* ë¼ëì¤ ë²í¼ ë° ì²´í¬ë°ì¤ ì»¤ì¤í */
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
            background-image: url('https://via.placeholder.com/20x20?text=â');
            background-size: 80%;
            background-position: center;
            background-repeat: no-repeat;
        }

        /* ë°°ì¡ë¹ ê´ë ¨ */
        .shipping-method {
            margin-top: 20px;
            display: none;
        }

        .shipping-method.show {
            display: block;
        }

        /* íë§¤ê°ê²© ìë ¥ íë */
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

        /* ë¬´ë£ëë ì²´í¬ë°ì¤ */
        .free-giveaway {
            display: flex;
            align-items: center;
            white-space: nowrap;
        }

        .free-giveaway input {
            margin-right: 5px;
        }

        /* ë±ë¡ ë²í¼ */
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

        /* ì ìì¬í­ ìë´ */
        .info-text {
            font-size: 0.8rem;
            color: #888;
            margin-top: 20px;
        }

        /* ë°ìí ëìì¸ */
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
            <!-- ì´ë¯¸ì§ ìë¡ë -->
            <div class="mb-3">
                <div class="upload-container" id="uploadContainer">
                    <span class="upload-text">0/10</span>
                </div>
                <input type="file" id="fileInput" class="d-none" accept="image/*" multiple>
            </div>

            <!-- ìíëª ìë ¥ -->
            <div class="mb-3">
                <input type="text" class="form-control" placeholder="ìíëª">
            </div>

            <!-- ì¹´íê³ ë¦¬ ì í -->
            <div class="mb-3">
                <div class="category-box">
                    <div class="category-item">ììëªí</div>
                    <div class="category-item">í¨ììë¥</div>
                    <div class="category-item">í¨ìì¡í</div>
                    <div class="category-item">ë·°í°</div>
                    <div class="category-item">ì¶ì°/ì ìë</div>
                    <div class="category-item">ëª¨ë°ì¼/íë¸ë¦¿</div>
                </div>
            </div>

            <!-- íë§¤ê°ê²© ìë ¥ ë° ë¬´ë£ëë -->
            <div class="mb-3 price-input-container">
                <input type="text" class="form-control price-input" placeholder="â© íë§¤ê°ê²©">
                <div class="free-giveaway">
                    <input type="checkbox" id="freeGiveaway">
                    <label for="freeGiveaway">ë¬´ë£ëë</label>
                </div>
            </div>

            <!-- ì ìì¬í­ íì¤í¸ë°ì¤ -->
            <div class="mb-3">
                <textarea class="form-control notice-box" id="noticeBox" rows="4" onclick="clearPlaceholder(this)">
                    - ìíëª(ë¸ëë)
- êµ¬ë§¤ ìê¸°
- ì¬ì© ê¸°ê°
- íì ì¬ë¶

* ì¤ì  ì´¬ìí ì¬ì§ê³¼ í¨ê» ìì¸ ì ë³´ë¥¼ ìë ¥í´ì£¼ì¸ì.
                </textarea>
                <div class="text-end mt-2"><span id="charCount">0</span> / 1000</div>
            </div>

            <!-- ìíìí -->
            <div class="mb-3 d-flex">
                <div class="product-status-btn selected" id="usedBtn">ì¤ê³ </div>
                <div class="product-status-btn" id="newBtn">ììí</div>
            </div>

            <!-- ê±°ëë°©ë² -->
            <div class="mb-3">
                <div class="form-check">
                    <input class="form-check-input" type="radio" name="dealMethod" id="delivery" value="íë°°ê±°ë">
                    <label class="form-check-label" for="delivery">íë°°ê±°ë</label>
                </div>
                <div class="form-check">
                    <input class="form-check-input" type="radio" name="dealMethod" id="direct" value="ì§ê±°ë">
                    <label class="form-check-label" for="direct">ì§ê±°ë</label>
                </div>
            </div>

            <!-- ë°°ì¡ë¹ ì¶ê° ë°ì¤ -->
            <div class="shipping-method" id="shippingMethod">
                <div class="shipping-label">ë°°ì¡ë¹:</div>
                <div class="form-check">
                    <input class="form-check-input" type="radio" name="shippingFee" id="shippingSeparate" value="ë³ë">
                    <label class="form-check-label" for="shippingSeparate">ë°°ì¡ë¹ ë³ë</label>
                </div>
                <div class="form-check">
                    <input class="form-check-input" type="radio" name="shippingFee" id="shippingIncluded" value="í¬í¨">
                    <label class="form-check-label" for="shippingIncluded">ë°°ì¡ë¹ í¬í¨</label>
                </div>
            </div>

            <!-- ë±ë¡ ë²í¼ -->
            <button type="submit" class="btn-submit">ë±ë¡</button>

            <!-- ìë´ë¬¸ -->
            <div class="info-text">
                ì²´í¬ í Pay ê±°ë¶ ì ìë¹ì¤ ì í ì²ë¦¬ë  ì ìì´ì. <a href="#">ë°ë¡ê°ê¸°</a>
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
                    uploadContainer.innerHTML = `<img src="${e.target.result}" alt="ì´ë¯¸ì§">`;
                };
                reader.readAsDataURL(files[0]);
            }
        });
        // ì ìì¬í­ ë°ì¤ í´ë¦­ ì placeholderì²ë¼ ëì
        function clearPlaceholder(element) {
            if (element.value.startsWith('- ìíëª')) {
                element.value = '';
            }
        }

        // ìíìí ë²í¼ í´ë¦­ ì ìì ë³ê²½
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

        // ê±°ëë°©ë² ì í ì ë°°ì¡ë¹ ìµì íì
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

        // ë¬¸ìì ì¹´ì´í°
        const textarea = document.getElementById('noticeBox');
        const charCount = document.getElementById('charCount');

        textarea.addEventListener('input', () => {
            charCount.textContent = textarea.value.length;
        });
    </script>

</body>

</html>
