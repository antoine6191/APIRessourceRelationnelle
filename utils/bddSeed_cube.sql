CREATE DATABASE IF NOT EXISTS ressource_relationelle;
use ressource_relationelle;

DROP TABLE IF EXISTS ressource_relationelle.statistiques;
DROP TABLE IF EXISTS ressource_relationelle.favoris;
DROP TABLE IF EXISTS ressource_relationelle.commits;
DROP TABLE IF EXISTS ressource_relationelle.ressources;
DROP TABLE IF EXISTS ressource_relationelle.users;
DROP TABLE IF EXISTS ressource_relationelle.roles;
DROP TABLE IF EXISTS ressource_relationelle.ressource_types;
DROP TABLE IF EXISTS ressource_relationelle.relation_types;
DROP TABLE IF EXISTS ressource_relationelle.categories;

CREATE TABLE roles(
    id int PRIMARY KEY,
    libelle varchar(50),
    createdAt datetime DEFAULT CURRENT_TIMESTAMP,
    updatedAt datetime DEFAULT CURRENT_TIMESTAMP  
);

CREATE TABLE users(
    id int PRIMARY KEY NOT NULL AUTO_INCREMENT,
    nom varchar(50),
    prenom varchar(50),
    mail varchar(50),
    telephone varchar(50),
    motdepasse varchar(50),
    cp varchar(50),
    rue varchar(50),
    numero varchar(50),
    ville varchar(50),
    createdAt datetime DEFAULT CURRENT_TIMESTAMP,
    updatedAt datetime DEFAULT CURRENT_TIMESTAMP,
    role_id int,
    FOREIGN KEY (role_id) REFERENCES roles(id)
);

CREATE TABLE categories(
    id int PRIMARY KEY NOT NULL AUTO_INCREMENT,
    label varchar(50),
    createdAt datetime DEFAULT CURRENT_TIMESTAMP,
    updatedAt datetime DEFAULT CURRENT_TIMESTAMP  
);

CREATE TABLE relation_types(
    id int PRIMARY KEY NOT NULL AUTO_INCREMENT,
    label varchar(50),
    createdAt datetime DEFAULT CURRENT_TIMESTAMP,
    updatedAt datetime DEFAULT CURRENT_TIMESTAMP  
);

CREATE TABLE ressource_types(
    id int PRIMARY KEY NOT NULL AUTO_INCREMENT,
    label varchar(50),
    createdAt datetime DEFAULT CURRENT_TIMESTAMP,
    updatedAt datetime DEFAULT CURRENT_TIMESTAMP  
);

CREATE TABLE ressources(
    id int PRIMARY KEY NOT NULL AUTO_INCREMENT,
    titre varchar(50),
    description text,
    createdAt datetime DEFAULT CURRENT_TIMESTAMP,
    updatedAt datetime DEFAULT CURRENT_TIMESTAMP,
    categorie_id int,
    relation_types_id int,
    ressource_types_id int,
    user_id int,
    FOREIGN KEY (categorie_id) REFERENCES categories(id),
    FOREIGN KEY (relation_types_id) REFERENCES relation_types(id),
    FOREIGN KEY (ressource_types_id) REFERENCES ressource_types(id),
    FOREIGN KEY (user_id) REFERENCES users(id)

);

CREATE TABLE commits(
    id int PRIMARY KEY NOT NULL AUTO_INCREMENT,
    post datetime DEFAULT CURRENT_TIMESTAMP,
    texte varchar(250),
    createdAt datetime DEFAULT CURRENT_TIMESTAMP,
    updatedAt datetime DEFAULT CURRENT_TIMESTAMP,
    user_id int,
    ressource_id int,
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (ressource_id) REFERENCES ressources(id)
);

CREATE TABLE favoris(
    id int PRIMARY KEY NOT NULL AUTO_INCREMENT,
    favoris boolean,
    createdAt datetime DEFAULT CURRENT_TIMESTAMP,
    updatedAt datetime DEFAULT CURRENT_TIMESTAMP,
    user_id int,
    ressource_id int,
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (ressource_id) REFERENCES ressources(id)
);

CREATE TABLE statistiques(
    id int PRIMARY KEY NOT NULL AUTO_INCREMENT,
    nb_vues int,
    createdAt datetime DEFAULT CURRENT_TIMESTAMP,
    updatedAt datetime DEFAULT CURRENT_TIMESTAMP,
    ressource_id int,
    FOREIGN KEY (ressource_id) REFERENCES ressources(id)
);

INSERT INTO roles(id, libelle)
VALUES (1, 'citoyen'), (2, 'admin'), (3, 'superadmin');

INSERT INTO users(id, nom, prenom, mail, telephone, motdepasse, cp, rue, numero, ville, role_id)
VALUES (1, 'hervieu', 'antoine', 'antoine.hervieu@gmail.com', '0611695851', 'test1234', '72290', 'lieu dit le jardin', 'na', 'mezieres sur ponthouin', 3),
    (2, 'teillay', 'louis', 'louis.tellay@gmail.com', '0611695852', 'test1234', '72000', 'avenue rhin et danube', '121', 'le mans', 2),
    (3, 'poyeau', 'tom', 'tom.poyeau@gmail.com', '0611695853', 'test1234', '72100', 'avenue olivier heuze', '151bis', 'le mans', 2),
    (4, 'prunier', 'corentin', 'corentin.prunier@gmail.com', '0611695854', 'test1234', '72510', 'na', 'na', 'na', 1);

INSERT INTO categories(id, label)
VALUES (1, 'communication'), 
    (2, 'cultures'), 
    (3, 'd??veloppement personnel'), 
    (4, 'loisirs'), 
    (5, 'monde professionnel'), 
    (6, 'parentalit??'), 
    (7, 'qualit?? de vie'), 
    (8, 'recherche de sens'), 
    (9, 'sant?? physique'), 
    (10, 'sant?? psychique'), 
    (11, 'spiritualit??'), 
    (12, 'vie affective'),
    (13, 'intelligence ??motionelle');

INSERT INTO relation_types(id, label)
VALUES (1, 'soi'), 
    (2, 'conjoints'), 
    (3, 'famille: enfants/parents/fratrie'), 
    (4, 'professionnelle: coll??gues, collaborateurs, managers'),
    (5, 'amis et communaut??s'),
    (6, 'inconnus');

INSERT INTO ressource_types(id, label)
VALUES (1, 'activit??/jeu ?? r??aliser'), 
    (2, 'article'), 
    (3, 'carte d??fi'), 
    (4, 'cours au format pdf'),
    (5, 'exercice/atelier'),
    (6, 'fiche de lecture'),
    (7, 'jeu en ligne'),
    (8, 'vid??o');


INSERT INTO ressources(id, titre, description, categorie_id, relation_types_id, ressource_types_id, user_id)
VALUES (
        1, 
        'reconnaitre ses ??motions', 
        'L???objectif de cet exercice est de reconna??tre les ??motions sur soi. Pour ce faire, nous noterons dans un petit cahier pr??vu ?? cet effet, ?? des moments pr??d??finis de la journ??e, comment nous nous sentons ??motionnellement. Quelle ??motion nous habite ? Cette ??motion est-elle positive ou n??gative ? Avec quelle force ? Quel a ??t?? le facteur d??clencheur ? Nous r??p??terons la d??marche durant une semaine. Apr??s une semaine, reprenons nos notes et identifions avec un marqueur les ??motions que nous ressentons le plus souvent, si elles sont positives ou n??gatives et quel type de facteur d??clencheur est observ?? le plus souvent. Pour conclure, demandons-nous si nos ??motions auraient pu ??tre diff??rentes et si la situation en aurait ??t?? chang??e.', 
        13, 1, 5,1
    ),
    (
        2,
        'Emission ARTE : Travail | Travail, Salaire, Profit',
        'https://www.youtube.com/watch?v=Dpzv8H16R-Q',
        5, 4, 8,1
    ),
    (
        3,
        'Le rire au travail et l?????thique',
        'Introduction:
1Dans cet article, nous souhaitons apporter des ??l??ments de r??ponse ?? la question du rire
dans les situations professionnelles. Notre objectif est d???orienter les travaux de recherche portant plus globalement sur l?????thique au travail, mais aussi de fournir des rep??res pour le d??veloppement des pratiques de management. Si le rire comme expression ??motionnelle spontan??e de joie semble de prime abord ??chapper ?? toute tentative de management, c???est justement cette attribution commun??ment positive et, de plus, associ??e ?? une libert?? inali??nable du sujet qui ressort de notre ??tude comme contribuant en partie aux probl??mes qu???il soul??ve. En effet, le rire d??signe un comportement individuel ou collectif qui n?????merge et ne trouve son sens que dans un contexte d?????changes sociaux. Situ??e dans le champ de la gestion des ressources humaines, cette ??tude se limite aux situations professionnelles d???interactions directes entre des personnes au travail. La complexit?? de la probl??matique du rire s???en trouve r??duite puisque nous ??cartons les ph??nom??nes de foule, les tabous soci??taux, le rapport au sacr?? ou encore l???exercice des contre-pouvoirs dans nos d??mocraties modernes.
2Le point de d??part des travaux pr??sent??s est le constat dans le cadre d???une recherche plus large men??e par recherche-action sur le r??le du tiers avec la posture de coach, que plusieurs salari??s, demandeurs d???une aide ponctuelle pour r??soudre un probl??me ou sortir d???une situation qu???ils ressentaient comme insupportable, ??voquaient ???le rire???, celui des autres ou le leur propre, soit comme une source de mal-??tre, soit comme un mode de r??sistance ou de d??fense de soi. Nous nous sommes alors appuy??s sur sept cas s??lectionn??s car ils s???av??raient en rapport direct avec le sujet et l???analyse de contenu des 42 entretiens individuels ainsi r??alis??s pour proposer une grille d???intelligibilit?? du ph??nom??ne pla??ant le rire au travail au c??ur d???une probl??matique manag??riale d???ordre ??thique.
3Pour cela, nous avons dans un premier temps effectu?? une revue de litt??rature en l?????largissant ?? la philosophie morale, pour dans une seconde partie proc??der ?? l???analyse de nos mat??riaux recueillis empiriquement. Nous avions en effet ?? traiter du rire d???une part en ce qu???il ??merge au sein d???une situation professionnelle qu???il transforme, et de l?????thique abord??e comme un processus de questionnement de la morale (Ric??ur, 2010). Ces deux notions semblaient relever d???obligations s???imposant au sujet pour des raisons obscures et ???au-del????? de lui de par sa nature humaine ou d???un imp??ratif sup??rieur. La question centrale de notre ??tude est ainsi : le rire au travail est-il mal ? Et si oui, comment le r??guler ? D???embl??e, nous pouvons pr??ciser que le rire ne peut ??tre consid??r?? comme mal en soi et que par suite, notre

   questionnement doit trouver une formulation plus appropri??e. C???est d??j?? rentrer dans cette r??flexion ??thique ch??re aux philosophes et ?? laquelle ne peut ??chapper ni le chercheur en gestion soucieux d???apporter des r??ponses ?? la question du bon ou du mal-rire au travail, ni le manager incapable de savoir quand et comment le r??guler. Ainsi, les demandeurs d???aide de l?????tude, tous cadres d???entreprise et tous, pour des raisons diff??rentes, subissant concr??tement une situation, o?? deux obligations, celle du rire et celle de la morale, se trouvaient en opposition, faisaient appel ?? un tiers pour en sortir.
4Comment d??s lors identifier et traiter de ce qui rentre en tension pour les individus ou les collectifs et qui semble relever moins d???un jugement que du sentiment moral ? S???agit-il, pour reprendre une grille d???analyse tir??e de la psychologie sociale (Moscovici, 1984, p.9), d???un conflit dans le rapport ?? un objet, pour nous le travail, entre un sujet individuel en qu??te d???authenticit?? et d???affirmation, et un sujet social en qu??te de conformit?? et d???int??gration ? Le rire se situant dans le champ des expressions spontan??es d???un ressenti, peut-on solliciter la notion de ???dissonance ??motionnelle???, d??j?? d??velopp??e en appui sur les travaux de Leon Festinger (1957) dans le domaine du management (Van Hoorebeke, 2003) ? L???approfondissement dans cette voie au regard de notre probl??matique consid??rerait comme un double postulat initial que premi??rement, pour pr??venir les ??ventuelles divergences entre rire et morale, les sujets doivent au pr??alable acc??der ?? la connaissance de l???un comme de l???autre, et deuxi??mement, qu???ils arriveront par suite ?? un contr??le individuel et social des ph??nom??nes du rire. Ce serait supposer que les d??finitions pr??existent ?? la manifestation du rire, pos??es d??finitivement comme des v??rit??s pr??alables et confondre ?????thique??? avec discours normatif et pression de conformit??. Or, le propre du rire est qu???il ne s???explique pas : il arrive et surprend le rieur. Or, le propre du mal-rire est que s???il est d??sign?? comme une v??rit??, c???est dans une approche par la manifestation consistant ?? ?? laisser-??tre ce qui se montre ?? (Thomasset, 1996, p.253).
5Nous souhaitons emprunter ce chemin de questionnement et de r??flexion pour poser puis tenter de r??soudre la probl??matique de cette ??tude. Partant de ce mal-rire pr??sent dans les discours de plainte sur le travail, notre objectif est de nous tourner du c??t?? des pratiques de management au sein des organisations pour identifier en quoi elles en favorisent ou non l?????mergence. L???objet de notre ??tude d??limitant par ailleurs le champ de sa probl??matique est donc le v??cu d???un rire d??sign?? comme ???mal??? par au moins un des acteurs de la situation, soit dans l???instant, soit apr??s-coup. Nous avons ensuite questionn?? ce mal-rire d??sign?? au regard de la litt??rature et par la mise en ??vidence et la discussion de trois puis quatre indicateurs nous concluons sur les pratiques de r??gulation.
1 ??? Des bienfaits du rire au travail ?? la probl??matique de sa n??cessaire r??gulation
6Le questionnement sous-tendu par la tension entre rire et morale pourrait nous renvoyer ?? l???un des d??bats philosophiques toujours ouvert (Darwall, 1995), opposant notamment le comte de Shaftesbury (1715) [1][1]?? On peut objecter que ces affections, toutes d??natur??es..., qui dans la lign??e des sto??ciens, en appelait ?? un gouvernement de soi mais hors de toute loi externe, hors de toute sanction, par satisfaction de l???action bonne, ?? Emmanuel Kant pour qui l???autod??termination est un exercice de la volont?? individuelle pour appliquer la loi morale. Malgr?? tout, l???un comme l???autre se tournent vers le sujet avec implicitement l???injonction de ne pas ???mal-rire???. Sous cet angle, le management ne saurait ??tre concerne?, puisqu???il ne s???agirait que d???une moralit?? proche de la discipline personnelle et hors du champ des comp??tences


   professionnelles. Le probl??me est tout autre si l???on aborde la question de l???interdiction du rire consid??r?? comme un comportement professionnel inappropri?? ou producteur de mal-??tre au travail. Ainsi, l???interrogation, qui sous-tend cette ??tude est bien : ?? faut-il r??guler le rire au travail ? ?? avec pour corollaires : ?? comment sait-on qu???une r??gulation est n??cessaire ? ?? et
?? si c???est n??cessaire, comment proc??der ? ??. Pour r??pondre ?? ces questions, nous avons proc??d?? ?? une revue de litt??rature notamment dans le domaine de la philosophie morale.
1.1 ??? Le rire comme probl??me d???ordre
??thique entre droit naturel et contr??le
social
7Sans consid??rer avec Jacques Abadie (2003, p.267) que ?? les hommes pensent que leur rire est toujours innocent, et pourtant il est toujours criminel et condamnable ?? car il ??merge au d??triment d???un autre, la croyance oppos??e et socialement partag??e que ?? les rieurs sont toujours du bon c??t?? [2][2]Nous indiquons les ?? extraits de discours ?? entre guillemets en... ?? en devient une arme puissante de domination. Pour Robert Solomon (1998), les ??motions ne ?? font pas juste de nous arriver ??, et nous les utilisons pour affronter les autres. Sous cet angle, les personnes utilisent leurs ??motions pour agir en leur faveur en mettant en ??uvre ce qui peut ??tre d??sign?? comme une ???strat??gie du rire???. Si une conception d???un rire exclusivement ???sous contr??le??? est rapidement d??mentie empiriquement, ne serait-ce que par notre propre exp??rience, quand le rire ?????clate???, il est certes hors de la volont?? du sujet, mais il s???inscrit dans un contexte social et m??me dans une situation directement v??cue. Ainsi, le rire ressort comme la r??sultante d???une forme d???obligation, qui rejoint celle du sens moral de Francis Hutcheson (1993) dans la mesure o?? elle ?? n???est pas la contrainte d???une loi ext??rieure ; mais [o?? Hutcheson] n???a pas pour autant con??u cette obligation comme une obligation int??rieure ?? (Jaffro, 2000, p.45). ?? Rire nerveux ??, ?? fou-rire ??, les rieurs s???exclameront : ?? c???est plus fort que moi ! ??.
8Mais que faire ? Interdire de rire dans les organisations ? Bien ??videmment m??me la question est absurde pour trois raisons, dont deux au moins semblent ??videntes. D???une part, le rire est une expression ??motionnelle g??n??ralement spontan??e, ??chappant ?? la volont?? des personnes, voire ?? leur conscience. L???exiger [3][3]Le point soulign?? ressort comme encore plus ??vident si on... ou l???interdire par une loi ou une r??gle en ressort comme contraire ?? l?????thique dans la mesure o??, elle placerait les sujets dans une situation o?? il est impossible de bien se conduire, puisque quoi qu???ils fassent, aucun ??tre humain n???a la capacit?? de s???y conformer [4][4]Nous nous d??marquons ici des sto??ciens qui avec Cic??ron.... On retrouve la notion ???d???injonction paradoxale???, consistant ?? exiger un comportement ?? qui ne peut surgir que spontan??ment et non sur commande ?? (Watzlawick, 1980, p.106) et source de d??tresse chez les individus qui y sont soumis. Un autre courant th??orique traitant des ???obscurs ressorts??? du rire incontr??l?? en introduisant la notion ???d???inconscient??? nous permet de souligner l???aberration de l???interdiction du rire, celui de la psychanalyse freudienne. Consid??rant que
?? Le sur-moi-de-la-culture a produit ses id??aux et ??lev?? ses exigences ? Parmi ces derni??res, celles qui concernent les relations des hommes entre eux sont regroup??es en tant
qu?????thique ??, Sigmund Freud (1929, p.85-86) va s???interroger sur la possibilit?? ?? d?????carter le plus grand obstacle ?? la culture ?? qu???il ram??ne ?? deux pulsions humaines en conflit, celle de l???agression ou de l???auto-an??antissement et celle de la vie (Eros), tout en expliquant que leur refoulement ou leur n??gation ne peut que conduire ?? leur surgissement inconscient et socialement inappropri??, voir destructeur de soi ou d???autrui.

   9Si le propos de Freud repr??sente un mod??le du constat contre-intuitif d???un d??veloppement conjoint de la violence et de la culture, il conforte la pertinence de notre premier argument.
10Une deuxi??me raison est que le recours formel ?? la coercition soul??verait des objections morales bien plus importantes au point qu???on ne peut imaginer la stipulation dans un r??glement int??rieur ou le code du travail qu???il est formellement interdit de rire dans les situations professionnelles [5][5]Par contre, plusieurs cas de ?? fou-rire ?? ont ??t?? relev??s.... En effet, d???un c??t??, cela atteindrait la libert?? de critiquer, ce que le comte de Shaftesbury (1710, p.1) condamnait d??s le XVIIIe si??cle, tout en en questionnant les soubassements et les d??rives potentielles : ?? Mais qui sera le juge de ce que la censure peut examiner librement, ou de ce qu???elle doit souffrir impun??ment ? Qui d??cidera des circonstances o?? la libert?? peut agir sans scrupule, ou se taire ? ??. Resitu??e dans le contexte actuel d???une entreprise, cela d??poss??derait les salari??s de l???un de leurs modes d???expression fondamental, celui des ??motions, dont l???usage serait d??fini hors d???eux-m??mes. Cela reviendrait ?? une forme de d??shumanisation du personnel, dont il n???est plus n??cessaire aujourd???hui, de rappeler les multiples critiques non seulement d???ordre ??thique, mais aussi associ??es au constat qu???un tel mode de gouvernance r??ifiant les forces de travail est contre-productif et dessert les int??r??ts ??conomiques de l???organisation. D???un autre c??t??, la loi se tromperait l?? encore d???objet, car ou bien le rire est ???bon??? et l???interdire est injustifiable ou bien il est ???mal???, et n???est-ce pas d??s lors la dynamique m??me du mal-rire qui est ?? bannir ? Si l???on consid??re que les ressorts du rire sont mauvais, comme le soulignait en 1720 Gottfried Wilhelm Leibniz (1720, p.3) dans ce qu???il pr??sentait comme une r??ponse ?? Shaftesbury et qui ici nous semble se situer dans une logique compl??mentaire : ?? Je ne vois pas aussi que le ris, c???est-??-dire quelque chose qui tient du m??pris et abaisse l???id??e de l???objet, soit une pierre de touche qui serve ?? reconna??tre la v??rit??. M??priser ce qu???on ne conna??t pas encore est une pr??vention dont il faut se d??faire ??. Sous cet angle, et en poussant le raisonnement, la crainte du rire serait une peur des puissants que celui-ci ne puisse r??v??ler une v??rit?? : au final, la censure serait l???indicateur de mensonges que les personnes ries chercheraient ?? prot??ger. Sans rentrer dans le d??bat, Shaftesbury comme Leibniz, nous ram??ne ?? la m??me interrogation : si une interdiction ou des sanctions sont ?? poser par une r??gle ou une loi, ne doivent-elles pas porter sur ce qui conduit ?? un mal-rire ? 11La troisi??me raison de l???inimaginable interdiction du rire est reli??e aux deux autres mais tout en rappelant l???existence des vertus du ???bon rire??? qui permet de supporter sa condition humaine et les ??preuves de la vie, voire de pr??server sa dignit??. Malgr?? tout, la probl??matique du rire au travail va bien au-del?? d???un tri entre le bon et le mauvais rire. Nous pouvons retrouver ?? la fois la figure mal??fique du pervers qui rit du malheur d???autrui, le surgissement d???une ??motion ??chappant au contr??le du sujet, et qui par contrecoup le dessert ou que lui- m??me trouve inappropri??, et en dernier une situation ou? le rire est la seule issue permettant ?? la personne d???exister dans un contexte d???ali??nation. Le rire se manifeste mais rien n???est ???risible??? en soi. Cette expression ??motionnelle sp??cifique ne donne que peu d???informations sur son objet ou sur ce que nous pourrions tenter de cerner en d??finissant la cat??gorie du ???risible???. Par contre il d??signe un contexte ou renseigne sur la nature du rieur, et soit dans l???un, soit dans le second, ou encore dans les deux, quelque chose de mauvais se joue, qu???il r??v??le. Au final, aucuns des rieurs concern??s - harceleurs, manipul??e ou exclu - ne se trouvent du bon c??t??. Il en ressort que la question pos??e n???est pas celle du ???comique???, celui-ci d???ailleurs ne suscitant pas forc??ment un ??clat de rire, mais celle de la dynamique du rire au travail, qui semble associ??e ?? trois notions principales elles-m??mes inter-reli??es [6][6]Cette interrelation entre pouvoir, v??rit?? et existence se..., celles du ???pouvoir???, de ???la v??rit?????, et de ???l???existence???, avec une fonction restant ?? identifier et ?? questionner de r??gulateur et/ou d???indicateur.

   1.2 ??? Le rire au travail, un r??gulateur ??thique ?
12Abord?? comme r??gulateur, le rire peut tout d???abord ??tre consid??r?? comme une pratique sociale pr??supposant un d??clencheur du rire et au moins un rieur. Il s???agit a minima d???une interaction entre un sujet et son environnement social. Si le d??bat semble ouvert entre les philosophes sur la possibilit?? de rire de soi, de rire seul ou si un tiers est n??cessaire [7][7]Pour Freud S. (1905, p. 262-263), ?? Nul ne peut se satisfaire..., nous n???aborderons cette question qu???indirectement en nous focalisant sur les th??ories nous permettant d?????clairer l?????ventuelle fonction d???indicateur ou de r??gulateur ??thique du rire en situations professionnelles. Dans les organisations, comme le soulignait Ignasi Marti en 2009 (p.128) : ?? La vision traditionnelle de la r??sistance est une vision connot??e d???opposition, voire d???agressivit?? ??. Si l???apport des formes d???action sans violence est soulign?? par l???auteur, tout comme l???impact de la d??stabilisation, le recours ?? l???humour ou ?? l???ironie n???est pas ??voqu??.
13Par ailleurs, plusieurs travaux en sciences de gestion abordent le management en soulignant le r??le d???une notion, ???l???intelligence ??motionnelle???, pour l???efficacit?? des leaders et leur capacit?? ?? influencer les individus et les groupes pour atteindre leurs objectifs (Kotz?? et Venter, 2011). Le rire peut en ressortir comme une aptitude ?? ext??rioriser des ??motions
?? positives ?? permettant de mieux faire face au stress et d???entretenir une vision optimiste de l???avenir favorable ?? la r??alisation mais aussi ?? la mobilisation au travail. Le processus est souvent identifi?? comme relevant de ce qui est d??sign?? comme un processus de
?? contagion ??motionnelle ?? (Barsade, 2002) favorisant, lorsque les ??motions sont ???positives???, la coop??ration et la performance individuelle et collective. Le rire est presque syst??matiquement ramen?? ?? une expression de joie, cette derni??re ??tant cat??goris??e dans le groupe de ces ??motions ???positives???. Notre approche est bien diff??rente dans la mesure o?? d???une part m??me si cette attribution est commun??ment admise depuis Darwin [8][8]Darwin C.R. (1872) reste toutefois prudent, puisqu???il consid??re..., nous nous limiterons ?? consid??rer prudemment que le rire correspond ?? l???ext??riorisation d???une d??charge ??motionnelle et que d???autre part, tout en restant toutefois ???binaire??? puisque nous opposons le ???bien??? et le ???mal???, le qualificatif de ???positif??? nous semble inappropri?? pour le ???mal-rire???. Cette affirmation trouve un ??tayage empirique dans l???un des cas de coaching ayant initi?? la r??flexion pr??sent??e dans cet article. En dehors de plusieurs situations o?? les coach??s interpr??taient mal la nature de leurs ??motions par conformit?? sociale et en ??prouvaient un mal-??tre ?? l???origine de leur demande, notamment du fait du caract??re ???sexu????? des ??motions (Braconnier, 2000), Or de nombreux travaux ont montr?? que le processus de changement dans les situations de travail pr??sente de fortes similitudes avec celui du deuil (Kets de Vries et Miller, 1985), dont la psychiatre Elisabeth Kubler-Ross (1989) a conceptualis?? les ??tapes : allant du d??ni de la r??alit?? qui heurte le sujet, ?? l???acceptation, en passant par la r??volte et le marchandage. Au niveau affectif, les personnes doivent ?? s???arracher pour se d??tacher ?? de leur ??tat ant??rieur, ce qui s???accompagne de diff??rents ressentis ??motionnels, dont les deux principaux sont la col??re puis la peine, deux ??motions d??sign??es comme ???n??gatives???. Il en ressort que ce n???est pas le rire ou l???expression d?????motions positives qui repr??sente en soi un mode de r??gulation mais la r??gulation des ??motions ressenties en autorisant et canalisant leur expression d???une fa??on socialement acceptable. Ainsi, dans la lign??e des ??tudes d??j?? men??es, d??finissant comme comp??tence du leader, celle de ?? r??gulateur des ??tats ??motionnels ?? de son ??quipe (Haag et Laroche, 2009), plus que d???orienter le groupe vers un type d?????motions, ne peut-on pas faire la proposition qu???il s???agirait plut??t de lui permettre une expression moralement acceptable d???un ressenti par nature ??chappant au contr??le ? Ce cas confirme ??galement d???autres r??sultats de

   recherche soulignant l???importance pour les d??cideurs d?????couter leurs ??motions pour bien orienter leur jugement (Coger, Haag et Bonnefous, 2009).
1.3 ??? Quels indicateurs du mal-rire au travail ?
14Notre analyse nous conduit ??galement ?? questionner le caract??re moralement acceptable de la moquerie, en ce qu???elle d??finit un rire dont l???objet est autrui, et par suite ?? nous interroger sur les indicateurs du mal-rire. En effet, lorsqu???elle se tourne vers autrui, qui d???objet du rire se retrouve plac??e en position de victime, la moquerie est aujourd???hui consid??r??e comme ill??gitime et condamnable depuis la loi de 2002 contre le harc??lement moral au travail [9][9]Loi n?? 2002-73 du 17 janvier 2002 de modernisation sociale,.... Dans ces situations, le ???mal-rire??? est ??vident, tout autant que la violence subie, tant depuis Nietzsche, l???on sait que : ?? Ce n???est pas par la col??re, c???est par le rire que l???on tue ?? (Kessler, 2005, p.507). Par contre, dans d???autres contextes une ???gentille moquerie??? peut ?? d??tendre l???atmosph??re ?? et susciter le rire de l???int??ress??(e), se consid??rant lui-m??me/elle-m??me comme ???taquin??(e) avec bienveillance???. Ainsi, ce n???est pas la moquerie qui en ressort comme l???indicateur syst??matique du ???mal-rire???, mais la volont?? de son ???bon usage???. Emmanuel Jaffelin (2010, p.106) propose ainsi entre autres d??finitions de la gentillesse, celle de
?? l???expression de notre bon vouloir, qui est aussi vouloir du bien ??. Nous retrouvons ici le ???bon usage des passions??? de Ren?? Descartes (1649, p.227 ?? 230) qui s???op??re non par domination de la raison mais par la volont?? ?? r??solue ?? d???un sujet ?? averti de l???emportement ?? que peut ??tre une passion, et du ?? rempart que constitue sa fermet?? ? d?????me ou sa
r??solution ??, la g??n??rosit?? se d??finissant pour Descartes par l???estime de soi-m??me, consid??r??e comme une vertu, et non par l???altruisme ou l???oubli de soi. Malgr?? tout, et sans rentrer dans les ressorts de ce bon usage des passions, il nous semblerait hasardeux de tenter de diff??rencier les ???m??chantes??? des ???gentilles??? moqueries en prenant comme crit??re la volont?? du moqueur de blesser le moqu?? ou son incomp??tence ?? exercer son ?? libre arbitre avec justesse ??. En dehors de la difficult?? ?? ???mesurer??? l???intention de sujets qui dans bien des cas n???en ont pas une conscience claire, l???effet destructeur est tout aussi puissant quand les harceleurs s???exclament
?? mais c???est pas m??chant ! ?? que lorsqu???ils avouent leur d??sir de faire souffrir. Ce serait plut??t trois autres notions qui feraient la diff??rence et qui d??finissent nos propositions de recherche sur les indicateurs du mal-rire au travail et dont nous avons ??tay?? le bien-fond?? empiriquement dans une deuxi??me partie : la ???r??ciprocit?????, ???l???unanimit?????, et la ???persistance???. 15Il semble que la ???r??ciprocit????? ait deux dimensions. En effet, elle vise ?? indiquer que les rieurs sont ?? la fois moqueurs et moqu??s mais aussi que la situation est elle-m??me un d??clencheur du rire. Nous entendons par le deuxi??me indicateur, ???l???unanimit?????, non pas que la moquerie fasse rire ???tout le monde???, mais que le rire soit partag?? par les trois groupes de protagonistes directement concern??s : moqueur, moqu?? mais aussi t??moin. Pour ce dernier, plusieurs travaux soulignent que les spectateurs peuvent ??tre afflig??s par l???exp??rience subie d???un ???mal-rire??? et en ??prouver un malaise profond (Houba, 2007). ?? ce stade, il nous semble que deux conceptions oppos??es du rire et de son rapport ?? la r??gulation sociale peuvent ??tre relev??es. Pour l???une, ?? Le rire est une exp??rience subversive [...] Le rire est une arme de lib??ration massive contre les oppresseurs, un outil pour r??sister aux forces
d???an??antissement ?? (Birnbaum, 2011, p.9), quand pour l???autre, le rire va ??tre consid??r?? avec Henri Bergson (1940) comme une ?? sanction sociale symbolique ?? permettant ?? la soci??t?? d???exercer un contr??le et de se pr??munir des sujets la mena??ant. Si dans les deux cas, l???intelligence ou la clairvoyance est postul??e du c??t?? des rieurs et des moqueurs, pour le premier, elle s???inscrit dans une dynamique de refus de se soumettre ?? ce qui domine, alors que

   dans le second, elle exerce une pression de conformit?? sociale. Replac??e dans le monde du travail, chacune des approches peut trouver des objections remettant en question leur bien- fond?? et leur possible orientation des pratiques. En effet, de nombreux cas, comme par exemple ceux portant sur la discrimination au travail, mettent en ??vidence que r??sister peut aussi consister ?? ne pas rire d???un bouc-??missaire au milieu d???un groupe hilare, ou affirmer son opposition ?? la ridiculisation de l???autre. Par ailleurs, le ph??nom??ne conduisant les collectifs ?? une euphorie groupale associ??e ?? un sentiment de surpuissance illusoire et une perte du sens des r??alit??s, a ??t?? largement ??tudi?? [10][10]Le premier ?? avoir affirme? que ?? l???individu en foule diff??re.... Non seulement les r??sultats sur les ??quipes professionnelles contredisent le postulat de clairvoyance des rieurs, mais ils conduisent au constat que les groupes alors d??sign??s comme fusionnels (Anzieu et Martin, 1982) finissent toujours par ??clater : ce type de rire ne pr??serve la coh??sion sociale que de fa??on pr??caire et artificielle. Le mouvement de retour ?? la r??alit?? est aussi une prise de conscience individuelle que le collectif peut conduire ?? adopter un comportement que chaque membre condamne apr??s-coup et consid??re comme irresponsable. Ainsi, d??signer un autre comme une victime expiatoire ou un objet l??gitime de moqueries est une ignorance de sa valeur d???homme et place dans une posture illusoire de sup??riorit??. Nous avons d???ailleurs relev?? que Bergson (1932, p.90) affirme dans un ouvrage ant??rieur que ?? si s??v??rement que nous affections de juger les autres hommes, nous les croyons, au fond, meilleurs que nous. Sur cette heureuse illusion repose une bonne partie de la vie sociale ??. Nous retrouvons ici une d??finition du troisi??me indicateur propos?? : la ???persistance???. Il r??pond ?? la question : le rieur consid??re-t-il apr??s-coup qu???il a ???mal-ri??? ? La r??gulation en ressort ??galement comme un processus inachevable, toujours en cours et ?? mener.
2 ??? Etayage empirique de l???existence du mal-rire au travail et de ses indicateurs
16Dans cette partie, apr??s avoir explicit?? la m??thodologie de la recherche, nous pr??sentons les r??sultats de sept ??tudes de cas d???accompagnement de responsables confront??s ?? des difficult??s de management et demandeurs d???aide aupr??s d???un tiers compl??t??s par l???analyse de contenu des entretiens individuels men??s, enregistr??s et retranscrits dans le cadre de cette recherche- action. Celle-ci s???inscrivait dans un projet visant plus globalement ?? explorer le r??le du tiers dans le changement des comportements professionnels et la r??solution des probl??mes de management. L?????tude pr??sent??e dans cet article a pour objectif de conforter l???existence de situations de rire producteur de mal-??tre et d?????tayer nos propositions de recherche sur les indicateurs de ce mal-rire au travail afin d???orienter les pratiques de r??gulation.
2.1 ??? M??thodologie de l?????tude : quand le rire conduit ?? une demande d???aide
17D???un point de vue ??pist??mologique, nous nous situons dans un paradigme interpr??tativiste. En effet, si notre recherche est de type exploratoire, il ne s???agit pas de faire abstraction des cadres th??oriques existants mais d???identifier les th??ories pertinentes, de s???y appuyer pour les confronter et investiguer la r??alit??, avec l???adoption d???une posture r??flexive avec le terrain (Jodelet, 2003), dans un ???va-et-vient??? entre observations empiriques et hypoth??ses interpr??tatives permettant ???d???ancrer??? une th??orie en cours d?????laboration (Glaser et Strauss, 1967). La m??thode de cas nous est apparue comme la plus pertinente pour ??tudier les

   situations du rire dans les situations de travail. Selon Miles et Huberman (1991), elle permet de d??velopper les conceptualisations ?? partir de descriptions approfondies des ph??nom??nes. Il s???agit d???appr??hender l???impact d???un comportement humain dans une complexit??, dont nous souhaitons saisir toutes les dimensions, ce que l?????tude de cas favorise (Giroux et Tremblay, 2002). Enfin, le caract??re ??thique ou non est une pr??occupation organisationnelle contemporaine, et l?????tude de cas, comme le souligne Yin (1994), est par d??finition une d??marche de recherche qui traite des ph??nom??nes en prise directe avec les contextes dans lesquels ils ??mergent. La m??thode utilis??e est celle de la recherche-action (Koenig, 1993) avec comme objectif en coh??rence avec notre posture interpr??tativiste de nous appuyer sur un cadre th??orique issu de la litt??rature afin de faire ??merger une grille d???intelligibilit?? du mal-rire au travail, tout en co-??laborant avec les acteurs (les coach??s) des construits op??ratoires.
18L?????tude a ??t?? men??e de 2006 ?? 2008. Elle a consist?? ?? accompagner individuellement des demandeurs d???aide dans une s??rie de dix entretiens au maximum d???environ 60 minutes chacun et enregistr??s avec l???accord des int??ress??s. Seul un cas s???est concr??tis?? par dix entretiens. Pour les six autres cas, le coach?? a consid??r?? qu???il n???avait plus besoin d???accompagnement avant la fin des dix s??ances qui lui ??taient ouvertes car son probl??me ??tait r??solu et qu???il pouvait faire face sans aide ?? ses situations professionnelles aussi difficiles soient-elles. Renforcer l???autonomie du coach?? et la confiance en ses propres ressources est l???une des caract??ristiques majeures de la d??marche d???accompagnement servant d???appui ?? la recherche-action. Les sept cas de l?????tude pr??sent??e sont extraits d???un corpus de 34 cas et a abouti ?? l???analyse de 42 entretiens. Sans que leur demande d???accompagnement concerne initialement directement le rire, les coach??s ont ??t?? choisis car ils avaient ??voqu?? la question du rire en termes ??thiques et cela a ??merg?? de l?????change comme d??finissant en totalit?? ou en partie ce qui leur posait probl??me. La population de l?????tude est compos??e de quatre femmes et de trois hommes, de 26 ?? 54 ans et occupant des postes de responsable dans diff??rents secteurs d???activit??s avec le statut de cadre.
Tableau 1
Les sept cas de l?????tude
19En plus de l???analyse de cas proprement dite effectu??e en confrontant nos notes prises avec la posture de chercheur-coach et l?????volution du discours des coach??s au fil des s??ances, nous avons proc??d?? ?? une analyse de contenu des entretiens par strates de relecture manuelle et

   r??partition des extraits de discours dans les cat??gories issues d???une part de la revue de la litt??rature (1??re phase avec deux s??ries de relecture) puis d???autre part de l???analyse de contenu proprement dite (2e phase avec trois strates de relecture : approfondissement des contenus class??s avec ??mergence de nouvelles dimensions ; ??mergence d???un 4e indicateur du mal-rire ; rep??rage des contenus d?????tayage et de d??finition du 4e indicateur). La 1??re phase d???analyse s???est appuy??e sur les crit??res classant des discours tir??s de la revue de la litt??rature : mal-??tre du sujet ri, mal-??tre du sujet rieur et les trois indicateurs du mal-rire. Son apport a ??t?? d???approfondir le cadre th??orique initial, que la 2e phase a permis de compl??ter essentiellement par le rep??rage d???une 4e caract??ristique.
2.2 ??? R??sultats : Le bon et le mauvais rire coexistent au travail
20La situation des quatre premiers cas permet d???illustrer les diff??rentes dynamiques du rire au travail et leur rapport ?? l?????thique. Les trois cas suivants nous ont permis de conforter nos propositions de recherche sur les trois indicateurs du mal rire. Nous les avons ??tay??es par une analyse de contenu des 42 entretiens retranscrits des sept cas de l?????tude.
2.2.1 ??? Les dynamiques du rire et leur rapport ?? l?????thique
21Pour confirmer l???existence du mal-rire au travail et en proposer une grille d???intelligibilit??, nous pourrions citer la d??claration de cette femme cadre de 48 ans en cong?? maladie pour d??pression du cas n??1, qui confiait : ?? Au d??but, je suis rest??e de marbre mais ?? force ??a atteint. Stupidement ce sont les blagues sur mon poids qui m???ont us??e. C?????tait juste... m??chant ? ??. Nos r??sultats font ressortir que le mal-??tre g??n??r?? par le v??cu du rire peut ??tre ressenti non seulement par le sujet-ri que par le sujet-rieur. Ainsi dans le cas n??2, une femme de 27 ans nouvellement embauch??e dans un service marketing, se ?? sentait mal ?? de se retrouver ?? rire dans un groupe ayant pris l???habitude avant son arriv??e de ?? taquiner ?? un stagiaire handicap?? qui pr??sentait de ?? l??g??res difficult??s d?????locution ??. L???int??r??t du poste et ?? la chance d???avoir d??croch?? un job... formateur,... le salaire,... bien quoi ! ?? ne l???ont pas emp??ch?? de changer d???emploi au plus vite. Cela confirme que le ???c??t?? des rieurs??? est loin d?????tre d??sign?? syst??matiquement comme ???le bon??? m??me par l???inconfort qu???il procure. Une interrogation d???ordre ??thique est bien pos??e sur le rire au travail, non comme un jeu abstrait visant principalement ?? distraire les philosophes, mais comme un facteur de souffrance en situation professionnelle ?? aborder comme tel pour mettre en ??uvre les politiques de pr??vention appel??es de leurs v??ux par les responsables d???entreprises et les syndicats. Nos r??sultats ont ??galement fait ressortir les bienfaits potentiels du rire. Ainsi dans le cas n??3, un responsable de production de 54 ans qui nous avait sollicit?? pour la ?? red??finition de [son] projet professionnel ?? s???est exclam?? lors du premier entretien : ?? Si y???a une chose qu???on ne peut pas m???emp??cher, c???est de me marrer... c???est la seule chose... quand l???autre avec sa cravate m???a dit que c?????tait mon tour... ??ject??... vous rigolez !... la veille j???ai fini ??... je sais pas... neuf heures... et le matin j?????tais l?? pour leur r??union et ensuite... l???un apr??s l???autre... dans son bureau... allez : j?????tais dans le lot... dehors !... j???ai rien dit... je l???ai regard?? en me marrant... pas question de s?????crouler... et moi ??a va... ??.

   22Dans ces trois premiers cas nous retrouvons ?? la fois la figure mal??fique du pervers qui rit du malheur d???autrui, le surgissement d???une ??motion ??chappant au contr??le du sujet, et qui par contrecoup le dessert ou que lui-m??me trouve inappropri??, et en dernier une situation o?? le rire est la seule issue permettant ?? la personne d???exister dans un contexte d???ali??nation. Le rire se manifeste mais rien n???est ?? risible ?? en soi. Le cas n??4 d???un manager de 38 ans, responsable d???une ??quipe charg??e d???un projet dans le domaine de la haute technologie, que la direction lui avait demand?? d???abandonner en pleine r??alisation pour se consacrer ?? un autre, nous permet de pr??ciser cette dynamique du rire et ses limites. Convaincu que son r??le ??tait de ?? maintenir le moral des troupes ??, il mettait son ?? point d???honneur ?? faire bonne figure ??, ce qui se traduisait par ce qu???il d??signait comme sa ?? nature ?? blaguer tout le temps ??. Or, ni lui, ni son groupe - ?? pourtant, on est des pros ! ?? - n???arrivaient ?? s???investir sur le nouveau dossier et continuaient ?? ??voquer le pr??c??dent. Au cours du deuxi??me entretien, le manager a exprim?? ce qu???il a d??fini ensuite comme sa ???col??re rentr??e???. Il en est arriv?? ?? la conclusion que ses coll??gues devaient aussi ?? l??cher leur venin ?? pour pouvoir ?? se remettre au travail ??. Ce qu???il fit, d??clarant ?? la troisi??me et derni??re s??ance : ?? Je leur ai dit : je sais pas vous mais moi je suis furieux ; alors je vous propose d???en parler mais interdiction d???injurier ou de crier et chacun son tour et uniquement si vous avez envie... et alors, c???est parti !... je crois que c???est r??gl??... ils m???ont m??me dit : tu nous saoulais, parce qu???on voyait bien que c?????tait faux, ??a grin??ait ! ??.
23L???analyse du contenu des 42 entretiens a permis de conforter cette notion de mal-rire inter- reli??e ?? celles d???un double mal-??tre en miroir : le mal-??tre du sujet ri et le mal-??tre du sujet- rieur (voir tableau 2).
Tableau 2
Le mal-rire comme g??n??rateur de mal-??tre

   2.2.2 ??? Les indicateurs du mal-rire
24Nous avons pu s??lectionner trois cas permettant de conforter et pr??ciser les trois indicateurs du mal-rire issus de la revue de litt??rature, tout en confirmant la pertinence de la transposition d???un cadre th??orique issu d???une revue de la litt??rature essentiellement philosophique. Concernant la ???r??ciprocit?????, nous retrouvons cette notion lorsque les sujets abordent la comp??tition dans les relations professionnelles. Celle-ci comme pour les ??quipes de commerciaux par exemple, peut ??tre stimulante et prendre la d??finition donn??e dans le sport. Nous avons relev?? dans les propos de l???une d???entre elles repr??sentant notre cas n??5, cadre de 47 ans, responsable d???une ??quipe de vente, qu???elle pouvait s???accompagner d?????changes verbaux utilisant une moquerie qu???elle qualifiait de ?? bonne guerre ??. Notre coach??e nous les indiquait pour expliciter son temp??rament de ?? gagnante ??, ses comp??tences assertives et sa pugnacit??. Il en ressortait que si les moqueries ??taient interpr??t??es comme un ??change confraternel et respectueux, c???est qu???elle en ?? recevait tout autant ; ??a me booste ! ??. C???est d???ailleurs ce qui nous semble pouvoir r??guler les formes autodestructrices d???autod??rision, comme pour le cas n??6 un malade du sida de 46 ans qui a arr??t?? de s???exclamer en riant lorsque des ??ch??anciers ??taient en cours d?????laboration : ?? vous me raconterez, si je suis au
cimeti??re ! ??. La notion ???d???unanimit????? renvoie par suite ?? une n??cessaire forme individuelle d???autor??gulation du rire dans une m??me volont?? de respect mutuel de soi et des autres. Enfin, dans le cas n??7, une femme de 26 ans, chef de travaux dans le b??timent souhaitait ?? changer de secteur d???activit?? ?? car nous disait-elle dans le cadre de son coaching : ?? j???en peux plus de leur douce rigolade vulgaire d???obs??d??s par leur p??nis ??. Apr??s plusieurs s??ances, et consid??rant qu???elle n???avait ?? rien ?? perdre d???essayer ??, elle a d??cid?? de ?? leur dire ?? et s???y est pr??par??e. Elle fut surprise de constater que plusieurs de ses coll??gues masculins ??galement pris ?? t??moins des plaisanteries, appuyaient sa demande. Les rieurs furent pri??s de r??server l???usage de leur humour ?? une sph??re non professionnelle d???amis susceptibles de l???appr??cier.
25L???analyse de contenu de nos 42 entretiens, nous a permis non seulement de retrouver dans les situations de travail les trois indicateurs au fil des discours des sujets de l?????tude, mais d???en identifier un quatri??me que nous avons d??sign?? par les termes de ???plein accord pr??alable???. En effet, nous avons relev?? la distinction faite entre le rire subi ou m??me consenti et le rire approuve?. Si les deux peuvent conduire le sujet-ri ?? ?? rire avec les rieurs ?? pour ??viter de perdre la face, seul le second semble ??tre une ?? sortie sans casse ?? pour la personne. Ainsi pour Goffman (1974, p.39), ?? on peut [donc] consid??rer une relation sociale comme ??tant une situation o?? une personne est particuli??rement forc??e de compter sur le tact et la probit?? d???autrui pour sauver la face et l???image qu???elle a d???elle-m??me ??. Nous avons retrouv?? cette situation d??crite par les sujets dans leurs entretiens, comme par exemple comme discours type : ?? j???ai bien vu qu???il se retenait de rire... faut dire que quand je bafouille, j???y vais pas ?? moiti??... alors j???ai dit : ma chompre a trouch??... et j???ai ??clat?? de rire... c?????tait marrant... on a bien ri et ??a fait du bien ??. On retrouve ici le rire, source de bien-??tre et permettant de d??velopper sa capacit?? de faire face aux situations critiques du monde professionnel (Mittal et Mathur, 2011). Par contre, ?? rire jaune ?? tout en sortant meurtri de la situation d?????changes est revenu dans les entretiens comme l???indicateur que ?? le rire n?????tait pas de bonne qualit?? ??. Ne pas rire est consid??r?? comme une fa??on ?? d???empirer la situation ??, les protestations pouvant ??tre encore plus risibles. Un discours type pourrait ??tre ?? le plus douloureux est que je n???ai rien pu faire d???autres que faire semblant de trouver ??a dr??le ?? ou ?? c?????tait outrageant, il se moquait de mon apparence ; le seul qui peut le faire c???est moi... c???est comme les blagues juives... c???est antis??mite hein quand seuls les juifs ne rient pas ??.

   2.3 ??? Discussion : vers la r??gulation du mal- rire au travail
26Rep??rer en se r??f??rant aux indicateurs qu???il s???agit d???un mal-rire au travail ne suffit pas ?? d??finir les modes de r??gulation. En effet, il ne faudrait pas en d??duire qu???il s???agit de d??finir les normes g??n??rales du ???bon comique??? au travail, mais plut??t que la n??cessit?? s???impose d???en souligner les dysfonctionnements. Nous avons ainsi montr?? que le poids du contexte sur l?????valuation de la situation, comme Hackney (2011) qui a d??montr?? que certaines pratiques de management pouvaient conduire ?? faire perdre le sens de l???humour des salari??s m??me lorsque les plaisanteries ont ??t?? pr??-test??es comme dr??les. Ce qui fait rire est non seulement culturellement ancr?? mais fait le ciment des groupes sociaux. Il est une arme de st??r??otypage et de discrimination tout autant qu???un puissant levier d?????mancipation, comme en t??moignent les travaux sur le rire des femmes (Willett et al., 2012). Gkorezis, Hatzithomas et Petridou (2011) soulignent ainsi que si l???utilisation de l???humour par les dirigeants est un levier puissant de mobilisation, son recours peut avoir des effets n??gatifs en fonction notamment de l???anciennet?? des salari??s. D???une part, le r??le de l???humour comme activateur de cr??ativit?? ou de r??solution de probl??me a ??t?? mis en ??vidence, voire m??me pour assouplir les rigidit??s organisationnelles propres aux administrations publiques (Cates, 1979). D???autre part, plusieurs travaux ont soulign?? que les ??motions positives comme l???euphorie pouvaient conduire ?? une prise de risque plus importante et inconsid??r??e notamment dans les d??cisions financi??res (Cavalheiro et al., 2011).
27Nos quatre indicateurs, ???r??ciprocit?????, ???unanimit?????, ???persistance??? et ???plein accord pr??alable??? peuvent ??galement ressortir comme des r??gles de comportement collectif ?? poser pour permettre aux salari??s de les int??rioriser ??motionnellement. Il s???agit ainsi moins de r??gles de politesse formelle que de l???apprentissage d???une forme de ???civilit?? au travail???, en r??f??rence ?? la d??finition de l???incivilit?? par les philosophes et de leur ??tude de la recrudescence du ph??nom??ne dans nos civilisations (Habib et Raynaud, 2012 ; Bourin, 2012). Face au mal-??tre ressenti par les ???mal-rieurs??? et de l???effet destructeur sur la personne ???rie???, il s???agirait pour les managers en lien avec les travaux initi??s par Sen (2004) au niveau socio-??conomique de cr??er les conditions d???une ???vie au travail humainement digne??? et une gestion des ressources humaines qui int??gre ce que Nussbaum (2012) d??signe comme des ???culpabilit??s??? et parmi lesquelles se positionnent le ressenti ??motionnel et la conception du bien.
Conclusion
28Cette recherche men??e en appui sur sept cas de coaching avec 42 entretiens individuels, nous a conduits ?? d??finir quatre indicateurs du rire au travail : la ???r??ciprocit?????, ???l???unanimit?????, ???la persistance??? et le ???plein accord pr??alable??? permettant d???orienter les pratiques de r??gulation. Dans ce qu???ils pr??supposent comme dynamique ?? l?????uvre, les notions qu???ils d??signent sont aussi ce qui permet de ne pas limiter le rire ?? la moquerie. Il nous semble m??me que le rire prend toute sa port??e ?? d???intervention cr??atrice de la conscience ?? soulign??e par Robert Escarpit (1960, p.94), et peut devenir une v??ritable force de progr??s potentielle dans les organisations si le comique renonce ?? ridiculiser les personnes pour se positionner dans le champ de la d??nonciation de et par l???absurde des syst??mes ou des politiques. Hors de la moquerie, le rire est aussi un mode de faire face ?? la d??tresse de vivre et peut ??tre reli?? ?? un comique qui ?? manifeste la fragilit?? essentielle du sens humain, mais nous donne les moyens de l???exorciser ?? (Giribone, 2009, p. 58). Le rire des autres est d??s lors potentiellement un

   encouragement ?? se distancier et m??me ?? transcender notre condition d???homme et la finitude de la vie. En cela, il est un vecteur de r??flexivit?? et m??me de bien-??tre, non dans une recherche exclusive de plaisir h??doniste, qui ne r??siste pas au questionnement d???ordre ??thique, mais dans une qu??te existentielle telle que Martin Heidegger (1927) l???a th??oris??e.
29Cette premi??re ??tude sur le rire au travail et l?????thique d??bouche enfin sur plusieurs pistes de recherche et, nous semble-t-il, plus particuli??rement sur un recensement des diff??rentes situations professionnelles d?????mergence du rire afin de valider quantitativement nos r??sultats affirmant que c???est seulement lorsque le rire est r??ciproque, unanime, qu???il perdure et qu???il a ??merg?? dans un plein accord pr??alable des parties, qu???il s???inscrit dans une dynamique positive pour les personnes comme pour les organisations.
Notes
??? [1] ?? On peut objecter que ces affections, toutes d??natur??es qu???elles sont, ne vont point sans plaisir ; & qu???un plaisir quelque inhumain qu???il soit, est toujours un plaisir, f??t-il place? dans la vengeance, dans la malignit?? & dans l???exercice m??me de la tyrannie. Cette difficult?? serait sans r??ponse, si, comme dans les joies cruelles & barbares, on ne pouvait arriver au plaisir qu???en passant par le tourment ; mais aimer les hommes, les traiter avec humanit??, exercer la complaisance, la douceur, la bienveillance, & les autres affections sociales ; c???est jouir d???une satisfaction imm??diate ?? l???action & qui n???est pay??e d???aucune peine ant??rieure ; satisfaction originelle & pure, qui n???est pr??venue d???aucune amertume. Au contraire, l???animosit??, la haine, la malignit??, sont des tourments r??els dont la suspension occasionn??e par l???accomplissement du d??sir, est compt??e pour un plaisir. ?? Cooper A.A., comte de Shaftesbury (1715, p.248-249)
??? [2] Nous indiquons les ?? extraits de discours ?? entre guillemets en les distinguant
des ?? citations ?? mises quant ?? elles en italique. Nous utilisons un autre caract??re pour les ???notions??? que nous questionnons. Ici il s???agit d???une affirmation prononc??e commun??ment comme un dicton.
??? [3] Le point soulign?? ressort comme encore plus ??vident si on questionne la mesure consistant ?? imposer aux salari??s de rire. Si l???on associe rire et joie, on pourrait y retrouver la d??nonciation d???une pression exerc??e actuellement de fa??on implicite dans certaines organisations et revenant ?? exiger que les salari??s expriment leur bonheur de travailler - Cf. en sciences de gestion : Gori R., Le Coz P. (2006) ; en philosophie : Manzano M. (2008).
??? [4] Nous nous d??marquons ici des sto??ciens qui avec Cic??ron consid??raient que la
?? joie folle ?? est une ?? maladie de l?????me ?? au m??me titre que toutes les passions qui ??loigne l???homme de ?? la conscience du sage ?? : Cic??ron (45 av. J.C.), Tusculanes, III, IV-V, in Br??hier E. (1997), pour consid??rer avec Baruch Spinoza (1677, Ethique, IV, propositions IV-VII) que ?? l???homme est n??cessairement toujours soumis aux
passions ??, Korichi M. (2000, p.113), mais sans rejeter toute possibilit?? d???autor??gulation individuelle dans la lign??e de Ren?? Descartes (1649) pour qui selon Michel Meyer (1991, p.238), ?? la passion m???aveugle, donc je suis dans la possible erreur, et je sais cela, donc je suis au-del?? de la passion, la connaissant pour ce qu???elle est ??.

   ??? [5] Par contre, plusieurs cas de ?? fou-rire ?? ont ??t?? relev??s aboutissant au licenciement des rieurs, comme par exemple pour l???employ?? d???une entreprise de pompes fun??bres ou encore pour une vendeuse de lingerie f??minine.
??? [6] Cette interrelation entre pouvoir, v??rit?? et existence se retrouve dans le manifeste censur?? d???Albert Camus, qui devait para??tre dans Le Soir r??publicain, date? du 25 novembre 1939 et publie? dans le cahier du journal Le Monde, N?? 20888, date? du 17 mars 2012 : ?? [...] l???ironie demeure une arme sans pr??c??dent contre les trop puissants. Elle compl??te le refus en ce sens qu???elle permet, non plus de rejeter ce qui est faux, mais de dire souvent ce qui est vrai. Un journaliste libre, en 1939, ne se fait pas trop d???illusions sur l???intelligence de ceux qui l???oppriment. Il est pessimiste en ce qui regarde l???homme. [...] Oui, c???est souvent ?? son corps d??fendant qu???un esprit libre de ce si??cle fait sentir son ironie. Que trouver de plaisant dans ce monde enflamme? ? Mais la vertu de l???homme est de maintenir en face de tout ce qui le nie. ??
??? [7] Pour Freud S. (1905, p. 262-263), ?? Nul ne peut se satisfaire d???avoir fait un mot d???esprit pour soi tout seul. Au travail du mot d???esprit, est indissociablement li?? le profond besoin de communiquer le mot d???esprit ?? autrui ??
??? [8] Darwin C.R. (1872) reste toutefois prudent, puisqu???il consid??re que le rire
?? para??t ??tre ?? l???expression ?? primitive ?? de la joie et du bonheur (Smadja, 1993, p.33).
??? [9] Loi n?? 2002-73 du 17 janvier 2002 de modernisation sociale, J.O. n??15 dat?? du 18 janvier 2002, p. 1008.
??? [10] Le premier ?? avoir affirme? que ?? l???individu en foule diff??re de l???individu isole? ?? et souligne? les risques d???emportement associ??s aux dynamiques collectifs, est peut- ??tre Gustave Le Bon (1895, p.11).
Source : https://www.cairn.info/revue-@grh-2013-1-page-45.htm'
    , 5, 4, 2,1
    ),
    (
        4,
        'Partager des vrais moments de vie de famille',
        'Carte d??fi : pendant une semaine, passer un repas en famille par jour, ?? table sans ??crans (t??l??vision,
smartphone, tablette, etc.).
Bonus : cuisiner en famille en amont du repas.',
        7, 3, 3,1
    ),
    (
        5,
        'Partager des vrais moments de vie de famille',
        'Carte d??fi : lors de votre prochaine sortie, refuser de boire de l???alcool et observer les r??actions de vos
amis. Assumez votre choix et notez les ??motions ressenties.',
        3, 5, 3,1
    );

INSERT INTO `commits` 
    (`id`, `post`, `texte`, `createdAt`, `updatedAt`, `user_id`, `ressource_id`) VALUES 
    (NULL, '2022-02-17 10:54:51.000000', 'test', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, '1', '3'), 
    (NULL, '2022-02-17 10:54:51.000000', 'test2', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, '3', '3'),
    (NULL, '2022-02-17 10:54:51.000000', 'test2', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, '4', '2'),
    (NULL, '2022-02-17 10:54:51.000000', 'test2', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, '4', '3');


INSERT INTO `favoris` 
    (`id`, `favoris`, `createdAt`, `updatedAt`, `user_id`, `ressource_id`) VALUES 
    (NULL, '1', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, '1', '3'), 
    (NULL, '1', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, '1', '2'),
    (NULL, '1', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, '3', '2'),
    (NULL, '1', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, '3', '3'),
    (NULL, '1', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, '2', '1'),
    (NULL, '1', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, '2', '2');



INSERT INTO `statistiques` 
    (`id`, `nb_vues`, `createdAt`, `updatedAt`, `ressource_id`) VALUES 
    (NULL, '45', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, '3'), 
    (NULL, '54', '2022-07-01T14:59:55.711Z', CURRENT_TIMESTAMP, '3'),
    (NULL, '60', '2023-07-01T14:59:55.711Z', CURRENT_TIMESTAMP, '3'),
    (NULL, '10', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, '2'),
    (NULL, '22', '2022-07-01T14:59:55.711Z', CURRENT_TIMESTAMP, '2'),
    (NULL, '30', '2022-07-07T14:59:55.711Z', CURRENT_TIMESTAMP, '2'),
    (NULL, '46', '2022-07-09T14:59:55.711Z', CURRENT_TIMESTAMP, '2'),
    (NULL, '23', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, '1'),
    (NULL, '30', '2022-07-01T14:59:55.711Z', CURRENT_TIMESTAMP, '1'),
    (NULL, '33', '2022-08-05T15:59:55.711Z', CURRENT_TIMESTAMP, '1');
