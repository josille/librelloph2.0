{** * issue.tpl 
* 
* Copyright (c) 2003-2012 John Willinsky 
* Distributed under the GNU GPL v2. For full terms see the file docs/COPYING. 
* 
* Issue 
* 
* $Id$ 
*}
<?xml version="1.0" encoding="UTF-8"?>
<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">

{iterate from=articles item=article} 
{assign var=articlePath value=$article->getBestArticleId($currentJournal)}			

<url>
<loc>{url page='article' op='view' path=$articlePath}</loc>
<changefreq>weekly</changefreq>
<priority>0.5</priority>
</url>

{/iterate} 
</urlset>