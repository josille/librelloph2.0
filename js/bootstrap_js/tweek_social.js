
/*
 * tweeter
 */
!function(d,s,id){var js,fjs=d.getElementsByTagName(s)[0],p=/^http:/.test(d.location)?'http':'https';if(!d.getElementById(id)){js=d.createElement(s);js.id=id;js.src=p+'://platform.twitter.com/widgets.js';fjs.parentNode.insertBefore(js,fjs);}}(document, 'script', 'twitter-wjs');


/*
 *LinkeDin
*/
$("head").append('<script type="text/javascript" src="//platform.linkedin.com/in.js">lang: en_US</script>');


(function(d, s, id) {
	  var js, fjs = d.getElementsByTagName(s)[0];
	  if (d.getElementById(id)) return;
	  js = d.createElement(s); js.id = id;
	  js.src = "//connect.facebook.net/en_US/all.js#xfbml=1&appId=344934532276338";
	  fjs.parentNode.insertBefore(js, fjs);
	}(document, 'script', 'facebook-jssdk'));