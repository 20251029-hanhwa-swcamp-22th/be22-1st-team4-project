/* =============================================================
다중 신고 -> 알림 누적 자동 생성 테스트
 =============================================================*/

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
