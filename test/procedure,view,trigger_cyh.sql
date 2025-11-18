# 테스트용 procedure, trigger, view

# 0. 테스트용 시퀀스 생성기
CREATE TABLE IF NOT EXISTS TBL_TEST_SEQ (
    SEQ_NAME VARCHAR(50) PRIMARY KEY,
    SEQ_VAL INT NOT NULL
);

DELIMITER $$

DROP PROCEDURE IF EXISTS SP_GET_NEXT_SEQ$$
CREATE PROCEDURE SP_GET_NEXT_SEQ(
    IN  p_seq_name VARCHAR(50),
    OUT p_next_val  INT
)
BEGIN
    DECLARE v_val INT;

    START TRANSACTION;

    -- 락을 걸어서 동시성 방지
    SELECT SEQ_VAL INTO v_val
    FROM TBL_TEST_SEQ
    WHERE SEQ_NAME = p_seq_name
    FOR UPDATE;

    IF v_val IS NULL THEN
        -- 존재하지 않으면 새로 삽입하고 1 반환 (원하면 초기값 변경)
        INSERT INTO TBL_TEST_SEQ(SEQ_NAME, SEQ_VAL) VALUES (p_seq_name, 1);
        SET v_val = 1;
    ELSE
        SET v_val = v_val + 1;
        UPDATE TBL_TEST_SEQ SET SEQ_VAL = v_val WHERE SEQ_NAME = p_seq_name;
    END IF;

    COMMIT;

    SET p_next_val = v_val;
END$$

DELIMITER ;

# 1. 데이터 초기화용 procedure
DELIMITER $$

CREATE OR REPLACE PROCEDURE SP_RESET_TEST_DATA()
BEGIN
    /** FK 체크 비활성화 **/
    SET FOREIGN_KEY_CHECKS = 0;


    -- 1단계: 최하위 의존성(자식 테이블)부터 초기화
    TRUNCATE TABLE TBL_ORDER_DETAILS;
    TRUNCATE TABLE TBL_GFC_ORDER;
    TRUNCATE TABLE TBL_ORDER_PHY;
    TRUNCATE TABLE TBL_ORDERS;
    TRUNCATE TABLE TBL_DELIVERY_PHY;
    TRUNCATE TABLE TBL_ORDER_HISTORY;
    TRUNCATE TABLE TBL_CARTS;

    TRUNCATE TABLE TBL_PRODUCTS_FOOD_SPECS;
    TRUNCATE TABLE TBL_PRODUCTS_DRINK_SPECS;
    TRUNCATE TABLE TBL_PRODUCTS_GOODS_SPECS;
    TRUNCATE TABLE TBL_PRODUCTS_PACKAGE_SPECS;

    TRUNCATE TABLE TBL_POST_IMAGES;
    TRUNCATE TABLE TBL_COMMENT;

    TRUNCATE TABLE TBL_MOVIE_CAST;
    TRUNCATE TABLE TBL_MOVIE_GENRES;

    TRUNCATE TABLE TBL_USER_COUPONS;
    TRUNCATE TABLE TBL_REPORTS;
    TRUNCATE TABLE TBL_REVIEWS;
    TRUNCATE TABLE TBL_NOTIFICATIONS;
    TRUNCATE TABLE TBL_USER_SOCIAL_ACCOUNTS;

    -- 2단계: 중간 레벨 테이블
    TRUNCATE TABLE TBL_VARIANT_SALE_GB;
    TRUNCATE TABLE TBL_PRODUCT_VARIANTS;
    TRUNCATE TABLE TBL_COUPONS;

    TRUNCATE TABLE TBL_CARTS;

    TRUNCATE TABLE TBL_GFC_SEND;
    TRUNCATE TABLE TBL_GFC_SEND_ST;
    TRUNCATE TABLE TBL_GFC_SEND_TYPE;

    TRUNCATE TABLE TBL_ST_PHY;

    TRUNCATE TABLE TBL_POSTS;

    TRUNCATE TABLE TBL_PRODUCTS;
    TRUNCATE TABLE TBL_PRODUCT_TYPE;
    TRUNCATE TABLE TBL_PRODUCT_CATEGORIES;

    TRUNCATE TABLE TBL_POST_CATEGORIES;

    TRUNCATE TABLE TBL_GENRES;
    TRUNCATE TABLE TBL_MOVIES;

    TRUNCATE TABLE TBL_COUPON_DISCOUNT_GB;
    TRUNCATE TABLE TBL_REPORT_GB;

    -- 3단계: 최상위 부모 테이블
    TRUNCATE TABLE TBL_USERS;

    /** FK 다시 활성화 **/
    SET FOREIGN_KEY_CHECKS = 1;
END$$

DELIMITER ;

# 2. 주문 생성 시, 재고 차감용 trigger (실물 상품만)

DELIMITER $$
## ORDER DETAIL 데이터 삽입 시 발생
CREATE OR REPLACE TRIGGER TRG_ORDER_DETAILS_STOCK_DOWN
AFTER INSERT ON TBL_ORDER_DETAILS
FOR EACH ROW
BEGIN
    DECLARE v_product_type INT;

    -- 주문된 옵션의 상품 타입 가져오기
    SELECT P.PRODUCT_TYPE_CD INTO v_product_type
    FROM TBL_PRODUCT_VARIANTS V
    JOIN TBL_PRODUCTS P ON V.PRODUCT_CD = P.PRODUCT_CD
    WHERE V.VARIANT_CD = NEW.VARIANT_CD;

    -- 실물(1 = PHYSICAL)일 경우에만 재고 차감
    IF v_product_type = 1 THEN
        UPDATE TBL_PRODUCT_VARIANTS
        SET VARIANT_STOCK_CNT = VARIANT_STOCK_CNT - NEW.ORD_DETL_QTY_CNT
        WHERE VARIANT_CD = NEW.VARIANT_CD;
    END IF;

END$$

DELIMITER ;

# 장바구니 항목 중복 시 수량 증가
DELIMITER $$

CREATE PROCEDURE PROC_ADD_TO_CART_SAFE(
    IN p_user_cd BIGINT,
    IN p_variant_cd INT,
    IN p_add_qty INT
)
BEGIN
    DECLARE v_qty INT DEFAULT 0;
    DECLARE v_stock INT DEFAULT 0;

    -- 옵션 재고 조회
    SELECT VARIANT_STOCK_CNT
      INTO v_stock
      FROM TBL_PRODUCT_VARIANTS
     WHERE VARIANT_CD = p_variant_cd;

    -- 기존 장바구니 조회
    SELECT CART_QTY_CNT
      INTO v_qty
      FROM TBL_CARTS
     WHERE USER_CD = p_user_cd
       AND VARIANT_CD = p_variant_cd;

    IF v_qty IS NULL THEN
        SET v_qty = 0;
    END IF;

    -- 새 수량 계산
    SET v_qty = v_qty + p_add_qty;

    -- 재고 이상이면 재고 수로 제한
    IF v_qty > v_stock THEN
        SET v_qty = v_stock;
    END IF;

    -- Insert or Update
    INSERT INTO TBL_CARTS(USER_CD, VARIANT_CD, CART_QTY_CNT, CART_REG_DTTM)
    VALUES(p_user_cd, p_variant_cd, v_qty, NOW())
    ON DUPLICATE KEY UPDATE
        CART_QTY_CNT = v_qty;

END $$

DELIMITER ;

## 장바구니 수량 업데이트
DELIMITER $$

DROP PROCEDURE IF EXISTS PROC_UPDATE_CART_QTY_SAFE $$
CREATE PROCEDURE PROC_UPDATE_CART_QTY_SAFE(
    IN p_user_cd BIGINT,
    IN p_variant_cd INT,
    IN p_new_qty INT
)
BEGIN
    DECLARE v_stock INT DEFAULT NULL;
    DECLARE v_limit INT DEFAULT 0;
    DECLARE v_type INT DEFAULT 0;
    DECLARE v_existing INT DEFAULT NULL;
    DECLARE v_existing_type INT DEFAULT NULL;

    START TRANSACTION;

    /* 1) 옵션 + 상품 타입 정보 조회 (FOR UPDATE) */
    SELECT V.VARIANT_STOCK_CNT,
           IFNULL(V.VARIANT_GUMAE_LIMIT, 0),
           P.PRODUCT_TYPE_CD
      INTO v_stock, v_limit, v_type
      FROM TBL_PRODUCT_VARIANTS V
      JOIN TBL_PRODUCTS P ON V.PRODUCT_CD = P.PRODUCT_CD
     WHERE V.VARIANT_CD = p_variant_cd
     FOR UPDATE;

    /* 옵션이 없으면 오류 */
    IF v_stock IS NULL THEN
        ROLLBACK;
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '옵션(variant) 없음';
    ELSE
        /* 재고가 0이면 즉시 삭제 처리 및 종료 */
        IF v_stock = 0 THEN
            DELETE FROM TBL_CARTS
             WHERE USER_CD = p_user_cd
               AND VARIANT_CD = p_variant_cd;

            COMMIT;
            SELECT 'DELETED_STOCK_ZERO' AS RESULT;
        ELSE
            /* 2) 장바구니에 다른 타입(실물/기프티콘) 존재 여부 체크 */
            SELECT PP.PRODUCT_TYPE_CD
              INTO v_existing_type
              FROM TBL_CARTS C
              JOIN TBL_PRODUCT_VARIANTS VV ON C.VARIANT_CD = VV.VARIANT_CD
              JOIN TBL_PRODUCTS PP ON VV.PRODUCT_CD = PP.PRODUCT_CD
             WHERE C.USER_CD = p_user_cd
               AND VV.VARIANT_CD <> p_variant_cd
             LIMIT 1;

            IF v_existing_type IS NOT NULL AND v_existing_type <> v_type THEN
                ROLLBACK;
                SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '장바구니에 다른 상품 타입이 존재함(실물/기프티콘 충돌)';
            ELSE
                /* 3) 기존 장바구니 수량 조회 */
                SELECT CART_QTY_CNT
                  INTO v_existing
                  FROM TBL_CARTS
                 WHERE USER_CD = p_user_cd
                   AND VARIANT_CD = p_variant_cd
                 FOR UPDATE;

                /* 만약 요청 수량이 0 이하이면 삭제 처리 */
                IF p_new_qty <= 0 THEN
                    DELETE FROM TBL_CARTS
                     WHERE USER_CD = p_user_cd
                       AND VARIANT_CD = p_variant_cd;

                    COMMIT;
                    SELECT 'DELETED' AS RESULT;
                ELSE
                    /* 재고/구매한도 적용 */
                    IF v_limit = 0 THEN
                        SET v_limit = v_stock;
                    END IF;

                    IF p_new_qty > v_stock THEN
                        SET p_new_qty = v_stock;
                    END IF;

                    IF p_new_qty > v_limit THEN
                        SET p_new_qty = v_limit;
                    END IF;

                    /* Insert or Update */
                    IF v_existing IS NULL THEN
                        INSERT INTO TBL_CARTS (USER_CD, VARIANT_CD, CART_QTY_CNT, CART_REG_DTTM)
                        VALUES (p_user_cd, p_variant_cd, p_new_qty, NOW());
                    ELSE
                        UPDATE TBL_CARTS
                           SET CART_QTY_CNT = p_new_qty,
                               CART_REG_DTTM = NOW()
                         WHERE USER_CD = p_user_cd
                           AND VARIANT_CD = p_variant_cd;
                    END IF;

                    COMMIT;

                    SELECT USER_CD, VARIANT_CD, CART_QTY_CNT
                      FROM TBL_CARTS
                     WHERE USER_CD = p_user_cd
                       AND VARIANT_CD = p_variant_cd;
                END IF; /* p_new_qty <= 0 */
            END IF; /* type conflict */
        END IF; /* v_stock = 0 */
    END IF; /* v_stock is null */

END $$
DELIMITER ;