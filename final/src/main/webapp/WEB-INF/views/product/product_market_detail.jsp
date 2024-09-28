<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>ì í íì´ì§</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        * {
            list-style: none;
        }

        body {
            font-family: 'Arial', sans-serif;
            background-color: #fff;
            padding: 20px;
        }

        .container {
            max-width: 1200px;
            margin: 0 auto;
        }

        .product-header {
            font-size: 0.9rem;
            color: #888;
            margin-bottom: 20px;
        }

        .product-title {
            font-size: 2.2rem;
            font-weight: bold;
            margin-bottom: 20px;
        }

        .price {
            font-size: 2.8rem;
            font-weight: bold;
            color: #333;
            margin-bottom: 20px;
        }

        .price span {
            font-size: 1.2rem;
            background-color: #00c73c;
            color: white;
            padding: 5px 10px;
            border-radius: 5px;
            margin-left: 15px;
        }

        .time-info {
            font-size: 0.85rem;
            color: #888;
            margin-bottom: 30px;
        }

        .product-details {
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
            margin-bottom: 40px;
        }

        .product-image {
            flex: 1;
            margin-right: 40px;
        }

        .product-image img {
            width: 100%;
            border-radius: 5px;
        }

        .product-info {
            flex: 1.2;
            margin-left: 40px;
        }

        /* íì´ë¸ ì¤íì¼ */
        .info-table {
            width: 100%;
            border: 1px solid #e1e1e1;
            border-radius: 8px;
            text-align: center;
            margin-bottom: 30px;
            border-collapse: separate;
            border-spacing: 0;
        }

        .info-table th,
        .info-table td {
            padding: 20px;
            color: #555;
        }

        .info-table th {
            font-weight: normal;
            font-size: 0.9rem;
            color: #999;
        }

        .info-table td {
            font-weight: bold;
            font-size: 1.1rem;
            color: #333;
        }

        .info-table td+td {
            border-left: 1px solid #e1e1e1;
        }

        /* ë ë²ì§¸ íì´ë¸ */
        /* ë ë²ì§¸ íì´ë¸ ê°ê²© ì¡°ì  */
.info-table-2 {
    width: 100%;
    border: 1px solid #e1e1e1;
    border-radius: 8px;
    text-align: center;
    margin-bottom: 30px;
    border-collapse: separate;
    border-spacing: 0;
    margin-top: 30px;
    table-layout: fixed; /* ê° ì´ì í¬ê¸°ë¥¼ ê³ ì  */
}

.info-table-2 th,
.info-table-2 td {
    padding: 1px; /* í¬ê¸° ë° ê°ê²© ëì¼íê² ì¤ì  */
    color: #555;
}

.info-table-2 th {
    font-weight: normal;
    font-size: 0.9rem;
    color: #999;
}

.info-table-2 td {
    font-weight: bold;
    font-size: 1.1rem;
    color: #333;
}

.info-table-2 td+td {
    border-left: 1px solid #e1e1e1;
}


        /* ì¶ê° ì ë³´ */
        .extra-info {
            font-size: 0.9rem;
            color: #333;
            margin-bottom: 30px;
        }

        .extra-info ul {
            padding-left: 0;
            list-style: none;
        }

        .extra-info li {
            margin-bottom: 15px;
        }

        .buttons {
            display: flex;
            justify-content: space-between;
            margin-top: 30px;
        }

        .btn {
            padding: 15px 0;
            font-size: 1.2rem;
            width: 48%;
            border-radius: 8px;
            text-align: center;
            font-weight: bold;
        }

        .btn-chat {
            background-color: white;
            color: #333;
            border: 1px solid #ddd;
        }

        .btn-chat:hover {
            background-color: #f1f1f1;
        }

        .btn-safe {
            background-color: #000;
            color: white;
            border: none;
        }

        .btn-safe:hover {
            background-color: #333;
        }

        /* ìí ì ë³´ ë° ê°ê² ì ë³´ */
        .product-store-info {
            display: flex;
            justify-content: space-between;
            margin-top: 50px;
        }

        .product-info-left {
            flex: 1.5;
            margin-right: 40px;
        }

        .store-info-right {
            flex: 1;
            margin-left: 40px;
        }

        /* ê°ê² ì ë³´ ì¤íì¼ ìì  */
      .store-info-right .store-name-container {
      
       display: flex;
       align-items: center;
       justify-content: space-between;
       margin-bottom: 15px;
}

.store-info-right .store-name-container img {
    margin-right: 10px; /* ì´ë¦ê³¼ íë¡í ì¬ì§ ê°ê²© ì¡°ì  */
    border-radius: 50%;
}

        .store-info-right .store-name {
            font-size: 1.4rem;
            font-weight: bold;
            margin-bottom: 15px;
        }

        .trust-score {
            font-size: 0.9rem;
            margin-bottom: 20px;
            display: flex;
            justify-content: space-between;
        }

        .trust-bar {
            width: 100%;
            height: 10px;
            background-color: #e1e1e1;
            border-radius: 5px;
            margin-top: 10px;
            position: relative;
        }

        .trust-bar-fill {
            background-color: #00c73c;
            height: 100%;
            width: 27%;
            border-radius: 5px;
            position: absolute;
            top: 0;
            left: 0;
        }

        /* íë¨ ì ë³´ */
        .posted-product {
            display: flex;
            gap: 15px;
            margin-top: 20px;
            align-items: center;
        }

        .posted-product img {
            width: 70px;
            height: 70px;
            border-radius: 5px;
        }

        .posted-product-info {
            font-size: 0.9rem;
        }

        .profile-img {
    width: 70px;
    height: 70px;
    border-radius: 50%;
    object-fit: cover;
}

        /* ë°ìí ëìì¸ */
        @media (max-width: 768px) {
            .product-details {
                flex-direction: column;
            }

            .product-store-info {
                flex-direction: column;
            }

            .product-image,
            .product-info {
                margin-right: 0;
                margin-left: 0;
            }

            .btn {
                width: 100%;
                margin-bottom: 10px;
            }

            .buttons {
                flex-direction: column;
            }
        }
    </style>
</head>

<body>

    <div class="container">
        <!-- ìë¨ ì ë³´ -->
        <div class="product-header">í > ëª¨ë°ì¼/íë¸ë¦¿ > ì¤ë§í¸í° > ì í</div>

        <!-- ì íëª -->
        <div class="product-title">ìì´í° 13ë¯¸ë íí¬ 128ê¸°ê°</div>

        <!-- ê°ê²© -->
        <div class="price">
            300,000ì
            <span>Pay</span>
        </div>

        <!-- ìê° ì ë³´ -->
        <div class="time-info">1ìê° ì  Â· ì¡°í 13 Â· ì±í 1 Â· ì° 0</div>

        <!-- ì í ì´ë¯¸ì§ì ì ë³´ -->
        <div class="product-details">
            <!-- ì´ë¯¸ì§ -->
            <div class="product-image">
                <img src="https://via.placeholder.com/150" alt="ìí ì´ë¯¸ì§" class="img-fluid">
            </div>

            <!-- ì ë³´ -->
            <div class="product-info">
                <!-- ì²« ë²ì§¸ íì´ë¸ -->
                <table class="info-table">
                    <thead>
                        <tr>
                            <th>ì íìí</th>
                            <th>ê±°ëë°©ì</th>
                            <th>ë°°ì¡ë¹</th>
                            <th>ìì ê±°ë</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td>ì¤ê³ </td>
                            <td>ì§ê±°ë, íë°°</td>
                            <td>ë³ë</td>
                            <td>ì¬ì©</td>
                        </tr>
                    </tbody>
                </table>

                <!-- ì¶ê° ì ë³´ -->
                <div class="extra-info">
                    <ul>
                        <li><b>ê±°ëí¬ë§ì§ì­:</b> ê³ ì°1ë</li>
                        <li><b>ê²°ì íí:</b> íì´ì½ ìµë 4ë§ì ì¦ìí ì¸, KBêµ­ë¯¼ì¹´ë 18ê°ì 6% í¹ë³ í ë¶ ììë£</li>
                        <li><b>ë¬´ì´ìíí:</b> 1ë§ì ì´ì ë¬´ì´ì í ë¶</li>
                    </ul>
                </div>

                <!-- ë²í¼ -->
                <div class="buttons">
                    <button class="btn btn-chat">ì±ííê¸°</button>
                    <button class="btn btn-safe">ìì ê±°ë</button>
                </div>
            </div>
        </div>

        <!-- ìí ì ë³´ ë° ê°ê² ì ë³´ -->
        <div class="product-store-info">
            <!-- ìí ì ë³´ -->
            <div class="product-info-left">
               
                <h4 style="font-weight: bold;">ìí ì ë³´</h4>
                <div class="left-wrap" style="border-top: 1px solid #e1e1e1; margin-top: 25px;">
                <ul style="margin-top: 25px;">
                    <li>- ìíëª: ì í ìì´í° 13ë¯¸ë íí¬ 128ê¸°ê°</li>
                    <li>- ê°ê²©: 300,000ì</li>
                    <li>- êµ¬ë§¤ìê¸°: 2022ë 12ì</li>
                    <li>- ë°°í°ë¦¬ ì±ë¥: 83í¼</li>
                    <li>- í¹ì´ì¬í­: í´ëí° ë¨íì´ê³ , ì¡ì ê³¼ íë©´ìë ê¸°ì¤, íìì ìì§ë§ ì¸¡ë©´ì ìê¸°ì¤ì ì°í íë ììµëë¤. ì¬ì§ ì°¸ê³ í´ì£¼ì¸ì.</li>
                </ul>
            </div>
            </div>

            <!-- ê°ê² ì ë³´ -->
            <div class="store-info-right">
                <h4 style="font-weight: bold;">íë¡í ì ë³´</h4>
                <div class="left-wrap" style="border-top: 1px solid #e1e1e1; margin-top: 25px;">
                    <div class="store-name-container" style="margin-top: 30px;">
                        <div class="store-name">woody0226</div>
                        <img src="https://via.placeholder.com/50" alt="íë¡í ì¬ì§" width="70px;">
                    </div>                  
                <div class="trust-score" style="margin-top: 30px;">ì ë¢°ì§ì <span>272</span></div>
                <div class="trust-bar">
                    <div class="trust-bar-fill"></div>
                </div>
                <!-- ë ë²ì§¸ íì´ë¸ -->
                <table class="info-table-2">
                    <thead>
                        <tr>
                            <th>ìì ê±°ë</th>
                            <th>ê±°ëíê¸°</th>
                            <th>ë¨ê³¨</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td>1</td>
                            <td>0</td>
                            <td>2</td>
                        </tr>
                    </tbody>
                </table>

                <div class="posted-product">
                    <img src="https://via.placeholder.com/60" alt="ìì´í° 13ë¯¸ë">
                    <div class="posted-product-info">
                        ìì´í° 13ë¯¸ë íí¬ 128ê¸°ê°<br>
                        300,000ì
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>

</html>
