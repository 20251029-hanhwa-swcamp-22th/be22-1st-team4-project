/* ================================================================
TEST CASE 1 : 욕설/비방 신고
 ================================================================*/

-- 1) 테스트용 회원 생성
INSERT INTO
    TBL_USERS (
                       USER_ID,
                       USER_NICK_NM,
                       USER_EMAIL
)
VALUES (
        'test1_reporter',
        '욕설신고자',
        't1_report@test.com'
       );
SET
@R1_USER = LAST_INSERT_ID();

INSERT INTO
    TBL_USERS (
               USER_ID,
               USER_NICK_NM,
               USER_EMAIL
)
VALUES (
        'test1_target',
        '트롤러1',
        't1_target@test.com'
       );
SET
 @T1_USER = LAST_INSERT_ID();


-- 2) 신고 입력
INSERT INTO
    TBL_REPORTS (
                 REPORT_GB,
                 REPORT_USER_CD,
                 TARGET_USER_CD,
                 REPORT_REASON,
                 REPORT_ST
)
VALUES
    (
     1,
        @R1_USER,
        @T1_USER,
        '리뷰에서저한태 욕했어요.',
        0
    );
SET
@RPT1 = LAST_INSERT_ID();


-- 3) 알림
INSERT INTO
    TBL_NOTIFICATIONS (
                               USER_CD
    NOTI_CONT
    )

VALUES
    (
        @R1_USER,
        '욕설/비방 신고가 정상 접수되었습니다'
       );


-- 4) 알림2
INSERT INTO
    TBL_NOTIFICATIONS (
                       USER_CD,
                       NOTI_CONT
)
VALUES
    (
        @T1_USER,
        '회원님의 리뷰에 욕설이 있어 신고되었습니다'
       );


-- 5) 신고 처리 완료
UPDATE
    TBL_REPORTS
SET REPORT_ST = 1 WHERE REPORT_CD = @RPT1;

---

/*================================================================
 TEST CASE 2 : 비인가 광고
 ================================================================
*/
-- 1) 테스트용 회원 생성
INSERT INTO
    TBL_USERS
    (
     USER_ID,
         USER_NICK_NM,
             USER_EMAIL
    )
VALUES
    (
     'test2_reporter',
     '광고감시요원',
     't2_report@test.com'
    );
SET
@R2_USER = LAST_INSERT_ID();

INSERT INTO
    TBL_USERS (
                 USER_ID,
               USER_NICK_NM,
               USER_EMAIL
)
VALUES
    (
     'test2_target',
        '스팸러2',
     't2_target@test.com'
    );
SET
@T2_USER = LAST_INSERT_ID();


-- 2) 신고 입력
INSERT INTO
    TBL_REPORTS
    (
     REPORT_GB,
     REPORT_USER_CD,
      TARGET_USER_CD,
       REPORT_REASON,
       REPORT_ST
    )
VALUES
    (3,
        @R2_USER,
     @T2_USER,
     '리뷰 내용 전체가 특정 사이트 홍보입니다.',
     0
    );
SET
 @RPT2 = LAST_INSERT_ID();


-- 3) 알림 - 신고자
INSERT INTO
    TBL_NOTIFICATIONS (
                       USER_CD,
                       NOTI_CONT
)
VALUES
    (
        @R2_USER,
     '광고 신고가 정상 접수되었습니다'
    );


-- 4) 알림 - 피신고자
INSERT INTO
    TBL_NOTIFICATIONS (
                       USER_CD,
                       NOTI_CONT
)
VALUES
    (
     @T2_USER,
     '회원님의 내용이 "광고" 사유로 신고되었습니다'
    );


-- 5) 신고 처리 완료로 변경
UPDATE
    TBL_REPORTS SET REPORT_ST = 1 WHERE REPORT_CD = @RPT2;




-- ================================================================
-- TEST CASE 3 : 스포일러 신고
-- ================================================================

-- 1) 테스트용 회원 생성
INSERT INTO
    TBL_USERS (
               USER_ID,
               USER_NICK_NM,
               USER_EMAIL
)
VALUES
    (
        'test3_reporter',
     '스포저격수',
     't3_report@test.com'
    );
SET
@R3_USER = LAST_INSERT_ID();

INSERT INTO
    TBL_USERS
    (
     USER_ID,
     USER_NICK_NM,
     USER_EMAIL
    )
VALUES
    (
     'test3_target',
     '스포충3',
     't3_target@test.com'
    );
SET
@T3_USER = LAST_INSERT_ID();


-- 2) 신고 입력
INSERT INTO
    TBL_REPORTS
    (
     REPORT_GB,
     REPORT_USER_CD,
     TARGET_USER_CD,
     REPORT_REASON,
     REPORT_ST
    )
VALUES
    (2,
     @R3_USER,
     @T3_USER,
     '내일 볼려고 했는데 스포했어요',
     0
    );
SET
 @RPT3 = LAST_INSERT_ID();




-- 3) 알림 - 신고자
INSERT INTO
    TBL_NOTIFICATIONS (
                       USER_CD,
                       NOTI_CONT
)
VALUES
    (
     @R3_USER,
     '스포일러 신고접수'
    );


-- 4) 알림 - 피신고자
INSERT INTO
    TBL_NOTIFICATIONS
    (
     USER_CD,
     NOTI_CONT
    )
VALUES
    (
        @T3_USER,
        '회원님의 게시물이 "스포일러" 사유로 신고 접수되었습니다'
       );



