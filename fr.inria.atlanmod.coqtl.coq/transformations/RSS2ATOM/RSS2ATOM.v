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

Instance R2AConfiguration : TransformationConfiguration := 
  Build_TransformationConfiguration RSSMetamodel_Metamodel_Instance ATOMMetamodel_Metamodel_Instance.

Instance RSS2ATOMConfiguration : ModelingTransformationConfiguration R2AConfiguration :=
 Build_ModelingTransformationConfiguration R2AConfiguration RSSMetamodel_ModelingMetamodel_Instance ATOMMetamodel_ModelingMetamodel_Instance.

Definition getOrElse {T: Type} (o: option T) (def: T): T := match o with
  | Some t => t
  | None => def
end.

Definition getItemsAuthor (items: option (list Item)) := match items with
  | Some items =>
  match (head items) with
    | Some item =>
    match (Item_getAuthor item) with
      | Some author => Some (BuildAuthor (BuildPerson author None None))
      | None => None
    end
    | None => None
  end
  | None => None
end.

Open Scope coqtl.

Definition RSS2ATOM :=
  transformation [
    rule "Channel2ATOM"
    from [ChannelClass]
    to [elem [ChannelClass] ATOMClass "atom"
      (fun i m c => BuildATOM
        (Channel_getTitle c)
        ""
        (Some (Channel_getDescription c))
        (Channel_getCopyright c)
        None
        None
        (getOrElse (Channel_getLastBuildDate c) ""%string)
      )
      [
        (* categories <- At.category->asSet() *)
        link [ChannelClass] ATOMClass ATOMCategoriesReference
        (fun tls i m c a =>
          maybeBuildATOMCategories a (
            maybeResolveAll tls m "cat" ATOM.CategoryClass (
              maybeSingleton (maybeSingleton (
                Channel_getCategoryObject c m
              ))
            )
          )
        );
        (* links <- Sequence{link}.first() *)
        link [ChannelClass] ATOMClass ATOMLinksReference
        (fun tls i m c a =>
          maybeBuildATOMLinks a (
            Some [BuildLink None (Channel_getLink c) None None None None]
          )
        );
        (* authors <- Sequence{auth}.first() *)
        link [ChannelClass] ATOMClass ATOMAuthorsReference
        (fun tls i m c a =>
          maybeBuildATOMAuthors a (
            maybeSingleton (getItemsAuthor (Channel_getItems c m))
          )
        )
      ]
    ];
    rule "Item2Entry"
    from [ItemClass]
    to [elem [ItemClass] EntryClass "entry"
      (fun i m it => BuildEntry
        (Item_getTitle it)
        (getOrElse (Item_getGuid it) ""%string)
        None
        (Item_getComments it)
        (Item_getPubDate it)
        ""
      )
      [
        (* links <- Sequence{link}.first() *)
        link [ItemClass] EntryClass EntryLinksReference
        (fun tls i m i e =>
          maybeBuildEntryLinks e (
            Some [BuildLink None (Some (Item_getLink i)) None None None None]
          )
        ) 
      ]
    ];
    rule "Category2Category"
    from [RSS.CategoryClass]
    to [elem [RSS.CategoryClass] ATOM.CategoryClass "cat"
      (fun i m c => ATOM.BuildCategory
        ""
        (Some (Category_getDomain c))
        (Some (Category_getValue c))
      )
      nil
    ]
  ].
Close Scope coqtl.
