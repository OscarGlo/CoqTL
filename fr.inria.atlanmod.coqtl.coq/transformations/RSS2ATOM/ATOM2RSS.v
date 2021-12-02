Require Import String.
Require Import List.
Require Import Multiset.
Require Import ListSet.

Require Import core.utils.Utils.
Require Import core.utils.ListUtils.

Require Import core.modeling.ConcreteSyntax.
Require Import core.modeling.ModelingSemantics.
Require Import core.modeling.ModelingMetamodel.
Require Import core.modeling.ConcreteExpressions.
Require Import core.modeling.Parser.

Require Import RSS2ATOM.ATOM.
Require Import RSS2ATOM.RSS.

Require Import core.TransformationConfiguration.
Require Import core.modeling.ModelingTransformationConfiguration.

Instance A2RConfiguration : TransformationConfiguration := 
  Build_TransformationConfiguration ATOMMetamodel_Metamodel_Instance RSSMetamodel_Metamodel_Instance.

Instance ATOM2RSSConfiguration : ModelingTransformationConfiguration A2RConfiguration :=
 Build_ModelingTransformationConfiguration A2RConfiguration ATOMMetamodel_ModelingMetamodel_Instance RSSMetamodel_ModelingMetamodel_Instance.

Definition getOrElse {T: Type} (o: option T) (def: T): T := match o with
  | Some t => t
  | None => def
end.

Definition maybeHead {T: Type} (o: option (list T)) := match o with 
  | Some t => head t
  | None => None
end.

Definition maybeApply {T: Type} {U: Type} (f: T -> U) (o: option T) := match o with
  | Some t => Some (f t)
  | None => None
end.

Open Scope coqtl.

Definition ATOM2RSS :=
  transformation [
    rule "ATOM2Channel"
    from [ATOMClass]
    to [elem [ATOMClass] ChannelClass "channel"
      (fun i m a => BuildChannel
        (ATOM_getTitle a)
        (getOrElse (maybeApply Link_getHrefl (maybeHead (ATOM_getLinks a m))) None)
        (getOrElse (ATOM_getSubtitle a) ""%string)
        None
        (ATOM_getRights a)
        (maybeApply Person_getName (maybeApply Author_getPerson
          (maybeHead (ATOM_getAuthors a m))
        ))
        None
        (maybeApply Generator_getName (ATOM_getGenerator a m))
        None None None None
        (getOrElse (maybeApply Entry_getPublished (maybeHead (ATOM_getEntrie a m))) None)
        None None
      )
      [
        (* url <- At.logo *)
        link [ATOMClass] ChannelClass ChannelImageReference
        (fun tls i m a c =>
          maybeBuildChannelImage c (
            Some (BuildImage (getOrElse (ATOM_getLogo a) ""%string) "" "" None None None)
          )
        )
      ]
    ];
    rule "Entry2Item"
    from [EntryClass]
    to [elem [EntryClass] ItemClass "item"
      (fun i m e => BuildItem
        (Entry_getTitle e)
        (getOrElse (getOrElse (
          maybeApply Link_getHrefl (maybeHead (Entry_getLinks e m))
        ) None) ""%string)
        (getOrElse (getOrElse (
          maybeApply Content_getText (Entry_getContent e m)
        ) None) ""%string)
        (Entry_getPublished e)
        None
        (Entry_getSummary e)
        (Some (Entry_getId e))
      )
      nil
    ];
    rule "Category2Category"
    from [ATOM.CategoryClass]
    to [elem [ATOM.CategoryClass] RSS.CategoryClass "category"
      (fun i m c => RSS.BuildCategory
        (getOrElse (Category_getScheme c) ""%string)
        (getOrElse (Category_getLabel c) ""%string)
      )
      nil
    ]
  ].
Close Scope coqtl.
