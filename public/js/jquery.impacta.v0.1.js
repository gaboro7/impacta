var impacta = function(options)
{
   
    return new impacta.prototype.init(options);
};

impacta.prototype = {
   
    init : function(options) {
        
        this.controlador = options.controlador;
        this.id_buscador = options.id_buscador;
        var campo_busqueda = $('<input   type="text" size="25">')
         
        .css('background','url("http://www.liveclickerdocs.com/mockups/images/lFkqn.png") no-repeat scroll 0 0 transparent')
        .css('border','1px solid #CCCCCC')
        .css('color','#EEEEEE')
        .css('font-family','Verdana,Arial,sans-serif')
        .css('font-size','1em')
        .css('padding','3px 5px 5px 30px')
        .css('width','410px')
        .keyup(function(){
            console.log(options.controlador);
            $.ajax({
                url: options.controlador+".json",
               
                success: function(data){
                   console.log( campo_busqueda.val());
                } ,
                error: function( xhr, status, index, anchor ) {
                    alert("error");
                }
            });

        });

        $("#"+this.id_buscador).append(campo_busqueda);


        this.readyList = new Array();
        /* */
        return this;

    },
    callback: function ( api_json ) {
        
        if ( this.readyList ) {
            // Execute all of them
            var fn, i = 0;
            console.log(api_json);
            while ( (fn = impacta.prototype.readyList[ i++ ]) ) {
                console.log(fn);
                var thisFn = impacta.proxy( fn, this );
                thisFn.call();
            }
            // Reset the list of functions
            impacta.readyList = [];
        }
    },
    isReady: function( fn ) {
        
        impacta.prototype.readyList = Array( fn );
        console.log(this.readyList);
    }
}

impacta.proxy = function( fn, proxy, thisObject ) {
    if ( arguments.length === 2 ) {
        if ( typeof proxy === "string" ) {
            thisObject = fn;
            fn = thisObject[ proxy ];
            proxy = undefined;

        } else if ( proxy && !$.isFunction( proxy ) ) {
            thisObject = proxy;
            proxy = undefined;
        }
    }

    if ( !proxy && fn ) {
        proxy = function() {
            return fn.apply( thisObject || this, arguments );
        };
    }

    // Set the guid of unique handler to the same of original handler, so it can be removed
    if ( fn ) {
        proxy.guid = fn.guid = fn.guid || proxy.guid || $.guid++;
    }

    // So proxy can be declared as an argument
    return proxy;
};

