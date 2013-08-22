{**
 * header.tpl
 *
 * Copyright (c) 2000-2012 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Common site header.
 *}
{strip}
{if !$pageTitleTranslated}{translate|assign:"pageTitleTranslated" key=$pageTitle}{/if}
{if $pageCrumbTitle}
	{translate|assign:"pageCrumbTitleTranslated" key=$pageCrumbTitle}
{elseif !$pageCrumbTitleTranslated}
	{assign var="pageCrumbTitleTranslated" value=$pageTitleTranslated}
{/if}
{/strip}
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
	"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset={$defaultCharset|escape}" />
	<title>{$pageTitleTranslated}</title>
	<meta name="description" content="{$metaSearchDescription|escape}" />
	<meta name="keywords" content="{$metaSearchKeywords|escape}" />
	<meta name="generator" content="{$applicationName} {$currentVersionString|escape}" />
	{$metaCustomHeaders}
	{if $displayFavicon}<link rel="icon" href="{$faviconDir}/{$displayFavicon.uploadName|escape:"url"}" />{/if}
	
	<!-- link rel="stylesheet" href="{$baseUrl}/lib/pkp/styles/pkp.css" type="text/css" /-->
	<!-- link rel="stylesheet" href="{$baseUrl}/lib/pkp/styles/common.css" type="text/css" /-->
	
	<!--[if IE ]-->
	   <!-- link rel="stylesheet" href="{$baseUrl}/styles/common_ie.css" type="text/css" /-->
	<!-- [endif]-->	
	<!--[if !IE]>-->
	   <!-- link rel="stylesheet" href="{$baseUrl}/styles/common.css" type="text/css" /-->
	<!--<![endif]-->

	<!-- Base Jquery -->
	
	<!-- script type="text/javascript" src="{$baseUrl}/lib/pkp/js/lib/jquery/jquery.min.js"></script-->
	<!-- script type="text/javascript" src="{$baseUrl}/lib/pkp/js/lib/jquery/plugins/jqueryUi.min.js"></script-->
	

	{call_hook|assign:"leftSidebarCode" name="Templates::Common::LeftSidebar"}
	{call_hook|assign:"rightSidebarCode" name="Templates::Common::RightSidebar"}
	{if $leftSidebarCode || $rightSidebarCode}
	<!-- link rel="stylesheet" href="{$baseUrl}/styles/sidebar.css" type="text/css" /-->{/if}
	{if $leftSidebarCode}
	<!-- link rel="stylesheet" href="{$baseUrl}/styles/leftSidebar.css" type="text/css" /-->{/if}
	{if $rightSidebarCode}
	<!-- link rel="stylesheet" href="{$baseUrl}/styles/rightSidebar.css" type="text/css" /-->{/if}
	{if $leftSidebarCode && $rightSidebarCode}
	<!-- link rel="stylesheet" href="{$baseUrl}/styles/bothSidebars.css" type="text/css" /-->{/if}

	{foreach from=$stylesheets item=cssUrl}
		<!-- link rel="stylesheet" href="{$cssUrl}" type="text/css" /-->
	{/foreach}

	<!-- script type="text/javascript" src="{$baseUrl}/lib/pkp/js/general.js"></script-->
	<!-- script type="text/javascript" src="{$baseUrl}/lib/pkp/js/tag-it.js"></script-->
	<!-- Add javascript required for font sizer -->
	<!-- script type="text/javascript" src="{$baseUrl}/lib/pkp/js/jquery.cookie.js"></script-->
	<!-- script type="text/javascript" src="{$baseUrl}/lib/pkp/js/fontController.js"></script-->



	{$additionalHeadData}
	
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	
	<!-- JavaScript plugins (requires jQuery) -->

	<!-- script type="text/javascript" src="{$baseUrl}/lib/pkp/js/lib/jquery/jquery.min.js"></script-->
	<script type="text/javascript" src="{$baseUrl}/lib/pkp/js/lib/jquery/jquery-2.0.2.min.js"></script>
	<script type="text/javascript" src="{$baseUrl}/lib/pkp/js/lib/jquery/plugins/jqueryUi.min.js"></script>
	
	  <!-- script src="http://code.jquery.com/jquery.js"></script-->
    
    
    
   <!-- Include all compiled plugins (below), or include individual files as needed -->
    <script src="{$baseUrl}/js/bootstrap_js/bootstrap.min.js"></script>
    <!-- script src="//netdna.bootstrapcdn.com/bootstrap/3.0.0-rc1/js/bootstrap.min.js"></script-->
	
    <!-- Bootstrap -->
    <link href="{$baseUrl}/styles/bootstrap_css/bootstrap.min.css" rel="stylesheet" media="screen">
    <!-- link href="{$baseUrl}/styles/bootstrap_css/bootstrap-glyphicons.css" rel="stylesheet" media="screen"-->
    <!-- link rel="stylesheet" href="//netdna.bootstrapcdn.com/bootstrap/3.0.0-rc1/css/bootstrap.min.css"-->
	
	<link href="{$baseUrl}/styles/bootstrap_css/tweeks.css" rel="stylesheet" media="screen">
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
<p class="navbar-text pull-right margin_top_10 margin_bottom_10"><a class="btn btn-default btn-xs"
	href="{url page="gateway"}/plugin/WebFeedGatewayPlugin/rss2">
<img src="{$baseUrl}/public/site/RSS_icon.png" width="26" height="26" alt="Rss"/></a></p>
<p class="navbar-text pull-right margin_top_10 margin_bottom_10"><a class="btn btn-default btn-xs"
	href="https://twitter.com/librello" target="blank"><img src="{$baseUrl}/public/site/Twitter_icon.png" width="26" height="26" alt="Twitter"/></a>
</p>
<p class="navbar-text pull-right margin_top_10 margin_bottom_10"><a class="btn btn-default btn-xs"
	href="http://www.linkedin.com/company/librello" target="blank"><img src="{$baseUrl}/public/site/Linkedin_icon.png" width="26" height="26" alt="LinkedIn"/></a></p>
	<p class="navbar-text pull-right margin_top_10 margin_bottom_10"><a class="btn btn-default btn-xs"
	href="https://plus.google.com/117721213017356591223" target="blank"><img src="{$baseUrl}/public/site/Google_icon.png" width="26" height="26" alt="Google +"/></a></p>

</div>
</div>

<div class="container">

 

<div itemscope itemtype="http://schema.org/Article" id="container">

<div id="header">
<div id="headerTitle">
    
    <div>
    
    <h1>
    {if $displayPageHeaderLogo && is_array($displayPageHeaderLogo)}
        <img itemprop="image" src="{$publicFilesDir}/{$displayPageHeaderLogo.uploadName|escape:"url"}" width="{$displayPageHeaderLogo.width|escape}" height="{$displayPageHeaderLogo.height|escape}" {if $displayPageHeaderLogoAltText != ''}alt="{$displayPageHeaderLogoAltText|escape}"{else}alt="{translate key="common.pageHeaderLogo.altText"}"{/if} />
        <span itemprop="name" style='height:1px;display:none;'>{if $displayPageHeaderLogoAltText != ''}{$displayPageHeaderLogoAltText|escape}{else}{translate key="common.pageHeaderLogo.altText"}{/if}</span>
    {/if}
    {if $displayPageHeaderTitle && is_array($displayPageHeaderTitle)}
        <img itemprop="image" src="{$publicFilesDir}/{$displayPageHeaderTitle.uploadName|escape:"url"}" width="{$displayPageHeaderTitle.width|escape}" height="{$displayPageHeaderTitle.height|escape}" {if $displayPageHeaderTitleAltText != ''}alt="{$displayPageHeaderTitleAltText|escape}"{else}alt="{translate key="common.pageHeader.altText"}"{/if} />
        <span itemprop="name" style='height:1px;display:none;'>{if $displayPageHeaderTitleAltText != ''}{$displayPageHeaderTitleAltText|escape}{else}{translate key="common.pageHeader.altText"}{/if}</span>
    {elseif $displayPageHeaderTitle}
        {$displayPageHeaderTitle}
    {elseif $alternatePageHeader}
        {$alternatePageHeader}
    {elseif $siteTitle}
        {$siteTitle}
    {else}
        {$applicationName}
    {/if}
    </h1>
    
    </div>
    
{include file="common/navbar.tpl"}
</div>
</div>

<div id="body">



<div id="main">
<!--
{include file="common/breadcrumbs.tpl"}
-->

{if !$journalFlag}

<ol class="breadcrumb margin_top_10">
  <li><a href="{url page="index"}" target="_parent">{translate key="navigation.home"}</a></li>
  {if $issue}
  <li class="active">{$issue->getIssueIdentification(false,true)|escape}</li>
  {/if}
</ol>

<h2>{$pageTitleTranslated}</h2>

{if $pageSubtitle && !$pageSubtitleTranslated}{translate|assign:"pageSubtitleTranslated" key=$pageSubtitle}{/if}
{if $pageSubtitleTranslated}
	<h3>{$pageSubtitleTranslated}</h3>
{/if}
{/if}


<div id="content">

