{**
 * siteMapXML.tpl
 *
 * Copyright (c) 2003-2012 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * About the Journal / Site Map.
 *
 * TODO: Show the site map.
 *
 * $Id$
 *}
 
<?xml version="1.0" encoding="UTF-8"?>


	{if $journals|@count>1 && !$currentJournal}
	<sitemapindex xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">
			{foreach from=$journals item=journal}
			<sitemap>
		     <loc>{url journal=$journal->getPath() page="about" op="siteMapXML"}</loc>
		     <lastmod>2004-10-01T18:23:17+00:00</lastmod>
		   </sitemap>
			{/foreach}
		</sitemapindex>
		{else}
			
<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">
			<url>
					<loc>{url journal=$currentJournal->getPath() page="about"}</loc>
					<changefreq>monthly</changefreq>
					<priority>0.5</priority>
			</url>
	
			{if $isUserLoggedIn}
				{assign var=currentJournalId value=$currentJournal->getId()}
					{foreach from=$rolesByJournal[$currentJournalId] item=role}
						{translate|assign:"roleName" key=$role->getRoleName()}
						<url>
							<loc>{url journal=$currentJournal->getPath() page=$role->getRolePath()}
							</loc>
							<priority>0.5</priority>
						</url>
					{/foreach}
			{else}
			<url>
				<loc>{url journal=$currentJournal->getPath() page="login"}
				</loc>
				<priority>0.5</priority>
			</url>
			<url>
				<loc>{url journal=$currentJournal->getPath() page="user" op="register"}
				</loc>
				<priority>0.5</priority>
			</url>					
			{/if}
			
			
			{if $currentJournal->getSetting('publishingMode') != $smarty.const.PUBLISHING_MODE_NONE}
			<url>
						<loc>{url journal=$currentJournal->getPath() page="search"}
						</loc>
						<priority>0.5</priority>
			</url>
			<url>
						<loc>{url journal=$currentJournal->getPath() page="search" op="authors"}
						</loc>
						<priority>0.5</priority>
			</url>
			<url>
						<loc>{url journal=$currentJournal->getPath() page="search" op="titles"}
						</loc>
						<priority>0.5</priority>
			</url>
			<url>	
						<loc>{url journal=$currentJournal->getPath() page="issue" op="current"}
						</loc>
			</url>
			<url>
						<loc>{url journal=$currentJournal->getPath() page="issue" op="archive"}
						</loc>
			</url>
					{/if}
					
		</urlset> 
      {/if}


