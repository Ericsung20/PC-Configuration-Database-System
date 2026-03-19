use db3;

CREATE TABLE 사용자 (
	사용자ID	VARCHAR(20)	NOT NULL,
	비밀번호	VARCHAR(50) NOT NULL,
    이름		VARCHAR(10)	NOT NULL,
    나이		INT			NOT NULL,
    번호		VARCHAR(15),
    사용자유형	VARCHAR(10) DEFAULT '일반',
    PRIMARY KEY (사용자ID)
);

CREATE TABLE 게시글 (
    게시글ID	CHAR(5)		NOT NULL,
    게시글유형	VARCHAR(30),
	작성자	VARCHAR(20)		NOT NULL,
    제목		VARCHAR(100)	NOT NULL,
    내용 	TEXT,
    조회수	INT,
    좋아요수	INT,
    PRIMARY KEY (게시글ID),
    FOREIGN KEY (작성자) REFERENCES 사용자(사용자ID) 
);

CREATE TABLE 견적(
	견적ID	CHAR(5)		NOT NULL,
	작성자	VARCHAR(20),
    총가격	INT,
    작성날짜	DATE,
	설명		TEXT,
    PRIMARY KEY(견적ID),
    FOREIGN KEY(제작자)	REFERENCES 사용자(사용자ID)
);

CREATE TABLE 부품(
	부품ID	CHAR(5)	NOT NULL,
	카테고리	VARCHAR(10),
    제조사	VARCHAR(20),
    품명		VARCHAR(50),
    가격		DECIMAL(10, 2),
    소켓타입	VARCHAR(20),
    RAM타입	VARCHAR(20),
    전력요구량	INT, 
    PCIe버전 VARCHAR(20),
    PRIMARY KEY(부품ID)
);

CREATE TABLE 호환성(
	호환성ID	CHAR(5)		NOT NULL,
	부품1	CHAR(5) 	NOT NULL,
    부품2	CHAR(5)		NOT NULL,
    호환여부	BOOLEAN,
	설명		TEXT,
    PRIMARY KEY(호환성ID),
    FOREIGN KEY(부품1)	REFERENCES 부품(부품ID),
	FOREIGN KEY(부품2)	REFERENCES 부품(부품ID)
);

CREATE TABLE 작성(
	작성자	VARCHAR(20)	NOT NULL,
	게시글	CHAR(5)		NOT NULL,
    작성IP 	INT			NOT NULL,
    작성일자	DATE,
    FOREIGN KEY(작성자)	REFERENCES 사용자(사용자ID),
    FOREIGN KEY(게시글)	REFERENCES 게시글(게시글ID)
);

CREATE TABLE 구상(
	구상ID	CHAR(5)		NOT NULL,
	작성자	VARCHAR(20)	NOT NULL,
	견적		CHAR(5)		NOT NULL,
    FOREIGN KEY(작성자)	REFERENCES 사용자(사용자ID),
    FOREIGN KEY(게시글)	REFERENCES 게시글(게시글ID)
);

CREATE TABLE 구성(
	구성ID	CHAR(5)		NOT NULL,
    견적		CHAR(5)		NOT NULL,
	구성부품	CHAR(5)		NOT NULL,
	부품수량	INT,
    PRIMARY KEY (구성ID),
	FOREIGN KEY(견적)	REFERENCES 견적(견적ID),
    FOREIGN KEY(구성부품)	REFERENCES 부품(부품ID)
);

CREATE TABLE 판단(
	판단ID	CHAR(5)		NOT NULL,
    호환성ID	CHAR(5)		NOT NULL,
    부품1	CHAR(5)		NOT NULL,
    부품2	CHAR(5)		NOT NULL,
    호환상태	VARCHAR(10)	NOT NULL,
    판단기준	VARCHAR(30),
    부품1값	VARCHAR(20),
    부품2값	VARCHAR(20),
    판단이유	TEXT,
    PRIMARY KEY (판단ID),
	FOREIGN KEY(호환성ID)	REFERENCES 호환성(호환성ID),
    FOREIGN KEY(부품1)	REFERENCES 부품(부품ID),
    FOREIGN KEY(부품2)	REFERENCES 부품(부품ID)
);

