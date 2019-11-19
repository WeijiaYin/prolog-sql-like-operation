:- dynamic dstudent/3.
:- dynamic denroll/3.
:- dynamic dcourse/4.

/* student database */
student('10001', 'Mary', 'MiNI').
student('10002', 'John', 'MiNI').
student('10003', 'Harry', 'MiNI').
student('10004', 'Anna', 'MiNI').
student('10005', 'Anna', 'EiTI').

/* course database */
course('MSA-001', 'Calculus', 'profA', 'MiNI').
course('MSA-002', 'Algorithms', 'profB', 'MiNI').
course('MSA-003', 'C++', 'profC', 'MiNI').
course('MSA-004', 'C', 'profD', 'MiNI').

/* course enroll */
enroll('10001', 'MSA-001', 90).
enroll('10001', 'MSA-002', 60).
enroll('10001', 'MSA-003', 40).
enroll('10002', 'MSA-003', 70).
enroll('10003', 'MSA-003', 91).
enroll('10004', 'MSA-003', 92).
enroll('10005', 'MSA-003', 0).

/* end of initial database entry */
assert_course:-
    course(Course_id, Course_name, Course_prof, Course_faculty),
    assertz(dcourse(Course_id, Course_name, Course_prof, Course_faculty)),
    fail.
assert_course:-!.

assert_student:-
    student(Stu_id, Stu_name, Stu_faculty),
    assertz(dstudent(Stu_id, Stu_name, Stu_faculty)),
    fail.
assert_student:-!.

assert_enroll:-
    enroll(Stu_id, Course_id, Grade),
    assertz(denroll(Stu_id, Course_id, Grade)),
    fail.
assert_enroll:-!.


clear_database:-
    retract(dstudent(_,_,_)),
    retract(dcourse(_,_,_,_)),
    retract(denroll(_,_,_)),
    fail.
clear_database:-!.

do_mbase:-
    clear_database,
    assert_student,
    assert_course,
    assert_enroll.

view(Table):-
    Table==student ->
    write('stu_id stu_name stu_faculty'),nl,
    dstudent(X,Y,Z),
    write(X),tab(5),write(Y),tab(5),write(Z),nl,fail;
    Table==course ->
    write('course_id course_name course_prof course_faculty'), nl,
    dcourse(X,Y,Z,T),
    write(X),tab(3),write(Y),tab(3),write(Z),tab(3),write(T),nl,fail;
    Table==enroll ->
    write('stu_id course_id grade'),nl,
    denroll(X,Y,Z),
    write(X),tab(3),write(Y),tab(3),write(Z),nl,fail.

view(_):-!.

select_student(Attribute, Value):-
    Attribute==stu_id->
    dstudent(Value, X, Y),
    write(Value),tab(5),write(X),tab(5),write(Y),nl,fail;
    Attribute==stu_name->
    dstudent(X, Value, Y),
    write(X),tab(5),write(Value),tab(5),write(Y),nl,fail;
    Attribute==stu_faculty->
    dstudent(X,Y,Value),
    write(X),tab(5),write(Y),tab(5),write(Value),nl,fail.
select_student(_,_):-!.

select_course(Attribute, Value):-
    Attribute==course_id->
    dcourse(Value, X, Y, Z),
    write(Value),tab(3),write(X),tab(3),write(Y),tab(3),write(Z),nl,fail;
    Attribute==course_name->
    dcourse(X, Value, Y, Z),
    write(X),tab(3),write(Value),tab(3),write(Y),tab(3),write(Z),nl,fail;
    Attribute==course_prof->
    dcourse(X,Y,Value,Z),
    write(X),tab(3),write(Y),tab(3),write(Value),tab(3),write(Z),nl,fail;
    Attribute==course_faculty->
    dcourse(X,Y,Z,Value),
    write(X),tab(3),write(Y),tab(3),write(Z),tab(3),write(Value),nl,fail.
select_course(_,_):-!.

select_enroll(Attribute, Value):-
    Attribute==stu_id->
    denroll(Value,X,Y),
    write(Value),tab(3),write(X),tab(3),write(Y),nl,fail;
    Attribute==course_id->
    denroll(X,Value,Y),
    write(X),tab(3),write(Value),tab(3),write(Y),nl,fail;
    Attribute==grade->
    denroll(X,Y,Value),
    write(X),tab(3),write(Y),tab(3),write(Value),nl,fail.
select_enroll(_,_):-!.

select_table(Table, Attribute, Value):-
    Table==student->
    select_student(Attribute, Value);
    Table==course->
    select_course(Attribute, Value);
    Table==enroll->
    select_enroll(Attribute, Value).

insert_student(Stu_id, Stu_name, Stu_faculty):-
    assertz(dstudent(Stu_id, Stu_name, Stu_faculty)),!.

insert_course(Course_id, Course_name, Course_prof, Course_faculty):-
    assertz(dcourse(Course_id, Course_name, Course_prof, Course_faculty)),!.

insert_enroll(Stud_id, Course_id, Grade):-
    assertz(denroll(Stud_id, Course_id, Grade)),!.

insert_table(Table, A1, A2, A3):-
    Table==student->
    insert_student(A1, A2, A3);
    Table==enroll->
    insert_enroll(A1, A2, A3).
insert_table(course, A1, A2, A3, A4):-
    insert_course(A1, A2, A3, A4).

delete_student(Attribute, Value):-
    Attribute==stu_id->
    retract(dstudent(Value,_,_)),!;
    Attribute==stu_name->
    retract(dstudent(_,Value,_)),!;
    Attribute==stu_faculty->
    retract(dstudent(_,_,Value)),!.

delete_course(Attribute, Value):-
    Attribute==course_id->
    retract(dcourse(Value, _, _, _)),!;
    Attribute==course_name->
    retract(dcourse(_, Value, _, _)),!;
    Attribute==course_prof->
    retract(dcourse(_,_,Value,_)),!;
    Attribute==course_faculty->
    retract(dcourse(_,_,_,Value)),!.

delete_enroll(Attribute, Value):-
    Attribute==stu_id->
    retract(denroll(Value,_,_)),!;
    Attribute==course_id->
    retract(denroll(_,Value,_)),!;
    Attribute==grade->
    retract(denroll(_,_,Value)),!.

delete_table(Table, Attribute, Value):-
    Table==student->
    delete_student(Attribute, Value);
    Table==course->
    delete_course(Attribute, Value);
    Table==enroll->
    delete_enroll(Attribute, Value).

update_student(Attribute1, Value1, Attribute2, Value2):-
    Attribute1==stu_id->
    dstudent(Value1, X, Y),
    retract(dstudent(Value1,_,_)),
    (   Attribute2==stu_id->
        insert_student(Value2,X,Y);
        Attribute2==stu_name->
        insert_student(Value1, Value2, Y);
        Attribute2==stu_faculty->
        insert_student(Value1, X, Value2));
    Attribute1==stu_name->
    dstudent(X, Value1, Y),
    retract(dstudent(_,Value1,_)),
    (   Attribute2==stu_id->
        insert_student(Value2,Value1,Y);
        Attribute2==stu_name->
        insert_student(X, Value2, Y);
        Attribute2==stu_faculty->
        insert_student(X, Value1, Value2));
    Attribute1==stu_faculty->
    dstudent(X,Y,Value1),
    retract(dstudent(_,_,Value1)),
    (   Attribute2==stu_id->
        insert_student(Value2,Y,Value1);
        Attribute2==stu_name->
        insert_student(X, Value2, Value1);
        Attribute2==stu_faculty->
        insert_student(X, Y, Value2)),!.

update_enroll(Attribute1, Value1, Attribute2, Value2):-
    Attribute1==stu_id->
    denroll(Value1, X, Y),
    retract(denroll(Value1,_,_)),
    (   Attribute2==stu_id->
        insert_enroll(Value2,X,Y);
        Attribute2==course_id->
        insert_enroll(Value1, Value2, Y);
        Attribute2==grade->
        insert_enroll(Value1, X, Value2));
    Attribute1==course_id->
    denroll(X, Value1, Y),
    retract(denroll(_,Value1,_)),
    (   Attribute2==stu_id->
        insert_enroll(Value2,Value1,Y);
        Attribute2==course_id->
        insert_enroll(X, Value2, Y);
        Attribute2==grade->
        insert_enroll(X, Value1, Value2));
    Attribute1==gradde->
    denroll(X,Y,Value1),
    retract(denroll(_,_,Value1)),
    (   Attribute2==stu_id->
        insert_enroll(Value2,Y,Value1);
        Attribute2==course_id->
        insert_enroll(X, Value2, Value1);
        Attribute2==grade->
        insert_enroll(X, Y, Value2)),!.

update_course(Attribute1, Value1, Attribute2, Value2):-
    Attribute1==course_id->
    dcourse(Value1, X, Y, Z),
    retract(dcourse(Value1,_,_,_)),
    (   Attribute2==course_id->
        insert_course(Value2,X,Y,Z);
        Attribute2==course_name->
        insert_course(Value1, Value2, Y, Z);
        Attribute2==course_prof->
        insert_course(Value1, X, Value2, Z);
        Attribute2==course_faculty->
        insert_course(Value1, X, Y, Value2));
    Attribute1==course_name->
    dcourse(X, Value1, Y, Z),
    retract(dcourse(_,Value1,_,_)),
    (   Attribute2==course_id->
        insert_course(Value2,Value1,Y,Z);
        Attribute2==course_name->
        insert_course(X, Value2,Y,Z);
        Attribute2==course_prof->
        insert_course(X, Value1, Value2,Z);
        Attribute2==grade->
        insert_course(X, Value1, Y, Value2));
    Attribute1==course_prof->
    dcourse(X,Y,Value1,Z),
    retract(dcourse(_,_,Value1,_)),
    (   Attribute2==course_id->
        insert_course(Value2,Y,Value1,Z);
        Attribute2==course_name->
        insert_course(X, Value2, Value1,Z);
        Attribute2==course_prof->
        insert_course(X, Y, Value2, Z);
        Attribute2==course_faculty->
        insert_course(X,Y,Value1,Value2));
    Attribute1==course_faculty->
    dcourse(X,Y,Z,Value1),
    retract(dcourse(_,_,_,Value1)),
    (
        Attribute2==course_id->
        insert_course(Value2,Y,Z,Value1);
        Attribute2==course_name->
        insert_course(X,Value2,Z,Value1);
        Attribute2==course_prof->
        insert_course(X,Y,Value2,Value1);
        Attribute2==course_faculty->
        insert_course(X,Y,Z,Value2)),!.

update_table(Table, Attribute1, Value1, Attribute2, Value2):-
    Table==student->
    update_student(Attribute1, Value1, Attribute2, Value2);
    Table==course->
    update_course(Attribute1, Value1, Attribute2, Value2);
    Table==enroll->
    update_enroll(Attribute1, Value1, Attribute2, Value2).

join(Course_id):-
    write('Stu_id Stu_name Course_id Course_name grade'),nl,
    denroll(Stu_id,Course_id,Grade),
    dstudent(Stu_id,Stu_name,_),
    dcourse(Course_id,Course_name,_,_),
    write(Stu_id),tab(5),write(Stu_name),tab(5),write(Course_id),tab(5),write(Course_name),tab(5),write(Grade),nl,fail.

join(_):-!.

average_grade(Course_id):-
    aggregate(r(count, sum(Grade)),
             Stu_id^Course_id^denroll(Stu_id, Course_id, Grade),
              r(Count, Sum)),
    Count >0,
    Average is Sum/Count,
    write(Average).

