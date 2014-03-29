<?php

/**
 * @file pages/user/UserHandler.inc.php
 *
 * Copyright (c) 2003-2012 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * @class UserHandler
 * @ingroup pages_user
 *
 * @brief Handle requests for user functions.
 */

import('lib.pkp.pages.user.PKPUserHandler');

class MemInstHandler extends PKPUserHandler {
	/**
	 * Constructor
	 **/
	function MemInstHandler() {
		parent::PKPUserHandler();
	}

	/**
	 * Display user index page.
	 */
	function payMembershipInst() {
		$journal =& Request::getJournal();

		$sessionManager =& SessionManager::getManager();
		$session =& $sessionManager->getUserSession();
		
		$user =& Request::getUser();
		$userId = $user->getId();

		$this->setupTemplate();

		

		$templateMgr =& TemplateManager::getManager();
		$templateMgr->assign('journalTitle', $journal->getLocalizedTitle());
		$templateMgr->assign('journalPath', $journal->getPath());
		$templateMgr->assign('userId', $userId);

		$templateMgr->display('user/MemInst.tpl');
	}

}

?>
