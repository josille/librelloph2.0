{**
 * header.tpl
 *
 * Copyright (c) 2003-2012 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Article View -- Header component.
 *}
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
	"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<title>{$article->getLocalizedTitle()|escape} | {$article->getFirstAuthor(true)|escape} | pdf</title>
	<meta http-equiv="Content-Type" content="text/html; charset={$defaultCharset|escape}" />

	{if $article->getAbstract(null)}
	<meta name="description" content="View PDF, Abstract: {foreach from=$article->getAbstract(null) key=metaLocale item=metaValue}{$metaValue|strip_tags|escape}{/foreach}, Author(s): {foreach from=$article->getAuthorString()|explode:', ' item=dc_author}{$dc_author|escape}{/foreach}, Category: {$article->getSectionTitle()}, Pages: {$article->getPages()}"/>
	{/if}	

	{if $article->getLocalizedSubject()}
		<meta name="keywords" content="{$article->getLocalizedSubject()|escape}" />
	{/if}

	{if $displayFavicon}<link rel="icon" href="{$faviconDir}/{$displayFavicon.uploadName|escape:"url"}" />{/if}

	{include file="article/dublincore.tpl"}
	{include file="article/googlescholar.tpl"}
	{call_hook name="Templates::Article::Header::Metadata"}

	<script type="text/javascript" src="{$baseUrl}/lib/pkp/js/lib/jquery/jquery-2.0.3.min.js"></script>
	<script type="text/javascript" src="{$baseUrl}/lib/pkp/js/lib/jquery/plugins/jqueryUi.min.js"></script>
	
		<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	
<script type="text/javascript" src="{$baseUrl}/js/bootstrap_js/bootstrap.min.js"></script> 
	
	<!-- Bootstrap -->
<link href="{$baseUrl}/styles/bootstrap_css/bootstrap.min.css" rel="stylesheet" media="screen"/>

<link href="{$baseUrl}/styles/bootstrap_css/tweeks.css" rel="stylesheet" media="screen"/>
</head>
<body>
<div>
<div class="container" itemscope="" itemtype="http://schema.org/Article" id="container">
<div id="body">

<div id="main">

