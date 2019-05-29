
(********************************************************************
	@name Coq declarations for metamodel: <TT>
	@date 2019/05/28 14:06:05
	@description Automatically generated by Ecore2Coq transformation.
 ********************************************************************)

(* Coq libraries *)
Require Import String.
Require Import List.      (* sequence *)
Require Import Multiset.  (* bag *)
Require Import ListSet.   (* set *)
Require Import Omega.
Require Import Bool.

Require Import core.utils.TopUtils.
Require Import core.Metamodel.
Require Import core.Model.

Require Import Coq.Logic.Eqdep_dec.

	
(* Base types *)
Inductive LocatedElement : Set :=
  BuildLocatedElement :
  (* location *) string ->
  LocatedElement.
  
Inductive TruthTable : Set :=
  BuildTruthTable :
  (* Inheritence Attribute *) LocatedElement -> 
  (* name *) string ->
  TruthTable.
  
Inductive Port : Set :=
  BuildPort :
  (* Inheritence Attribute *) LocatedElement -> 
  (* name *) string ->
  Port.
  
Inductive InputPort : Set :=
  BuildInputPort :
  (* Inheritence Attribute *) Port -> 
  InputPort.
  
Inductive OutputPort : Set :=
  BuildOutputPort :
  (* Inheritence Attribute *) Port -> 
  OutputPort.
  
Inductive Row : Set :=
  BuildRow :
  (* Inheritence Attribute *) LocatedElement -> 
  Row.
  
Inductive Cell : Set :=
  BuildCell :
  (* Inheritence Attribute *) LocatedElement -> 
  (* value *) bool ->
  Cell.
  


Inductive TruthTablePorts : Set :=
   BuildTruthTablePorts :
   TruthTable ->
   list Port ->
   TruthTablePorts.
Inductive TruthTableRows : Set :=
   BuildTruthTableRows :
   TruthTable ->
   list Row ->
   TruthTableRows.

Inductive PortOwner : Set :=
   BuildPortOwner :
   Port ->
   TruthTable ->
   PortOwner.
Inductive PortCells : Set :=
   BuildPortCells :
   Port ->
   list Cell ->
   PortCells.



Inductive RowOwner : Set :=
   BuildRowOwner :
   Row ->
   TruthTable ->
   RowOwner.
Inductive RowCells : Set :=
   BuildRowCells :
   Row ->
   list Cell ->
   RowCells.

Inductive CellOwner : Set :=
   BuildCellOwner :
   Cell ->
   Row ->
   CellOwner.
Inductive CellPort : Set :=
   BuildCellPort :
   Cell ->
   Port ->
   CellPort.



(* Accessors *)
Definition LocatedElement_getLocation (l : LocatedElement) : string :=
  match l with BuildLocatedElement  location  => location end.
 
Definition TruthTable_getLocatedElement (t : TruthTable) : LocatedElement :=
  match t with BuildTruthTable locatedelement name  => locatedelement end.
Definition TruthTable_getName (t : TruthTable) : string :=
  match t with BuildTruthTable locatedelement name  => name end.
 
Definition Port_getLocatedElement (p : Port) : LocatedElement :=
  match p with BuildPort locatedelement name  => locatedelement end.
Definition Port_getName (p : Port) : string :=
  match p with BuildPort locatedelement name  => name end.
 
Definition InputPort_getPort (i : InputPort) : Port :=
  match i with BuildInputPort port  => port end.
 
Definition OutputPort_getPort (o : OutputPort) : Port :=
  match o with BuildOutputPort port  => port end.
 
Definition Row_getLocatedElement (r : Row) : LocatedElement :=
  match r with BuildRow locatedelement  => locatedelement end.
 
Definition Cell_getLocatedElement (c : Cell) : LocatedElement :=
  match c with BuildCell locatedelement value  => locatedelement end.
Definition Cell_getValue (c : Cell) : bool :=
  match c with BuildCell locatedelement value  => value end.
 


		
(* Meta-types *)
Inductive TTMetamodel_EClass : Set :=
  | LocatedElementEClass
  | TruthTableEClass
  | PortEClass
  | InputPortEClass
  | OutputPortEClass
  | RowEClass
  | CellEClass
.

Definition TTMetamodel_getTypeByEClass (ttec_arg : TTMetamodel_EClass) : Set :=
  match ttec_arg with
    | LocatedElementEClass => LocatedElement
    | TruthTableEClass => TruthTable
    | PortEClass => Port
    | InputPortEClass => InputPort
    | OutputPortEClass => OutputPort
    | RowEClass => Row
    | CellEClass => Cell
  end.	

Definition TTMetamodel_getEAttributeTypesByEClass (ttec_arg : TTMetamodel_EClass) : Set :=
  match ttec_arg with
    | LocatedElementEClass => 
    (string)
    | TruthTableEClass => 
    (LocatedElement * string)
    | PortEClass => 
    (LocatedElement * string)
    | InputPortEClass => 
    (Port)
    | OutputPortEClass => 
    (Port)
    | RowEClass => 
    (LocatedElement)
    | CellEClass => 
    (LocatedElement * bool)
  end.

Inductive TTMetamodel_EReference : Set :=
| TruthTablePortsEReference
| TruthTableRowsEReference
| PortOwnerEReference
| PortCellsEReference
| RowOwnerEReference
| RowCellsEReference
| CellOwnerEReference
| CellPortEReference
.

Definition TTMetamodel_getTypeByEReference (tter_arg : TTMetamodel_EReference) : Set :=
  match tter_arg with
| TruthTablePortsEReference => TruthTablePorts
| TruthTableRowsEReference => TruthTableRows
| PortOwnerEReference => PortOwner
| PortCellsEReference => PortCells
| RowOwnerEReference => RowOwner
| RowCellsEReference => RowCells
| CellOwnerEReference => CellOwner
| CellPortEReference => CellPort
  end.

Definition TTMetamodel_getERoleTypesByEReference (tter_arg : TTMetamodel_EReference) : Set :=
  match tter_arg with
| TruthTablePortsEReference => (TruthTable * list Port)
| TruthTableRowsEReference => (TruthTable * list Row)
| PortOwnerEReference => (Port * TruthTable)
| PortCellsEReference => (Port * list Cell)
| RowOwnerEReference => (Row * TruthTable)
| RowCellsEReference => (Row * list Cell)
| CellOwnerEReference => (Cell * Row)
| CellPortEReference => (Cell * Port)
  end.

(* Generic types *)





Inductive TTMetamodel_EObject : Set :=
 | Build_TTMetamodel_EObject : 
    forall (ttec_arg: TTMetamodel_EClass), (TTMetamodel_getTypeByEClass ttec_arg) -> TTMetamodel_EObject.

Inductive TTMetamodel_ELink : Set :=
 | Build_TTMetamodel_ELink : 
    forall (tter_arg:TTMetamodel_EReference), (TTMetamodel_getTypeByEReference tter_arg) -> TTMetamodel_ELink.

(* Reflective functions *)

Lemma TTMetamodel_eqEClass_dec : 
 forall (ttec_arg1:TTMetamodel_EClass) (ttec_arg2:TTMetamodel_EClass), { ttec_arg1 = ttec_arg2 } + { ttec_arg1 <> ttec_arg2 }.
Proof. repeat decide equality. Defined.

Lemma TTMetamodel_eqEReference_dec : 
 forall (tter_arg1:TTMetamodel_EReference) (tter_arg2:TTMetamodel_EReference), { tter_arg1 = tter_arg2 } + { tter_arg1 <> tter_arg2 }.
Proof. repeat decide equality. Defined.

Definition TTMetamodel_getEClass (tteo_arg : TTMetamodel_EObject) : TTMetamodel_EClass :=
   match tteo_arg with
  | (Build_TTMetamodel_EObject tteo_arg _) => tteo_arg
   end.

Definition TTMetamodel_getEReference (ttel_arg : TTMetamodel_ELink) : TTMetamodel_EReference :=
   match ttel_arg with
  | (Build_TTMetamodel_ELink ttel_arg _) => ttel_arg
   end.

Definition TTMetamodel_instanceOfEClass (ttec_arg: TTMetamodel_EClass) (tteo_arg : TTMetamodel_EObject): bool :=
  if TTMetamodel_eqEClass_dec (TTMetamodel_getEClass tteo_arg) ttec_arg then true else false.

Definition TTMetamodel_instanceOfEReference (tter_arg: TTMetamodel_EReference) (ttel_arg : TTMetamodel_ELink): bool :=
  if TTMetamodel_eqEReference_dec (TTMetamodel_getEReference ttel_arg) tter_arg then true else false.

(** Helper of building EObject for model **)
Definition TTMetamodel_getEObjectFromEAttributeValues (ttec_arg : TTMetamodel_EClass) : (TTMetamodel_getEAttributeTypesByEClass ttec_arg) -> TTMetamodel_EObject :=
  match ttec_arg with
    | LocatedElementEClass => 
    (fun (p: (string)) => (Build_TTMetamodel_EObject LocatedElementEClass (BuildLocatedElement p)))
    | TruthTableEClass => 
    (fun (p: (LocatedElement * string)) => (Build_TTMetamodel_EObject TruthTableEClass (BuildTruthTable (fst p) (snd p))))
    | PortEClass => 
    (fun (p: (LocatedElement * string)) => (Build_TTMetamodel_EObject PortEClass (BuildPort (fst p) (snd p))))
    | InputPortEClass => 
    (fun (p: (Port)) => (Build_TTMetamodel_EObject InputPortEClass (BuildInputPort p)))
    | OutputPortEClass => 
    (fun (p: (Port)) => (Build_TTMetamodel_EObject OutputPortEClass (BuildOutputPort p)))
    | RowEClass => 
    (fun (p: (LocatedElement)) => (Build_TTMetamodel_EObject RowEClass (BuildRow p)))
    | CellEClass => 
    (fun (p: (LocatedElement * bool)) => (Build_TTMetamodel_EObject CellEClass (BuildCell (fst p) (snd p))))
  end.

(** Helper of building ELink for model **)
Definition TTMetamodel_getELinkFromERoleValues (tter_arg : TTMetamodel_EReference) : (TTMetamodel_getERoleTypesByEReference tter_arg) -> TTMetamodel_ELink :=
  match tter_arg with
| TruthTablePortsEReference => (fun (p: (TruthTable * list Port)) => (Build_TTMetamodel_ELink TruthTablePortsEReference (BuildTruthTablePorts (fst p) (snd p))))
| TruthTableRowsEReference => (fun (p: (TruthTable * list Row)) => (Build_TTMetamodel_ELink TruthTableRowsEReference (BuildTruthTableRows (fst p) (snd p))))
| PortOwnerEReference => (fun (p: (Port * TruthTable)) => (Build_TTMetamodel_ELink PortOwnerEReference (BuildPortOwner (fst p) (snd p))))
| PortCellsEReference => (fun (p: (Port * list Cell)) => (Build_TTMetamodel_ELink PortCellsEReference (BuildPortCells (fst p) (snd p))))
| RowOwnerEReference => (fun (p: (Row * TruthTable)) => (Build_TTMetamodel_ELink RowOwnerEReference (BuildRowOwner (fst p) (snd p))))
| RowCellsEReference => (fun (p: (Row * list Cell)) => (Build_TTMetamodel_ELink RowCellsEReference (BuildRowCells (fst p) (snd p))))
| CellOwnerEReference => (fun (p: (Cell * Row)) => (Build_TTMetamodel_ELink CellOwnerEReference (BuildCellOwner (fst p) (snd p))))
| CellPortEReference => (fun (p: (Cell * Port)) => (Build_TTMetamodel_ELink CellPortEReference (BuildCellPort (fst p) (snd p))))
  end.

Definition TTMetamodel_toEClass (ttec_arg : TTMetamodel_EClass) (tteo_arg : TTMetamodel_EObject) : option (TTMetamodel_getTypeByEClass ttec_arg).
Proof.
  destruct tteo_arg as [arg1 arg2].
  destruct (TTMetamodel_eqEClass_dec arg1 ttec_arg) as [e|] eqn:dec_case.
  - rewrite e in arg2.
    exact (Some arg2).
  - exact None.
Defined.

Definition TTMetamodel_toEReference (tter_arg : TTMetamodel_EReference) (ttel_arg : TTMetamodel_ELink) : option (TTMetamodel_getTypeByEReference tter_arg).
Proof.
  destruct ttel_arg as [arg1 arg2].
  destruct (TTMetamodel_eqEReference_dec arg1 tter_arg) as [e|] eqn:dec_case.
  - rewrite e in arg2.
  	exact (Some arg2).
  - exact None.
Defined.

(* Generic functions *)
Definition TTMetamodel_toEObjectFromLocatedElement (lo_arg :LocatedElement) : TTMetamodel_EObject :=
  (Build_TTMetamodel_EObject LocatedElementEClass lo_arg).
Coercion TTMetamodel_toEObjectFromLocatedElement : LocatedElement >-> TTMetamodel_EObject.

Definition TTMetamodel_toEObjectFromTruthTable (tr_arg :TruthTable) : TTMetamodel_EObject :=
  (Build_TTMetamodel_EObject TruthTableEClass tr_arg).
Coercion TTMetamodel_toEObjectFromTruthTable : TruthTable >-> TTMetamodel_EObject.

Definition TTMetamodel_toEObjectFromPort (po_arg :Port) : TTMetamodel_EObject :=
  (Build_TTMetamodel_EObject PortEClass po_arg).
Coercion TTMetamodel_toEObjectFromPort : Port >-> TTMetamodel_EObject.

Definition TTMetamodel_toEObjectFromInputPort (in_arg :InputPort) : TTMetamodel_EObject :=
  (Build_TTMetamodel_EObject InputPortEClass in_arg).
Coercion TTMetamodel_toEObjectFromInputPort : InputPort >-> TTMetamodel_EObject.

Definition TTMetamodel_toEObjectFromOutputPort (ou_arg :OutputPort) : TTMetamodel_EObject :=
  (Build_TTMetamodel_EObject OutputPortEClass ou_arg).
Coercion TTMetamodel_toEObjectFromOutputPort : OutputPort >-> TTMetamodel_EObject.

Definition TTMetamodel_toEObjectFromRow (ro_arg :Row) : TTMetamodel_EObject :=
  (Build_TTMetamodel_EObject RowEClass ro_arg).
Coercion TTMetamodel_toEObjectFromRow : Row >-> TTMetamodel_EObject.

Definition TTMetamodel_toEObjectFromCell (ce_arg :Cell) : TTMetamodel_EObject :=
  (Build_TTMetamodel_EObject CellEClass ce_arg).
Coercion TTMetamodel_toEObjectFromCell : Cell >-> TTMetamodel_EObject.




(** Metamodel Type Class Instaniation **)
Definition TTMetamodel_toEObject (tteo_arg : TTMetamodel_EObject) : TTMetamodel_EObject := tteo_arg.
Definition TTMetamodel_toELink (ttel_arg : TTMetamodel_ELink) : TTMetamodel_ELink := ttel_arg.
Definition TTModel := Model TTMetamodel_EObject TTMetamodel_ELink.

Definition TTMetamodel_toEObjectOfEClass (ttec_arg: TTMetamodel_EClass) (t: TTMetamodel_getTypeByEClass ttec_arg) : TTMetamodel_EObject :=
  (Build_TTMetamodel_EObject ttec_arg t).

Definition TTMetamodel_toELinkOfEReference (tter_arg: TTMetamodel_EReference) (t: TTMetamodel_getTypeByEReference tter_arg) : TTMetamodel_ELink :=
		  (Build_TTMetamodel_ELink tter_arg t).


(* Accessors on model *)
(* Equality for Types *)
(*? We currently define eq for Eclass on their fist attribute *)
Definition beq_LocatedElement (lo_arg1 : LocatedElement) (lo_arg2 : LocatedElement) : bool :=
( beq_string (LocatedElement_getLocation lo_arg1) (LocatedElement_getLocation lo_arg2) )
.

Definition beq_TruthTable (tr_arg1 : TruthTable) (tr_arg2 : TruthTable) : bool :=
beq_LocatedElement (TruthTable_getLocatedElement tr_arg1) (TruthTable_getLocatedElement tr_arg2) &&
( beq_string (TruthTable_getName tr_arg1) (TruthTable_getName tr_arg2) )
.

Definition beq_Port (po_arg1 : Port) (po_arg2 : Port) : bool :=
beq_LocatedElement (Port_getLocatedElement po_arg1) (Port_getLocatedElement po_arg2) &&
( beq_string (Port_getName po_arg1) (Port_getName po_arg2) )
.

Definition beq_InputPort (in_arg1 : InputPort) (in_arg2 : InputPort) : bool :=
beq_Port (InputPort_getPort in_arg1) (InputPort_getPort in_arg2)
.

Definition beq_OutputPort (ou_arg1 : OutputPort) (ou_arg2 : OutputPort) : bool :=
beq_Port (OutputPort_getPort ou_arg1) (OutputPort_getPort ou_arg2)
.

Definition beq_Row (ro_arg1 : Row) (ro_arg2 : Row) : bool :=
beq_LocatedElement (Row_getLocatedElement ro_arg1) (Row_getLocatedElement ro_arg2)
.

Definition beq_Cell (ce_arg1 : Cell) (ce_arg2 : Cell) : bool :=
beq_LocatedElement (Cell_getLocatedElement ce_arg1) (Cell_getLocatedElement ce_arg2) &&
( eqb (Cell_getValue ce_arg1) (Cell_getValue ce_arg2) )
.



Fixpoint TTMetamodel_LocatedElement_downcastTruthTable (lo_arg : LocatedElement) (l : list TTMetamodel_EObject) : option TruthTable := 
  match l with
	 | Build_TTMetamodel_EObject TruthTableEClass (BuildTruthTable eSuper name ) :: l' => 
		if beq_LocatedElement lo_arg eSuper then (Some (BuildTruthTable eSuper name )) else (TTMetamodel_LocatedElement_downcastTruthTable lo_arg l')
	 | _ :: l' => (TTMetamodel_LocatedElement_downcastTruthTable lo_arg l')
	 | nil => None
end.

Definition LocatedElement_downcastTruthTable (lo_arg : LocatedElement) (m : TTModel) : option TruthTable :=
  TTMetamodel_LocatedElement_downcastTruthTable lo_arg (@allModelElements _ _ m).

Fixpoint TTMetamodel_LocatedElement_downcastPort (lo_arg : LocatedElement) (l : list TTMetamodel_EObject) : option Port := 
  match l with
	 | Build_TTMetamodel_EObject PortEClass (BuildPort eSuper name ) :: l' => 
		if beq_LocatedElement lo_arg eSuper then (Some (BuildPort eSuper name )) else (TTMetamodel_LocatedElement_downcastPort lo_arg l')
	 | _ :: l' => (TTMetamodel_LocatedElement_downcastPort lo_arg l')
	 | nil => None
end.

Definition LocatedElement_downcastPort (lo_arg : LocatedElement) (m : TTModel) : option Port :=
  TTMetamodel_LocatedElement_downcastPort lo_arg (@allModelElements _ _ m).

Fixpoint TTMetamodel_LocatedElement_downcastRow (lo_arg : LocatedElement) (l : list TTMetamodel_EObject) : option Row := 
  match l with
	 | Build_TTMetamodel_EObject RowEClass (BuildRow eSuper ) :: l' => 
		if beq_LocatedElement lo_arg eSuper then (Some (BuildRow eSuper )) else (TTMetamodel_LocatedElement_downcastRow lo_arg l')
	 | _ :: l' => (TTMetamodel_LocatedElement_downcastRow lo_arg l')
	 | nil => None
end.

Definition LocatedElement_downcastRow (lo_arg : LocatedElement) (m : TTModel) : option Row :=
  TTMetamodel_LocatedElement_downcastRow lo_arg (@allModelElements _ _ m).

Fixpoint TTMetamodel_LocatedElement_downcastCell (lo_arg : LocatedElement) (l : list TTMetamodel_EObject) : option Cell := 
  match l with
	 | Build_TTMetamodel_EObject CellEClass (BuildCell eSuper value ) :: l' => 
		if beq_LocatedElement lo_arg eSuper then (Some (BuildCell eSuper value )) else (TTMetamodel_LocatedElement_downcastCell lo_arg l')
	 | _ :: l' => (TTMetamodel_LocatedElement_downcastCell lo_arg l')
	 | nil => None
end.

Definition LocatedElement_downcastCell (lo_arg : LocatedElement) (m : TTModel) : option Cell :=
  TTMetamodel_LocatedElement_downcastCell lo_arg (@allModelElements _ _ m).


Fixpoint TTMetamodel_Port_downcastInputPort (po_arg : Port) (l : list TTMetamodel_EObject) : option InputPort := 
  match l with
	 | Build_TTMetamodel_EObject InputPortEClass (BuildInputPort eSuper ) :: l' => 
		if beq_Port po_arg eSuper then (Some (BuildInputPort eSuper )) else (TTMetamodel_Port_downcastInputPort po_arg l')
	 | _ :: l' => (TTMetamodel_Port_downcastInputPort po_arg l')
	 | nil => None
end.

Definition Port_downcastInputPort (po_arg : Port) (m : TTModel) : option InputPort :=
  TTMetamodel_Port_downcastInputPort po_arg (@allModelElements _ _ m).

Fixpoint TTMetamodel_Port_downcastOutputPort (po_arg : Port) (l : list TTMetamodel_EObject) : option OutputPort := 
  match l with
	 | Build_TTMetamodel_EObject OutputPortEClass (BuildOutputPort eSuper ) :: l' => 
		if beq_Port po_arg eSuper then (Some (BuildOutputPort eSuper )) else (TTMetamodel_Port_downcastOutputPort po_arg l')
	 | _ :: l' => (TTMetamodel_Port_downcastOutputPort po_arg l')
	 | nil => None
end.

Definition Port_downcastOutputPort (po_arg : Port) (m : TTModel) : option OutputPort :=
  TTMetamodel_Port_downcastOutputPort po_arg (@allModelElements _ _ m).




Fixpoint TruthTable_getPortsOnLinks (tr_arg : TruthTable) (l : list TTMetamodel_ELink) : option (list Port) :=
match l with
| (Build_TTMetamodel_ELink TruthTablePortsEReference (BuildTruthTablePorts TruthTable_ctr ports_ctr)) :: l' => 
	  if beq_TruthTable TruthTable_ctr tr_arg then Some ports_ctr else TruthTable_getPortsOnLinks tr_arg l'
| _ :: l' => TruthTable_getPortsOnLinks tr_arg l'
| nil => None
end.

Definition TruthTable_getPorts (tr_arg : TruthTable) (m : TTModel) : option (list Port) :=
  TruthTable_getPortsOnLinks tr_arg (@allModelLinks _ _ m).
Fixpoint TruthTable_getRowsOnLinks (tr_arg : TruthTable) (l : list TTMetamodel_ELink) : option (list Row) :=
match l with
| (Build_TTMetamodel_ELink TruthTableRowsEReference (BuildTruthTableRows TruthTable_ctr rows_ctr)) :: l' => 
	  if beq_TruthTable TruthTable_ctr tr_arg then Some rows_ctr else TruthTable_getRowsOnLinks tr_arg l'
| _ :: l' => TruthTable_getRowsOnLinks tr_arg l'
| nil => None
end.

Definition TruthTable_getRows (tr_arg : TruthTable) (m : TTModel) : option (list Row) :=
  TruthTable_getRowsOnLinks tr_arg (@allModelLinks _ _ m).

Fixpoint Port_getOwnerOnLinks (po_arg : Port) (l : list TTMetamodel_ELink) : option (TruthTable) :=
match l with
| (Build_TTMetamodel_ELink PortOwnerEReference (BuildPortOwner Port_ctr owner_ctr)) :: l' => 
	  if beq_Port Port_ctr po_arg then Some owner_ctr else Port_getOwnerOnLinks po_arg l'
| _ :: l' => Port_getOwnerOnLinks po_arg l'
| nil => None
end.

Definition Port_getOwner (po_arg : Port) (m : TTModel) : option (TruthTable) :=
  Port_getOwnerOnLinks po_arg (@allModelLinks _ _ m).
Fixpoint Port_getCellsOnLinks (po_arg : Port) (l : list TTMetamodel_ELink) : option (list Cell) :=
match l with
| (Build_TTMetamodel_ELink PortCellsEReference (BuildPortCells Port_ctr cells_ctr)) :: l' => 
	  if beq_Port Port_ctr po_arg then Some cells_ctr else Port_getCellsOnLinks po_arg l'
| _ :: l' => Port_getCellsOnLinks po_arg l'
| nil => None
end.

Definition Port_getCells (po_arg : Port) (m : TTModel) : option (list Cell) :=
  Port_getCellsOnLinks po_arg (@allModelLinks _ _ m).



Fixpoint Row_getOwnerOnLinks (ro_arg : Row) (l : list TTMetamodel_ELink) : option (TruthTable) :=
match l with
| (Build_TTMetamodel_ELink RowOwnerEReference (BuildRowOwner Row_ctr owner_ctr)) :: l' => 
	  if beq_Row Row_ctr ro_arg then Some owner_ctr else Row_getOwnerOnLinks ro_arg l'
| _ :: l' => Row_getOwnerOnLinks ro_arg l'
| nil => None
end.

Definition Row_getOwner (ro_arg : Row) (m : TTModel) : option (TruthTable) :=
  Row_getOwnerOnLinks ro_arg (@allModelLinks _ _ m).
Fixpoint Row_getCellsOnLinks (ro_arg : Row) (l : list TTMetamodel_ELink) : option (list Cell) :=
match l with
| (Build_TTMetamodel_ELink RowCellsEReference (BuildRowCells Row_ctr cells_ctr)) :: l' => 
	  if beq_Row Row_ctr ro_arg then Some cells_ctr else Row_getCellsOnLinks ro_arg l'
| _ :: l' => Row_getCellsOnLinks ro_arg l'
| nil => None
end.

Definition Row_getCells (ro_arg : Row) (m : TTModel) : option (list Cell) :=
  Row_getCellsOnLinks ro_arg (@allModelLinks _ _ m).

Fixpoint Cell_getOwnerOnLinks (ce_arg : Cell) (l : list TTMetamodel_ELink) : option (Row) :=
match l with
| (Build_TTMetamodel_ELink CellOwnerEReference (BuildCellOwner Cell_ctr owner_ctr)) :: l' => 
	  if beq_Cell Cell_ctr ce_arg then Some owner_ctr else Cell_getOwnerOnLinks ce_arg l'
| _ :: l' => Cell_getOwnerOnLinks ce_arg l'
| nil => None
end.

Definition Cell_getOwner (ce_arg : Cell) (m : TTModel) : option (Row) :=
  Cell_getOwnerOnLinks ce_arg (@allModelLinks _ _ m).
Fixpoint Cell_getPortOnLinks (ce_arg : Cell) (l : list TTMetamodel_ELink) : option (Port) :=
match l with
| (Build_TTMetamodel_ELink CellPortEReference (BuildCellPort Cell_ctr port_ctr)) :: l' => 
	  if beq_Cell Cell_ctr ce_arg then Some port_ctr else Cell_getPortOnLinks ce_arg l'
| _ :: l' => Cell_getPortOnLinks ce_arg l'
| nil => None
end.

Definition Cell_getPort (ce_arg : Cell) (m : TTModel) : option (Port) :=
  Cell_getPortOnLinks ce_arg (@allModelLinks _ _ m).


Definition TTMetamodel_defaultInstanceOfEClass (ttec_arg: TTMetamodel_EClass) : (TTMetamodel_getTypeByEClass ttec_arg) :=
  match ttec_arg with
  | LocatedElementEClass => 
  (BuildLocatedElement "")
  | TruthTableEClass => 
  (BuildTruthTable (BuildLocatedElement "") "" )
  | PortEClass => 
  (BuildPort (BuildLocatedElement "") "" )
  | InputPortEClass => 
  (BuildInputPort (BuildPort (BuildLocatedElement "") "" )  )
  | OutputPortEClass => 
  (BuildOutputPort (BuildPort (BuildLocatedElement "") "" )  )
  | RowEClass => 
  (BuildRow (BuildLocatedElement "") )
  | CellEClass => 
  (BuildCell (BuildLocatedElement "")  true)
  end.

(* Typeclass Instance *)
Instance TTMetamodel : Metamodel TTMetamodel_EObject TTMetamodel_ELink TTMetamodel_EClass TTMetamodel_EReference :=
  {
    denoteModelClass := TTMetamodel_getTypeByEClass;
    denoteModelReference := TTMetamodel_getTypeByEReference;
    toModelClass := TTMetamodel_toEClass;
    toModelReference := TTMetamodel_toEReference;
    toModelElement := TTMetamodel_toEObjectOfEClass;
    toModelLink := TTMetamodel_toELinkOfEReference;
    bottomModelClass := TTMetamodel_defaultInstanceOfEClass;

    (* Theorems *)
    eqModelClass_dec := TTMetamodel_eqEClass_dec;
    eqModelReference_dec := TTMetamodel_eqEReference_dec;

    (* Constructors *)
    BuildModelElement := Build_TTMetamodel_EObject;
    BuildModelLink := Build_TTMetamodel_ELink;
  }.
  
(* Useful lemmas *)
Lemma TT_invert : 
  forall (ttec_arg: TTMetamodel_EClass) (t1 t2: TTMetamodel_getTypeByEClass ttec_arg), Build_TTMetamodel_EObject ttec_arg t1 = Build_TTMetamodel_EObject ttec_arg t2 -> t1 = t2.
Proof.
  intros.
  inversion H.
  apply inj_pair2_eq_dec in H1.
  exact H1.
  apply TTMetamodel_eqEClass_dec.
Qed.