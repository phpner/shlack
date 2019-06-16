<?php
/**************************************************************/
/*	@copyright	Phpner 2019							  */
/*	@support	http://phpner.ru					  */
/*	@license	LICENSE.txt									  */
/**************************************************************/

class ModelPhpnerBlogComments extends Model {
    public function addComment($phpner_blog_article_id, $data) {
        $phpner_blog_setting_data = $this->config->get('phpner_blog_setting_data');
        
        if ($phpner_blog_setting_data['comment_moderation'] == 1) {
            $status = 0;
        } else {
            $status = 1;
        }
        
        $this->db->query("INSERT INTO " . DB_PREFIX . "phpner_blog_comments SET author = '" . $this->db->escape($data['name']) . "', customer_id = '" . (int) $this->customer->getId() . "', phpner_blog_article_id = '" . (int) $phpner_blog_article_id . "', text = '" . $this->db->escape($data['text']) . "', rating = '" . (int) $data['rating'] . "', status = '" . (int) $status . "', date_added = NOW()");
    }
    
    public function getCommentsByArticleId($phpner_blog_article_id, $start = 0, $limit = 20) {
        if ($start < 0) {
            $start = 0;
        }
        
        if ($limit < 1) {
            $limit = 20;
        }
        
        $query = $this->db->query("SELECT c.phpner_blog_comment_id, c.author, c.rating, c.text, c.plus, c.minus, a.phpner_blog_article_id, ad.name, a.image, c.date_added FROM " . DB_PREFIX . "phpner_blog_comments c LEFT JOIN " . DB_PREFIX . "phpner_blog_article a ON (c.phpner_blog_article_id = a.phpner_blog_article_id) LEFT JOIN " . DB_PREFIX . "phpner_blog_article_description ad ON (a.phpner_blog_article_id = ad.phpner_blog_article_id) WHERE a.phpner_blog_article_id = '" . (int) $phpner_blog_article_id . "' AND a.date_added <= NOW() AND a.status = '1' AND c.status = '1' AND ad.language_id = '" . (int) $this->config->get('config_language_id') . "' ORDER BY c.date_added DESC LIMIT " . (int) $start . "," . (int) $limit);
        
        return $query->rows;
    }
    
    public function getTotalCommentsByArticleId($phpner_blog_article_id) {
        $query = $this->db->query("SELECT COUNT(*) AS total FROM " . DB_PREFIX . "phpner_blog_comments c LEFT JOIN " . DB_PREFIX . "phpner_blog_article a ON (c.phpner_blog_article_id = a.phpner_blog_article_id) LEFT JOIN " . DB_PREFIX . "phpner_blog_article_description ad ON (a.phpner_blog_article_id = ad.phpner_blog_article_id) WHERE a.phpner_blog_article_id = '" . (int) $phpner_blog_article_id . "' AND a.date_added <= NOW() AND a.status = '1' AND c.status = '1' AND ad.language_id = '" . (int) $this->config->get('config_language_id') . "'");
        
        return $query->row['total'];
    }
    
    public function updateLike($phpner_blog_comment_id, $phpner_blog_article_id, $type) {
        $sql = "UPDATE " . DB_PREFIX . "phpner_blog_comments";
        
        if ($type == 'plus') {
            $sql .= " SET plus = (plus + 1)";
        }
        
        if ($type == 'minus') {
            $sql .= " SET minus = (minus + 1)";
        }
        
        $sql .= " WHERE phpner_blog_article_id = '" . (int) $phpner_blog_article_id . "' AND phpner_blog_comment_id = '" . (int) $phpner_blog_comment_id . "'";
        
        $this->db->query($sql);
    }
    
    public function addCommentLike($phpner_blog_comment_id, $phpner_blog_article_id, $data) {
        $this->db->query("INSERT INTO " . DB_PREFIX . "phpner_blog_comments_like SET customer_ip = '" . $this->db->escape($data['customer_ip']) . "', customer_id = '" . $this->db->escape($data['customer_id']) . "', phpner_blog_article_id = '" . (int) $phpner_blog_article_id . "', phpner_blog_comment_id = '" . (int) $phpner_blog_comment_id . "'");
    }
    
    public function checkLike($phpner_blog_comment_id, $phpner_blog_article_id, $data) {
        $query = $this->db->query("SELECT * FROM " . DB_PREFIX . "phpner_blog_comments_like WHERE phpner_blog_article_id = '" . (int) $phpner_blog_article_id . "' AND phpner_blog_comment_id = '" . (int) $phpner_blog_comment_id . "' AND coalesce(customer_ip = '" . $this->db->escape($data['customer_ip']) . "', customer_id = '" . $this->db->escape($data['customer_id']) . "')");
        
        return $query->rows;
    }
    
    public function getLikeCount($phpner_blog_comment_id, $phpner_blog_article_id, $type) {
        $query = $this->db->query("SELECT MAX(" . $type . ") as total FROM " . DB_PREFIX . "phpner_blog_comments c LEFT JOIN " . DB_PREFIX . "phpner_blog_article a ON (c.phpner_blog_article_id = a.phpner_blog_article_id) LEFT JOIN " . DB_PREFIX . "phpner_blog_article_description ad ON (a.phpner_blog_article_id = ad.phpner_blog_article_id) WHERE a.phpner_blog_article_id = '" . (int) $phpner_blog_article_id . "' AND a.date_added <= NOW() AND a.status = '1' AND c.status = '1' AND c.phpner_blog_comment_id = '" . (int) $phpner_blog_comment_id . "' AND ad.language_id = '" . (int) $this->config->get('config_language_id') . "'");
        
        return $query->row['total'];
    }
}