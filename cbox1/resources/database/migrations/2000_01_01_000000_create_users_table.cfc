component {

	function up( schema, query ){
		schema.create( "users", function(table) {
			table.increments( "id" );
			table.string( "email" ).unique();
			table.string( "password" );
			table.string( "name" );
			table.string( "list" );
			table.string( "justBought" );
			table.string( "dateBought" );
		} );
	}

	function down( schema, query ){
		schema.drop( "users" );
	}

}
