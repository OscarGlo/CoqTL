Require Import String.
Require Import List.
Require Import Multiset.
Require Import ListSet.

Require Import core.utils.Utils.

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

Open Scope coqtl.

Definition RSS2ATOM :=
<<<<<<< HEAD
  transformation [
    rule "Channel2ATOM"
    from [ChannelClass]
    to [elem [ChannelClass] ATOMClass "atom"
      (fun i m c => BuildATOM
        (Channel_getTitle c)
        "#index"
        (Channel_getDescription c)
        (Channel_getCopyright c)
        "#icon"
        "#logo"
        (Channel_getLastBuildDate c)
      )
      [
        (* categories <- At.category->asSet() *)
        link [ChannelClass] ATOMClass ATOMCategoriesReference
        (fun tls i m c a =>
          maybeBuildATOMCategories a (
            maybeResolveAll tls m "cat" ATOM.CategoryClass
              (maybeSingleton (maybeSingleton (Channel_getCategoryObject c m)))
          )
        )(*;
        (* TODO *)
        (* links <- Sequence{link}.first() *)
        (fun tls i m c a =>
          Some (buildATOMLinks a (
            resolveAll tls m "link" ATOMLinks
              (singleton (singleton (Channel_getLink c)))
          ))
        );
        (* authors <- Sequence{auth}.first() *)
        (fun tls i m c a =>
          maybeBuildATOMAuthors a (
            (maybeResolveAll tls m "auth" ATOMAuthors
              (maybeSingleton (BuildATOMAuthors a (BuildAuthor)))
            )
          )
        ) *)
      ]
    ];
    rule "Item2Entry"
    from [ItemClass]
    to [elem [ItemClass] EntryClass "entry"
      (fun i m it => BuildEntry
        (Item_getTitle it)
        (Item_getGuid it)
        "#rights"
        (Item_getComments it)
        (Item_getPubDate it)
        "#lastUpdate"
      )
      (* TODO *)
      nil
    ];
    rule "Category2Category"
    from [RSS.CategoryClass]
    to [elem [RSS.CategoryClass] ATOM.CategoryClass "cat"
      (fun i m c => ATOM.BuildCategory
        "#term"
        (Category_getDomain c)
        (Category_getValue c)
      )
      nil
    ]
  ].
Close Scope coqtl.
=======
  transformation nil.

Close Scope coqtl.
>>>>>>> 7f3b818f993057e5b8d33591b3ea604eef260c5f
