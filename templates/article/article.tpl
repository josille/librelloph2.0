{**
 * article.tpl
 *
 * Copyright (c) 2003-2012 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Article View.
 *}


{if $galley}
	{if $galley->isHTMLGalley()}
	
		{include file="article/header.tpl"}
		
		{$galley->getHTMLContents()}
	{elseif $galley->isPdfGalley()}
	
		{include file="article/header_view_pdf.tpl"}
	
		{url|assign:"pdfUrl" op="viewFile" path=$articleId|to_array:$galley->getBestGalleyId($currentJournal) escape=false}
		{translate|assign:"noPluginText" key='article.pdf.pluginMissing'}
		<script type="text/javascript"><!--{literal}
			$(document).ready(function(){
				if (true) { // PDFObject does not correctly work with safari's built-in PDF viewer
					var embedCode = "<object id='pdfObject' type='application/pdf' data='{/literal}{$pdfUrl|escape:'javascript'}{literal}' width='99%' height='500px'><div id='pluginMissing'>{/literal}{$noPluginText|escape:'javascript'}{literal}</div></object>";
					$("#articlePdf").html(embedCode);
					if($("#pluginMissing").is(":hidden")) {
						$('#fullscreenShow').show();
						$("#articlePdf").resizable({ containment: 'parent', handles: 'se' });

						
					} else { // Chrome Mac hides the embed object, obscuring the text.  Reinsert.
						$("#articlePdf").html('{/literal}{$noPluginText|escape:"javascript"}{literal}');
					}
					
					
				} else {
					var success = new PDFObject({ url: "{/literal}{$pdfUrl|escape:'javascript'}{literal}" }).embed("articlePdf");
					if (success) {

						var width = window.innerWidth || document.documentElement.clientWidth
									|| document.body.offsetWidth;
						var height = window.innerHeight || document.documentElement.clientHeight
									|| document.body.offsetHeight;
						
						//alert(height);
						// PDF was embedded; enbale fullscreen mode and the resizable widget
						$('#fullscreenShow').show();
						$("#articlePdfResizer").resizable({ containment: 'parent', handles: 'se' });

						$('#articlePdfResizer').css('height',height-3);
						$('#articlePdfResizer').css('width',width-2);
					}
					else
					{
						$("#articlePdf").append('<p><br/><br/><a class="action" target="_parent" href="{/literal}{url op="download" path=$articleId|to_array:$galley->getBestGalleyId($currentJournal)}{literal}">{/literal}{translate key="article.pdf.download"}{literal}</a></p>');
					}
				}
			});
		{/literal}
		// -->
		</script>
		<div id="articlePdfResizer">
			<div id="articlePdf" class="ui-widget-content">
				{translate key="article.pdf.pluginMissing"}
			</div>
		</div>
		<!-- p>
			{* The target="_parent" is for the sake of iphones, which present scroll problems otherwise. *}
			<a class="action" target="_parent" href="{url op="download" path=$articleId|to_array:$galley->getBestGalleyId($currentJournal)}">{translate key="article.pdf.download"}</a>
			<a class="action" href="#" id="fullscreenShow">{translate key="common.fullscreen"}</a>
			<a class="action" href="#" id="fullscreenHide">{translate key="common.fullscreenOff"}</a>
		</p-->
	{/if}
{else}

{include file="article/header.tpl"}
{assign var=galleys value=$article->getGalleys()}

<div class="row">
<div class="col-xs-6 col-sm-6 col-md-6 col-lg-6 doi_style">
{if $coverPagePath}
		<div id="articleCoverImage"><img src="{$coverPagePath|escape}{$coverPageFileName|escape}"{if $coverPageAltText != ''} alt="{$coverPageAltText|escape}"{else} alt="{translate key="article.coverPage.altText"}"{/if}{if $width} width="{$width|escape}"{/if}{if $height} height="{$height|escape}"{/if}/>
		</div>
	{/if}
	{call_hook name="Templates::Article::Article::ArticleCoverImage"}
</div>
</div>

<div class="row">
<div class="col-xs-12 col-sm-12 col-md-6 col-lg-6 doi_style">
DOI: <span style='margin-right:10px;'>{$article->getDOI()}</span><span>|</span><span style='margin-left:10px;'>Publication Date: {$article->getDatePublished()|date_format:"%e %B %Y"}</span>
</div>
</div>
<div class="row">
<div class="col-xs-7 col-sm-5 col-md-8 col-lg-6">

<div class='research_div'>
<strong>
		<span class='research_div_inner'>
			 {assign var=articleType value=$article->getSectionTitle()}
		 {if $articleType eq 'Articles'}
		    Research Article
		{elseif $articleType eq 'Commentaries'}
		    Commentary
		{elseif $articleType eq 'Communications'}
		    Communication
		{elseif $articleType eq 'Editorials'}
		    Editorial
		{elseif $articleType eq 'Reviews'}
		    Review
		{elseif $articleType eq 'Short Notes'}
		    Short Note
		{elseif $articleType eq 'Book Review'}
		    Book Review
		{elseif $articleType eq 'Research Notes'}
		    Research Note
        {elseif $articleType eq 'Opinions'}
             Opinion
        {else}
             {$articleType}
		{/if}
		</span>
		</strong>
		</div>

</div>

<div class="col-xs-8 col-sm-5 col-md-8 col-lg-6">
{if $galleys}
<div class="btn-group  pull-right">

<button type="button" class="btn btn-info dropdown-toggle" data-toggle="dropdown">
<span class="glyphicon glyphicon-download"></span> Download this Article <span class="caret"></span></button>
	
  <ul class="dropdown-menu" role="menu">
				{foreach from=$article->getGalleys() item=galley name=galleyList} {if
	$galley->isPdfGalley()}
	<li><a href="{url page='article' op='download' path=$article->getBestArticleId($currentJournal)|to_array:$galley->getBestGalleyId($currentJournal)}" 
	class="file">Full text PDF</a></li>

	<li><a href="{url page='article' op='viewXML' path=$article->getBestArticleId($currentJournal)}/xml" class="file">Abstract XML</a></li>
	{else}
	<li><a href="{url page='article' op='view' path=$article->getBestArticleId($currentJournal)|to_array:$galley->getBestGalleyId($currentJournal)}"
	class="file" target="blank">{$galley->getGalleyLabel()|escape}</a></li>
	{/if} {/foreach}
				</ul>


</div>
{/if}
</div>
</div>

<div class="row">
<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">

	<div id="articleTitle"><h3 itemprop="name">{$article->getLocalizedTitle()|strip_unsafe_html}</h3></div>
</div>
</div>

<div class="row">
<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">

{$article->getAuthorAffiliationHTMLtpl(true)}

</div>
</div>

{if $article->getLocalizedAbstract()}
<div class="row">
<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12 margin_top_10">
	
		<div itemprop="articleBody"><strong>{translate key="article.abstract"}:</strong>
		{$article->getLocalizedAbstract()|strip_unsafe_html|nl2br}</div>
		
</div>
</div>
{/if}

{if $article->getLocalizedSubject()}
<br/>

<div class="row">
<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12 margin_top_10">
<strong>{translate key="article.subject"}:</strong> {$article->getLocalizedSubject()|escape}
</div>
</div>

<br/>
{/if}

{if $article->getSuppFiles()}

<div class="row">
<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12 margin_top_10">
<h4>Supplementary files</h4>
</div>
</div>

<div class="row">
<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12 margin_top_10">

<div class="table-responsive">
  <table class="table table-hover supp_files_table">
  <thead>
            <tr>
              <th>#</th>
              <th>Name</th>
              <th>File</th>
            </tr>
          </thead>
          <tbody>
    {foreach name=suppFiles from=$article->getSuppFiles() item=suppFile}
			
			<tr>
				<td>{$smarty.foreach.suppFiles.iteration}.</td>
				<td>{$suppFile->getSuppFileTitle()|escape}</td>
				<td><a href="{url op="downloadSuppFile" path=$article->getBestArticleId($currentJournal)|to_array:$suppFile->getBestSuppFileId($currentJournal)}" class="file">{$article->getBestArticleId($currentJournal)}-SUP{$suppFile->getSequence()+1}.{$suppFile->getFileExtension()}</a></td>
			
			</tr>
			{/foreach}
			</tbody>
  </table>
</div>

			
</div>
</div>

{/if}

<div class="row">
<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12 margin_top_10">

<script type="text/javascript">
    {literal}
      // Load the Visualization API and the piechart package.
      // Load the Visualization API and the piechart package.
    google.load('visualization', '1', {'packages':['corechart']});
      
    // Set a callback to run when the Google Visualization API is loaded.
    google.setOnLoadCallback(drawChart);


      // Callback that creates and populates a data table,
      // instantiates the pie chart, passes in the data and
      // draws it.
      
      //{url page='article' op='download' path=$article->getBestArticleId($currentJournal)|to_array:$galley->getBestGalleyId($currentJournal)}
      function drawChart() {

    	  var jsonData = $.ajax({
              //url: "http://localhost/librelloph2.0/index.php/politicsandgovernance/article/viewVisits/PaG-1.1.1",
              url: $('#urlArtCount').text(),
              dataType:"json",
              async: false
              }).responseText;
              
          // Create our data table out of JSON data loaded from server.
          var data = new google.visualization.DataTable(jsonData);

         var options = {
        		 	pieSliceText: 'value',
        	        title: 'Article visist and downloads',
        	        width: 500, 
        	        height: 250,
        	        is3D: true
        	      };
        	          

        // Instantiate and draw our chart, passing in some options.
        var chart = new google.visualization.PieChart(document.getElementById('chart_div'));
        chart.draw(data, options);

      }
      {/literal}
    </script>

<div style='width:500px;margin-left: auto;  margin-right: auto;'>
<!--Div that will hold the pie chart-->
<span id='urlArtCount' style='display:none;'>{url page='article' op='viewVisits' path=$article->getBestArticleId($currentJournal)}</span>
    <div id="chart_div"></div>
    </div>
</div></div>

{if $citationFactory->getCount()}
<div class="row">
<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12 margin_top_10">
		<div id="articleCitations">
		<h4>{translate key="submission.citations"}</h4>
		<br />
		<div>
			{iterate from=citationFactory item=citation}
				<p>{$citation->getRawCitation()|strip_unsafe_html}</p>
			{/iterate}
		</div>
		<br />
		</div>
</div></div>
{/if}

{/if}
<div style='display:block;height:30px;'></div>
{include file="article/comments.tpl"}

{include file="article/footer.tpl"}

