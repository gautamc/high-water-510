$(document).ready(function() {
    
    $(".lang_selector").change(function() {
	var current_url = window.location.href;
	if ( window.location.search.length == 0 ) {
	    current_url += "?locale=" + $(".lang_selector").val();
	} else {
	    var params = {};
	    current_url = current_url.split('?')[0] + '?';
	    $.map(window.location.search.split('?')[1].split('&'), function(n,i) {
		var kvp = n.split('=');
		kvp[0] = kvp[0].replace(/^\?/, '');
		params[kvp[0]] = kvp[1];
	    });
	    var args = [];
	    $.each(params, function(k, v) {
		if( k != "locale" ) {
		    args.push(k + "=" + params[k]);
		}
	    });
	    args.push( "locale=" + $(".lang_selector").val() );
	    current_url += args.join("&");
	}
	window.location = current_url;
    });
    
});