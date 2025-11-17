INSERT INTO TBL_USERS (
    `USER_ID`,
	`USER_PW`,
	`USER_NICK_NM`,
	`USER_EMAIL`,
    `USER_NM`,
	`USER_TEL`,
	`USER_BIRTH_DT`,
	`USER_SEX_GB`,
	`USER_JUSO`,
	`USER_JUSO_D`
)
VALUES (
    'test1', -- 회원 아이디 (중복 불가 조건이 없다면 임의 값 사용)
    'test1', -- 비밀번호 (실제 환경에서는 해시된 값, 테스트에서는 임의의 해시 문자열)
    '김길동', -- 닉네임 (중복 불가 조건이 있다면 임의 값 사용)
    'test1@test.com', -- 이메일 (사전 조건: 중복되지 않은 이메일)
    '홍길동', -- 실명
    '010-1234-1234', -- 전화번호
    '2000-09-20', -- 생년월일
    'M', -- 성별 구분 (M 또는 F)
    '서울시 강남구', -- 주소
    '역삼동 123-45' -- 상세주소
);

INSERT INTO TBL_USERS (
    `USER_ID`,
	`USER_PW`,
	`USER_NICK_NM`,
	`USER_EMAIL`,
    `USER_NM`,
	`USER_TEL`,
	`USER_BIRTH_DT`,
	`USER_SEX_GB`,
	`USER_JUSO`,
	`USER_JUSO_D`
)
VALUES (
    'test2', -- 회원 아이디 (중복 불가 조건이 없다면 임의 값 사용)
    'test2', -- 비밀번호 (실제 환경에서는 해시된 값, 테스트에서는 임의의 해시 문자열)
    '유길동', -- 닉네임 (중복 불가 조건이 있다면 임의 값 사용)
    'test1@test.com', -- 이메일 (사전 조건: 중복되지 않은 이메일)
    '박길동', -- 실명
    '010-2312-1234', -- 전화번호
    '2000-02-20', -- 생년월일
    'M', -- 성별 구분 (M 또는 F)
    '서울시 강남구', -- 주소
    '신사동 23-45' -- 상세주소
);


select *
FROM TBL_USERS;

SELECT
    USER_CD,
    USER_PW,
    USER_EMAIL,
    USER_ST
FROM
    TBL_USERS
WHERE
    USER_ID = 'test1';


ALTER TABLE TBL_USERS AUTO_INCREMENT = 1;
DELETE  FROM TBL_USERS WHERE USER_CD = 1 ;


-- 기존 프로시저가 있다면 삭제
DROP PROCEDURE IF EXISTS GenerateTestUsers;

-- 딜리미터를 변경하여 프로시저 본문 내의 세미콜론(;)이 쿼리 종료로 인식되지 않게 합니다.
DELIMITER $$

-- 테스트 회원 데이터를 생성하는 프로시저 정의
CREATE PROCEDURE GenerateTestUsers()
BEGIN
    -- 루프 카운터 변수
    DECLARE i INT DEFAULT 1;
    -- 생성할 최종 데이터 수
    DECLARE max_count INT DEFAULT 100;

    -- 회원 아이디, 닉네임, 이메일 생성을 위한 변수
    DECLARE v_id VARCHAR(50);
    DECLARE v_nick_nm VARCHAR(50);
    DECLARE v_email VARCHAR(100);
    DECLARE v_tel VARCHAR(20);
    DECLARE v_birth_date DATE;
    DECLARE v_sex CHAR(1);
    DECLARE v_name VARCHAR(50);

    -- 루프 시작
    WHILE i <= max_count DO
        -- 1. 고유한 아이디, 닉네임, 이메일 생성
        SET v_id = CONCAT('testuser', LPAD(i, 3, '0'));
        SET v_nick_nm = CONCAT('테스트닉네임', i);
        SET v_email = CONCAT('test', LPAD(i, 3, '0'), '@testdomain.com');
        SET v_name = CONCAT('홍길동', i);

        -- 2. 랜덤 전화번호 생성 (010-XXXX-XXXX 형식)
        SET v_tel = CONCAT('010-',
                           LPAD(FLOOR(RAND() * 9000) + 1000, 4, '0'),
                           '-',
                           LPAD(FLOOR(RAND() * 9000) + 1000, 4, '0'));

        -- 3. 랜덤 생년월일 생성 (1980년 1월 1일 ~ 2005년 12월 31일 사이)
        SET v_birth_date = DATE_ADD('1980-01-01', INTERVAL FLOOR(RAND() * 9500) DAY); -- 약 26년치 랜덤

        -- 4. 랜덤 성별 생성
        SET v_sex = IF(RAND() > 0.5, 'M', 'F');

        -- 5. TBL_USERS 테이블에 데이터 삽입
        INSERT INTO TBL_USERS (
            USER_ID,
            USER_PW, -- 간단한 테스트 비밀번호 (실제 운영 환경에서는 반드시 해싱하세요)
            USER_NICK_NM,
            USER_EMAIL,
            USER_LV,
            USER_ST,
            USER_NM,
            USER_TEL,
            USER_BIRTH_DT,
            USER_SEX_GB,
            USER_JUSO,
            USER_JUSO_D
        ) VALUES (
            v_id,
            SHA2('1234', 256), -- '1234'를 SHA-256으로 해싱하여 저장
            v_nick_nm,
            v_email,
            FLOOR(RAND() * 4) + 1, -- 1에서 4 사이의 레벨
            'ACTIVE',
            v_name,
            v_tel,
            v_birth_date,
            v_sex,
            CONCAT('테스트시 테스트구 테스트동', i),
            CONCAT('테스트아파트 ', LPAD(i, 3, '0'), '호')
        );

        -- 카운터 증가
        SET i = i + 1;
    END WHILE;

END$$

-- 딜리미터를 원래대로 복구
DELIMITER ;


CALL GenerateTestUsers();
SELECT * FROM TBL_USERS;



-- 기존 트리거가 있다면 삭제 (선택 사항)
DROP TRIGGER IF EXISTS trg_TBL_USERS_UpdateModDttm;

-- 딜리미터 변경
DELIMITER $$

-- 트리거 정의
CREATE TRIGGER trg_TBL_USERS_UpdateModDttm
BEFORE UPDATE ON TBL_USERS
FOR EACH ROW
BEGIN
    -- USER_MOD_DTTM을 현재 시각으로 설정
    SET NEW.USER_MOD_DTTM = NOW();
END$$

-- 딜리미터 원래대로 복구
DELIMITER ;

SELECT
    USER_CD,
    USER_NICK_NM,
    USER_MOD_DTTM
FROM
    TBL_USERS
WHERE
    USER_CD = 1;

-- 참고: 이 시점의 USER_MOD_DTTM 값을 기억해두세요.



-- 트리거 작동을 명확히 확인하기 위해 잠시 대기 시간(예: 1초)을 두는 것이 좋습니다.
-- MySQL 쿼리에는 sleep 명령어가 없으므로, 필요하다면 터미널에서 수동으로 잠시 대기합니다.
-- 또는 아래 쿼리를 1초 후에 실행한다고 가정합니다.

UPDATE
    TBL_USERS
SET
    USER_NICK_NM = '업데이트된_테스트닉네임'
WHERE
    USER_CD = 1;



SELECT
    USER_CD,
    USER_NICK_NM,
    USER_MOD_DTTM
FROM
    TBL_USERS
WHERE
    USER_CD = 1;

-- 예상 결과: USER_NICK_NM이 '업데이트된_테스트닉네임'으로 바뀌고,
-- USER_MOD_DTTM은 UPDATE 쿼리를 실행한 시점으로 변경되어야 합니다.

DROP TRIGGER IF EXISTS trg_TBL_USERS_UpdateModDttm;

DELETE FROM TBL_USERS;
SELECT * FROM TBL_USERS;



