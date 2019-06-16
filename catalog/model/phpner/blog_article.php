<?php
/**************************************************************/
/*	@copyright	Phpner 2019							  */
/*	@support	http://phpner.ru					  */
/*	@license	LICENSE.txt									  */
/**************************************************************/

class ModelPhpnerBlogArticle extends Model {
    public function __construct($registry) {
        parent::__construct($registry);
        
        $sql = "CREATE TABLE IF NOT EXISTS `" . DB_PREFIX . "phpner_blog_category` (";
        $sql .= "  `phpner_blog_category_id` int(11) NOT NULL AUTO_INCREMENT,";
        $sql .= "  `image` varchar(255) DEFAULT NULL,";
        $sql .= "  `phpner_blog_category_parent_id` int(11) NOT NULL DEFAULT '0',";
        $sql .= "  `sort_order` int(3) NOT NULL DEFAULT '0',";
        $sql .= "  `status` tinyint(1) NOT NULL,";
        $sql .= "  `date_added` datetime NOT NULL,";
        $sql .= "  `date_modified` datetime NOT NULL,";
        $sql .= "  PRIMARY KEY (`phpner_blog_category_id`)";
        $sql .= ") ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=0 ;";
        
        $this->db->query($sql);
        
        $sql1 = "CREATE TABLE IF NOT EXISTS `" . DB_PREFIX . "phpner_blog_category_description` (";
        $sql1 .= "  `phpner_blog_category_id` int(11) NOT NULL,";
        $sql1 .= "  `language_id` int(11) NOT NULL,";
        $sql1 .= "  `name` varchar(255) NOT NULL,";
        $sql1 .= "  `description` text NOT NULL,";
        $sql1 .= "  `meta_title` varchar(255) NOT NULL,";
        $sql1 .= "  `meta_description` varchar(255) NOT NULL,";
        $sql1 .= "  `meta_keyword` varchar(255) NOT NULL,";
        $sql1 .= "  PRIMARY KEY (`phpner_blog_category_id`,`language_id`),";
        $sql1 .= "  KEY `name` (`name`)";
        $sql1 .= ") ENGINE=MyISAM DEFAULT CHARSET=utf8;";
        
        $this->db->query($sql1);
        
        $sql2 = "CREATE TABLE IF NOT EXISTS `" . DB_PREFIX . "phpner_blog_category_to_layout` (";
        $sql2 .= "  `phpner_blog_category_id` int(11) NOT NULL,";
        $sql2 .= "  `store_id` int(11) NOT NULL,";
        $sql2 .= "  `layout_id` int(11) NOT NULL,";
        $sql2 .= "  PRIMARY KEY (`phpner_blog_category_id`,`store_id`)";
        $sql2 .= ") ENGINE=MyISAM DEFAULT CHARSET=utf8;";
        
        $this->db->query($sql2);
        
        $sql3 = "CREATE TABLE IF NOT EXISTS `" . DB_PREFIX . "phpner_blog_category_to_store` (";
        $sql3 .= "  `phpner_blog_category_id` int(11) NOT NULL,";
        $sql3 .= "  `store_id` int(11) NOT NULL,";
        $sql3 .= "  PRIMARY KEY (`phpner_blog_category_id`,`store_id`)";
        $sql3 .= ") ENGINE=MyISAM DEFAULT CHARSET=utf8;";
        
        $this->db->query($sql3);
        
        $sql4 = "CREATE TABLE IF NOT EXISTS `" . DB_PREFIX . "phpner_blog_category_path` (";
        $sql4 .= "  `phpner_blog_category_id` int(11) NOT NULL,";
        $sql4 .= "  `phpner_blog_category_path_id` int(11) NOT NULL,";
        $sql4 .= "  `level` int(11) NOT NULL,";
        $sql4 .= "  PRIMARY KEY (`phpner_blog_category_id`,`phpner_blog_category_path_id`)";
        $sql4 .= ") ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;";
        
        $this->db->query($sql4);
        
        $sql5 = "CREATE TABLE IF NOT EXISTS `" . DB_PREFIX . "phpner_blog_article` (";
        $sql5 .= "  `phpner_blog_article_id` int(11) NOT NULL AUTO_INCREMENT,";
        $sql5 .= "  `image` varchar(255) DEFAULT NULL,";
        $sql5 .= "  `sort_order` int(11) NOT NULL DEFAULT '0',";
        $sql5 .= "  `status` tinyint(1) NOT NULL DEFAULT '0',";
        $sql5 .= "  `viewed` int(5) NOT NULL DEFAULT '0',";
        $sql5 .= "  `date_added` datetime NOT NULL,";
        $sql5 .= "  `date_modified` datetime NOT NULL,";
        $sql5 .= "  PRIMARY KEY (`phpner_blog_article_id`)";
        $sql5 .= ") ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=0 ;";
        
        $this->db->query($sql5);
        
        $sql6 = "CREATE TABLE IF NOT EXISTS `" . DB_PREFIX . "phpner_blog_article_description` (";
        $sql6 .= "  `phpner_blog_article_id` int(11) NOT NULL,";
        $sql6 .= "  `language_id` int(11) NOT NULL,";
        $sql6 .= "  `name` varchar(255) NOT NULL,";
        $sql6 .= "  `description` text NOT NULL,";
        $sql6 .= "  `tag` text NOT NULL,";
        $sql6 .= "  `meta_title` varchar(255) NOT NULL,";
        $sql6 .= "  `meta_description` varchar(255) NOT NULL,";
        $sql6 .= "  `meta_keyword` varchar(255) NOT NULL,";
        $sql6 .= "  PRIMARY KEY (`phpner_blog_article_id`,`language_id`),";
        $sql6 .= "  KEY `name` (`name`)";
        $sql6 .= ") ENGINE=MyISAM DEFAULT CHARSET=utf8;";
        
        $this->db->query($sql6);
        
        $sql7 = "CREATE TABLE IF NOT EXISTS `" . DB_PREFIX . "phpner_blog_article_image` (";
        $sql7 .= "  `phpner_blog_article_image_id` int(11) NOT NULL AUTO_INCREMENT,";
        $sql7 .= "  `phpner_blog_article_id` int(11) NOT NULL,";
        $sql7 .= "  `image` varchar(255) DEFAULT NULL,";
        $sql7 .= "  `sort_order` int(3) NOT NULL DEFAULT '0',";
        $sql7 .= "  PRIMARY KEY (`phpner_blog_article_image_id`),";
        $sql7 .= "  KEY `phpner_blog_article_id` (`phpner_blog_article_id`)";
        $sql7 .= ") ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=0 ;";
        
        $this->db->query($sql7);
        
        $sql8 = "CREATE TABLE IF NOT EXISTS `" . DB_PREFIX . "phpner_blog_article_products_related` (";
        $sql8 .= "  `phpner_blog_article_id` int(11) NOT NULL,";
        $sql8 .= "  `product_related_id` int(11) NOT NULL,";
        $sql8 .= "  PRIMARY KEY (`phpner_blog_article_id`,`product_related_id`)";
        $sql8 .= ") ENGINE=MyISAM DEFAULT CHARSET=utf8;";
        
        $this->db->query($sql8);
        
        $sql9 = "CREATE TABLE IF NOT EXISTS `" . DB_PREFIX . "phpner_blog_article_articles_related` (";
        $sql9 .= "  `phpner_blog_article_id` int(11) NOT NULL,";
        $sql9 .= "  `article_related_id` int(11) NOT NULL,";
        $sql9 .= "  PRIMARY KEY (`phpner_blog_article_id`,`article_related_id`)";
        $sql9 .= ") ENGINE=MyISAM DEFAULT CHARSET=utf8;";
        
        $this->db->query($sql9);
        
        $sql10 = "CREATE TABLE IF NOT EXISTS `" . DB_PREFIX . "phpner_blog_article_to_category` (";
        $sql10 .= "  `phpner_blog_article_id` int(11) NOT NULL,";
        $sql10 .= "  `phpner_blog_category_id` int(11) NOT NULL,";
        $sql10 .= "  `main_phpner_blog_category_id` tinyint(1) NOT NULL DEFAULT '0',";
        $sql10 .= "  PRIMARY KEY (`phpner_blog_article_id`,`phpner_blog_category_id`),";
        $sql10 .= "  KEY `phpner_blog_category_id` (`phpner_blog_category_id`)";
        $sql10 .= ") ENGINE=MyISAM DEFAULT CHARSET=utf8;";
        
        $this->db->query($sql10);
        
        $sql11 = "CREATE TABLE IF NOT EXISTS `" . DB_PREFIX . "phpner_blog_article_to_layout` (";
        $sql11 .= "  `phpner_blog_article_id` int(11) NOT NULL,";
        $sql11 .= "  `store_id` int(11) NOT NULL,";
        $sql11 .= "  `layout_id` int(11) NOT NULL,";
        $sql11 .= "  PRIMARY KEY (`phpner_blog_article_id`,`store_id`)";
        $sql11 .= ") ENGINE=MyISAM DEFAULT CHARSET=utf8;";
        
        $this->db->query($sql11);
        
        $sql12 = "CREATE TABLE IF NOT EXISTS `" . DB_PREFIX . "phpner_blog_article_to_store` (";
        $sql12 .= "  `phpner_blog_article_id` int(11) NOT NULL,";
        $sql12 .= "  `store_id` int(11) NOT NULL DEFAULT '0',";
        $sql12 .= "  PRIMARY KEY (`phpner_blog_article_id`,`store_id`)";
        $sql12 .= ") ENGINE=MyISAM DEFAULT CHARSET=utf8;";
        
        $this->db->query($sql12);
        
        $sql13 = "CREATE TABLE IF NOT EXISTS `" . DB_PREFIX . "phpner_blog_comments` (";
        $sql13 .= "  `phpner_blog_comment_id` int(11) NOT NULL AUTO_INCREMENT,";
        $sql13 .= "  `phpner_blog_article_id` int(11) NOT NULL,";
        $sql13 .= "  `customer_id` int(11) NOT NULL,";
        $sql13 .= "  `author` varchar(64) NOT NULL,";
        $sql13 .= "  `text` text NOT NULL,";
        $sql13 .= "  `rating` int(1) NOT NULL,";
        $sql13 .= "  `status` tinyint(1) NOT NULL DEFAULT '0',";
        $sql13 .= "  `plus` INT(11) NOT NULL DEFAULT  '0',";
        $sql13 .= "  `minus` INT( 11 ) NOT NULL DEFAULT '0',";
        $sql13 .= "  `date_added` datetime NOT NULL,";
        $sql13 .= "  `date_modified` datetime NOT NULL,";
        $sql13 .= "  PRIMARY KEY (`phpner_blog_comment_id`),";
        $sql13 .= "  KEY `phpner_blog_article_id` (`phpner_blog_article_id`)";
        $sql13 .= ") ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=0 ;";
        
        $this->db->query($sql13);
        
        $sql14 = "CREATE TABLE IF NOT EXISTS `" . DB_PREFIX . "phpner_blog_comments_like` (";
        $sql14 .= "  `phpner_blog_comment_id` int(11) NOT NULL,";
        $sql14 .= "  `phpner_blog_article_id` int(11) NOT NULL,";
        $sql14 .= "  `customer_id` int(11) NOT NULL,";
        $sql14 .= "  `customer_ip` varchar(40) NOT NULL";
        $sql14 .= ") ENGINE=InnoDB DEFAULT CHARSET=utf8;";
        
        $this->db->query($sql14);
    }
    
    public function updateViewed($phpner_blog_article_id) {
        $this->db->query("UPDATE " . DB_PREFIX . "phpner_blog_article SET viewed = (viewed + 1) WHERE phpner_blog_article_id = '" . (int) $phpner_blog_article_id . "'");
    }
    
    public function getArticle($phpner_blog_article_id) {
        $query = $this->db->query("SELECT DISTINCT *, (SELECT AVG(rating) AS total FROM " . DB_PREFIX . "phpner_blog_comments c1 WHERE c1.phpner_blog_article_id = a.phpner_blog_article_id AND c1.status = '1' GROUP BY c1.phpner_blog_article_id) AS rating, (SELECT COUNT(*) AS total FROM " . DB_PREFIX . "phpner_blog_comments c2 WHERE c2.phpner_blog_article_id = a.phpner_blog_article_id AND c2.status = '1' GROUP BY c2.phpner_blog_article_id) AS comments FROM " . DB_PREFIX . "phpner_blog_article a LEFT JOIN " . DB_PREFIX . "phpner_blog_article_description ad ON (a.phpner_blog_article_id = ad.phpner_blog_article_id) LEFT JOIN " . DB_PREFIX . "phpner_blog_article_to_store a2s ON (a.phpner_blog_article_id = a2s.phpner_blog_article_id) WHERE a.phpner_blog_article_id = '" . (int) $phpner_blog_article_id . "' AND ad.language_id = '" . (int) $this->config->get('config_language_id') . "' AND a2s.store_id = '" . (int) $this->config->get('config_store_id') . "' AND a.status = '1'");
        
        return $query->row;
    }
    
    public function getArticles($data = array()) {
        $sql = "SELECT a.phpner_blog_article_id, ad.name, a.date_added, a.image, a.viewed, ad.description, (SELECT AVG(rating) AS total FROM " . DB_PREFIX . "phpner_blog_comments c1 WHERE c1.phpner_blog_article_id = a.phpner_blog_article_id AND c1.status = '1' GROUP BY c1.phpner_blog_article_id) AS rating, (SELECT COUNT(*) AS total FROM " . DB_PREFIX . "phpner_blog_comments c2 WHERE c2.phpner_blog_article_id = a.phpner_blog_article_id AND c2.status = '1' GROUP BY c2.phpner_blog_article_id) AS comments";
        
        if (!empty($data['filter_category_id'])) {
            if (!empty($data['filter_sub_category'])) {
                $sql .= " FROM " . DB_PREFIX . "phpner_blog_category_path cp LEFT JOIN " . DB_PREFIX . "phpner_blog_article_to_category a2c ON (cp.phpner_blog_category_id = a2c.phpner_blog_category_id)";
            } else {
                $sql .= " FROM " . DB_PREFIX . "phpner_blog_article_to_category a2c";
            }
            
            $sql .= " LEFT JOIN " . DB_PREFIX . "phpner_blog_article a ON (a2c.phpner_blog_article_id = a.phpner_blog_article_id)";
        } else {
            $sql .= " FROM " . DB_PREFIX . "phpner_blog_article a";
        }
        
        $sql .= " LEFT JOIN " . DB_PREFIX . "phpner_blog_article_description ad ON (a.phpner_blog_article_id = ad.phpner_blog_article_id) LEFT JOIN " . DB_PREFIX . "phpner_blog_article_to_store a2s ON (a.phpner_blog_article_id = a2s.phpner_blog_article_id) WHERE ad.language_id = '" . (int) $this->config->get('config_language_id') . "' AND a.status = '1' AND a2s.store_id = '" . (int) $this->config->get('config_store_id') . "'";
        
        if (!empty($data['filter_category_id'])) {
            if (!empty($data['filter_sub_category'])) {
                $sql .= " AND cp.phpner_blog_category_path_id = '" . (int) $data['filter_category_id'] . "'";
            } else {
                $sql .= " AND a2c.phpner_blog_category_id = '" . (int) $data['filter_category_id'] . "'";
            }
        }
        
        if (!empty($data['filter_name']) || !empty($data['filter_tag'])) {
            $sql .= " AND (";
            
            if (!empty($data['filter_name'])) {
                $implode = array();
                
                $words = explode(' ', trim(preg_replace('/\s+/', ' ', $data['filter_name'])));
                
                foreach ($words as $word) {
                    $implode[] = "ad.name LIKE '%" . $this->db->escape($word) . "%'";
                }
                
                if ($implode) {
                    $sql .= " " . implode(" AND ", $implode) . "";
                }
                
                if (!empty($data['filter_description'])) {
                    $sql .= " OR ad.description LIKE '%" . $this->db->escape($data['filter_name']) . "%'";
                }
            }
            
            if (!empty($data['filter_name']) && !empty($data['filter_tag'])) {
                $sql .= " OR ";
            }
            
            if (!empty($data['filter_tag'])) {
                $sql .= "ad.tag LIKE '%" . $this->db->escape($data['filter_tag']) . "%'";
            }
            $sql .= ")";
        }
        
        $sql .= " GROUP BY a.phpner_blog_article_id";
        
        if (isset($data['sort'])) {
            if ($data['sort'] == 'ad.name_asc') {
                $sql .= " ORDER BY LCASE(ad.name) ASC";
            } elseif ($data['sort'] == 'ad.name_desc') {
                $sql .= " ORDER BY LCASE(ad.name) DESC";
            } elseif ($data['sort'] == 'a.sort_order_asc') {
                $sql .= " ORDER BY a.sort_order ASC";
            } elseif ($data['sort'] == 'a.date_added_asc') {
                $sql .= " ORDER BY a.date_added ASC";
            } elseif ($data['sort'] == 'a.date_added_desc') {
                $sql .= " ORDER BY a.date_added DESC";
            } else {
                $sql .= " ORDER BY a.sort_order DESC";
            }
        } else {
            $sql .= " ORDER BY a.date_added DESC ";
        }
        
        if (isset($data['start']) || isset($data['limit'])) {
            if ($data['start'] < 0) {
                $data['start'] = 0;
            }
            
            if ($data['limit'] < 1) {
                $data['limit'] = 20;
            }
            
            $sql .= " LIMIT " . (int) $data['start'] . "," . (int) $data['limit'];
        }
        
        $article_data = array();
        
        $query = $this->db->query($sql);
        
        foreach ($query->rows as $result) {
            $article_data[$result['phpner_blog_article_id']] = $this->getArticle($result['phpner_blog_article_id']);
        }
        
        return $article_data;
    }
    
    
    public function getTotalArticles($data = array()) {
        $sql = "SELECT COUNT(DISTINCT a.phpner_blog_article_id) AS total";
        
        if (!empty($data['filter_category_id'])) {
            if (!empty($data['filter_sub_category'])) {
                $sql .= " FROM " . DB_PREFIX . "phpner_blog_category_path cp LEFT JOIN " . DB_PREFIX . "phpner_blog_article_to_category a2c ON (cp.phpner_blog_category_id = a2c.phpner_blog_category_id)";
            } else {
                $sql .= " FROM " . DB_PREFIX . "phpner_blog_article_to_category a2c";
            }
            
            $sql .= " LEFT JOIN " . DB_PREFIX . "phpner_blog_article a ON (a2c.phpner_blog_article_id = a.phpner_blog_article_id)";
        } else {
            $sql .= " FROM " . DB_PREFIX . "phpner_blog_article a";
        }
        
        $sql .= " LEFT JOIN " . DB_PREFIX . "phpner_blog_article_description ad ON (a.phpner_blog_article_id = ad.phpner_blog_article_id) LEFT JOIN " . DB_PREFIX . "phpner_blog_article_to_store a2s ON (a.phpner_blog_article_id = a2s.phpner_blog_article_id) WHERE ad.language_id = '" . (int) $this->config->get('config_language_id') . "' AND a.status = '1' AND a2s.store_id = '" . (int) $this->config->get('config_store_id') . "'";
        
        if (!empty($data['filter_category_id'])) {
            if (!empty($data['filter_sub_category'])) {
                $sql .= " AND cp.phpner_blog_category_path_id = '" . (int) $data['filter_category_id'] . "'";
            } else {
                $sql .= " AND a2c.phpner_blog_category_id = '" . (int) $data['filter_category_id'] . "'";
            }
        }
        
        $query = $this->db->query($sql);
        
        return $query->row['total'];
    }
    
    public function getArticlesLayoutId($phpner_blog_article_id) {
        $query = $this->db->query("SELECT * FROM " . DB_PREFIX . "phpner_blog_article_to_layout WHERE phpner_blog_article_id = '" . (int) $phpner_blog_article_id . "' AND store_id = '" . (int) $this->config->get('config_store_id') . "'");
        
        if ($query->num_rows) {
            return $query->row['layout_id'];
        } else {
            return 0;
        }
    }
    
    public function getArticleImages($phpner_blog_article_id) {
        $query = $this->db->query("SELECT * FROM " . DB_PREFIX . "phpner_blog_article_image WHERE phpner_blog_article_id = '" . (int) $phpner_blog_article_id . "' ORDER BY sort_order ASC");
        
        return $query->rows;
    }
    
    public function getArticleProductsRelated($phpner_blog_article_id) {
        $article_data = array();
        
        $this->load->model('catalog/product');
        
        $query = $this->db->query("SELECT * FROM " . DB_PREFIX . "phpner_blog_article_products_related ar LEFT JOIN " . DB_PREFIX . "product p ON (ar.product_related_id = p.product_id) LEFT JOIN " . DB_PREFIX . "product_to_store p2s ON (p.product_id = p2s.product_id) WHERE ar.phpner_blog_article_id = '" . (int) $phpner_blog_article_id . "' AND p.status = '1' AND p.date_available <= NOW() AND p2s.store_id = '" . (int) $this->config->get('config_store_id') . "'");
        
        if ($query->rows) {
            foreach ($query->rows as $result) {
                $article_data[$result['product_related_id']] = $this->model_catalog_product->getProduct($result['product_related_id']);
            }
        }
        
        return $article_data;
    }
    
    public function getArticleArticlesRelated($phpner_blog_article_id) {
        $article_data = array();
        
        $query = $this->db->query("SELECT ar.* FROM " . DB_PREFIX . "phpner_blog_article_articles_related ar LEFT JOIN " . DB_PREFIX . "phpner_blog_article a ON (a.phpner_blog_article_id = ar.phpner_blog_article_id) LEFT JOIN " . DB_PREFIX . "phpner_blog_article_description ad ON (a.phpner_blog_article_id = ad.phpner_blog_article_id) LEFT JOIN " . DB_PREFIX . "phpner_blog_article_to_store a2s ON (a.phpner_blog_article_id = a2s.phpner_blog_article_id) WHERE ar.phpner_blog_article_id = '" . (int) $phpner_blog_article_id . "' AND ad.language_id = '" . (int) $this->config->get('config_language_id') . "' AND a2s.store_id = '" . (int) $this->config->get('config_store_id') . "' AND a.status = '1'");
        
        if ($query->rows) {
            foreach ($query->rows as $row) {
                $article_data[] = $row['article_related_id'];
            }
        }
        
        return $article_data;
    }
}