---
css: assets/polyman.css
############################## DOCUMENT INFO DATA #############################
# !define( DocVer   )( v1.1.1-rc  ) <- Document version number
# !define( PMLVer   )( 1.0        ) <- PML version number
# !define( DocDate  )( 2020-08-23 ) <- Document last edited (YYYY-MM-DD)
# !define( PolygenV )( v1.0.6     ) <- Polygen version the doc applies to
###############################################################################
lang: it
title:          Polygen Meta Language Spec !PMLVer
subtitle:       Guida introduttiva all'uso di PML
author-meta:    Alvise Spanò
date-meta:      !DocDate
description: |
    Polygen Meta Language (PML) v!PMLVer — Specifica tecnica e guida
    introduttiva all'uso di PML, il meta linguaggio di Polygen.
keywords:
   - polygen
   - linguaggio
   - grammatica
   - specifica
   - pml
   - ebnf
toc-title:      Indice
#==============================================================================
#                           pandoc-crossref settings
#==============================================================================
numberSections: true
sectionsDepth: -1
secPrefix:
    - "sezione"
    - "sezioni"
linkReferences: true
nameInLink: true
chapters: true
autoSectionLabels: true
#==============================================================================
#                      Blocco di Testo Prima dell'Indice
#==============================================================================
summary: |
    Edizione **!DocVer** (!DocDate) per **PML !PMLVer**, Polygen **!PolygenV**.

    :::::: Note :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
    __Copyright © 2002-2020 Alvise Spanò.__ Questo documento è soggetto ai termini
    della licenza [GNU General Public License] (GPLv2+); o la versione 2 della
    licenza o (a propria scelta) una versione successiva. È lecito redistribuirlo
    o modificarlo secondo i termini della medesima licenza.

    Nuova edizione digitale a cura di [Tristano Ajmone] (Febbraio 2018).
    :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
...

# Cos’è una grammatica?

Una grammatica è un file di testo ASCII che contiene le definizioni della struttura sintattica e dei termini che il programma utilizza per comporre frasi. Il *Polygen* è in grado di interpretare un linguaggio per la definizione di grammatiche di *[tipo-2]* (secondo la classificazione di Chomsky) che consiste in una variante più espressiva dell’*EBNF ([Extended Backus Naur Form])* --- una forma semplice e molto utilizzata di descrizione della sintassi di un linguaggio.

Una definizione consiste nello specificare per un dato simbolo una serie di **produzioni** separate dal **pipe** `|` e seguite dal **punto e virgola `;`** che funge da terminatore:

**ESEMPIO**

!Polygen
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
S ::= la mela | il mango | l'arancia ;
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

**PRODUCE**

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
la mela
il mango
l'arancia
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Questa definizione del simbolo `S` (detto __non terminale__) permette la generazione dei simboli `la mela`, `il mango` oppure `l'arancia` (detti __terminali__).

La probabilità con cui viene generata `la mela` è pari ad 1 volta su 3, così come per `il mango` e `l'arancia`: perciò in presenza di 3 produzioni si ha 1 probabilità su 3 per ciascuna di esse; in presenza di 5 produzioni si ha una probabilità su 5, ecc.

È possibile fornire numerose definizioni di simboli non terminali diversi e richiamare tali simboli nelle varie produzioni, al fine di rendere articolata la generazione di frasi:

**ESEMPIO**

!Polygen
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
S ::= il Animale mangia Frutto ;

Animale ::= gatto | cane ;
Frutto ::= la mela | il mango ;
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

**PRODUCE**

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
il gatto mangia la mela
il gatto mangia il mango
il cane mangia la mela
il cane mangia il mango
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

ecc.

:::::: Note ::::::::::::::::::::::::::::::::
__N.B.__: il _Polygen_ adotta convenzionalmente il simbolo non terminale `S` come iniziale, pertanto qualunque grammatica deve presentare almeno la definizione di esso.
::::::::::::::::::::::::::::::::::::::::::::

Per convenzione, un termine che comincia per lettera maiuscola è considerato un simbolo non terminale (associato quindi ad una definizione a valle o a monte dell'utilizzo), mentre un termine che comincia per lettera minuscola è cosiderato un simbolo terminale, ovvero una semplice parola. Pertanto, se si desidera generare una parola che inizia con lettera maiuscola, è necessario specificarla tra virgolette affinché non venga confusa con un simbolo non terminale:

**ESEMPIO**

!Polygen
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
S ::= Fido "Fido" ;

Fido ::= bassotto | pastore | alano ;
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

**PRODUCE**

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
bassotto Fido
pastore Fido
alano Fido
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Si noti che i caratteri che il programma utilizza come parole chiave (ad esempio le parentesi tonde e quadrate) devono essere specificati tra  virgolette se si desidera che vengano generati in output (si veda la [@sec:regole-lessicali] per le regole lessicali complete).

**ESEMPIO**

!Polygen
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
S ::= "(" (mela | pera) ")" ;
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

**PRODUCE**

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
( mela )
( pera )
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

## Sottoproduzioni

In una definizione, nella parte a destra del `::=`, è possibile specificare una sottoproduzione di qualunque forma tra parentesi tonde:

**ESEMPIO**

!Polygen
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
S ::= la (pera | mela | banana) e' sul (tavolo | davanzale) ;
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

**PRODUCE**

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
la pera e' sul tavolo
la pera e' sul davanzale
la mela e' sul tavolo
la mela e' sul davanzale
la banana e' sul tavolo
la banana e' sul davanzale
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

## Sottoproduzioni opzionali {#sec:sottoproduzioni-opzionali}

Una sottoproduzione specificata tra parentesi quadrate anziché tonde è considerata opzionale ed ha una probabilità del 50% (pari ad 1 volta su 2) di essere generata:

**ESEMPIO**

!Polygen
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
S ::= la (pera | mela) e' sul (tavolo | davanzale) [del salotto | della cucina] ;
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

**PRODUCE**

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
la pera e' sul tavolo
la pera e' sul tavolo del salotto
la pera e' sul tavolo della cucina
la pera e' sul davanzale
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

ecc.

## Commenti

È possibile scrivere testo qualunque tra la coppia di parole chiave
`(*` e `*)`. Tale testo verrà completamente ignorato dal *Polygen*.

**ESEMPIO**

!Polygen
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
S ::= la mela | la pera (* | la banana *) | il mango ;
(* anche questo e' un commento *)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

**PRODUCE**

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
la mela
la pera
il mango
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# Caratteristiche avanzate

Il *Polygen* supporta una serie di costrutti che aumentano l’espressività del linguaggio di definizione delle grammatiche ben oltre _EBNF_.

## Concatenazione

L’**apice** `^` può essere prefisso, suffisso o infisso in qualunque punto di una produzione per istruire il programma a non inserire un carattere di spazio nell’output generato:

**ESEMPIO**

!Polygen
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
S ::= "(" ^ (mela | pera) ^ ")" ;
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

**PRODUCE**

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
(mela)
(pera)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

La concatenazione dell’output è particolarmente comoda nei casi i cui si desidera generare parole assemblando sillabe o lettere da produzioni differenti:

**ESEMPIO**

!Polygen
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
S ::= la bottega del Prodotto ;

Prodotto ::= ^lo sciroppo | ^le arance | salame ;
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

**PRODUCE**

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
la bottega dello sciroppo
la bottega delle arancie
la bottega del salame
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Si badi che la specifica di più apici è del tutto equivalente alla specifica di un apice solo.

## Epsilon {#sec:epsilon}

Il carattere di underscore `_` è la parola chiave che specifica la produzione vuota, formalmente chiamata **epsilon**.

**ESEMPIO**

!Polygen
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
S ::= palla | _ ;
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

**PRODUCE**

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
palla
_
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Si badi che una epsilon-produzione non consiste nel carattere `_` in sè, né in un carattere di spazio, ma nell’assenza di output. L’esempio di cui sopra è esattamente identico al seguente:

**ESEMPIO**

!Polygen
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
S ::= [palla] ;
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

**PRODUCE**

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
palla
_
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Ovvero una grammatica che può generare l’output `a` oppure nulla.

## Controllo della probabilità di una produzione {#sec:controllo-probabilita}

Il simbolo **più** `+` prefisso ad una qualunque produzione aumenta la probabilità che questa venga generata rispetto alle altre della stessa serie; simmetricamente, il simbolo **meno** `-` diminuisce la probabilità. Un numero a piacere di `+` e `-` può essere specificato:

**ESEMPIO**

!Polygen
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
S ::= il gatto mangia (+ la mela |- la pera | l'arancia |-- il  limone)  ;
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

**PRODUCE**

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
il gatto mangia la mela
il gatto mangia la pera
il gatto mangia l'arancia
il gatto mangia il limone
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

La definizione del simbolo non terminale `S` viene internamente interpretata come:

!Polygen
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
S ::= il gatto mangia ( la mela | la mela | la mela | la mela
                      | la pera | la  pera
                      | l'arancia | l'arancia | l'arancia
                      | il  limone) ;
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

pertanto la probabilità che la produzione `la mela` venga generata è maggiore rispetto a quella de `l'arancia`, che è maggiore di quella de `la pera`, a sua volta maggiore de `il limone`.

## Unfolding {#sec:unfolding}

Il _Polygen_ dispone di un potente sottosistema di unfolding che, in generale, permette di portare al livello della sequenza corrente una serie di produzioni altrimenti raccolte in una sottoproduzione o da un simbolo non terminale.

Si può intuitivamente vedere questa operazione come un _appiattimento_ di una grammatica operato a monte della generazione e che pertanto può influire su quest'ultima dal punto di vista probabilistico soltanto, poiché la trasformazione non altera la semantica della grammatica sorgente --- come dimostrano le regole di traduzione riportate in [@sec:regole-traduzione].

Non tutti i possibili atomi tuttavia possono essere sottoposti ad un unfolding, ma solamente quelli per cui tale operazione ha senso: si consulti la [@sec:sintassi-concreta] per conoscere tale sottoinsieme.

### Di simboli non terminali {#sec:simboli-non-terminali}

Si consideri il seguente scenario:

**ESEMPIO**

!Polygen
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
S ::= gatto soriano | cane Razza ;

Razza ::= pastore | dalmata | bastardo ;
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

**PRODUCE**

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
gatto soriano
cane pastore
cane dalmata
cane bastardo
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

La probabilità che `gatto soriano` sia generato è pari a 1 su 2; non vale però lo stesso per `cane pastore`, `cane dalmata` e `cane bastardo`, sebbene un utente possa ritenere ragionevole che siano tutti generabili con la medesima probabilità.

Il problema nasce dal fatto che `gatto soriano` e `cane Razza` si spartiscono equamente la produzione di `S`, ovvero la probabilità con cui viene generato `gatto soriano` è la stessa (pari ad 1 su 2) con cui viene generato uno tra `cane pastore`, `cane dalmata` e `cane bastardo`. Nella fattispecie la distribuzione delle probabilità per ogni produzione possibile   appare come segue:

|                 |                  |
|-----------------|------------------|
| `gatto soriano` | 1/2              |
| `cane pastore`  | 1/2 \* 1/3 = 1/6 |
| `cane dalmata`  | 1/2 \* 1/3 = 1/6 |
| `cane bastardo` | 1/2 \* 1/3 = 1/6 |

Come prova, 1/2 + 1/6 + 1/6 + 1/6 = 1.

Al fine di ridistribuire equamente le probabilità delle sottoproduzioni sarebbe necessario riscrivere `S` nel modo seguente:

!Polygen
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
S ::= gatto soriano | cane pastore | cane dalmata | cane bastardo ;
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

perdendo tuttavia l’architettura originale che raccoglieva le razze in un apposito simbolo non terminale ed aumentando di molto la quantità di lavoro da compiere da parte dell’utente.

Per risolvere questo problema, che rappresenta un’istanza del più vasto problema dell’irregolarità della distribuzione delle probabilità in presenza, in generale, di sottoproduzioni, il linguaggio consente di operare l’**unfolding** di un simbolo non terminale:

**ESEMPIO**

!Polygen
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
S ::= gatto soriano | cane >Razza ;

Razza ::= pastore | dalmata | bastardo ;
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Prefiggendo la parola chiave `>`, il programma opera, nella fase di preprocessing a monte della generazione, la trasformazione di cui sopra, cambiando la distribuzione delle probabilità nel seguente modo:

|                 |     |
|-----------------|-----|
| `gatto soriano` | 1/4 |
| `cane pastore`  | 1/4 |
| `cane dalmata`  | 1/4 |
| `cane bastardo` | 1/4 |

### Di sottoproduzioni {#sec:unfolding-sottoproduzioni}

Non è raro utilizzare una sottoproduzione per diminuire la verbosità di una grammatica, ad esempio raccogliendo una serie di sostantivi in base all’articolo che supportano, evitando così di doverne specificare uno per ciascuno.

**ESEMPIO**

!Polygen
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
S ::= il (gatto | cane | canarino | toro | lupo | gallo)
    | lo storione
    | la (capra | pecora) ;
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Se da una parte l'architettura e la scalabilità della grammatica ne giovano, dall'altra la qualità dell'output ne risente molto, in quanto 1 volta su 3 verrà generato `lo storione` per un motivo analogo a quello esposto in [@sec:simboli-non-terminali]. Per portare l'eterogeneità dell'output al (ragionevolmente desiderabile) livello in cui ciascun animale possa essere prodotto con la medesima probabilità, sarebbe necessario evitare l'utilizzo delle parentesi tonde, le quali danno luogo a sole 3 macro-produzioni, e specificare l'articolo accanto ad ogni nome di animale; in altre parole, quindi, rinunciare all'architettura originale della grammatica.

A tale proposito una qualunque sottoproduzione può essere sottoposta ad __unfolding__ in maniera analoga a quanto esposto in [@sec:simboli-non-terminali] per i simboli non terminali. L'uso dell'operatore `>` istruisce il programma a delegare al preprocessore l'onere di operare l'unfolding della sottoproduzione immediatamente seguente, permettendo all'utente di mantenere inalterata l'architettura della grammatica sorgente.

**ESEMPIO**

!Polygen
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
S ::= il >(gatto | cane | canarino | toro | lupo | gallo)
    | lo storione
    | la >(capra | pecora) ;
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

viene tradotto esattamente come desiderato:

!Polygen
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
S ::= il gatto | il cane | il canarino | il toro | il lupo | il gallo
    | lo storione
    | la capra | la pecora ;
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

ovvero una serie di produzioni alla stesso livello.

Un esempio più articolato:

**ESEMPIO**

!Polygen
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
S ::= M: >( il (gatto | cane >(pastore | dalmata) | canarino | toro | lupo | gallo)
          | lo storione
          )
   |  F: la >(capra | pecora) ;
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

viene tradotto in:

!Polygen
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
S ::= M: il gatto | M: il cane pastore | M: il cane dalmata | M: il canarino | M: il toro | M: il lupo | M: il gallo
   |  M: lo storione
   |  F: la capra | F: pecora ;
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

### Di sottoproduzioni opzionali

Una sottoproduzione tra parentesi quadrate (vedi [@sec:sottoproduzioni-opzionali]) è equivalente ad una sottoproduzione tra parentesi tonde che produce il contenuto originale oppure __epsilon__ (si veda l'esempio di cui in [@sec:controllo-probabilita-opzionale]).

Alla luce di ciò, operare l'__unfolding__ di una sottoproduzione opzionale è perfettamente lecito, dunque, ed il risultato è analogo a quanto descritto in [@sec:unfolding-sottoproduzioni].

### Di sottoproduzioni permutabili

Come è possibile constatare dalle regole di traduzione in [@sec:regole-traduzione], l'__unfolding__ operato dal preprocessore avviene a valle delle permutazioni (vedi [@sec:permutazioni]): una sottoproduzione permutabile legata all'operatore `>` è pertanto soggetta prima alla permutazione, la quale mantiene valida l'azione dell'__unfolding__ specificata, che viene eseguita successivamente nella nuova posizione all'interno della sequenza.

**ESEMPIO**

!Polygen
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
S ::= >{il >(cane | gatto)} e {la (pecora | capra)} ;
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Si presti attenzione al differente comportamento dell'unfolding esterno alle parentesi graffe rispetto a quello interno; la traduzione dà luogo a:

!Polygen
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
S ::= il cane e la (pecora | capra)
   | il gatto e la (pecora | capra)
   | la (pecora | capra) e il cane
   | la (pecora | capra) e il gatto ;
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

### Di sottoproduzioni soggette ad unfolding in profondità

Come descritto in [@sec:unfolding-profondita] l'unfolding in profondità dà luogo ad una sottoproduzione al cui interno tutto è stato appiattito.

Tuttavia talvolta è desiderabile operare un ulteriore __unfolding__: quello di tale sottoproduzione.

**ESEMPIO**

!Polygen
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
S ::= > >> il (cane | gatto) | la (pecora | capra) << | lo storione ;
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

che viene tradotto in:

!Polygen
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
S ::= il cane | il gatto | la pecora | la capra | lo storione ;
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

## Attributi

### Etichette e selezione {#sec:etichette-selezione}

Ciascuna produzione o sottoproduzione (innestata a piacere) può essere associata ad una etichetta e, grazie all'operazione di selezione tramite l'operatore __punto__, è possibile vincolare la generazione al sottoinsieme di una serie di produzioni che la presentano.

**ESEMPIO**

!Polygen
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
S ::= Nome.S mangia Nome.P | (Nome mangiano Nome).P ;

Nome ::= (S: il | P: i) (lup | gatt) ^ (S: o | P: i) ;
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

**PRODUCE**

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
il lupo mangia i lupi
il lupo mangia i gatti
il gatto mangia i lupi
il gatto mangia i gatti
i lupi mangiano i lupi
i lupi mangiano i gatti
i gatti mangiano i lupi
i gatti mangiano i gatti
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

La selezione avviene semplicemente eliminando da una serie di produzioni o sottoproduzioni tutte quelle aventi etichetta differente da quella selezionata. Più precisamente, una selezione propaga l’etichetta specificata (a destra del punto) per tutta la generazione di ciò che si trova a sinistra del punto; nel corso della generazione verranno considerate valide solamente quelle produzioni che non sono associate ad alcuna etichetta oppure che sono associate ad un’etichetta che è stata selezionata.

Si noti quindi che è possibile operare selezioni in momenti diversi e arricchire la lista delle etichette selezionate: tale tecnica può tornare utile per propagare determinati attributi che si vuole influenzino la generazione.

**ESEMPIO**

!Polygen
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
S ::= (Ogg.M | Ogg.F).S | (Ogg.M | Ogg.F).P ;

Ogg ::= M: ((Art Sost).il | (Art Sost).lo)
     |  F: Art Sost ;

Art ::= M: (il: (S: il | P: i) | lo: (S: lo | P: gli))
     |  F: (S: la | P: le) ;

Sost ::= M: ( il: (lup ^ Decl.2 | can ^ Decl.3))
            | lo: (gnom ^ Decl.2 | zabaion ^ Decl.3)
      |  F: pecor ^ Decl.1 ;

Decl ::= 1: (S: a | P: e) | 2: (S: o | P: i) | 3: (S: e | P: i) ;
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

**PRODUCE**

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
il lupo
il cane
lo gnomo
lo zabaione
la pecora
i lupi
i cani
gli gnomi
gli zabaioni
le pecore
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Nell'esempio, assumendo la convenzione secondo cui le etichette `S`, `P`, `M` ed `F` si riferiscono rispettivamente alle forme singolare, plurale, maschile e femminile, è stato possibile declinare correttamente sostantivi appartenenti a classi differenti ed associare l'articolo appropriato.

Si faccia caso che, volendo in un futuro estendere la serie dei sostantivi, sarà possibile aggiungerne a piacere curandosi solamente di inserirli nella sottoproduzione di `Sost` opportuna.

### Selezione multipla

Si prenda l'esempio in [@sec:etichette-selezione]: la produzione sostanzialmente attiva entrambe le coppie di etichette prima di discendere nella generazione del non-terminale `Ogg`: sia la coppia `S` e `P` che la coppia  `M` ed `F`  vengono attivate mutuamente, con l'obiettivo di generare tutte le combinazioni possibili di maschile e femminile, sia al singolare che al plurale. Tuttavia, casi come questo introducono ineleganti replicazioni: la sottoproduzione `(Ogg.M | Ogg.F)` è replicata due volte: una volta per l'etichetta `S` ed un'altra per l'etichetta `P`.

Per evitare tali replicazioni è possibile attivare molteplici etichette in una singola operazione di selezione, separandole dal simbolo di __pipe__. L'esempio di cui sopra si può esprimere in modo più compatto e senza replicazioni nel seguente modo:

**ESEMPIO**

!Polygen
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
S ::= Ogg.(M|F).(S|P) ;
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Analogamente a quanto descritto in [@sec:controllo-probabilita] per le produzioni, è inoltre possibile specificare dei modificatori di probabilità per le etichette che compaiono in una serie tramite l'utilizzo delle parole chiave `+` e `-`.

**ESEMPIO**

!Polygen
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
S ::= Ogg.(+M|--F).(S|-P) ;
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Che è equivalente a:

!Polygen
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
S ::= (Ogg.M | Ogg.M | Ogg.M | Ogg.M | Ogg.F).S
   |  (Ogg.M | Ogg.M | Ogg.M | Ogg.M | Ogg.F).S
   |  (Ogg.M | Ogg.M | Ogg.M | Ogg.M | Ogg.F).P ;
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

### Reset dell'ambiente delle etichette

Va tenuto a mente che l'operatore di selezione aggiunge l'etichetta specificata alla serie di quelle già attive; ciò comporta la necessità di azzerare manualmente tale serie di quando in quando. Si vogliano ad esempio generare numeri interi positivi (zero incluso) di qualunque lunghezza in cui non compaiano zeri non significativi:

**ESEMPIO**

!Polygen
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
S ::= Cifra | S.nz [^S.] ;

Cifra ::= z: 0 | nz: >(1| 2 | 3 | 4 | 5 | 6 | 7 | 8 | 9) ;
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

**PRODUCE**

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
0
1
23
23081993
112358
20020723
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

ecc.

L’operatore punto non seguito da alcuna etichetta provoca l’azzeramento della serie di selezioni attive in un dato momento della generazione; in altre parole, permette di non propagare oltre le etichette selezionate fino a quel punto della generazione.

## Maiuscole

È spesso desiderabile, per motivi essenzialmente di forma, rispettare le regole ortografiche di scrittura delle lettere maiuscole, ad esempio, dopo il punto.

D’altro canto però l’architettura stessa di una grammattica assai complessa, provvista di produzioni ricorsive che generano subordinate, potrebbe rendere impossibile tale operazione, a meno di riscrivere parte del sorgente.

A tale proposito il linguaggio mette a disposizione la parola chiave **backslash** `\` che istruisce il programma a trasformare in maiuscola (nel caso in cui già non lo sia) la prima lettera del simbolo terminale immediatamente successivo.

**ESEMPIO**

!Polygen
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
S ::= \ pippo (e' | "." \) Eulogia ^ "." ;

Eulogia ::= proprio un bell'uomo
         |  davvero un signore ;
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

**PRODUCE**

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Pippo e' proprio un bell'uomo.
Pippo. Proprio un bell'uomo.
Pippo e' davvero un signore.
Pippo. Davvero un signore.
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Si badi che l'azione dell'operatore `\` persiste fino al successivo simbolo terminale risultato della produzione, pertanto ogni altro atomo (epsilon, concatenazione o l'operatore `\` stesso) che si interpone agirà come di consueto:

**ESEMPIO**

!Polygen
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
S ::= a \ ^ \ _ b
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

**PRODUCE**

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
aB
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

## Permutazioni {#sec:permutazioni}

In molte lingue è possibile cambiare l'ordine delle parole (o di gruppi di parole) in una frase senza che il significato cambi; a livello macroscopico, analogamente, è talvolta possibile cambiare l'ordine delle frasi in un discorso.

Per evitare che l'utente debba scrivere più volte la stessa sequenza con alcuni atomi cambiati di posizione, è possibile specificare tra __parentesi graffe__ `{` e` }` sottoproduzioni che vengono automaticamente sottoposte ad una permutazione.

**ESEMPIO**

!Polygen
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
S ::= se {e'} {quindi} {egli} ;
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

**PRODUCE**

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
se e' quindi egli
se e' egli quindi
se egli e' quindi
se egli quindi e'
se quindi egli e'
se quindi e' egli
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Si badi che la permutabilità di una sottoproduzione si riferisce alla sola sequenza di cui fa parte: specificare sottoproduzioni permutabili in sottosequenze (o altre sottoproduzioni --- permutabili o meno) differenti non consente la permutazione. Si noti la differenza tra i due esempi a venire:

**ESEMPIO**

!Polygen
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
S ::= {tra 10 minuti}^, {alle 3 in punto}^, {{io} {partiro'} solo} ;
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

**PRODUCE**

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
tra 10 minuti, alle 3 in punto, io partiro' solo
alle 3 in punto, tra 10 minuti, io partiro' solo
tra 10 minuti, io partiro' solo, alle 3 in punto
alle 3 in punto, io partiro' solo, tra 10 minuti
io partiro' solo, tra 10 minuti, alle 3 in punto
io partiro' solo, alle 3 in punto, tra 10 minuti
tra 10 minuti, alle 3 in punto, partiro' io solo
alle 3 in punto, tra 10 minuti, partiro' io solo
tra 10 minuti, partiro' io solo, alle 3 in punto
alle 3 in punto, partiro' io solo, tra 10 minuti
partiro' io solo, tra 10 minuti, alle 3 in punto
partiro' io solo, alle 3 in punto, tra 10 minuti
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

**ESEMPIO**

!Polygen
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
S ::= {tra 10 minuti}^, {alle 3 in punto}^, ({io} {partiro'} solo) ;
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

**PRODUCE**

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
tra 10 minuti, alle 3 in punto, io partiro' solo
alle 3 in punto, tra 10 minuti, io partiro' solo
tra 10 minuti, alle 3 in punto, partiro' io solo
alle 3 in punto, tra 10 minuti, partiro' io solo
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

## Unfolding in profondità {#sec:unfolding-profondita}

È possibile operare l'unfolding in profondità di una sottoproduzione specificata tra doppie parentesi acute rivolte verso l'interno `>>` e `<<`: ciascun atomo, a qualunque livello, per cui ha senso l'unfolding (vedi [@sec:unfolding]) è soggetto ad un unfolding appunto. Il risultato è l'appiattimento totale di qualunque sottoproduzione e simbolo non terminale specificati all'interno delle doppie parentesi acute:

**ESEMPIO**

!Polygen
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
S ::= senti >> M: ( il (cane| gatto (soriano | persiano) | colibri')
                  | lo (storione
                  | sciacallo)
                  )
             | F: la (pecora | raganella | Animale)
            << ;

Animale ::= capra | mucca da (latte | carne) ;
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Il simbolo non terminale `S` viene tradotto in:

!Polygen
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
S ::= senti ( M: il cane
            | M: il gatto soriano
            | M: il gatto persiano
            | M: il colibri'
            | M: lo storione
            | M: lo sciacallo
            | F: la pecora
            | F: la raganella
            | F: la capra
            | F: la mucca da (latte | carne)
            ) ;
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

L'unfolding in profondità viene tradotto quindi in una sottoproduzione al cui interno tutto viene appiattito ricorsivamente, ad esclusione delle produzioni associate ai simboli non terminali. Ciò è dovuto al fatto che l'operazione consiste di fatto nell'unfolding semplice di ogni atomo per cui tale operazione abbia senso: mentre quindi anche i simboli non terminali sono soggetti a tale trattamento, le produzioni ad essi associate invece non vengono toccate. Tale politica, sebbene possa apparire di primo acchito ingiustificata, permette invero all'utente di specificare un qualunque simbolo non terminale all'interno di una sottoproduzione tra doppie parentesi acute senza dare luogo inavvertitamente ad una serie enorme di unfolding o, ancor peggio, ad unfolding ciclici (vedi [@sec:unfolding-ricorsivi]).

## Folding

L'unfolding in profondità descritto in [@sec:unfolding-profondita] può talvolta non essere completamente desiderabile: se nella maggior parte dei casi esso è utilizzato per evitare di specificare esplicitamente l'operatore `>` per ogni sottoproduzione o simbolo non terminale di una sottoproduzione, non sempre è possibile tuttavia operare ricorsivamente l'unfolding di ogni singolo atomo senza dare luogo ad errori. Il linguaggio supportato dal _Polygen_ permette a tale proposito di __bloccare__ l'unfolding (di un atomo per cui tale operazione avrebbe senso) tramite l'operatore prefisso `<`.

**ESEMPIO**

!Polygen
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
S ::= senti >> M: ( il (cane | gatto <(soriano | persiano) | colibri')
                  |lo (storione | sciacallo)
                  )
             | F: la (pecora | raganella)
            << ;
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

in cui il simbolo non terminale `S` viene tradotto in:

!Polygen
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
S ::= senti ( M: il cane
            | M: il gatto (soriano | persiano)
            | M: il colibri'
            | M: lo storione
            | M: lo sciacallo
            | F: la pecora
            | F: la raganella
            ) ;
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Si badi che, come dalle regole in [@sec:sintassi-concreta], sono errori sintattici il folding di un unfolding e viceversa.

## Binding {#sec:binding}

Un binding in generale è un costrutto dichiarativo che associa una serie di produzioni ad un simbolo non terminale. Ogni binding introduce nell'ambiente (si veda la [@sec:ambienti-scoping]) tale associazione ed ogni produzione generata in tale ambiente può fare riferimento a tali simboli non terminali.

### Chiusure {#sec:chiusure}

La parola chiave `::=` introduce un binding, già ampiamente discusso in questo manuale, cosiddetto _debole_ o _chiusura_.

**ESEMPIO**

!Polygen
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
S ::= Frutto e Frutto ;

Frutto ::= la mela | il mango | l'arancia ;
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

**PRODUCE**

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
la mela e la mela
la mela e il mango
la mela e l'arancia
il mango e la mela
il mango e il mango
il mango e l'arancia
l'arancia e la mela
l'arancia e il mango
l'arancia e l'arancia
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

La produzione associata a `Frutto` __non__ subisce una generazione immediata ma viene chiusa insieme all'ambiente corrente secondo le regole di scoping. Ogni occorrenza del simbolo `Frutto` in un ambiente discendente (od il medesimo, come nell'esempio) provoca la generazione della produzione associata nell'ambiente chiuso assieme ad essa.

### Sospensioni {#sec:sospensioni}

La parola chiave `:=` introduce una seconda forma di binding detta _forte_ o _sospensione_ o _assegnazione_.

**ESEMPIO**

!Polygen
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
S ::= Frutto e Frutto ;

Frutto := la mela | il mango | l'arancia ;
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

**PRODUCE**

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
la mela e la mela
il mango e il mango
l'arancio e l'arancio
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

La produzione associata a `Frutto` viene sospesa e chiusa insieme all'ambiente corrente secondo le regole di scoping. Durante la generazione, alla prima occorrenza del simbolo `Frutto` in un ambiente discendente (od il medesimo, come nell'esempio) la produzione associata viene generata __una sola volta__ nell'ambiente chiuso assieme ad essa ed il risultato, immodificabile, della generazione risposto nell'ambiente; ogni successiva occorrenza dello stesso non terminale produrrà sempre lo stesso risultato.

Si badi che la prima generazione avviene in un ambiente in cui il simbolo non terminale in questione è associato alla chiusura, non ancora ad una sospensione: in tal modo è possibile fare uso di ricorsione anche definendo binding forti.

**ESEMPIO**

!Polygen
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
S ::= A A ;

A := a | a ^ A ;
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

**PRODUCE**

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
a a
aa aa
aaa aaa
aaaa aaaa
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

ecc.

## Ambienti e Scoping {#sec:ambienti-scoping}

L’ambiente è il contesto, l’insieme dei binding (vedi [@sec:binding]), ovvero delle associazioni da simbolo non terminale a serie produzioni. Tale ambiente può essere arricchito dai binding a top-level oppure da quelli introdotti dai costrutti di scoping.

### Ambiente a top-level

In gran parte di questo manuale si è parlato di binding (di qualsivoglia forma) introdotti a top-level del file sorgente, separati dalla parola chiave `;`. Com’è già stato accennato e come è ragionevole aspettarsi, tali binding vengono introdotti nell’ambiente (vuoto) secondo un rapporto di mutua ricorsione: ciascuna produzione legata ad un non terminale può infatti fare riferimento a qualunque simbolo non terminale definito a top-level, a monte o a valle, incluso quello a cui essa stessa è legata.

**ESEMPIO**

!Polygen
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
S ::= S | A | B | s ;

A ::= S | A | B | a ;

B :=  S | A | B | b ;
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

È facile immaginare quale sia la potenza offerta da questa politica.

### Ambienti locali

È possibile introdurre nuovi binding aventi visibiltà locale all’apertura di una sottoproduzione di qualunque forma: il corpo della sottoproduzione (che consiste in un serie di produzioni) può essere preceduto da una serie di binding separati dalla parola chiave `;`, la cui ultima occorrenza separa l’ultimo binding dal corpo.

**ESEMPIO**

!Polygen
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
S ::= sono (X := Agg; Molto ::= molto [Molto]; X ^ "," anzi Molto X | decisamente Molto Agg) e Agg ;

Agg ::= bello | simpatico ;
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

**PRODUCE**

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
sono bello, anzi molto bello e simpatico
sono bello, anzi molto bello e bello
sono bello, anzi molto ... bello e simpatico
sono bello, anzi molto ... bello e bello
sono simpatico, anzi molto simpatico e bello
sono simpatico, anzi molto simpatico e simpatico
sono simpatico, anzi molto ... simpatico e bello
sono simpatico, anzi molto ... simpatico e simpatico
sono decisamente molto bello e simpatico
sono decisamente molto bello e bello
sono decisamente molto .. bello e simpatico
sono decisamente molto .. bello e bello
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Dall’esempio risulta chiara la visibilità, ovvero lo scope, dei vari simboli non terminali: `X` e `Molto` sono locali alla sottoproduzione che li definisce, mentre `Agg` è utlizzato sia dal corpo di tale sottoproduzione che dal corpo di `S`.

Si faccia caso all’utilizzo del costrutto di scoping in congiunzione con il binding forte (vedi [@sec:sospensioni]): `X` è un simbolo introdotto localmente il cui unisco scopo è in qualche modo _fissare_ la generazione di `Agg`, che nell’ambiente a top-level è definita tramite un binding debole (vedi [@sec:chiusure]): in generale l’utilizzo degli scope assieme alle varie forme di binding aggiunge molta potenza al linguaggio ed aumenta le possibilità di ingegnerizzazione di una grammatica.

Si noti, ancora, che nell’esempio di cui sopra non c’è utilizzo del rapporto di mutua ricorsione dei binding locali, pertanto il medesimo risultato sarebbe stato ottenibile innestando 2 _scope_:

**ESEMPIO**

!Polygen
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
S ::= sono (X := Agg; (Molto ::= molto [Molto]; X ^ "," anzi Molto X | decisamente Molto Agg)) e Agg ;

Agg ::= bello | simpatico ;
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Nulla vieta che il corpo di una sottoproduzione possa essere a sua volta una sottoproduzione, ovviamente: ciò dà luogo all’arricchimento dell’ambiente senza porre in rapporto di mutua ricorsione i binding.

Si ricordi infine che __qualunque__ tipo di sottoproduzione può introdurre binding locali.

### Scoping statico lessicale

Le regole di scoping sono al contempo rigide e intuitive: ogni produzione viene generata nell’ambiente in cui è stata definita. Sebbene quindi gli ambienti siano arricchibili tramite binding locali innestati, __non__ è possibile generare una produzione definita altrove utilizzando simboli nell’ambiente corrente __anche __ nel caso in cui tali simboli abbiano lo stesso nome.

**ESEMPIO**

!Polygen
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
S ::= (X ::= a | b; A) ;

A ::= X X ;

X := x | y ;
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

**PRODUCE**

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
x x
y y
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Per definizione di scoping __statico__, il binding locale di `X` nella sottoproduzione di `S` non ha alcun effetto sulla generazione di `A`, che è stata _chiusa_ assieme all’ambiente in cui è stata definita (vedi [@sec:chiusure]), ovvero quello a top-level, in cui la `X` è legata alla produzione `x | y`.

Ancora, le regole di scoping lessicale consentono l'__overriding__ (o __shadowing__) dei binding:

**ESEMPIO**

!Polygen
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
S ::= (X ::= a | b; (X ::= x | y; X)) ;
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

**PRODUCE**

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
x
y
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

All’interno della seconda sottoproduzione innestata non c’è visibilità della definizione esterna di `X`. Le medesime regole si applicano ovviamente anche all’ambiente top-level.

Si badi infine che i binding sono ricorsivi, pertanto non è possibile fare riferimento alla definizione di un simbolo nell’ambiente in una ridefinizione in override del medesimo simbolo.

**ESEMPIO**

!Polygen
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
S ::= (X ::= a | b; (X ::= x [X]; X)) ;
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

**PRODUCE**

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
x
x x
x x x ...
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

L’occorrenza di `X` nel secondo binding innestato viene dunque vista come una ricorsione, non come un riferimento alla `X` dell’ambiente padre.

Analogamente in presenza di una serie di binding in rapporto di mutua ricorsione:

**ESEMPIO**

!Polygen
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
S ::= (X ::= x [A]; A ::= a [X]; (X ::= y [A]; A ::= b [X]; X)) ;
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

**PRODUCE**

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
y b
y b y b
y b y b y b ...
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

## Generazione posizionale

Sebbene il sistema di etichette sia piuttosto potente e versatile, nella maggior parte delle circostanze esso torna utile quale semplice _filtro_ su una serie di produzioni che specificano casi sintattici disgiunti di una data lingua; esempi frequenti possono essere desinenze per articoli, sostantivi e aggettivi in base al genere ed al numero, oppure coniugazioni di verbi in base alla persona, al tempo ed al modo.

Ciò che ragionevolmente si vuole dal sistema è poter attivare un’etichetta, ad esempio, per il genere e che la generazione abbia poi luogo coerentemente. Talvolta si desidera tale effetto solamente per una frase:

**ESEMPIO**

!Polygen
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
S ::= (sei (M: un | F: una) (M: bel | F: bella) ragazz ^ (M: o | F: a)).(M|F) ;
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

**PRODUCE**

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
sei un bel ragazzo
sei una bella ragazza
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Per ovviare alla scomodità di dover specificare etichette locali ed attivarle in loco, il linguaggio fornisce un sistema di generazione posizionale automatica. Con tale caratteristica (operativamente equivalente all'utilizzo di etichette e selezione, ma più concisa) è possibile esprimere in maniera molto sintetica gruppi di desinenze, declinazioni, coniugazioni, ecc. La parola chiave `,` separa gli atomi che rappresentano le possibili scelte:

**ESEMPIO**

!Polygen
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
S ::= sei un,una  bel,bella ragazz ^ o,a ;
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Il risultato è identico a quello dell'esempio più verboso; la differenza consiste nel fatto che non c'è menzione ad alcuna etichetta: come dalle regole di traduzione in [@sec:regole-traduzione], ogni produzione che presenta gruppi di atomi separati da `,` viene tradotta in una sottoproduzione che consiste in tante produzioni separate da  `|` quanti sono gli atomi nel gruppo e dove ognuna di tali produzioni presenta l'__i__-esimo atomo di ogni gruppo, per ogni __i__. L'esempio di cui sopra viene tradotto in:

!Polygen
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
S ::= sei un bel ragazz ^ o | sei una bella ragazz ^ a ;
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

L'unico limite di questa caratteristica è ovviamente che tutti i gruppi di una produzione raccolgano __lo stesso numero di atomi__. Si badi inoltre che lo _scope_ di tale vincolo è un singola produzione.

È importante capire che la generazione posizionale non sostituisce il sistema di label, ma offre un'alternativa sintetica ad esso nei frequenti casi in cui verrebbe utilizzato per declinare termini. Non è difficile immaginare comunque come tale meccanismo possa tornare utile in altri contesti; ad esempio, a livello macroscopico, per specificare relazioni tra porzioni di una frase:

**ESEMPIO**

!Polygen
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
S ::= non potro',(ho potuto) mai,_ venire da te ;
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

**PRODUCE**

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
non potro' mai venire da te
non ho potuto venire da te
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

## Iterazione

Sebbene grazie ai costrutti di scoping ([vedi @sec:ambienti-scoping]) sia possibile iterare una produzione in maniera molto semplice e concisa, un apposito costrutto di iterazione analogo alla [chiusura di Kleene] di EBNF può risultare talvolta assai comodo:

**ESEMPIO**

!Polygen
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
S ::= una ragazza m^ (o^)+ lto carina ;
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

**PRODUCE**

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
una ragazza molto carina
una ragazza moolto carina
una ragazza mooolto carina
...
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Com'è ragionevole aspettarsi, qualunque produzione può essere presente all'interno della sottoproduzione iterata:

**ESEMPIO**

!Polygen
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
S ::= (a | b)+ ;
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

**PRODUCE**

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
a
b
a a
a b
b a
b b
a a a
a a b
a b a
...
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Si potrebbe ritenere ragionevole che venisse iterata sempre la stessa generazione, ma non è così (come dalle [regole di traduzione @sec:regole-traduzione]), poiché nella maggior parte dei frangenti il comportamento di cui sopra è preferibile ed inoltre semanticamente affine all'analogo costrutto EBNF. È possibile tuttavia ottenere l'effetto ipotizzato in maniera piuttosto semplice sfruttando il binding forte (vedi [@sec:sospensioni]):

**ESEMPIO**

!Polygen
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
S ::= (X := a | b; (X)+) ;
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

**PRODUCE**

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
a
b
a a
b b
a a a ...
b b b ...
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# Tecniche avanzate

## Ricorsione

È possibile specificare in una produzione il simbolo che si sta definendo per ottenere una generazione ricorsiva:

**ESEMPIO**

!Polygen
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
S ::= Cifra [^ S] ;

Cifra ::= 0 | 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 | 9 ;
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

**PRODUCE**

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
0
23
853211
000000
00011122335
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

ecc.

ovvero un numero composto da un numero casuale di cifre da 0 a 9.

Si provi per esercizio a definire una grammatica che generi frasi di lunghezza variabile agganciando subordinate ricorsivamente.

## Raggruppamento

Per avere un controllo della distribuzione delle probabilità superiore a quello offerto dalle caratteristiche descritte nelle sezioni [-@sec:controllo-probabilita] e [-@sec:unfolding] è possibile utilizzare opportunamente le parentesi tonde:

**ESEMPIO**

!Polygen
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
S1 ::= gatto | cane | cammello ;

S2 ::= gatto | (cane | cammello) ;
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

**PRODUCE**

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
gatto
cane
cammello
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Nella definizione di `S1` la distribuzione delle probabilità è:

|            |     |
|------------|-----|
| `gatto`    | 1/3 |
| `cane`     | 1/3 |
| `cammello` | 1/3 |

Nel caso di `S2` invece:

|            |                  |
|------------|------------------|
| `gatto`    | 1/2              |
| `cane`     | 1/2 \* 1/2 = 1/4 |
| `cammello` | 1/2 \* 1/2 = 1/4 |

## Controllo della probabilità di una sottoproduzione opzionale {#sec:controllo-probabilita-opzionale}

Il linguaggio di definizione delle grammatiche riconosciuto dal *Polygen* non permette il diretto controllo della probabilità con cui una sottoproduzione opzionale viene generata. In altre parole, non esiste un operatore analogo al `+` o al `-` per le sottoproduzioni tra parentesi quadrate.

Esiste tuttavia una tecnica assai semplice per ottenere questo risultato:

**ESEMPIO**

!Polygen
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
S ::= la (+ _  | bella) casa ;
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

**PRODUCE**

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
la casa
la bella casa
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Poiché una sottoproduzione opzionale è di fatto equivalente ad una sottoproduzione non opzionale che genera l'output desiderato oppure nulla (vedi la [@sec:epsilon]), è possibile operare manualmente tale traduzione ed utilizzare la `+` o la `-` a piacere.

Nell'esempio di cui sopra la probabilità che non venga prodotto nulla è maggiore di quella per cui venga prodotta `bella`.

# Controllo statico di una grammatica

Il _Polygen_ dispone di un potente algoritmo di controllo statico di un file sorgente: è pertanto in grado di verificare in un tempo finito la correttezza di un'intera grammatica senza dover generare ogni produzione possibile ed indipendentemente dalla complessità delle definizioni.

Una grammatica che passa con successo la fase di controllo è garantita generare sempre un output valido --- come una sorta di prova di _soundness_.

Poiché quindi la fase di controllo precede sempre quella di generazione, se il programma produce un output senza messaggi d'errore, allora la grammatica è interamente corretta.

Laddove specificato dal messaggio generato dal programma, warning ed errori si riferiscono ad un'area del file di testo sorgente compresa tra due coppie di coordinate che esprimono un numero di linea ed un numero di colonna.

## Errori

Sono classificati come errori quei casi che infrangono la definizione di correttezza di una grammatica.

Un errore arresta l'esecuzione del programma.

### Inesistenza di simboli non terminali

Viene controllata l'esistenza di ciascun simbolo non terminale che appare nella parte destra di una definizione, al fine di evitare che erroneamente vengano utilizzati nelle produzioni simboli non terminali che non sono stati definiti.

**ESEMPIO**

!Polygen
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
S ::= A | B ;

A ::= a ;
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Questa grammatica dà luogo ad un errore, in quanto `B` non è definito.

### Ricorsioni cicliche e non-terminazione

L'algoritmo di controllo è in grado di verificare che ciascun simbolo non terminale sia in grado di produrre un output, ovvero che la generazione prima o poi termini senza dare luogo a ricorsioni infinite.

**ESEMPIO**

!Polygen
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
S ::= S | A ;
A ::= B ;
B ::= S | A ;
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Questa grammatica non potrebbe produrre alcun output, poiché la generazione, indipendentemente da quale simbolo non terminale abbia inizio, incorrerebbe in un ciclo ricorsivo infinito.

Altri casi più subdoli possono dare luogo a sottocicli:

!Polygen
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
S ::= a | A ;
A ::= B ;
B ::= A ;
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Sebbene in tale frangente la generazione non dia necessariamente luogo ad una ricorsione infinita grazie alla presenza del simbolo terminale `a`, è virtualmente possibile che la generazione non termini. Casi simili sono segnalati da un messaggio di errore.


### Unfolding ricorsivi {#sec:unfolding-ricorsivi}

Non è lecito prefiggere l'operatore `>` di unfolding (vedi la [@sec:simboli-non-terminali]) ad un simbolo non terminale che produrrebbe una ricorsione ciclica.

**ESEMPIO**

!Polygen
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
S ::= >A ;
A ::= >B ;
B ::= >S ;
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Tale grammatica darebbe luogo ad una serie di unfolding che la espanderebbero all’infinito e, pertanto, genera un messaggio d’errore.

### Epsilon-produzioni {#sec:epsilon-produzioni}

È possibile che una grammatica soddisfi la clausola di terminazione grazie ad una epsilon-produzione, ovvero che l’unico output possibile sia epsilon (si veda la [@sec:epsilon]).

In tali casi si è in presenza di una grammatica considerata scorretta:

**ESEMPIO**

!Polygen
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
S ::= A ;

A ::= A ^ | _ ;
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

**PRODUCE**

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
_
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Anche una selezione distruttiva ([vedi @sec:selezione-distruttiva]) in taluni frangenti può dare luogo ad una epsilon-produzione.

### Ridefinizione di simboli non terminali

Viene verificato che uno stesso simbolo non terminale non venga accidentalmente definito più volte nello scope.

**ESEMPIO**

!Polygen
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
A ::= mela | pera | capra ;

A ::= mandarino | anguria ;
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

La cosa vale anche all’interno di scope innestati (vedi [@sec:ambienti-scoping]):

**ESEMPIO**

!Polygen
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
S ::= (A ::= mela | pera | capra ; A ::= mandarino | anguria ; il A) ;
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

### Carattere illegale

Propriamente si tratta di un errore generato dal lexer nel caso in cui, in fase di analisi sintattica del file sorgente, si imbatta in un carattere che non appartiene ad alcun token riconosciuto --- ovvero non definito dalle regole lessicali di cui in [@sec:regole-lessicali].

### Token inaspettato

Si tratta propriamente di un errore generato dal parser nel caso in cui, in fase di analisi sintattica del file sorgente, si imbatta in un token sì valido ma che non dovrebbe trovarsi in tale posizione --- ad indicare pertanto un'infrazione delle regole sintattiche di cui in [@sec:sintassi-concreta].

## Warning

Sono classificati come warning quei casi che non infrangono la definizione di correttezza di una grammatica, ma che possono portare ad effetti inaspettati o indesiderati. La presenza di messaggi di warning dunque non indica che la grammatica sia scorretta, ma che è poco robusta; tant'è che un warning non arresta l'esecuzione del programma.

I warning sono suddivisi in livelli dipendentemente dalla gravità: più basso è il livello, più gravi sono i warning raggruppati in esso; al livello 0 appartengono quei warning che non possono essere ignorati (pur continuando a non rappresentare un pericolo per la generazione).

### Livello 0

Per ora non esistono warning appatenenti a questo gruppo.

### Livello 1

#### Inesistenza del simbolo `I`

La mancata definizione del simbolo non terminale `I` non permette l'utilizzo dell'opzione `-info` del programma.

Tale simbolo tipicamente specifica una stringa informativa sulla grammatica (autore, titolo, ecc.) e, sebbene non sia di per sè un errore ometterlo, è buona norma aderire a tale convenzione definendolo opportunamente.

#### Potenziali epsilon-produzioni {#sec:potenziali-epsilon-produzioni}

Esistono casi in cui una grammatica non genera in ogni caso epsilon (si veda la [@sec:epsilon-produzioni]), ma solo potenzialmente.

**ESEMPIO**

!Polygen
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
S ::= [a] ;
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

**PRODUCE**

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
a
_
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Anche alcune situazioni di selezione distruttiva ([vedi @sec:selezione-distruttiva]) portano a potenziali epsilon-produzioni.

#### Selezione distruttiva {#sec:selezione-distruttiva}

Non è infrequente, nei casi di utilizzo massiccio della selezione ([vedi @sec:etichette-selezione]), perdere il controllo della propagazione delle etichette e scordarsi di attivarle o attivare quelle sbagliate. In tali situazioni il risultato è la distruzione delle produzioni che dipendono dall’attivazione di tali etichette, con conseguenti epsilon-produzioni.

I casi fortunati in cui tale distruzione riguarda un’intera produzione vengono regolarmente segnalati da un warning ([-@sec:potenziali-epsilon-produzioni]) o un errore ([-@sec:epsilon-produzioni]), ma nel caso in cui le produzioni distrutte siano all’interno di una sequenza non ci sarebbe modo, tramite solamente l’algoritmo di controllo delle epsilon-produzioni, di rilevare il problema, poiché di fatto non si è in presenza di epsilon-produzioni:

**ESEMPIO**

!Polygen
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
S ::= a A.z ;

A ::= x: x | y: y ;
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

**PRODUCE**

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
a
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Quando _Polygen_ indvidua una selezione distruttiva, genera un warning apposito che notifica l'utente del problema. Si badi che la correzione di tutti i warning di questo tipo irrobustiscono di molto una grammatica e talvolta possono aiutare persino a rilevare utilizzi concettualmente scorretti delle etichette.

### Livello 2

#### Permutazione inutile

Nel caso in cui in una sequenza appaia una sola sottoproduzione permutabile (si veda la [@sec:permutazioni]), non avviene di fatto alcuna permutazione per ovvi motivi.

**ESEMPIO**

!Polygen
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
S ::= a {b} c ;
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Sebbene una simile situazione non sia propriamente un errore, viene generato un messaggio di warning di bassa gravità.

#### Unfolding inutile

I casi in cui l'operatore di unfolding sia utilizzato in contesti --- pur non scorretti --- che non darebbero di fatto luogo ad alcun unfolding vengono segnalati da un warning di bassa gravità.

**ESEMPIO**

!Polygen
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
S ::= >(b c) ;
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

L'unfolding di una sottoproduzione costituita da una singola produzione è un caso di unfolding inutile.

### Livello 3

#### Unfolding di un simbolo legato ad un'assegnazione

L'unfolding di un simbolo legato da un binding forte (vedi [@sec:sospensioni]) è sintatticamente legale e semanticamente corretto; tuttavia potrebbe suscitare qualche perplessità concettuale. Il risultato è in qualche modo simile al concetto di _ereditarietà_: facendo sì che il preprocessore replichi le produzioni legate al simbolo in questione e le inserisca, appiattendole (vedi [@sec:simboli-non-terminali]), all'interno di un'altra produzione è equivalente a _ereditare_ le produzioni di tale simbolo per fare in modo che possano generare qualcosa di diverso.

**ESEMPIO**

!Polygen
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
S ::= >A A A ;

A := a | b ;
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

**PRODUCE**

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
a a a
b a a
a b b
b b b
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Tale trucco rappresenta però in qualche modo un abuso dell'unfolding e viene pertanto segnalato da un warning a bassissima gravità.

# Appendice

## Sintassi concreta {#sec:sintassi-concreta}

Segue la sintassi concreta in notazione _EBNF_ del linguaggio (di _[tipo-2]_) di definizione di grammatiche interpretato dal _Polygen_ e descritto in questo documento.

I simboli non terminali associati a produzioni sono interamente maiuscoli; i simboli non terminali associati ad espressioni regolari cominciano per lettera minuscola  (si veda la [@sec:regole-lessicali]); i simboli terminali sono tra virgolette; `S` è il simbolo non terminale iniziale.

!comment
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
INCLUDE "Concrete syntax" (EBNF Rules) from external file.
        (same file shared by all versions of the manual)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

!include(polygen-spec_inc_con.markdown)

## Sintassi astratta

Per completezza riportiamo di seguito la sintassi astratta del linguaggio interpretato dal *Polygen* libero dagli zuccheri sintattici e dai termini che interessano solamente la fase di preprocessing (si consulti la [@sec:regole-traduzione] per le regole di traduzione).

!comment
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
INCLUDE "Abstract syntax" (EBNF Rules) from external file.
        (same file shared by all versions of the manual)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

!include(polygen-spec_inc_abs.markdown)

## Regole lessicali {#sec:regole-lessicali}

Seguono le regole lessicali in notazione di espressioni regolari di _tipo-3_.

!comment
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
INCLUDE "Lexical rules" (EBNF Rules) from external file.
        (same file shared by all versions of the manual)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

!include(polygen-spec_inc_lex.markdown)

Si badi che anche il carattere di spazio può essere specificato tra virgolette come simbolo terminale.

## Sequenze escape

L'espressione regolare `Term` di cui in [@sec:regole-lessicali] riconosce tra virgolette il backslash `\`, che funge da carattere escape. È possibile che un simbolo terminale tra virgolette contenga sequenze escape tra le seguenti:

|        |                             |
|--------|-----------------------------|
| `\\`   | backslash                   |
| `\"`   | virgolette                  |
| `\n`   | new line                    |
| `\r`   | carriage return             |
| `\b`   | backspace                   |
| `\t`   | tab                         |
| `\xyz` | codice ASCII decimale _xyz_ |

## Regole di traduzione {#sec:regole-traduzione}

Come riferimento formale riportiamo le regole di traduzione da sintassi concreta a sintassi astratta in ordine di precedenza (dove ovvero la traduzione _i_-esima ha luogo prima della _i+1_-esima). Esse rappresentano quanto operato dal parser nel caso di zuccheri sintattici o dal preprocessore altrimenti.

!comment
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
INCLUDE TABLES: 4.1.5 Regole di traduzione
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

!include(polygen-spec_IT_inc_tables.markdown)

!comment
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-----------------------------{ END OF DOCUMENT }------------------------------
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

[GNU General Public License]: https://www.gnu.org/licenses/old-licenses/gpl-2.0.en.html "Visita la pagina ufficiale della GNU GPLv2 su www.gnu.org"

[chiusura di Kleene]: https://it.wikipedia.org/wiki/Star_di_Kleene "Vedi pagina 'Star di Kleene' su Wikipedia"

[Extended Backus Naur Form]: https://it.wikipedia.org/wiki/EBNF "Vedi pagina 'Extended Backus–Naur form' su Wikipedia"

[tipo-2]: https://it.wikipedia.org/wiki/Gerarchia_di_Chomsky "Vedi pagina 'Gerarchia di Chomsky' su Wikipedia"

[Tristano Ajmone]: https://github.com/tajmone "Visita il profilo GitHub di Tristano Ajmone"

!comment
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
                                  CHANGELOG
==============================================================================
v1.1.0 (2018-02-10) | PML 1.0 | Polygen v1.0.6
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
