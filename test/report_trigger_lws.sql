/*-- 1. 구분자를 // 로 변경
DELIMITER //

-- 기존 트리거가 있다면 재실행 시 오류 방지를 위해 삭제 (선택 사항)
DROP TRIGGER IF EXISTS trg_report_after_insert;

-- TBL_REPORTS에 데이터가 삽입된 후(AFTER INSERT) 작동하는 트리거 생성
CREATE TRIGGER trg_report_after_insert
AFTER INSERT ON TBL_REPORTS
FOR EACH ROW
BEGIN
    -- 새로 삽입된 신고 정보(NEW.REPORT_USER_CD, NEW.REPORT_GB)를 이용하여
    -- TBL_NOTIFICATIONS 테이블에 알림을 삽입합니다.

    INSERT INTO TBL_NOTIFICATIONS (
        USER_CD,
        NOTI_CONT,
        READ_FG
    )
    VALUES (
        NEW.REPORT_USER_CD, -- [수신자] : 방금 신고한 회원 코드 (NEW.USER_CD)
        CONCAT(
            '회원님의 신고(사유: ',
            -- TBL_REPORT_GB에서 신고 구분의 한글 이름(REPORT_GB_NM)을 조회하여 알림 내용에 포함
            (SELECT REPORT_GB_NM FROM TBL_REPORT_GB WHERE REPORT_GB = NEW.REPORT_GB),
            ')가 정상적으로 접수되었습니다. 처리 후 다시 알림을 보내드리겠습니다.'
        ),
        0 -- [읽음 여부] : 0 (안 읽음)
    );
END//

-- 2. 구분자를 원래대로 ; 로 복원
DELIMITER ;


SELECT * FROM TBL_NOTIFICATIONS;*/
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