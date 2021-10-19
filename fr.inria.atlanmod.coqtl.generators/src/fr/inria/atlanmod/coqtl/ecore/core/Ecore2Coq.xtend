package fr.inria.atlanmod.coqtl.ecore.core

import fr.inria.atlanmod.coqtl.util.EMFUtil
import java.text.SimpleDateFormat
import java.util.Date
import org.eclipse.emf.ecore.EAttribute
import org.eclipse.emf.ecore.EClass
import org.eclipse.emf.ecore.EObject
import org.eclipse.emf.ecore.EPackage
import org.eclipse.emf.ecore.EReference
import fr.inria.atlanmod.coqtl.util.Keywords
import java.util.HashSet

class Ecore2Coq {
	
			
				
				
	/* 
	 * Entry point of metamodel to Boogie transformation
	 * */ 
	def static mapEPackage(EPackage ePackage) '''

		«val mm = '''«ePackage.name»«Keywords.PostfixMetamodel»'''»
		«val mm_eclass = '''«mm»_«Keywords.PostfixEClass»'''»
		«val mm_eclass_qarg = arg('''«mm»_«Keywords.PostfixEClass»''')»
		«val mm_eclass_qarg1 = arg1('''«mm»_«Keywords.PostfixEClass»''')»
		«val mm_eclass_qarg2 = arg2('''«mm»_«Keywords.PostfixEClass»''')»
		«val mm_eref = '''«mm»_«Keywords.PostfixEReference»'''»
		«val mm_eref_qarg = arg('''«mm»_«Keywords.PostfixEReference»''')»
		«val mm_eref_qarg1 = arg1('''«mm»_«Keywords.PostfixEReference»''')»
		«val mm_eref_qarg2 = arg2('''«mm»_«Keywords.PostfixEReference»''')»
		«val mm_eobject = '''«mm»_«Keywords.PostfixEObject»'''»
		«val mm_eobject_qarg = arg('''«mm»_«Keywords.PostfixEObject»''')»
		«val mm_elink = '''«mm»_«Keywords.PostfixELink»'''»
		«val mm_elink_qarg = arg('''«mm»_«Keywords.PostfixELink»''')»
		
		(********************************************************************
			@name Coq declarations for metamodel: <«ePackage.name»>
			@date «new SimpleDateFormat("yyyy/MM/dd HH:mm:ss").format(new Date)»
			@description Automatically generated by Ecore2Coq transformation.
		 ********************************************************************)
		
		(* Coq libraries *)
		Require Import String.
		Require Import Bool.
		Require Import List.      (* sequence *)
		Require Import Multiset.  (* bag *)
		Require Import ListSet.   (* set *)
		Require Import Omega.
		Require Import Coq.Logic.Eqdep_dec.
		
		Require Import core.EqDec.
		Require Import core.utils.Utils.
		Require Import core.Metamodel.
		Require Import core.modeling.ModelingMetamodel.
		Require Import core.Model.
		Require Import core.utils.CpdtTactics.

		(* Base types *)
		
		«var eClasses = EMFUtil.getEClassifiersInorder(ePackage)»
		
		«FOR eClass : eClasses»
			Inductive «eClass.name» : Set :=
			  Build«eClass.name» :
			  «IF eClass.ESuperTypes.size>0»(* Inheritence Attribute *) «eClass.ESuperTypes.get(0).name» -> «ENDIF»
			  «FOR eAttribute : eClass.EAttributes»
			    (* «eAttribute.name» *) «AttributeType2Coq(eAttribute)» ->
			  «ENDFOR»
			  «eClass.name».
			
		«ENDFOR»	
		
		«FOR eClass : eClasses»
 			«FOR eReference : eClass.EReferences
            »Inductive «eClass.name»«eReference.name.toFirstUpper» : Set :=
 			   Build«eClass.name»«eReference.name.toFirstUpper» :
 			   «eClass.name» ->
 			   «ReferenceType2Coq(eReference)» ->
 			   «eClass.name»«eReference.name.toFirstUpper».
 			
 			Definition maybeBuild«eClass.name»«eReference.name.toFirstUpper» («arg(eClass.name)»: «eClass.name») («arg(eReference.name)»: option («ReferenceType2Coq(eReference)»)) : option «eClass.name»«eReference.name.toFirstUpper» :=
 			  match «arg(eClass.name)», «arg(eReference.name)» with
 			  | «arg_succ(eClass.name)», Some «arg_succ(eReference.name)» => Some (Build«eClass.name»«eReference.name.toFirstUpper» «arg_succ(eClass.name)» «arg_succ(eReference.name)»)
 			  | _, _ => None
 			  end.
			«ENDFOR»

		«ENDFOR»
		
		
		(* Accessors *)
		«FOR eClass : eClasses»
			  «val v = eClass.name.toLowerCase.charAt(0)»
			  «IF eClass.ESuperTypes.size>0»
			  «val supName = eClass.ESuperTypes.get(0).name»
			  Definition «eClass.name»_get«supName.toFirstUpper» («v» : «eClass.name») : «supName» :=
			    match «v» with Build«eClass.name» «IF eClass.ESuperTypes.size>0»«supName.toLowerCase»«ENDIF» «FOR eAttributeCtr : eClass.EAttributes»«eAttributeCtr.name» «ENDFOR» => «supName.toLowerCase» end.
			  «ENDIF»	
			  «FOR eAttribute : eClass.EAttributes»
			  Definition «eClass.name»_get«eAttribute.name.toFirstUpper» («v» : «eClass.name») : «AttributeType2Coq(eAttribute)» :=
			    match «v» with Build«eClass.name» «IF eClass.ESuperTypes.size>0»«eClass.ESuperTypes.get(0).name.toLowerCase»«ENDIF» «FOR eAttributeCtr : eClass.EAttributes»«eAttributeCtr.name» «ENDFOR» => «eAttribute.name» end.
			  «ENDFOR»	 
			  
		«ENDFOR»

		«FOR eClass : eClasses
		»Definition beq_«eClass.name» («arg1(eClass.name)» : «eClass.name») («arg2(eClass.name)» : «eClass.name») : bool :=
			«IF eClass.ESuperTypes.size > 0 »
		    	«val supName = eClass.ESuperTypes.get(0).name»
		    	«val supAcc = eClass.name+"_get"+supName.toFirstUpper»
		    	«IF eClass.EAttributes.size > 0»
		    	beq_«eClass.ESuperTypes.get(0).name» («supAcc» «arg1(eClass.name)») («supAcc» «arg2(eClass.name)») &&
		    	«FOR eAttribute : eClass.EAttributes SEPARATOR " && "
		    	»( beq_«AttributeType2Coq(eAttribute)» («eClass.name»_get«eAttribute.name.toFirstUpper» «arg1(eClass.name)») («eClass.name»_get«eAttribute.name.toFirstUpper» «arg2(eClass.name)») )
				«ENDFOR»
		    	«ELSE»
		    	beq_«eClass.ESuperTypes.get(0).name» («supAcc» «arg1(eClass.name)») («supAcc» «arg2(eClass.name)»)
		    	«ENDIF»
		    «ELSE»
		    	«IF eClass.EAttributes.size > 0»
		    	«FOR eAttribute : eClass.EAttributes SEPARATOR " && "
		    	»( beq_«AttributeType2Coq(eAttribute)» («eClass.name»_get«eAttribute.name.toFirstUpper» «arg1(eClass.name)») («eClass.name»_get«eAttribute.name.toFirstUpper» «arg2(eClass.name)») )
				«ENDFOR»
		    	«ELSE»
		    	(true)
		    	«ENDIF»
		    «ENDIF»
		.
		
		«ENDFOR»
		
		(* Meta-types *)	
		Inductive «mm»_«Keywords.PostfixEClass» : Set :=
		  «FOR eClass : ePackage.EClassifiers.filter(typeof(EClass))»
		  | «eClass.name»«Keywords.PostfixEClass»
		  «ENDFOR»
		.
		
		Definition «Keywords.Elem_denoteSubType_FunName(mm)» («mm_eclass_qarg» : «mm»_«Keywords.PostfixEClass») : Set :=
		  match «mm_eclass_qarg» with
		    «FOR eClass : ePackage.EClassifiers.filter(typeof(EClass))»
		    | «eClass.name»«Keywords.PostfixEClass» => «eClass.name»
		    «ENDFOR»
		  end.	
		
		Inductive «mm»_«Keywords.PostfixEReference» : Set :=
		  «FOR eClass : ePackage.EClassifiers.filter(typeof(EClass))»
			«FOR eReference : eClass.EReferences
		    »| «eClass.name»«eReference.name.toFirstUpper»«Keywords.PostfixEReference»
		 	«ENDFOR»
		  «ENDFOR»
		.
		
		Definition «Keywords.Link_denoteSubType_FunName(mm)» («mm_eref_qarg» : «mm»_«Keywords.PostfixEReference») : Set :=
		  match «mm_eref_qarg» with
		    «FOR eClass : ePackage.EClassifiers.filter(typeof(EClass))»
				«FOR eReference : eClass.EReferences
    		    »| «eClass.name»«eReference.name.toFirstUpper»«Keywords.PostfixEReference» => «eClass.name»«eReference.name.toFirstUpper»
    		 	«ENDFOR» 
		    «ENDFOR»
		  end.
		
		Definition «mm»_getERoleTypesByEReference («mm_eref_qarg» : «mm»_«Keywords.PostfixEReference») : Set :=
		  match «mm_eref_qarg» with
		    «FOR eClass : ePackage.EClassifiers.filter(typeof(EClass))»
				«FOR eReference : eClass.EReferences
		    	»| «eClass.name»«eReference.name.toFirstUpper»«Keywords.PostfixEReference» => («eClass.name» * «ReferenceType2Coq(eReference)»)
		    	«ENDFOR»
		    «ENDFOR»
		  end.
		
		(* Generic types *)			
		Inductive «mm_eobject» : Set :=
		 | Build_«mm_eobject» : 
		    forall («mm_eclass_qarg»: «mm_eclass»), («Keywords.Elem_denoteSubType_FunName(mm)» «mm_eclass_qarg») -> «mm_eobject».
		
		Definition beq_«mm_eobject» (c1 : «mm_eobject») (c2 : «mm_eobject») : bool :=
		  match c1, c2 with
		  «FOR eClass : ePackage.EClassifiers.filter(typeof(EClass))»
		  | Build_«mm_eobject» «eClass.name»«Keywords.PostfixEClass» o1, Build_«mm_eobject» «eClass.name»«Keywords.PostfixEClass» o2 => beq_«eClass.name» o1 o2
		  «ENDFOR»
		  | _, _ => false
		  end.
		
		Inductive «mm_elink» : Set :=
		 | Build_«mm_elink» : 
		    forall («mm_eref_qarg»:«mm_eref»), («Keywords.Link_denoteSubType_FunName(mm)» «mm_eref_qarg») -> «mm_elink».
		
		(* TODO *)
		Definition beq_«mm_elink» (l1 : «mm_elink») (l2 : «mm_elink») : bool := true.
		
		(* Reflective functions *)
		Lemma «mm»_eqEClass_dec : 
		 forall («mm_eclass_qarg1»:«mm_eclass») («mm_eclass_qarg2»:«mm_eclass»), { «mm_eclass_qarg1» = «mm_eclass_qarg2» } + { «mm_eclass_qarg1» <> «mm_eclass_qarg2» }.
		Proof. repeat decide equality. Defined.
		
		Lemma «mm»_eqEReference_dec : 
		 forall («mm_eref_qarg1»:«mm_eref») («mm_eref_qarg2»:«mm_eref»), { «mm_eref_qarg1» = «mm_eref_qarg2» } + { «mm_eref_qarg1» <> «mm_eref_qarg2» }.
		Proof. repeat decide equality. Defined.
		
		Definition «mm»_getEClass («mm_eobject_qarg» : «mm_eobject») : «mm_eclass» :=
		   match «mm_eobject_qarg» with
		  | (Build_«mm_eobject» «mm_eobject_qarg» _) => «mm_eobject_qarg»
		   end.
		
		Definition «mm»_getEReference («mm_elink_qarg» : «mm_elink») : «mm_eref» :=
		   match «mm_elink_qarg» with
		  | (Build_«mm_elink» «mm_elink_qarg» _) => «mm_elink_qarg»
		   end.
		
		Definition «mm»_instanceOfEClass («mm_eclass_qarg»: «mm_eclass») («mm_eobject_qarg» : «mm_eobject»): bool :=
		  if «mm»_eqEClass_dec («mm»_getEClass «mm_eobject_qarg») «mm_eclass_qarg» then true else false.
		
		Definition «mm»_instanceOfEReference («mm_eref_qarg»: «mm_eref») («mm_elink_qarg» : «mm_elink»): bool :=
		  if «mm»_eqEReference_dec («mm»_getEReference «mm_elink_qarg») «mm_eref_qarg» then true else false.

		
		Definition «Keywords.Elem_toSubType_FunName(mm)» («mm_eclass_qarg» : «mm_eclass») («mm_eobject_qarg» : «mm_eobject») : option («Keywords.Elem_denoteSubType_FunName(mm)» «mm_eclass_qarg»).
		Proof.
		  destruct «mm_eobject_qarg» as [arg1 arg2].
		  destruct («mm»_eqEClass_dec arg1 «mm_eclass_qarg») as [e|] eqn:dec_case.
		  - rewrite e in arg2.
		    exact (Some arg2).
		  - exact None.
		Defined.
		
		Definition «Keywords.Link_toSubType_FunName(mm)» («mm_eref_qarg» : «mm_eref») («mm_elink_qarg» : «mm_elink») : option («Keywords.Link_denoteSubType_FunName(mm)» «mm_eref_qarg»).
		Proof.
		  destruct «mm_elink_qarg» as [arg1 arg2].
		  destruct («mm»_eqEReference_dec arg1 «mm_eref_qarg») as [e|] eqn:dec_case.
		  - rewrite e in arg2.
		  	exact (Some arg2).
		  - exact None.
		Defined.
		
		(* Generic functions *)
		Definition «ePackage.name»Model := Model «mm_eobject» «mm_elink».
		
		Definition «Keywords.Elem_toSumType_FunName(mm)» («mm_eclass_qarg»: «mm_eclass») (t: «Keywords.Elem_denoteSubType_FunName(mm)» «mm_eclass_qarg») : «mm_eobject» :=
		  (Build_«mm_eobject» «mm_eclass_qarg» t).
		
		Definition «Keywords.Link_toSumType_FunName(mm)» («mm_eref_qarg»: «mm_eref») (t: «Keywords.Link_denoteSubType_FunName(mm)» «mm_eref_qarg») : «mm_elink» :=
		  (Build_«mm_elink» «mm_eref_qarg» t).
		
		«val candidates = new HashSet»
		«FOR eSuper : ePackage.EClassifiers.filter(typeof(EClass))»
			«FOR eSub : ePackage.EClassifiers.filter(typeof(EClass))»
				«IF eSub.ESuperTypes.contains(eSuper)»
				«{candidates.add(eSuper);""}»
				«ENDIF»
			«ENDFOR»
		«ENDFOR»

		«FOR eSuper : candidates»
		   «FOR eSub : ePackage.EClassifiers.filter(typeof(EClass))»«IF eSub.ESuperTypes.contains(eSuper)
		   »Fixpoint «mm»_«eSuper.name»_downcast«eSub.name» («arg(eSuper.name)» : «eSuper.name») (l : list «mm_eobject») : option «eSub.name» := 
		     match l with
		   	 | Build_«mm_eobject» «eSub.name»«Keywords.PostfixEClass» (Build«eSub.name» eSuper «FOR eAttributeCtr : eSub.EAttributes»«eAttributeCtr.name» «ENDFOR») :: l' => 
		   		if beq_«eSuper.name» «arg(eSuper.name)» eSuper then (Some (Build«eSub.name» eSuper «FOR eAttributeCtr : eSub.EAttributes»«eAttributeCtr.name» «ENDFOR»)) else («mm»_«eSuper.name»_downcast«eSub.name» «arg(eSuper.name)» l')
		   	 | _ :: l' => («mm»_«eSuper.name»_downcast«eSub.name» «arg(eSuper.name)» l')
		   	 | nil => None
		   end.
		   
		   Definition «eSuper.name»_downcast«eSub.name» («arg(eSuper.name)» : «eSuper.name») (m : «ePackage.name»Model) : option «eSub.name» :=
		     «mm»_«eSuper.name»_downcast«eSub.name» «arg(eSuper.name)» (@allModelElements _ _ m).
		   
		   «ENDIF»«ENDFOR»

		«ENDFOR»
		
		
		«FOR eClass : ePackage.EClassifiers.filter(typeof(EClass))»
 			«FOR eReference : eClass.EReferences
 			»Fixpoint «Keywords.getRefOnLinks_FunName(eClass.name, eReference.name)» («arg(eClass.name)» : «eClass.name») (l : list «mm_elink») : option («ReferenceType2Coq(eReference)») :=
 			match l with
 			| (Build_«mm_elink» «eClass.name»«eReference.name.toFirstUpper»«Keywords.PostfixEReference» (Build«eClass.name»«eReference.name.toFirstUpper» «eClass.name»_ctr «eReference.name»_ctr)) :: l' => 
 				  if beq_«eClass.name» «eClass.name»_ctr «arg(eClass.name)» then Some «eReference.name»_ctr else «eClass.name»_get«eReference.name.toFirstUpper»OnLinks «arg(eClass.name)» l'
 			| _ :: l' => «eClass.name»_get«eReference.name.toFirstUpper»OnLinks «arg(eClass.name)» l'
 			| nil => None
 			end.
 			
 			Definition «Keywords.getRefOnModel_FunName(eClass.name, eReference.name)» («arg(eClass.name)» : «eClass.name») (m : «ePackage.name»Model) : option («ReferenceType2Coq(eReference)») :=
 			  «eClass.name»_get«eReference.name.toFirstUpper»OnLinks «arg(eClass.name)» (@allModelLinks _ _ m).
 			  
 			Definition «Keywords.getRefOnModelObject_FunName(eReference, eClass.name, eReference.name)» («arg(eClass.name)» : «eClass.name») (m : «ePackage.name»Model) : option («ReferenceType2CoqGeneric(eReference, mm_eobject)») :=
 			  match «Keywords.getRefOnModel_FunName(eClass.name, eReference.name)» «arg(eClass.name)» m with
 			  | «getRefOnModelObject_body(eReference, mm)»
 			  | _ => None
 			  end.
			«ENDFOR»

		«ENDFOR»
		
		(* Typeclass Instances *)	
		Instance «mm»_«Keywords.ElementSum» : Sum «mm_eobject» «mm_eclass» :=
		{
			denoteSubType := «Keywords.Elem_denoteSubType_FunName(mm)»;
			toSubType := «Keywords.Elem_toSubType_FunName(mm)»;
			toSumType := «Keywords.Elem_toSumType_FunName(mm)»;
		}.
		
		Instance «mm»_«Keywords.LinkSum» : Sum «mm_elink» «mm_eref» :=
		{
			denoteSubType := «Keywords.Link_denoteSubType_FunName(mm)»;
			toSubType := «Keywords.Link_toSubType_FunName(mm)»;
			toSumType := «Keywords.Link_toSumType_FunName(mm)»;
		}.
		
		Instance «mm»_EqDec : EqDec «mm_eobject» := {
		    eq_b := beq_«mm_eobject»;
		}.

		Instance «mm»_«Keywords.MetamodelTypeClassName»_instance : 
			«Keywords.MetamodelTypeClassName» :=
		{
			ModelElement := «mm_eobject»;
			ModelLink := «mm_elink»;
		}.
		
		Instance «mm»_«Keywords.ModelingMetamodelTypeClassName»_instance : 
			«Keywords.ModelingMetamodelTypeClassName» «mm»_«Keywords.MetamodelTypeClassName»_instance :=
		{ 
		    elements := «mm»_«Keywords.ElementSum»;
		    links := «mm»_«Keywords.LinkSum»; 
		}.
		
		(* Useful lemmas *)
		
		Lemma «ePackage.name»_invert : 
		  forall («mm_eclass_qarg»: «mm_eclass») (t1 t2: «Keywords.Elem_denoteSubType_FunName(mm)» «mm_eclass_qarg»), 
		    Build_«mm_eobject» «mm_eclass_qarg» t1 = Build_«mm_eobject» «mm_eclass_qarg» t2 -> t1 = t2.
		Admitted.
	'''
	
	
	
	def static arg (String s) '''«s.split("_").map[s1 | if (s1.length()>1)  s1.toLowerCase.substring(0,2) else s1.toLowerCase.substring(0,1)].join»_arg'''
	def static arg1 (String s) '''«s.split("_").map[s1 |if (s1.length()>1)  s1.toLowerCase.substring(0,2) else s1.toLowerCase.substring(0,1)].join»_arg1'''
	def static arg2 (String s) '''«s.split("_").map[s1 | if (s1.length()>1)  s1.toLowerCase.substring(0,2) else s1.toLowerCase.substring(0,1)].join»_arg2'''
	def static arg_succ (String s) '''«arg(s)»_succ'''
	
	def static AttributeType2Coq(EAttribute eAttribute)'''
	   «val eType = eAttribute.EType»
	   «IF eType.name == 'EInt'»nat«
		ELSEIF eType.name == 'EBoolean'»bool«
		ELSEIF eType.name == 'EString'»string«
		ELSEIF eType.name == 'Integer'»nat«
		ELSEIF eType.name == 'Boolean'»bool«
		ELSEIF eType.name == 'String'»string«
		ELSE»We don't know how to print «eType.name» «ENDIF
	»'''
	
	def static getRefOnModelObject_body(EReference eReference, String mm)'''
		«val eType = eReference.EType»
		«IF eReference.upperBound == -1»Some l => Some (map («Keywords.Elem_toSumType_FunName(mm)» «eType.name»«Keywords.PostfixEClass») l)«
			ELSE»Some «arg(eType.name)» => Some («Keywords.Elem_toSumType_FunName(mm)» «eType.name»«Keywords.PostfixEClass» «arg(eType.name)») «ENDIF
		»
	'''
	
	def static ReferenceType2CoqGeneric(EReference eReference, String genericType)'''
	   «IF eReference.upperBound == -1»list «genericType»«
		ELSE»«genericType»«ENDIF
	»'''
	
	def static ReferenceType2Coq(EReference eReference)'''
	   «val eType = eReference.EType»
	   «IF eReference.upperBound == -1»list «eType.name»«
		ELSE»«eType.name»«ENDIF
	»'''
	
	def static  <T extends EObject> String PrintCtrArgsByPair(int size, String c){	
		if(size - 1 == 0){
			return '''«c»'''
		}else if(size - 1 == 1){
			return '''(fst «c») (snd «c»)'''
		}else{
			return String.format("%s %s", PrintCtrArgsByPair(size-1, '''(fst «c»)'''), '''(snd «c»)''')
		}
		
	}
	
}