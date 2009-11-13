CREATE TABLE `boilerusage` (
  `boiler` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `fromid` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  KEY `index_boilerusage_on_boiler` (`boiler`),
  KEY `index_boilerusage_on_fromid` (`fromid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `docid_searches` (
  `doc_id` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `search_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `document` (
  `id` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `birthdate` date DEFAULT NULL,
  `modifieddate` date DEFAULT NULL,
  `approveddate` date DEFAULT NULL,
  `owner` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `author` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `importance` int(11) DEFAULT NULL,
  `visibility` int(11) DEFAULT NULL,
  `volatility` int(11) DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  UNIQUE KEY `index_docs_on_id` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `documentdomain` (
  `id` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `domain` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  KEY `index_documentdomain_on_id` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `documentnames` (
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `docid` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  KEY `index_documentnames_on_docid` (`docid`),
  KEY `index_documentnames_on_name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `domain_searches` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `search_id` int(11) DEFAULT NULL,
  `domain_id` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `domainlist` (
  `domain` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `class` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `type` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `description` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `visible` varchar(512) COLLATE utf8_unicode_ci DEFAULT NULL,
  `accessible` varchar(512) COLLATE utf8_unicode_ci DEFAULT NULL,
  `audience` varchar(512) COLLATE utf8_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `expire` (
  `id` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `expiredate` date DEFAULT NULL,
  `explanation` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `hotitem` (
  `id` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `hotitem` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  KEY `index_hotitem_on_id` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `importance` (
  `rank` int(11) DEFAULT NULL,
  `importance` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `kba_by_searches` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `search_id` int(11) DEFAULT NULL,
  `kba_by_id` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `kba_searches` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `search_id` int(11) DEFAULT NULL,
  `kba_id` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `kba_usage` (
  `docid` varchar(4) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `kba` varchar(4) COLLATE utf8_unicode_ci NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `kbresource` (
  `id` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `username` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  KEY `index_kbresource_on_id` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `kbuser` (
  `username` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `lastname` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `firstname` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `email` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `worknumber` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `homenumber` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `status` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `password` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `pagernumber` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `listed_docs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `list_id` int(11) DEFAULT NULL,
  `doc_id` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `workstate` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `tag` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `lists` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `owner_id` int(11) DEFAULT NULL,
  `comment` text COLLATE utf8_unicode_ci,
  `audience_id` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `search_id` int(11) DEFAULT NULL,
  `show_workstate` tinyint(1) DEFAULT '1',
  `show_approveddate` tinyint(1) DEFAULT '1',
  `show_author` tinyint(1) DEFAULT NULL,
  `show_boiler` tinyint(1) DEFAULT NULL,
  `show_birthdate` tinyint(1) DEFAULT NULL,
  `show_domains` tinyint(1) DEFAULT '1',
  `show_expirations` tinyint(1) DEFAULT NULL,
  `show_hotitems` tinyint(1) DEFAULT NULL,
  `show_importance` tinyint(1) DEFAULT NULL,
  `show_kbas` tinyint(1) DEFAULT NULL,
  `show_kba_bys` tinyint(1) DEFAULT NULL,
  `show_modifieddate` tinyint(1) DEFAULT '1',
  `show_notes` tinyint(1) DEFAULT '1',
  `show_owner` tinyint(1) DEFAULT '1',
  `show_refs` tinyint(1) DEFAULT NULL,
  `show_refbys` tinyint(1) DEFAULT NULL,
  `show_referenced_boilers` tinyint(1) DEFAULT NULL,
  `show_resources` tinyint(1) DEFAULT NULL,
  `show_status` tinyint(1) DEFAULT NULL,
  `show_titles` tinyint(1) DEFAULT '1',
  `show_visibility` tinyint(1) DEFAULT '1',
  `show_volatility` tinyint(1) DEFAULT NULL,
  `show_xtras` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `notes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `text` text COLLATE utf8_unicode_ci,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `owner_id` int(11) DEFAULT NULL,
  `listed_doc_id` int(11) DEFAULT NULL,
  `doc_id` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `references` (
  `fromid` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `toid` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `schema_migrations` (
  `version` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  UNIQUE KEY `unique_schema_migrations` (`version`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `searches` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `importance_id` int(11) DEFAULT NULL,
  `visibility_id` int(11) DEFAULT NULL,
  `volatility_id` int(11) DEFAULT NULL,
  `status_id` int(11) DEFAULT NULL,
  `author_id` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `owner_id` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `expiredate` date DEFAULT NULL,
  `resource_id` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `title_search` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `birthdate` date DEFAULT NULL,
  `modifieddate` date DEFAULT NULL,
  `approveddate` date DEFAULT NULL,
  `boiler_id` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `hotitem_id` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `xtra_search` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `approveddate_is` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `birthdate_is` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `modifieddate_is` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `expiredate_is` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `importance_is` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `visibility_is` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `volatility_is` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `status_is` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `status` (
  `rank` int(11) DEFAULT NULL,
  `status` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `titleaudience` (
  `audience` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `description` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `titlecache` (
  `title` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `docid` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `audience` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  KEY `index_titlecache_on_audience` (`audience`),
  KEY `index_titlecache_on_docid` (`docid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `crypted_password` varchar(40) COLLATE utf8_unicode_ci DEFAULT NULL,
  `salt` varchar(40) COLLATE utf8_unicode_ci DEFAULT NULL,
  `remember_token` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `remember_token_expires_at` datetime DEFAULT NULL,
  `email_address` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `administrator` tinyint(1) DEFAULT '0',
  `state` varchar(255) COLLATE utf8_unicode_ci DEFAULT 'active',
  `key_timestamp` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `visibility` (
  `rank` int(11) DEFAULT NULL,
  `visibility` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `volatility` (
  `rank` int(11) DEFAULT NULL,
  `volatility` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `xtra` (
  `term` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `weight` int(11) DEFAULT NULL,
  `id` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  KEY `index_xtra_on_id` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO schema_migrations (version) VALUES ('20080825192621');

INSERT INTO schema_migrations (version) VALUES ('20080826185338');

INSERT INTO schema_migrations (version) VALUES ('20080826200701');

INSERT INTO schema_migrations (version) VALUES ('20080826210338');

INSERT INTO schema_migrations (version) VALUES ('20080827181857');

INSERT INTO schema_migrations (version) VALUES ('20080828130601');

INSERT INTO schema_migrations (version) VALUES ('20080828132757');

INSERT INTO schema_migrations (version) VALUES ('20080912152438');

INSERT INTO schema_migrations (version) VALUES ('20080912191042');

INSERT INTO schema_migrations (version) VALUES ('20080912200257');

INSERT INTO schema_migrations (version) VALUES ('20081020164010');

INSERT INTO schema_migrations (version) VALUES ('20081024191025');

INSERT INTO schema_migrations (version) VALUES ('20081024192134');

INSERT INTO schema_migrations (version) VALUES ('20081027201958');

INSERT INTO schema_migrations (version) VALUES ('20081027204830');

INSERT INTO schema_migrations (version) VALUES ('20081030134202');

INSERT INTO schema_migrations (version) VALUES ('20081030134204');

INSERT INTO schema_migrations (version) VALUES ('20081030135532');

INSERT INTO schema_migrations (version) VALUES ('20081030192724');

INSERT INTO schema_migrations (version) VALUES ('20081030192944');

INSERT INTO schema_migrations (version) VALUES ('20081030201942');

INSERT INTO schema_migrations (version) VALUES ('20081031153339');

INSERT INTO schema_migrations (version) VALUES ('20081031153816');

INSERT INTO schema_migrations (version) VALUES ('20081031165623');

INSERT INTO schema_migrations (version) VALUES ('20081031180756');

INSERT INTO schema_migrations (version) VALUES ('20081101141842');

INSERT INTO schema_migrations (version) VALUES ('20081101152006');

INSERT INTO schema_migrations (version) VALUES ('20081107160702');

INSERT INTO schema_migrations (version) VALUES ('20081107162236');

INSERT INTO schema_migrations (version) VALUES ('20081107180940');

INSERT INTO schema_migrations (version) VALUES ('20090321015115');

INSERT INTO schema_migrations (version) VALUES ('20090326143722');

INSERT INTO schema_migrations (version) VALUES ('20090326173349');

INSERT INTO schema_migrations (version) VALUES ('20090326183932');

INSERT INTO schema_migrations (version) VALUES ('20090329210301');

INSERT INTO schema_migrations (version) VALUES ('20090329211906');

INSERT INTO schema_migrations (version) VALUES ('20090329211909');

INSERT INTO schema_migrations (version) VALUES ('20090330001815');

INSERT INTO schema_migrations (version) VALUES ('20090330002558');

INSERT INTO schema_migrations (version) VALUES ('20090330002747');

INSERT INTO schema_migrations (version) VALUES ('20090330003503');

INSERT INTO schema_migrations (version) VALUES ('20090330004422');

INSERT INTO schema_migrations (version) VALUES ('20090330020855');

INSERT INTO schema_migrations (version) VALUES ('20090407154543');

INSERT INTO schema_migrations (version) VALUES ('20090407155319');

INSERT INTO schema_migrations (version) VALUES ('20090407175557');

INSERT INTO schema_migrations (version) VALUES ('20090408123236');

INSERT INTO schema_migrations (version) VALUES ('20090410145824');

INSERT INTO schema_migrations (version) VALUES ('20090411021231');

INSERT INTO schema_migrations (version) VALUES ('20090506202913');

INSERT INTO schema_migrations (version) VALUES ('20090507150745');

INSERT INTO schema_migrations (version) VALUES ('20090507182653');

INSERT INTO schema_migrations (version) VALUES ('20090508130635');

INSERT INTO schema_migrations (version) VALUES ('20090508135844');

INSERT INTO schema_migrations (version) VALUES ('20090519160209');

INSERT INTO schema_migrations (version) VALUES ('20090521132016');

INSERT INTO schema_migrations (version) VALUES ('20090603131607');

INSERT INTO schema_migrations (version) VALUES ('20090606030258');

INSERT INTO schema_migrations (version) VALUES ('20090609183408');

INSERT INTO schema_migrations (version) VALUES ('20090611181901');

INSERT INTO schema_migrations (version) VALUES ('20090612183321');

INSERT INTO schema_migrations (version) VALUES ('20090615145658');

INSERT INTO schema_migrations (version) VALUES ('20090615153424');

INSERT INTO schema_migrations (version) VALUES ('20090615160745');

INSERT INTO schema_migrations (version) VALUES ('20090615180816');

INSERT INTO schema_migrations (version) VALUES ('20090615182557');

INSERT INTO schema_migrations (version) VALUES ('20090615190225');

INSERT INTO schema_migrations (version) VALUES ('20090615195257');

INSERT INTO schema_migrations (version) VALUES ('20090615203112');

INSERT INTO schema_migrations (version) VALUES ('20090618145229');

INSERT INTO schema_migrations (version) VALUES ('20090618150813');

INSERT INTO schema_migrations (version) VALUES ('20090619032710');

INSERT INTO schema_migrations (version) VALUES ('20090620234309');

INSERT INTO schema_migrations (version) VALUES ('20090623144231');

INSERT INTO schema_migrations (version) VALUES ('20090624145938');

INSERT INTO schema_migrations (version) VALUES ('20091103191442');

INSERT INTO schema_migrations (version) VALUES ('20091105205540');

INSERT INTO schema_migrations (version) VALUES ('20091109213954');

INSERT INTO schema_migrations (version) VALUES ('20091110200159');

INSERT INTO schema_migrations (version) VALUES ('20091110200843');