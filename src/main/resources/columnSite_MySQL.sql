-- 1.31 최종 업데이트

create table BOARD (
	POST_NUM INT PRIMARY KEY auto_increment,
    TITLE VARCHAR(100) NOT NULL,
    WRITER VARCHAR(30) NOT NULL,
    REG_DATE DATETIME DEFAULT current_timestamp,
    VIEWS INT DEFAULT 0,
    COMMENT_COUNT INT DEFAULT 0,
    NOTICE INT(1) DEFAULT 0,
    CONTENT TEXT
);

create table BOARD_VIEWS_DETAIL (
	POST_NUM int NOT NULL,
    IP VARCHAR(15) NOT NULL,
    REG_DATE DATETIME DEFAULT current_timestamp
);

create table FULL_NOTICE (
	POST_NUM INT PRIMARY KEY auto_increment,
    TITLE VARCHAR(100) NOT NULL,
    WRITER VARCHAR(30) NOT NULL,
    REG_DATE DATETIME DEFAULT current_timestamp,
    VIEWS INT DEFAULT 0,
    COMMENT_COUNT INT DEFAULT 0,
    NOTICE INT(1) DEFAULT 1,
    CONTENT TEXT
);

CREATE TABLE FULL_NOTICE_COMMENT (
	POST_NUM INT NOT NULL,
    COMMENT_NUM INT primary KEY auto_increment,
    ID VARCHAR(50) NOT NULL,
    REG_DATE datetime DEFAULT current_timestamp,
    CONTENT VARCHAR(500)
);

CREATE TABLE FULL_NOTICE_VIEWS (
	POST_NUM INT NOT NULL,
    IP VARCHAR(15) NOT NULL,
    REG_DATE DATETIME default current_timestamp
);

CREATE TABLE MEMBER (
	ID VARCHAR(50) PRIMARY KEY,
    PW VARCHAR(80) NOT NULL,
    NICKNAME VARCHAR(50) NOT NULL,
    REALNAME VARCHAR(30) NOT NULL,
    EMAIL VARCHAR(100),
    PHONE VARCHAR(50),
    GRADE INT(1) NOT NULL DEFAULT 1,
    REG_DATE DATETIME DEFAULT current_timestamp
);

create table OPENCOLUMN (
	POST_NUM INT PRIMARY KEY auto_increment,
    TITLE VARCHAR(100) NOT NULL,
    WRITER VARCHAR(30) NOT NULL,
    REG_DATE DATETIME DEFAULT current_timestamp,
    VIEWS INT DEFAULT 0,
    COMMENT_COUNT INT DEFAULT 0,
    NOTICE INT(1) DEFAULT 0,
    CONTENT TEXT
);

CREATE TABLE OPENCOLUMN_COMMENT (
	POST_NUM INT NOT NULL,
    COMMENT_NUM INT primary KEY auto_increment,
    ID VARCHAR(50) NOT NULL,
    REG_DATE datetime DEFAULT current_timestamp,
    CONTENT VARCHAR(500)
);

CREATE TABLE OPENCOLUMN_VIEWS (
	POST_NUM INT NOT NULL,
    IP VARCHAR(15) NOT NULL,
    REG_DATE DATETIME default current_timestamp
);

CREATE TABLE POST_COMMENT (
	POST_NUM INT NOT NULL,
    COMMENT_NUM INT primary KEY auto_increment,
    ID VARCHAR(50) NOT NULL,
    REG_DATE datetime DEFAULT current_timestamp,
    CONTENT VARCHAR(500)
);

create table VIDEO (
	POST_NUM INT PRIMARY KEY auto_increment,
    TITLE VARCHAR(100) NOT NULL,
    WRITER VARCHAR(30) NOT NULL,
    REG_DATE DATETIME DEFAULT current_timestamp,
    VIEWS INT DEFAULT 0,
    COMMENT_COUNT INT DEFAULT 0,
    NOTICE INT(1) DEFAULT 0,
    CONTENT TEXT,
    URL VARCHAR(300)
);

CREATE TABLE VIDEO_COMMENT (
	POST_NUM INT NOT NULL,
    COMMENT_NUM INT primary KEY auto_increment,
    ID VARCHAR(50) NOT NULL,
    REG_DATE datetime DEFAULT current_timestamp,
    CONTENT VARCHAR(500)
);

CREATE TABLE VIDEO_VIEWS (
	POST_NUM INT NOT NULL,
    IP VARCHAR(15) NOT NULL,
    REG_DATE DATETIME default current_timestamp
);

create table LIBRARY (
	POST_NUM INT PRIMARY KEY auto_increment,
    TITLE VARCHAR(100) NOT NULL,
    WRITER VARCHAR(30) NOT NULL,
    REG_DATE DATETIME DEFAULT current_timestamp,
    VIEWS INT DEFAULT 0,
    COMMENT_COUNT INT DEFAULT 0,
    NOTICE INT(1) DEFAULT 0,
    CONTENT TEXT
);

CREATE TABLE LIBRARY_VIEWS (
	POST_NUM INT NOT NULL,
    IP VARCHAR(15) NOT NULL,
    REG_DATE DATETIME default current_timestamp
);

CREATE TABLE LIBRARY_COMMENT (
	POST_NUM INT NOT NULL,
    COMMENT_NUM INT primary KEY auto_increment,
    ID VARCHAR(50) NOT NULL,
    REG_DATE datetime DEFAULT current_timestamp,
    CONTENT VARCHAR(500)
);

CREATE TABLE LIBRARY_FILE (
	POST_NUM INT NOT NULL,
    FILE_NUM INT PRIMARY KEY AUTO_INCREMENT,
    ORIGINAL_FILE_NAME VARCHAR(255),
    FILE_PATH VARCHAR(500),
    FILE_SIZE INTEGER
);

SELECT post_num, title, content, writer, reg_date, views, COMMENT_COUNT, notice
	FROM BOARD
	WHERE title like CONCAT('%', '미도리', '%') AND notice=0
	ORDER by post_num desc
	LIMIT 0, 10;

INSERT INTO MEMBER -- 관리자 계정 생성
	VALUES('admin', '1111', '운영자', '운영자', 'ozkhan@naver.com', '000', 3, now());

INSERT INTO MEMBER -- 테스트 계정(미도리) 생성
	VALUES('midori', '1111', 'midori', '미도리', 'midori@cat.com', '000', 2, now());

SELECT * FROM full_notice;

UPDATE FULL_NOTICE
	set title='테스트수정판', content='ㅅㄷㄴㅅ', writer='admin'
	where post_num=11;

DELETE FROM full_notice;

SELECT * FROM
	(SELECT A.POST_NUM, A.COMMENT_NUM, A.ID, A.REG_DATE, A.CONTENT, B.NICKNAME
		FROM FULL_NOTICE_COMMENT A
		INNER JOIN MEMBER B
		ON A.ID=B.ID
		WHERE A.POST_NUM=1
		ORDER BY A.COMMENT_NUM DESC) C	
	ORDER BY COMMENT_NUM
    LIMIT 0, 10;
    
SELECT * FROM library;

SELECT A.POST_NUM, A.COMMENT_NUM, A.ID, A.REG_DATE, A.CONTENT, B.NICKNAME
	FROM OPENCOLUMN_COMMENT A
	INNER JOIN MEMBER B
	ON A.ID=B.ID
	WHERE A.POST_NUM=14
	ORDER BY A.COMMENT_NUM DESC;

SELECT * FROM
	(SELECT A.POST_NUM, A.COMMENT_NUM, A.ID, A.REG_DATE, A.CONTENT, B.NICKNAME
		FROM OPENCOLUMN_COMMENT A
		INNER JOIN MEMBER B
		ON A.ID=B.ID
		WHERE A.POST_NUM=14
		ORDER BY A.COMMENT_NUM DESC
        LIMIT 0, 10) C
	ORDER BY COMMENT_NUM;

SELECT IFNULL(MAX(POST_NUM),0)
	FROM LIBRARY;

SELECT * FROM LIBRARY;

SELECT * FROM LIBRARY_FILE;	

INSERT INTO library_file(POST_NUM, ORIGINAL_FILE_NAME, FILE_PATH, FILE_SIZE)
	VALUES(7, '2f2956e20e2a5ede67907e3b83af29ac.jpg', 'c:\\testsite\\upload/', 29085);
    
DELETE FROM library_file
	WHERE POST_NUM=7;

set sql_safe_updates=0; -- 일시적인 안전모드 해제

COMMIT;