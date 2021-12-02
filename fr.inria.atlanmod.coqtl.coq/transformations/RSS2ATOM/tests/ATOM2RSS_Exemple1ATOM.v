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
Require Import transformations.RSS2ATOM.ATOM2RSS.
Require Import transformations.RSS2ATOM.tests.Exemple1RSS.
Require Import transformations.RSS2ATOM.tests.Exemple1ATOM.

Definition Exemple1ATOM_RSS := execute (parse ATOM2RSS) Exemple1ATOM.

Compute Exemple1ATOM_RSS.
Compute Model_beq beq_RSSMetamodel_Object beq_RSSMetamodel_Link Exemple1ATOM_RSS Exemple1RSS.
