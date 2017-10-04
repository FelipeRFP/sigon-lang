grammar Agent;

 

agent
	:
	  (context | bridgeRule)*
	  EOF
	;

 
context
	: contextName '(' param? ')' ':' formulas
	| PLANS '(' planType ')' ':' plansFormulas
	;

planType
	: ('prop' | 'fol')?
	;
	

param
	: type 
	;

	
contextName
	: primitiveContextName 
	| customContextName
;

primitiveContextName
	: (BELIEFS | DESIRES | INTENTIONS)
	;

customContextName
	:
	'_'(LCLETTER | UCLETTER)+ character*
	;


type
	: 'prop'
	| 'fol'
	| customType (',' semanticRules)
	;

customType
	: (LCLETTER | UCLETTER) character *
	;

 
//'plan' '(' somethingToBeTrue ',' compoundaction ',' preconditions ',' postconditions ')'
plan
	: 'plan' '(' listOfClauses ',' ('_' |compoundaction )',' ('_' | listOfClauses) ',' ('_' | listOfClauses) ')'
	;

//'action' '(' functionInvocation ',' preconditions ',' postconditions ')'
action
	: 'action' '(' functionInvocation ',' listOfClauses ',' listOfClauses ')'
	;

functionInvocation
	: functionName '(' argumentList? ')'
	;

functionName
	: LCLETTER + character*
	;

argumentList
	:	expression (',' expression)*
;

expression
	: STRING
	;

compoundaction
	: ('[' action (',' action)* ']')?;
	
listOfClauses
	: (propClause | ('[' propClause (',' propClause)* ']'))
	| (folClause | ('[' folClause (',' folClause)* ']'))
	;

formulas
	: propFormula*
	| folFormula*
	;
	
propFormula
	: ((propClause  | (propClause ':-' propLogExpr ))'.')
	;
	
folFormula
	: ((folClause | (folClause ':-' folLogExpr )) '.')
	;
		
plansFormulas
	: ((plan  | action )'.') *
	;	

bridgeRule
	:
	head ':-' body '.'
	;

head
	:
('!' (contextName | PLANS) '(' type ')' ) ('not')? (propClause | folClause)
;

body
	:
(contextName | PLANS) '(' type ')' (('not'? (propClause | folClause))
| plan) (('and'|'or')  (contextName | PLANS) '(' type ')' (('not'? (propClause | folClause)) |plan))*
	;




propClause
	: ('not')? constant*
	;

folClause
	: constant '(' (numeral | constant | variable | '_') (',' (numeral | constant | variable | '_') )* ')'
	;
	
numeral 
	: DIGIT+
	;

constant
	: LCLETTER character*
	;

variable
	: UCLETTER character*	
	;

propLogExpr
	: propLogExpr ('and' | 'or') propLogExpr
	| propClause
	;


folLogExpr
	: folLogExpr ('and' | 'or') folLogExpr
	| folClause
	;


character
    : LCLETTER | UCLETTER | DIGIT
    ;

/* Permiter que o usuário descreva a semântica da lógica.
*/

semanticRules
	: (LCLETTER | UCLETTER) character* '.semantic'
	;

STRING
	 : '"' (~[\r\n"] | '""')* '"'
 	 ;

BELIEFS
	: 'beliefs'
	;

DESIRES
	: 'desires'
	;

INTENTIONS
	: 'intentions'
	;
PLANS
	: 'plans'
	;
LCLETTER
    : [a-z_];

UCLETTER
    : [A-Z];

DIGIT
    : [0-9];

WS
   : [ \t\r\n] -> skip
;


BlockComment
    :   '/*' .*? '*/'
        -> skip
    ;

LineComment
    :   '//' ~[\r\n]*
        -> skip
;
