-- =======================================================================
-- 제약 조건 설정을 위해 잠시 FK 체크를 비활성화합니다.
-- =======================================================================

set foreign_key_checks = 0;

-- =======================================================================
-- (필수 선행) TBL_USERS : 회원 (참조 대상 테이블)
-- : TBL_NOTIFICATIONS와 TBL_REPORTS가 참조해야 하므로 먼저 생성합니다.
-- =======================================================================
DROP TABLE IF EXISTS `TBL_USERS`;
CREATE TABLE `TBL_USERS` (
    `USER_CD`  INT    NOT NULL AUTO_INCREMENT COMMENT '회원 코드 (PK)',
    `USER_ID`  VARCHAR(50)    NOT NULL COMMENT '회원 아이디',
    `USER_PW`  VARCHAR(255)   NULL COMMENT '비밀번호',
    `USER_NICK_NM` VARCHAR(50)    NOT NULL COMMENT '닉네임',
    `USER_EMAIL`   VARCHAR(100)   NOT NULL COMMENT '이메일',
    CONSTRAINT `PK_TBL_USERS` PRIMARY KEY (`USER_CD`)
);

-- =======================================================================
-- TBL_NOTIFICATIONS : 알람
-- =======================================================================

DROP TABLE IF EXISTS `TBL_NOTIFICATIONS`;
CREATE TABLE `TBL_NOTIFICATIONS` (
    `NOTI_CD`  INT    NOT NULL AUTO_INCREMENT COMMENT '알림 코드 (PK)',
    `USER_CD`  INT    NOT NULL COMMENT '수신자 회원 코드 (FK)',
    `NOTI_CONT`    VARCHAR(1000)  NOT NULL COMMENT '알림 내용',
    `READ_FG`  INT    NOT NULL   DEFAULT 0 COMMENT '읽음 여부',
    `NOTI_REG_DTTM`    DATETIME   NOT NULL   DEFAULT NOW() COMMENT '생성일시',
    CONSTRAINT `PK_TBL_NOTIFICATIONS` PRIMARY KEY (`NOTI_CD`),
    CONSTRAINT `FK_TBL_USERS_TO_TBL_NOTIFICATIONS_1` FOREIGN KEY (`USER_CD`) REFERENCES `TBL_USERS` (`USER_CD`)
);



SELECT * FROM TBL_NOTIFICATIONS ;

-- =======================================================================
-- TBL_REPORTS : 신고
-- =======================================================================
DROP TABLE IF EXISTS `TBL_REPORTS`;
CREATE TABLE `TBL_REPORTS` (
	`REPORT_CD`	INT	NOT NULL AUTO_INCREMENT	COMMENT '신고 코드 (PK)',
	`REPORT_GB`	INT	NOT NULL	COMMENT '신고 구분 코드 (FK)',
	`REPORT_USER_CD`	INT	NOT NULL	COMMENT '신고자 코드',
	`TARGET_USER_CD`	INT	NOT NULL	COMMENT '신고 대상자 코드',
	`REPORT_REASON`	VARCHAR(255)	NOT NULL	COMMENT '신고 사유',
	`REPORT_ST`	INT	NOT NULL	DEFAULT 0	COMMENT '처리 상태',
	`REPORT_REG_DTTM`	DATETIME	NOT NULL	DEFAULT NOW()	COMMENT '신고일시',
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
-- TBL_MOVIES : 영화
-- =======================================================================
DROP TABLE IF EXISTS `TBL_MOVIES`;
CREATE TABLE `TBL_MOVIES` (
	`MOVIE_CD`	INT	NOT NULL AUTO_INCREMENT	COMMENT '영화 코드 (PK)',
	`MOVIE_NM`	VARCHAR(255)	NOT NULL	COMMENT '영화 제목',
	`MOVIE_REG_DTTM`	DATETIME	NOT NULL	DEFAULT NOW()	COMMENT '데이터 등록일시',
	`MOVIE_OVERVIEW`	VARCHAR(1000)	NOT NULL	COMMENT '줄거리',
	`RELEASE_DT`	DATE	NULL	COMMENT '개봉일',
	`RUNTIME`	INT	NULL	COMMENT '런타임 (분 단위)',
	`POSTER_URL`	VARCHAR(255)	NULL	COMMENT '포스터 이미지 URL',
	CONSTRAINT `PK_TBL_MOVIES` PRIMARY KEY (
		`MOVIE_CD`
	)
);


-- =======================================================================
-- TBL_REPORT_GB : 신고 구분
-- =======================================================================
DROP TABLE IF EXISTS `TBL_REPORT_GB`;
CREATE TABLE `TBL_REPORT_GB` (
	`REPORT_GB`	INT	NOT NULL AUTO_INCREMENT	COMMENT '신고 구분 코드 (PK)',
	`REPORT_GB_NM`	VARCHAR(50)	NOT NULL	COMMENT '신고 구분명 (한글) 게시글/댓글/리뷰',
	CONSTRAINT `PK_TBL_REPORT_GB` PRIMARY KEY (
		`REPORT_GB`
	)
);


-- =======================================================================
-- 제약 조건 설정을 위해 잠시 비활성화했던 FK 체크를 다시 활성화합니다.
-- =======================================================================
set foreign_key_checks = 1;

