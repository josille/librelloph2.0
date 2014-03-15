<?php

/**
 * @file SNPostHandler.inc.php
 *
 * Copyright (c) 2013 Rodrigo De la Garza
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * @class SitemapHandler
 * @ingroup pages_sitemap
 *
 * @brief Will post rss updates into social networks
 */

// $Id$

define('SITEMAP_XSD_URL', 'http://www.sitemaps.org/schemas/sitemap/0.9');

import('classes.handler.Handler');
import('classes.twitter.Twitter');

class SNPostHandler extends Handler {
	
	function SNPostHandler() {
		parent::Handler();
	}
	
	/**
	 * Generate an XML sitemap for webcrawlers
	 * Creates a sitemap index if in site context, else creates a sitemap
	 */
	function index() {
		//	$this->validate();
		//$this->setupTemplate();
		
		 
// db holder
$savedItems = array();
 
// db file name
$savedItemsFilename = './sndb/SNPostDB.txt';
 
// max days to keep items in db
$numberOfDays = 3;
 
$numberOfDaysInSeconds = ($numberOfDays*24*60*60);
$expireDate = time() - $numberOfDaysInSeconds;
 
$urls = array('http://librelloph.com/ojs/index.php/challengesinsustainability/gateway/plugin/WebFeedGatewayPlugin/rss2');
$feed = new SimplePie();
$feed->set_feed_url($urls);
$feed->set_cache_duration(100);
$feed->init();
		
	/*
        load flat file db into array
*/
if(file_exists($savedItemsFilename))
{
        $savedItems = unserialize(file_get_contents($savedItemsFilename));
        if(!$savedItems)
        {
                $savedItems = array();
        }
}


/*
        Loop through items to find new ones and insert them into db
*/
//$test_dead = 6;
//$test_dead_index = 1;
foreach($feed->get_items() as $item)
{
//	if($test_dead_index == $test_dead)
//	{
//		break;
//	}
//	$test_dead_index++;
	// make id
        $id = md5($item->get_id());
        
 // if item is already in db, skip it
        if(isset($savedItems[$id]))
        {
        	echo 'item: '.$item->get_title().' skiped </br>';
                continue;
        }
        
		//echo $item->get_date('U') . ', id '. $id .'</br>';
		
		// found new item, add it to db
        $i = array();
        $i['title'] = $item->get_title();
        //$i['link'] = $item->get_link();
        //$i['author'] = '';
        //$author = $item->get_author();
        //if($author)
        //{
        //        $i['author'] = $author->get_name();
        //}
        $i['date'] = $item->get_date('U');
        //$i['content'] = $item->get_content();
        //$feed = $item->get_feed();
        //$i['feed_link'] = $item->get_permalink();
        //$i['feed_title'] = $item->get_title();
 
        $savedItems[$id] = $i;
        
        // send tweet
    
        // Include twitteroauth

$twitter = new Twitter('FE6jqXpv6yQXmKiCk87Q', 'piwBD4TCWS443C7XKtOzF2LUAECFiJKz8n1TQcw8o');

// set tokens
  $twitter->setOAuthToken('14517684-lFFdJPcd0leuQc2umOECdf4MHfZbsf6OFaYEJRj1j');
$twitter->setOAuthTokenSecret('4PKW72ndEqYkCzoLXBG1shILkuYz2Rt0rs2LWaifGA');

//$link = file_get_contents('http://tinyurl.com/api-create.php?url='.$item->get_permalink());
/*
 * If tweet os longer than 140 char, reduce title and test again
 */
$title = $item->get_title();
$tweet =  $title.' '.$twitter->minifyURL($item->get_permalink()).' #sustainability';

while(strlen($tweet) > 140)
{
	$title =  substr( $title, 0 ,strlen($title)-5 );
	
	$tweet =  $title.' '.$twitter->minifyURL($item->get_permalink()).' #sustainability';
}

$twitter->statusesUpdate($tweet);


}

	/*
        save db
*/
if(!file_put_contents($savedItemsFilename,serialize($savedItems)))
{
        echo ("<strong>Error: Can't save items.</strong><br>");
}



/*
        display all items from db
*/
echo '<h2>SimplePie + flat file database</h2>';
$count = 1;
foreach($savedItems as $item)
{
        echo $count++ . '. ';
        echo '<strong>' . $item['feed_title'] . '</strong>';
        echo ' : ';
        echo $item['title'];
        echo '<br>';
        echo '<small>' . date('r',$item['date']) . '</small>';
        echo '<br>';
        echo '<br>';
}
 
/*
        for comparison, show all feed items using SimplePie only
*/
echo '<h2>SimplePie only</h2>';
$count = 1;
foreach($feed->get_items() as $item)
{
        echo $count++ . '. ';
        $iFeed = $item->get_feed();
        echo '<strong>' . $iFeed->get_title() . '</strong>';
        echo ' : ';
        echo $item->get_title();
        echo '<br>';
        echo '<small>' . $item->get_date('r') . '</small>';
        echo '<br>';
        echo '<br>';
}
 
/*
        Total counts
*/
        echo '<h2>Total item counts</h2>';
        echo 'Database item count: ' . count($savedItems);
        echo '<br>';
        echo 'SimplePie item count: ' . $feed->get_item_quantity();
        echo '<br>';
		
		/*
		if (Request::getRequestedJournalPath() == 'index') {
			$doc = SitemapHandler::createSitemapIndex();
			header("Content-Type: application/xml");
			header("Cache-Control: private");
			header("Content-Disposition: inline; filename=\"sitemap_index.xml\"");
			XMLCustomWriter::printXML($doc);
		} else {
			$doc = SitemapHandler::createJournalSitemap();
			header("Content-Type: application/xml");
			header("Cache-Control: private");
			header("Content-Disposition: inline; filename=\"sitemap.xml\"");
			XMLCustomWriter::printXML($doc);
		}
		*/
	}
	 
	/**
	 * Construct a sitemap index listing each journal's individual sitemap
	 * @return XMLNode
	 */
	function createSitemapIndex() {
		$journalDao =& DAORegistry::getDAO('JournalDAO');
		
		$doc =& XMLCustomWriter::createDocument();
		$root =& XMLCustomWriter::createElement($doc, 'sitemapindex');
		XMLCustomWriter::setAttribute($root, 'xmlns', SITEMAP_XSD_URL);

		$journals =& $journalDao->getEnabledJournals();
		while ($journal =& $journals->next()) {
			$sitemapUrl = Request::url($journal->getPath(), 'sitemap');
			$sitemap =& XMLCustomWriter::createElement($doc, 'sitemap');
			XMLCustomWriter::createChildWithText($doc, $sitemap, 'loc', $sitemapUrl, false);
			XMLCustomWriter::appendChild($root, $sitemap);
			unset($journal);
		}
		
		XMLCustomWriter::appendChild($doc, $root);
		return $doc;
	}

	 /**
	 * Construct the sitemap
	 * @return XMLNode
	 */
	function createJournalSitemap() {
		$issueDao =& DAORegistry::getDAO('IssueDAO');
		$publishedArticleDao =& DAORegistry::getDAO('PublishedArticleDAO');
		$galleyDao =& DAORegistry::getDAO('ArticleGalleyDAO');
		
		$journal =& Request::getJournal();
		$journalId = $journal->getId();
		
		$doc =& XMLCustomWriter::createDocument();
		$root =& XMLCustomWriter::createElement($doc, 'urlset');
		XMLCustomWriter::setAttribute($root, 'xmlns', SITEMAP_XSD_URL);
		
		// Journal home
		XMLCustomWriter::appendChild($root, SitemapHandler::createUrlTree($doc, Request::url($journal->getPath(),'index','index')));
		// About page
		XMLCustomWriter::appendChild($root, SitemapHandler::createUrlTree($doc, Request::url($journal->getPath(), 'about')));
		XMLCustomWriter::appendChild($root, SitemapHandler::createUrlTree($doc, Request::url($journal->getPath(), 'about', 'editorialTeam')));
		XMLCustomWriter::appendChild($root, SitemapHandler::createUrlTree($doc, Request::url($journal->getPath(), 'about', 'editorialPolicies')));
		XMLCustomWriter::appendChild($root, SitemapHandler::createUrlTree($doc, Request::url($journal->getPath(), 'about', 'submissions')));
		XMLCustomWriter::appendChild($root, SitemapHandler::createUrlTree($doc, Request::url($journal->getPath(), 'about', 'siteMap')));
		XMLCustomWriter::appendChild($root, SitemapHandler::createUrlTree($doc, Request::url($journal->getPath(), 'about', 'aboutThisPublishingSystem')));
		// Search
		XMLCustomWriter::appendChild($root, SitemapHandler::createUrlTree($doc, Request::url($journal->getPath(), 'search')));
		XMLCustomWriter::appendChild($root, SitemapHandler::createUrlTree($doc, Request::url($journal->getPath(), 'search', 'authors')));
		XMLCustomWriter::appendChild($root, SitemapHandler::createUrlTree($doc, Request::url($journal->getPath(), 'search', 'titles')));
		// Issues
		XMLCustomWriter::appendChild($root, SitemapHandler::createUrlTree($doc, Request::url($journal->getPath(), 'issue', 'current')));
		XMLCustomWriter::appendChild($root, SitemapHandler::createUrlTree($doc, Request::url($journal->getPath(), 'issue', 'archive')));
		$publishedIssues =& $issueDao->getPublishedIssues($journalId);
		while ($issue =& $publishedIssues->next()) {
			XMLCustomWriter::appendChild($root, SitemapHandler::createUrlTree($doc, Request::url($journal->getPath(), 'issue', 'view', $issue->getId())));
			// Articles for issue
			$articles = $publishedArticleDao->getPublishedArticles($issue->getId());
			foreach($articles as $article) {
				// Abstract
				XMLCustomWriter::appendChild($root, SitemapHandler::createUrlTree($doc, Request::url($journal->getPath(), 'article', 'view', array($article->getId()))));
				// Galley files
				$galleys = $galleyDao->getGalleysByArticle($article->getId());
				foreach ($galleys as $galley) {
					XMLCustomWriter::appendChild($root, SitemapHandler::createUrlTree($doc, Request::url($journal->getPath(), 'article', 'view', array($article->getId(), $galley->getId()))));
				}
			}
			unset($issue);
		}
		
		XMLCustomWriter::appendChild($doc, $root);
		return $doc;
	}
	
	/**
	 * Create a url entry with children
	 * @param $doc XMLNode Reference to the XML document object
	 * @param $loc string URL of page (required)
	 * @param $lastmod string Last modification date of page (optional)
	 * @param $changefreq Frequency of page modifications (optional)
	 * @param $priority string Subjective priority assesment of page (optional) 
	 * @return XMLNode
	 */
	function createUrlTree(&$doc, $loc, $lastmod = null, $changefreq = null, $priority = null) {		
		$url =& XMLCustomWriter::createElement($doc, 'url');
		
		XMLCustomWriter::createChildWithText($doc, $url, htmlentities('loc'), $loc, false);
		XMLCustomWriter::createChildWithText($doc, $url, 'lastmod', $lastmod, false);
		XMLCustomWriter::createChildWithText($doc, $url, 'changefreq', $changefreq, false);
		XMLCustomWriter::createChildWithText($doc, $url, 'priority', $priority, false);
		
		return $url;
	}
	
}

?>
