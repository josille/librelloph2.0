
/*
 * 
 *  	Small devices Tablets (>=768px) 
 *  	Medium devices Desktops (>=992px) 	
 *  Large devices Desktops (>=1200px)
 */

$(document).ready(function() {
	sizeAdjust();
	
	function sizeAdjust()
	{			
		if($(this).width() <= '490'){
			$('#navigation_menu').addClass('nav-stacked');
			
			/*
			 * New menu
			 * <div class="panel-group" id="accordion">
  <div class="panel panel-default">
			 */
			
			var new_heading = $('<div class="panel-heading"><a class="accordion-toggle" data-toggle="collapse" data-parent="#accordion" href="#collapseOneTopMenu">Menu <span class="glyphicon glyphicon-sort"> </span></a></div>');
			
			new_heading.insertBefore($('#navigation_top_dropdown'));
			$('#navigation_top_dropdown')
			.wrap('<div class="panel-group" id="accordion_top_menu_small"/>')
			.wrap('<div id="panel_menu_home_small" class="panel panel-default"/>')
			.wrap('<div id="collapseOneTopMenu" class="panel-collapse collapse"/>');
			
			$('.element_remove').remove();
		}
		else if($(this).width() > '490' && $(this).width() < '800'){
			//alert($(this).width() + ' medium device')
			$('#row_div_initial_page').removeClass('col-xs-12');
			$('#row_div_initial_page').addClass('col-xs-9');
		}
		//else if($(this).width() > '1200'){
			//alert($(this).width() + ' large device')
		//}
	}
});


/*
 * Two methos to make the anchor transition smoother, 
 * The first one is on teh same page
 * The second one is when navigation from a different page
 */
$(document).ready(function() {
	$('a[href*=#]').click(function(){
	    $('html, body').animate({
	        scrollTop: ($( $.attr(this, 'href') ).offset().top-70)
	    }, 500);
	    return false;
	});
});

$(document).ready(function() {
	if (window.location.hash) {
		var hash = window.location.hash;
	    $('html, body').animate({
	        scrollTop: ($(hash).offset().top-70)
	    }, 100);
		
	}
});


