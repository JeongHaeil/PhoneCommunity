document.addEventListener('DOMContentLoaded', function () {
    const manufacturerLinks = document.querySelectorAll('[data-manufacturer]');
    const carrierLinks = document.querySelectorAll('[data-carrier]');
    const divisionLinks = document.querySelectorAll('[data-division]');
    const categoryLinks = document.querySelectorAll('[data-category]');
    const productListItems = document.querySelectorAll('.plans-product-list li');
    const productSearchInput = document.getElementById('product-search');

    // 처음에는 모든 제품 숨김
    productListItems.forEach(product => product.style.display = 'none');

    // 공통된 필터 처리 함수
    function applyFilter(linkGroup, activeClass = 'active') {
        linkGroup.forEach(link => {
            link.addEventListener('click', function(e) {
                e.preventDefault();
                // 같은 그룹 내의 다른 항목에서 active 클래스 제거
                linkGroup.forEach(link => link.classList.remove(activeClass));
                // 선택된 항목에 active 클래스 추가
                this.classList.add(activeClass);
            });
        });
    }

    // 각 필터 그룹에 독립적인 이벤트 리스너 적용
    applyFilter(manufacturerLinks);
    applyFilter(carrierLinks);
    applyFilter(divisionLinks);
    applyFilter(categoryLinks);

    // 제조사 클릭 시 해당 제품만 표시
    manufacturerLinks.forEach(link => {
        link.addEventListener('click', function(e) {
            e.preventDefault();
            const selectedManufacturer = this.dataset.manufacturer;
            productListItems.forEach(product => {
                product.style.display = 'none'; // 모든 제품 숨김
                if (product.querySelector('.plans-product-name').getAttribute('data-manufacturer') === selectedManufacturer) {
                    product.style.display = 'flex'; // 선택된 제조사의 제품만 표시
                }
            });
        });
    });

    // 제품 클릭 시 제품 이름을 검색창에 입력
    document.querySelector('.plans-product-list').addEventListener('click', function(e) {
        if (e.target.classList.contains('plans-product-name')) {
            productSearchInput.value = e.target.innerText;
        }
    });
});
