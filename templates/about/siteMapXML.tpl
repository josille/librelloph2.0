{** * siteMapXML.tpl * * Copyright (c) 2003-2012 John Willinsky *
Distributed under the GNU GPL v2. For full terms see the file
docs/COPYING. * * About the Journal / Site Map. * * TODO: Show the site
map. * * $Id$ *}
<?xml version="1.0" encoding="UTF-8"?>


{if $journals|@count>1 && !$currentJournal}
<sitemapindex xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">
{foreach from=$journals item=journal}
<sitemap>
<loc>{url journal=$journal->getPath() page="about" op="siteMapXML"}</loc>
<lastmod>2013-09-01T18:23:17+00:00</lastmod>
</sitemap>
<sitemap>
<loc>{url journal=$journal->getPath() page="issue" op="archiveSiteMapXML"}</loc>
<lastmod>2013-09-01T18:23:17+00:00</lastmod>
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
<url>
<loc>{url journal=$currentJournal->getPath() page="about" op="contact"}</loc>
<changefreq>monthly</changefreq>
<priority>0.5</priority>
</url>

<url>
<loc>{url journal=$currentJournal->getPath() page="about" op="editorialTeam"}</loc>
<changefreq>monthly</changefreq>
<priority>0.5</priority>
</url>

<url>
<loc>{url journal=$currentJournal->getPath() page="about" op="editorialPolicies"}</loc>
<changefreq>monthly</changefreq>
<priority>0.5</priority>
</url>
<url>
<loc>{url journal=$currentJournal->getPath() page="about" op="submissions"}</loc>
<changefreq>monthly</changefreq>
<priority>0.5</priority>
</url>

<url>
<loc>{url journal=$currentJournal->getPath() page="pages" op="view"}/guidelinesreviewers</loc>
<changefreq>monthly</changefreq>
<priority>0.5</priority>
</url>
<url>
<loc>{url journal=$currentJournal->getPath() page="pages" op="view"}/indexArchive</loc>
<changefreq>weekly</changefreq>
<priority>0.5</priority>
</url>

<url>
<loc>{url journal=$currentJournal->getPath() page="pages" op="view"}/membership</loc>
<changefreq>monthly</changefreq>
<priority>0.5</priority>
</url>

<url>
<loc>{url journal=$currentJournal->getPath() page="login"}</loc>
<priority>0.5</priority>
</url>
<url>
<loc>{url journal=$currentJournal->getPath() page="user" op="register"}</loc>
<priority>0.5</priority>
</url>

<url>
<loc>{url journal=$currentJournal->getPath() page="author" op="submit"}</loc>
<priority>0.5</priority>
</url>



{if $currentJournal->getSetting('publishingMode') !=
$smarty.const.PUBLISHING_MODE_NONE}
<url>
<loc>{url journal=$currentJournal->getPath() page="search"}</loc>
<priority>0.5</priority>
</url>

<url>
<loc>{url journal=$currentJournal->getPath() page="issue" op="current"}</loc>
<changefreq>weekly</changefreq>
<priority>0.5</priority>
</url>

<url>
<loc>{url journal=$currentJournal->getPath() page="pages" op="view"}/specialissues</loc>
<changefreq>weekly</changefreq>
<priority>0.5</priority>
</url>
<url>
<loc>{url journal=$currentJournal->getPath() page="issue" op="archive"}</loc>
<changefreq>weekly</changefreq>
<priority>0.5</priority>
</url>
{/if}
</urlset>
{/if}