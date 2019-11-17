:- dynamic dplayer/8.

/* Pro Football Database */
player('Den Marino', 'Miami Dolphins', 13, 'QB', '6-3', 215, 4, 'Pittsburgh').
player('Richart Dent', 'Chicago Bears', 95, 'DE', '6-5', 263, 4 ,'Tennessee State').
player('Bernie Kosar', 'Cleveland Browns', 19, "QB", '6-5', 210, 2, 'Miami').
player('Doug Cosbie', 'Dallas Cowboys', 84, 'TE', '6-6', 235, 8, 'Santa Clara').
player('Mark Malone', 'Pittsburgh Steelers', 16, 'QB', '6-4', 223, 7, 'Arizona State').

/* end of initial database entry */
assert_database:-
    player(P_name, T_name, P_number, Pos, Ht, Wt, Exp, College),
    assertz(dplayer(P_name, T_name, P_number, Pos, Ht, Wt, Exp, College)),
    fail.
assert_database:-!.
clear_database:-
    retract(dplayer(_,_,_,_,_,_,_,_)),
    fail.
clear_database:-!.

equal(X,y):- X=y.


/* This database management system is a menu driven system. Based on the user query, it calls appropriate processes to serve the need. You may expend the menu to include more functions */

/* goal as a rule */

do_mbase:-
    assert_database,
    menu,
    clear_database.

menu:-
    repeat,
    write('***************************'),nl,
    write('         *'),nl,
    write('* 1. Add a Player to database   *'),nl,
    write('* 2. Delete a Player from database *'),nl,
    write('* 3. View a Player from database *'), nl,
    write('* 4. Update   *'), nl,
    write('* 5. Quit from this program *'), nl,
    write('***************************'),nl,
    write('Please enter your choice:1,2,3, 4 or 5:'),nl,
    read(Choice),nl,
    process(Choice),
    Choice = 5,!.

/* Add a Player to Database    */

process(1):-  write('Add a Player to Database'), nl,
    write('Enter Player name:'),
    read(P_name),
    write('Enter team:'),
    read(T_name),
    write('Enter Player number:'),
    read(P_number),
    write('Enter Position:'),
    read(Pos),
    write('Enter height:'),
    read(Ht),
    write('Enter Weight:'),
    read(Wt),
    write('Enter NFL exp:'),
    read(Exp),
    write('Enter college:'),
    read(College),
    assertz(dplayer(P_name, T_name, P_number, Pos, Ht, Wt, Exp, College)),
    write(P_name), write('has been added to the database.'),nl,!.

/* Delete a Player from Database   */

process(2):- write('Delete a Player from Database'),nl,
    write('Enter name to delete:'),
    read(P_name),
    retract(dplayer(P_name,_,_,_,_,_,_,_)),
    write(P_name), write('has been deleted from the database.'),
    nl,
    !.

/*   View a Player in the database   */

process(3):- write('View a Player'),nl,
    write('Enter name to view'),
    read(P_name),
    dplayer(P_name, T_name, P_number, Pos, Ht, Wt, Exp, College),nl,
    write('NFL league Player'), nl,
    write('Player name: '),write(P_name),nl,
    write(' Team Name : '),write(T_name), nl,
    write(' P_number: '), write(P_number), nl,
    write(' Position: '), write(Pos),nl,
    write(' Player\'s Height:'), write(Ht),nl,
    write(' Player\'s Weight:'), write(Wt),nl,
    write(' Player\'s NFL-exp:'), write(Exp),nl,
    write(' Player\'s College:'), write(College),nl,nl,
    !.

process(3):- write('No Luck'), nl,
    write('Can\'t find that Player in the database.'),nl,
    write('Sorry, bye!'),nl,
    !.

process(4):- write('Change a Player'),nl,
    write('Enter a name to change'),
    read(P_name),
    retract(dplayer(P_name,_,_,_,_,_,_,_)),
    write('Enter team:'),
    read(T_name),
    write('Enter Player number:'),
    read(P_number),
    write('Enter Position:'),
    read(Pos),
    write('Enter height:'),
    read(Ht),
    write('Enter Weight:'),
    read(Wt),
    write('Enter NFL exp:'),
    read(Exp),
    write('Enter college:'),
    read(College),
    assertz(dplayer(P_name, T_name, P_number, Pos, Ht, Wt, Exp, College)),
    write(P_name), write('has been added to the database.'),nl,!.

process(4):- write('No Luck'), nl,
    write('Can\'t find that Player in the database.'),nl,
    write('Sorry, bye!'),nl,
    !.

/* Quit from the program */
process(5):-write('Are you sure you want to quit(y/n)'),
    read(Answer),
    equal(Answer,'y'),!.


/* Invalid entry */
process(Choice):- Choice < 1, error.
process(Choice):- Choice > 5, error.

error:- write('Please Enter A number from 1 to 4'),nl.

/**************************************/
