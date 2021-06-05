Require Import String.
Require Import Coq.Logic.Eqdep_dec.
Require Import Arith.
Require Import Coq.Arith.Gt.
Require Import Coq.Arith.EqNat.
Require Import List.
Require Import Omega.

Require Import core.utils.Utils.
Require Import core.Semantics.
Require Import core.Certification.
Require Import core.modeling.Metamodel.
Require Import core.Model.

Require Import examples.Class2Relational.Class2Relational.
Require Import examples.Class2Relational.ClassMetamodel.
Require Import examples.Class2Relational.RelationalMetamodel.


Theorem Relational_Column_Reference_definedness:
forall (cm : ClassModel) (rm : RelationalModel), 
  (* transformation *) rm = execute Class2Relational cm ->
  (* precondition *)  (forall (att : Attribute),
    In (ClassMetamodel_toObject AttributeClass att) (allModelElements cm) ->
        getAttributeType att cm <> None) ->
  (* postcondition *)  (forall (col: Column),
    In (RelationalMetamodel_toObject ColumnClass col) (allModelElements rm) ->
      getColumnReference col rm <> None). 
Proof.
intros cm rm tr pre.
intros. 
rewrite tr.

assert 
(exists t: Table, 
  In (RelationalMetamodel_BuildLink 
        ColumnReferenceReference 
        (BuildColumnReference col t))
     (allModelLinks rm)) as HcolInrml.
{  
eexists.
rewrite tr.
apply tr_execute_in_links.

(* get the sp that corresponds to [col] *)

rewrite tr in H.
apply tr_execute_in_elements in H.
destruct H as [sp H].
destruct H as [HspIncm HcolInInst].
remember HspIncm as HspIncm_copy.
clear HeqHspIncm_copy.
destruct sp as [ | sphd sptl] eqn: sp_ca. (* Case analysis on source pattern *)
- (* Empty pattern *) contradiction HcolInInst.
- destruct sptl eqn: sptl_ca.
  + (* Singleton *) 
    apply allTuples_incl in HspIncm.
    unfold incl in HspIncm.
    specialize (HspIncm sphd).
    assert (In sphd [sphd]). { left. reflexivity. }
    specialize (HspIncm H).  
    destruct sphd as [sphd_tp sphd_elem]. 
    destruct sphd_tp. (* Case analysis on source element type *)
    ++ (* [Class] *) simpl in HcolInInst.
      destruct HcolInInst.
      +++ inversion H0. (* contradiction in H0 *)
      +++ crush.
    ++ (* [Attribute] *) destruct sphd_elem as [attr_id attr_der attr_name] eqn: sphd_elem_attr.
      destruct attr_der eqn: attr_der_ca. (* Case analysis on attribute derivable *)
      +++ (* derived *) contradiction HcolInInst.
      +++ (* not derived *) 
         exists sp.
         split.
         * rewrite <- sp_ca in HspIncm_copy. exact HspIncm_copy.
         * admit.
  + (* Other patterns *) do 2 destruct c.
    * admit. (* destruct c0. destruct c; contradiction H0. *)
    * admit. (* destruct c0. destruct c; contradiction H0. *)
}

destruct HcolInrml as [t Ht].


Admitted.