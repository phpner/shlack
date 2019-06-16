<?php
/**************************************************************/
/*	@copyright	Phpner 2019							  */
/*	@support	http://phpner.ru					  */
/*	@license	LICENSE.txt									  */
/**************************************************************/

class ModelPhpnerBlogArticle extends Model {
    public function addArticle($data) {
        $this->db->query("INSERT INTO " . DB_PREFIX . "phpner_blog_article SET status = '" . (int) $data['status'] . "', sort_order = '" . (int) $data['sort_order'] . "', date_added = NOW()");
        
        $phpner_blog_article_id = $this->db->getLastId();
        
        if (isset($data['image'])) {
            $this->db->query("UPDATE " . DB_PREFIX . "phpner_blog_article SET image = '" . $this->db->escape($data['image']) . "' WHERE phpner_blog_article_id = '" . (int) $phpner_blog_article_id . "'");
        }
        
        foreach ($data['article_description'] as $language_id => $value) {
            $this->db->query("INSERT INTO " . DB_PREFIX . "phpner_blog_article_description SET phpner_blog_article_id = '" . (int) $phpner_blog_article_id . "', language_id = '" . (int) $language_id . "', name = '" . $this->db->escape($value['name']) . "', description = '" . $this->db->escape($value['description']) . "', tag = '" . $this->db->escape($value['tag']) . "', meta_title = '" . $this->db->escape($value['meta_title']) . "', meta_description = '" . $this->db->escape($value['meta_description']) . "', meta_keyword = '" . $this->db->escape($value['meta_keyword']) . "'");
        }
        
        if (isset($data['article_store'])) {
            foreach ($data['article_store'] as $store_id) {
                $this->db->query("INSERT INTO " . DB_PREFIX . "phpner_blog_article_to_store SET phpner_blog_article_id = '" . (int) $phpner_blog_article_id . "', store_id = '" . (int) $store_id . "'");
            }
        }
        
        if (isset($data['article_image'])) {
            foreach ($data['article_image'] as $article_image) {
                $this->db->query("INSERT INTO " . DB_PREFIX . "phpner_blog_article_image SET phpner_blog_article_id = '" . (int) $phpner_blog_article_id . "', image = '" . $this->db->escape($article_image['image']) . "', sort_order = '" . (int) $article_image['sort_order'] . "'");
            }
        }
        
        if (isset($data['article_category'])) {
            foreach ($data['article_category'] as $phpner_blog_category_id) {
                $this->db->query("INSERT INTO " . DB_PREFIX . "phpner_blog_article_to_category SET phpner_blog_article_id = '" . (int) $phpner_blog_article_id . "', phpner_blog_category_id = '" . (int) $phpner_blog_category_id . "'");
            }
        }
        
        if (isset($data['main_phpner_blog_category_id']) && $data['main_phpner_blog_category_id'] > 0) {
            $this->db->query("DELETE FROM " . DB_PREFIX . "phpner_blog_article_to_category WHERE phpner_blog_article_id = '" . (int) $phpner_blog_article_id . "' AND phpner_blog_category_id = '" . (int) $data['main_phpner_blog_category_id'] . "'");
            $this->db->query("INSERT INTO " . DB_PREFIX . "phpner_blog_article_to_category SET phpner_blog_article_id = '" . (int) $phpner_blog_article_id . "', phpner_blog_category_id = '" . (int) $data['main_phpner_blog_category_id'] . "', main_phpner_blog_category_id = 1");
        } elseif (isset($data['article_category'][0])) {
            $this->db->query("UPDATE " . DB_PREFIX . "phpner_blog_article_to_category SET main_phpner_blog_category_id = 1 WHERE phpner_blog_article_id = '" . (int) $phpner_blog_article_id . "' AND phpner_blog_category_id = '" . (int) $data['article_category'][0] . "'");
        }
        
        if (isset($data['article_related'])) {
            foreach ($data['article_related'] as $article_related_id) {
                $this->db->query("DELETE FROM " . DB_PREFIX . "phpner_blog_article_articles_related WHERE phpner_blog_article_id = '" . (int) $phpner_blog_article_id . "' AND article_related_id = '" . (int) $article_related_id . "'");
                $this->db->query("INSERT INTO " . DB_PREFIX . "phpner_blog_article_articles_related SET phpner_blog_article_id = '" . (int) $phpner_blog_article_id . "', article_related_id = '" . (int) $article_related_id . "'");
                $this->db->query("DELETE FROM " . DB_PREFIX . "phpner_blog_article_articles_related WHERE phpner_blog_article_id = '" . (int) $article_related_id . "' AND article_related_id = '" . (int) $phpner_blog_article_id . "'");
                $this->db->query("INSERT INTO " . DB_PREFIX . "phpner_blog_article_articles_related SET phpner_blog_article_id = '" . (int) $article_related_id . "', article_related_id = '" . (int) $phpner_blog_article_id . "'");
            }
        }
        
        if (isset($data['product_related'])) {
            foreach ($data['product_related'] as $product_related_id) {
                $this->db->query("DELETE FROM " . DB_PREFIX . "phpner_blog_article_products_related WHERE phpner_blog_article_id = '" . (int) $phpner_blog_article_id . "' AND product_related_id = '" . (int) $product_related_id . "'");
                $this->db->query("INSERT INTO " . DB_PREFIX . "phpner_blog_article_products_related SET phpner_blog_article_id = '" . (int) $phpner_blog_article_id . "', product_related_id = '" . (int) $product_related_id . "'");
                // $this->db->query("DELETE FROM " . DB_PREFIX . "phpner_blog_article_products_related WHERE phpner_blog_article_id = '" . (int)$product_related_id . "' AND product_related_id = '" . (int)$phpner_blog_article_id . "'");
                // $this->db->query("INSERT INTO " . DB_PREFIX . "phpner_blog_article_products_related SET phpner_blog_article_id = '" . (int)$product_related_id . "', product_related_id = '" . (int)$phpner_blog_article_id . "'");
            }
        }
        
        if (isset($data['article_layout'])) {
            foreach ($data['article_layout'] as $store_id => $layout_id) {
                $this->db->query("INSERT INTO " . DB_PREFIX . "phpner_blog_article_to_layout SET phpner_blog_article_id = '" . (int) $phpner_blog_article_id . "', store_id = '" . (int) $store_id . "', layout_id = '" . (int) $layout_id . "'");
            }
        }
        
        if (isset($data['keyword'])) {
            $this->db->query("INSERT INTO " . DB_PREFIX . "url_alias SET query = 'phpner_blog_article_id=" . (int) $phpner_blog_article_id . "', keyword = '" . $this->db->escape($data['keyword']) . "'");
        }
        
        $this->cache->delete('phpner_blog_article');
        
        return $phpner_blog_article_id;
    }
    
    public function editArticle($phpner_blog_article_id, $data) {
        $this->db->query("UPDATE " . DB_PREFIX . "phpner_blog_article SET status = '" . (int) $data['status'] . "', sort_order = '" . (int) $data['sort_order'] . "', date_modified = NOW() WHERE phpner_blog_article_id = '" . (int) $phpner_blog_article_id . "'");
        
        if (isset($data['image'])) {
            $this->db->query("UPDATE " . DB_PREFIX . "phpner_blog_article SET image = '" . $this->db->escape($data['image']) . "' WHERE phpner_blog_article_id = '" . (int) $phpner_blog_article_id . "'");
        }
        
        $this->db->query("DELETE FROM " . DB_PREFIX . "phpner_blog_article_description WHERE phpner_blog_article_id = '" . (int) $phpner_blog_article_id . "'");
        
        foreach ($data['article_description'] as $language_id => $value) {
            $this->db->query("INSERT INTO " . DB_PREFIX . "phpner_blog_article_description SET phpner_blog_article_id = '" . (int) $phpner_blog_article_id . "', language_id = '" . (int) $language_id . "', name = '" . $this->db->escape($value['name']) . "', description = '" . $this->db->escape($value['description']) . "', tag = '" . $this->db->escape($value['tag']) . "', meta_title = '" . $this->db->escape($value['meta_title']) . "', meta_description = '" . $this->db->escape($value['meta_description']) . "', meta_keyword = '" . $this->db->escape($value['meta_keyword']) . "'");
        }
        
        $this->db->query("DELETE FROM " . DB_PREFIX . "phpner_blog_article_to_store WHERE phpner_blog_article_id = '" . (int) $phpner_blog_article_id . "'");
        
        if (isset($data['article_store'])) {
            foreach ($data['article_store'] as $store_id) {
                $this->db->query("INSERT INTO " . DB_PREFIX . "phpner_blog_article_to_store SET phpner_blog_article_id = '" . (int) $phpner_blog_article_id . "', store_id = '" . (int) $store_id . "'");
            }
        }
        
        $this->db->query("DELETE FROM " . DB_PREFIX . "phpner_blog_article_image WHERE phpner_blog_article_id = '" . (int) $phpner_blog_article_id . "'");
        
        if (isset($data['article_image'])) {
            foreach ($data['article_image'] as $article_image) {
                $this->db->query("INSERT INTO " . DB_PREFIX . "phpner_blog_article_image SET phpner_blog_article_id = '" . (int) $phpner_blog_article_id . "', image = '" . $this->db->escape($article_image['image']) . "', sort_order = '" . (int) $article_image['sort_order'] . "'");
            }
        }
        
        $this->db->query("DELETE FROM " . DB_PREFIX . "phpner_blog_article_to_category WHERE phpner_blog_article_id = '" . (int) $phpner_blog_article_id . "'");
        
        if (isset($data['article_category'])) {
            foreach ($data['article_category'] as $phpner_blog_category_id) {
                $this->db->query("INSERT INTO " . DB_PREFIX . "phpner_blog_article_to_category SET phpner_blog_article_id = '" . (int) $phpner_blog_article_id . "', phpner_blog_category_id = '" . (int) $phpner_blog_category_id . "'");
            }
        }
        
        if (isset($data['main_phpner_blog_category_id']) && $data['main_phpner_blog_category_id'] > 0) {
            $this->db->query("DELETE FROM " . DB_PREFIX . "phpner_blog_article_to_category WHERE phpner_blog_article_id = '" . (int) $phpner_blog_article_id . "' AND phpner_blog_category_id = '" . (int) $data['main_phpner_blog_category_id'] . "'");
            $this->db->query("INSERT INTO " . DB_PREFIX . "phpner_blog_article_to_category SET phpner_blog_article_id = '" . (int) $phpner_blog_article_id . "', phpner_blog_category_id = '" . (int) $data['main_phpner_blog_category_id'] . "', main_phpner_blog_category_id = 1");
        } elseif (isset($data['article_category'])) {
            $this->db->query("UPDATE " . DB_PREFIX . "phpner_blog_article_to_category SET main_phpner_blog_category_id = 1 WHERE phpner_blog_article_id = '" . (int) $phpner_blog_article_id . "' AND phpner_blog_category_id = '" . (int) $data['article_category'][0] . "'");
        }
        
        $this->db->query("DELETE FROM " . DB_PREFIX . "phpner_blog_article_articles_related WHERE phpner_blog_article_id = '" . (int) $phpner_blog_article_id . "'");
        $this->db->query("DELETE FROM " . DB_PREFIX . "phpner_blog_article_articles_related WHERE article_related_id = '" . (int) $phpner_blog_article_id . "'");
        
        if (isset($data['article_related'])) {
            foreach ($data['article_related'] as $article_related_id) {
                $this->db->query("DELETE FROM " . DB_PREFIX . "phpner_blog_article_articles_related WHERE phpner_blog_article_id = '" . (int) $phpner_blog_article_id . "' AND article_related_id = '" . (int) $article_related_id . "'");
                $this->db->query("INSERT INTO " . DB_PREFIX . "phpner_blog_article_articles_related SET phpner_blog_article_id = '" . (int) $phpner_blog_article_id . "', article_related_id = '" . (int) $article_related_id . "'");
                $this->db->query("DELETE FROM " . DB_PREFIX . "phpner_blog_article_articles_related WHERE phpner_blog_article_id = '" . (int) $article_related_id . "' AND article_related_id = '" . (int) $phpner_blog_article_id . "'");
                $this->db->query("INSERT INTO " . DB_PREFIX . "phpner_blog_article_articles_related SET phpner_blog_article_id = '" . (int) $article_related_id . "', article_related_id = '" . (int) $phpner_blog_article_id . "'");
            }
        }
        
        $this->db->query("DELETE FROM " . DB_PREFIX . "phpner_blog_article_products_related WHERE phpner_blog_article_id = '" . (int) $phpner_blog_article_id . "'");
        $this->db->query("DELETE FROM " . DB_PREFIX . "phpner_blog_article_products_related WHERE product_related_id = '" . (int) $phpner_blog_article_id . "'");
        
        if (isset($data['product_related'])) {
            foreach ($data['product_related'] as $product_related_id) {
                $this->db->query("DELETE FROM " . DB_PREFIX . "phpner_blog_article_products_related WHERE phpner_blog_article_id = '" . (int) $phpner_blog_article_id . "' AND product_related_id = '" . (int) $product_related_id . "'");
                $this->db->query("INSERT INTO " . DB_PREFIX . "phpner_blog_article_products_related SET phpner_blog_article_id = '" . (int) $phpner_blog_article_id . "', product_related_id = '" . (int) $product_related_id . "'");
                // $this->db->query("DELETE FROM " . DB_PREFIX . "phpner_blog_article_products_related WHERE phpner_blog_article_id = '" . (int)$product_related_id . "' AND product_related_id = '" . (int)$phpner_blog_article_id . "'");
                // $this->db->query("INSERT INTO " . DB_PREFIX . "phpner_blog_article_products_related SET phpner_blog_article_id = '" . (int)$product_related_id . "', product_related_id = '" . (int)$phpner_blog_article_id . "'");
            }
        }
        
        $this->db->query("DELETE FROM " . DB_PREFIX . "phpner_blog_article_to_layout WHERE phpner_blog_article_id = '" . (int) $phpner_blog_article_id . "'");
        
        if (isset($data['article_layout'])) {
            foreach ($data['article_layout'] as $store_id => $layout_id) {
                $this->db->query("INSERT INTO " . DB_PREFIX . "phpner_blog_article_to_layout SET phpner_blog_article_id = '" . (int) $phpner_blog_article_id . "', store_id = '" . (int) $store_id . "', layout_id = '" . (int) $layout_id . "'");
            }
        }
        
        $this->db->query("DELETE FROM " . DB_PREFIX . "url_alias WHERE query = 'phpner_blog_article_id=" . (int) $phpner_blog_article_id . "'");
        
        if ($data['keyword']) {
            $this->db->query("INSERT INTO " . DB_PREFIX . "url_alias SET query = 'phpner_blog_article_id=" . (int) $phpner_blog_article_id . "', keyword = '" . $this->db->escape($data['keyword']) . "'");
        }
        
        $this->cache->delete('phpner_blog_article');
    }
    
    public function copyArticle($phpner_blog_article_id) {
        $query = $this->db->query("SELECT DISTINCT * FROM " . DB_PREFIX . "phpner_blog_article a LEFT JOIN " . DB_PREFIX . "phpner_blog_article_description ad ON (a.phpner_blog_article_id = ad.phpner_blog_article_id) WHERE a.phpner_blog_article_id = '" . (int) $phpner_blog_article_id . "' AND ad.language_id = '" . (int) $this->config->get('config_language_id') . "'");
        
        if ($query->num_rows) {
            $data = $query->row;
            
            $data['viewed']  = '0';
            $data['keyword'] = '';
            $data['status']  = '0';
            
            $data['article_description'] = $this->getArticleDescriptions($phpner_blog_article_id);
            $data['article_image']       = $this->getArticleImages($phpner_blog_article_id);
            $data['article_related']     = $this->getArticleArticlesRelated($phpner_blog_article_id);
            $data['product_related']     = $this->getArticleProductsRelated($phpner_blog_article_id);
            $data['article_category']    = $this->getArticleCategories($phpner_blog_article_id);
            $data['article_layout']      = $this->getArticleLayouts($phpner_blog_article_id);
            $data['article_store']       = $this->getArticleStores($phpner_blog_article_id);
            
            $this->addArticle($data);
        }
    }
    
    public function deleteArticle($phpner_blog_article_id) {
        $this->db->query("DELETE FROM " . DB_PREFIX . "phpner_blog_article WHERE phpner_blog_article_id = '" . (int) $phpner_blog_article_id . "'");
        $this->db->query("DELETE FROM " . DB_PREFIX . "phpner_blog_article_description WHERE phpner_blog_article_id = '" . (int) $phpner_blog_article_id . "'");
        $this->db->query("DELETE FROM " . DB_PREFIX . "phpner_blog_article_image WHERE phpner_blog_article_id = '" . (int) $phpner_blog_article_id . "'");
        $this->db->query("DELETE FROM " . DB_PREFIX . "phpner_blog_article_articles_related WHERE phpner_blog_article_id = '" . (int) $phpner_blog_article_id . "'");
        $this->db->query("DELETE FROM " . DB_PREFIX . "phpner_blog_article_articles_related WHERE article_related_id = '" . (int) $phpner_blog_article_id . "'");
        $this->db->query("DELETE FROM " . DB_PREFIX . "phpner_blog_article_products_related WHERE phpner_blog_article_id = '" . (int) $phpner_blog_article_id . "'");
        $this->db->query("DELETE FROM " . DB_PREFIX . "phpner_blog_article_products_related WHERE product_related_id = '" . (int) $phpner_blog_article_id . "'");
        $this->db->query("DELETE FROM " . DB_PREFIX . "phpner_blog_article_to_category WHERE phpner_blog_article_id = '" . (int) $phpner_blog_article_id . "'");
        $this->db->query("DELETE FROM " . DB_PREFIX . "phpner_blog_article_to_layout WHERE phpner_blog_article_id = '" . (int) $phpner_blog_article_id . "'");
        $this->db->query("DELETE FROM " . DB_PREFIX . "phpner_blog_article_to_store WHERE phpner_blog_article_id = '" . (int) $phpner_blog_article_id . "'");
        $this->db->query("DELETE FROM " . DB_PREFIX . "phpner_blog_comments WHERE phpner_blog_article_id = '" . (int) $phpner_blog_article_id . "'");
        $this->db->query("DELETE FROM " . DB_PREFIX . "phpner_blog_comments_like WHERE phpner_blog_article_id = '" . (int) $phpner_blog_article_id . "'");
        $this->db->query("DELETE FROM " . DB_PREFIX . "url_alias WHERE query = 'phpner_blog_article_id=" . (int) $phpner_blog_article_id . "'");
        
        $this->cache->delete('phpner_blog_article');
    }
    
    public function getArticle($phpner_blog_article_id) {
        $query = $this->db->query("SELECT DISTINCT *, (SELECT keyword FROM " . DB_PREFIX . "url_alias WHERE query = 'phpner_blog_article_id=" . (int) $phpner_blog_article_id . "') AS keyword FROM " . DB_PREFIX . "phpner_blog_article a LEFT JOIN " . DB_PREFIX . "phpner_blog_article_description ad ON (a.phpner_blog_article_id = ad.phpner_blog_article_id) WHERE a.phpner_blog_article_id = '" . (int) $phpner_blog_article_id . "' AND ad.language_id = '" . (int) $this->config->get('config_language_id') . "'");
        
        return $query->row;
    }
    
    public function getArticles($data = array()) {
        $sql = "SELECT * FROM " . DB_PREFIX . "phpner_blog_article a LEFT JOIN " . DB_PREFIX . "phpner_blog_article_description ad ON (a.phpner_blog_article_id = ad.phpner_blog_article_id) WHERE ad.language_id = '" . (int) $this->config->get('config_language_id') . "'";
        
        if (!empty($data['filter_name'])) {
            $sql .= " AND ad.name LIKE '" . $this->db->escape($data['filter_name']) . "%'";
        }
        
        if (isset($data['filter_status']) && !is_null($data['filter_status'])) {
            $sql .= " AND a.status = '" . (int) $data['filter_status'] . "'";
        }
        
        $sql .= " GROUP BY a.phpner_blog_article_id";
        
        $sort_data = array(
            'ad.name',
            'a.status',
            'a.sort_order'
        );
        
        if (isset($data['sort']) && in_array($data['sort'], $sort_data)) {
            $sql .= " ORDER BY " . $data['sort'];
        } else {
            $sql .= " ORDER BY ad.name";
        }
        
        if (isset($data['order']) && ($data['order'] == 'DESC')) {
            $sql .= " DESC";
        } else {
            $sql .= " ASC";
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
        
        $query = $this->db->query($sql);
        
        return $query->rows;
    }
    
    public function getArticlesByCategoryId($phpner_blog_category_id) {
        $query = $this->db->query("SELECT * FROM " . DB_PREFIX . "phpner_blog_article a LEFT JOIN " . DB_PREFIX . "phpner_blog_article_description ad ON (a.phpner_blog_article_id = ad.phpner_blog_article_id) LEFT JOIN " . DB_PREFIX . "phpner_blog_article_to_category a2c ON (a.phpner_blog_article_id = a2c.phpner_blog_article_id) WHERE ad.language_id = '" . (int) $this->config->get('config_language_id') . "' AND a2c.phpner_blog_category_id = '" . (int) $phpner_blog_category_id . "' ORDER BY ad.name ASC");
        
        return $query->rows;
    }
    
    public function getArticleDescriptions($phpner_blog_article_id) {
        $article_description_data = array();
        
        $query = $this->db->query("SELECT * FROM " . DB_PREFIX . "phpner_blog_article_description WHERE phpner_blog_article_id = '" . (int) $phpner_blog_article_id . "'");
        
        foreach ($query->rows as $result) {
            $article_description_data[$result['language_id']] = array(
                'name' => $result['name'],
                'description' => $result['description'],
                'meta_title' => $result['meta_title'],
                'meta_description' => $result['meta_description'],
                'meta_keyword' => $result['meta_keyword'],
                'tag' => $result['tag']
            );
        }
        
        return $article_description_data;
    }
    
    public function getArticleCategories($phpner_blog_article_id) {
        $article_category_data = array();
        
        $query = $this->db->query("SELECT * FROM " . DB_PREFIX . "phpner_blog_article_to_category WHERE phpner_blog_article_id = '" . (int) $phpner_blog_article_id . "'");
        
        foreach ($query->rows as $result) {
            $article_category_data[] = $result['phpner_blog_category_id'];
        }
        
        return $article_category_data;
    }
    
    public function getArticleImages($phpner_blog_article_id) {
        $query = $this->db->query("SELECT * FROM " . DB_PREFIX . "phpner_blog_article_image WHERE phpner_blog_article_id = '" . (int) $phpner_blog_article_id . "' ORDER BY sort_order ASC");
        
        return $query->rows;
    }
    
    public function getArticleStores($phpner_blog_article_id) {
        $article_store_data = array();
        
        $query = $this->db->query("SELECT * FROM " . DB_PREFIX . "phpner_blog_article_to_store WHERE phpner_blog_article_id = '" . (int) $phpner_blog_article_id . "'");
        
        foreach ($query->rows as $result) {
            $article_store_data[] = $result['store_id'];
        }
        
        return $article_store_data;
    }
    
    public function getArticleLayouts($phpner_blog_article_id) {
        $article_layout_data = array();
        
        $query = $this->db->query("SELECT * FROM " . DB_PREFIX . "phpner_blog_article_to_layout WHERE phpner_blog_article_id = '" . (int) $phpner_blog_article_id . "'");
        
        foreach ($query->rows as $result) {
            $article_layout_data[$result['store_id']] = $result['layout_id'];
        }
        
        return $article_layout_data;
    }
    
    public function getArticleMainCategoryId($phpner_blog_article_id) {
        $query = $this->db->query("SELECT phpner_blog_category_id FROM " . DB_PREFIX . "phpner_blog_article_to_category WHERE phpner_blog_article_id = '" . (int) $phpner_blog_article_id . "' AND main_phpner_blog_category_id = '1' LIMIT 1");
        
        return ($query->num_rows ? (int) $query->row['phpner_blog_category_id'] : 0);
    }
    
    public function getArticleArticlesRelated($phpner_blog_article_id) {
        $article_related_data = array();
        
        $query = $this->db->query("SELECT * FROM " . DB_PREFIX . "phpner_blog_article_articles_related WHERE phpner_blog_article_id = '" . (int) $phpner_blog_article_id . "'");
        
        foreach ($query->rows as $result) {
            $article_related_data[] = $result['article_related_id'];
        }
        
        return $article_related_data;
    }
    
    public function getArticleProductsRelated($phpner_blog_article_id) {
        $product_related_data = array();
        
        $query = $this->db->query("SELECT * FROM " . DB_PREFIX . "phpner_blog_article_products_related WHERE phpner_blog_article_id = '" . (int) $phpner_blog_article_id . "'");
        
        foreach ($query->rows as $result) {
            $product_related_data[] = $result['product_related_id'];
        }
        
        return $product_related_data;
    }
    
    public function getTotalArticles($data = array()) {
        $sql = "SELECT COUNT(DISTINCT a.phpner_blog_article_id) AS total FROM " . DB_PREFIX . "phpner_blog_article a LEFT JOIN " . DB_PREFIX . "phpner_blog_article_description ad ON (a.phpner_blog_article_id = ad.phpner_blog_article_id)";
        
        $sql .= " WHERE ad.language_id = '" . (int) $this->config->get('config_language_id') . "'";
        
        if (!empty($data['filter_name'])) {
            $sql .= " AND ad.name LIKE '" . $this->db->escape($data['filter_name']) . "%'";
        }
        
        if (isset($data['filter_status']) && !is_null($data['filter_status'])) {
            $sql .= " AND a.status = '" . (int) $data['filter_status'] . "'";
        }
        
        $query = $this->db->query($sql);
        
        return $query->row['total'];
    }
    
    public function getTotalArticlesByLayoutId($layout_id) {
        $query = $this->db->query("SELECT COUNT(*) AS total FROM " . DB_PREFIX . "phpner_blog_article_to_layout WHERE layout_id = '" . (int) $layout_id . "'");
        
        return $query->row['total'];
    }
}