Require Import String.
Require Import List.
Require Import Multiset.
Require Import ListSet.
Require Import Omega.

Require Import core.utils.tTop.
Require Import core.Notations.
Require Import core.CoqTL.

Require Import examples.Class2RelationalMV.ClassMetamodel.
Require Import examples.Class2RelationalMV.RelationalMetamodel.
Require Import examples.Class2RelationalMV.ClassMetamodelPattern.

Definition Class2RelationalMVConcrete :=
  transformation Class2Relational from ClassMetamodel to RelationalMetamodel
    with m as ClassModel := [

      rule Class2Table
        from
          element c class ClassEClass
        to [
          output "tab"
            element t class TableEClass :=
              BuildTable newId (getClassName c)
            links [
              reference TableColumnsEReference :=
                attrs <- getClassAttributes c m;
                cols <- (resolveAll Class2Relational m "col" ColumnEClass
                  (map (fun a:Attribute => [[ a ]]) attrs));
                key <- resolve Class2Relational m "key" ColumnEClass [[ c ]];
                return BuildTableColumns t (key :: cols)
            ];
          output "key"
            element k class ColumnEClass :=
              BuildColumn newId (getClassName c ++ "id")
            links nil
        ];

      rule SinglevaluedAttribute2Column
        from
          element a class AttributeEClass 
            when negb (getAttributeMultiValued a)
        to [
          output "col"
            element c class ColumnEClass := 
              BuildColumn newId (getAttributeName a)
            links [
              reference ColumnReferenceEReference :=
                cl <- getAttributeType a m;
                tb <- resolve Class2Relational m "tab" TableEClass [[ cl ]];
                return BuildColumnReference c tb
            ]
        ];

      rule MultivaluedAttribute2Column
        from
          element a class AttributeEClass 
            when getAttributeMultiValued a
        to [
          output "col"
            element c class ColumnEClass := 
              BuildColumn newId (getAttributeName a)
            links [
              reference ColumnReferenceEReference :=
                tb <- resolve Class2Relational m "pivot" TableEClass [[ a ]];
                return BuildColumnReference c tb
            ];
                 
          output "pivot"
            element t class TableEClass := 
              BuildTable newId (getAttributeName a ++ "Pivot")
            links [
               reference TableColumnsEReference :=
                 psrc <- resolve Class2Relational m "psrc" ColumnEClass [[ a ]];
                 ptrg <- resolve Class2Relational m "ptrg" ColumnEClass [[ a ]];
                 return BuildTableColumns t [psrc; ptrg]
            ];
                 
          output "psrc"
            element c class ColumnEClass := 
               BuildColumn newId "key"
            links nil;
                 
          output "ptrg"
            element c class ColumnEClass := 
              BuildColumn newId (getAttributeName a)
            links [
              reference ColumnReferenceEReference :=
                cl <- getAttributeType a m;
                tb <- resolve Class2Relational m "tab" TableEClass [[ cl ]];
                return BuildColumnReference c tb
            ] 
        ]
  ].

Definition Class2RelationalMV := parseTransformation Class2RelationalMVConcrete.

                                              