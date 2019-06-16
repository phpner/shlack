<?php
/**************************************************************/
/*	@copyright	Phpner 2019							  */
/*	@support	http://phpner.ru					  */
/*	@license	LICENSE.txt									  */
/**************************************************************/

class ModelPhpnerSreviewReviews extends Model {
    public function addReview($data = array()) {
        $phpner_sreview_setting_data = $this->config->get('phpner_sreview_setting_data');
        
        if ($phpner_sreview_setting_data['review_moderation'] == 1) {
            $status = 0;
        } else {
            $status = 1;
        }
        
        $this->db->query("INSERT INTO " . DB_PREFIX . "phpner_sreview_reviews SET author = '" . $this->db->escape($data['author']) . "', text = '" . $this->db->escape($data['text']) . "', status = '" . (int) $status . "', date_added = NOW()");
        
        $phpner_sreview_review_id = $this->db->getLastId();
        
        $avg_rating = 0;
        $rate_val   = 0;
        
        if (isset($data['rating'])) {
            $count_i = 0;
            
            foreach ($data['rating'] as $subject_id => $rating) {
                $subject = $this->getSubject($subject_id);
                
                if ($subject) {
                    $this->db->query("UPDATE " . DB_PREFIX . "phpner_sreview_subject SET subject_rating_count" . $rating . " = (subject_rating_count" . $rating . " + " . $rating . ") WHERE phpner_sreview_subject_id = '" . (int) $subject_id . "'");
                    $this->db->query("INSERT INTO " . DB_PREFIX . "phpner_sreview_reviews_vote SET phpner_sreview_subject_id = '" . (int) $subject_id . "', phpner_sreview_review_id = '" . (int) $phpner_sreview_review_id . "', rating = '" . $rating . "'");
                    $rate_val = $rate_val + $rating;
                    $count_i++;
                }
                
            }
        }
        
        if ($rate_val != 0) {
            $avg_rating = $rate_val / $count_i;
        }
        
        $this->db->query("UPDATE " . DB_PREFIX . "phpner_sreview_reviews SET avg_rating = '" . $avg_rating . "' WHERE phpner_sreview_review_id = '" . (int) $phpner_sreview_review_id . "'");
    }
    
    public function getSubject($phpner_sreview_subject_id) {
        $query = $this->db->query("SELECT DISTINCT * FROM " . DB_PREFIX . "phpner_sreview_subject s LEFT JOIN " . DB_PREFIX . "phpner_sreview_subject_description sd ON (s.phpner_sreview_subject_id = sd.phpner_sreview_subject_id) LEFT JOIN " . DB_PREFIX . "phpner_sreview_subject_to_store s2s ON (s.phpner_sreview_subject_id = s2s.phpner_sreview_subject_id) WHERE s.status = '1' AND s.phpner_sreview_subject_id = '" . (int) $phpner_sreview_subject_id . "' AND s2s.store_id = '" . (int) $this->config->get('config_store_id') . "' AND sd.language_id = '" . (int) $this->config->get('config_language_id') . "'");
        
        return $query->row;
    }
    
    public function getReviews($data = array()) {
        $sql = "SELECT * FROM " . DB_PREFIX . "phpner_sreview_reviews WHERE status = '1'";
        
        $sort_data = array(
            'author_asc',
            'author_desc',
            'date_added_asc',
            'date_added_desc'
        );
        
        if (isset($data['sort']) && in_array($data['sort'], $sort_data)) {
            if ($data['sort'] == 'author_asc') {
                $sql .= " ORDER BY LCASE(author) ASC";
            } elseif ($data['sort'] == 'author_desc') {
                $sql .= " ORDER BY LCASE(author) DESC";
            } elseif ($data['sort'] == 'date_added_asc') {
                $sql .= " ORDER BY date_added ASC";
            } else {
                $sql .= " ORDER BY date_added DESC";
            }
        } else {
            $sql .= " ORDER BY date_added DESC";
        }
        
        if (isset($data['start']) || isset($data['limit'])) {
            
            if (!isset($data['start']) || $data['start'] < 0) {
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
    
    public function getTotalReviews($data = array()) {
        $sql = "SELECT COUNT(*) as total FROM " . DB_PREFIX . "phpner_sreview_reviews WHERE status = '1'";
        
        $sort_data = array(
            'author_asc',
            'author_desc',
            'date_added_asc',
            'date_added_desc'
        );
        
        if (isset($data['sort']) && in_array($data['sort'], $sort_data)) {
            if ($data['sort'] == 'author_asc') {
                $sql .= " ORDER BY LCASE(author) ASC";
            } elseif ($data['sort'] == 'author_desc') {
                $sql .= " ORDER BY LCASE(author) DESC";
            } elseif ($data['sort'] == 'date_added_asc') {
                $sql .= " ORDER BY date_added ASC";
            } else {
                $sql .= " ORDER BY date_added DESC";
            }
        } else {
            $sql .= " ORDER BY date_added ASC";
        }
        
        $query = $this->db->query($sql);
        
        return $query->row['total'];
    }
    
    public function getTotalStoreReviews() {
        $sql = "SELECT COUNT(rv.phpner_sreview_review_id) as total, (SELECT SUM(rv.rating)) as vote_sum FROM " . DB_PREFIX . "phpner_sreview_reviews r LEFT JOIN " . DB_PREFIX . "phpner_sreview_reviews_vote rv ON (r.phpner_sreview_review_id = rv.phpner_sreview_review_id) WHERE r.status = '1'";
        
        $query = $this->db->query($sql);
        
        $results = 0;
        
        if ($query->row['vote_sum'] != 0 && $query->row['total'] != 0) {
            $results = $query->row['vote_sum'] / $query->row['total'];
        }
        
        return $results;
    }
    
    public function getSubjects() {
        $query = $this->db->query("SELECT * FROM " . DB_PREFIX . "phpner_sreview_subject s LEFT JOIN " . DB_PREFIX . "phpner_sreview_subject_description sd ON (s.phpner_sreview_subject_id = sd.phpner_sreview_subject_id) LEFT JOIN " . DB_PREFIX . "phpner_sreview_subject_to_store s2s ON (s.phpner_sreview_subject_id = s2s.phpner_sreview_subject_id) WHERE s.status = '1' AND sd.language_id = '" . (int) $this->config->get('config_language_id') . "' AND s2s.store_id = '" . (int) $this->config->get('config_store_id') . "' GROUP BY s.phpner_sreview_subject_id ORDER BY s.sort_order, LCASE(sd.name) DESC");
        
        return $query->rows;
    }
    
    public function getReviewSubjects($phpner_sreview_review_id) {
        $query = $this->db->query("SELECT * FROM " . DB_PREFIX . "phpner_sreview_reviews_vote WHERE phpner_sreview_review_id = '" . (int) $phpner_sreview_review_id . "'");
        
        return $query->rows;
    }
}