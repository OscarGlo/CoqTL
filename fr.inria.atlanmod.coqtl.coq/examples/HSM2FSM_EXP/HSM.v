
(********************************************************************
	@name Coq declarations for metamodel: <HSM>
	@date 2018/08/15 18:41:07
	@description Automatically generated by Ecore2Coq transformation.
 ********************************************************************)

(* Coq libraries *)
Require Import Bool.
Require Import String.
Require Import List.
Require Import Multiset.
Require Import ListSet.
Require Import Omega.
Require Import Coq.Logic.Eqdep_dec.

(* CoqTL libraries *)
Require Import core.utils.tTop.
Require Import core.Metamodel.
Require Import core.Model.


	
(* Base types *)
Inductive StateMachine : Set :=
  BuildStateMachine :
  (* name *) string ->
  (* StateMachineID *) string ->
  StateMachine.
  
Inductive Transition : Set :=
  BuildTransition :
  (* label *) string ->
  (* TransitionID *) string ->
  Transition.

Inductive InitialState : Set :=
  BuildInitialState :
  (* name *) string ->
  (* InitialStateID *) string ->
  InitialState.
  
Inductive RegularState : Set :=
  BuildRegularState :
  (* name *) string ->
  (* RegularStateID *) string ->
  RegularState.
  
Inductive CompositeState : Set :=
  BuildCompositeState :
  (* name *) string ->
  (* CompositeStateID *) string ->
  CompositeState.

(*TODO*)
(* AbstractState-types *)
Inductive AbstractState_EClass : Set :=
  | InitialStateEClass
  | RegularStateEClass
  | CompositeStateEClass
.

(*TODO*)
Definition AbstractState_getTypeByEClass (hsec_arg : AbstractState_EClass) : Set :=
  match hsec_arg with
    | InitialStateEClass => InitialState
    | RegularStateEClass => RegularState
    | CompositeStateEClass => CompositeState
  end.

(*TODO*)
Definition AbstractState_getEAttributeTypesByEClass (hsec_arg : AbstractState_EClass) : Set :=
  match hsec_arg with
    | InitialStateEClass => 
    (string * string)
    | RegularStateEClass => 
    (string * string)
    | CompositeStateEClass => 
    (string * string)
  end.

(*TODO*)
Inductive AbstractState : Set :=
 | BuildAbstractState : 
    forall (hsec_arg: AbstractState_EClass), (AbstractState_getTypeByEClass hsec_arg) -> AbstractState.


Inductive StateMachineTransitions : Set :=
   BuildStateMachineTransitions :
   StateMachine ->
   list Transition ->
   StateMachineTransitions.
Inductive StateMachineStates : Set :=
   BuildStateMachineStates :
   StateMachine ->
   list AbstractState ->
   StateMachineStates.

Inductive TransitionStateMachine : Set :=
   BuildTransitionStateMachine :
   Transition ->
   StateMachine ->
   TransitionStateMachine.
Inductive TransitionSource : Set :=
   BuildTransitionSource :
   Transition ->
   AbstractState ->
   TransitionSource.
Inductive TransitionTarget : Set :=
   BuildTransitionTarget :
   Transition ->
   AbstractState ->
   TransitionTarget.

Inductive AbstractStateStateMachine : Set :=
   BuildAbstractStateStateMachine :
   AbstractState ->
   StateMachine ->
   AbstractStateStateMachine.
Inductive AbstractStateCompositeState : Set :=
   BuildAbstractStateCompositeState :
   AbstractState ->
   CompositeState ->
   AbstractStateCompositeState.



Inductive CompositeStateStates : Set :=
   BuildCompositeStateStates :
   CompositeState ->
   list AbstractState ->
   CompositeStateStates.



(* Accessors *)
Definition StateMachine_getName (s : StateMachine) : string :=
  match s with BuildStateMachine  name StateMachineID  => name end.
Definition StateMachine_getStateMachineID (s : StateMachine) : string :=
  match s with BuildStateMachine  name StateMachineID  => StateMachineID end.
 
Definition Transition_getLabel (t : Transition) : string :=
  match t with BuildTransition  label TransitionID  => label end.
Definition Transition_getTransitionID (t : Transition) : string :=
  match t with BuildTransition  label TransitionID  => TransitionID end.

(*TODO*)
Definition AbstractState_getName (a : AbstractState) : string :=
  match a with 
| BuildAbstractState InitialStateEClass (BuildInitialState name id) => name
| BuildAbstractState RegularStateEClass (BuildRegularState name id) => name
| BuildAbstractState CompositeStateEClass (BuildCompositeState name id) => name
end.
(*TODO*)
Definition AbstractState_getAbstractStateID (a : AbstractState) : string :=
  match a with 
| BuildAbstractState InitialStateEClass (BuildInitialState name id) => id
| BuildAbstractState RegularStateEClass (BuildRegularState name id) => id
| BuildAbstractState CompositeStateEClass (BuildCompositeState name id) => id
end.

(*TODO*)
Definition InitialState_getName (i : InitialState) : string :=
  match i with BuildInitialState name InitialStateID  => name end.
Definition InitialState_getInitialStateID (i : InitialState) : string :=
  match i with BuildInitialState name InitialStateID  => InitialStateID end.
 
Definition RegularState_getName (r : RegularState) : string :=
  match r with BuildRegularState name RegularStateID  => name end.
Definition RegularState_getRegularStateID (r : RegularState) : string :=
  match r with BuildRegularState name RegularStateID  => RegularStateID end.
 
Definition CompositeState_getName (c : CompositeState) : string :=
  match c with BuildCompositeState name CompositeStateID  => name end.
Definition CompositeState_getCompositeStateID (c : CompositeState) : string :=
  match c with BuildCompositeState name CompositeStateID  => CompositeStateID end.
 

(*TODO*)
(* Meta-types *)
Inductive HSMMetamodel_EClass : Set :=
  | StateMachineEClass
  | TransitionEClass
  | AbstractStateEClass
.

(*TODO*)
Definition HSMMetamodel_getTypeByEClass (hsec_arg : HSMMetamodel_EClass) : Set :=
  match hsec_arg with
    | StateMachineEClass => StateMachine
    | TransitionEClass => Transition
    | AbstractStateEClass => AbstractState
  end.

Check (fun (c : AbstractState_EClass) => (AbstractState_getEAttributeTypesByEClass c)) .



Inductive HSMMetamodel_EReference : Set :=
| StateMachineTransitionsEReference
| StateMachineStatesEReference
| TransitionStateMachineEReference
| TransitionSourceEReference
| TransitionTargetEReference
| AbstractStateStateMachineEReference
| AbstractStateCompositeStateEReference
| CompositeStateStatesEReference
.

Definition HSMMetamodel_getTypeByEReference (hser_arg : HSMMetamodel_EReference) : Set :=
  match hser_arg with
| StateMachineTransitionsEReference => StateMachineTransitions
| StateMachineStatesEReference => StateMachineStates
| TransitionStateMachineEReference => TransitionStateMachine
| TransitionSourceEReference => TransitionSource
| TransitionTargetEReference => TransitionTarget
| AbstractStateStateMachineEReference => AbstractStateStateMachine
| AbstractStateCompositeStateEReference => AbstractStateCompositeState
| CompositeStateStatesEReference => CompositeStateStates
  end.

Definition HSMMetamodel_getERoleTypesByEReference (hser_arg : HSMMetamodel_EReference) : Set :=
  match hser_arg with
| StateMachineTransitionsEReference => (StateMachine * list Transition)
| StateMachineStatesEReference => (StateMachine * list AbstractState)
| TransitionStateMachineEReference => (Transition * StateMachine)
| TransitionSourceEReference => (Transition * AbstractState)
| TransitionTargetEReference => (Transition * AbstractState)
| AbstractStateStateMachineEReference => (AbstractState * StateMachine)
| AbstractStateCompositeStateEReference => (AbstractState * CompositeState)
| CompositeStateStatesEReference => (CompositeState * list AbstractState)
  end.

(* Generic types *)
Inductive HSMMetamodel_EObject : Set :=
 | Build_HSMMetamodel_EObject : 
    forall (hsec_arg: HSMMetamodel_EClass), (HSMMetamodel_getTypeByEClass hsec_arg) -> HSMMetamodel_EObject.

Inductive HSMMetamodel_ELink : Set :=
 | Build_HSMMetamodel_ELink : 
    forall (hser_arg:HSMMetamodel_EReference), (HSMMetamodel_getTypeByEReference hser_arg) -> HSMMetamodel_ELink.


Check Build_HSMMetamodel_EObject AbstractStateEClass (BuildAbstractState InitialStateEClass (BuildInitialState "A" "05")).





(* Reflective functions *)
Lemma HSMMetamodel_eqEClass_dec : 
 forall (hsec_arg1:HSMMetamodel_EClass) (hsec_arg2:HSMMetamodel_EClass), { hsec_arg1 = hsec_arg2 } + { hsec_arg1 <> hsec_arg2 }.
Proof. repeat decide equality. Defined.

Lemma HSMMetamodel_eqEReference_dec : 
 forall (hser_arg1:HSMMetamodel_EReference) (hser_arg2:HSMMetamodel_EReference), { hser_arg1 = hser_arg2 } + { hser_arg1 <> hser_arg2 }.
Proof. repeat decide equality. Defined.

Definition HSMMetamodel_getEClass (hseo_arg : HSMMetamodel_EObject) : HSMMetamodel_EClass :=
   match hseo_arg with
  | (Build_HSMMetamodel_EObject hseo_arg _) => hseo_arg
   end.

Definition HSMMetamodel_getEReference (hsel_arg : HSMMetamodel_ELink) : HSMMetamodel_EReference :=
   match hsel_arg with
  | (Build_HSMMetamodel_ELink hsel_arg _) => hsel_arg
   end.

Definition HSMMetamodel_instanceOfEClass (hsec_arg: HSMMetamodel_EClass) (hseo_arg : HSMMetamodel_EObject): bool :=
  if HSMMetamodel_eqEClass_dec (HSMMetamodel_getEClass hseo_arg) hsec_arg then true else false.

Definition HSMMetamodel_instanceOfEReference (hser_arg: HSMMetamodel_EReference) (hsel_arg : HSMMetamodel_ELink): bool :=
  if HSMMetamodel_eqEReference_dec (HSMMetamodel_getEReference hsel_arg) hser_arg then true else false.


(*TODO*)
Lemma AbstractState_eqEClass_dec : 
 forall (hsec_arg1:AbstractState_EClass) (hsec_arg2:AbstractState_EClass), { hsec_arg1 = hsec_arg2 } + { hsec_arg1 <> hsec_arg2 }.
Proof. repeat decide equality. Defined.

Definition AbstractState_getEClass (hseo_arg : AbstractState) : AbstractState_EClass :=
   match hseo_arg with
  | (BuildAbstractState hseo_arg _) => hseo_arg
   end.

Definition AbstractState_instanceOfEClass (hsec_arg: AbstractState_EClass) (hseo_arg : AbstractState): bool :=
  if AbstractState_eqEClass_dec (AbstractState_getEClass hseo_arg) hsec_arg then true else false.






(** Helper of building ELink for model **)
Definition HSMMetamodel_getELinkFromERoleValues (hser_arg : HSMMetamodel_EReference) : (HSMMetamodel_getERoleTypesByEReference hser_arg) -> HSMMetamodel_ELink :=
  match hser_arg with
| StateMachineTransitionsEReference => (fun (p: (StateMachine * list Transition)) => (Build_HSMMetamodel_ELink StateMachineTransitionsEReference (BuildStateMachineTransitions (fst p) (snd p))))
| StateMachineStatesEReference => (fun (p: (StateMachine * list AbstractState)) => (Build_HSMMetamodel_ELink StateMachineStatesEReference (BuildStateMachineStates (fst p) (snd p))))
| TransitionStateMachineEReference => (fun (p: (Transition * StateMachine)) => (Build_HSMMetamodel_ELink TransitionStateMachineEReference (BuildTransitionStateMachine (fst p) (snd p))))
| TransitionSourceEReference => (fun (p: (Transition * AbstractState)) => (Build_HSMMetamodel_ELink TransitionSourceEReference (BuildTransitionSource (fst p) (snd p))))
| TransitionTargetEReference => (fun (p: (Transition * AbstractState)) => (Build_HSMMetamodel_ELink TransitionTargetEReference (BuildTransitionTarget (fst p) (snd p))))
| AbstractStateStateMachineEReference => (fun (p: (AbstractState * StateMachine)) => (Build_HSMMetamodel_ELink AbstractStateStateMachineEReference (BuildAbstractStateStateMachine (fst p) (snd p))))
| AbstractStateCompositeStateEReference => (fun (p: (AbstractState * CompositeState)) => (Build_HSMMetamodel_ELink AbstractStateCompositeStateEReference (BuildAbstractStateCompositeState (fst p) (snd p))))
| CompositeStateStatesEReference => (fun (p: (CompositeState * list AbstractState)) => (Build_HSMMetamodel_ELink CompositeStateStatesEReference (BuildCompositeStateStates (fst p) (snd p))))
  end.

Definition HSMMetamodel_toEClass (hsec_arg : HSMMetamodel_EClass) (hseo_arg : HSMMetamodel_EObject) : option (HSMMetamodel_getTypeByEClass hsec_arg).
Proof.
  destruct hseo_arg as [arg1 arg2].
  destruct (HSMMetamodel_eqEClass_dec arg1 hsec_arg) as [e|] eqn:dec_case.
  - rewrite e in arg2.
    exact (Some arg2).
  - exact None.
Defined.

Definition HSMMetamodel_AbstractState_downcast (t : AbstractState_EClass) (ab_arg : AbstractState) : option (AbstractState_getTypeByEClass t).
Proof.
 destruct ab_arg as [arg1 arg2].
 destruct (AbstractState_eqEClass_dec arg1 t) as [e|] eqn:dec_case.
 -  rewrite e in arg2.
    exact (Some arg2).
 -  exact None.
Defined.

Compute (HSMMetamodel_AbstractState_downcast InitialStateEClass (BuildAbstractState InitialStateEClass (BuildInitialState "A" "05")) ).

Definition HSMMetamodel_toEReference (hser_arg : HSMMetamodel_EReference) (hsel_arg : HSMMetamodel_ELink) : option (HSMMetamodel_getTypeByEReference hser_arg).
Proof.
  destruct hsel_arg as [arg1 arg2].
  destruct (HSMMetamodel_eqEReference_dec arg1 hser_arg) as [e|] eqn:dec_case.
  - rewrite e in arg2.
  	exact (Some arg2).
  - exact None.
Defined.

(* Generic functions *)
Definition HSMMetamodel_toEObjectFromStateMachine (st_arg :StateMachine) : HSMMetamodel_EObject :=
  (Build_HSMMetamodel_EObject StateMachineEClass st_arg).
Coercion HSMMetamodel_toEObjectFromStateMachine : StateMachine >-> HSMMetamodel_EObject.

Definition HSMMetamodel_toEObjectFromTransition (tr_arg :Transition) : HSMMetamodel_EObject :=
  (Build_HSMMetamodel_EObject TransitionEClass tr_arg).
Coercion HSMMetamodel_toEObjectFromTransition : Transition >-> HSMMetamodel_EObject.

Definition HSMMetamodel_toEObjectFromAbstractState (ab_arg :AbstractState) : HSMMetamodel_EObject :=
  (Build_HSMMetamodel_EObject AbstractStateEClass ab_arg).
Coercion HSMMetamodel_toEObjectFromAbstractState : AbstractState >-> HSMMetamodel_EObject.


(*TODO*)
Definition HSMMetamodel_toEObjectFromInitialState (in_arg :InitialState) : HSMMetamodel_EObject :=
  (Build_HSMMetamodel_EObject AbstractStateEClass (BuildAbstractState InitialStateEClass in_arg)).
Coercion HSMMetamodel_toEObjectFromInitialState : InitialState >-> HSMMetamodel_EObject.

Definition HSMMetamodel_toEObjectFromRegularState (re_arg :RegularState) : HSMMetamodel_EObject :=
  (Build_HSMMetamodel_EObject AbstractStateEClass (BuildAbstractState RegularStateEClass re_arg)).
Coercion HSMMetamodel_toEObjectFromRegularState : RegularState >-> HSMMetamodel_EObject.

Definition HSMMetamodel_toEObjectFromCompositeState (co_arg :CompositeState) : HSMMetamodel_EObject :=
  (Build_HSMMetamodel_EObject AbstractStateEClass (BuildAbstractState CompositeStateEClass co_arg)).
Coercion HSMMetamodel_toEObjectFromCompositeState : CompositeState >-> HSMMetamodel_EObject.




(** Metamodel Type Class Instaniation **)
Definition HSMMetamodel_toEObject (hseo_arg : HSMMetamodel_EObject) : HSMMetamodel_EObject := hseo_arg.
Definition HSMMetamodel_toELink (hsel_arg : HSMMetamodel_ELink) : HSMMetamodel_ELink := hsel_arg.
Definition HSMModel := Model HSMMetamodel_EObject HSMMetamodel_ELink.

Definition HSMMetamodel_toEObjectOfEClass (hsec_arg: HSMMetamodel_EClass) (t: HSMMetamodel_getTypeByEClass hsec_arg) : HSMMetamodel_EObject :=
  (Build_HSMMetamodel_EObject hsec_arg t).

Definition HSMMetamodel_toELinkOfEReference (hser_arg: HSMMetamodel_EReference) (t: HSMMetamodel_getTypeByEReference hser_arg) : HSMMetamodel_ELink :=
		  (Build_HSMMetamodel_ELink hser_arg t).


(* Accessors on model *)
(* Equality for Types *)
Definition beq_StateMachine (st_arg1 : StateMachine) (st_arg2 : StateMachine) : bool :=
( beq_string (StateMachine_getName st_arg1) (StateMachine_getName st_arg2) ) && 
( beq_string (StateMachine_getStateMachineID st_arg1) (StateMachine_getStateMachineID st_arg2) )
.

Definition beq_Transition (tr_arg1 : Transition) (tr_arg2 : Transition) : bool :=
( beq_string (Transition_getLabel tr_arg1) (Transition_getLabel tr_arg2) ) && 
( beq_string (Transition_getTransitionID tr_arg1) (Transition_getTransitionID tr_arg2) )
.

Definition beq_AbstractState (ab_arg1 : AbstractState) (ab_arg2 : AbstractState) : bool :=
( beq_string (AbstractState_getName ab_arg1) (AbstractState_getName ab_arg2) ) && 
( beq_string (AbstractState_getAbstractStateID ab_arg1) (AbstractState_getAbstractStateID ab_arg2) )
.

(*TODO*)
Definition beq_InitialState (in_arg1 : InitialState) (in_arg2 : InitialState) : bool :=
beq_string (InitialState_getName in_arg1) (InitialState_getName in_arg2) &&
( beq_string (InitialState_getInitialStateID in_arg1) (InitialState_getInitialStateID in_arg2) )
.

Definition beq_RegularState (re_arg1 : RegularState) (re_arg2 : RegularState) : bool :=
beq_string (RegularState_getName re_arg1) (RegularState_getName re_arg2) &&
( beq_string (RegularState_getRegularStateID re_arg1) (RegularState_getRegularStateID re_arg2) )
.

Definition beq_CompositeState (co_arg1 : CompositeState) (co_arg2 : CompositeState) : bool :=
beq_string (CompositeState_getName co_arg1) (CompositeState_getName co_arg2) &&
( beq_string (CompositeState_getCompositeStateID co_arg1) (CompositeState_getCompositeStateID co_arg2) )
.








Fixpoint StateMachine_getTransitionsOnLinks (st_arg : StateMachine) (l : list HSMMetamodel_ELink) : option (list Transition) :=
match l with
| (Build_HSMMetamodel_ELink StateMachineTransitionsEReference (BuildStateMachineTransitions StateMachine_ctr transitions_ctr)) :: l' => 
	  if beq_StateMachine StateMachine_ctr st_arg then Some transitions_ctr else StateMachine_getTransitionsOnLinks st_arg l'
| _ :: l' => StateMachine_getTransitionsOnLinks st_arg l'
| nil => None
end.

Definition StateMachine_getTransitions (st_arg : StateMachine) (m : HSMModel) : option (list Transition) :=
  StateMachine_getTransitionsOnLinks st_arg (@allModelLinks _ _ m).
Fixpoint StateMachine_getStatesOnLinks (st_arg : StateMachine) (l : list HSMMetamodel_ELink) : option (list AbstractState) :=
match l with
| (Build_HSMMetamodel_ELink StateMachineStatesEReference (BuildStateMachineStates StateMachine_ctr states_ctr)) :: l' => 
	  if beq_StateMachine StateMachine_ctr st_arg then Some states_ctr else StateMachine_getStatesOnLinks st_arg l'
| _ :: l' => StateMachine_getStatesOnLinks st_arg l'
| nil => None
end.

Definition StateMachine_getStates (st_arg : StateMachine) (m : HSMModel) : option (list AbstractState) :=
  StateMachine_getStatesOnLinks st_arg (@allModelLinks _ _ m).

Fixpoint Transition_getStateMachineOnLinks (tr_arg : Transition) (l : list HSMMetamodel_ELink) : option (StateMachine) :=
match l with
| (Build_HSMMetamodel_ELink TransitionStateMachineEReference (BuildTransitionStateMachine Transition_ctr stateMachine_ctr)) :: l' => 
	  if beq_Transition Transition_ctr tr_arg then Some stateMachine_ctr else Transition_getStateMachineOnLinks tr_arg l'
| _ :: l' => Transition_getStateMachineOnLinks tr_arg l'
| nil => None
end.

Definition Transition_getStateMachine (tr_arg : Transition) (m : HSMModel) : option (StateMachine) :=
  Transition_getStateMachineOnLinks tr_arg (@allModelLinks _ _ m).
Fixpoint Transition_getSourceOnLinks (tr_arg : Transition) (l : list HSMMetamodel_ELink) : option (AbstractState) :=
match l with
| (Build_HSMMetamodel_ELink TransitionSourceEReference (BuildTransitionSource Transition_ctr source_ctr)) :: l' => 
	  if beq_Transition Transition_ctr tr_arg then Some source_ctr else Transition_getSourceOnLinks tr_arg l'
| _ :: l' => Transition_getSourceOnLinks tr_arg l'
| nil => None
end.

Definition Transition_getSource (tr_arg : Transition) (m : HSMModel) : option (AbstractState) :=
  Transition_getSourceOnLinks tr_arg (@allModelLinks _ _ m).
Fixpoint Transition_getTargetOnLinks (tr_arg : Transition) (l : list HSMMetamodel_ELink) : option (AbstractState) :=
match l with
| (Build_HSMMetamodel_ELink TransitionTargetEReference (BuildTransitionTarget Transition_ctr target_ctr)) :: l' => 
	  if beq_Transition Transition_ctr tr_arg then Some target_ctr else Transition_getTargetOnLinks tr_arg l'
| _ :: l' => Transition_getTargetOnLinks tr_arg l'
| nil => None
end.

Definition Transition_getTarget (tr_arg : Transition) (m : HSMModel) : option (AbstractState) :=
  Transition_getTargetOnLinks tr_arg (@allModelLinks _ _ m).

Fixpoint AbstractState_getStateMachineOnLinks (ab_arg : AbstractState) (l : list HSMMetamodel_ELink) : option (StateMachine) :=
match l with
| (Build_HSMMetamodel_ELink AbstractStateStateMachineEReference (BuildAbstractStateStateMachine AbstractState_ctr stateMachine_ctr)) :: l' => 
	  if beq_AbstractState AbstractState_ctr ab_arg then Some stateMachine_ctr else AbstractState_getStateMachineOnLinks ab_arg l'
| _ :: l' => AbstractState_getStateMachineOnLinks ab_arg l'
| nil => None
end.

Definition AbstractState_getStateMachine (ab_arg : AbstractState) (m : HSMModel) : option (StateMachine) :=
  AbstractState_getStateMachineOnLinks ab_arg (@allModelLinks _ _ m).
Fixpoint AbstractState_getCompositeStateOnLinks (ab_arg : AbstractState) (l : list HSMMetamodel_ELink) : option (CompositeState) :=
match l with
| (Build_HSMMetamodel_ELink AbstractStateCompositeStateEReference (BuildAbstractStateCompositeState AbstractState_ctr compositeState_ctr)) :: l' => 
	  if beq_AbstractState AbstractState_ctr ab_arg then Some compositeState_ctr else AbstractState_getCompositeStateOnLinks ab_arg l'
| _ :: l' => AbstractState_getCompositeStateOnLinks ab_arg l'
| nil => None
end.

Definition AbstractState_getCompositeState (ab_arg : AbstractState) (m : HSMModel) : option (CompositeState) :=
  AbstractState_getCompositeStateOnLinks ab_arg (@allModelLinks _ _ m).



Fixpoint CompositeState_getStatesOnLinks (co_arg : CompositeState) (l : list HSMMetamodel_ELink) : option (list AbstractState) :=
match l with
| (Build_HSMMetamodel_ELink CompositeStateStatesEReference (BuildCompositeStateStates CompositeState_ctr states_ctr)) :: l' => 
	  if beq_CompositeState CompositeState_ctr co_arg then Some states_ctr else CompositeState_getStatesOnLinks co_arg l'
| _ :: l' => CompositeState_getStatesOnLinks co_arg l'
| nil => None
end.

Definition CompositeState_getStates (co_arg : CompositeState) (m : HSMModel) : option (list AbstractState) :=
  CompositeState_getStatesOnLinks co_arg (@allModelLinks _ _ m).


Definition HSMMetamodel_defaultInstanceOfEClass (hsec_arg: HSMMetamodel_EClass) : (HSMMetamodel_getTypeByEClass hsec_arg) :=
  match hsec_arg with
  | StateMachineEClass => 
  (BuildStateMachine "" "")
  | TransitionEClass => 
  (BuildTransition "" "")
  | AbstractStateEClass => 
  (BuildAbstractState InitialStateEClass (BuildInitialState "" ""))
  end.

(* Typeclass Instance *)
Instance HSMMetamodel : Metamodel HSMMetamodel_EObject HSMMetamodel_ELink HSMMetamodel_EClass HSMMetamodel_EReference :=
  {
    denoteModelClass := HSMMetamodel_getTypeByEClass;
    denoteModelReference := HSMMetamodel_getTypeByEReference;
    toModelClass := HSMMetamodel_toEClass;
    toModelReference := HSMMetamodel_toEReference;
    toModelElement := HSMMetamodel_toEObjectOfEClass;
    toModelLink := HSMMetamodel_toELinkOfEReference;
    bottomModelClass := HSMMetamodel_defaultInstanceOfEClass;

    (* Theorems *)
    eqModelClass_dec := HSMMetamodel_eqEClass_dec;
    eqModelReference_dec := HSMMetamodel_eqEReference_dec;

    (* Constructors *)
    BuildModelElement := Build_HSMMetamodel_EObject;
    BuildModelLink := Build_HSMMetamodel_ELink;
  }.
  
(* Useful lemmas *)
Lemma HSM_invert : 
  forall (hsec_arg: HSMMetamodel_EClass) (t1 t2: HSMMetamodel_getTypeByEClass hsec_arg), Build_HSMMetamodel_EObject hsec_arg t1 = Build_HSMMetamodel_EObject hsec_arg t2 -> t1 = t2.
Proof.
  intros.
  inversion H.
  apply inj_pair2_eq_dec in H1.
  exact H1.
  apply HSMMetamodel_eqEClass_dec.
Qed.


Definition HSMMetamodel_getEAttributeTypesByEClass (hsec_arg : HSMMetamodel_EClass) : Type :=
  match hsec_arg with
    | StateMachineEClass => 
    (string * string)
    | TransitionEClass => 
    (string * string)
    | AbstractStateEClass => 
    (AbstractState_EClass * AbstractState) 
  end.

Compute (HSMMetamodel_getEAttributeTypesByEClass AbstractStateEClass).

(*TODO*)
Definition AbstractState_getEObjectFromEAttributeValues (hsec_arg : AbstractState_EClass) : (AbstractState_getEAttributeTypesByEClass hsec_arg) -> AbstractState :=
  match hsec_arg with
    | InitialStateEClass => 
    (fun (x: (string * string)) => (BuildAbstractState InitialStateEClass (BuildInitialState (fst x) (snd x)))) 
    | RegularStateEClass => 
    (fun (x: (string * string)) => (BuildAbstractState RegularStateEClass (BuildRegularState (fst x) (snd x)))) 
    | CompositeStateEClass => 
    (fun (x: (string * string)) => (BuildAbstractState CompositeStateEClass (BuildCompositeState (fst x) (snd x)))) 
  end.

(** Helper of building EObject for model **)
Definition HSMMetamodel_getEObjectFromEAttributeValues (hsec_arg : HSMMetamodel_EClass) : (HSMMetamodel_getEAttributeTypesByEClass hsec_arg) -> HSMMetamodel_EObject :=
  match hsec_arg with
    | StateMachineEClass => 
    (fun (p: (string * string)) => (Build_HSMMetamodel_EObject StateMachineEClass (BuildStateMachine (fst p) (snd p))))
    | TransitionEClass => 
    (fun (p: (string * string)) => (Build_HSMMetamodel_EObject TransitionEClass (BuildTransition (fst p) (snd p))))
    | AbstractStateEClass => 
    (fun (p: AbstractState_EClass * AbstractState)=> (Build_HSMMetamodel_EObject AbstractStateEClass (snd p)))
end.


(* 


 match (fst p) with
  | InitialStateEClass => (Build_HSMMetamodel_EObject AbstractStateEClass (BuildAbstractState InitialStateEClass (BuildInitialState (fst (AbstractState_getEAttributeTypesByEClass (fst p))) (snd(AbstractState_getEAttributeTypesByEClass p)))))
  | RegularStateEClass => (Build_HSMMetamodel_EObject AbstractStateEClass (BuildAbstractState RegularStateEClass (BuildRegularState (fst (AbstractState_getEAttributeTypesByEClass p)) (snd(AbstractState_getEAttributeTypesByEClass p)))))
  | CompositeStateEClass => (Build_HSMMetamodel_EObject AbstractStateEClass (BuildAbstractState CompositeStateEClass (BuildCompositeState (fst (AbstractState_getEAttributeTypesByEClass p)) (snd(AbstractState_getEAttributeTypesByEClass p)))))
  end)


 *)