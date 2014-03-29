{**
 * archive.tpl
 *
 * Copyright (c) 2003-2012 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Issue Archive.
 *
 * $Id$
 *}<?xml version="1.0" encoding="UTF-8"?>
<sitemapindex xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">

{iterate from=issues item=issue}

{if $issue->getYear() != 0 && $issue->getVolume() != 0 && $issue->getNumber() != 0}
<sitemap>
<loc>{url op="issueSiteMapXml" path=$issue->getBestIssueId($currentJournal)}</loc>
<lastmod>2013-09-01T18:23:17+00:00</lastmod>
</sitemap>

{/if}

{/iterate}

{iterate from=issuesSI item=issueSI}
{if $issueSI->getVolume() == 0}
<sitemap>

<loc>{url op="issueSiteMapXml" path=$issueSI->getBestIssueId($currentJournal)}</loc>
<lastmod>2013-09-01T18:23:17+00:00</lastmod>

</sitemap>
{/if}
{/iterate}


</sitemapindex>