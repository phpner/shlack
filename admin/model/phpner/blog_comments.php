<?php
/**************************************************************/
/*	@copyright	Phpner 2019							  */
/*	@support	http://phpner.ru					  */
/*	@license	LICENSE.txt									  */
/**************************************************************/

class ModelPhpnerBlogComments extends Model {
    public function addComment($data) {
        $this->db->query("INSERT INTO " . DB_PREFIX . "phpner_blog_comments SET author = '" . $this->db->escape($data['author']) . "', phpner_blog_article_id = '" . (int) $data['phpner_blog_article_id'] . "', text = '" . $this->db->escape(strip_tags($data['text'])) . "', rating = '" . (int) $data['rating'] . "', status = '" . (int) $data['status'] . "', plus = '" . (int) $data['plus'] . "', minus = '" . (int) $data['minus'] . "', date_added = NOW()");
        
        $phpner_blog_comment_id = $this->db->getLastId();
        
        $this->cache->delete('phpner_blog_article');
        
        return $phpner_blog_comment_id;
    }
    
    public function editComment($phpner_blog_comment_id, $data) {
        $this->db->query("UPDATE " . DB_PREFIX . "phpner_blog_comments SET author = '" . $this->db->escape($data['author']) . "', phpner_blog_article_id = '" . (int) $data['phpner_blog_article_id'] . "', text = '" . $this->db->escape(strip_tags($data['text'])) . "', rating = '" . (int) $data['rating'] . "', status = '" . (int) $data['status'] . "', plus = '" . (int) $data['plus'] . "', minus = '" . (int) $data['minus'] . "', date_modified = NOW() WHERE phpner_blog_comment_id = '" . (int) $phpner_blog_comment_id . "'");
        
        $this->cache->delete('phpner_blog_article');
    }
    
    public function deleteComment($phpner_blog_comment_id) {
        $this->db->query("DELETE FROM " . DB_PREFIX . "phpner_blog_comments WHERE phpner_blog_comment_id = '" . (int) $phpner_blog_comment_id . "'");
        $this->db->query("DELETE FROM " . DB_PREFIX . "phpner_blog_comments_like WHERE phpner_blog_comment_id = '" . (int) $phpner_blog_comment_id . "'");
        
        $this->cache->delete('phpner_blog_article');
    }
    
    public function getComment($phpner_blog_comment_id) {
        $query = $this->db->query("SELECT DISTINCT *, (SELECT ad.name FROM " . DB_PREFIX . "phpner_blog_article_description ad WHERE ad.phpner_blog_article_id = com.phpner_blog_article_id AND ad.language_id = '" . (int) $this->config->get('config_language_id') . "') AS article FROM " . DB_PREFIX . "phpner_blog_comments com WHERE com.phpner_blog_comment_id = '" . (int) $phpner_blog_comment_id . "'");
        
        return $query->row;
    }
    
    public function getComments($data = array()) {
        $sql = "SELECT com.phpner_blog_comment_id, ad.name, com.author, com.rating, com.status, com.date_added FROM " . DB_PREFIX . "phpner_blog_comments com LEFT JOIN " . DB_PREFIX . "phpner_blog_article_description ad ON (com.phpner_blog_article_id = ad.phpner_blog_article_id) WHERE ad.language_id = '" . (int) $this->config->get('config_language_id') . "'";
        
        if (!empty($data['filter_article'])) {
            $sql .= " AND ad.name LIKE '" . $this->db->escape($data['filter_article']) . "%'";
        }
        
        if (!empty($data['filter_author'])) {
            $sql .= " AND com.author LIKE '" . $this->db->escape($data['filter_author']) . "%'";
        }
        
        if (isset($data['filter_status']) && !is_null($data['filter_status'])) {
            $sql .= " AND com.status = '" . (int) $data['filter_status'] . "'";
        }
        
        if (!empty($data['filter_date_added'])) {
            $sql .= " AND DATE(com.date_added) = DATE('" . $this->db->escape($data['filter_date_added']) . "')";
        }
        
        $sort_data = array(
            'ad.name',
            'com.author',
            'com.rating',
            'com.status',
            'com.date_added'
        );
        
        if (isset($data['sort']) && in_array($data['sort'], $sort_data)) {
            $sql .= " ORDER BY " . $data['sort'];
        } else {
            $sql .= " ORDER BY com.date_added";
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
    
    public function getTotalComments($data = array()) {
        $sql = "SELECT COUNT(*) AS total FROM " . DB_PREFIX . "phpner_blog_comments com LEFT JOIN " . DB_PREFIX . "phpner_blog_article_description ad ON (com.phpner_blog_article_id = ad.phpner_blog_article_id) WHERE ad.language_id = '" . (int) $this->config->get('config_language_id') . "'";
        
        if (!empty($data['filter_article'])) {
            $sql .= " AND ad.name LIKE '" . $this->db->escape($data['filter_article']) . "%'";
        }
        
        if (!empty($data['filter_author'])) {
            $sql .= " AND com.author LIKE '" . $this->db->escape($data['filter_author']) . "%'";
        }
        
        if (isset($data['filter_status']) && !is_null($data['filter_status'])) {
            $sql .= " AND com.status = '" . (int) $data['filter_status'] . "'";
        }
        
        if (!empty($data['filter_date_added'])) {
            $sql .= " AND DATE(com.date_added) = DATE('" . $this->db->escape($data['filter_date_added']) . "')";
        }
        
        $query = $this->db->query($sql);
        
        return $query->row['total'];
    }
    
    public function getTotalCommentsAwaitingApproval() {
        $query = $this->db->query("SELECT COUNT(*) AS total FROM " . DB_PREFIX . "phpner_blog_comments WHERE status = '0'");
        
        return $query->row['total'];
    }
}