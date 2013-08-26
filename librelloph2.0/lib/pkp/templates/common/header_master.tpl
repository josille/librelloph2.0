{** * header.tpl * * Copyright (c) 2000-2012 John Willinsky *
Distributed under the GNU GPL v2. For full terms see the file
docs/COPYING. * * Common site header. *} {strip} {if
!$pageTitleTranslated}{translate|assign:"pageTitleTranslated"
key=$pageTitle}{/if} {if $pageCrumbTitle}
{translate|assign:"pageCrumbTitleTranslated" key=$pageCrumbTitle}
{elseif !$pageCrumbTitleTranslated} {assign
var="pageCrumbTitleTranslated" value=$pageTitleTranslated} {/if}
{/strip}
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
	"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type"	content="text/html; charset={$defaultCharset|escape}" />
<title>{$pageTitleTranslated}</title>
<meta name="description" content="{$metaSearchDescription|escape}" />
<meta name="keywords" content="{$metaSearchKeywords|escape}" />
<meta name="generator"
	content="{$applicationName} {$currentVersionString|escape}" />
{$metaCustomHeaders} {if $displayFavicon}
<link rel="icon" href="{$faviconDir}/{$displayFavicon.uploadName|escape:" url"}" />
{/if}
<!-- link rel="stylesheet" href="{$baseUrl}/lib/pkp/styles/pkp.css" type="text/css" /-->
<!-- link rel="stylesheet" href="{$baseUrl}/lib/pkp/styles/common.css" type="text/css" /-->

<!-- link rel="stylesheet" href="{$baseUrl}/styles/common.css" type="text/css" /-->





<!-- script type="text/javascript" src="{$baseUrl}/lib/pkp/js/general.js"></script-->
<!-- script type="text/javascript" src="{$baseUrl}/lib/pkp/js/tag-it.js"></script-->

<!-- Add javascript required for font sizer -->
<!-- script type="text/javascript" src="{$baseUrl}/lib/pkp/js/jquery.cookie.js"></script-->
<!-- script type="text/javascript" src="{$baseUrl}/lib/pkp/js/fontController.js" ></script-->
{$additionalHeadData}

<script type="text/javascript" src="{$baseUrl}/lib/pkp/js/lib/jquery/jquery-2.0.2.min.js"></script>
	<script type="text/javascript" src="{$baseUrl}/lib/pkp/js/lib/jquery/plugins/jqueryUi.min.js"></script>
	
	  <!-- script src="http://code.jquery.com/jquery.js"></script-->

<meta name="viewport" content="width=device-width, initial-scale=1.0" /><!-- Bootstrap -->
<link href="{$baseUrl}/styles/bootstrap_css/bootstrap.min.css"
	rel="stylesheet" media="screen"><!-- link rel="stylesheet" href="//netdna.bootstrapcdn.com/bootstrap/3.0.0-rc1/css/bootstrap.min.css"-->

<link href="{$baseUrl}/styles/bootstrap_css/tweeks.css" rel="stylesheet"
	media="screen">

<script type="text/javascript" src="{$baseUrl}/js/bootstrap_js/tweeks.js"></script>
<script type="text/javascript" src="{$baseUrl}/js/bootstrap_js/tweek_social.js"></script>
</head>

<body>
<div id="fb-root"></div>
<div class="navbar navbar-inverse navbar-fixed-top">
<div class="container">
<p class="navbar-text pull-right margin_top_10 margin_bottom_10"><a target="blank" style="background:none;" href="http://localhost/librelloph2.0/index.php/index/oai?verb=Identify">
<img width="45px" height="35px" alt="OAI" src="http://www.openarchives.org/images/OA100.gif">
</a></p>
<!-- p class="navbar-text pull-right margin_top_10 margin_bottom_10"><a class="btn btn-default btn-xs"
	href="{url page="gateway"}/plugin/WebFeedGatewayPlugin/rss2">
RSS </a></p-->
<p class="navbar-text pull-right margin_top_10 margin_bottom_10"><a class="btn btn-default btn-xs"
	href="https://twitter.com/librello" target="blank"><img src="{$publicFilesDir}/Twitter_icon.png" width="26" height="26" alt="Twitter"/></a>
</p>
<p class="navbar-text pull-right margin_top_10 margin_bottom_10"><a class="btn btn-default btn-xs"
	href="http://www.linkedin.com/company/librello" target="blank"><img src="{$publicFilesDir}/Linkedin_icon.png" width="26" height="26" alt="LinkedIn"/></a></p>
	<p class="navbar-text pull-right margin_top_10 margin_bottom_10"><a class="btn btn-default btn-xs"
	href="https://plus.google.com/117721213017356591223" target="blank"><img src="{$publicFilesDir}/Google_icon.png" width="26" height="26" alt="Google +"/></a></p>

</div>
</div>

<div class="container"><!-- JavaScript plugins (requires jQuery) --> <!-- script type="text/javascript" src="{$baseUrl}/lib/pkp/js/lib/jquery/jquery.min.js"></script-->
<script type="text/javascript"
	src="{$baseUrl}/lib/pkp/js/lib/jquery/jquery-2.0.2.min.js"></script> <script
	type="text/javascript"
	src="{$baseUrl}/lib/pkp/js/lib/jquery/plugins/jqueryUi.min.js"></script>

<!-- script src="http://code.jquery.com/jquery.js"></script--> <!-- Include all compiled plugins (below), or include individual files as needed -->
<script src="{$baseUrl}/js/bootstrap_js/bootstrap.min.js"></script> <!-- script src="//netdna.bootstrapcdn.com/bootstrap/3.0.0-rc1/js/bootstrap.min.js"></script-->


<div itemscope="" itemtype="http://schema.org/LocalBusiness"
	id="container">

<div id="header">
<div id="headerTitle">

<div>

<h1>{if $displayPageHeaderLogo && is_array($displayPageHeaderLogo)} <img
	itemprop="image"
	src="{$publicFilesDir}/{$displayPageHeaderLogo.uploadName|escape:"
	url"}" width="{$displayPageHeaderLogo.width|escape}"
	height="{$displayPageHeaderLogo.height|escape}"
	{if $displayPageHeaderLogoAltText !=''
	}alt="{$displayPageHeaderLogoAltText|escape}"
	{else}alt="{translate key=" common.pageHeaderLogo.altText"}"{/if} />
{/if} {if $displayPageHeaderTitle && is_array($displayPageHeaderTitle)}
<img itemprop="image"
	src="{$publicFilesDir}/{$displayPageHeaderTitle.uploadName|escape:"
	url"}" width="{$displayPageHeaderTitle.width|escape}"
	height="{$displayPageHeaderTitle.height|escape}"
	{if $displayPageHeaderTitleAltText !=''
	}alt="{$displayPageHeaderTitleAltText|escape}"
	{else}alt="{translate key=" common.pageHeader.altText"}"{/if} />
{elseif $displayPageHeaderTitle} {$displayPageHeaderTitle} {elseif
$alternatePageHeader} {$alternatePageHeader} {elseif $siteTitle}
{$siteTitle} {else} {$applicationName} {/if}</h1>
</div>

{include file="common/navbar.tpl"}</div>
</div>

<div id="body">

<div class="row">
  <div class="col-2 col-sm-3 col-lg-2">
  {if $journals}
		<h3 class='font_our_journals'>Our Journals:</h3>
		<ul class="nav nav-pills nav-stacked">
			{iterate from=journals item=journal}
			<li><a href="{url journal=$journal->getPath()}" class="mainjournal"
				style="font-style: italic; background: none;"> <img
				style="margin-bottom: 10px; border-style: none;"
				src="/public/journals/{$journal->getJournalId()}/{$journal->getJournalInitials()}small.png" />

			</a></li>
			{/iterate}
		</ul>
		{/if}
	</div>
  <div class="col-12 col-sm-8 col-lg-9">
<h2><span itemprop="name">{$pageTitleTranslated}</span></h2>

		{if $pageSubtitle &&
		!$pageSubtitleTranslated}{translate|assign:"pageSubtitleTranslated"
		key=$pageSubtitle}{/if} {if $pageSubtitleTranslated}
		<h3>{$pageSubtitleTranslated}</h3>
		{/if}

		<hr />
		<div id="content">






		