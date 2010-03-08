var sfHover = function() {
    jQuery("ul.horizontal_menu li").mouseover(function() {
        jQuery(this).addClass('sfhover');
    }).mouseout(function() {
        jQuery(this).removeClass('sfhover');
    });
};

jQuery(document).ready(sfHover);