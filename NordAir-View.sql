/* **********************************************************
	NordAir - Vues
	Schéma MRD:	"NordAir"
	Auteur:		Arthur Tirado et Xavier Breton-L'italien	
********************************************************** */
USE NORDAIR
GO	
 /* Question B.1
Créer la vue V_ENVOLEES_SIEGES qui renvoie toutes les envolées avec les informations
suivantes :
	L’identifiant de l’envolée (ID_ENVOLEE);
	L’appellation de l’avion, COPA ou CADM (APPEL_AVION);
	Le nombre de sièges dans l’avion (NB_SIEGES);
	Le nombre de sièges réservés pour l’envolée (NB_RESERVES).
 */
DROP VIEW IF EXISTS V_ENVOLEES_SIEGES
GO
CREATE VIEW V_ENVOLEES_SIEGES AS
SELECT
	ENVOLEE.ID_ENVOLEE,
	AVION.APPEL_AVION,
	AVION.NOMBRE_PLACES,
	ISNULL(COUNT(RESERVATION_ENVOLEE.ID_RESERVATION), 0) AS NB_RESERVE
FROM
	ENVOLEE
	INNER JOIN AVION
		ON ENVOLEE.ID_AVION = AVION.ID_AVION
	LEFT OUTER JOIN RESERVATION_ENVOLEE
		ON ENVOLEE.ID_ENVOLEE = RESERVATION_ENVOLEE.ID_ENVOLEE
GROUP BY
	ENVOLEE.ID_ENVOLEE,
	AVION.APPEL_AVION,
	AVION.NOMBRE_PLACES
ORDER BY
	ENVOLEE.ID_ENVOLEE

/*
Écrire une requête SELECT pour vérifier le contenu complet de la vue,
trié par l’identifiant des envolées.
L’affichage de cette requête de validation doit être de qualité.
Inclure le résultat affiché lors de l’exécution de la requête d’interrogation de la vue.
*/
GO
SELECT * FROM V_ENVOLEES_SIEGES
ORDER BY ID_ENVOLEE
/*
ID_ENVOLEE                              APPEL_AVION ID_AVION                                NOMBRE_PLACES                           NB_RESERVE
--------------------------------------- ----------- --------------------------------------- --------------------------------------- -----------
1                                       COPA        2                                       48                                      4
2                                       COPA        2                                       48                                      3
3                                       COPA        2                                       48                                      1
4                                       COPA        2                                       48                                      1
5                                       COPA        2                                       48                                      0
6                                       COPA        2                                       48                                      0
7                                       COPA        2                                       48                                      0
8                                       COPA        2                                       48                                      1
9                                       CADM        1                                       32                                      0
10                                      CADM        1                                       32                                      0
11                                      CADM        1                                       32                                      0
12                                      CADM        1                                       32                                      1
13                                      CADM        1                                       32                                      7
14                                      CADM        1                                       32                                      7
15                                      CADM        1                                       32                                      7
16                                      CADM        1                                       32                                      2
17                                      COPA        2                                       48                                      0
18                                      COPA        2                                       48                                      0
19                                      COPA        2                                       48                                      0
20                                      COPA        2                                       48                                      1
21                                      COPA        2                                       48                                      0
22                                      COPA        2                                       48                                      0
23                                      COPA        2                                       48                                      0
24                                      COPA        2                                       48                                      0
25                                      CADM        1                                       32                                      0
26                                      CADM        1                                       32                                      0
27                                      CADM        1                                       32                                      0
28                                      CADM        1                                       32                                      0
29                                      CADM        1                                       32                                      0
30                                      CADM        1                                       32                                      1
31                                      CADM        1                                       32                                      0
32                                      CADM        1                                       32                                      0
33                                      COPA        2                                       48                                      0
34                                      COPA        2                                       48                                      0
35                                      COPA        2                                       48                                      1
36                                      COPA        2                                       48                                      0
37                                      COPA        2                                       48                                      0
38                                      COPA        2                                       48                                      0
39                                      COPA        2                                       48                                      0
40                                      COPA        2                                       48                                      0
41                                      CADM        1                                       32                                      0
42                                      CADM        1                                       32                                      0
43                                      CADM        1                                       32                                      1
44                                      CADM        1                                       32                                      2
45                                      CADM        1                                       32                                      0
46                                      CADM        1                                       32                                      0
47                                      CADM        1                                       32                                      0
48                                      CADM        1                                       32                                      0
49                                      COPA        2                                       48                                      4
50                                      COPA        2                                       48                                      2
51                                      COPA        2                                       48                                      1
52                                      COPA        2                                       48                                      2
53                                      COPA        2                                       48                                      0
54                                      COPA        2                                       48                                      2
55                                      COPA        2                                       48                                      0
56                                      COPA        2                                       48                                      1
57                                      CADM        1                                       32                                      0
58                                      CADM        1                                       32                                      0
59                                      CADM        1                                       32                                      0
60                                      CADM        1                                       32                                      1
61                                      CADM        1                                       32                                      3
62                                      CADM        1                                       32                                      1
63                                      CADM        1                                       32                                      1
64                                      CADM        1                                       32                                      0
65                                      CADM        1                                       32                                      0
66                                      CADM        1                                       32                                      0
67                                      CADM        1                                       32                                      0
68                                      CADM        1                                       32                                      1
69                                      COPA        2                                       48                                      0
70                                      COPA        2                                       48                                      0
71                                      COPA        2                                       48                                      0
72                                      COPA        2                                       48                                      0
73                                      COPA        2                                       48                                      0
74                                      COPA        2                                       48                                      0
75                                      COPA        2                                       48                                      0
76                                      COPA        2                                       48                                      0
77                                      CADM        1                                       32                                      1
78                                      CADM        1                                       32                                      1
79                                      CADM        1                                       32                                      1
80                                      CADM        1                                       32                                      1
81                                      CADM        1                                       32                                      3
82                                      CADM        1                                       32                                      3
83                                      CADM        1                                       32                                      0
84                                      CADM        1                                       32                                      2
85                                      COPA        2                                       48                                      0
86                                      COPA        2                                       48                                      0
87                                      COPA        2                                       48                                      1
88                                      COPA        2                                       48                                      0
89                                      COPA        2                                       48                                      2
90                                      COPA        2                                       48                                      0
91                                      COPA        2                                       48                                      1
92                                      COPA        2                                       48                                      1
93                                      CADM        1                                       32                                      0
94                                      CADM        1                                       32                                      0
95                                      CADM        1                                       32                                      0
96                                      CADM        1                                       32                                      0
97                                      CADM        1                                       32                                      0
98                                      CADM        1                                       32                                      0
99                                      CADM        1                                       32                                      0
100                                     CADM        1                                       32                                      1
101                                     COPA        2                                       48                                      0
102                                     COPA        2                                       48                                      1
103                                     COPA        2                                       48                                      1
104                                     COPA        2                                       48                                      0
105                                     COPA        2                                       48                                      0
106                                     COPA        2                                       48                                      0
107                                     COPA        2                                       48                                      0
108                                     COPA        2                                       48                                      0
109                                     CADM        1                                       32                                      4
110                                     CADM        1                                       32                                      1
111                                     CADM        1                                       32                                      1
112                                     CADM        1                                       32                                      0
113                                     CADM        1                                       32                                      0
114                                     CADM        1                                       32                                      3
115                                     CADM        1                                       32                                      0
116                                     CADM        1                                       32                                      1
117                                     COPA        2                                       48                                      0
118                                     COPA        2                                       48                                      0
119                                     COPA        2                                       48                                      0
120                                     COPA        2                                       48                                      0
121                                     COPA        2                                       48                                      0
122                                     COPA        2                                       48                                      2
123                                     COPA        2                                       48                                      0
124                                     COPA        2                                       48                                      0
125                                     CADM        1                                       32                                      0
126                                     CADM        1                                       32                                      0
127                                     CADM        1                                       32                                      2
128                                     CADM        1                                       32                                      1

(128 rows affected)
*/

/* Question B.2
Créer la vue V_PASSAGERS_VOLS qui renvoie la liste des passagers ayant des réservations sur des
vols avec les informations suivantes :
	- L’identifiant passager (ID_PASSAGER);
	- Le nom du passager (NOM_PASSAGER);
	- Le prénom du passager (PRENOM_PASSAGER);
	- La date du vol, ou plutôt de l’envolées… (DATE_VOL);
	- L’identifiant du vol (ID_VOL);
	- L’ordre du segment de départ du passager : lettre A, B, C etc. (ORDRE_SEG_DEPART);
	- L’ordre du segment d’arrivée du passager : lettre A, B, C etc. (ORDRE_SEG_ARRIVEE).
*/
GO
DROP VIEW IF EXISTS V_PASSAGERS_VOLS
GO
CREATE VIEW V_PASSAGERS_VOLS AS
SELECT
	PASSAGER.ID_PASSAGER,
	PASSAGER.NOM,
	PASSAGER.PRENOM,
	ENVOLEE.DATE_ENVOLEE,
	SEGMENT.ID_VOL,
	MIN(SEGMENT.ORDRE_SEGMENT) AS ORDRE_SEG_DEPART,
	MAX(SEGMENT.ORDRE_SEGMENT) AS ORDRE_SEG_ARRIVEE

	FROM PASSAGER
		INNER JOIN RESERVATION ON
			PASSAGER.ID_PASSAGER = RESERVATION.ID_PASSAGER
		INNER JOIN RESERVATION_ENVOLEE ON
			RESERVATION.ID_RESERVATION = RESERVATION_ENVOLEE.ID_RESERVATION
		INNER JOIN ENVOLEE ON
			RESERVATION_ENVOLEE.ID_ENVOLEE = ENVOLEE.ID_ENVOLEE
		INNER JOIN SEGMENT ON
			ENVOLEE.ID_SEGMENT = SEGMENT.ID_SEGMENT
	GROUP BY
		PASSAGER.ID_PASSAGER,
		PASSAGER.NOM,
		PASSAGER.PRENOM,
		ENVOLEE.DATE_ENVOLEE,
		SEGMENT.ID_VOL
GO
/*
ID_PASSAGER                             NOM             PRENOM          DATE_ENVOLEE            ID_VOL                                  ORDRE_SEG_DEPART ORDRE_SEG_ARRIVEE
--------------------------------------- --------------- --------------- ----------------------- --------------------------------------- ---------------- -----------------
1                                       Barbeau         Isabelle        2024-05-13 00:00:00.000 1                                       A                A
2                                       Berthiaume      Jonny           2024-05-13 00:00:00.000 1                                       A                A
3                                       Bolduc          Sebastien       2024-05-13 00:00:00.000 1                                       B                B
4                                       BrindAmour      Jean-Francois   2024-05-13 00:00:00.000 1                                       A                A
5                                       Desjardins      Francois        2024-05-13 00:00:00.000 1                                       A                D
16                                      Mercier         David           2024-05-13 00:00:00.000 1                                       B                B
2                                       Berthiaume      Jonny           2024-05-13 00:00:00.000 2                                       D                D
14                                      Nadeau          Michel          2024-05-13 00:00:00.000 3                                       D                D
9                                       Fortin          Mathieu         2024-05-13 00:00:00.000 4                                       A                B
12                                      Gregoire        Pierre-Luc      2024-05-13 00:00:00.000 4                                       A                C
15                                      Tremblay        Vincent         2024-05-13 00:00:00.000 4                                       C                C
20                                      Poussier        Genevieve       2024-05-13 00:00:00.000 4                                       C                C
29                                      Lapointe-Girard etienne         2024-05-13 00:00:00.000 4                                       A                C
32                                      Ouellet         Remi            2024-05-13 00:00:00.000 4                                       A                B
33                                      Ouellette       Pierre          2024-05-13 00:00:00.000 4                                       A                C
35                                      Tremblay        Sebastien       2024-05-13 00:00:00.000 4                                       A                D
36                                      Talbot          Remi            2024-05-13 00:00:00.000 4                                       A                D
8                                       Harnois         Stephane J.     2024-05-14 00:00:00.000 1                                       D                D
4                                       BrindAmour      Jean-Francois   2024-05-14 00:00:00.000 4                                       B                B
37                                      Rouillard       Guy             2024-05-15 00:00:00.000 1                                       C                C
6                                       Cote            Mathieu         2024-05-15 00:00:00.000 3                                       D                D
9                                       Fortin          Mathieu         2024-05-15 00:00:00.000 3                                       C                D
7                                       Fortin          Jean-Philippe   2024-05-16 00:00:00.000 1                                       D                D
18                                      Duval           Philippe        2024-05-16 00:00:00.000 1                                       A                A
19                                      Lapierre        Guillaume       2024-05-16 00:00:00.000 1                                       A                A
20                                      Poussier        Genevieve       2024-05-16 00:00:00.000 1                                       B                B
21                                      Mallet          Sylvain         2024-05-16 00:00:00.000 1                                       A                A
22                                      Saucier         Jean-Francois   2024-05-16 00:00:00.000 1                                       A                D
10                                      Jobin           Samuel          2024-05-16 00:00:00.000 2                                       B                B
19                                      Lapierre        Guillaume       2024-05-16 00:00:00.000 2                                       D                D
37                                      Rouillard       Guy             2024-05-16 00:00:00.000 2                                       B                B
31                                      Aubert          Vincent         2024-05-16 00:00:00.000 3                                       D                D
5                                       Desjardins      Francois        2024-05-16 00:00:00.000 4                                       A                C
7                                       Fortin          Jean-Philippe   2024-05-16 00:00:00.000 4                                       A                A
9                                       Fortin          Mathieu         2024-05-16 00:00:00.000 4                                       A                A
25                                      Aspiros         Charles         2024-05-17 00:00:00.000 1                                       D                D
5                                       Desjardins      Francois        2024-05-17 00:00:00.000 4                                       D                D
11                                      Ratte           Francois        2024-05-17 00:00:00.000 4                                       A                A
21                                      Mallet          Sylvain         2024-05-17 00:00:00.000 4                                       B                B
32                                      Ouellet         Remi            2024-05-17 00:00:00.000 4                                       C                C
11                                      Ratte           Francois        2024-05-18 00:00:00.000 1                                       D                D
12                                      Gregoire        Pierre-Luc      2024-05-18 00:00:00.000 1                                       B                B
23                                      Lagace          Mathieu         2024-05-18 00:00:00.000 1                                       D                D
29                                      Lapointe-Girard etienne         2024-05-18 00:00:00.000 1                                       B                B
33                                      Ouellette       Pierre          2024-05-18 00:00:00.000 1                                       B                B
35                                      Tremblay        Sebastien       2024-05-18 00:00:00.000 1                                       A                A
36                                      Talbot          Remi            2024-05-18 00:00:00.000 1                                       A                A
37                                      Rouillard       Guy             2024-05-18 00:00:00.000 1                                       A                A
13                                      Dostie-Proulx   Pierre-Luc      2024-05-18 00:00:00.000 2                                       C                C
17                                      Dionne          Marjorie        2024-05-18 00:00:00.000 3                                       A                A
26                                      Picard          Maxime          2024-05-18 00:00:00.000 3                                       C                D
34                                      Pelletier       Nathalie        2024-05-18 00:00:00.000 3                                       A                A
24                                      Blanchette      Marc            2024-05-19 00:00:00.000 1                                       D                D
27                                      Richard         Jean-Francois   2024-05-19 00:00:00.000 2                                       B                B
30                                      Mercier         Nicolas         2024-05-19 00:00:00.000 2                                       C                C
22                                      Saucier         Jean-Francois   2024-05-19 00:00:00.000 4                                       A                C
24                                      Blanchette      Marc            2024-05-19 00:00:00.000 4                                       A                A
26                                      Picard          Maxime          2024-05-19 00:00:00.000 4                                       A                A
28                                      Dube            Jason           2024-05-19 00:00:00.000 4                                       A                A
28                                      Dube            Jason           2024-05-20 00:00:00.000 1                                       D                D
35                                      Tremblay        Sebastien       2024-05-20 00:00:00.000 1                                       B                B
36                                      Talbot          Remi            2024-05-20 00:00:00.000 1                                       B                B
37                                      Rouillard       Guy             2024-05-20 00:00:00.000 1                                       B                B
17                                      Dionne          Marjorie        2024-05-20 00:00:00.000 3                                       B                B
34                                      Pelletier       Nathalie        2024-05-20 00:00:00.000 3                                       B                B
16                                      Mercier         David           2024-05-20 00:00:00.000 4                                       C                C
22                                      Saucier         Jean-Francois   2024-05-20 00:00:00.000 4                                       D                D
33                                      Ouellette       Pierre          2024-05-20 00:00:00.000 4                                       C                C

(68 rows affected)
*/
SELECT * FROM V_PASSAGERS_VOLS
ORDER BY DATE_ENVOLEE,  ID_VOL