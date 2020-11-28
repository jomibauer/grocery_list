component extends="quick.models.BaseEntity" accessors="true" {

	property name="bcrypt" inject="@BCrypt" persistent="false";

	property name="id";
	property name="email";
	property name="password";
	property name="name";
	property name="list" default=' ';
	property name="justBought" default = ' ';
	property name="dateBought" default = "#Now()#";

	public User function setPassword( required string password ){
		return assignAttribute( "password", bcrypt.hashPassword( arguments.password ) );
	}

	public User function addToList( required string newList required numeric id ){
		//var user = retrieveUserById( arguments.id );
		
		return assignAttribute( "list", newList );
	}

	public boolean function hasPermission( required string permission ){
		return true;
	}

	public boolean function isValidCredentials( required string email, required string password ){
		var user = newEntity().where( "email", arguments.email ).first();
		if ( !user.isLoaded() ) {
			return false;
		}
		return bcrypt.checkPassword( arguments.password, user.getPassword() );
	}

	public User function retrieveUserByName( required string name ){
		return newEntity().where( "name", arguments.name ).firstOrFail();
	}

	public User function retrieveUserByUsername( required string email ){
		return newEntity().where( "email", arguments.email ).firstOrFail();
	}

	public User function retrieveUserById( required numeric id ){
		return newEntity().findOrFail( arguments.id );
	}

	public struct function getMemento(){
		return { "email" : variables.getEmail() };
	}
	public struct function getName(){
		return { "name" : name };
	}

	public struct function getList(){
		return { "list": list };
	}

	public struct function getJustBought(){
		return { "justBought": justBought };
	}

	public struct function getDateBought(){
		return { "dateBought": ParseDateTime(dateBought) };
	}

}
