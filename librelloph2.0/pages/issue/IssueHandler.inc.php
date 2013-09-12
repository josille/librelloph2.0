<?php

/**
 * @file IssueHandler.inc.php
 *
 * Copyright (c) 2003-2012 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * @class IssueHandler
 * @ingroup pages_issue
 *
 * @brief Handle requests for issue functions.
 */

// $Id$


import ('classes.issue.IssueAction');
import('classes.handler.Handler');

class IssueHandler extends Handler {
	/**
	 * Constructor
	 **/
	function IssueHandler() {
		parent::Handler();
		
		$this->addCheck(new HandlerValidatorJournal($this));
		$this->addCheck(new HandlerValidatorCustom($this, false, null, null, create_function('$journal', 'return $journal->getSetting(\'publishingMode\') != PUBLISHING_MODE_NONE;'), array(Request::getJournal())));
	}

	/**
	 * Display about index page.
	 */
	function index($args) {
		$this->current();
	}

	/**
	 * Display current issue page.
	 */
	function current($args = null) {
		$this->validate();
		$this->setupTemplate();

		$journal =& Request::getJournal();

		$issueDao =& DAORegistry::getDAO('IssueDAO');
		$issue =& $issueDao->getCurrentIssue($journal->getId(), true);

		$templateMgr =& TemplateManager::getManager();

		if ($issue != null) {
			import('classes.file.PublicFileManager');
			$publicFileManager = new PublicFileManager();

			if ($styleFileName = $issue->getStyleFileName()) {
				$templateMgr->addStyleSheet(
					Request::getBaseUrl() . '/' . $publicFileManager->getJournalFilesPath($journal->getId()) . '/' . $styleFileName
				);
			}

			$issueHeadingTitle = $issue->getIssueIdentification(false, true,false,true);
			$issueCrumbTitle = $issue->getIssueIdentification(false, true);

			$arg = isset($args[0]) ? $args[0] : '';
			$showToc = ($arg == 'showToc') ? true : false;

			$locale = AppLocale::getLocale();
			$templateMgr->assign('locale', $locale);

			$coverPagePath = Request::getBaseUrl() . '/';
			$coverPagePath .= $publicFileManager->getJournalFilesPath($journal->getId()) . '/';
			$templateMgr->assign('coverPagePath', $coverPagePath);

			if (!$showToc && $issue->getFileName($locale) && $issue->getShowCoverPage($locale) && !$issue->getHideCoverPageCover($locale)) {
				$templateMgr->assign('fileName', $issue->getFileName($locale));
				$templateMgr->assign('width', $issue->getWidth($locale));
				$templateMgr->assign('height', $issue->getHeight($locale));
				$templateMgr->assign('coverPageAltText', $issue->getCoverPageAltText($locale));
				$templateMgr->assign('originalFileName', $issue->getOriginalFileName($locale));

				$showToc = false;
			} else {
				//$publishedArticleDao =& DAORegistry::getDAO('PublishedArticleDAO');
								
				/*
				 * by default was (id, true, this added by RDLG)
				 */
				//$publishedArticles =& $publishedArticleDao->getPublishedArticlesInSections($issue->getId(), false,false);
				//$templateMgr->assign_by_ref('publishedArticles', $publishedArticles);
				
				//import('lib.pkp.classes.db.DBResultRange');
				//$rangeInfo = new DBResultRange(5, 1);				
				
				$articleDao =& DAORegistry::getDAO('PublishedArticleDAO');
				//$articles =& $articleDao->getPublishedArticlesByJournalId($journal->getId(),NULL,true);
				$articles =& $articleDao->getPublishedArticlesByIssueId($issue->getId(),NULL,false,true);
				
				$templateMgr->assign_by_ref('articles',$articles );
				
				$showToc = true;
			}

			$templateMgr->assign_by_ref('issue', $issue);
			$templateMgr->assign('showToc', $showToc);

			// Subscription Access
			import('classes.issue.IssueAction');
			$subscriptionRequired = IssueAction::subscriptionRequired($issue);
			$subscribedUser = IssueAction::subscribedUser($journal);
			$subscribedDomain = IssueAction::subscribedDomain($journal);
			$subscriptionExpiryPartial = $journal->getSetting('subscriptionExpiryPartial');
			
			if ($showToc && $subscriptionRequired && !$subscribedUser && !$subscribedDomain && $subscriptionExpiryPartial) {
				$templateMgr->assign('subscriptionExpiryPartial', true);
				$publishedArticleDao =& DAORegistry::getDAO('PublishedArticleDAO');
				$publishedArticlesTemp =& $publishedArticleDao->getPublishedArticles($issue->getId());

				$articleExpiryPartial = array();
				foreach ($publishedArticlesTemp as $publishedArticle) {
					$partial = IssueAction::subscribedUser($journal, $issue->getId(), $publishedArticle->getId());
					if (!$partial) IssueAction::subscribedDomain($journal, $issue->getId(), $publishedArticle->getId()); 
					$articleExpiryPartial[$publishedArticle->getId()] = $partial;
				}
				$templateMgr->assign_by_ref('articleExpiryPartial', $articleExpiryPartial);
			}

			$templateMgr->assign('subscriptionRequired', $subscriptionRequired);
			$templateMgr->assign('subscribedUser', $subscribedUser);
			$templateMgr->assign('subscribedDomain', $subscribedDomain);
			$templateMgr->assign('showGalleyLinks', $journal->getSetting('showGalleyLinks'));

			import('classes.payment.ojs.OJSPaymentManager');
			$paymentManager =& OJSPaymentManager::getManager();
			if ( $paymentManager->onlyPdfEnabled() ) {
				$templateMgr->assign('restrictOnlyPdf', true);
			}
			if ( $paymentManager->purchaseArticleEnabled() ) {
				$templateMgr->assign('purchaseArticleEnabled', true);
			}			
			
		} else {
			$issueCrumbTitle = __('current.noCurrentIssue');
			$issueHeadingTitle = __('current.noCurrentIssue');
		}
 
		// Display creative commons logo/licence if enabled
		$templateMgr->assign('displayCreativeCommons', $journal->getSetting('includeCreativeCommons'));
		$templateMgr->assign('issueCrumbTitle', $issueCrumbTitle);
		$templateMgr->assign('issueHeadingTitle', $issueHeadingTitle);
		$templateMgr->assign('pageHierarchy', array(array(Request::url(null, 'issue', 'current'), 'current.current')));
		$templateMgr->assign('helpTopicId', 'user.currentAndArchives');
		$templateMgr->display('issue/viewPage.tpl');
	}

	/**
	 * Display issue view page.
	 */
	function view($args) {
		$this->validate();
		$this->setupTemplate();

		$issueId = isset($args[0]) ? $args[0] : 0;
		$showToc = isset($args[1]) ? $args[1] : '';

		$journal =& Request::getJournal();

		$issueDao =& DAORegistry::getDAO('IssueDAO');

		if ($journal->getSetting('enablePublicIssueId')) {
			$issue =& $issueDao->getIssueByBestIssueId($issueId, $journal->getId());
		} else {
			$issue =& $issueDao->getIssueById((int) $issueId, null, true);
		}

		if (!$issue) Request::redirect(null, null, 'current');

		$templateMgr =& TemplateManager::getManager();
		$this->setupIssueTemplate($issue, ($showToc == 'showToc') ? true : false);

		
		$articleDao =& DAORegistry::getDAO('PublishedArticleDAO');
		$articles =& $articleDao->getPublishedArticlesByIssueId($issueId,NULL,false);
		$templateMgr->assign_by_ref('articles',$articles );
		
		$templateMgr->assign_by_ref('issueHeadingTitle',$issue->getIssueIdentification(false,false,false,true));
		
		// Display creative commons logo/licence if enabled
		$templateMgr->assign('displayCreativeCommons', $journal->getSetting('includeCreativeCommons'));
		$templateMgr->assign('pageHierarchy', array(array(Request::url(null, 'issue', 'archive'), 'archive.archives')));
		$templateMgr->assign('helpTopicId', 'user.currentAndArchives');
		$templateMgr->display('issue/viewPage.tpl');

	}
	
	function viewXML($args) {
		$issueId = isset($args[0]) ? $args[0] : 0;
		$showToc = isset($args[1]) ? $args[1] : '';

		$journal =& Request::getJournal();

		$issueDao =& DAORegistry::getDAO('IssueDAO');

		if ($journal->getSetting('enablePublicIssueId')) {
			$issue =& $issueDao->getIssueByBestIssueId($issueId, $journal->getId());
		} else {
			$issue =& $issueDao->getIssueById((int) $issueId, null, true);
		}

		if (!$issue) Request::redirect(null, null, 'current');
						
		PluginRegistry::loadCategory('importexport');
		$templateMgr = &TemplateManager::getManager();
		$plugin = &PluginRegistry::getPlugin('importexport', 'PubMedExportPlugin');
		$arr = array("exportIssue", $issueId);
		
		return $plugin->display($arr);
	}
	
/**
	 * Downloads the issue
	 * @param $args array
	 * @param $request Request
	 */
	function downloadPDF($args) {		
		$issueId = isset($args[0]) ? $args[0] : 0;
		$showToc = isset($args[1]) ? $args[1] : '';
		
		$journal =& Request::getJournal();

		$issueDao =& DAORegistry::getDAO('IssueDAO');

		if ($journal->getSetting('enablePublicIssueId')) {
			$issue =& $issueDao->getIssueByBestIssueId($issueId, $journal->getId());
		} else {
			$issue =& $issueDao->getIssueById((int) $issueId, null, true);
		}

		if (!$issue) Request::redirect(null, null, 'current');
		
		//Crate name of toc file
		//PaG-1-1.pdf
		//PaG-SI-2003-1.pdf
		$issue_name = $issue->getLocalizedOriginalFileName();
		
		$issue_name = str_replace("cover", "", $issue_name);
		$issue_name = str_replace(".png", ".pdf", $issue_name);
		$issue_name = str_replace(".jpg", ".pdf", $issue_name);
		
		//if (!HookRegistry::call('ArticleHandler::downloadFile', array(&$article, &$galley))) {
		import('classes.file.JournalFileManager');			
		$JournalFileManager = new JournalFileManager($journal);

		$JournalFileManager->downloadFile('issues/'.$issueId.'/'.$issue_name,null);
		
		//}
	}

	/**
	 * Given an issue, set up the template with all the required variables for
	 * issues/view.tpl to function properly.
	 * @param $issue object The issue to display
	 * @param $showToc boolean iff false and a custom cover page exists,
	 * 	the cover page will be displayed. Otherwise table of contents
	 * 	will be displayed.
	 */
	function setupIssueTemplate(&$issue, $showToc = false) {
		$journal =& Request::getJournal();
		$journalId = $journal->getId();
		$templateMgr =& TemplateManager::getManager();
		if (isset($issue) && ($issue->getPublished() || Validation::isEditor($journalId) || Validation::isLayoutEditor($journalId) || Validation::isProofreader($journalId)) && $issue->getJournalId() == $journalId) {

			$issueHeadingTitle = $issue->getIssueIdentification(false, true);
			$issueCrumbTitle = $issue->getIssueIdentification(false, true);

			$locale = AppLocale::getLocale();

			import('classes.file.PublicFileManager');
			$publicFileManager = new PublicFileManager();
			$coverPagePath = Request::getBaseUrl() . '/';
			$coverPagePath .= $publicFileManager->getJournalFilesPath($journalId) . '/';
			$templateMgr->assign('coverPagePath', $coverPagePath);
			$templateMgr->assign('locale', $locale);


			if (!$showToc && $issue->getFileName($locale) && $issue->getShowCoverPage($locale) && !$issue->getHideCoverPageCover($locale)) {
				$templateMgr->assign('fileName', $issue->getFileName($locale));
				$templateMgr->assign('width', $issue->getWidth($locale));
				$templateMgr->assign('height', $issue->getHeight($locale));
				$templateMgr->assign('coverPageAltText', $issue->getCoverPageAltText($locale));
				$templateMgr->assign('originalFileName', $issue->getOriginalFileName($locale));

				$showToc = false;
			} else {
				$publishedArticleDao =& DAORegistry::getDAO('PublishedArticleDAO');
				/*
				 * by default was (id, true, this added by RDLG)
				 */
				$publishedArticles =& $publishedArticleDao->getPublishedArticlesInSections($issue->getId(), false, false);

				$publicFileManager = new PublicFileManager();
				$templateMgr->assign('publishedArticles', $publishedArticles);
				$showToc = true;
			}
			$templateMgr->assign('showToc', $showToc);
			$templateMgr->assign('issueId', $issue->getBestIssueId());
			$templateMgr->assign('issue', $issue);

			// Subscription Access
			import('classes.issue.IssueAction');
			$subscriptionRequired = IssueAction::subscriptionRequired($issue);
			$subscribedUser = IssueAction::subscribedUser($journal);
			$subscribedDomain = IssueAction::subscribedDomain($journal);
			$subscriptionExpiryPartial = $journal->getSetting('subscriptionExpiryPartial');
			
			if ($showToc && $subscriptionRequired && !$subscribedUser && !$subscribedDomain && $subscriptionExpiryPartial) {
				$templateMgr->assign('subscriptionExpiryPartial', true);
				$publishedArticleDao =& DAORegistry::getDAO('PublishedArticleDAO');
				$publishedArticlesTemp =& $publishedArticleDao->getPublishedArticles($issue->getId());

				$articleExpiryPartial = array();
				foreach ($publishedArticlesTemp as $publishedArticle) {
					$partial = IssueAction::subscribedUser($journal, $issue->getId(), $publishedArticle->getId());
					if (!$partial) IssueAction::subscribedDomain($journal, $issue->getId(), $publishedArticle->getId()); 
					$articleExpiryPartial[$publishedArticle->getId()] = $partial;
				}
				$templateMgr->assign_by_ref('articleExpiryPartial', $articleExpiryPartial);
			}

			$templateMgr->assign('subscriptionRequired', $subscriptionRequired);
			$templateMgr->assign('subscribedUser', $subscribedUser);
			$templateMgr->assign('subscribedDomain', $subscribedDomain);
			$templateMgr->assign('showGalleyLinks', $journal->getSetting('showGalleyLinks'));

			import('classes.payment.ojs.OJSPaymentManager');
			$paymentManager =& OJSPaymentManager::getManager();
			if ( $paymentManager->onlyPdfEnabled() ) {
				$templateMgr->assign('restrictOnlyPdf', true);
			}
			if ( $paymentManager->purchaseArticleEnabled() ) {
				$templateMgr->assign('purchaseArticleEnabled', true);
			}			

		} else {
			$issueCrumbTitle = __('archive.issueUnavailable');
			$issueHeadingTitle = __('archive.issueUnavailable');
		}

		if ($styleFileName = $issue->getStyleFileName()) {
			import('classes.file.PublicFileManager');
			$publicFileManager = new PublicFileManager();
			$templateMgr->addStyleSheet(
				Request::getBaseUrl() . '/' . $publicFileManager->getJournalFilesPath($journalId) . '/' . $styleFileName
			);
		}

		$templateMgr->assign('pageCrumbTitleTranslated', $issueCrumbTitle);
		$templateMgr->assign('issueHeadingTitle', $issueHeadingTitle);
	}

	/**
	 * Display the issue archive listings
	 */
	function archive() {
		$this->validate();
		$this->setupTemplate();

		$journal =& Request::getJournal();
		$issueDao =& DAORegistry::getDAO('IssueDAO');
		$rangeInfo = Handler::getRangeInfo('issues');

		$publishedIssuesIterator = $issueDao->getPublishedIssues($journal->getId(), $rangeInfo);
		$publishedIssuesIteratorSI = $issueDao->getPublishedIssues($journal->getId(), $rangeInfo);

		import('classes.file.PublicFileManager');
		$publicFileManager = new PublicFileManager();
		$coverPagePath = Request::getBaseUrl() . '/';
		$coverPagePath .= $publicFileManager->getJournalFilesPath($journal->getId()) . '/';

		$templateMgr =& TemplateManager::getManager();
		$templateMgr->assign('coverPagePath', $coverPagePath);
		$templateMgr->assign('locale', AppLocale::getLocale());
		$templateMgr->assign_by_ref('issues', $publishedIssuesIterator);
		$templateMgr->assign_by_ref('issuesSI', $publishedIssuesIteratorSI);
		$templateMgr->assign('helpTopicId', 'user.currentAndArchives');
		$templateMgr->display('issue/archive.tpl');
	}
		
	function setupTemplate() {
		parent::setupTemplate();
		AppLocale::requireComponents(array(LOCALE_COMPONENT_PKP_READER, LOCALE_COMPONENT_OJS_EDITOR));
	}
	
	/**
	 * Display the issue archive index sitemap
	 */
	function archiveSiteMapXML() {
		//$this->validate();
		//$this->setupTemplate();

		$journal =& Request::getJournal();
		$issueDao =& DAORegistry::getDAO('IssueDAO');
		$rangeInfo = Handler::getRangeInfo('issues');

		$publishedIssuesIterator = $issueDao->getPublishedIssues($journal->getId(), $rangeInfo);
		$publishedIssuesIteratorSI = $issueDao->getPublishedIssues($journal->getId(), $rangeInfo);

		$templateMgr =& TemplateManager::getManager();
		//$templateMgr->assign('coverPagePath', $coverPagePath);
		$templateMgr->assign('locale', AppLocale::getLocale());
		$templateMgr->assign_by_ref('issues', $publishedIssuesIterator);
		$templateMgr->assign_by_ref('issuesSI', $publishedIssuesIteratorSI);
		//$templateMgr->assign('helpTopicId', 'user.currentAndArchives');
		$templateMgr->display('issue/siteMapXmlArchive.tpl','text/xml');
	}
	
	
	/**
	 * Display issue sitemap.
	 */
	function issueSiteMapXml($args) {
		//$this->validate();
		//$this->setupTemplate();

		$issueId = isset($args[0]) ? $args[0] : 0;
		$showToc = isset($args[1]) ? $args[1] : '';

		$journal =& Request::getJournal();

		$issueDao =& DAORegistry::getDAO('IssueDAO');

		if ($journal->getSetting('enablePublicIssueId')) {
			$issue =& $issueDao->getIssueByBestIssueId($issueId, $journal->getId());
		} else {
			$issue =& $issueDao->getIssueById((int) $issueId, null, true);
		}

		$templateMgr =& TemplateManager::getManager();

		
		$articleDao =& DAORegistry::getDAO('PublishedArticleDAO');
		$articles =& $articleDao->getPublishedArticlesByIssueId($issueId,NULL,false);
		$templateMgr->assign_by_ref('articles',$articles );
		
		$templateMgr->display('issue/issueSiteMapXml.tpl','text/xml');

	}
	
}

?>
