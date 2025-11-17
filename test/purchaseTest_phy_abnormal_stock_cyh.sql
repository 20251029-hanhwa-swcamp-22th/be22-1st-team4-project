# 데이터 초기화
CALL SP_RESET_TEST_DATA();

# 테스트 데이터 입력
CALL INPUT_DATA();

/* Abnormal Case. 재고 부족한 경우에 장바구니 추가 */

SELECT VARIANT_NM,VARIANT_STOCK_CNT FROM TBL_PRODUCT_VARIANTS; # 재고 확인

# 재고 숫자 0으로 만들기
UPDATE TBL_PRODUCT_VARIANTS
SET VARIANT_STOCK_CNT = 0
WHERE VARIANT_CD = 201;    -- 티셔츠 Size L

SELECT VARIANT_NM,VARIANT_STOCK_CNT FROM TBL_PRODUCT_VARIANTS; # 201번 재고 0으로 변하는거 확인

# 장바구니 추가
# SELECT * FROM TBL_CARTS;
# INSERT INTO TBL_CARTS (USER_CD, VARIANT_CD, CART_QTY_CNT)
# VALUES (1001, 201, 1);

# 기 입력된 장바구니가 입력하려는것과 같아서 문제가 발생함.
# 장바구니 추가를 장바구니 수량 변경용 프로시저를 활용해 진행함

# 수정 후 테스트

# 데이터 초기화
CALL SP_RESET_TEST_DATA();

# 테스트 데이터 입력
CALL INPUT_DATA();

SELECT * FROM TBL_CARTS; # 기존 장바구니 수량 확인
CALL PROC_ADD_TO_CART_SAFE(1001, 201, 1); # 동일 상품 1개 추가
SELECT * FROM TBL_CARTS; # 장바구니 수량 1개 증가 확인

SELECT * FROM TBL_CARTS; # 기존 장바구니 수량 확인
CALL PROC_UPDATE_CART_QTY_SAFE(1001, 201, 5); # 동일 상품 5개로 변경
SELECT * FROM TBL_CARTS; # 구매 제한이 1개로 걸려 있어 1개로 강제 변경

# 구매 제한 수량 변경
UPDATE TBL_PRODUCT_VARIANTS
SET VARIANT_STOCK_CNT = 999,
    VARIANT_GUMAE_LIMIT = 999
WHERE VARIANT_CD = 201;

SELECT * FROM TBL_CARTS; # 기존 장바구니 수량 확인
CALL PROC_UPDATE_CART_QTY_SAFE(1001, 201, 5); # 동일 상품 5개로 변경
SELECT * FROM TBL_CARTS; # 5개로 변경 확인

# 장바구니의 수량을 0으로 변경한 경우
SELECT * FROM TBL_CARTS; # 기존 장바구니 수량 확인
CALL PROC_UPDATE_CART_QTY_SAFE(1001, 201, 0); # 상품 0개로 변경
SELECT * FROM TBL_CARTS; # 장바구니 삭제 확인

# 기존 장바구니에 제품이 담겨있었는데 재고가 사라진 경우

CALL PROC_UPDATE_CART_QTY_SAFE(1001, 201, 1); # 기존 장바구니 1개
SELECT VARIANT_NM,VARIANT_STOCK_CNT FROM TBL_PRODUCT_VARIANTS; # 기존 재고 확인
SELECT * FROM TBL_CARTS; # 기존 장바구니 수량 확인

# 재고 숫자 0으로 만들기
UPDATE TBL_PRODUCT_VARIANTS
SET VARIANT_STOCK_CNT = 0
WHERE VARIANT_CD = 201;    -- 티셔츠 Size L

CALL PROC_UPDATE_CART_QTY_SAFE(1001, 201, 1); # 장바구니 업데이트
SELECT * FROM TBL_CARTS; # 장바구니에서 내용 삭제 확인