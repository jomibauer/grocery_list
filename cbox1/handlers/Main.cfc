component extends="coldbox.system.EventHandler" secured {

	// Default Action
	function index( event, rc, prc ){
		session.user = getInstance( "User").retrieveUserById(session.CBSTORAGE.cbauth__userId)
		session.user.name = getInstance( "User").retrieveUserById(session.CBSTORAGE.cbauth__userId).getName().name;
		session.list = getInstance( "User").retrieveUserById(session.CBSTORAGE.cbauth__userId).getList().list

		prc.welcome = session.user.name & "'s shopping list";
		prc.displayMsg = '';

		prc.xeh.p_addListItem = "main/p_addListItem";
		prc.xeh.p_removeBoughtItems = "main/p_removeBoughtItems";
		
		event.setView( view="main/list", layout="layout" );
	}


	function v_list( event, rc, prc){
		prc.welcome = session.user.name & "'s shopping list";
		prc.displayMsg = '';

		prc.xeh.p_addListItem = "main/p_addListItem";
		prc.xeh.p_removeBoughtItems = "main/p_removeBoughtItems";

		event.setView(view="main/list", layout="layout");
	}

	function p_addListItem( event, rc, prc){
		prc.welcome = session.user.name & "'s shopping list";

		prc.xeh.p_addListItem = "main/p_addListItem";
		prc.xeh.p_removeBoughtItems = "main/p_removeBoughtItems";
		
		if (event.getValue( "listItem" ) == ''){
			prc.displayMsg = "Type at least one item into the box";
		}
		else{
			prc.displayMsg = '';
			session.list = listAppend(session.list, event.getValue( "listItem" ));
			session.user.update({ list: session.list });
		}
		
		event.setView(view="main/list", layout="layout");
	}

	function p_removeBoughtItems(event, rc, prc){
		var oldListArray = session.list.listToArray(",");
		var toDelete = event.getValue("items").listToArray(",");
		
		oldListArray.removeAll(toDelete);
		session.list = oldListArray.toList(",");

		if (session.list == ''){
			session.list = ' ';
		}
		session.user.update({ list: session.list });
		flash.put("purchased", arrayToList( toDelete ));

		relocate(uri="p_updateJustBought");
	}

	function p_updateJustBought(event, rc, prc){
		prc.displayMsg = '';
		prc.welcome = session.user.name & "'s shopping list";

		prc.xeh.p_addListItem = "main/p_addListItem";
		prc.xeh.p_removeBoughtItems = "main/p_removeBoughtItems";

		var purchased = flash.get("purchased");
		flash.remove("purchased");

		prc.dateBought = session.user.getDateBought().dateBought;
		var comparedDate = dateCompare(prc.dateBought, Now(), "d");
		if (comparedDate < 0){
			session.user.update({
				dateBought: prc.dateBought,
				justBought: purchased
				});
		}
		else{
			prc.justBought = ListAppend(session.user.getJustBought().justBought, purchased);
			session.user.update({ justBought: prc.justBought });
		}
		event.setView(view="main/list", layout="layout");

	}

	function dump(event, rc, prc){
		
		user = getInstance( "User").retrieveUserById(session.CBSTORAGE.cbauth__userId);
		prc.username = user.getMemento();
		prc.name = user.getName();
		event.setView( "main/dump" );
	}

	/************************************** IMPLICIT ACTIONS *********************************************/

	function onAppInit( event, rc, prc ){
	}

	function onRequestStart( event, rc, prc ){
	}

	function onRequestEnd( event, rc, prc ){
	}

	function onSessionStart( event, rc, prc ){
	}

	function onSessionEnd( event, rc, prc ){
		var sessionScope = event.getValue( "sessionReference" );
		var applicationScope = event.getValue( "applicationReference" );
	}

	function onException( event, rc, prc ){
		event.setHTTPHeader( statusCode = 500 );
		// Grab Exception From private request collection, placed by ColdBox Exception Handling
		var exception = prc.exception;
		// Place exception handler below:
	}

}
