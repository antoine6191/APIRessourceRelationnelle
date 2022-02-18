CREATE DATABASE IF NOT EXISTS ressource_relationelle;
use ressource_relationelle;

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
    (3, 'développement personnel'), 
    (4, 'loisirs'), 
    (5, 'monde professionnel'), 
    (6, 'parentalité'), 
    (7, 'qualité de vie'), 
    (8, 'recherche de sens'), 
    (9, 'santé physique'), 
    (10, 'santé psychique'), 
    (11, 'spiritualité'), 
    (12, 'vie affective'),
    (13, 'intelligence émotionelle');

INSERT INTO relation_types(id, label)
VALUES (1, 'soi'), 
    (2, 'conjoints'), 
    (3, 'famille: enfants/parents/fratrie'), 
    (4, 'professionnelle: collègues, collaborateurs, managers'),
    (5, 'amis et communautés'),
    (6, 'inconnus');

INSERT INTO ressource_types(id, label)
VALUES (1, 'activité/jeu à réaliser'), 
    (2, 'article'), 
    (3, 'carte défi'), 
    (4, 'cours au format pdf'),
    (5, 'exercice/atelier'),
    (6, 'fiche de lecture'),
    (7, 'jeu en ligne'),
    (8, 'vidéo');


INSERT INTO ressources(id, titre, description, categorie_id, relation_types_id, ressource_types_id, user_id)
VALUES (
        1, 
        'reconnaitre ses émotions', 
        'L’objectif de cet exercice est de reconnaître les émotions sur soi. Pour ce faire, nous noterons dans un petit cahier prévu à cet effet, à des moments prédéfinis de la journée, comment nous nous sentons émotionnellement. Quelle émotion nous habite ? Cette émotion est-elle positive ou négative ? Avec quelle force ? Quel a été le facteur déclencheur ? Nous répèterons la démarche durant une semaine. Après une semaine, reprenons nos notes et identifions avec un marqueur les émotions que nous ressentons le plus souvent, si elles sont positives ou négatives et quel type de facteur déclencheur est observé le plus souvent. Pour conclure, demandons-nous si nos émotions auraient pu être différentes et si la situation en aurait été changée.', 
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
        'Le rire au travail et l’éthique',
        'Introduction:
1Dans cet article, nous souhaitons apporter des éléments de réponse à la question du rire
dans les situations professionnelles. Notre objectif est d’orienter les travaux de recherche portant plus globalement sur l’éthique au travail, mais aussi de fournir des repères pour le développement des pratiques de management. Si le rire comme expression émotionnelle spontanée de joie semble de prime abord échapper à toute tentative de management, c’est justement cette attribution communément positive et, de plus, associée à une liberté inaliénable du sujet qui ressort de notre étude comme contribuant en partie aux problèmes qu’il soulève. En effet, le rire désigne un comportement individuel ou collectif qui n’émerge et ne trouve son sens que dans un contexte d’échanges sociaux. Située dans le champ de la gestion des ressources humaines, cette étude se limite aux situations professionnelles d’interactions directes entre des personnes au travail. La complexité de la problématique du rire s’en trouve réduite puisque nous écartons les phénomènes de foule, les tabous sociétaux, le rapport au sacré ou encore l’exercice des contre-pouvoirs dans nos démocraties modernes.
2Le point de départ des travaux présentés est le constat dans le cadre d’une recherche plus large menée par recherche-action sur le rôle du tiers avec la posture de coach, que plusieurs salariés, demandeurs d’une aide ponctuelle pour résoudre un problème ou sortir d’une situation qu’ils ressentaient comme insupportable, évoquaient “le rire”, celui des autres ou le leur propre, soit comme une source de mal-être, soit comme un mode de résistance ou de défense de soi. Nous nous sommes alors appuyés sur sept cas sélectionnés car ils s’avéraient en rapport direct avec le sujet et l’analyse de contenu des 42 entretiens individuels ainsi réalisés pour proposer une grille d’intelligibilité du phénomène plaçant le rire au travail au cœur d’une problématique managériale d’ordre éthique.
3Pour cela, nous avons dans un premier temps effectué une revue de littérature en l’élargissant à la philosophie morale, pour dans une seconde partie procéder à l’analyse de nos matériaux recueillis empiriquement. Nous avions en effet à traiter du rire d’une part en ce qu’il émerge au sein d’une situation professionnelle qu’il transforme, et de l’éthique abordée comme un processus de questionnement de la morale (Ricœur, 2010). Ces deux notions semblaient relever d’obligations s’imposant au sujet pour des raisons obscures et “au-delà” de lui de par sa nature humaine ou d’un impératif supérieur. La question centrale de notre étude est ainsi : le rire au travail est-il mal ? Et si oui, comment le réguler ? D’emblée, nous pouvons préciser que le rire ne peut être considéré comme mal en soi et que par suite, notre

   questionnement doit trouver une formulation plus appropriée. C’est déjà rentrer dans cette réflexion éthique chère aux philosophes et à laquelle ne peut échapper ni le chercheur en gestion soucieux d’apporter des réponses à la question du bon ou du mal-rire au travail, ni le manager incapable de savoir quand et comment le réguler. Ainsi, les demandeurs d’aide de l’étude, tous cadres d’entreprise et tous, pour des raisons différentes, subissant concrètement une situation, où deux obligations, celle du rire et celle de la morale, se trouvaient en opposition, faisaient appel à un tiers pour en sortir.
4Comment dès lors identifier et traiter de ce qui rentre en tension pour les individus ou les collectifs et qui semble relever moins d’un jugement que du sentiment moral ? S’agit-il, pour reprendre une grille d’analyse tirée de la psychologie sociale (Moscovici, 1984, p.9), d’un conflit dans le rapport à un objet, pour nous le travail, entre un sujet individuel en quête d’authenticité et d’affirmation, et un sujet social en quête de conformité et d’intégration ? Le rire se situant dans le champ des expressions spontanées d’un ressenti, peut-on solliciter la notion de “dissonance émotionnelle”, déjà développée en appui sur les travaux de Leon Festinger (1957) dans le domaine du management (Van Hoorebeke, 2003) ? L’approfondissement dans cette voie au regard de notre problématique considérerait comme un double postulat initial que premièrement, pour prévenir les éventuelles divergences entre rire et morale, les sujets doivent au préalable accéder à la connaissance de l’un comme de l’autre, et deuxièmement, qu’ils arriveront par suite à un contrôle individuel et social des phénomènes du rire. Ce serait supposer que les définitions préexistent à la manifestation du rire, posées définitivement comme des vérités préalables et confondre “éthique” avec discours normatif et pression de conformité. Or, le propre du rire est qu’il ne s’explique pas : il arrive et surprend le rieur. Or, le propre du mal-rire est que s’il est désigné comme une vérité, c’est dans une approche par la manifestation consistant « à laisser-être ce qui se montre » (Thomasset, 1996, p.253).
5Nous souhaitons emprunter ce chemin de questionnement et de réflexion pour poser puis tenter de résoudre la problématique de cette étude. Partant de ce mal-rire présent dans les discours de plainte sur le travail, notre objectif est de nous tourner du côté des pratiques de management au sein des organisations pour identifier en quoi elles en favorisent ou non l’émergence. L’objet de notre étude délimitant par ailleurs le champ de sa problématique est donc le vécu d’un rire désigné comme “mal” par au moins un des acteurs de la situation, soit dans l’instant, soit après-coup. Nous avons ensuite questionné ce mal-rire désigné au regard de la littérature et par la mise en évidence et la discussion de trois puis quatre indicateurs nous concluons sur les pratiques de régulation.
1 – Des bienfaits du rire au travail à la problématique de sa nécessaire régulation
6Le questionnement sous-tendu par la tension entre rire et morale pourrait nous renvoyer à l’un des débats philosophiques toujours ouvert (Darwall, 1995), opposant notamment le comte de Shaftesbury (1715) [1][1]« On peut objecter que ces affections, toutes dénaturées..., qui dans la lignée des stoïciens, en appelait à un gouvernement de soi mais hors de toute loi externe, hors de toute sanction, par satisfaction de l’action bonne, à Emmanuel Kant pour qui l’autodétermination est un exercice de la volonté individuelle pour appliquer la loi morale. Malgré tout, l’un comme l’autre se tournent vers le sujet avec implicitement l’injonction de ne pas “mal-rire”. Sous cet angle, le management ne saurait être concerne?, puisqu’il ne s’agirait que d’une moralité proche de la discipline personnelle et hors du champ des compétences


   professionnelles. Le problème est tout autre si l’on aborde la question de l’interdiction du rire considéré comme un comportement professionnel inapproprié ou producteur de mal-être au travail. Ainsi, l’interrogation, qui sous-tend cette étude est bien : « faut-il réguler le rire au travail ? » avec pour corollaires : « comment sait-on qu’une régulation est nécessaire ? » et
« si c’est nécessaire, comment procéder ? ». Pour répondre à ces questions, nous avons procédé à une revue de littérature notamment dans le domaine de la philosophie morale.
1.1 – Le rire comme problème d’ordre
éthique entre droit naturel et contrôle
social
7Sans considérer avec Jacques Abadie (2003, p.267) que « les hommes pensent que leur rire est toujours innocent, et pourtant il est toujours criminel et condamnable » car il émerge au détriment d’un autre, la croyance opposée et socialement partagée que « les rieurs sont toujours du bon côté [2][2]Nous indiquons les « extraits de discours » entre guillemets en... » en devient une arme puissante de domination. Pour Robert Solomon (1998), les émotions ne « font pas juste de nous arriver », et nous les utilisons pour affronter les autres. Sous cet angle, les personnes utilisent leurs émotions pour agir en leur faveur en mettant en œuvre ce qui peut être désigné comme une “stratégie du rire”. Si une conception d’un rire exclusivement “sous contrôle” est rapidement démentie empiriquement, ne serait-ce que par notre propre expérience, quand le rire “éclate”, il est certes hors de la volonté du sujet, mais il s’inscrit dans un contexte social et même dans une situation directement vécue. Ainsi, le rire ressort comme la résultante d’une forme d’obligation, qui rejoint celle du sens moral de Francis Hutcheson (1993) dans la mesure où elle « n’est pas la contrainte d’une loi extérieure ; mais [où Hutcheson] n’a pas pour autant conçu cette obligation comme une obligation intérieure » (Jaffro, 2000, p.45). « Rire nerveux », « fou-rire », les rieurs s’exclameront : « c’est plus fort que moi ! ».
8Mais que faire ? Interdire de rire dans les organisations ? Bien évidemment même la question est absurde pour trois raisons, dont deux au moins semblent évidentes. D’une part, le rire est une expression émotionnelle généralement spontanée, échappant à la volonté des personnes, voire à leur conscience. L’exiger [3][3]Le point souligné ressort comme encore plus évident si on... ou l’interdire par une loi ou une règle en ressort comme contraire à l’éthique dans la mesure où, elle placerait les sujets dans une situation où il est impossible de bien se conduire, puisque quoi qu’ils fassent, aucun être humain n’a la capacité de s’y conformer [4][4]Nous nous démarquons ici des stoïciens qui avec Cicéron.... On retrouve la notion “d’injonction paradoxale”, consistant à exiger un comportement « qui ne peut surgir que spontanément et non sur commande » (Watzlawick, 1980, p.106) et source de détresse chez les individus qui y sont soumis. Un autre courant théorique traitant des “obscurs ressorts” du rire incontrôlé en introduisant la notion “d’inconscient” nous permet de souligner l’aberration de l’interdiction du rire, celui de la psychanalyse freudienne. Considérant que
« Le sur-moi-de-la-culture a produit ses idéaux et élevé ses exigences ? Parmi ces dernières, celles qui concernent les relations des hommes entre eux sont regroupées en tant
qu’éthique », Sigmund Freud (1929, p.85-86) va s’interroger sur la possibilité « d’écarter le plus grand obstacle à la culture » qu’il ramène à deux pulsions humaines en conflit, celle de l’agression ou de l’auto-anéantissement et celle de la vie (Eros), tout en expliquant que leur refoulement ou leur négation ne peut que conduire à leur surgissement inconscient et socialement inapproprié, voir destructeur de soi ou d’autrui.

   9Si le propos de Freud représente un modèle du constat contre-intuitif d’un développement conjoint de la violence et de la culture, il conforte la pertinence de notre premier argument.
10Une deuxième raison est que le recours formel à la coercition soulèverait des objections morales bien plus importantes au point qu’on ne peut imaginer la stipulation dans un règlement intérieur ou le code du travail qu’il est formellement interdit de rire dans les situations professionnelles [5][5]Par contre, plusieurs cas de « fou-rire » ont été relevés.... En effet, d’un côté, cela atteindrait la liberté de critiquer, ce que le comte de Shaftesbury (1710, p.1) condamnait dès le XVIIIe siècle, tout en en questionnant les soubassements et les dérives potentielles : « Mais qui sera le juge de ce que la censure peut examiner librement, ou de ce qu’elle doit souffrir impunément ? Qui décidera des circonstances où la liberté peut agir sans scrupule, ou se taire ? ». Resituée dans le contexte actuel d’une entreprise, cela déposséderait les salariés de l’un de leurs modes d’expression fondamental, celui des émotions, dont l’usage serait défini hors d’eux-mêmes. Cela reviendrait à une forme de déshumanisation du personnel, dont il n’est plus nécessaire aujourd’hui, de rappeler les multiples critiques non seulement d’ordre éthique, mais aussi associées au constat qu’un tel mode de gouvernance réifiant les forces de travail est contre-productif et dessert les intérêts économiques de l’organisation. D’un autre côté, la loi se tromperait là encore d’objet, car ou bien le rire est “bon” et l’interdire est injustifiable ou bien il est “mal”, et n’est-ce pas dès lors la dynamique même du mal-rire qui est à bannir ? Si l’on considère que les ressorts du rire sont mauvais, comme le soulignait en 1720 Gottfried Wilhelm Leibniz (1720, p.3) dans ce qu’il présentait comme une réponse à Shaftesbury et qui ici nous semble se situer dans une logique complémentaire : « Je ne vois pas aussi que le ris, c’est-à-dire quelque chose qui tient du mépris et abaisse l’idée de l’objet, soit une pierre de touche qui serve à reconnaître la vérité. Mépriser ce qu’on ne connaît pas encore est une prévention dont il faut se défaire ». Sous cet angle, et en poussant le raisonnement, la crainte du rire serait une peur des puissants que celui-ci ne puisse révéler une vérité : au final, la censure serait l’indicateur de mensonges que les personnes ries chercheraient à protéger. Sans rentrer dans le débat, Shaftesbury comme Leibniz, nous ramène à la même interrogation : si une interdiction ou des sanctions sont à poser par une règle ou une loi, ne doivent-elles pas porter sur ce qui conduit à un mal-rire ? 11La troisième raison de l’inimaginable interdiction du rire est reliée aux deux autres mais tout en rappelant l’existence des vertus du “bon rire” qui permet de supporter sa condition humaine et les épreuves de la vie, voire de préserver sa dignité. Malgré tout, la problématique du rire au travail va bien au-delà d’un tri entre le bon et le mauvais rire. Nous pouvons retrouver à la fois la figure maléfique du pervers qui rit du malheur d’autrui, le surgissement d’une émotion échappant au contrôle du sujet, et qui par contrecoup le dessert ou que lui- même trouve inapproprié, et en dernier une situation ou? le rire est la seule issue permettant à la personne d’exister dans un contexte d’aliénation. Le rire se manifeste mais rien n’est “risible” en soi. Cette expression émotionnelle spécifique ne donne que peu d’informations sur son objet ou sur ce que nous pourrions tenter de cerner en définissant la catégorie du “risible”. Par contre il désigne un contexte ou renseigne sur la nature du rieur, et soit dans l’un, soit dans le second, ou encore dans les deux, quelque chose de mauvais se joue, qu’il révèle. Au final, aucuns des rieurs concernés - harceleurs, manipulée ou exclu - ne se trouvent du bon côté. Il en ressort que la question posée n’est pas celle du “comique”, celui-ci d’ailleurs ne suscitant pas forcément un éclat de rire, mais celle de la dynamique du rire au travail, qui semble associée à trois notions principales elles-mêmes inter-reliées [6][6]Cette interrelation entre pouvoir, vérité et existence se..., celles du “pouvoir”, de “la vérité”, et de “l’existence”, avec une fonction restant à identifier et à questionner de régulateur et/ou d’indicateur.

   1.2 – Le rire au travail, un régulateur éthique ?
12Abordé comme régulateur, le rire peut tout d’abord être considéré comme une pratique sociale présupposant un déclencheur du rire et au moins un rieur. Il s’agit a minima d’une interaction entre un sujet et son environnement social. Si le débat semble ouvert entre les philosophes sur la possibilité de rire de soi, de rire seul ou si un tiers est nécessaire [7][7]Pour Freud S. (1905, p. 262-263), « Nul ne peut se satisfaire..., nous n’aborderons cette question qu’indirectement en nous focalisant sur les théories nous permettant d’éclairer l’éventuelle fonction d’indicateur ou de régulateur éthique du rire en situations professionnelles. Dans les organisations, comme le soulignait Ignasi Marti en 2009 (p.128) : « La vision traditionnelle de la résistance est une vision connotée d’opposition, voire d’agressivité ». Si l’apport des formes d’action sans violence est souligné par l’auteur, tout comme l’impact de la déstabilisation, le recours à l’humour ou à l’ironie n’est pas évoqué.
13Par ailleurs, plusieurs travaux en sciences de gestion abordent le management en soulignant le rôle d’une notion, “l’intelligence émotionnelle”, pour l’efficacité des leaders et leur capacité à influencer les individus et les groupes pour atteindre leurs objectifs (Kotzé et Venter, 2011). Le rire peut en ressortir comme une aptitude à extérioriser des émotions
« positives » permettant de mieux faire face au stress et d’entretenir une vision optimiste de l’avenir favorable à la réalisation mais aussi à la mobilisation au travail. Le processus est souvent identifié comme relevant de ce qui est désigné comme un processus de
« contagion émotionnelle » (Barsade, 2002) favorisant, lorsque les émotions sont “positives”, la coopération et la performance individuelle et collective. Le rire est presque systématiquement ramené à une expression de joie, cette dernière étant catégorisée dans le groupe de ces émotions “positives”. Notre approche est bien différente dans la mesure où d’une part même si cette attribution est communément admise depuis Darwin [8][8]Darwin C.R. (1872) reste toutefois prudent, puisqu’il considère..., nous nous limiterons à considérer prudemment que le rire correspond à l’extériorisation d’une décharge émotionnelle et que d’autre part, tout en restant toutefois “binaire” puisque nous opposons le “bien” et le “mal”, le qualificatif de “positif” nous semble inapproprié pour le “mal-rire”. Cette affirmation trouve un étayage empirique dans l’un des cas de coaching ayant initié la réflexion présentée dans cet article. En dehors de plusieurs situations où les coachés interprétaient mal la nature de leurs émotions par conformité sociale et en éprouvaient un mal-être à l’origine de leur demande, notamment du fait du caractère “sexué” des émotions (Braconnier, 2000), Or de nombreux travaux ont montré que le processus de changement dans les situations de travail présente de fortes similitudes avec celui du deuil (Kets de Vries et Miller, 1985), dont la psychiatre Elisabeth Kubler-Ross (1989) a conceptualisé les étapes : allant du déni de la réalité qui heurte le sujet, à l’acceptation, en passant par la révolte et le marchandage. Au niveau affectif, les personnes doivent « s’arracher pour se détacher » de leur état antérieur, ce qui s’accompagne de différents ressentis émotionnels, dont les deux principaux sont la colère puis la peine, deux émotions désignées comme “négatives”. Il en ressort que ce n’est pas le rire ou l’expression d’émotions positives qui représente en soi un mode de régulation mais la régulation des émotions ressenties en autorisant et canalisant leur expression d’une façon socialement acceptable. Ainsi, dans la lignée des études déjà menées, définissant comme compétence du leader, celle de « régulateur des états émotionnels » de son équipe (Haag et Laroche, 2009), plus que d’orienter le groupe vers un type d’émotions, ne peut-on pas faire la proposition qu’il s’agirait plutôt de lui permettre une expression moralement acceptable d’un ressenti par nature échappant au contrôle ? Ce cas confirme également d’autres résultats de

   recherche soulignant l’importance pour les décideurs d’écouter leurs émotions pour bien orienter leur jugement (Coger, Haag et Bonnefous, 2009).
1.3 – Quels indicateurs du mal-rire au travail ?
14Notre analyse nous conduit également à questionner le caractère moralement acceptable de la moquerie, en ce qu’elle définit un rire dont l’objet est autrui, et par suite à nous interroger sur les indicateurs du mal-rire. En effet, lorsqu’elle se tourne vers autrui, qui d’objet du rire se retrouve placée en position de victime, la moquerie est aujourd’hui considérée comme illégitime et condamnable depuis la loi de 2002 contre le harcèlement moral au travail [9][9]Loi n° 2002-73 du 17 janvier 2002 de modernisation sociale,.... Dans ces situations, le “mal-rire” est évident, tout autant que la violence subie, tant depuis Nietzsche, l’on sait que : « Ce n’est pas par la colère, c’est par le rire que l’on tue » (Kessler, 2005, p.507). Par contre, dans d’autres contextes une “gentille moquerie” peut « détendre l’atmosphère » et susciter le rire de l’intéressé(e), se considérant lui-même/elle-même comme “taquiné(e) avec bienveillance”. Ainsi, ce n’est pas la moquerie qui en ressort comme l’indicateur systématique du “mal-rire”, mais la volonté de son “bon usage”. Emmanuel Jaffelin (2010, p.106) propose ainsi entre autres définitions de la gentillesse, celle de
« l’expression de notre bon vouloir, qui est aussi vouloir du bien ». Nous retrouvons ici le “bon usage des passions” de René Descartes (1649, p.227 à 230) qui s’opère non par domination de la raison mais par la volonté « résolue » d’un sujet « averti de l’emportement » que peut être une passion, et du « rempart que constitue sa fermeté ? d’âme ou sa
résolution », la générosité se définissant pour Descartes par l’estime de soi-même, considérée comme une vertu, et non par l’altruisme ou l’oubli de soi. Malgré tout, et sans rentrer dans les ressorts de ce bon usage des passions, il nous semblerait hasardeux de tenter de différencier les “méchantes” des “gentilles” moqueries en prenant comme critère la volonté du moqueur de blesser le moqué ou son incompétence à exercer son « libre arbitre avec justesse ». En dehors de la difficulté à “mesurer” l’intention de sujets qui dans bien des cas n’en ont pas une conscience claire, l’effet destructeur est tout aussi puissant quand les harceleurs s’exclament
« mais c’est pas méchant ! » que lorsqu’ils avouent leur désir de faire souffrir. Ce serait plutôt trois autres notions qui feraient la différence et qui définissent nos propositions de recherche sur les indicateurs du mal-rire au travail et dont nous avons étayé le bien-fondé empiriquement dans une deuxième partie : la “réciprocité”, “l’unanimité”, et la “persistance”. 15Il semble que la “réciprocité” ait deux dimensions. En effet, elle vise à indiquer que les rieurs sont à la fois moqueurs et moqués mais aussi que la situation est elle-même un déclencheur du rire. Nous entendons par le deuxième indicateur, “l’unanimité”, non pas que la moquerie fasse rire “tout le monde”, mais que le rire soit partagé par les trois groupes de protagonistes directement concernés : moqueur, moqué mais aussi témoin. Pour ce dernier, plusieurs travaux soulignent que les spectateurs peuvent être affligés par l’expérience subie d’un “mal-rire” et en éprouver un malaise profond (Houba, 2007). À ce stade, il nous semble que deux conceptions opposées du rire et de son rapport à la régulation sociale peuvent être relevées. Pour l’une, « Le rire est une expérience subversive [...] Le rire est une arme de libération massive contre les oppresseurs, un outil pour résister aux forces
d’anéantissement » (Birnbaum, 2011, p.9), quand pour l’autre, le rire va être considéré avec Henri Bergson (1940) comme une « sanction sociale symbolique » permettant à la société d’exercer un contrôle et de se prémunir des sujets la menaçant. Si dans les deux cas, l’intelligence ou la clairvoyance est postulée du côté des rieurs et des moqueurs, pour le premier, elle s’inscrit dans une dynamique de refus de se soumettre à ce qui domine, alors que

   dans le second, elle exerce une pression de conformité sociale. Replacée dans le monde du travail, chacune des approches peut trouver des objections remettant en question leur bien- fondé et leur possible orientation des pratiques. En effet, de nombreux cas, comme par exemple ceux portant sur la discrimination au travail, mettent en évidence que résister peut aussi consister à ne pas rire d’un bouc-émissaire au milieu d’un groupe hilare, ou affirmer son opposition à la ridiculisation de l’autre. Par ailleurs, le phénomène conduisant les collectifs à une euphorie groupale associée à un sentiment de surpuissance illusoire et une perte du sens des réalités, a été largement étudié [10][10]Le premier à avoir affirme? que « l’individu en foule diffère.... Non seulement les résultats sur les équipes professionnelles contredisent le postulat de clairvoyance des rieurs, mais ils conduisent au constat que les groupes alors désignés comme fusionnels (Anzieu et Martin, 1982) finissent toujours par éclater : ce type de rire ne préserve la cohésion sociale que de façon précaire et artificielle. Le mouvement de retour à la réalité est aussi une prise de conscience individuelle que le collectif peut conduire à adopter un comportement que chaque membre condamne après-coup et considère comme irresponsable. Ainsi, désigner un autre comme une victime expiatoire ou un objet légitime de moqueries est une ignorance de sa valeur d’homme et place dans une posture illusoire de supériorité. Nous avons d’ailleurs relevé que Bergson (1932, p.90) affirme dans un ouvrage antérieur que « si sévèrement que nous affections de juger les autres hommes, nous les croyons, au fond, meilleurs que nous. Sur cette heureuse illusion repose une bonne partie de la vie sociale ». Nous retrouvons ici une définition du troisième indicateur proposé : la “persistance”. Il répond à la question : le rieur considère-t-il après-coup qu’il a “mal-ri” ? La régulation en ressort également comme un processus inachevable, toujours en cours et à mener.
2 – Etayage empirique de l’existence du mal-rire au travail et de ses indicateurs
16Dans cette partie, après avoir explicité la méthodologie de la recherche, nous présentons les résultats de sept études de cas d’accompagnement de responsables confrontés à des difficultés de management et demandeurs d’aide auprès d’un tiers complétés par l’analyse de contenu des entretiens individuels menés, enregistrés et retranscrits dans le cadre de cette recherche- action. Celle-ci s’inscrivait dans un projet visant plus globalement à explorer le rôle du tiers dans le changement des comportements professionnels et la résolution des problèmes de management. L’étude présentée dans cet article a pour objectif de conforter l’existence de situations de rire producteur de mal-être et d’étayer nos propositions de recherche sur les indicateurs de ce mal-rire au travail afin d’orienter les pratiques de régulation.
2.1 – Méthodologie de l’étude : quand le rire conduit à une demande d’aide
17D’un point de vue épistémologique, nous nous situons dans un paradigme interprétativiste. En effet, si notre recherche est de type exploratoire, il ne s’agit pas de faire abstraction des cadres théoriques existants mais d’identifier les théories pertinentes, de s’y appuyer pour les confronter et investiguer la réalité, avec l’adoption d’une posture réflexive avec le terrain (Jodelet, 2003), dans un “va-et-vient” entre observations empiriques et hypothèses interprétatives permettant “d’ancrer” une théorie en cours d’élaboration (Glaser et Strauss, 1967). La méthode de cas nous est apparue comme la plus pertinente pour étudier les

   situations du rire dans les situations de travail. Selon Miles et Huberman (1991), elle permet de développer les conceptualisations à partir de descriptions approfondies des phénomènes. Il s’agit d’appréhender l’impact d’un comportement humain dans une complexité, dont nous souhaitons saisir toutes les dimensions, ce que l’étude de cas favorise (Giroux et Tremblay, 2002). Enfin, le caractère éthique ou non est une préoccupation organisationnelle contemporaine, et l’étude de cas, comme le souligne Yin (1994), est par définition une démarche de recherche qui traite des phénomènes en prise directe avec les contextes dans lesquels ils émergent. La méthode utilisée est celle de la recherche-action (Koenig, 1993) avec comme objectif en cohérence avec notre posture interprétativiste de nous appuyer sur un cadre théorique issu de la littérature afin de faire émerger une grille d’intelligibilité du mal-rire au travail, tout en co-élaborant avec les acteurs (les coachés) des construits opératoires.
18L’étude a été menée de 2006 à 2008. Elle a consisté à accompagner individuellement des demandeurs d’aide dans une série de dix entretiens au maximum d’environ 60 minutes chacun et enregistrés avec l’accord des intéressés. Seul un cas s’est concrétisé par dix entretiens. Pour les six autres cas, le coaché a considéré qu’il n’avait plus besoin d’accompagnement avant la fin des dix séances qui lui étaient ouvertes car son problème était résolu et qu’il pouvait faire face sans aide à ses situations professionnelles aussi difficiles soient-elles. Renforcer l’autonomie du coaché et la confiance en ses propres ressources est l’une des caractéristiques majeures de la démarche d’accompagnement servant d’appui à la recherche-action. Les sept cas de l’étude présentée sont extraits d’un corpus de 34 cas et a abouti à l’analyse de 42 entretiens. Sans que leur demande d’accompagnement concerne initialement directement le rire, les coachés ont été choisis car ils avaient évoqué la question du rire en termes éthiques et cela a émergé de l’échange comme définissant en totalité ou en partie ce qui leur posait problème. La population de l’étude est composée de quatre femmes et de trois hommes, de 26 à 54 ans et occupant des postes de responsable dans différents secteurs d’activités avec le statut de cadre.
Tableau 1
Les sept cas de l’étude
19En plus de l’analyse de cas proprement dite effectuée en confrontant nos notes prises avec la posture de chercheur-coach et l’évolution du discours des coachés au fil des séances, nous avons procédé à une analyse de contenu des entretiens par strates de relecture manuelle et

   répartition des extraits de discours dans les catégories issues d’une part de la revue de la littérature (1ère phase avec deux séries de relecture) puis d’autre part de l’analyse de contenu proprement dite (2e phase avec trois strates de relecture : approfondissement des contenus classés avec émergence de nouvelles dimensions ; émergence d’un 4e indicateur du mal-rire ; repérage des contenus d’étayage et de définition du 4e indicateur). La 1ère phase d’analyse s’est appuyée sur les critères classant des discours tirés de la revue de la littérature : mal-être du sujet ri, mal-être du sujet rieur et les trois indicateurs du mal-rire. Son apport a été d’approfondir le cadre théorique initial, que la 2e phase a permis de compléter essentiellement par le repérage d’une 4e caractéristique.
2.2 – Résultats : Le bon et le mauvais rire coexistent au travail
20La situation des quatre premiers cas permet d’illustrer les différentes dynamiques du rire au travail et leur rapport à l’éthique. Les trois cas suivants nous ont permis de conforter nos propositions de recherche sur les trois indicateurs du mal rire. Nous les avons étayées par une analyse de contenu des 42 entretiens retranscrits des sept cas de l’étude.
2.2.1 – Les dynamiques du rire et leur rapport à l’éthique
21Pour confirmer l’existence du mal-rire au travail et en proposer une grille d’intelligibilité, nous pourrions citer la déclaration de cette femme cadre de 48 ans en congé maladie pour dépression du cas n°1, qui confiait : « Au début, je suis restée de marbre mais à force ça atteint. Stupidement ce sont les blagues sur mon poids qui m’ont usée. C’était juste... méchant ? ». Nos résultats font ressortir que le mal-être généré par le vécu du rire peut être ressenti non seulement par le sujet-ri que par le sujet-rieur. Ainsi dans le cas n°2, une femme de 27 ans nouvellement embauchée dans un service marketing, se « sentait mal » de se retrouver à rire dans un groupe ayant pris l’habitude avant son arrivée de « taquiner » un stagiaire handicapé qui présentait de « légères difficultés d’élocution ». L’intérêt du poste et « la chance d’avoir décroché un job... formateur,... le salaire,... bien quoi ! » ne l’ont pas empêché de changer d’emploi au plus vite. Cela confirme que le “côté des rieurs” est loin d’être désigné systématiquement comme “le bon” même par l’inconfort qu’il procure. Une interrogation d’ordre éthique est bien posée sur le rire au travail, non comme un jeu abstrait visant principalement à distraire les philosophes, mais comme un facteur de souffrance en situation professionnelle à aborder comme tel pour mettre en œuvre les politiques de prévention appelées de leurs vœux par les responsables d’entreprises et les syndicats. Nos résultats ont également fait ressortir les bienfaits potentiels du rire. Ainsi dans le cas n°3, un responsable de production de 54 ans qui nous avait sollicité pour la « redéfinition de [son] projet professionnel » s’est exclamé lors du premier entretien : « Si y’a une chose qu’on ne peut pas m’empêcher, c’est de me marrer... c’est la seule chose... quand l’autre avec sa cravate m’a dit que c’était mon tour... éjecté... vous rigolez !... la veille j’ai fini à... je sais pas... neuf heures... et le matin j’étais là pour leur réunion et ensuite... l’un après l’autre... dans son bureau... allez : j’étais dans le lot... dehors !... j’ai rien dit... je l’ai regardé en me marrant... pas question de s’écrouler... et moi ça va... ».

   22Dans ces trois premiers cas nous retrouvons à la fois la figure maléfique du pervers qui rit du malheur d’autrui, le surgissement d’une émotion échappant au contrôle du sujet, et qui par contrecoup le dessert ou que lui-même trouve inapproprié, et en dernier une situation où le rire est la seule issue permettant à la personne d’exister dans un contexte d’aliénation. Le rire se manifeste mais rien n’est « risible » en soi. Le cas n°4 d’un manager de 38 ans, responsable d’une équipe chargée d’un projet dans le domaine de la haute technologie, que la direction lui avait demandé d’abandonner en pleine réalisation pour se consacrer à un autre, nous permet de préciser cette dynamique du rire et ses limites. Convaincu que son rôle était de « maintenir le moral des troupes », il mettait son « point d’honneur à faire bonne figure », ce qui se traduisait par ce qu’il désignait comme sa « nature à blaguer tout le temps ». Or, ni lui, ni son groupe - « pourtant, on est des pros ! » - n’arrivaient à s’investir sur le nouveau dossier et continuaient à évoquer le précédent. Au cours du deuxième entretien, le manager a exprimé ce qu’il a défini ensuite comme sa “colère rentrée”. Il en est arrivé à la conclusion que ses collègues devaient aussi « lâcher leur venin » pour pouvoir « se remettre au travail ». Ce qu’il fit, déclarant à la troisième et dernière séance : « Je leur ai dit : je sais pas vous mais moi je suis furieux ; alors je vous propose d’en parler mais interdiction d’injurier ou de crier et chacun son tour et uniquement si vous avez envie... et alors, c’est parti !... je crois que c’est réglé... ils m’ont même dit : tu nous saoulais, parce qu’on voyait bien que c’était faux, ça grinçait ! ».
23L’analyse du contenu des 42 entretiens a permis de conforter cette notion de mal-rire inter- reliée à celles d’un double mal-être en miroir : le mal-être du sujet ri et le mal-être du sujet- rieur (voir tableau 2).
Tableau 2
Le mal-rire comme générateur de mal-être

   2.2.2 – Les indicateurs du mal-rire
24Nous avons pu sélectionner trois cas permettant de conforter et préciser les trois indicateurs du mal-rire issus de la revue de littérature, tout en confirmant la pertinence de la transposition d’un cadre théorique issu d’une revue de la littérature essentiellement philosophique. Concernant la “réciprocité”, nous retrouvons cette notion lorsque les sujets abordent la compétition dans les relations professionnelles. Celle-ci comme pour les équipes de commerciaux par exemple, peut être stimulante et prendre la définition donnée dans le sport. Nous avons relevé dans les propos de l’une d’entre elles représentant notre cas n°5, cadre de 47 ans, responsable d’une équipe de vente, qu’elle pouvait s’accompagner d’échanges verbaux utilisant une moquerie qu’elle qualifiait de « bonne guerre ». Notre coachée nous les indiquait pour expliciter son tempérament de « gagnante », ses compétences assertives et sa pugnacité. Il en ressortait que si les moqueries étaient interprétées comme un échange confraternel et respectueux, c’est qu’elle en « recevait tout autant ; ça me booste ! ». C’est d’ailleurs ce qui nous semble pouvoir réguler les formes autodestructrices d’autodérision, comme pour le cas n°6 un malade du sida de 46 ans qui a arrêté de s’exclamer en riant lorsque des échéanciers étaient en cours d’élaboration : « vous me raconterez, si je suis au
cimetière ! ». La notion “d’unanimité” renvoie par suite à une nécessaire forme individuelle d’autorégulation du rire dans une même volonté de respect mutuel de soi et des autres. Enfin, dans le cas n°7, une femme de 26 ans, chef de travaux dans le bâtiment souhaitait « changer de secteur d’activité » car nous disait-elle dans le cadre de son coaching : « j’en peux plus de leur douce rigolade vulgaire d’obsédés par leur pénis ». Après plusieurs séances, et considérant qu’elle n’avait « rien à perdre d’essayer », elle a décidé de « leur dire » et s’y est préparée. Elle fut surprise de constater que plusieurs de ses collègues masculins également pris à témoins des plaisanteries, appuyaient sa demande. Les rieurs furent priés de réserver l’usage de leur humour à une sphère non professionnelle d’amis susceptibles de l’apprécier.
25L’analyse de contenu de nos 42 entretiens, nous a permis non seulement de retrouver dans les situations de travail les trois indicateurs au fil des discours des sujets de l’étude, mais d’en identifier un quatrième que nous avons désigné par les termes de “plein accord préalable”. En effet, nous avons relevé la distinction faite entre le rire subi ou même consenti et le rire approuve?. Si les deux peuvent conduire le sujet-ri à « rire avec les rieurs » pour éviter de perdre la face, seul le second semble être une « sortie sans casse » pour la personne. Ainsi pour Goffman (1974, p.39), « on peut [donc] considérer une relation sociale comme étant une situation où une personne est particulièrement forcée de compter sur le tact et la probité d’autrui pour sauver la face et l’image qu’elle a d’elle-même ». Nous avons retrouvé cette situation décrite par les sujets dans leurs entretiens, comme par exemple comme discours type : « j’ai bien vu qu’il se retenait de rire... faut dire que quand je bafouille, j’y vais pas à moitié... alors j’ai dit : ma chompre a trouché... et j’ai éclaté de rire... c’était marrant... on a bien ri et ça fait du bien ». On retrouve ici le rire, source de bien-être et permettant de développer sa capacité de faire face aux situations critiques du monde professionnel (Mittal et Mathur, 2011). Par contre, « rire jaune » tout en sortant meurtri de la situation d’échanges est revenu dans les entretiens comme l’indicateur que « le rire n’était pas de bonne qualité ». Ne pas rire est considéré comme une façon « d’empirer la situation », les protestations pouvant être encore plus risibles. Un discours type pourrait être « le plus douloureux est que je n’ai rien pu faire d’autres que faire semblant de trouver ça drôle » ou « c’était outrageant, il se moquait de mon apparence ; le seul qui peut le faire c’est moi... c’est comme les blagues juives... c’est antisémite hein quand seuls les juifs ne rient pas ».

   2.3 – Discussion : vers la régulation du mal- rire au travail
26Repérer en se référant aux indicateurs qu’il s’agit d’un mal-rire au travail ne suffit pas à définir les modes de régulation. En effet, il ne faudrait pas en déduire qu’il s’agit de définir les normes générales du “bon comique” au travail, mais plutôt que la nécessité s’impose d’en souligner les dysfonctionnements. Nous avons ainsi montré que le poids du contexte sur l’évaluation de la situation, comme Hackney (2011) qui a démontré que certaines pratiques de management pouvaient conduire à faire perdre le sens de l’humour des salariés même lorsque les plaisanteries ont été pré-testées comme drôles. Ce qui fait rire est non seulement culturellement ancré mais fait le ciment des groupes sociaux. Il est une arme de stéréotypage et de discrimination tout autant qu’un puissant levier d’émancipation, comme en témoignent les travaux sur le rire des femmes (Willett et al., 2012). Gkorezis, Hatzithomas et Petridou (2011) soulignent ainsi que si l’utilisation de l’humour par les dirigeants est un levier puissant de mobilisation, son recours peut avoir des effets négatifs en fonction notamment de l’ancienneté des salariés. D’une part, le rôle de l’humour comme activateur de créativité ou de résolution de problème a été mis en évidence, voire même pour assouplir les rigidités organisationnelles propres aux administrations publiques (Cates, 1979). D’autre part, plusieurs travaux ont souligné que les émotions positives comme l’euphorie pouvaient conduire à une prise de risque plus importante et inconsidérée notamment dans les décisions financières (Cavalheiro et al., 2011).
27Nos quatre indicateurs, “réciprocité”, “unanimité”, “persistance” et “plein accord préalable” peuvent également ressortir comme des règles de comportement collectif à poser pour permettre aux salariés de les intérioriser émotionnellement. Il s’agit ainsi moins de règles de politesse formelle que de l’apprentissage d’une forme de “civilité au travail”, en référence à la définition de l’incivilité par les philosophes et de leur étude de la recrudescence du phénomène dans nos civilisations (Habib et Raynaud, 2012 ; Bourin, 2012). Face au mal-être ressenti par les “mal-rieurs” et de l’effet destructeur sur la personne “rie”, il s’agirait pour les managers en lien avec les travaux initiés par Sen (2004) au niveau socio-économique de créer les conditions d’une “vie au travail humainement digne” et une gestion des ressources humaines qui intègre ce que Nussbaum (2012) désigne comme des “culpabilités” et parmi lesquelles se positionnent le ressenti émotionnel et la conception du bien.
Conclusion
28Cette recherche menée en appui sur sept cas de coaching avec 42 entretiens individuels, nous a conduits à définir quatre indicateurs du rire au travail : la “réciprocité”, “l’unanimité”, “la persistance” et le “plein accord préalable” permettant d’orienter les pratiques de régulation. Dans ce qu’ils présupposent comme dynamique à l’œuvre, les notions qu’ils désignent sont aussi ce qui permet de ne pas limiter le rire à la moquerie. Il nous semble même que le rire prend toute sa portée « d’intervention créatrice de la conscience » soulignée par Robert Escarpit (1960, p.94), et peut devenir une véritable force de progrès potentielle dans les organisations si le comique renonce à ridiculiser les personnes pour se positionner dans le champ de la dénonciation de et par l’absurde des systèmes ou des politiques. Hors de la moquerie, le rire est aussi un mode de faire face à la détresse de vivre et peut être relié à un comique qui « manifeste la fragilité essentielle du sens humain, mais nous donne les moyens de l’exorciser » (Giribone, 2009, p. 58). Le rire des autres est dès lors potentiellement un

   encouragement à se distancier et même à transcender notre condition d’homme et la finitude de la vie. En cela, il est un vecteur de réflexivité et même de bien-être, non dans une recherche exclusive de plaisir hédoniste, qui ne résiste pas au questionnement d’ordre éthique, mais dans une quête existentielle telle que Martin Heidegger (1927) l’a théorisée.
29Cette première étude sur le rire au travail et l’éthique débouche enfin sur plusieurs pistes de recherche et, nous semble-t-il, plus particulièrement sur un recensement des différentes situations professionnelles d’émergence du rire afin de valider quantitativement nos résultats affirmant que c’est seulement lorsque le rire est réciproque, unanime, qu’il perdure et qu’il a émergé dans un plein accord préalable des parties, qu’il s’inscrit dans une dynamique positive pour les personnes comme pour les organisations.
Notes
• [1] « On peut objecter que ces affections, toutes dénaturées qu’elles sont, ne vont point sans plaisir ; & qu’un plaisir quelque inhumain qu’il soit, est toujours un plaisir, fût-il place? dans la vengeance, dans la malignité & dans l’exercice même de la tyrannie. Cette difficulté serait sans réponse, si, comme dans les joies cruelles & barbares, on ne pouvait arriver au plaisir qu’en passant par le tourment ; mais aimer les hommes, les traiter avec humanité, exercer la complaisance, la douceur, la bienveillance, & les autres affections sociales ; c’est jouir d’une satisfaction immédiate à l’action & qui n’est payée d’aucune peine antérieure ; satisfaction originelle & pure, qui n’est prévenue d’aucune amertume. Au contraire, l’animosité, la haine, la malignité, sont des tourments réels dont la suspension occasionnée par l’accomplissement du désir, est comptée pour un plaisir. » Cooper A.A., comte de Shaftesbury (1715, p.248-249)
• [2] Nous indiquons les « extraits de discours » entre guillemets en les distinguant
des « citations » mises quant à elles en italique. Nous utilisons un autre caractère pour les “notions” que nous questionnons. Ici il s’agit d’une affirmation prononcée communément comme un dicton.
• [3] Le point souligné ressort comme encore plus évident si on questionne la mesure consistant à imposer aux salariés de rire. Si l’on associe rire et joie, on pourrait y retrouver la dénonciation d’une pression exercée actuellement de façon implicite dans certaines organisations et revenant à exiger que les salariés expriment leur bonheur de travailler - Cf. en sciences de gestion : Gori R., Le Coz P. (2006) ; en philosophie : Manzano M. (2008).
• [4] Nous nous démarquons ici des stoïciens qui avec Cicéron considéraient que la
« joie folle » est une « maladie de l’âme » au même titre que toutes les passions qui éloigne l’homme de « la conscience du sage » : Cicéron (45 av. J.C.), Tusculanes, III, IV-V, in Bréhier E. (1997), pour considérer avec Baruch Spinoza (1677, Ethique, IV, propositions IV-VII) que « l’homme est nécessairement toujours soumis aux
passions », Korichi M. (2000, p.113), mais sans rejeter toute possibilité d’autorégulation individuelle dans la lignée de René Descartes (1649) pour qui selon Michel Meyer (1991, p.238), « la passion m’aveugle, donc je suis dans la possible erreur, et je sais cela, donc je suis au-delà de la passion, la connaissant pour ce qu’elle est ».

   • [5] Par contre, plusieurs cas de « fou-rire » ont été relevés aboutissant au licenciement des rieurs, comme par exemple pour l’employé d’une entreprise de pompes funèbres ou encore pour une vendeuse de lingerie féminine.
• [6] Cette interrelation entre pouvoir, vérité et existence se retrouve dans le manifeste censuré d’Albert Camus, qui devait paraître dans Le Soir républicain, date? du 25 novembre 1939 et publie? dans le cahier du journal Le Monde, N° 20888, date? du 17 mars 2012 : « [...] l’ironie demeure une arme sans précédent contre les trop puissants. Elle complète le refus en ce sens qu’elle permet, non plus de rejeter ce qui est faux, mais de dire souvent ce qui est vrai. Un journaliste libre, en 1939, ne se fait pas trop d’illusions sur l’intelligence de ceux qui l’oppriment. Il est pessimiste en ce qui regarde l’homme. [...] Oui, c’est souvent à son corps défendant qu’un esprit libre de ce siècle fait sentir son ironie. Que trouver de plaisant dans ce monde enflamme? ? Mais la vertu de l’homme est de maintenir en face de tout ce qui le nie. »
• [7] Pour Freud S. (1905, p. 262-263), « Nul ne peut se satisfaire d’avoir fait un mot d’esprit pour soi tout seul. Au travail du mot d’esprit, est indissociablement lié le profond besoin de communiquer le mot d’esprit à autrui »
• [8] Darwin C.R. (1872) reste toutefois prudent, puisqu’il considère que le rire
« paraît être » l’expression « primitive » de la joie et du bonheur (Smadja, 1993, p.33).
• [9] Loi n° 2002-73 du 17 janvier 2002 de modernisation sociale, J.O. n°15 daté du 18 janvier 2002, p. 1008.
• [10] Le premier à avoir affirme? que « l’individu en foule diffère de l’individu isole? » et souligne? les risques d’emportement associés aux dynamiques collectifs, est peut- être Gustave Le Bon (1895, p.11).
Source : https://www.cairn.info/revue-@grh-2013-1-page-45.htm'
    , 5, 4, 2,1
    ),
    (
        4,
        'Partager des vrais moments de vie de famille',
        'Carte défi : pendant une semaine, passer un repas en famille par jour, à table sans écrans (télévision,
smartphone, tablette, etc.).
Bonus : cuisiner en famille en amont du repas.',
        7, 3, 3,1
    ),
    (
        5,
        'Partager des vrais moments de vie de famille',
        'Carte défi : lors de votre prochaine sortie, refuser de boire de l’alcool et observer les réactions de vos
amis. Assumez votre choix et notez les émotions ressenties.',
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
