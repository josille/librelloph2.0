{** * siteMapXML.tpl * * Copyright (c) 2003-2012 John Willinsky *
Distributed under the GNU GPL v2. For full terms see the file
docs/COPYING. * * About the Journal / Site Map. * * TODO: Show the site
map. * * $Id$ *}
{if $secondlevel eq 'index'}
<a href='libarch.rdf'>libarch.rdf</a><br/>
<a href='libseri.rdf'>libseri.rdf</a><br/>

{foreach from=$arrLinks key=key item=link}
<a href='{$link}/{$key}.rdf'>{$link}/{$key}.rdf</a><br/>
{/foreach}
{elseif $secondlevel eq 'libarch.rdf'}

Template-type: ReDIF-Archive 1.0
Handle: RePEc:lib
Name: {$siteTitle}
Maintainer-Email: {$siteContactEmail}
Description: {$siteIntro}
{*URL: {$baseUrl}/index/about/RePEc/lib/*}
URL: http://www.librelloph.com/about/RePEc/lib/

{elseif $secondlevel eq 'libseri.rdf'}
{foreach from=$journals item=journal}
Template-type: ReDIF-Series 1.0
Name: {$journal.jouname}
Description: {$journal.joudesc|strip_unsafe_html|nl2br}
Provider-Name: {$siteTitle}
{*Provider-Institution: RePEc:lib*}
{assign var=mantainer value=$journal.mantainer}
{foreach from=$mantainer item=mant}
Maintainer-Name: {$mant.name|escape}
Maintainer-Email: {$mant.email|escape}
{/foreach}
{assign var=editor value=$journal.editor}
{foreach from=$editor item=edit}
Editor-Name: {$edit.name|escape}
Editor-Email: {$edit.email|escape}
{/foreach}
Type: ReDIF-Article
Handle: RePEc:lib:{$journal.jouabbr|lower}


{/foreach}

{elseif $secondlevel neq 'libseri.rdf' AND $secondlevel neq 'libarch.rdf'}
{iterate from=articles item=article}
{assign var=issueArt value=$article->getArticleIssue()}
{assign var=journalPath value=$article->getJournalPath()}
Template-Type: ReDIF-Article 1.0
{$article->getAuthorAffiliationHTMLtpl(false,true)}
Title:  {$article->getLocalizedTitle()|strip_unsafe_html}
Abstract:  {$article->getLocalizedAbstract()|strip_unsafe_html|nl2br}
{if $clasif != ''}
Classification-JEL: {$clasif}
{/if}
{if $article->getLocalizedSubject()}
Keywords: {$article->getLocalizedSubject()|strip_unsafe_html|nl2br}
{/if}
Journal: {$jouName}
Pages: {$article->getPages()|escape}
Volume: {$issueArt->getVolume()}
Issue: {$issueArt->getNumber()}
Year: {$issueArt->getYear()}
{*Month: February*}
File-URL: {url journal=$journalPath page='article' op='download' path=$article->getId()}/pdf
{*File-URL: http://www.librelloph.com/index.php/index/article/download/{$article->getId()}/pdf*}
File-Format: Application/pdf
File-URL: {url journal=$journalPath page='article' op='view' path=$article->getId()}
{*File-URL: http://www.librelloph.com/index.php/index/article/view/{$article->getId()}*}
File-Format: text/html
Handle: RePEc:lib:{$secondlevel}:v:{$issueArt->getVolume()}:y:{$issueArt->getYear()}:i:{$issueArt->getNumber()}:p:{$article->getPages()|escape}



{/iterate}

{/if}