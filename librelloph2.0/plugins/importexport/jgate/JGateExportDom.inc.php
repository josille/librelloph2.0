<?php

/**
 * @file plugins/importexport/crossref/JGateExportDom.inc.php
 *
 * Copyright (c) 2013 Rodrigo De la Garza
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * @class JGateExportDom
 * @ingroup plugins_importexport_jgate
 *
 * @brief JGate XML export plugin DOM functions
 */

// $Id$


import('lib.pkp.classes.xml.XMLCustomWriter');

define('JGATE_XMLNS_XSI' , 'http://www.w3.org/2001/XMLSchema-instance');
//define('JGATE_XMLNS' , 'http://www.crossref.org/schema/4.3.0');
define('JGATE_VERSION' , '4.3.0');
//define('JGATE_XSI_SCHEMALOCATION' , 'http://www.crossref.org/schema/4.3.0 http://www.crossref.org/schema/deposit/crossref4.3.0.xsd');

class JGateExportDom {

	/**
	 * Build article XML using DOM elements
	 * @return XMLNode
	 */
	function &generateJGateDom() {
		// create the output XML document in DOM with a root node
		$doc =& XMLCustomWriter::createDocument();
		return $doc;
	}

	/**
	 * Generate DOI batch DOM tree.
	 * @param $doc object
	 * @return XMLNode
	 */
	function &generateDoiBatchDom(&$doc) {

		// Generate the root node for the file first and set its attributes
		$root =& XMLCustomWriter::createElement($doc, 'articles');

		/* Root doi_batch tag attributes
		 * Change to these attributes must be accompanied by a review of entire output
		 */
		XMLCustomWriter::setAttribute($root, 'xmlns:xsi', JGATE_XMLNS_XSI);
		//XMLCustomWriter::setAttribute($root, 'xmlns', JGATE_XMLNS);
		XMLCustomWriter::setAttribute($root, 'version', JGATE_VERSION);
		//XMLCustomWriter::setAttribute($root, 'xsi:schemaLocation', JGATE_XSI_SCHEMALOCATION);

		XMLCustomWriter::appendChild($doc, $root);

		return $root;
	}

	/**
	 * Generate the <head> tag that accompanies each submission
	 * @param $doc XMLNode
	 * @param $journal Journal
	 * @return XMLNode
	 */
	/*
	function &generateHeadDom(&$doc, &$journal) {
		$head =& XMLCustomWriter::createElement($doc, 'head');

		// DOI batch ID is a simple tracking ID: initials + timestamp
		XMLCustomWriter::createChildWithText($doc, $head, 'doi_batch_id', $journal->getLocalizedSetting('initials') . '_' . time());
		XMLCustomWriter::createChildWithText($doc, $head, 'timestamp', time());

		$journalId = $journal->getId();

		/* Depositor defaults to the Journal's technical Contact *
		$depositorNode =& JGateExportDom::generateDepositorDom($doc, $journal->getSetting('supportName'), $journal->getSetting('supportEmail'));
		XMLCustomWriter::appendChild($head, $depositorNode);

		/* The registrant is assumed to be the Publishing institution *
		$publisherInstitution = $journal->getSetting('publisherInstitution');
		XMLCustomWriter::createChildWithText($doc, $head, 'registrant', $publisherInstitution);

		return $head;
	}
	*/

	/**
	 * Generate depositor node
	 * @param $doc XMLNode
	 * @param $name string
	 * @param $email string
	 * @return XMLNode
	 */
	function &generateDepositorDom(&$doc, $name, $email) {
		$depositor =& XMLCustomWriter::createElement($doc, 'depositor');
		XMLCustomWriter::createChildWithText($doc, $depositor, 'name', $name);
		XMLCustomWriter::createChildWithText($doc, $depositor, 'email_address', $email);

		return $depositor;
	}

	/**
	 * Generate metadata for journal - accompanies every article
	 * @param $doc XMLNode
	 * @param $journal Journal
	 * @return XMLNode
	 */
	/*
	function &generateJournalMetadataDom(&$doc, &$journal) {
		$journalMetadataNode =& XMLCustomWriter::createElement($doc, 'journal_metadata');

		/* Full Title of Journal *
		XMLCustomWriter::createChildWithText($doc, $journalMetadataNode, 'full_title', $journal->getLocalizedTitle());

		/* Abbreviated title - defaulting to initials if no abbreviation found *
		if ($journal->getLocalizedSetting('abbreviation') != '' ) {
			XMLCustomWriter::createChildWithText($doc, $journalMetadataNode, 'abbrev_title', $journal->getLocalizedSetting('abbreviation'));
		}

		/* Both ISSNs are permitted for CrossRef, so sending whichever one (or both) *
		if ( $ISSN = $journal->getSetting('onlineIssn') ) {
			$onlineISSN =& XMLCustomWriter::createChildWithText($doc, $journalMetadataNode, 'issn', $ISSN);
			XMLCustomWriter::setAttribute($onlineISSN, 'media_type', 'electronic');
		}
		else {
			$onlineISSN =& XMLCustomWriter::createChildWithText($doc, $journalMetadataNode, 'issn', '0000-0000');
			XMLCustomWriter::setAttribute($onlineISSN, 'media_type', 'electronic');
		}

		/* Both ISSNs are permitted for CrossRef so sending whichever one (or both) *
		if ( $ISSN = $journal->getSetting('printIssn') ) {
			$printISSN =& XMLCustomWriter::createChildWithText($doc, $journalMetadataNode, 'issn', $ISSN);
			XMLCustomWriter::setAttribute($printISSN, 'media_type', 'print');
		}

		return $journalMetadataNode;
	}
	*/

	/**
	 * Generate journal issue tag to accompany every article
	 * @param $doc XMLNode
	 * @param $journal Journal
	 * @param $issue Issue
	 * @param $section Section
	 * @param $article Article
	 * @return XMLNode
	 */
	/*
	function &generateJournalIssueDom(&$doc, &$journal, &$issue, &$section, &$article) {
		$journalIssueNode =& XMLCustomWriter::createElement($doc, 'journal_issue');

		if ($issue->getDatePublished()) {
			$publicationDateNode =& JGateExportDom::generatePublisherDateDom($doc, $issue->getDatePublished());
			XMLCustomWriter::appendChild($journalIssueNode, $publicationDateNode);
		}

		$journalVolumeNode =& XMLCustomWriter::createElement($doc, 'journal_volume');
		XMLCustomWriter::appendChild($journalIssueNode, $journalVolumeNode);
		XMLCustomWriter::createChildWithText($doc, $journalVolumeNode, 'volume', $issue->getVolume());

		XMLCustomWriter::createChildWithText($doc, $journalIssueNode, 'issue', $issue->getNumber());

		return $journalIssueNode;
	}
	*/

	/**
	 * Generate the article node (the heart of the file).
	 * @param $doc XMLNode
	 * @param $journal Journal
	 * @param $issue Issue
	 * @param $section Section
	 * @param $article Article
	 * @return XMLNode
	 */
	function &generateArticleDom(&$doc, &$journal, &$issue, &$section, &$article) {
		// Create the base node
		$articleNode =& XMLCustomWriter::createElement($doc, 'article');
		//XMLCustomWriter::setAttribute($articleNode, 'publication_type', 'full_text');

		/* Titles */
		$titlesNode =& XMLCustomWriter::createElement($doc, 'ArtTitle');
		$titlesTextNode =&XMLCustomWriter::createTextNode($doc, $article->getLocalizedTitle());
		XMLCustomWriter::appendChild($titlesNode, $titlesTextNode);	
		XMLCustomWriter::appendChild($articleNode, $titlesNode);
		
		/* The registrant is assumed to be the Publishing institution */
		$publisherInstitution = $journal->getSetting('publisherInstitution');
		XMLCustomWriter::createChildWithText($doc, $articleNode, 'PubName', $publisherInstitution);
		
		/* Full Title of Journal */
		XMLCustomWriter::createChildWithText($doc, $articleNode, 'JournalName', $journal->getLocalizedTitle());
		
		/* Both ISSNs are permitted for CrossRef, so sending whichever one (or both) */
		if ( $ISSN = $journal->getSetting('onlineIssn') ) {
			$onlineISSN =& XMLCustomWriter::createChildWithText($doc, $articleNode, 'EISSN', $ISSN);
		}
		
		/* Both ISSNs are permitted for CrossRef so sending whichever one (or both) */
		if ( $ISSN = $journal->getSetting('printIssn') ) {
			$printISSN =& XMLCustomWriter::createChildWithText($doc, $articleNode, 'PISSN', $ISSN);
		}
		
		/* Generate publication date */
		if ($issue->getDatePublished()) {
			$publicationDateNode =& JGateExportDom::generatePublisherDateDom($doc, $issue->getDatePublished());
			XMLCustomWriter::appendChild($articleNode, $publicationDateNode);
		}
		
		/* Journal volume */
		XMLCustomWriter::createChildWithText($doc, $articleNode, 'volume', $issue->getVolume());
		
		/* Journal Issue */
		XMLCustomWriter::createChildWithText($doc, $articleNode, 'issue', $issue->getNumber());
		
		/* Supplementary files */
		$textSUP = 'No';
		if ($article->getSuppFiles())
		{
			$textSUP = 'Yes';
		}
		
		XMLCustomWriter::createChildWithText($doc, $articleNode, 'SupIssue', $textSUP);
		
		/* publication date */
		$parsedPubdate = strtotime($issue->getDatePublished());		
		XMLCustomWriter::createChildWithText($doc, $articleNode, 'Pubdate', date('d-m-Y', $parsedPubdate));
		
		/* Authors */
		$authStr = '';
		foreach ($article->getAuthors() as $author) {
			$authStr =+ ucfirst($author->getFirstName()).(($author->getMiddleName())?' '.ucfirst($author->getMiddleName()):''.' '.ucfirst($author->getLastName()));
		}		
		XMLCustomWriter::createChildWithText($doc, $articleNode, 'AuthorName', ucfirst($author->getFirstName()).(($author->getMiddleName())?' '.ucfirst($author->getMiddleName()):''));
		/* Affiliation and email ToDO */
		
		/* publisher_item is the article pages */
		if ($article->getPages() != '') {
			XMLCustomWriter::createChildWithText($doc, $articleNode, 'PageNo', $article->getPages());
		}
		
		/* Generate DOI */
		XMLCustomWriter::createChildWithText($doc, $articleNode, 'DOI', $article->getDOI());
		
		
		/* Article Keywords TODO*/
		$subjects = array_map('trim', explode(';', $article->getLocalizedSubject()));

		foreach ($subjects as $keyword) {
			XMLCustomWriter::createChildWithText($doc, $articleNode, 'Keywords', $keyword, false);
		}
		//XMLCustomWriter::createChildWithText($doc, $articleNode, 'Keywords', '');
		
		/* --- Abstract --- */
		if ($article->getLocalizedAbstract()) {
			$abstractNode = XMLCustomWriter::createChildWithText($doc, $articleNode, 'Abstract', strip_tags($article->getLocalizedAbstract()), false);
		}
		
		
		/* URL */
		$URLsNode =& XMLCustomWriter::createElement($doc, 'URLs');
		XMLCustomWriter::createChildWithText($doc, $URLsNode, 'abstract', Request::url(null, 'article', 'view', $article->getId()));
		
		$fulltextNode =& XMLCustomWriter::createElement($doc, 'Fulltext');
		XMLCustomWriter::createChildWithText($doc, $fulltextNode, 'pdf', Request::url(null, 'article', 'download', array($article->getId(),'pdf')));
		
		XMLCustomWriter::appendChild($URLsNode, $fulltextNode);	
		XMLCustomWriter::appendChild($articleNode, $URLsNode);
		
		/*
		$contributorsNode =& XMLCustomWriter::createElement($doc, 'contributors');

		/* AuthorList *
		$isFirst = true;
		foreach ($article->getAuthors() as $author) {
			$authorNode =& JGateExportDom::generateAuthorDom($doc, $author, $isFirst);
			$isFirst = false;
			XMLCustomWriter::appendChild($contributorsNode, $authorNode);
		}
		XMLCustomWriter::appendChild($articleNode, $contributorsNode);

		/* publication date of article *
		if ($article->getDatePublished()) {
			$publicationDateNode =& JGateExportDom::generatePublisherDateDom($doc, $article->getDatePublished());
			XMLCustomWriter::appendChild($articleNode, $publicationDateNode);
		}
		*/
		

		return $articleNode;
	}

	/**
	 * Generate doi_data element - this is what assigns the DOI
	 * @param $doc XMLNode
	 * @param $DOI string
	 * @param $url string
	 */
	/*
	function &generateDOIdataDom(&$doc, $DOI, $url) {
		$DOIdataNode =& XMLCustomWriter::createElement($doc, 'doi_data');
		XMLCustomWriter::createChildWithText($doc, $DOIdataNode, 'doi', $DOI);
		XMLCustomWriter::createChildWithText($doc, $DOIdataNode, 'resource', $url);

		return $DOIdataNode;
	}
	*/

	/**
	 * Generate author node
	 * @param $doc XMLNode
	 * @param $author Author
	 * @return XMLNode
	 */
	function &generateAuthorDom(&$doc, &$author, $isFirst = false) {
		$authorNode =& XMLCustomWriter::createElement($doc, 'person_name');
		XMLCustomWriter::setAttribute($authorNode, 'contributor_role', 'author');

		/* there should only be 1 primary contact per article */
		if ($isFirst) {
			XMLCustomWriter::setAttribute($authorNode, 'sequence', 'first');
		} else {
			XMLCustomWriter::setAttribute($authorNode, 'sequence', 'additional');
		}

		XMLCustomWriter::createChildWithText($doc, $authorNode, 'given_name', ucfirst($author->getFirstName()).(($author->getMiddleName())?' '.ucfirst($author->getMiddleName()):''));
		XMLCustomWriter::createChildWithText($doc, $authorNode, 'surname', ucfirst($author->getLastName()));

		return $authorNode;
	}

	/**
	 * Generate publisher date - order matters
	 * @param $doc XMLNode
	 * @param $pubdate string
	 * @return XMLNode
	 */
	function &generatePublisherDateDom(&$doc, $pubdate) {
		$publicationDateNode =& XMLCustomWriter::createElement($doc, 'pub-date');
		XMLCustomWriter::setAttribute($publicationDateNode, 'pub-type', 'epub');

		$parsedPubdate = strtotime($pubdate);		
		XMLCustomWriter::createChildWithText($doc, $publicationDateNode, 'day', date('d', $parsedPubdate), false);
		XMLCustomWriter::createChildWithText($doc, $publicationDateNode, 'month', date('m', $parsedPubdate), false);
		XMLCustomWriter::createChildWithText($doc, $publicationDateNode, 'year', date('Y', $parsedPubdate));

		return $publicationDateNode;
	}
}

?>
