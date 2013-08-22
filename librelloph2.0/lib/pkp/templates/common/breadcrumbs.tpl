{**
 * breadcrumbs.tpl
 *
 * Copyright (c) 2000-2012 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Breadcrumbs
 *
 *}

<ol class="breadcrumb margin_top_10">
  <li><a href="{url context=$homeContext page="index"}">{translate key="navigation.home"}</a></li>
  
  {foreach from=$pageHierarchy item=hierarchyLink}
	<li><a href="{$hierarchyLink[0]|escape}" class="hierarchyLink">{if not $hierarchyLink[2]}{translate key=$hierarchyLink[1]}{else}{$hierarchyLink[1]|escape}{/if}</a></li>
	{/foreach}
  
  <li class="active">{$pageCrumbTitleTranslated}</li>
  
</ol>
