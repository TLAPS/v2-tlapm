----------------------------- MODULE functions -----------------------------

EXTENDS Naturals, TLC, TLAPS


LEMMA <<1>>[1] = 1 OBVIOUS
LEMMA ASSUME NEW f, \A x : f[x] = IF x = 0 THEN {} ELSE {0}
      PROVE f[0] = {} OBVIOUS
LEMMA ASSUME NEW f, f = (0 :> {}) @@ (1 :> {1}) @@ [ x |-> {} ]
      PROVE f[2] = {} OBVIOUS  \* not provable, fails


=============================================================================
\* Modification History
\* Last modified Fri Apr 20 14:47:53 CEST 2018 by merz
\* Last modified Sat Jul 30 12:13:22 CEST 2016 by marty
\* Created Sat Jul 30 12:11:45 CEST 2016 by marty
