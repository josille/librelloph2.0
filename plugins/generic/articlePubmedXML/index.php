<?php

/**
 * @defgroup plugins_generic_articlepubmedxml
 */
 
/**
 * @file plugins/generic/articlePubmedXML/index.php
 *
 * Copyright (c) 2009 <Mahmoud Saghaei>
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * @ingroup plugins_generic_articlePubmedXML
 * @brief Adds XML link to the galley and abstract listing of articles in TOC
 *
 */

require_once('ArticlePubmedXMLPlugin.inc.php');

return new ArticlePubmedXMLPlugin();

?>
