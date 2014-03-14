//  DADA ENGINE MODEL
//  five-paragraph essay
//  developed using online sample essays


#include <stdmap.pbi>

///////////////////////////////
//               //
//  ESSAY STRUCTURE      //
//               //
///////////////////////////////

output:
    PARA(intro-para)
    PARA(body-para)
    PARA(body-para)
    PARA(body-para)
    PARA(conc-para)
;


////////////////////////////////////
//                //
//  PARAGRAPH STRUCTURES      //
//                //
////////////////////////////////////

intro-para:
    topical-deep-sen>sen-format>cap-first
    topical-elaboration-sen>sen-format>cap-first
    topical-grounding-sen>sen-format>cap-first
    thesis-sen>sen-format>cap-first
;

body-para:
    topical-credible-sen>sen-format>cap-first
    scientific-sen>sen-format>cap-first
    scientific-sen>sen-format>cap-first
    topical-scientific-sen>sen-format>cap-first
    topical-cause-effect-sen>sen-format>cap-first
    topical-cause-effect-sen>sen-format>cap-first
    |
    topical-paren-sen>sen-format>cap-first
    topical-cause-effect-sen>sen-format>cap-first
    additional-sen>sen-format>cap-first
    personal-sen>sen-format>cap-first
    however-sen>sen-format>cap-first
    personal-sen>sen-format>cap-first
    topical-personal-sen>sen-format>cap-first
    balanced-sen>sen-format>cap-first
    personal-sen>sen-format>cap-first
    topical-cause-effect-sen>sen-format>cap-first
;

conc-para:
    topical-deep-sen>sen-format>cap-first
    however-sen>sen-format>cap-first
    topical-cause-effect-sen>sen-format>cap-first
    topical-deep-sen>sen-format>cap-first
    thesis-sen>sen-format>cap-first
;


///////////////////////////////////
//               //
//  SENTENCE STRUCTURES      //
//               //
///////////////////////////////////

generic-sen:
    topical-deep-sen | topical-elaboration-sen | topical-grounding-sen | topical-credible-sen |
    topical-paren-sen | scientific-sen | topical-scientific-sen | topical-cause-effect-sen
;

topical-deep-sen:
// Objectivity by researchers has not, and probably never will be attained.

    topic PP deep-VP-3rd |
    topic deep-VP-3rd
;

topical-elaboration-sen:
// People will always have biases; some will be created by cultural values and others by personal views.

    topical-broad-claim-clause>trim
    "; "
    dichotomy-clause
;

topical-grounding-sen:
// The search for objectivity lies in the realm of philosophy along with the search for reality.

    topical-complex-NP-sing "lies in " abstract-field and abstract-field
;

topical-credible-sen:
// As I have learned in my Theory of Knowledge class, perception and thought are intimately connected.

    credibility-clause>trim
    ", "
    topical-broad-claim-clause
;

topical-paren-sen:
// Discoveries, especially in the scientific realm, can be doubly affected by a lack of objectivity.

    NP-sing>trim ", " paren-clause>trim ", " topical-VP-3rd
    |
    topical-NP-sing>trim ", " paren-clause>trim ", " VP-3rd
;

thesis-sen:
// Even though objectivity can never be reached, people are better at making observations, discoveries, and decisions if they attempt to set aside their biases.

    although NP-any verb-aux verb-trans-inf NP-any>trim ", " topic "is both " adj "and " adj
    |
    because topic verb-trans-3rd complex-NP-pl>trim ", " humanity "should " verb-trans-inf topic "immediately "
    |
    consequently>trim ", " topic verb-aux "engender " complex-NP-pl
    |
    "instead of " VP-gerund>trim ", " topic "constitutes both a " adj noun-count "and a " adj noun-count
    |
    "why is " topic "so " adj "to " noun-uncount>trim "? The " answer "to this " question "is that " topic "is " AdjP
    |
    topic "is the most " AdjP noun-count "of " humanity
    |
    topic "is " AdjP due-to "its " complex-NP-pl
;

scientific-sen:
// The brain takes the input from the eyes and processes it to form an image.

    scientific-clause "to " scientific-VP-inf
    |
    although scientific-clause>trim ", " scientific-clause
;

topical-scientific-sen:
// That image is not the only thing the brain produces; it also provides extra information based on generalizations and biases.

    scientific-NP-sing "is not the only thing " scientific-NP-sing scientific-verb-intrans-3rd>trim "; it also " scientific-VP-3rd topical-PP
;

topical-cause-effect-sen:
// By attempting to reduce the addition of extraneous information being added to the observation, a true observation of an object can be more closely approximated.

    cause-clause>trim ", " topical-effect-clause
    |
    topical-complex-NP-sing "changes " topical-complex-NP-sing
    |
    topical-cause-clause>trim ", " topical-effect-clause
    |
    the-more-clause>trim ", " the-more-clause
;

additional-sen:
    additionally>trim ", " generic-sen
;

personal-sen:
// In a recent experiment in physics class, almost all of the students in my class analyzed the data incorrectly.

    in-my-experience-clause>trim ", " personal-clause
    |
    personal-NP-sing VP-3rd
;

however-sen:
// However, armed with the knowledge that zero percent error is never possible, we were satisfied with the results.

    however>trim ", " knowledge-clause>trim ", " personal-clause
    |
    NP-sing verb-aux>trim ", " however>trim ", be " standalone-AdjP
;

topical-personal-sen:
// A lack of objectivity can clearly be seen to be a problem in my last stud`ent council election as well.

    topical-complex-NP-sing VP-3rd personal-PP as-well |
    subsequently>trim ", " NP-sing VP-3rd personal-PP
;

balanced-sen:
// The most popular person was chosen for president, not the objectively best candidate.

    NP-sing VP-3rd>trim ", not " NP-sing
;

/////////////////////////////////
//                 //
//  CLAUSE STRUCTURES      //
//                 //
/////////////////////////////////

topical-broad-claim-clause:
// people will always have biases

    humanity "will always " topical-VP-inf |
    topic "is the most fundamental " noun-count "of " humanity
;

cause-clause:
// by attempting to reduce the addition of extraneous information being added to the observation

    due-to VP-gerund
;

topical-cause-clause:
// since scientific discoveries are based on observation

    because NP-pl "are " topical-AdjP
    |
    "if " NP-pl VP-inf
;

topical-effect-clause:
// a true observation of an object can be more closely approximated

    topical-complex-NP-sing "can be more " adverb verb-trans-inf>pastpart
    |
    complex-NP-pl verb-intrans-inf as-well topical-PP
;

dichotomy-clause:
// some will be created by cultural values and others by personal views

    "some " PP "and others " PP |
    "many " PP "but a few " PP |
    "whether " PP "or " PP
;

credibility-clause:
// as I have learned in my Theory of Knowledge class

    "as I have learned in my " academic-subject "class "
    |
    "according to professor of " academic-subject famous-name
;

scientific-clause:
// the brain takes the input from the eyes

    scientific-NP-sing scientific-VP-3rd
    |
    "the same " scientific-noun-count "may " scientific-verb-trans-inf "two different " scientific-NP-pl
;

paren-clause:
// especially in the scientific realm
    usually PP
;

in-my-experience-clause:
    "in my " academic-subject "class "
    |
    "in my experience "
;

personal-clause:
// almost all of the students in my class analyzed the data incorrectly
    
    all-of-the noun-count>plural personal-PP VP-inf
;

knowledge-clause:
// armed with the knowledge that zero percent error is never possible

    "armed with the knowledge that " NP-sing VP-3rd
    |
    "knowing that " NP-sing VP-3rd
;

the-more-clause:
// the less we allow bias to influence

    the-more NP-sing VP-3rd |
    the-more NP-pl VP-inf
;

/////////////////////////////////
//                 //
//  PHRASE STRUCTURES      //
//                 //
/////////////////////////////////

///////////
/// NPs ///
///////////

topical-NP-sing:

    topic |
    topical-complex-NP-sing
;

topical-complex-NP-sing:
// the search for objectivity

    NP-sing topical-PP |
    topic "which " VP-3rd |
    det AdjP topic |
    "a " quantity "of " topic
;

NP-any:
    NP-pl |
    NP-sing
;

NP-pl:
    
    noun-count>plural |
    complex-NP-pl
;

complex-NP-pl:

    NP-pl PP |
    NP-pl "which " VP-inf |
    AdjP noun-count>plural |
    all-of-the noun-count>plural |
    those involved
;

NP-sing:

    noun-uncount |
    det noun-count |
    complex-NP-sing
;

complex-NP-sing:
    
    NP-sing PP |
    NP-sing "that " VP-3rd |
    det AdjP noun-uncount
;

scientific-NP-pl:
    
    scientific-noun-count>plural |
    scientific-NP-pl PP
;

scientific-NP-sing:

    scientific-noun-uncount |
    det scientific-noun-count |
    scientific-NP-sing PP
;

personal-NP-sing:
// our personal belief in the validity of the method of analyzation we chose

    "our personal " noun-count prep "the " noun-count "we " verb-trans-inf |
    "my " noun-count
;

///////////
/// VPs ///
///////////

VP-inf:
    verb-intrans-inf |
    verb-trans-inf NP-pl |
    verb-trans-inf NP-sing |
    VP-inf conj VP-inf
;

/*complex-VP-inf:

;*/

VP-3rd:

    verb-intrans-3rd |
    verb-trans-3rd NP-pl |
    verb-trans-3rd NP-sing |
    "is " standalone-AdjP |
    verb-aux "be " NP-sing |
    verb-aux adverb "be " NP-sing |
    VP-3rd conj VP-3rd
;

/*complex-VP-3rd:

;*/

VP-gerund:

    verb-intrans-inf>gerund |
    verb-trans-inf>gerund NP-pl |
    verb-trans-inf>gerund NP-sing
;

scientific-VP-3rd:

    scientific-verb-intrans-3rd |
    scientific-verb-trans-3rd scientific-NP-sing |
    scientific-verb-trans-3rd scientific-NP-pl

;

scientific-VP-inf:
    
    scientific-verb-intrans-inf |
    scientific-verb-trans-inf scientific-NP-sing |
    scientific-verb-trans-inf scientific-NP-pl
;

deep-VP-3rd:
// has not, and probably never will be attained

    "has not, and " probably "never will be " standalone-AdjP |
    "will always be a " part "of " humanity
;

topical-VP-inf:
// have biases

    verb-trans-inf topic
;

topical-VP-3rd:
// can be doubly affected by a lack of objectivity

    verb-trans-3rd topical-NP-sing
    |
    verb-aux verb-trans-inf topical-NP-sing
    |
    verb-aux "be " standalone-AdjP topical-PP
;

/////////////
/// AdjPs ///
/////////////

topical-AdjP:
    verb-trans-inf>pastpart topical-PP
;

AdjP:
    adj |
    complex-AdjP
;

complex-AdjP:
    adverb adj |
    adverb conj adverb adj
;

standalone-AdjP:
    AdjP |
    complex-AdjP |
    adj>trim ", " adj>trim ", and " adj |
    adj "but not " adj |
    adj "yet somehow " adj |
    adj in-the-way "we " VP-inf
;

///////////
/// PPs ///
///////////

PP:
// by researchers

    prep noun-count>plural |
    prep det noun-count |
    prep noun-uncount |
    complex-PP
;

complex-PP:
    prep NP-pl |
    prep NP-sing |
    prep abstract-field
;

topical-PP:

    prep topic
;

personal-PP:
    
    prep personal-NP-sing
;


///////////////////////////////////
//               //
//  INDIVIDUAL CONCEPTS      //
//               //
///////////////////////////////////

abstract-field:

    "the realm of " academic-subject |
    "the search for " academic-subject |
    "the area of " academic-subject |
    "the study of " academic-subject |
    "the field of " academic-subject 
;

additionally:
    "additionally " | "furthermore " | "also "
;

all-of-the:
    "all of the " | "some of the " | "many of the " | "most of the " | "none of the " |
    almost "all of the "
;

almost:
    "almost " | "nearly " | "just about "
;

although:
    "although " | "while " | "despite the fact that " | "though " | "even though "
;

and:
    "and " | "as well as " | "in addition to " | "along with " | "together with " | "but also "
;

answer:
    "answer " | "reply " | "response " | "rejoinder " | "solution "
;

as-well:
    "as well " | "also " | "too " | "equally " | "to the same extent "
;

because:
    "because " | "since " | due-to "the fact that " | "seeing as "
;

consequently:
    "consequently " | "thus " | "therefore " | "hence " | "as a result "
;

due-to:
    "due to " | "by " | "from " | "as a result of " | "because of "
;

however:
    "however " | "nonetheless " | "even so " | "still yet " | "be that as it may " | "in any case "
;

humanity:
    "humanity " | "mankind " | "humankind " | "society " | "human society " | "human life "
;

involved:
    "involved " | "in question "
;

in-the-way:
    "in the way " | "in the extent to which " | "in how much "
;

part:
    "part " | "component " | "experience "
;

probably:
    "probably " | "in all likelihood " | "doubtless " | "undoubtedly " | "no doubt " |
    "likely " | "doubtlessly " | "presumably "
;

quantity:
    "lack " | "dearth " | "abundance " | "plethora " | "quantity "
;

question:
    "question " | "query " | "inquiry " | "interrogation "
;

subsequently:
    "subsequently " | "since then " | "ever since "
;

the-more:
    "the more " | "the less " | "the sooner "
;

those:
    "those " | "the people " | "the " noun-count>plural
;

topic:
// temporary, clearly
    "technology " | "progress "
;

usually:
    "usually "  | "typically " | "especially " | "normally " | "often " | "frequently "
;

famous-name:
    "Oscar Wilde " | "Eleanor Roosevelt " | "Leon Trotsky " | "Mark Twain " | "Eli Whitney " | "the Reverend Dr. Martin Luther King, Jr. "
;


////////////////////////////////////
//                //
//  TEMPORARY VOCABULARY      //
//                //
////////////////////////////////////

noun-count:
    {{ pb_word_list(noun_countable) }}
;

noun-uncount:
    {{ pb_word_list(noun_uncountable) }}
;

scientific-noun-count:
    "plasma " | "brain " | "neuron " | "gamma ray " | "orbital " | "pendulum " | "neutrino "
;

scientific-noun-uncount:
    "radiation " | "interference " | "information " | "gravity " | "simulation "
;

academic-subject:
    "philosophy " | "reality " | "semantics " | "semiotics " | "literature " | "theory of knowledge "
;

verb-intrans-inf:
    {{ pb_word_list(verb_intrans) }}
;

verb-intrans-3rd:
    verb-intrans-inf>plural
;

verb-trans-inf:
    {{ pb_word_list(verb_trans) }}
;

verb-trans-3rd:
    // is this allowed??
    verb-trans-inf>plural
;

verb-aux:
    "can " | "will " | "should " | "may " | "might "
;

scientific-verb-intrans-inf:
    "implode " | "invert " | "spin " | "react " | "oscillate " | "reproduce "
;

scientific-verb-intrans-3rd:
    scientific-verb-intrans-inf>plural
;

scientific-verb-trans-inf:
    "process " | "counteract " | "produce " | "emit " | "receive " | "transmit " | "catalyze "
;

scientific-verb-trans-3rd:
    scientific-verb-trans-inf>plural
;

adj:
    {{ pb_word_list(adjectives) }}
;

adverb:
    {{ pb_word_list(adverbs) }}
;

prep:
    "at " | "by " | "for " | "of " | "with " | "on " | "to "
;

conj:
    "and " | "but " | "or "
;

det:
    "the " | "a "
;

/////////////////////////////////////
//                 //
//  FORMATTING OPERATIONS      //
//                 //
/////////////////////////////////////

PARA(p): "<p>" p "</p>\n\n";

sen-format:
    ".* $" -> " $"/"\. "
;

%trans cap-first:
    ".*": 0 u ;
;

trim:
    ".* $" -> " $"/""
;

plural:
    ".*y $" -> "y $"/"ies "
    ".*s $" -> " $"/"es "
    ".* $" -> " $"/"s "
;

gerund:
    ".*e $" -> "e $"/"ing "
    ".* $" -> " $"/"ing "
;

pastpart:
    ".*y $" -> "y $"/"ied "
    ".*e $" -> " $"/"d "
    ".* $" -> " $"/"ed "
;
