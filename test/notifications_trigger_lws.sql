/*

-- 1) 새로운 유저 두 명 생성
INSERT INTO
    TBL_USERS
    (
     USER_ID,
       USER_NICK_NM,
  USER_EMAIL
    )
VALUES
    (
        'tri_multi1',
     '멀티신고자',
     'multi1@test.com'
    );
SET
    @TRI_R2 = LAST_INSERT_ID();

INSERT INTO
    TBL_USERS (USER_ID, USER_NICK_NM, USER_EMAIL)
VALUES
    (
     'tri_multi2',
     '멀티피신고자',
     'multi2@test.com'
    );
SET
    @TRI_T2 = LAST_INSERT_ID();

-- 2) 스포일러 신고 3회 반복 (모두 트리거 자동 처리)
INSERT INTO
    TBL_REPORTS
    (
     REPORT_GB,
         REPORT_USER_CD,
             TARGET_USER_CD,
     REPORT_REASON
    )
VALUES
    (
        2,
     @TRI_R2,
        @TRI_T2,
      '스포일러 신고 1'
    );

INSERT INTO
    TBL_REPORTS
    (
     REPORT_GB,
     REPORT_USER_CD,
     TARGET_USER_CD,
     REPORT_REASON
    )
VALUES (
        2,
        @TRI_R2,
        @TRI_T2,
         '스포일러 신고 2'
       );



INSERT INTO
    TBL_REPORTS
    (REPORT_GB,
     REPORT_USER_CD,
     TARGET_USER_CD,
     REPORT_REASON)
VALUES
    (
        2,
        @TRI_R2,
        @TRI_T2,
        '스포일러 신고 3'
       );

-- 3) 결과 확인
SELECT
    *
FROM
             TBL_NOTIFICATIONS
WHERE
    USER_CD IN (@TRI_R2, @TRI_T2)
ORDER BY
    NOTI_CD DESC;
*/

/* =============================================================
다중 신고 -> 알림 누적 자동 생성 테스트 (수정됨)
=============================================================*/

    DELIMITER //
DROP TRIGGER IF EXISTS trg_report_after_insert;

CREATE TRIGGER trg_report_after_insert
AFTER
    INSERT ON TBL_REPORTS
FOR EACH ROW
BEGIN
    INSERT INTO TBL_NOTIFICATIONS(
               USER_CD,
                NOTI_CONT,
                READ_FG
        )
        VALUES (
                NEW.REPORT_USER_CD,
                CONCAT(
                '신고 내역 (사유: ',
            (SELECT
                 REPORT_GB_NM
             FROM
                 TBL_REPORT_GB
             WHERE
                 REPORT_GB = NEW.REPORT_GB),
            ')가 접수되었습니다. 확인후 알림드리겠습니다.'
                ),
                1
               );

end//
DELIMITER ;


SELECT * FROM TBL_REPORTS;









-- **[수정] 0) Foreign Key 제약 조건을 만족시키기 위해 신고 유형 코드 2번(스포일러)을 먼저 삽입**
INSERT IGNORE INTO TBL_REPORT_GB (REPORT_GB, REPORT_GB_NM)
VALUES (2, '스포일러');


-- 1) 새로운 유저 두 명 생성
INSERT INTO
    TBL_USERS
    (
     USER_ID,
       USER_NICK_NM,
  USER_EMAIL
    )
VALUES
    (
        'tri_multi1',
     '멀티신고자',
     'multi1@test.com'
    );
SET
    @TRI_R2 = LAST_INSERT_ID();

INSERT INTO
    TBL_USERS (USER_ID, USER_NICK_NM, USER_EMAIL)
VALUES
    (
     'tri_multi2',
     '멀티피신고자',
     'multi2@test.com'
    );
SET
    @TRI_T2 = LAST_INSERT_ID();

-- 2) 스포일러 신고 3회 반복 (모두 트리거 자동 처리)
-- 이 3회의 INSERT마다 트리거가 작동하여 알림이 2개씩 총 6개가 생성됩니다.
INSERT INTO
    TBL_REPORTS
    (
     REPORT_GB,
         REPORT_USER_CD,
             TARGET_USER_CD,
     REPORT_REASON
    )
VALUES
    (
        2,
     @TRI_R2,
        @TRI_T2,
      '스포일러 신고 1'
    );

INSERT INTO
    TBL_REPORTS
    (
     REPORT_GB,
     REPORT_USER_CD,
     TARGET_USER_CD,
     REPORT_REASON
    )
VALUES (
        2,
        @TRI_R2,
        @TRI_T2,
         '스포일러 신고 2'
       );



INSERT INTO
    TBL_REPORTS
    (REPORT_GB,
     REPORT_USER_CD,
     TARGET_USER_CD,
     REPORT_REASON)
VALUES
    (
        2,
        @TRI_R2,
        @TRI_T2,
        '스포일러 신고 3'
       );


-- 신고 접수 직후 상태 확인
SELECT
    REPORT_CD,
    REPORT_GB,
    REPORT_USER_CD,
    TARGET_USER_CD,
    REPORT_REASON,
    REPORT_ST
FROM
    TBL_REPORTS
WHERE
    REPORT_CD = @RPT1;

show triggers FROM cinefivedb;

-- 3) 결과 확인
SELECT
    *
FROM
             TBL_NOTIFICATIONS
WHERE
    USER_CD IN (@TRI_R2, @TRI_T2)
ORDER BY
    NOTI_CD ;

