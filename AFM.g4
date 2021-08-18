grammar AFM;

//parser rules

//model
feature_model:
	relationships_block attributes_block? constraints_block?;

//relationships block

relationships_block: '%Relationships' relationship_spec*;

relationship_spec:
	init_spec (non_cardinal_spec | cardinal_spec) ';';

init_spec: SPACE? WORD SPACE? ':' SPACE?;

obligatory_spec: SPACE? WORD SPACE?;
optional_spec: SPACE? '[' WORD ']' SPACE?;

non_cardinal_spec: (obligatory_spec | optional_spec)+;

cardinality: '[' INT ',' INT ']';
cardinal_spec:
	SPACE? cardinality SPACE? '{' obligatory_spec+ '}';

//attributes block

attributes_block: '%Attributes' attribute_spec*;

attribute_spec:
	attribute_name SPACE? ':' SPACE? attribute_domain SPACE? ',' SPACE? attribute_default_value
		SPACE? ',' SPACE? attribute_null_value ';';

attribute_name: WORD '.' LOWERCASE;

attribute_domain: (discrete_domain_spec | range_domain_spec);

discrete_domain_spec: '[' value_spec (',' value_spec)* ']';
range_domain_spec: SPACE? INTEGER SPACE? domain_range*;
domain_range: '[' INT SPACE? 'to' SPACE? INT ']';

attribute_default_value: value_spec;

attribute_null_value: value_spec;

value_spec: (WORD | LOWERCASE | INT | DOUBLE | STRING);

//constraints block

constraints_block: '%Constraints' constraint_spec*;

constraint_spec: brackets_spec | simple_spec;
brackets_spec:
	SPACE? WORD SPACE? '{' SPACE? simple_spec* SPACE? '}' SPACE?;
simple_spec: SPACE? expression SPACE? ';' SPACE?;

expression:
	SPACE? '(' expression ')' SPACE?			# parenthesisExp
	| NOT expression							# notExp
	| expression arithmetic_operator expression	# arithmeticExp
	| expression relational_operator expression	# relationalExp
	| expression AND expression					# andExp
	| expression OR expression					# orExp
	| expression logical_operator expression	# logicalExp
	| SPACE? (variable | number) SPACE?			# atom;

logical_operator: IFF | IMPLIES | REQUIRES | EXCLUDES;
arithmetic_operator: ADD | SUB | MULT | DIV | MOD | POW | ASIG;
relational_operator:
	HIGHER_THAN
	| LOWER_THAN
	| HIGHER_EQUAL_THAN
	| LOWER_EQUAL_THAN
	| EQUAL
	| DISTINCT;
number: INT | DOUBLE;
variable: WORD ('.' LOWERCASE)? | LOWERCASE;
//lexer rules

//arithmetic operators	
ADD: '+';
SUB: '-';
MULT: '*';
DIV: '/';
MOD: '%';
POW: '^';
ASIG: '=';

//prefix operators
ABS: 'abs';
MAX: 'max';
MIN: 'min';
COS: 'cos';
SIN: 'sin';
SUM: 'sum';

//logical operators

AND: 'AND';
OR: 'OR';
NOT: 'NOT';
IFF: 'IFF';
IMPLIES: 'IMPLIES';
REQUIRES: 'REQUIRES';
EXCLUDES: 'EXCLUDES';

//relational operators
HIGHER_THAN: '>';
LOWER_THAN: '<';
HIGHER_EQUAL_THAN: '>=';
LOWER_EQUAL_THAN: '<=';
EQUAL: '==';
DISTINCT: '!=';

INTEGER: 'Integer';

LOWERCASE: [a-z][a-z0-9]*;
WORD: [A-Z][a-zA-Z0-9]*;
INT: '0' | [1-9][0-9]*;
DOUBLE: [1-9][0-9]* '.' [0-9]+;
STRING: '"' (~'"')* '"';

SPACE: (' ' | '\t')+;
WS: [\n\r]+ -> skip;