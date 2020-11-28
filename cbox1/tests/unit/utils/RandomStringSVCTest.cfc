component extends="tests.resources.BaseIntegrationSpec"{

    property name="str" inject="models.utils.RandomStringSVC";

    function run (){
        describe( "random string generation", function() {
            beforeEach( function() {

            } );

            it( "can generate a unique random string", function(){
                
                var length = 10;
                var result = str.randstring(length);

                expect( result.len()).toBe(length);

            } );

            
        } );
    }
}