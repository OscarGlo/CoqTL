Require Import String.
Require Import List.
Require Import Multiset.
Require Import ListSet.
Require Import Bool.

Require Import core.utils.Utils.
Require Import core.Model.
Require Import core.Semantics.
Require Import core.modeling.Parser.

Require Import transformations.RSS2ATOM.RSS.
Require Import transformations.RSS2ATOM.ATOM.
Require Import transformations.RSS2ATOM.RSS2ATOM.
Require Import transformations.RSS2ATOM.tests.Exemple1RSS.
Require Import transformations.RSS2ATOM.tests.Exemple1ATOM.

Definition Exemple1RSS_ATOM := execute (parse RSS2ATOM) Exemple1RSS.

Compute Exemple1RSS_ATOM.
Compute Model_beq beq_ATOMMetamodel_Object beq_ATOMMetamodel_Link Exemple1RSS_ATOM Exemple1ATOM.