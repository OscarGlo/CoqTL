(********************************************************************
	@name Coq declarations for model
	@date 2021/10/16 14:45:18
	@description Automatically generated by XMI2Coq transformation.
 ********************************************************************)
		 
Require Import List.
Require Import core.Model.
Require Import String.
Require Import transformations.RSS2ATOM.RSS.


Definition InputModel : Model RSSMetamodel_Object RSSMetamodel_Link :=
	(Build_Model
		(
		(Build_RSSMetamodel_Object ChannelClass (BuildChannel "Atoute.org" "http://www.atoute.org/" "" "" "" "" "" "" "" 0 "" 0 "" "" "")) :: 
		(Build_RSSMetamodel_Object ItemClass (BuildItem "Outils de recherche pour professionnels" "http://www.atoute.org/medecine_pro.htm" "" "" "" "" "")) :: 
		(Build_RSSMetamodel_Object ItemClass (BuildItem "Dictionnaires médicaux" "http://www.atoute.org/dictionnaire_medical.htm" "" "" "" "" "")) :: 
		(Build_RSSMetamodel_Object ItemClass (BuildItem "La page du médecin" "http://www.atoute.org/page_du_medecin/spe/mg/mg_1024.htm" "" "" "" "" "")) :: 
		(Build_RSSMetamodel_Object RSSClass (BuildRSS "0.91")) :: 
		nil)
		(
		(Build_RSSMetamodel_Link ChannelRssReference (BuildChannelRss  (BuildChannel "Atoute.org" "http://www.atoute.org/" "" "" "" "" "" "" "" 0 "" 0 "" "" "")  (BuildRSS "0.91"))) ::
		(Build_RSSMetamodel_Link ChannelItemsReference (BuildChannelItems  (BuildChannel "Atoute.org" "http://www.atoute.org/" "" "" "" "" "" "" "" 0 "" 0 "" "" "") ( (BuildItem "La page du médecin" "http://www.atoute.org/page_du_medecin/spe/mg/mg_1024.htm" "" "" "" "" "") ::  (BuildItem "Outils de recherche pour professionnels" "http://www.atoute.org/medecine_pro.htm" "" "" "" "" "") ::  (BuildItem "Dictionnaires médicaux" "http://www.atoute.org/dictionnaire_medical.htm" "" "" "" "" "") :: nil ))) ::
		(Build_RSSMetamodel_Link ItemChannelReference (BuildItemChannel  (BuildItem "Outils de recherche pour professionnels" "http://www.atoute.org/medecine_pro.htm" "" "" "" "" "")  (BuildChannel "Atoute.org" "http://www.atoute.org/" "" "" "" "" "" "" "" 0 "" 0 "" "" ""))) ::
		(Build_RSSMetamodel_Link ItemChannelReference (BuildItemChannel  (BuildItem "Dictionnaires médicaux" "http://www.atoute.org/dictionnaire_medical.htm" "" "" "" "" "")  (BuildChannel "Atoute.org" "http://www.atoute.org/" "" "" "" "" "" "" "" 0 "" 0 "" "" ""))) ::
		(Build_RSSMetamodel_Link ItemChannelReference (BuildItemChannel  (BuildItem "La page du médecin" "http://www.atoute.org/page_du_medecin/spe/mg/mg_1024.htm" "" "" "" "" "")  (BuildChannel "Atoute.org" "http://www.atoute.org/" "" "" "" "" "" "" "" 0 "" 0 "" "" ""))) ::
		(Build_RSSMetamodel_Link RSSChannelReference (BuildRSSChannel  (BuildRSS "0.91")  (BuildChannel "Atoute.org" "http://www.atoute.org/" "" "" "" "" "" "" "" 0 "" 0 "" "" ""))) ::
		nil)
	).