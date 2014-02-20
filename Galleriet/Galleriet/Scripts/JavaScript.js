function GetQueryStringParams(sParam) {
    var sPageURL = window.location.search.substring(1);
    var sURLVariables = sPageURL.split('&');
    for (var i = 0; i < sURLVariables.length; i++) {
        var sParameterName = sURLVariables[i].split('=');
        if (sParameterName[0] == sParam) {
            return sParameterName[1];
        }
    }
};


$( document ).ready(function() {
    //$("#ThumbnailPanel a.border").removeClass("border");
    var name = GetQueryStringParams('name');
    //alert(name);
    $("img").addClass("active");
    //alert($("#ThumbnailPanel a img").length);

    var images = document.getElementsByTagName("img");
    //alert(images.length);
    var i;

    for (i = 0; i < images.length; i++) {
        images[i].className += "active";
    }

})