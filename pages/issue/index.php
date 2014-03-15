<?php

/**
 * @defgroup pages_issue
 */
 
/**
 * @file pages/issue/index.php
 *
 * Copyright (c) 2003-2012 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * @ingroup pages_issue
 * @brief Handle requests for issue functions. 
 *
 */

// $Id$


switch ($op) {
	case 'index':
	case 'current':
	case 'view':
	case 'viewXML':
	case 'archiveSiteMapXML':
	case 'issueSiteMapXml':
	case 'downloadPDF':
	case 'archive':
		define('HANDLER_CLASS', 'IssueHandler');
		import('pages.issue.IssueHandler');
		break;
}

?>
