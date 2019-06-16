<?php
/**************************************************************/
/*	@copyright	Phpner 2019							  */
/*	@support	http://phpner.ru					  */
/*	@license	LICENSE.txt									  */
/**************************************************************/

class ModelPhpnerSreviewReviews extends Model {
    public function addReview($data) {
        $this->db->query("INSERT INTO " . DB_PREFIX . "phpner_sreview_reviews SET author = '" . $this->db->escape($data['author']) . "', text = '" . $this->db->escape(strip_tags($data['text'])) . "', status = '" . (int) $data['status'] . "', date_added = NOW()");
        
        $phpner_sreview_review_id = $this->db->getLastId();
        
        return $phpner_sreview_review_id;
    }
    
    public function editReview($phpner_sreview_review_id, $data) {
        $this->db->query("UPDATE " . DB_PREFIX . "phpner_sreview_reviews SET author = '" . $this->db->escape($data['author']) . "', text = '" . $this->db->escape(strip_tags($data['text'])) . "', status = '" . (int) $data['status'] . "', date_modified = NOW() WHERE phpner_sreview_review_id = '" . (int) $phpner_sreview_review_id . "'");
    }
    
    public function deleteReview($phpner_sreview_review_id) {
        $reviews = $this->getReviewVote($phpner_sreview_review_id);
        
        if ($reviews) {
            foreach ($reviews as $review) {
                $this->db->query("UPDATE " . DB_PREFIX . "phpner_sreview_subject SET subject_rating_count" . (int) $review['rating'] . " = (subject_rating_count" . (int) $review['rating'] . " - " . (int) $review['rating'] . ") WHERE phpner_sreview_subject_id = '" . (int) $review['phpner_sreview_subject_id'] . "'");
            }
            $this->db->query("DELETE FROM " . DB_PREFIX . "phpner_sreview_reviews_vote WHERE phpner_sreview_review_id = '" . (int) $phpner_sreview_review_id . "'");
        }
        
        $this->db->query("DELETE FROM " . DB_PREFIX . "phpner_sreview_reviews WHERE phpner_sreview_review_id = '" . (int) $phpner_sreview_review_id . "'");
    }
    
    public function getReviewVote($phpner_sreview_review_id) {
        $query = $this->db->query("SELECT * FROM " . DB_PREFIX . "phpner_sreview_reviews_vote WHERE phpner_sreview_review_id = '" . (int) $phpner_sreview_review_id . "'");
        
        return $query->rows;
    }
    
    public function getReview($phpner_sreview_review_id) {
        $query = $this->db->query("SELECT DISTINCT * FROM " . DB_PREFIX . "phpner_sreview_reviews WHERE phpner_sreview_review_id = '" . (int) $phpner_sreview_review_id . "'");
        
        return $query->row;
    }
    
    public function getReviews($data = array()) {
        $sql = "SELECT * FROM " . DB_PREFIX . "phpner_sreview_reviews WHERE date_added != '00-00-0000'";
        
        if (isset($data['filter_status'])) {
            $sql .= " AND status = '" . $data['filter_status'] . "'";
        }
        
        if (!empty($data['filter_author'])) {
            $sql .= " AND author LIKE '" . $this->db->escape($data['filter_author']) . "%'";
        }
        
        if (!empty($data['filter_date_added'])) {
            $sql .= " AND DATE(date_added) = DATE('" . $this->db->escape($data['filter_date_added']) . "')";
        }
        
        $sort_data = array(
            'author',
            'rating',
            'status',
            'date_added'
        );
        
        if (isset($data['sort']) && in_array($data['sort'], $sort_data)) {
            $sql .= " ORDER BY " . $data['sort'];
        } else {
            $sql .= " ORDER BY date_added";
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
    
    public function getTotalReviews($data = array()) {
        $sql = "SELECT COUNT(*) AS total FROM " . DB_PREFIX . "phpner_sreview_reviews WHERE date_added != '00-00-0000'";
        
        if (!empty($data['filter_author'])) {
            $sql .= " AND author LIKE '" . $this->db->escape($data['filter_author']) . "%'";
        }
        
        if (isset($data['filter_status']) && !is_null($data['filter_status'])) {
            $sql .= " AND status = '" . (int) $data['filter_status'] . "'";
        }
        
        if (!empty($data['filter_date_added'])) {
            $sql .= " AND DATE(date_added) = DATE('" . $this->db->escape($data['filter_date_added']) . "')";
        }
        
        $query = $this->db->query($sql);
        
        return $query->row['total'];
    }
}