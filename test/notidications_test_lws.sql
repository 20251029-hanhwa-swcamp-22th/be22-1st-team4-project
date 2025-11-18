/* ======================================================
 TEST CASE 1 : 기본 알림 생성 테스트
 ======================================================*/

-- 1) 테스트 회원 생성
INSERT INTO
    TBL_USERS
    (
     USER_ID,
     USER_NICK_NM,
     USER_EMAIL
    )
VALUES
    (
     'noti_user1',
     '기본유저1',
     'noti1@test.com'
    );
SET
    @U1 = LAST_INSERT_ID();

-- 2) 알림 1개 생성
INSERT INTO
    TBL_NOTIFICATIONS (
                       USER_CD,
                       NOTI_CONT
)
VALUES
    (
     @U1,
        'test alram'
    );


/* ======================================================
TEST CASE 2 : 여러 개의 알림 생성 테스트
 ======================================================*/

-- 1) 테스트 회원 생성
INSERT INTO
    TBL_USERS
    (
     USER_ID,
     USER_NICK_NM,
     USER_EMAIL
    )
VALUES
    (
        'noti_user2',
        '멀티유저2',
        'noti2@test.com'
       );


SET
    @U2 = LAST_INSERT_ID();

-- 2) 알림 여러 개 생성
INSERT INTO
    TBL_NOTIFICATIONS
    (
     USER_CD,
     NOTI_CONT
    )
VALUES
(@U2, '첫 번째 알림입니다.'),
(@U2, '두 번째 알림: 신고 처리 결과가 도착했습니다.'),
(@U2, '세 번째 알림: 이벤트 참여 보상이 지급되었습니다.');

SELECT * FROM;