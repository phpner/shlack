<?php
/**************************************************************/
/*	@copyright	Phpner 2019							  */
/*	@support	http://phpner.ru					  */
/*	@license	LICENSE.txt									  */
/**************************************************************/

class ModelPhpnerSreviewSubject extends Model {
    public function addSubject($data) {
        $this->db->query("INSERT INTO " . DB_PREFIX . "phpner_sreview_subject SET status = '" . (int) $data['status'] . "', sort_order = '" . (int) $data['sort_order'] . "', date_added = NOW()");
        
        $phpner_sreview_subject_id = $this->db->getLastId();
        
        foreach ($data['subject_description'] as $language_id => $value) {
            $this->db->query("INSERT INTO " . DB_PREFIX . "phpner_sreview_subject_description SET phpner_sreview_subject_id = '" . (int) $phpner_sreview_subject_id . "', language_id = '" . (int) $language_id . "', name = '" . $this->db->escape($value['name']) . "'");
        }
        
        if (isset($data['subject_store'])) {
            foreach ($data['subject_store'] as $store_id) {
                $this->db->query("INSERT INTO " . DB_PREFIX . "phpner_sreview_subject_to_store SET phpner_sreview_subject_id = '" . (int) $phpner_sreview_subject_id . "', store_id = '" . (int) $store_id . "'");
            }
        }
        
        $this->cache->delete('phpner_sreview_subject');
        
        return $phpner_sreview_subject_id;
    }
    
    public function editSubject($phpner_sreview_subject_id, $data) {
        $this->db->query("UPDATE " . DB_PREFIX . "phpner_sreview_subject SET status = '" . (int) $data['status'] . "', sort_order = '" . (int) $data['sort_order'] . "', date_modified = NOW() WHERE phpner_sreview_subject_id = '" . (int) $phpner_sreview_subject_id . "'");
        
        $this->db->query("DELETE FROM " . DB_PREFIX . "phpner_sreview_subject_description WHERE phpner_sreview_subject_id = '" . (int) $phpner_sreview_subject_id . "'");
        
        foreach ($data['subject_description'] as $language_id => $value) {
            $this->db->query("INSERT INTO " . DB_PREFIX . "phpner_sreview_subject_description SET phpner_sreview_subject_id = '" . (int) $phpner_sreview_subject_id . "', language_id = '" . (int) $language_id . "', name = '" . $this->db->escape($value['name']) . "'");
        }
        
        $this->db->query("DELETE FROM " . DB_PREFIX . "phpner_sreview_subject_to_store WHERE phpner_sreview_subject_id = '" . (int) $phpner_sreview_subject_id . "'");
        
        if (isset($data['subject_store'])) {
            foreach ($data['subject_store'] as $store_id) {
                $this->db->query("INSERT INTO " . DB_PREFIX . "phpner_sreview_subject_to_store SET phpner_sreview_subject_id = '" . (int) $phpner_sreview_subject_id . "', store_id = '" . (int) $store_id . "'");
            }
        }
        
        $this->cache->delete('phpner_sreview_subject');
    }
    
    public function copySubject($phpner_sreview_subject_id) {
        $query = $this->db->query("SELECT DISTINCT * FROM " . DB_PREFIX . "phpner_sreview_subject s LEFT JOIN " . DB_PREFIX . "phpner_sreview_subject_description sd ON (s.phpner_sreview_subject_id = sd.phpner_sreview_subject_id) WHERE s.phpner_sreview_subject_id = '" . (int) $phpner_sreview_subject_id . "' AND sd.language_id = '" . (int) $this->config->get('config_language_id') . "'");
        
        if ($query->num_rows) {
            $data = $query->row;
            
            $data['status']                = '0';
            $data['subject_rating_count1'] = '0';
            $data['subject_rating_count2'] = '0';
            $data['subject_rating_count3'] = '0';
            $data['subject_rating_count4'] = '0';
            $data['subject_rating_count5'] = '0';
            $data['subject_description']   = $this->getSubjectDescriptions($phpner_sreview_subject_id);
            $data['subject_store']         = $this->getSubjectStores($phpner_sreview_subject_id);
            
            $this->addSubject($data);
        }
    }
    
    public function deleteSubject($phpner_sreview_subject_id) {
        $reviews = $this->getReviewVote($phpner_sreview_subject_id);
        
        if ($reviews) {
            foreach ($reviews as $review) {
                $this->db->query("UPDATE " . DB_PREFIX . "phpner_sreview_subject SET subject_rating_count" . (int) $review['rating'] . " = (subject_rating_count" . (int) $review['rating'] . " - " . (int) $review['rating'] . ") WHERE phpner_sreview_subject_id = '" . (int) $phpner_sreview_subject_id . "'");
            }
            $this->db->query("DELETE FROM " . DB_PREFIX . "phpner_sreview_reviews_vote WHERE phpner_sreview_subject_id = '" . (int) $phpner_sreview_subject_id . "'");
        }
        
        $this->db->query("DELETE FROM " . DB_PREFIX . "phpner_sreview_subject WHERE phpner_sreview_subject_id = '" . (int) $phpner_sreview_subject_id . "'");
        $this->db->query("DELETE FROM " . DB_PREFIX . "phpner_sreview_subject_description WHERE phpner_sreview_subject_id = '" . (int) $phpner_sreview_subject_id . "'");
        $this->db->query("DELETE FROM " . DB_PREFIX . "phpner_sreview_subject_to_store WHERE phpner_sreview_subject_id = '" . (int) $phpner_sreview_subject_id . "'");
        
        $this->cache->delete('phpner_sreview_subject');
    }
    
    public function getReviewVote($phpner_sreview_subject_id) {
        $query = $this->db->query("SELECT * FROM " . DB_PREFIX . "phpner_sreview_reviews_vote WHERE phpner_sreview_subject_id = '" . (int) $phpner_sreview_subject_id . "'");
        
        return $query->rows;
    }
    
    public function getSubject($phpner_sreview_subject_id) {
        $query = $this->db->query("SELECT DISTINCT * FROM " . DB_PREFIX . "phpner_sreview_subject s LEFT JOIN " . DB_PREFIX . "phpner_sreview_subject_description sd ON (s.phpner_sreview_subject_id = sd.phpner_sreview_subject_id) WHERE s.phpner_sreview_subject_id = '" . (int) $phpner_sreview_subject_id . "' AND sd.language_id = '" . (int) $this->config->get('config_language_id') . "'");
        
        return $query->row;
    }
    
    public function getSubjects($data = array()) {
        $sql = "SELECT * FROM " . DB_PREFIX . "phpner_sreview_subject s LEFT JOIN " . DB_PREFIX . "phpner_sreview_subject_description sd ON (s.phpner_sreview_subject_id = sd.phpner_sreview_subject_id) WHERE sd.language_id = '" . (int) $this->config->get('config_language_id') . "'";
        
        if (!empty($data['filter_name'])) {
            $sql .= " AND sd.name LIKE '" . $this->db->escape($data['filter_name']) . "%'";
        }
        
        if (isset($data['filter_status']) && !is_null($data['filter_status'])) {
            $sql .= " AND s.status = '" . (int) $data['filter_status'] . "'";
        }
        
        $sql .= " GROUP BY s.phpner_sreview_subject_id";
        
        $sort_data = array(
            'sd.name',
            's.status',
            's.sort_order'
        );
        
        if (isset($data['sort']) && in_array($data['sort'], $sort_data)) {
            $sql .= " ORDER BY " . $data['sort'];
        } else {
            $sql .= " ORDER BY sd.name";
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
    
    public function getSubjectDescriptions($phpner_sreview_subject_id) {
        $subject_description_data = array();
        
        $query = $this->db->query("SELECT * FROM " . DB_PREFIX . "phpner_sreview_subject_description WHERE phpner_sreview_subject_id = '" . (int) $phpner_sreview_subject_id . "'");
        
        foreach ($query->rows as $result) {
            $subject_description_data[$result['language_id']] = array(
                'name' => $result['name']
            );
        }
        
        return $subject_description_data;
    }
    
    public function getSubjectStores($phpner_sreview_subject_id) {
        $subject_store_data = array();
        
        $query = $this->db->query("SELECT * FROM " . DB_PREFIX . "phpner_sreview_subject_to_store WHERE phpner_sreview_subject_id = '" . (int) $phpner_sreview_subject_id . "'");
        
        foreach ($query->rows as $result) {
            $subject_store_data[] = $result['store_id'];
        }
        
        return $subject_store_data;
    }
    
    public function getTotalSubjects($data = array()) {
        $sql = "SELECT COUNT(DISTINCT s.phpner_sreview_subject_id) AS total FROM " . DB_PREFIX . "phpner_sreview_subject s LEFT JOIN " . DB_PREFIX . "phpner_sreview_subject_description sd ON (s.phpner_sreview_subject_id = sd.phpner_sreview_subject_id)";
        
        $sql .= " WHERE sd.language_id = '" . (int) $this->config->get('config_language_id') . "'";
        
        if (!empty($data['filter_name'])) {
            $sql .= " AND sd.name LIKE '" . $this->db->escape($data['filter_name']) . "%'";
        }
        
        if (isset($data['filter_status']) && !is_null($data['filter_status'])) {
            $sql .= " AND s.status = '" . (int) $data['filter_status'] . "'";
        }
        
        $query = $this->db->query($sql);
        
        return $query->row['total'];
    }
}