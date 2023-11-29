CREATE DATABASE test01;
CREATE TABLE TO01(
 num INT(5),
 fname VARCHAR(20),
 phone VARCHAR(11)
);
DROP DATABASE test01;
DROP TABLE TO01;

#DML 데이터 조작언어
#C : create -> INSERT 데이터삽입문
#INSERT INTO 테이블명((속성명,생략가능)) VALUES((데이터));
INSERT INTO TO01(num, fname, phone) VALUES(1, "홍길동", "01048563847");
INSERT INTO TO01 VALUES(2, "홍길동", "01048563847");

#R : Read -> SELECT 데이터조회문
#SELECT 속성명 FROM 테이블명;
#SELECT *(전체속성) FROM 테이블명;
SELECT num, fname, phone FROM TO01;
SELECT*FROM to01;

#U : Update -> UPDATE 데이터수정문
#UPDATE 테이블명 SET (수정할 속성명=속성값) WHERE 조건문;
UPDATE TO01 SET fname ='Kane' WHERE num=1;
UPDATE To01 SET num=3, fname ='Julia', phone='01012345678' WHERE num=2;

#D : Delete -> DELETE 데이터삭제문
#DELETE FROM 테이블명 WHERE 조건문; 
DELETE FROM to01 WHERE num=3;

#board table 생성
#시스템 날짜,시간 입력 
#속성명 (DATE,DATETIME) DEFAULT (CURDATE(),CURTIME())
DROP TABLE tb1_board;
CREATE TABLE tb1_board(
	bno INT PRIMARY KEY auto_increment,
	title VARCHAR(50),
	contents VARCHAR(1000),
	writer VARCHAR(20),
	regdate DATETIME DEFAULT CURTIME()
);

INSERT INTO tb1_board (title, contents, writer) VALUES('test title1', 'testcontents1', 'testwriter1');
INSERT INTO tb1_board (title, contents, writer) VALUES('test title2', 'testcontents2', 'testwriter2');
SELECT*FROM tb1_board;

##컬럼의 제약조건##
#primary key(pk) : 기본키 식별자, (필수(not null), 중복X(unique))
#후보키





















