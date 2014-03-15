$( document ).ready(function() {
/*
 * warp class sup_librello between sup tags
 */
$( ".suplibrello" ).wrap( "<sup></sup>" );


/*
 * warp class sub_librello between sub tags
 */
$( ".sublibrello" ).wrap( "<sub></sub>" );



/*
On reference mouse over, display reference text
a href="#Biblio
*/

$("a[href^='#Biblio']").mouseover(function () {
	  //alert( $(this).attr('href') );
	var idToCall = $(this).attr('href');
		//alert($(idToCall).text());
	$(this).attr('data-toggle','tooltip');
	$(this).attr('title',$(idToCall).text());
	$(this).attr('data-original-title',$(idToCall).text());
	$(this).attr('placement','auto');
	//	data-toggle="tooltip" title="first tooltip"
	});


/*
$("a[href^='#Biblio']").each(function() {
	var idToCall = $(this).attr('href');
	$(this).attr('data-toggle','tooltip');
	$(this).attr('title',$(idToCall).text());
	$(this).attr('placement','auto');
	});
*/
});