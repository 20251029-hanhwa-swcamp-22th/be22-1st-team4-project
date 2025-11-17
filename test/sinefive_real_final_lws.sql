/*-- =======================================================================
-- 제약 조건 설정을 위해 잠시 FK 체크를 비활성화합니다.
-- =======================================================================
SET foreign_key_checks = 0;

-- =======================================================================
-- (필수 선행) TBL_USERS : 회원 (참조 대상 테이블)
-- : TBL_NOTIFICATIONS와 TBL_REPORTS가 참조해야 하므로 먼저 생성합니다.
-- =======================================================================
DROP TABLE IF EXISTS `TBL_USERS`;
CREATE TABLE `TBL_USERS` (
    `USER_CD`
        INT    NOT NULL AUTO_INCREMENT COMMENT '회원 코드 (PK)',
    `USER_ID`
        VARCHAR(50)    NOT NULL COMMENT '회원 아이디',
    `USER_PW`
        VARCHAR(255)   NULL COMMENT '비밀번호',
    `USER_NICK_NM`
        VARCHAR(50)    NOT NULL COMMENT '닉네임',
    `USER_EMAIL`
        VARCHAR(100)   NOT NULL COMMENT '이메일',
    CONSTRAINT `PK_TBL_USERS` PRIMARY KEY (`USER_CD`)
);

-- =======================================================================
-- TBL_REPORT_GB : 신고 구분 (사용자 제공)
-- =======================================================================
DROP TABLE IF EXISTS `TBL_REPORT_GB`;
CREATE TABLE `TBL_REPORT_GB` (
    `REPORT_GB`
        INT    NOT NULL AUTO_INCREMENT    COMMENT '신고 구분 코드 (PK)',
    `REPORT_GB_NM`
        VARCHAR(50)    NOT NULL   COMMENT '신고 구분명 (한글) 게시글/댓글/리뷰',
    CONSTRAINT `PK_TBL_REPORT_GB` PRIMARY KEY (
       `REPORT_GB`
    )
);

-- =======================================================================
-- TBL_MOVIES : 영화 (사용자 제공)
-- =======================================================================
DROP TABLE IF EXISTS `TBL_MOVIES`;
CREATE TABLE `TBL_MOVIES` (
    `MOVIE_CD`
        INT    NOT NULL AUTO_INCREMENT    COMMENT '영화 코드 (PK)',
    `MOVIE_NM`
        VARCHAR(255)   NOT NULL   COMMENT '영화 제목',
    `MOVIE_REG_DTTM`
        DATETIME   NOT NULL   DEFAULT NOW()  COMMENT '데이터 등록일시',
    `MOVIE_OVERVIEW`
        VARCHAR(1000)  NOT NULL   COMMENT '줄거리',
    `RELEASE_DT`
        DATE   NULL   COMMENT '개봉일',
    `RUNTIME`
        INT    NULL   COMMENT '런타임 (분 단위)',
    `POSTER_URL`
        VARCHAR(255)   NULL   COMMENT '포스터 이미지 URL',
    CONSTRAINT `PK_TBL_MOVIES` PRIMARY KEY (
       `MOVIE_CD`
    )
);

-- =======================================================================
-- TBL_REPORTS : 신고 (사용자 제공)
-- =======================================================================
DROP TABLE IF EXISTS `TBL_REPORTS`;
CREATE TABLE `TBL_REPORTS` (
    `REPORT_CD`
        INT    NOT NULL AUTO_INCREMENT    COMMENT '신고 코드 (PK)',
    `REPORT_GB`
        INT    NOT NULL   COMMENT '신고 구분 코드 (FK)',
    `REPORT_USER_CD`
        INT    NOT NULL   COMMENT '신고자 코드',
    `TARGET_USER_CD`
        INT    NOT NULL   COMMENT '신고 대상자 코드',
    `REPORT_REASON`
        VARCHAR(255)   NOT NULL   COMMENT '신고 사유',
    `REPORT_ST`
        INT    NOT NULL   DEFAULT 0  COMMENT '처리 상태',
    `REPORT_REG_DTTM`
        DATETIME   NOT NULL   DEFAULT NOW()  COMMENT '신고일시',
    CONSTRAINT `PK_TBL_REPORTS` PRIMARY KEY (
       `REPORT_CD`
    ),
    CONSTRAINT `FK_TBL_REPORT_GB_TO_TBL_REPORTS_1` FOREIGN KEY (
       `REPORT_GB`
    )
    REFERENCES `TBL_REPORT_GB` (
       `REPORT_GB`
    ),
    CONSTRAINT `FK_TBL_USERS_TO_TBL_REPORTS_1` FOREIGN KEY (
       `REPORT_USER_CD`
    )
    REFERENCES `TBL_USERS` (
       `USER_CD`
    ),
    CONSTRAINT `FK_TBL_USERS_TO_TBL_REPORTS_2` FOREIGN KEY (
       `TARGET_USER_CD`
    )
    REFERENCES `TBL_USERS` (
       `USER_CD`
    )
);

-- =======================================================================
-- TBL_NOTIFICATIONS : 알림 (사용자 제공)
-- =======================================================================
DROP TABLE IF EXISTS `TBL_NOTIFICATIONS`;
CREATE TABLE `TBL_NOTIFICATIONS` (
    `NOTI_CD`
        INT    NOT NULL AUTO_INCREMENT COMMENT '알림 코드 (PK)',
    `USER_CD`
        INT    NOT NULL COMMENT '수신자 회원 코드 (FK)',
    `NOTI_CONT`
        VARCHAR(1000)  NOT NULL COMMENT '알림 내용',
    `READ_FG`
        INT    NOT NULL   DEFAULT 0 COMMENT '읽음 여부',
    `NOTI_REG_DTTM`
        DATETIME   NOT NULL   DEFAULT NOW() COMMENT '생성일시',
    CONSTRAINT `PK_TBL_NOTIFICATIONS` PRIMARY KEY (`NOTI_CD`),
    CONSTRAINT `FK_TBL_USERS_TO_TBL_NOTIFICATIONS_1` FOREIGN KEY (`USER_CD`) REFERENCES `TBL_USERS` (`USER_CD`)
);

-- =======================================================================
-- --- (시작) 시나리오 기반 테스트 데이터 INSERT ---
-- =======================================================================


INSERT INTO
    `TBL_REPORT_GB` (REPORT_GB_NM)
VALUES
       ('욕설/비방'),
       ('스포일러'),
       ('광고/홍보');

SET @REPORT_TYPE_SPOILER = 2;



INSERT INTO
    `TBL_MOVIES` (
                          MOVIE_NM,
                          MOVIE_OVERVIEW,
                          RELEASE_DT,
                          RUNTIME
)
VALUES
    ('인셉션',
        '꿈 속의 꿈으로 들어가는 이야기',
        '2010-07-21',
        148);



INSERT INTO
    `TBL_USERS` (
                         USER_ID,
                         USER_NICK_NM,
                         USER_EMAIL
)
VALUES ('clean_user', '순정가이', 'userA@test.com');

SET @REPORTER_USER_CD = LAST_INSERT_ID();


INSERT INTO `TBL_USERS` (USER_ID, USER_NICK_NM, USER_EMAIL)
VALUES ('spoiler_king', '빅스포맨', 'userB@test.com');

SET @TARGET_USER_CD = LAST_INSERT_ID();



INSERT INTO
    `TBL_REPORTS`
    (
     REPORT_GB,
     REPORT_USER_CD,
     TARGET_USER_CD,
     REPORT_REASON,
     REPORT_ST
    )
VALUES
    (@REPORT_TYPE_SPOILER,
     @REPORTER_USER_CD,
     @TARGET_USER_CD,
     '내일 볼려고했는데 마지막 팽이 결말을 스포당했어요.',
     0
    );


SET
    @REPORT_CD = LAST_INSERT_ID();



INSERT INTO
    `TBL_NOTIFICATIONS`
    (
     USER_CD,
     NOTI_CONT,
     READ_FG
    )
VALUES
    (
     @REPORTER_USER_CD,
     '회원님의 신고(사유: 스포일러)가 정상적으로 접수되었습니다. 긍정적으로 검토 후 처리하겠습니다.',
     0
    );



INSERT INTO
    `TBL_NOTIFICATIONS`
    (
     USER_CD,
     NOTI_CONT,
     READ_FG
    )
VALUES
    (
     @TARGET_USER_CD,
     '회원님의 리뷰가 "스포일러" 사유로 신고되어 정지 처리되었습니다.',
     0
    );



UPDATE
    `TBL_REPORTS`
SET
    REPORT_ST = 1
WHERE
    REPORT_CD = @REPORT_CD;


SET foreign_key_checks = 1;



SELECT
    'TBL_REPORT_GB' AS TABLE_NAME, * FROM TBL_REPORT_GB;
SELECT
    'TBL_MOVIES' AS TABLE_NAME, * FROM TBL_MOVIES;
SELECT
    'TBL_USERS' AS TABLE_NAME, USER_CD, USER_NICK_NM, USER_ID FROM TBL_USERS;


SELECT
    R.REPORT_CD AS 신고번호,
    UR.USER_NICK_NM AS 신고자,
    UT.USER_NICK_NM AS 피신고자,
    GB.REPORT_GB_NM AS 신고유형,
    R.REPORT_REASON AS 신고내용,
    CASE R.REPORT_ST WHEN 1 THEN ' 처리완료' ELSE ' 접수됨' END AS 처리상태,
    R.REPORT_REG_DTTM AS 신고일시
FROM
    TBL_REPORTS R
JOIN
    TBL_USERS UR ON R.REPORT_USER_CD = UR.USER_CD -- 신고자 JOIN
JOIN
    TBL_USERS UT ON R.TARGET_USER_CD = UT.USER_CD -- 피신고자 JOIN
JOIN
    TBL_REPORT_GB GB ON R.REPORT_GB = GB.REPORT_GB;



SELECT
    N.NOTI_CD AS 알림번호,
    U.USER_NICK_NM AS 수신자,
    N.NOTI_CONT AS 알림내용,
    CASE
        N.READ_FG WHEN 1 THEN '읽음' ELSE '안 읽음' END AS 읽음여부,
    N.NOTI_REG_DTTM AS 발송일시
FROM
    TBL_NOTIFICATIONS N
JOIN
        TBL_USERS U ON N.USER_CD = U.USER_CD
ORDER BY
    N.NOTI_REG_DTTM DESC;*/

       -- =======================================================================
-- 위에꺼 안되서 잼민이 찬스
-- =======================================================================

    -- =======================================================================
-- 1. 환경 설정 및 클린 실행 준비
-- =======================================================================
-- 데이터베이스를 선택하세요. (필수: 이 줄을 실행 환경에 맞게 수정하세요)
-- USE your_database_name;

SET foreign_key_checks = 0;

-- -----------------------------------------------------------------------
-- 2. 테이블 생성 (DDL 구문 정리)
-- -----------------------------------------------------------------------

-- TBL_USERS : 회원
DROP TABLE IF EXISTS `TBL_USERS`;
CREATE TABLE `TBL_USERS` (
    `USER_CD`      INT          NOT NULL AUTO_INCREMENT COMMENT '회원 코드 (PK)',
    `USER_ID`      VARCHAR(50)  NOT NULL COMMENT '회원 아이디',
    `USER_PW`      VARCHAR(255) NULL     COMMENT '비밀번호',
    `USER_NICK_NM` VARCHAR(50)  NOT NULL COMMENT '닉네임',
    `USER_EMAIL`   VARCHAR(100) NOT NULL COMMENT '이메일',
    CONSTRAINT `PK_TBL_USERS` PRIMARY KEY (`USER_CD`)
);

-- TBL_REPORT_GB : 신고 구분
DROP TABLE IF EXISTS `TBL_REPORT_GB`;
CREATE TABLE `TBL_REPORT_GB` (
    `REPORT_GB`    INT          NOT NULL AUTO_INCREMENT COMMENT '신고 구분 코드 (PK)',
    `REPORT_GB_NM` VARCHAR(50)  NOT NULL COMMENT '신고 구분명',
    CONSTRAINT `PK_TBL_REPORT_GB` PRIMARY KEY (`REPORT_GB`)
);

-- TBL_MOVIES : 영화
DROP TABLE IF EXISTS `TBL_MOVIES`;
CREATE TABLE `TBL_MOVIES` (
    `MOVIE_CD`       INT           NOT NULL AUTO_INCREMENT COMMENT '영화 코드 (PK)',
    `MOVIE_NM`       VARCHAR(255)  NOT NULL COMMENT '영화 제목',
    `MOVIE_REG_DTTM` DATETIME      NOT NULL DEFAULT NOW() COMMENT '데이터 등록일시',
    `MOVIE_OVERVIEW` VARCHAR(1000) NOT NULL COMMENT '줄거리',
    `RELEASE_DT`     DATE          NULL COMMENT '개봉일',
    `RUNTIME`        INT           NULL COMMENT '런타임 (분 단위)',
    `POSTER_URL`     VARCHAR(255)  NULL COMMENT '포스터 이미지 URL',
    CONSTRAINT `PK_TBL_MOVIES` PRIMARY KEY (`MOVIE_CD`)
);

-- TBL_REPORTS : 신고
DROP TABLE IF EXISTS `TBL_REPORTS`;
CREATE TABLE `TBL_REPORTS` (
    `REPORT_CD`      INT          NOT NULL AUTO_INCREMENT COMMENT '신고 코드 (PK)',
    `REPORT_GB`      INT          NOT NULL COMMENT '신고 구분 코드 (FK)',
    `REPORT_USER_CD` INT          NOT NULL COMMENT '신고자 코드',
    `TARGET_USER_CD` INT          NOT NULL COMMENT '신고 대상자 코드',
    `REPORT_REASON`  VARCHAR(255) NOT NULL COMMENT '신고 사유',
    `REPORT_ST`      INT          NOT NULL DEFAULT 0 COMMENT '처리 상태',
    `REPORT_REG_DTTM` DATETIME    NOT NULL DEFAULT NOW() COMMENT '신고일시',
    CONSTRAINT `PK_TBL_REPORTS` PRIMARY KEY (`REPORT_CD`),
    CONSTRAINT `FK_TBL_REPORT_GB_TO_TBL_REPORTS_1` FOREIGN KEY (`REPORT_GB`) REFERENCES `TBL_REPORT_GB` (`REPORT_GB`),
    CONSTRAINT `FK_TBL_USERS_TO_TBL_REPORTS_1` FOREIGN KEY (`REPORT_USER_CD`) REFERENCES `TBL_USERS` (`USER_CD`),
    CONSTRAINT `FK_TBL_USERS_TO_TBL_REPORTS_2` FOREIGN KEY (`TARGET_USER_CD`) REFERENCES `TBL_USERS` (`USER_CD`)
);

-- TBL_NOTIFICATIONS : 알림
DROP TABLE IF EXISTS `TBL_NOTIFICATIONS`;
CREATE TABLE `TBL_NOTIFICATIONS` (
    `NOTI_CD`      INT           NOT NULL AUTO_INCREMENT COMMENT '알림 코드 (PK)',
    `USER_CD`      INT           NOT NULL COMMENT '수신자 회원 코드 (FK)',
    `NOTI_CONT`    VARCHAR(1000) NOT NULL COMMENT '알림 내용',
    `READ_FG`      INT           NOT NULL DEFAULT 0 COMMENT '읽음 여부',
    `NOTI_REG_DTTM` DATETIME     NOT NULL DEFAULT NOW() COMMENT '생성일시',
    CONSTRAINT `PK_TBL_NOTIFICATIONS` PRIMARY KEY (`NOTI_CD`),
    CONSTRAINT `FK_TBL_USERS_TO_TBL_NOTIFICATIONS_1` FOREIGN KEY (`USER_CD`) REFERENCES `TBL_USERS` (`USER_CD`)
);

-- -----------------------------------------------------------------------
-- 3. 데이터 삽입 및 시나리오 실행
-- -----------------------------------------------------------------------

-- 기존 데이터 초기화 (깨끗한 테스트 환경 보장)
TRUNCATE TABLE `TBL_USERS`;
TRUNCATE TABLE `TBL_REPORT_GB`;
TRUNCATE TABLE `TBL_MOVIES`;
TRUNCATE TABLE `TBL_REPORTS`;
TRUNCATE TABLE `TBL_NOTIFICATIONS`;

-- 신고 구분 삽입
INSERT INTO `TBL_REPORT_GB` (REPORT_GB_NM) VALUES ('욕설/비방'), ('스포일러'), ('광고/홍보');
SET @REPORT_TYPE_SPOILER = 2;

-- 영화 데이터 삽입
INSERT INTO `TBL_MOVIES` (MOVIE_NM, MOVIE_OVERVIEW, RELEASE_DT, RUNTIME)
VALUES ('인셉션', '꿈 속의 꿈으로 들어가는 이야기', '2010-07-21', 148);

-- 회원 데이터 삽입 (신고자)
INSERT INTO `TBL_USERS` (USER_ID, USER_NICK_NM, USER_EMAIL)
VALUES ('clean_user', '순정가이', 'userA@test.com');
SET @REPORTER_USER_CD = LAST_INSERT_ID();

-- 회원 데이터 삽입 (피신고자)
INSERT INTO `TBL_USERS` (USER_ID, USER_NICK_NM, USER_EMAIL)
VALUES ('spoiler_king', '빅스포맨', 'userB@test.com');
SET @TARGET_USER_CD = LAST_INSERT_ID();

-- 신고 데이터 삽입
INSERT INTO `TBL_REPORTS` (REPORT_GB, REPORT_USER_CD, TARGET_USER_CD, REPORT_REASON, REPORT_ST)
VALUES (@REPORT_TYPE_SPOILER, @REPORTER_USER_CD, @TARGET_USER_CD, '내일 볼려고했는데 마지막 팽이 결말을 스포당했어요.', 0);
SET @REPORT_CD = LAST_INSERT_ID();

-- 알림 데이터 삽입 (신고자)
INSERT INTO `TBL_NOTIFICATIONS` (USER_CD, NOTI_CONT, READ_FG)
VALUES (@REPORTER_USER_CD, '회원님의 신고(사유: 스포일러)가 정상적으로 접수되었습니다. 긍정적으로 검토 후 처리하겠습니다.', 0);

-- 알림 데이터 삽입 (피신고자)
INSERT INTO `TBL_NOTIFICATIONS` (USER_CD, NOTI_CONT, READ_FG)
VALUES (@TARGET_USER_CD, '회원님의 리뷰가 "스포일러" 사유로 신고되어 정지 처리되었습니다.', 0);

-- 신고 처리 상태 업데이트
UPDATE `TBL_REPORTS` SET REPORT_ST = 1 WHERE REPORT_CD = @REPORT_CD;

-- -----------------------------------------------------------------------
-- 4. 최종 결과 확인 (수정된 SELECT 구문)
-- -----------------------------------------------------------------------

-- 🚨 오류가 발생했던 구문을 다음과 같이 수정합니다. (테이블 이름 리터럴과 *를 분리)

SELECT 'TBL_REPORT_GB' AS TABLE_NAME;  -- 테이블 이름 출력 (리터럴)
SELECT * FROM TBL_REPORT_GB;             -- 실제 데이터 출력

SELECT 'TBL_MOVIES' AS TABLE_NAME;
SELECT * FROM TBL_MOVIES;

SELECT 'TBL_USERS' AS TABLE_NAME;
SELECT USER_CD, USER_NICK_NM, USER_ID FROM TBL_USERS;


-- (나머지 JOIN 구문은 정상입니다.)

-- 신고 내역 상세 확인 (JOIN)
SELECT
    R.REPORT_CD AS 신고번호,
    UR.USER_NICK_NM AS 신고자,
    UT.USER_NICK_NM AS 피신고자,
    GB.REPORT_GB_NM AS 신고유형,
    R.REPORT_REASON AS 신고내용,
    CASE R.REPORT_ST WHEN 1 THEN '✅ 처리완료' ELSE '❌ 접수됨' END AS 처리상태,
    R.REPORT_REG_DTTM AS 신고일시
FROM TBL_REPORTS R
JOIN TBL_USERS UR ON R.REPORT_USER_CD = UR.USER_CD
JOIN TBL_USERS UT ON R.TARGET_USER_CD = UT.USER_CD
JOIN TBL_REPORT_GB GB ON R.REPORT_GB = GB.REPORT_GB;

-- 알림 내역 상세 확인 (JOIN)
SELECT
    N.NOTI_CD AS 알림번호,
    U.USER_NICK_NM AS 수신자,
    N.NOTI_CONT AS 알림내용,
    CASE N.READ_FG WHEN 1 THEN '읽음' ELSE '안 읽음' END AS 읽음여부,
    N.NOTI_REG_DTTM AS 발송일시
FROM TBL_NOTIFICATIONS N
JOIN TBL_USERS U ON N.USER_CD = U.USER_CD
ORDER BY N.NOTI_REG_DTTM DESC;