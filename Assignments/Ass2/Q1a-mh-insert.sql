/* FIT9132 2019 S1 Assignment 2 Q1-Part A ANSWERS
   Student Name: Zilong Zheng
    Student ID: 29499496

   Comments to your marker:
   
*/
INSERT INTO patient VALUES (
    83728,
    'Aelene',
    'Bilsford',
    '3 Johnson Plaza',
    TO_DATE('22-Jan-1991', 'DD-MON-YYYY'),
    '5359177922'
);

INSERT INTO patient VALUES (
    129652,
    'Nathalie',
    'Martinuzzi',
    '599 Hoffman Court',
    TO_DATE('22-May-1981', 'DD-MON-YYYY'),
    '8559541051'
);

INSERT INTO patient VALUES (
    44763,
    'Jena',
    'Grassick',
    '016 Springs Center',
    TO_DATE('10-Dec-1994', 'DD-MON-YYYY'),
    '9425466425'
);

INSERT INTO patient VALUES (
    61434,
    'Nerita',
    'Baudry',
    '44334 Hoffman Junction',
    TO_DATE('23-May-1998', 'DD-MON-YYYY'),
    '5074885512'
);

INSERT INTO patient VALUES (
    104695,
    'Elfreda',
    'Fiddymont',
    '88 Myrtle Road',
    TO_DATE('02-Jul-1995', 'DD-MON-YYYY'),
    '1443195043'
);

INSERT INTO patient VALUES (
    33767,
    'Naomi',
    'Hallede',
    '7 Nova Crossing',
    TO_DATE('23-Nov-1982', 'DD-MON-YYYY'),
    '8698632407'
);

INSERT INTO patient VALUES (
    169419,
    'Hyacinthie',
    'Knottley',
    '256 Nancy Avenue',
    TO_DATE('08-Mar-1983', 'DD-MON-YYYY'),
    '1413154372'
);

INSERT INTO patient VALUES (
    93984,
    'Elayne',
    'Righy',
    '76557 East Avenue',
    TO_DATE('01-Nov-1990', 'DD-MON-YYYY'),
    '4681916910'
);

INSERT INTO patient VALUES (
    150823,
    'Donall',
    'Maskall',
    '81 Park Meadow Junction',
    TO_DATE('03-Nov-1983', 'DD-MON-YYYY'),
    '1886895708'
);

INSERT INTO patient VALUES (
    62902,
    'Gaby',
    'Chatel',
    '00068 Sommers Way',
    TO_DATE('10-Mar-1997', 'DD-MON-YYYY'),
    '9163867203'
);

INSERT INTO patient VALUES (
    100187,
    'Sebastien',
    'Bodsworth',
    '10 Foster street',
    TO_DATE('19-Feb-1995', 'DD-MON-YYYY'),
    '0578666646'
);

INSERT INTO patient VALUES (
    100175,
    'Doralin',
    'O''Brogane',
    '11 Monash street',
    TO_DATE('06-Jan-1996', 'DD-MON-YYYY'),
    '0566874832'
);

INSERT INTO admission VALUES (
    12000,
    TO_DATE('14-Mar-2019 8:00', 'DD-MON-YYYY HH24:MI'),
    NULL,
    100187,
    1033
);

INSERT INTO admission VALUES (
    12001,
    TO_DATE('14-Mar-2019 14:00', 'DD-MON-YYYY HH24:MI'),
    NULL,
    100175,
    1033
);

INSERT INTO admission VALUES (
    64724,
    TO_DATE('25-Mar-2019 07:00', 'DD-MON-YYYY HH24:MI'),
    TO_DATE('16-Apr-2019 14:00', 'DD-MON-YYYY HH24:MI'),
    129652,
    1033
);

INSERT INTO admission VALUES (
    48573,
    TO_DATE('25-Apr-2019 14:00', 'DD-MON-YYYY HH24:MI'),
    TO_DATE('15-May-2019 16:00', 'DD-MON-YYYY HH24:MI'),
    44763,
    1033
);

INSERT INTO admission VALUES (
    136963,
    TO_DATE('21-Apr-2019 07:14', 'DD-MON-YYYY HH24:MI'),
    TO_DATE('03-May-2019 13:30', 'DD-MON-YYYY HH24:MI'),
    83728,
    1033
);

INSERT INTO admission VALUES (
    84266,
    TO_DATE('27-Jan-2019 22:10', 'DD-MON-YYYY HH24:MI'),
    TO_DATE('19-Mar-2019 13:24', 'DD-MON-YYYY HH24:MI'),
    129652,
    1048
);

INSERT INTO admission VALUES (
    54210,
    TO_DATE('23-Jan-2019 14:34', 'DD-MON-YYYY HH24:MI'),
    TO_DATE('10-Feb-2019 10:30', 'DD-MON-YYYY HH24:MI'),
    44763,
    1061
);

INSERT INTO admission VALUES (
    85599,
    TO_DATE('01-May-2019 07:00', 'DD-MON-YYYY HH24:MI'),
    TO_DATE('31-May-2019 22:00', 'DD-MON-YYYY HH24:MI'),
    61434,
    1084
);

INSERT INTO admission VALUES (
    187382,
    TO_DATE('07-Jan-2019 08:00', 'DD-MON-YYYY HH24:MI'),
    TO_DATE('01-Apr-2019 23:00', 'DD-MON-YYYY HH24:MI'),
    104695,
    2459
);

INSERT INTO admission VALUES (
    1131,
    TO_DATE('14-Jan-2019 14:00', 'DD-MON-YYYY HH24:MI'),
    TO_DATE('30-Jan-2019 15:00', 'DD-MON-YYYY HH24:MI'),
    33767,
    7890
);

INSERT INTO admission VALUES (
    153274,
    TO_DATE('12-Mar-2019 09:00', 'DD-MON-YYYY HH24:MI'),
    TO_DATE('09-May-2019 14:00', 'DD-MON-YYYY HH24:MI'),
    169419,
    1069
);

INSERT INTO admission VALUES (
    188835,
    TO_DATE('05-Feb-2019 12:00', 'DD-MON-YYYY HH24:MI'),
    TO_DATE('25-Feb-2019 09:00', 'DD-MON-YYYY HH24:MI'),
    93984,
    1033
);

INSERT INTO admission VALUES (
    183348,
    TO_DATE('13-May-2019 13:00', 'DD-MON-YYYY HH24:MI'),
    TO_DATE('20-May-2019 15:00', 'DD-MON-YYYY HH24:MI'),
    150823,
    7900
);

INSERT INTO admission VALUES (
    162315,
    TO_DATE('25-Feb-2019 23:00', 'DD-MON-YYYY HH24:MI'),
    TO_DATE('14-Apr-2019 16:00', 'DD-MON-YYYY HH24:MI'),
    62902,
    1095
);

INSERT INTO admission VALUES (
    72362,
    TO_DATE('23-Jan-2019 14:00', 'DD-MON-YYYY HH24:MI'),
    TO_DATE('27-Jan-2019 09:00', 'DD-MON-YYYY HH24:MI'),
    61434,
    1027
);

INSERT INTO admission VALUES (
    99879,
    TO_DATE('09-Feb-2019 13:00', 'DD-MON-YYYY HH24:MI'),
    TO_DATE('21-Feb-2019 14:00', 'DD-MON-YYYY HH24:MI'),
    169419,
    1033
);

INSERT INTO admission VALUES (
    176252,
    TO_DATE('20-Feb-2019 04:00', 'DD-MON-YYYY HH24:MI'),
    TO_DATE('13-Mar-2019 16:00', 'DD-MON-YYYY HH24:MI'),
    44763,
    1060
);

INSERT INTO admission VALUES (
    49726,
    TO_DATE('05-May-2019 06:00', 'DD-MON-YYYY HH24:MI'),
    TO_DATE('17-May-2019 09:00', 'DD-MON-YYYY HH24:MI'),
    129652,
    1084
);

INSERT INTO admission VALUES (
    131922,
    TO_DATE('10-Apr-2019 03:00', 'DD-MON-YYYY HH24:MI'),
    TO_DATE('06-May-2019 15:00', 'DD-MON-YYYY HH24:MI'),
    104695,
    1298
);

INSERT INTO adm_prc VALUES (
    11471,
    TO_DATE('30-Apr-2019', 'DD-MON-YYYY'),
    200,
    3.45,
    136963,
    15509,
    1012,
    1005
);

INSERT INTO adm_prc VALUES (
    169780,
    TO_DATE('06-Feb-2019', 'DD-MON-YYYY'),
    500,
    6.75,
    84266,
    33335,
    1018,
    1005
);

INSERT INTO adm_prc VALUES (
    115609,
    TO_DATE('01-Mar-2019', 'DD-MON-YYYY'),
    300,
    8.6,
    84266,
    40099,
    1027,
    1028
);

INSERT INTO adm_prc VALUES (
    111315,
    TO_DATE('28-Jan-2019', 'DD-MON-YYYY'),
    1000,
    182.33,
    54210,
    12055,
    1033,
    1027
);

INSERT INTO adm_prc VALUES (
    124417,
    TO_DATE('10-May-2019', 'DD-MON-YYYY'),
    300,
    15.1,
    85599,
    40100,
    1033,
    1027
);

INSERT INTO adm_prc VALUES (
    114181,
    TO_DATE('15-Jan-2019', 'DD-MON-YYYY'),
    264.32,
    123,
    187382,
    43114,
    1048,
    1028
);

INSERT INTO adm_prc VALUES (
    65605,
    TO_DATE('20-Jan-2019', 'DD-MON-YYYY'),
    1442.43,
    4.76,
    1131,
    65554,
    1060,
    1056
);

INSERT INTO adm_prc VALUES (
    112765,
    TO_DATE('20-Mar-2019', 'DD-MON-YYYY'),
    23.43,
    0,
    153274,
    71432,
    1069,
    1061
);

INSERT INTO adm_prc VALUES (
    107420,
    TO_DATE('15-Apr-2019', 'DD-MON-YYYY'),
    203.43,
    0,
    153274,
    49518,
    1056,
    1064
);

INSERT INTO adm_prc VALUES (
    163120,
    TO_DATE('12-Feb-2019', 'DD-MON-YYYY'),
    340.50,
    0.72,
    188835,
    15511,
    1095,
    1084
);

INSERT INTO adm_prc VALUES (
    45832,
    TO_DATE('14-May-2019', 'DD-MON-YYYY'),
    123,
    2.28,
    183348,
    19887,
    2459,
    1099
);

INSERT INTO adm_prc VALUES (
    109309,
    TO_DATE('28-Feb-2019', 'DD-MON-YYYY'),
    482,
    0.45,
    162315,
    40100,
    7890,
    1099
);

INSERT INTO adm_prc VALUES (
    97170,
    TO_DATE('05-Mar-2019', 'DD-MON-YYYY'),
    45.65,
    0,
    162315,
    54132,
    7900,
    1298
);

INSERT INTO adm_prc VALUES (
    176071,
    TO_DATE('26-Mar-2019', 'DD-MON-YYYY'),
    273,
    215.1,
    162315,
    27459,
    2459,
    1298
);

INSERT INTO adm_prc VALUES (
    126423,
    TO_DATE('24-Jan-2019', 'DD-MON-YYYY'),
    34.43,
    0,
    72362,
    15509,
    7890,
    1095
);

INSERT INTO adm_prc VALUES (
    13820,
    TO_DATE('12-Feb-2019', 'DD-MON-YYYY'),
    54.34,
    0,
    99879,
    15510,
    1095,
    1064
);

INSERT INTO adm_prc VALUES (
    177186,
    TO_DATE('25-Feb-2019', 'DD-MON-YYYY'),
    857.45,
    11.94,
    176252,
    43111,
    1298,
    1099
);

INSERT INTO adm_prc VALUES (
    110461,
    TO_DATE('09-May-2019', 'DD-MON-YYYY'),
    172.34,
    39.3,
    49726,
    15511,
    1060,
    7900
);

INSERT INTO adm_prc VALUES (
    53307,
    TO_DATE('12-Apr-2019', 'DD-MON-YYYY'),
    184,
    162.4,
    131922,
    65554,
    1099,
    1033
);

INSERT INTO adm_prc VALUES (
    199251,
    TO_DATE('15-Apr-2019', 'DD-MON-YYYY'),
    173,
    365.48,
    131922,
    43556,
    1048,
    1027
);

INSERT INTO item_treatment VALUES (
    11471,
    'NE001',
    1,
    3.45
);

INSERT INTO item_treatment VALUES (
    169780,
    'CA002',
    3,
    6.75
);

INSERT INTO item_treatment VALUES (
    115609,
    'TE001',
    5,
    8.6
);

INSERT INTO item_treatment VALUES (
    111315,
    'AN002',
    1,
    182.33
);

INSERT INTO item_treatment VALUES (
    124417,
    'SS006',
    1,
    15.1
);

INSERT INTO item_treatment VALUES (
    114181,
    'KN056',
    1,
    123
);

INSERT INTO item_treatment VALUES (
    65605,
    'PS318',
    1,
    4.76
);

INSERT INTO item_treatment VALUES (
    163120,
    'ST252',
    1,
    0.72
);

INSERT INTO item_treatment VALUES (
    45832,
    'AT258',
    2,
    2.28
);

INSERT INTO item_treatment VALUES (
    109309,
    'TN010',
    1,
    0.45
);

INSERT INTO item_treatment VALUES (
    176071,
    'LB250',
    1,
    215.1
);

INSERT INTO item_treatment VALUES (
    177186,
    'CE001',
    3,
    11.94
);

INSERT INTO item_treatment VALUES (
    110461,
    'CE010',
    10,
    39.3
);

INSERT INTO item_treatment VALUES (
    53307,
    'AP050',
    2,
    162.4
);

INSERT INTO item_treatment VALUES (
    199251,
    'BI500',
    1,
    365.48
);

COMMIT;