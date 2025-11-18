-- 게시글 작성
INSERT INTO TBL_POSTS (POST_CD, USER_CD, POST_CTGRY_CD, POST_TT, POST_CONT, POST_REG_DTTM)
VALUES
(500, 100, 1, '안녕', '반갑다 친구야', NOW());

-- 댓글 작성
INSERT INTO TBL_COMMENT (POST_CD, USER_CD, COMMENT_CONT, COMMENT_REG_DTTM)
VALUES (
    500,                                 -- POST_CD: 댓글을 달 게시글 코드
    100,                                 -- USER_CD: 댓글을 작성하는 회원/관리자 코드 (유효성 필수)
    '이것은 회원/관리자가 작성한 공감 댓글 내용입니다.', -- COMMENT_CONT: 댓글 내용
    NOW()
);

INSERT INTO TBL_COMMENT (POST_CD, USER_CD, COMMENT_CONT, COMMENT_REG_DTTM)
VALUES (
    500,                                 -- POST_CD: 댓글을 달 게시글 코드
    200,                                 -- USER_CD: 댓글을 작성하는 회원/관리자 코드 (유효성 필수)
    '이것은 회원/관리자가 작성한 추천 댓글 내용입니다.', -- COMMENT_CONT: 댓글 내용
    NOW()
);

INSERT INTO TBL_COMMENT (POST_CD, USER_CD, COMMENT_CONT, COMMENT_REG_DTTM)
VALUES (
    500,                                 -- POST_CD: 댓글을 달 게시글 코드
    300,                                 -- USER_CD: 댓글을 작성하는 회원/관리자 코드 (유효성 필수)
    '이것은 회원/관리자가 작성한 비추천 댓글 내용입니다.', -- COMMENT_CONT: 댓글 내용
    NOW()
);

INSERT INTO TBL_COMMENT (POST_CD, USER_CD, COMMENT_CONT, COMMENT_REG_DTTM)
VALUES (
    500,                                 -- POST_CD: 댓글을 달 게시글 코드
    400,                                 -- USER_CD: 댓글을 작성하는 회원/관리자 코드 (유효성 필수)
    '이것은 회원/관리자가 작성한 댓글 내용입니다.', -- COMMENT_CONT: 댓글 내용
    NOW()
);


-- 게시글 상세 조회
SELECT P.POST_CD, U.USER_NICK_NM, P.POST_TT, P.POST_CTGRY_CD, P.POST_REG_DTTM, P.POST_VIEW_CNT,
        (P.POST_LIKE_CNT - P.POST_DISLIKE_CNT) AS 'Like',
        C.COMMENT_CONT
FROM TBL_POSTS P
LEFT JOIN TBL_COMMENT C ON P.POST_CD = C.POST_CD
INNER JOIN TBL_USERS U ON P.USER_CD = U.USER_CD
WHERE P.POST_CD = 500;

DELIMITER $$

CREATE PROCEDURE GetPostDetailWithComments(
    IN p_post_cd INT -- 입력받을 게시글 코드 변수
)
BEGIN

    -- 1. 첫 번째 결과 셋: 게시글 상세 정보 (1건)
    -- 게시글 제목, 내용, 작성자 닉네임 등을 가져옵니다.
    SELECT
        P.POST_CD,
        U.USER_NICK_NM,
        P.POST_TT,
        P.POST_CONT,
        P.POST_REG_DTTM,
        P.POST_VIEW_CNT,
        (P.POST_LIKE_CNT - P.POST_DISLIKE_CNT) AS `NetLike`
    FROM
        TBL_POSTS P
    INNER JOIN
        TBL_USERS U
        ON P.USER_CD = U.USER_CD
    WHERE
        P.POST_CD = p_post_cd; -- 입력받은 게시글 코드로 조회

    -- 2. 두 번째 결과 셋: 댓글 목록 (N건)
    -- 해당 게시글의 모든 활성 댓글 목록과 작성자 닉네임을 가져옵니다.
    SELECT
        C.COMMENT_CD,
        U.USER_NICK_NM AS COMMENT_AUTHOR,
        C.COMMENT_CONT,
        C.COMMENT_REG_DTTM
    FROM
        TBL_COMMENT C
    INNER JOIN
        TBL_USERS U
        ON C.USER_CD = U.USER_CD
    WHERE
        C.POST_CD = p_post_cd -- 입력받은 게시글 코드로 조회
        AND C.COMMENT_ST = 1
    ORDER BY
        C.COMMENT_REG_DTTM ASC;

END $$

DELIMITER ;

-- 프로시저 실행 예시 (게시글 코드 500 조회)
CALL GetPostDetailWithComments(500);