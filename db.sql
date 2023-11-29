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
DESC tb1_board; #컬럼에 관한 설명
INSERT INTO tb1_board (title, contents, writer) VALUES('test title1', 'testcontents1', 'testwriter1');
INSERT INTO tb1_board (title, contents, writer) VALUES('test title2', 'testcontents2', 'testwriter2');
SELECT*FROM tb1_board;

##컬럼의 제약조건##
#primary key(pk) : 기본키 식별자, (필수(not null), 중복X(unique))
#후보키

DROP TABLE tb1_students;
CREATE table tb1_students(
	sno INT primary key AUTO_INCREMENT,
	sname VARCHAR(20),
	grade CHAR(1),
	class CHAR(1),
	kor_score INT(3),
	eng_score INT(3),
	sql_score INT(3)
);

INSERT INTO tb1_students (sname, grade, class, kor_score, eng_score, sql_score) VALUES('Ann', '1', '1', 80, 80, 90), ('Kane', '2', '1', 20, 80, 90), 
('Hong', '2', '1', 30, 70, 90), ('Kang', '2', '2', 40, 60, 90), ('Choi', '2', '2', 50, 80, 90),('Jeong', '1', '2', 60, 80, 90), 
('On', '1', '1', 70, 90, 90), ('Park', '1', '2', 80, 90, 90), ('Lee', '3', '1', 90, 60, 90), ('Seo', '3', '1', 100, 80, 90);
#속성에 항목값 총 갯수를 계산
#SELECT COUNT(*) FROM (테이블명);
SELECT COUNT(*) FROM tb1_students;
SELECT COUNT(sname) FROM tb1_students;
#AS 항목의 이름 수정
#SELECT 항목  AS (원하는 이름) FROM tb1_students;
SELECT COUNT(sno) AS 학생수 FROM tb1_students;

INSERT INTO tb1_students (sname, grade, class, kor_score, eng_score, sql_score) VALUES(NULL, '4', '1', 70, 80, 90);
#COUNT(*)은 NULL값 포함하여 계산
SELECT COUNT(*) FROM tb1_students;
#COUNT(속성명)은 NULL값 제외하여 계산
SELECT COUNT(sname) FROM tb1_students;
SELECT*FROM tb1_students;

#조건절 계산
SELECT sname, grade, class FROM tb1_students WHERE grade='1';
SELECT sname, grade FROM tb1_students WHERE kor_score>70;
#eng_score 65점이상 75점이하
SELECT sname FROM tb1_students WHERE eng_score>65 and eng_score<75;
SELECT sname FROM tb1_students WHERE eng_score BETWEEN 65 AND 75;

INSERT INTO tb1_students (sname, grade, class, kor_score, eng_score, sql_score) VALUES('김철수', '3', '2', 65, 75, 80), ('김동수', '3', '2', 65, 65, 70), 
('김희선', '3', '2', 65, 85, 60), ('나동수', '3', '2', 65, 95, 50), ('한철수', '3', '2', 65, 35, 40), ('마동석', '3', '2', 65, 55, 80);
#특정한 글자 조회
#SELECT*FROM 테이블명 WHERE 항목명 LIKE '글자';
#김% : 김으로 시작하는 이름 조회
SELECT*FROM tb1_students WHERE sname LIKE '김%';
#김_수 : 첫글자가 김이고 세번째글자가 수인 이름 조회
SELECT*FROM tb1_students WHERE sname LIKE '김_수';
SELECT*FROM tb1_students WHERE sname LIKE '_동%';
#NULL값 조회
SELECT*FROM tb1_students WHERE sname IS NULL;
#순서정렬 ASC 오름차순 DESC 내림차순
#ORDER BY 항목 (ASC,DESC)
SELECT kor_score+eng_score+sql_score AS 총점  FROM tb1_students  ORDER BY 총점 DESC;

UPDATE tb1_students SET sname='마석동' WHERE sname='마동석';
SELECT*FROM tb1_students WHERE sname='마석동';

SELECT*FROM tb1_students WHERE sname LIKE '__o%';

DELETE FROM tb1_students WHERE sname IS NULL;
SELECT*FROM tb1_students WHERE sname IS NULL;

UPDATE tb1_students set kor_score=kor_score+5 WHERE kor_score=65;
SELECT*FROM tb1_students WHERE kor_score=70;

#kor_score 최고점구하기
#SELECT MAX(항목명) FROM 테이블명
SELECT MAX(kor_score) FROM tb1_students;

#kor_score 최저점구하기
#SELECT MIN(항목명) FROM 테이블명
SELECT MIN(kor_score) FROM tb1_students;

SELECT sname, MIN(kor_score) FROM tb1_students;

#서브쿼리
SELECT sname FROM tb1_students where kor_score=(SELECT MAX(kor_score) FROM tb1_students);




