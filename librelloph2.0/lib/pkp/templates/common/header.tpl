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
	<title>{$pageTitleTranslated}{if $currentJournal} | {$currentJournal->getLocalizedTitle()} {/if}</title>
	<meta name="description" content="{$pageTitleTranslated}, {if $currentJournal}Journal:{$currentJournal->getLocalizedTitle()}{/if}, Info:{$metaSearchDescription|escape}" />
	<meta name="keywords" content="{$metaSearchKeywords|escape}" />
	<meta name="generator" content="{$applicationName} {$currentVersionString|escape}" />
	{$metaCustomHeaders}
	{if $displayFavicon}<link rel="icon" href="{$faviconDir}/{$displayFavicon.uploadName|escape:"url"}" />{/if}

	{$additionalHeadData}
	
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	
	<!-- JavaScript plugins (requires jQuery) -->

	<!-- script type="text/javascript" src="{$baseUrl}/lib/pkp/js/lib/jquery/jquery.min.js"></script-->
	<script type="text/javascript" src="{$baseUrl}/lib/pkp/js/lib/jquery/jquery-2.0.3.min.js"></script>
	<script type="text/javascript" src="{$baseUrl}/lib/pkp/js/lib/jquery/plugins/jqueryUi.min.js"></script>
	  <!-- script src="http://code.jquery.com/jquery.js"></script-->
      

    
    <!-- Bootstrap -->
       <script type="text/javascript" src="{$baseUrl}/js/bootstrap_js/bootstrap.min.js"></script>
    <link href="{$baseUrl}/styles/bootstrap_css/bootstrap.min.css" rel="stylesheet" media="screen" />
    
    <!-- BOOTSTRAP Override -->
	<link href="{$baseUrl}/styles/bootstrap_css/tweeks.css" rel="stylesheet" media="screen" />
	<link media="only screen and (max-width: 500px)" href="{$baseUrl}/styles/bootstrap_css/small.css" type="text/css" rel="stylesheet" />
	<link media="only screen and (max-width: 650px)" href="{$baseUrl}/styles/bootstrap_css/medium.css" type="text/css" rel="stylesheet" />
	
	<script type="text/javascript" src="{$baseUrl}/js/bootstrap_js/tweeks.js"></script>
	<script type="text/javascript" src="{$baseUrl}/js/bootstrap_js/tweeks_size_journals.js"></script>

<script type="text/javascript" src="{$baseUrl}/js/bootstrap_js/tweek_social.js"></script>

</head>
<body>
<div id="fb-root"></div>

{if $imgPathMain}
{assign var="imgPath" value="/../site"}
{else}
{assign var="imgPath" value="/../../site"}
{/if}

<div class="navbar navbar-inverse navbar-fixed-top">
<div id='top_nav_bar_journal' class="container">
<p class="navbar-text pull-right margin_top_18 margin_bottom_10"><a target="blank" style="background:none;" href="http://www.librelloph.com/oai?verb=Identify">
<img width="38px" height="28px" alt="OAI" src="http://www.openarchives.org/images/OA100.gif" />
</a></p>
<p class="navbar-text pull-right margin_top_18 margin_bottom_10"><a
	href="{url page="gateway"}/plugin/WebFeedGatewayPlugin/rss2">
<img src="{$baseUrl}/images/rss_top.png" width="26" height="26" alt="Rss"/></a></p>
<p class="navbar-text pull-right margin_top_18 margin_bottom_10"><a
	href="https://twitter.com/librello" target="blank"><img src="{$baseUrl}/images/twitter_top.png" width="26" height="26" alt="Twitter"/></a>
</p>
<p class="navbar-text pull-right margin_bottom_10 margin_top_18"><a 
href="http://www.linkedin.com/company/librello" target="blank"><img src="{$baseUrl}/images/linkedin_top.png" width="26" height="26" alt="LinkedIn"/></a></p>
<p class="navbar-text pull-right margin_top_18 margin_bottom_10"><a	href="https://plus.google.com/117721213017356591223" target="blank"><img src="{$baseUrl}/images/google_top.png" width="26" height="26" alt="Google +"/></a></p>
<p class="navbar-text pull-left margin_top_10 margin_bottom_10 margin_left_0">
<a href="http://www.librelloph.com">
<img src="{$baseUrl}/images/librello_logo_top_small.png" height="35" width="131" alt="Librello Home"/>
</a>
</p>

</div>
</div>

<div class="container">

 

<div itemscope itemtype="http://schema.org/Article" id="container">

<div id="header">
<div id="headerTitle">
    
    <div>
    
    <h1 class='margin_top_5'>
    {if $displayPageHeaderLogo && is_array($displayPageHeaderLogo)}
        <img id='librello_logo_img' itemprop="image" src="{$publicFilesDir}/{$displayPageHeaderLogo.uploadName|escape:"url"}" width="{$displayPageHeaderLogo.width|escape}" {if $displayPageHeaderLogoAltText != ''}alt="{$displayPageHeaderLogoAltText|escape}"{else}alt="{translate key="common.pageHeaderLogo.altText"}"{/if} />
        <span itemprop="name" style='height:1px;display:none;'>{if $displayPageHeaderLogoAltText != ''}{$displayPageHeaderLogoAltText|escape}{else}{translate key="common.pageHeaderLogo.altText"}{/if}</span>
    {/if}
    {if $displayPageHeaderTitle && is_array($displayPageHeaderTitle)}
    <a href="{url page="index"}" alt='Librello Publishing' style="background:none;">
        <img id='librello_logo_img' itemprop="image" src="{$publicFilesDir}/{$displayPageHeaderTitle.uploadName|escape:"url"}" width="{$displayPageHeaderTitle.width|escape}" {if $displayPageHeaderTitleAltText != ''}alt="{$displayPageHeaderTitleAltText|escape}"{else}alt="{translate key="common.pageHeader.altText"}"{/if} />
        </a>
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

{if !$journalFlag}

{include file="common/breadcrumbs.tpl"}

<h2>{$pageTitleTranslated}</h2>

{if $pageSubtitle && !$pageSubtitleTranslated}{translate|assign:"pageSubtitleTranslated" key=$pageSubtitle}{/if}
{if $pageSubtitleTranslated}
	<h3>{$pageSubtitleTranslated}</h3>
{/if}
{/if}


<div id="content">

