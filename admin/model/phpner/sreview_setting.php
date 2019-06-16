<?php
/**************************************************************/
/*	@copyright	Phpner 2019							  */
/*	@support	http://phpner.ru					  */
/*	@license	LICENSE.txt									  */
/**************************************************************/

class ModelPhpnerSreviewSetting extends Model {
    public function installTables() {
        
        $sql1 = "CREATE TABLE IF NOT EXISTS `" . DB_PREFIX . "phpner_sreview_subject` (";
        $sql1 .= "  `phpner_sreview_subject_id` int(11) NOT NULL AUTO_INCREMENT,";
        $sql1 .= "  `sort_order` int(11) NOT NULL DEFAULT '0',";
        $sql1 .= "  `subject_rating_count1` int(11) NOT NULL DEFAULT '0',";
        $sql1 .= "  `subject_rating_count2` int(11) NOT NULL DEFAULT '0',";
        $sql1 .= "  `subject_rating_count3` int(11) NOT NULL DEFAULT '0',";
        $sql1 .= "  `subject_rating_count4` int(11) NOT NULL DEFAULT '0',";
        $sql1 .= "  `subject_rating_count5` int(11) NOT NULL DEFAULT '0',";
        $sql1 .= "  `status` tinyint(1) NOT NULL DEFAULT '0',";
        $sql1 .= "  `date_added` datetime NOT NULL,";
        $sql1 .= "  `date_modified` datetime NOT NULL,";
        $sql1 .= "  PRIMARY KEY (`phpner_sreview_subject_id`)";
        $sql1 .= ") ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=0 ;";
        
        $this->db->query($sql1);
        
        $sql2 = "CREATE TABLE IF NOT EXISTS `" . DB_PREFIX . "phpner_sreview_subject_description` (";
        $sql2 .= "  `phpner_sreview_subject_id` int(11) NOT NULL,";
        $sql2 .= "  `language_id` int(11) NOT NULL,";
        $sql2 .= "  `name` varchar(255) NOT NULL,";
        $sql2 .= "  PRIMARY KEY (`phpner_sreview_subject_id`,`language_id`),";
        $sql2 .= "  KEY `name` (`name`)";
        $sql2 .= ") ENGINE=MyISAM DEFAULT CHARSET=utf8;";
        
        $this->db->query($sql2);
        
        $sql3 = "CREATE TABLE IF NOT EXISTS `" . DB_PREFIX . "phpner_sreview_subject_to_store` (";
        $sql3 .= "  `phpner_sreview_subject_id` int(11) NOT NULL,";
        $sql3 .= "  `store_id` int(11) NOT NULL DEFAULT '0',";
        $sql3 .= "  PRIMARY KEY (`phpner_sreview_subject_id`,`store_id`)";
        $sql3 .= ") ENGINE=MyISAM DEFAULT CHARSET=utf8;";
        
        $this->db->query($sql3);
        
        $sql4 = "CREATE TABLE IF NOT EXISTS `" . DB_PREFIX . "phpner_sreview_reviews` (";
        $sql4 .= "  `phpner_sreview_review_id` int(11) NOT NULL AUTO_INCREMENT,";
        $sql4 .= "  `author` varchar(64) NOT NULL,";
        $sql4 .= "  `text` text NOT NULL,";
        $sql4 .= "  `status` tinyint(1) NOT NULL DEFAULT '0',";
        $sql4 .= "  `avg_rating` int(11) NOT NULL DEFAULT '0',";
        $sql4 .= "  `date_added` datetime NOT NULL,";
        $sql4 .= "  `date_modified` datetime NOT NULL,";
        $sql4 .= "  PRIMARY KEY (`phpner_sreview_review_id`)";
        $sql4 .= ") ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=0 ;";
        
        $this->db->query($sql4);
        
        $sql5 = "CREATE TABLE IF NOT EXISTS `" . DB_PREFIX . "phpner_sreview_reviews_vote` (";
        $sql5 .= "  `phpner_sreview_review_id` int(11) NOT NULL,";
        $sql5 .= "  `phpner_sreview_subject_id` int(11) NOT NULL,";
        $sql5 .= "  `rating` int(11) NOT NULL";
        $sql5 .= ") ENGINE=InnoDB DEFAULT CHARSET=utf8;";
        
        $this->db->query($sql5);
    }
    
    public function deleteTables() {
        $this->db->query("DROP TABLE IF EXISTS `" . DB_PREFIX . "phpner_sreview_subject`;");
        $this->db->query("DROP TABLE IF EXISTS `" . DB_PREFIX . "phpner_sreview_subject_description`;");
        $this->db->query("DROP TABLE IF EXISTS `" . DB_PREFIX . "phpner_sreview_subject_to_store`;");
        $this->db->query("DROP TABLE IF EXISTS `" . DB_PREFIX . "phpner_sreview_reviews`;");
        $this->db->query("DROP TABLE IF EXISTS `" . DB_PREFIX . "phpner_sreview_reviews_vote`;");
    }
}