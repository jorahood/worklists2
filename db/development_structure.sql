CREATE TABLE `audiences` (
  `id` varchar(255) default NULL,
  `description` varchar(255) default NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `docs` (
  `id` varchar(4) default NULL,
  `birthdate` date default NULL,
  `modifieddate` datetime default NULL,
  `approveddate` date default NULL,
  `owner` varchar(255) default NULL,
  `author` varchar(255) default NULL,
  `importance` varchar(255) default NULL,
  `visibility` varchar(255) default NULL,
  `volatility` varchar(255) default NULL,
  `status` varchar(255) default NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `domains` (
  `id` int(11) NOT NULL auto_increment,
  `domain` varchar(255) default NULL,
  `domain_class` varchar(255) default NULL,
  `domain_type` varchar(255) default NULL,
  `description` varchar(255) default NULL,
  `visible` varchar(512) default NULL,
  `accessible` varchar(512) default NULL,
  `audience` varchar(512) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `listed_docs` (
  `id` int(11) NOT NULL auto_increment,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  `list_id` int(11) default NULL,
  `doc_id` varchar(4) default NULL,
  `status` varchar(255) default NULL,
  `tag` varchar(255) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `lists` (
  `id` int(11) NOT NULL auto_increment,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  `name` varchar(255) default NULL,
  `owner_id` int(11) default NULL,
  `comment` text,
  `audience_id` varchar(255) default 'default',
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `notes` (
  `id` int(11) NOT NULL auto_increment,
  `text` text,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  `owner_id` int(11) default NULL,
  `listed_doc_id` tinyint(4) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `schema_migrations` (
  `version` varchar(255) NOT NULL,
  UNIQUE KEY `unique_schema_migrations` (`version`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `titles` (
  `id` int(11) NOT NULL auto_increment,
  `title` varchar(255) default NULL,
  `docid` varchar(255) default NULL,
  `audience` varchar(255) default NULL,
  PRIMARY KEY  (`id`),
  UNIQUE KEY `index_titles_on_doc_id_and_audience_id` (`docid`,`audience`)
) ENGINE=InnoDB AUTO_INCREMENT=18116 DEFAULT CHARSET=utf8;

CREATE TABLE `users` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(255) default NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  `crypted_password` varchar(40) default NULL,
  `salt` varchar(40) default NULL,
  `remember_token` varchar(255) default NULL,
  `remember_token_expires_at` datetime default NULL,
  `email_address` varchar(255) default NULL,
  `administrator` tinyint(1) default '0',
  `state` varchar(255) default 'active',
  `key_timestamp` datetime default NULL,
  PRIMARY KEY  (`id`)
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