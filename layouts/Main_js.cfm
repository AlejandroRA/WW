<script>
if (localStorageSupport) {
    var header = localStorage.getItem("fix_header");
    var collapse = localStorage.getItem("collapse_filters");
    var pageguide = localStorage.getItem("show_pageguide");
}

$(document).ready(function(){
    $("ul.nav li.active").parents("li").addClass("active");
    $("ul.nav li.active").parents("ul").addClass(" in");
    $('.filters').hide();
    $('.pageguide').hide();
  
    if (header == 'on') {
        $('#headerSII').removeClass('header').addClass('header-fixed');
    }
});

$(function () {
	
	//*************** Config configuration menu ***************//
    // Enable/disable fixed header
    $('#fixedheader').click(function () {
        if ($('#fixedheader').is(':checked')) {
            $('#headerSII').removeClass('header').addClass('header-fixed');
            if (localStorageSupport) {
                localStorage.setItem("fix_header",'on');
            }
        } else {
            $('#headerSII').removeClass('header-fixed').addClass('header');
            if (localStorageSupport) {
                localStorage.setItem("fix_header",'off');
            }
        }
    });
    
    // Enable/disable page guide
    $('#showpageguide').click(function () {
        if ($('#showpageguide').is(':checked')) {
            $(".theme-config-box").toggleClass("show");
            if (localStorageSupport) {
                localStorage.setItem("show_pageguide",'on');
            }
        } else {
            if (localStorageSupport) {
                localStorage.setItem("show_pageguide",'off');
            }
        }
    });

    // Enable/disable collapse filters
    $('#collapsefilters').click(function () {
        // Block resize
        $.each(FusionCharts.items, function (i, obj) {
            FusionCharts.items[i].lockResize(true);
        });

        if ($('#collapsefilters').is(':checked')) {
            hideConfig();
            hide = false;

            if (localStorageSupport) {
                localStorage.setItem("collapse_filters",'on');
            }

        } else {
            showConfig();
            hide = true;

            if (localStorageSupport) {
                localStorage.setItem("collapse_filters",'off');
            }
        }
    });

    // Show configuration menu
    $('.spin-icon').click(function () {
        $(".theme-config-box").toggleClass("show");
    });

    if (localStorageSupport) {        

        var header = localStorage.getItem("fix_header");
        var collapse = localStorage.getItem("collapse_filters");
        var pageguide = localStorage.getItem("show_pageguide");

        if (header == 'on') {
            $('#fixedheader').prop('checked','checked')
        }
        if (collapse == 'on') {
            $('#collapsefilters').prop('checked','checked')
        }
        if (pageguide == 'on') {
            $('#showpageguide').prop('checked','checked')
        }
    }   

});

// check if browser support HTML5 local storage
function localStorageSupport() {
    return (('localStorage' in window) && window['localStorage'] !== null)
}

</script>
