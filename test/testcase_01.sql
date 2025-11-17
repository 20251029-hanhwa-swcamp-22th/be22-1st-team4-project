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
DELETE  FROM TBL_USERS WHERE USER_CD = 3 ;






