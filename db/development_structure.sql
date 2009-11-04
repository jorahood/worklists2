CREATE TABLE `boilerusage` (
  `boiler` varchar(255) DEFAULT NULL,
  `fromid` varchar(255) DEFAULT NULL,
  KEY `index_boilerusage_on_boiler` (`boiler`),
  KEY `index_boilerusage_on_fromid` (`fromid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `document` (
  `id` varchar(255) DEFAULT NULL,
  `birthdate` date DEFAULT NULL,
  `modifieddate` date DEFAULT NULL,
  `approveddate` date DEFAULT NULL,
  `owner` varchar(255) DEFAULT NULL,
  `author` varchar(255) DEFAULT NULL,
  `importance` int(11) DEFAULT NULL,
  `visibility` int(11) DEFAULT NULL,
  `volatility` int(11) DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  UNIQUE KEY `index_docs_on_id` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `documentdomain` (
  `id` varchar(255) DEFAULT NULL,
  `domain` varchar(255) DEFAULT NULL,
  KEY `index_documentdomain_on_id` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `documentnames` (
  `name` varchar(255) DEFAULT NULL,
  `docid` varchar(255) DEFAULT NULL,
  KEY `index_documentnames_on_docid` (`docid`),
  KEY `index_documentnames_on_name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `domain_searches` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `search_id` int(11) DEFAULT NULL,
  `domain_id` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `domainlist` (
  `domain` varchar(255) DEFAULT NULL,
  `class` varchar(255) DEFAULT NULL,
  `type` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `visible` varchar(512) DEFAULT NULL,
  `accessible` varchar(512) DEFAULT NULL,
  `audience` varchar(512) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `expire` (
  `id` varchar(255) DEFAULT NULL,
  `expiredate` date DEFAULT NULL,
  `explanation` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `hotitem` (
  `id` varchar(255) DEFAULT NULL,
  `hotitem` varchar(255) DEFAULT NULL,
  KEY `index_hotitem_on_id` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `importance` (
  `rank` int(11) DEFAULT NULL,
  `importance` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `kba_by_searches` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `search_id` int(11) DEFAULT NULL,
  `kba_by_id` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `kba_searches` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `search_id` int(11) DEFAULT NULL,
  `kba_id` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `kba_usage` (
  `docid` varchar(4) NOT NULL DEFAULT '',
  `kba` varchar(4) NOT NULL DEFAULT '',
  PRIMARY KEY (`docid`,`kba`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `kbresource` (
  `id` varchar(255) DEFAULT NULL,
  `username` varchar(255) DEFAULT NULL,
  KEY `index_kbresource_on_id` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `kbuser` (
  `username` varchar(255) DEFAULT NULL,
  `lastname` varchar(255) DEFAULT NULL,
  `firstname` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `worknumber` varchar(255) DEFAULT NULL,
  `homenumber` varchar(255) DEFAULT NULL,
  `status` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `pagernumber` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `listed_docs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `list_id` int(11) DEFAULT NULL,
  `doc_id` varchar(255) DEFAULT NULL,
  `status` varchar(255) DEFAULT NULL,
  `tag` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15640 DEFAULT CHARSET=utf8;

CREATE TABLE `lists` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `owner_id` int(11) DEFAULT NULL,
  `comment` text,
  `audience_id` varchar(255) DEFAULT NULL,
  `search_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

CREATE TABLE `notes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `text` text,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `owner_id` int(11) DEFAULT NULL,
  `listed_doc_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=utf8;

CREATE TABLE `references` (
  `fromid` varchar(255) NOT NULL DEFAULT '',
  `toid` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`fromid`,`toid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `schema_migrations` (
  `version` varchar(255) NOT NULL,
  UNIQUE KEY `unique_schema_migrations` (`version`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `searches` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `importance_id` int(11) DEFAULT NULL,
  `visibility_id` int(11) DEFAULT NULL,
  `volatility_id` int(11) DEFAULT NULL,
  `status_id` int(11) DEFAULT NULL,
  `author_id` varchar(255) DEFAULT NULL,
  `owner_id` varchar(255) DEFAULT NULL,
  `expiredate` date DEFAULT NULL,
  `resource_id` varchar(255) DEFAULT NULL,
  `title_search` varchar(255) DEFAULT NULL,
  `birthdate` date DEFAULT NULL,
  `modifieddate` date DEFAULT NULL,
  `approveddate` date DEFAULT NULL,
  `boiler_id` varchar(255) DEFAULT NULL,
  `hotitem_id` varchar(255) DEFAULT NULL,
  `xtra_search` varchar(255) DEFAULT NULL,
  `approveddate_is` varchar(255) DEFAULT NULL,
  `birthdate_is` varchar(255) DEFAULT NULL,
  `modifieddate_is` varchar(255) DEFAULT NULL,
  `expiredate_is` varchar(255) DEFAULT NULL,
  `importance_is` varchar(255) DEFAULT NULL,
  `visibility_is` varchar(255) DEFAULT NULL,
  `volatility_is` varchar(255) DEFAULT NULL,
  `status_is` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

CREATE TABLE `status` (
  `rank` int(11) DEFAULT NULL,
  `status` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `titleaudience` (
  `audience` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `titlecache` (
  `title` varchar(255) DEFAULT NULL,
  `docid` varchar(255) NOT NULL DEFAULT '',
  `audience` varchar(255) NOT NULL DEFAULT '',
  KEY `index_titlecache_on_audience` (`audience`),
  KEY `index_titlecache_on_docid` (`docid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `crypted_password` varchar(40) DEFAULT NULL,
  `salt` varchar(40) DEFAULT NULL,
  `remember_token` varchar(255) DEFAULT NULL,
  `remember_token_expires_at` datetime DEFAULT NULL,
  `email_address` varchar(255) DEFAULT NULL,
  `administrator` tinyint(1) DEFAULT '0',
  `state` varchar(255) DEFAULT 'active',
  `key_timestamp` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

CREATE TABLE `visibility` (
  `rank` int(11) DEFAULT NULL,
  `visibility` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `volatility` (
  `rank` int(11) DEFAULT NULL,
  `volatility` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `xtra` (
  `term` varchar(255) DEFAULT NULL,
  `weight` int(11) DEFAULT NULL,
  `id` varchar(255) DEFAULT NULL,
  KEY `index_xtra_on_id` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

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

INSERT INTO schema_migrations (version) VALUES ('20090616021458');

INSERT INTO schema_migrations (version) VALUES ('20090618145229');

INSERT INTO schema_migrations (version) VALUES ('20090618150813');

INSERT INTO schema_migrations (version) VALUES ('20090619032710');

INSERT INTO schema_migrations (version) VALUES ('20090620234309');

INSERT INTO schema_migrations (version) VALUES ('20090623144231');

INSERT INTO schema_migrations (version) VALUES ('20090624145938');

INSERT INTO schema_migrations (version) VALUES ('20090624155020');

INSERT INTO schema_migrations (version) VALUES ('20090624172948');

INSERT INTO schema_migrations (version) VALUES ('20090630144740');