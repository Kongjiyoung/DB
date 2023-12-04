#GROUP BY 항목명 : 항목명대로 그룹화한다.
#SELECT 항목명 FROM 테이블명 GROUP BY 항목명;
#SELECT 항목명 FROM 테이블명 WHERE 조건 GROUP BY 항목명; GROUP BY을 쓸떄에는 WHERE 조건절 뒤에 쓴다
SELECT grade, SUM(kor_score) FROM tb1_students where grade =3 GROUP BY grade;

#HAVING 그룹화한 데이터에 조건을 걸어준다
#SELECT 항목명 FROM 테이블명 GROUP BY 항목명 HAVING 조건;
SELECT gender, count(gender) FROM employees GROUP BY gender HAVING COUNT(gender)>130000;



DROP table student;

#특정 열에 제약조건 걸고 싶을 떄
#CHECK(항목명 IN (특정 문자,숫자))
#CHECK(조건식)
#DEFAULT 0 
CREATE TABLE student(
stu_no CHAR(9) PRIMARY KEY,
stu_name VARCHAR(20) NOT NULL,
stu_dept VARCHAR(20) NOT NULL,
stu_grade CHAR(1) CHECK(stu_grade IN (1,2,3)),
stu_class CHAR(1),
stu_gender CHAR(1) CHECK(stu_gender IN ('M', 'F')),
stu_height INT DEFAULT 0 CHECK(stu_height <300),
stu_weight INT DEFAULT 0
);
DELETE FROM student;

INSERT INTO student VALUES('20153075', '옥한빛', '기계', '1', 'C', 'M', 177, 80);
INSERT INTO student VALUES
('20153088', '이태연', '기계', '1', 'C', 'F', 162, 50),
('20143054', '유가인', '기계', '2', 'C', 'F', 154, 47), 
('20152088', '조민우', '전기전자', '1', 'C', 'M', 188, 90), 
('20142021', '심수정', '전기전자', '2', 'A', 'F', 168, 45), 
('20132003', '박희철', '전기전자', '3', 'B', 'M', NULL, 63),
('20151062', '김인중', '컴퓨터정보', '1', 'B', 'M', 166, 67),
('20141007', '진현무', '컴퓨터정보', '2', 'A', 'M', 174, 64),
('20131001', '김종헌', '컴퓨터정보', '3', 'C', 'M', NULL, 72),
('20131025', '옥성우', '컴퓨터정보', '3', 'A', 'F', 172, 63);


#DISTINCT 중복된 행을 제외시킴
SELECT distinct stu_dept FROM student;

#1. 학생테이블에서 학과명을 조회하시오. (단, 중복된 자료는 제외합니다.)
SELECT stu_dept FROM student GROUP BY stu_dept;
#2. 학생테이블에서 이름, 학과, 학년, 반을 조회할 때, 학과가 컴퓨터정보이고 학년이 2인 학생을 검색하시오
SELECT stu_name, stu_dept, stu_grade, stu_class FROM student WHERE stu_dept='컴퓨터정보' and stu_grade='2'; 
#3. 몸무게가 60이상 70이하인 학생의 정보를 검색하시오
select*FROM student WHERE stu_weight BETWEEN 60 AND 70;
#4. 학생테이블에서 학번, 이름을 조회할 떄 조회결과 열의 제목이 ID, NAME으로 표시되도록 하시오
SELECT stu_no AS ID, stu_name AS NAME FROM student;
#5. 2014학번 학생의 정보를 검색하시오
SELECT*FROM student WHERE stu_no LIKE '2014%';
#6. 성이 김씨인 학생들의 정보를 검색하시오
SELECT*FROM student WHERE stu_name LIKE '김%';
#7. 학생 중 이름의 두번쨰 문자가 '수'인 학생의 이름을 검색하시오
SELECT*FROM student WHERE stu_name LIKE '_수%';
#8. 학과가 컴퓨터 정보이거나 기계과인 학생의 학번과 이름을 검색하시오
SELECT stu_no, stu_name, stu_dept FROM student WHERE stu_dept='컴퓨터정보' OR stu_dept='기계';
SELECT stu_no, stu_name, stu_dept FROM student WHERE stu_dept IN ('컴퓨터정보', '기계');
#9. 학생의 기 정보가 null인 학생의 학번, 이름, 키 정보를 조회하시오.
SELECT stu_no, stu_name, stu_height FROM student WHERE stu_height IS NULL;
#10. 학생의 기 정보가 null이 아닌  학생의 학번, 이름, 키 정보를 조회하시오.
SELECT stu_no, stu_name, stu_height FROM student WHERE stu_height IS NOT NULL;
#11. 학과별 몸무게 평균을 구하시오.
SELECT stu_dept, AVG(stu_weight) AS '학과별 몸무게 평균' FROM student GROUP BY stu_dept; 

SELECT stu_dept, stu_grade, COUNT(stu_grade), AVG(stu_weight) FROM student GROUP BY stu_dept, stu_grade with ROLLUP; 
SELECT*FROM student;

#12. tb1_students 테이블에서 학년별 학생수를 구하시오.
SELECT grade, COUNT(sname) FROM tb1_students GROUP BY grade;

#13. 학년, 반별 학생수를 조회하시오.
SELECT grade, class, COUNT(sname) FROM tb1_students GROUP BY grade, class;

#14. 학년, 반별 국어점수의 합계를 조회하시오.
SELECT grade, class, SUM(kor_score) FROM tb1_students GROUP BY grade, class;

#15. 학년, 반별 국어점수, 영어점수, sql점수를 합한 총점을 내림차순으로 조회하시오.
SELECT grade, class, SUM(kor_score+eng_score+sql_score) AS 총합 FROM tb1_students  GROUP BY grade, class ORDER BY 총합 DESC;
#GROUP BY에서 조건을 걸고 싶을 때   HAVING절을 써준다.
SELECT grade, class, SUM(kor_score+eng_score+sql_score) AS 총합 FROM tb1_students  GROUP BY grade, class HAVING SUM(kor_score+eng_score+sql_score)> 1000;

#16. sql점수가 최저점인 학생의 이름과 학년, 반을 조회하시오.(서브쿼리가 막힐 때는 일단 여러줄 쓰기)
SELECT sname, grade, class FROM tb1_students WHERE sql_score=(SELECT MIN(sql_score) FROM tb1_students);

CREATE TABLE tbl_users(
	mem_id CHAR(10) PRIMARY KEY,
	mem_pw CHAR(10) NOT NULL,
	mem_num CHAR(11) DEFAULT 0,
	mem_gen CHAR(1) CHECK(mem_gen IN ('M', 'F'))
);
SELECT*FROM tbl_users;
DROP table tbl_users;
INSERT into tbl_users(mem_id, mem_pw, mem_num, mem_gen) VALUES('i','p','01012345678','M');

CREATE TABLE tbl_boards(
	bno INT AUTO_INCREMENT PRIMARY KEY,
	title VARCHAR(100) NOT NULL,
	content VARCHAR(1000) NOT NULL,
	writter VARCHAR(20),
	regdate DATETIME DEFAULT CURTIME(),
	FOREIGN KEY (writter) REFERENCES tbl_users(mem_id) #tbl_boards테이블 writer tbl_users 중 mem_id후보키설정해준다
);
SELECT*FROM tbl_boards;

INSERT into tbl_boards(title, content, writter) VALUES('뀨','뀨뀨','i');

SELECT u.mem_id, u.mem_pw, u.mem_num, u.mem_gen, b.title, b.content FROM  tbl_users u, tbl_boards b WHERE u.mem_id = b.writter;
SELECT mem_id, writter,title FROM tbl_users, tbl_boards WHERE mem_pw='p';


DROP TABLE tbl_boards;
SELECT*FROM tbl_users;



CREATE TABLE employees1(
	empno INT PRIMARY KEY AUTO_INCREMENT,
	ename VARCHAR(20),
	phone VARCHAR(13),
	dept CHAR(4)
);

CREATE TABLE eboard1(
	bno INT AUTO_INCREMENT PRIMARY KEY,
	title VARCHAR(50),
	content VARCHAR(100),
	empno INT,
	FOREIGN KEY(empno) REFERENCES employees1(empno) ON DELETE SET NULL ON UPDATE CASCADE
);
#외래키 변화에 대해서 반영
#FOREIGN (지금 작성할 테이블의 항목이름) references 참조할 테이블이름(참조할 테이블의 항목이름) ON 권한의 줄 기능(update, delete) CASCADE 


#독립적인 테이블 employees 테이블은 eboard테이블을 지워도 상관없지만 그 반대의 경우 eboard에서 employees테이블을 참조하고 있기 떄문에 지울 수 없다.
#on delete set null employees테이블에서 외래키를 지우면  references한 테이블에서 null로 바뀐다.
DROP TABLE eboard1;
DROP TABLE employees1;

INSERT INTO employees1(ename, phone, dept,empno) VALUE('홍길동', '01012345678', '부서1',1);
INSERT INTO employees1(ename, phone, dept,empno) VALUE('김길동', '0105558484', '부서2',2);
INSERT INTO eboard1(title, content, empno) VALUE('a', '네넨', 1);
INSERT INTO eboard1(title, content, empno) VALUE('c', '안녕', 2);

UPDATE employees1 SET empno=100 where empno=1;

DELETE FROM employees1 WHERE empno =100; 


SELECT*FROM employees1;
SELECT*FROM eboard1;

#테이블을 구조를 수정해주기
#컬럼 추가
ALTER TABLE employees ADD COLUMN address VARCHAR(100);
#데이터가 없을 때 지정값 넣어주기
ALTER TABLE employees ADD ninkname VARCHAR(50) DEFAULT '없음';
#컬럼 원하는 위치에 넣기
ALTER TABLE employees ADD COLUMN birth DATE AFTER phone;
#컬럼 수정
ALTER TABLE employees ADD COLUMN gender INT AFTER birth;
ALTER TABLE employees MODIFY COLUMN birth INT, MODIFY COLUMN gender CHAR(1);
ALTER TABLE employees MODIFY ninkname VARCHAR(50) AFTER birth;
#컬럼 이름 수정
ALTER TABLE employees CHANGE birth birthDate DATE;
#컬럼 삭제
ALTER TABLE employees DROP COLUMN ninkname;
#테이블 이름 수정
ALTER TABLE eboard RENAME tb1_eboard;

SELECT*FROM tb1_eboard;
DESC employees;

CREATE TABLE test (
	id VARCHAR(10),
	pw VARCHAR(10)
);

#기본키 입력
ALTER TABLE test ADD PRIMARY KEY  (id);
ALTER TABLE test DROP PRIMARY KEY;
#외래키 입력
ALTER TABLE test ADD COLUMN empno INT;
ALTER TABLE test ADD FOREIGN KEY (empno) REFERENCES employees(empno);
#외래키 이름 알아내기
SELECT*FROM information_schema.table_constraints WHERE TABLE_NAME = 'test';
#외래키 삭제
ALTER TABLE test01.test DROP FOREIGN KEY test_ibfk_1;

DESC test;