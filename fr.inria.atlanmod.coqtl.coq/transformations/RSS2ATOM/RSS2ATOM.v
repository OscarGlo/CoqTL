Require Import String.
Require Import List.
Require Import Multiset.
Require Import ListSet.
Require Import Omega.

Require Import Coq.Strings.Ascii.

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

Open Scope coqtl.

Instance R2AConfiguration : TransformationConfiguration := 
  Build_TransformationConfiguration RSSMetamodel_Metamodel_instance ATOMMetamodel_Metamodel_instance.

Instance RSS2ATOMConfiguration : ModelingTransformationConfiguration R2AConfiguration :=
  Build_ModelingTransformationConfiguration R2AConfiguration RSSMetamodel_ModelingMetamodel_instance ATOMMetamodel_ModelingMetamodel_instance.

(* Definition natToString(n: nat): string :=
  if (n < 10)
  then (ascii_of_nat n)
  else (string (ascii_of_nat (n mod 10)) (natToString (n / 10))). *)

Definition RSS2AATOM :=
  transformation [
    rule "Channel2ATOM"
    from [ChannelClass]
    to [elem [ChannelClass] ATOMClass "atom"
      (fun index model channel => BuildATOM
        (Channel_getTitle channel)
        "#index"
        (Channel_getDescription channel)
        (Channel_getCopyright channel)
        "#icon"
        "#logo"
        (Channel_getLastBuildDate channel)
      )
      (* Map categories *)
      [link [ChannelClass] ATOMClass ATOMCategoriesReference
        (fun tls i m c a =>
          maybeBuildATOMCategories a
            (maybeResolveAll tls m "cat" ATOM.CategoryClass
              (maybeSingleton (Channel_getItemsObjects c m))
            )
        )
      ]
    ]
  ].