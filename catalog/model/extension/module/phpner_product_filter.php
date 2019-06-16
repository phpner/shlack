<?php
/**************************************************************/
/*	@copyright	Phpner 2019							  */
/*	@support	http://phpner.ru					  */
/*	@license	LICENSE.txt									  */
/**************************************************************/

class ModelExtensionModulePhpnerProductFilter extends Model {
	public function getProductIDs($global_id, $global_type, $store_id, $customer_group_id) {
		/*3359*/
		$phpner_product_filter_data = $this->config->get('phpner_product_filter_data');
		
		if (!isset($phpner_product_filter_data['show_no_quantity_products'])) {
			$phpner_product_filter_data['show_no_quantity_products'] = 1;
		}
		/*3359*/
		
        if ($global_type == 'category') {
            $result = $this->cache->get('phpner.product_filter_pids.category.' . (int) $store_id . '.' . (int) $customer_group_id . '.' . (int) $global_id);
            
            if (!$result) {
				/*3359*/
				$sql = "SELECT DISTINCT p.product_id FROM " . DB_PREFIX . "product p LEFT JOIN " . DB_PREFIX . "product_to_category p2c ON (p.product_id = p2c.product_id) LEFT JOIN " . DB_PREFIX . "product_to_store p2s ON (p.product_id = p2s.product_id) WHERE p.status = '1'"; 
				
				if (isset($phpner_product_filter_data['show_no_quantity_products']) && !$phpner_product_filter_data['show_no_quantity_products']) {
					$sql .= " AND p.quantity > 0";
				}
				
				$sql .= " AND p.date_available <= NOW() AND p2s.store_id = '" . (int) $store_id . "' AND p2c.category_id = '" . (int) $global_id . "'";
				
                $query = $this->db->query($sql)->rows;
                /*3359*/
				
                $result = array();
                
                foreach ($query as $value) {
                    $result[] = $value['product_id'];
                }
                
                $this->cache->set('phpner.product_filter_pids.category.' . (int) $store_id . '.' . (int) $customer_group_id . '.' . (int) $global_id, $result);
            }
        } elseif ($global_type == 'manufacturer') {
            $result = $this->cache->get('phpner.product_filter_pids.manufacturer.' . (int) $store_id . '.' . (int) $customer_group_id . '.' . (int) $global_id);
            
            if (!$result) {
				/*3359*/
				$sql = "SELECT DISTINCT p.product_id FROM " . DB_PREFIX . "product p LEFT JOIN " . DB_PREFIX . "product_to_store p2s ON (p.product_id = p2s.product_id) WHERE p.status = '1'";
				
				if (isset($phpner_product_filter_data['show_no_quantity_products']) && !$phpner_product_filter_data['show_no_quantity_products']) {
					$sql .= " AND p.quantity > 0";
				}
				
				$sql .= " AND p.date_available <= NOW() AND p2s.store_id = '" . (int) $store_id . "' AND p.manufacturer_id = '" . (int) $global_id . "'";
				
                $query = $this->db->query($sql)->rows;
                /*3359*/
				
                $result = array();
                
                foreach ($query as $value) {
                    $result[] = $value['product_id'];
                }
                
                $this->cache->set('phpner.product_filter_pids.manufacturer.' . (int) $store_id . '.' . (int) $customer_group_id . '.' . (int) $global_id, $result);
            }
        } elseif ($global_type == 'special') {
            $result = $this->cache->get('phpner.product_filter_pids.special.' . (int) $store_id . '.' . (int) $customer_group_id);
            
            if (!$result) {
				/*3359*/
				$sql = "SELECT DISTINCT p.product_id FROM " . DB_PREFIX . "product p LEFT JOIN " . DB_PREFIX . "product_special ps ON (ps.product_id = p.product_id) LEFT JOIN " . DB_PREFIX . "product_to_store p2s ON (p.product_id = p2s.product_id) WHERE p.status = '1'";
				
				if (isset($phpner_product_filter_data['show_no_quantity_products']) && !$phpner_product_filter_data['show_no_quantity_products']) {
					$sql .= " AND p.quantity > 0";
				}
				
				$sql .= " AND p.date_available <= NOW() AND p2s.store_id = '" . (int) $store_id . "' AND ps.customer_group_id = '" . (int) $customer_group_id . "' AND ((ps.date_start = '0000-00-00' OR ps.date_start < NOW()) AND (ps.date_end = '0000-00-00' OR ps.date_end > NOW())) GROUP BY p.product_id";
				
                $query = $this->db->query($sql)->rows;
                /*3359*/
				
                $result = array();
                
                foreach ($query as $value) {
                    $result[] = $value['product_id'];
                }
                
                $this->cache->set('phpner.product_filter_pids.special.' . (int) $store_id . '.' . (int) $customer_group_id, $result);
            }
        } else {
            $result = $this->cache->get('phpner.product_filter_pids.all_products.' . (int) $store_id . '.' . (int) $customer_group_id);
            
            if (!$result) {
				/*3359*/
				$sql = "SELECT DISTINCT p.product_id FROM " . DB_PREFIX . "product p LEFT JOIN " . DB_PREFIX . "product_to_store p2s ON (p.product_id = p2s.product_id) WHERE p.status = '1'";
				
				if (isset($phpner_product_filter_data['show_no_quantity_products']) && !$phpner_product_filter_data['show_no_quantity_products']) {
					$sql .= " AND p.quantity > 0";
				}
				
				$sql .= " AND p.date_available <= NOW() AND p2s.store_id = '" . (int) $store_id . "'";
				
                $query = $this->db->query($sql)->rows;
                /*3359*/
				
                $result = array();
                
                foreach ($query as $value) {
                    $result[] = $value['product_id'];
                }
                
                $this->cache->set('phpner.product_filter_pids.all_products.' . (int) $store_id . '.' . (int) $customer_group_id, $result);
            }
        }
        
        return $result;
    }

	public function getFilterMINMAXPrices($global_id, $global_type, $store_id, $customer_group_id, $data = array(), $lead_time_status = false) {
		$product_ids = $this->getProductIDs($global_id, $global_type, $store_id, $customer_group_id);

		if ($product_ids) {
			if ($lead_time_status) {
				$sqlTime = 0;
				$timeStart = microtime(true);
			}

			if (isset($data['special_only']) && !empty($data['special_only'])) {
				$query = $this->db->query("SELECT MIN((SELECT ps.price FROM ".DB_PREFIX."product_special ps WHERE ps.product_id = p.product_id AND ps.customer_group_id = '".(int)$customer_group_id."' AND ((ps.date_start = '0000-00-00' OR ps.date_start < NOW()) AND (ps.date_end = '0000-00-00' OR ps.date_end > NOW())) ORDER BY ps.priority ASC, ps.price ASC LIMIT 1)) AS low_price, MAX((SELECT ps.price FROM ".DB_PREFIX."product_special ps WHERE ps.product_id = p.product_id AND ps.customer_group_id = '".(int)$customer_group_id."' AND ((ps.date_start = '0000-00-00' OR ps.date_start < NOW()) AND (ps.date_end = '0000-00-00' OR ps.date_end > NOW())) ORDER BY ps.priority ASC, ps.price ASC LIMIT 1)) AS high_price FROM ".DB_PREFIX."product p WHERE p.product_id IN (".implode(',', $product_ids).")")->row;
			} else {
				$query = $this->db->query("SELECT MIN(CASE WHEN(SELECT price FROM ".DB_PREFIX."product_special ps WHERE ps.product_id = p.product_id AND ps.customer_group_id = '".(int)$customer_group_id."' AND ((ps.date_start = '0000-00-00' OR ps.date_start < NOW()) AND (ps.date_end = '0000-00-00' OR ps.date_end > NOW())) ORDER BY ps.priority ASC, ps.price ASC LIMIT 1) > 0 THEN (SELECT price FROM ".DB_PREFIX."product_special ps WHERE ps.product_id = p.product_id AND ps.customer_group_id = '".(int)$customer_group_id."' AND ((ps.date_start = '0000-00-00' OR ps.date_start < NOW()) AND (ps.date_end = '0000-00-00' OR ps.date_end > NOW())) ORDER BY ps.priority ASC, ps.price ASC LIMIT 1) ELSE p.price END) AS low_price, MAX(CASE WHEN(SELECT price FROM ".DB_PREFIX."product_special ps WHERE ps.product_id = p.product_id AND ps.customer_group_id = '".(int)$customer_group_id."' AND ((ps.date_start = '0000-00-00' OR ps.date_start < NOW()) AND (ps.date_end = '0000-00-00' OR ps.date_end > NOW())) ORDER BY ps.priority ASC, ps.price ASC LIMIT 1) > 0 THEN (SELECT price FROM ".DB_PREFIX."product_special ps WHERE ps.product_id = p.product_id AND ps.customer_group_id = '".(int)$customer_group_id."' AND ((ps.date_start = '0000-00-00' OR ps.date_start < NOW()) AND (ps.date_end = '0000-00-00' OR ps.date_end > NOW())) ORDER BY ps.priority ASC, ps.price ASC LIMIT 1) ELSE p.price END) AS high_price FROM ".DB_PREFIX."product p WHERE p.product_id IN (".implode(',', $product_ids).")")->row;
			}

			if ($lead_time_status) {
				$sqlTime += microtime(true) - $timeStart;
				$log = new \Log('phpner_filter_debug.log');
				$log->write("######### start #########");
				$log->write("P query time : ".number_format(($sqlTime), 2)." sec");
			}

			return array(
				'low_price'  => $query['low_price'], 
				'high_price' => $query['high_price']
			);
		} else {
			return array(
				'low_price'  => 0, 
				'high_price' => 1
			);
		}
	}

	public function getFilterTotalSpecialOnly($global_id, $global_type, $store_id, $customer_group_id, $language_id, $lead_time_status = false, $data = array()) {
		$product_ids = $this->getProductIDs($global_id, $global_type, $store_id, $customer_group_id);

		if ($product_ids) {
			$sql = "SELECT COUNT(DISTINCT p.product_id) AS total FROM ".DB_PREFIX."product_special ps ";

			$sql .= "INNER JOIN ".DB_PREFIX."product p USING (product_id) ";

			if (isset($data['tag']) && !empty($data['tag'])) {
				$sql .= " INNER JOIN ".DB_PREFIX."product_description pd USING (product_id)";
			}

			if (isset($data['sticker']) && !empty($data['sticker'])) {
				$sql .= " INNER JOIN ".DB_PREFIX."phpner_filter_product_sticker fpst USING (product_id)";
			}

			if (isset($data['option']) && !empty($data['option'])) {
				$sql .= " INNER JOIN ".DB_PREFIX."phpner_filter_product_option fpo USING (product_id)";
			}

			if (isset($data['attribute']) && !empty($data['attribute'])) {
				$sql .= " INNER JOIN ".DB_PREFIX."phpner_filter_product_attribute fpa USING (product_id)";
			}

			if (isset($data['standard']) && !empty($data['standard'])) {
				$sql .= " INNER JOIN ".DB_PREFIX."phpner_filter_product_standard fpsd USING (product_id)";
			}

			$sql .= " WHERE ps.product_id IN (".implode(',', $product_ids).")";
			
			$sql .= " AND ps.product_id IN (SELECT product_id FROM ".DB_PREFIX."product_special WHERE product_id = ps.product_id AND ps.customer_group_id = '".(int)$data['filter_data']['customer_group_id']."' AND ((ps.date_start = '0000-00-00' OR ps.date_start < NOW()) AND (ps.date_end = '0000-00-00' OR ps.date_end > NOW())) ORDER BY ps.priority ASC, ps.price ASC)";

			if (isset($data['low_price']) && (isset($data['high_price']) && !empty($data['high_price']))) {
				$sql .= " AND ";
				/* 3359 */
				$sql .= "((CASE WHEN(SELECT price FROM ".DB_PREFIX."product_special ps WHERE ps.product_id = p.product_id AND ps.customer_group_id = '".(int)$data['filter_data']['customer_group_id']."' AND ((ps.date_start = '0000-00-00' OR ps.date_start < NOW()) AND (ps.date_end = '0000-00-00' OR ps.date_end > NOW())) ORDER BY ps.priority ASC, ps.price ASC LIMIT 1) > 0 THEN (SELECT price FROM ".DB_PREFIX."product_special ps WHERE ps.product_id = p.product_id AND ps.customer_group_id = '".(int)$data['filter_data']['customer_group_id']."' AND ((ps.date_start = '0000-00-00' OR ps.date_start < NOW()) AND (ps.date_end = '0000-00-00' OR ps.date_end > NOW())) ORDER BY ps.priority ASC, ps.price ASC LIMIT 1) ELSE p.price END) BETWEEN ".(float)$data['low_price']." AND ".(float)$data['high_price'].")";
				/* 3359 */
			}

			if (isset($data['manufacturer']) && !empty($data['manufacturer'])) {
				$sql .= " ".$data['filter_data']['manufacturer_logic_with_other']." (";

				if (is_array($data['manufacturer'])) {
					$implode_manufacturer = array();

					foreach ($data['manufacturer'] as $manufacturer) {
						$implode_manufacturer[] = "p.manufacturer_id = '".(int)$manufacturer."'";
					}

					if ($implode_manufacturer) {
						$sql .= "(".implode(' OR ', $implode_manufacturer).")";
					}
				} else {
					$sql .= "p.manufacturer_id = '".(int)$data['manufacturer']."'";
				}
				$sql .= ")";
			}

			if (isset($data['stock']) && !empty($data['stock'])) {
				$sql .= " ".$data['filter_data']['stock_logic_with_other']." (";

				if (is_array($data['stock'])) {
					$implode_stock = array();

					foreach ($data['stock'] as $stock) {
						if ($stock == 'in_stock') {
							$implode_stock[] = "p.quantity > '0'";
						} elseif($stock == 'out_of_stock') {
							$implode_stock[] = "p.quantity <= '0'";
						} elseif($stock == 'ending_stock') {
							$implode_stock[] = "(p.quantity BETWEEN '0' AND '".(int)$data['filter_data']['stock_ending_value']."')";	
						}
					}

					if ($implode_stock) {
						$sql .= implode(' '.$data['filter_data']['stock_logic_between_stock'].' ', $implode_stock);
					}
				} else {
					if ($data['stock'] == 'in_stock') {
						$sql .= "p.quantity > '0'";
					} elseif($data['stock'] == 'out_of_stock') {
						$sql .= "p.quantity <= '0'";
					} elseif($data['stock'] == 'ending_stock') {
						$sql .= "(p.quantity BETWEEN '0' AND '".(int)$data['filter_data']['stock_ending_value']."')";	
					}
				}
				$sql .= ")";
			}

			if (isset($data['rating']) && !empty($data['rating'])) {
				$implode_rating = array();

				if (is_array($data['rating'])) {
					foreach ($data['rating'] as $rating) {
						$implode_rating[] = "p.product_id IN (SELECT product_id FROM ".DB_PREFIX."review WHERE product_id = p.product_id AND rating = '".$rating."' AND status = '1' GROUP BY rating)";
					}
				} else {
					if ($data['rating']) {
						$implode_rating[] = "p.product_id IN (SELECT product_id FROM ".DB_PREFIX."review WHERE product_id = p.product_id AND rating = '".$data['rating']."' AND status = '1' GROUP BY rating)";
					}
				}

				if ($implode_rating) {
					$sql .= " ".$data['filter_data']['review_logic_with_other']." (" .implode(' '.$data['filter_data']['review_logic_between_review'].' ', $implode_rating) . ")";
				}
			}

			if (isset($data['sticker']) && !empty($data['sticker'])) {
				if ($data['filter_data']['sticker_logic_between_sticker'] == 'AND') {
					$implode_product_stickers = array();

					if (is_array($data['sticker'])) {
						foreach ($data['sticker'] as $product_sticker_id) {
							if ($product_sticker_id) {
								$implode_product_stickers[] = "fpst.product_id IN (SELECT product_id FROM ".DB_PREFIX."phpner_filter_product_sticker WHERE product_id = fpst.product_id AND product_sticker_id = '".(int)$product_sticker_id."' GROUP BY product_sticker_id)";
							}
						}
					} else {
						if ($data['sticker']) {
							$implode_product_stickers[] = "fpst.product_id IN (SELECT product_id FROM ".DB_PREFIX."phpner_filter_product_sticker WHERE product_id = fpst.product_id AND product_sticker_id = '".(int)$data['sticker']."' GROUP BY product_sticker_id)";
						}
					}

					if ($implode_product_stickers) {
						$sql .= " ".$data['filter_data']['sticker_logic_with_other']." (" . implode(' AND ', $implode_product_stickers) . ")";
					}
				} else {
					if (is_array($data['sticker'])) {
						$implode_product_stickers = array();

						foreach ($data['sticker'] as $product_sticker_id) {
							$implode_product_stickers[] = "fpst.product_sticker_id = '".(int)$product_sticker_id."'";
						}
					} else {
						$implode_product_stickers[] = "fpst.product_sticker_id = '".(int)$data['sticker']."'";
					}

					if ($implode_product_stickers) {
						$sql .= " ".$data['filter_data']['sticker_logic_with_other']." (".implode(' OR ', $implode_product_stickers).")";
					}
				}
			}

			if (isset($data['option']) && !empty($data['option'])) {
				if ($data['filter_data']['option_logic_between_option'] == 'AND') {
					$implode_product_options = array();

					foreach ($data['option'] as $option_name_mod => $option_value_id) {
						if (is_array($option_value_id)) {
							foreach ($option_value_id as $option_value_id_children) {
								if ($option_value_id_children) {
									$implode_product_options[] = "fpo.product_id IN (SELECT product_id FROM ".DB_PREFIX."phpner_filter_product_option WHERE product_id = fpo.product_id AND option_name_mod = '".$this->db->escape($option_name_mod)."' AND option_value_id = '".(int)$option_value_id_children."' GROUP BY option_value_id)";
								}
							}
						} else {
							if ($option_value_id) {
								$implode_product_options[] = "fpo.product_id IN (SELECT product_id FROM ".DB_PREFIX."phpner_filter_product_option WHERE product_id = fpo.product_id AND option_name_mod = '".$this->db->escape($option_name_mod)."' AND option_value_id = '".(int)$option_value_id."' GROUP BY option_value_id)";
							}
						}
					}

					if ($implode_product_options) {
						$sql .= " ".$data['filter_data']['option_logic_with_other']." (" . implode(' AND ', $implode_product_options) . ")";
					}
				} else {
					$implode_product_options = array();

					foreach ($data['option'] as $option_name_mod => $option_value_id) {
						if (is_array($option_value_id)) {
							foreach ($option_value_id as $option_value_id_children) {
								if ($option_value_id_children) {
									$implode_product_options[] = "(fpo.option_name_mod = '".$this->db->escape($option_name_mod)."' AND fpo.option_value_id = '".(int)$option_value_id_children."')";
								}
							}
						} else {
							if ($option_value_id) {
								$implode_product_options[] = "(fpo.option_name_mod = '".$this->db->escape($option_name_mod)."' AND fpo.option_value_id = '".(int)$option_value_id."')";
							}
						}
					}

					if ($implode_product_options) {
						$sql .= " ".$data['filter_data']['option_logic_with_other']." (" . implode(' OR ', $implode_product_options) . ")";
					}
				}
			}

			if (isset($data['attribute']) && !empty($data['attribute'])) {
				if ($data['filter_data']['attribute_logic_between_attribute'] == 'AND') {
					$implode_product_attributes = array();

					foreach ($data['attribute'] as $attribute_name_mod => $attribute_value_mod) {
						if (is_array($attribute_value_mod)) {
							foreach ($attribute_value_mod as $attribute_value_mod_children) {
								if ($attribute_value_mod_children) {
									$implode_product_attributes[] = "fpa.product_id IN (SELECT product_id FROM ".DB_PREFIX."phpner_filter_product_attribute WHERE product_id = fpa.product_id AND attribute_name_mod = '".$this->db->escape($attribute_name_mod)."'  AND attribute_value_mod = '".$this->db->escape($attribute_value_mod_children)."')";
								}
							}
						} else {
							if ($attribute_value_mod) {
								$implode_product_attributes[] = "fpa.product_id IN (SELECT product_id FROM ".DB_PREFIX."phpner_filter_product_attribute WHERE product_id = fpa.product_id AND attribute_name_mod = '".$this->db->escape($attribute_name_mod)."' AND attribute_value_mod = '".$this->db->escape($attribute_value_mod)."')";
							}
						}
					}

					if ($implode_product_attributes) {
						$sql .= " ".$data['filter_data']['attribute_logic_with_other']." (" . implode(' AND ', $implode_product_attributes) . ")";
					}
				} else {
					$implode_product_attributes = array();

					foreach ($data['attribute'] as $attribute_name_mod => $attribute_value_mod) {
						if (is_array($attribute_value_mod)) {
							foreach ($attribute_value_mod as $attribute_value_mod_children) {
								if ($attribute_value_mod_children) {
									$implode_product_attributes[] = "(fpa.attribute_name_mod = '".$this->db->escape($attribute_name_mod)."' AND fpa.attribute_value_mod = '".$this->db->escape($attribute_value_mod_children)."')";
								}
							}
						} else {
							if ($attribute_value_mod) {
								$implode_product_attributes[] = "(fpa.attribute_name_mod = '".$this->db->escape($attribute_name_mod)."' AND fpa.attribute_value_mod = '".$this->db->escape($attribute_value_mod)."')";
							}
						}
					}

					if ($implode_product_attributes) {
						$sql .= " ".$data['filter_data']['attribute_logic_with_other']." (" . implode(' OR ', $implode_product_attributes) . ")";
					}
				}
			}

			if (isset($data['standard']) && !empty($data['standard'])) {
				if ($data['filter_data']['standard_logic_between_standard'] == 'AND') {
					$implode_product_standards = array();

					foreach ($data['standard'] as $filter_name_mod => $filter_value_mod) {
						if (is_array($filter_value_mod)) {
							foreach ($filter_value_mod as $filter_value_mod_children) {
								if ($filter_value_mod_children) {
									$implode_product_standards[] = "fpsd.product_id IN (SELECT product_id FROM ".DB_PREFIX."phpner_filter_product_standard WHERE product_id = fpsd.product_id AND filter_name_mod = '".$this->db->escape($filter_name_mod)."' AND filter_value_mod = '".$this->db->escape($filter_value_mod_children)."' GROUP BY filter_value_mod)";
								}
							}
						} else {
							if ($filter_value_mod) {
								$implode_product_standards[] = "fpsd.product_id = (SELECT product_id FROM ".DB_PREFIX."phpner_filter_product_standard WHERE product_id = fpsd.product_id AND filter_name_mod = '".$this->db->escape($filter_name_mod)."' AND filter_value_mod IN ('".$this->db->escape($filter_value_mod)."') GROUP BY filter_value_mod)";
							}
						}
					}

					if ($implode_product_standards) {
						$sql .= " ".$data['filter_data']['standard_logic_with_other']." (" . implode(' AND ', $implode_product_standards) . ")";
					}
				} else {
					$implode_product_standards = array();

					foreach ($data['standard'] as $filter_name_mod => $filter_value_mod) {
						if (is_array($filter_value_mod)) {
							foreach ($filter_value_mod as $filter_value_mod_children) {
								if ($filter_value_mod_children) {
									$implode_product_standards[] = "(fpsd.filter_name_mod = '".$this->db->escape($filter_name_mod)."' AND fpsd.filter_value_mod = '".$this->db->escape($filter_value_mod_children)."')";
								}
							}
						} else {
							if ($filter_value_mod) {
								$implode_product_standards[] = "(fpsd.filter_name_mod = '".$this->db->escape($filter_name_mod)."' AND fpsd.filter_value_mod = '".$this->db->escape($filter_value_mod)."')";
							}
						}
					}

					if ($implode_product_standards) {
						$sql .= " ".$data['filter_data']['standard_logic_with_other']." (" . implode(' OR ', $implode_product_standards) . ")";
					}
				}
			}

			if (isset($data['tag']) && !empty($data['tag'])) {
				$sql .= " ".$data['filter_data']['tag_logic_with_other']." ";

				$implode_product_tag = array();
			
				$words = explode(' ', trim(preg_replace('/\s+/', ' ', $data['tag'])));
				
				foreach ($words as $word) {
					$implode_product_tag[] = "pd.tag LIKE '%".$this->db->escape($word)."%'";
				}

				if ($implode_product_tag) {
					$sql .= " ".implode(" AND ", $implode_product_tag)."";
				}
			}

			// $log = new \Log('phpner_filter_debug.log');
		 //  $log->write($sql);

			return $this->db->query($sql)->row['total'];
		} else {
			return array();
		}
	}

	public function getFilterManufacturers($global_id, $global_type, $store_id, $customer_group_id, $language_id, $lead_time_status = false) {
		$product_ids = $this->getProductIDs($global_id, $global_type, $store_id, $customer_group_id);

		if ($product_ids) {
			$this->load->model('tool/image');
			$phpner_product_filter_data = $this->config->get('phpner_product_filter_data');

			if ($lead_time_status) {
				$sqlTime = 0;
				$timeStart = microtime(true);
			}

			$manufacturers = $this->cache->get('phpner.product_filter_pids.manufacturers.'.(int)$store_id.'.'.(int)$customer_group_id.'.'.(int)$language_id.'.'.(int)$global_id);
				
			if (!$manufacturers) {
				$manufacturers = array();

				$query = $this->db->query("SELECT DISTINCT fpm.manufacturer_id, fpm.manufacturer_name, fpm.manufacturer_image FROM ".DB_PREFIX."phpner_filter_product_manufacturer fpm WHERE fpm.product_id IN (".implode(',', $product_ids).") AND fpm.language_id = '".(int)$language_id."' ORDER BY fpm.manufacturer_name ASC")->rows;

				
				foreach ($query as $value) {
					$manufacturer_image = ($value['manufacturer_image']) ? $this->model_tool_image->resize($value['manufacturer_image'], $phpner_product_filter_data['manufacturer_image_width'], $phpner_product_filter_data['manufacturer_image_height']) : $this->model_tool_image->resize("placeholder.png", $phpner_product_filter_data['manufacturer_image_width'], $phpner_product_filter_data['manufacturer_image_height']);

					$manufacturers[] = array(
						'manufacturer_id' => $value['manufacturer_id'],
						'name'            => $value['manufacturer_name'],
						'image'           => $manufacturer_image
					);
				}

				$this->cache->set('phpner.product_filter_pids.manufacturers.'.(int)$store_id.'.'.(int)$customer_group_id.'.'.(int)$language_id.'.'.(int)$global_id, $manufacturers);
			}

			if ($lead_time_status) {
				$sqlTime += microtime(true) - $timeStart;
				$log = new \Log('phpner_filter_debug.log');
				$log->write("M query time : ".number_format(($sqlTime), 2)." sec");
			}

			return $manufacturers;
		} else {
			return array();
		}
	}

	public function getFilterTotalManufacturers($global_id, $global_type, $store_id, $customer_group_id, $language_id, $data = array()) {
		$product_ids = $this->getProductIDs($global_id, $global_type, $store_id, $customer_group_id);

		if ($product_ids) {
			$sql = "SELECT COUNT(DISTINCT p.product_id) AS total, fpm.manufacturer_id FROM ".DB_PREFIX."phpner_filter_product_manufacturer fpm ";
			
			$sql .= "INNER JOIN ".DB_PREFIX."product p USING (product_id) ";

			if (isset($data['tag']) && !empty($data['tag'])) {
				$sql .= " INNER JOIN ".DB_PREFIX."product_description pd USING (product_id)";
			}

			if (isset($data['sticker']) && !empty($data['sticker'])) {
				$sql .= " INNER JOIN ".DB_PREFIX."phpner_filter_product_sticker fpst USING (product_id)";
			}

			if (isset($data['option']) && !empty($data['option'])) {
				$sql .= " INNER JOIN ".DB_PREFIX."phpner_filter_product_option fpo USING (product_id)";
			}

			if (isset($data['attribute']) && !empty($data['attribute'])) {
				$sql .= " INNER JOIN ".DB_PREFIX."phpner_filter_product_attribute fpa USING (product_id)";
			}

			if (isset($data['standard']) && !empty($data['standard'])) {
				$sql .= " INNER JOIN ".DB_PREFIX."phpner_filter_product_standard fpsd USING (product_id)";
			}

			$sql .= " WHERE fpm.product_id IN (".implode(',', $product_ids).") AND fpm.language_id = '".(int)$language_id."'";
			
			if (isset($data['low_price']) && (isset($data['high_price']) && !empty($data['high_price']))) {
				$sql .= " AND ";
				/* 3359 */
				if (isset($data['special_only']) && !empty($data['special_only'])) {
					$sql .= "((SELECT ps.price FROM ".DB_PREFIX."product_special ps WHERE ps.product_id = p.product_id AND ps.customer_group_id = '".(int)$data['filter_data']['customer_group_id']."' AND ((ps.date_start = '0000-00-00' OR ps.date_start < NOW()) AND (ps.date_end = '0000-00-00' OR ps.date_end > NOW())) ORDER BY ps.priority ASC, ps.price ASC LIMIT 1) BETWEEN ".(float)$data['low_price']." AND ".(float)$data['high_price'].")";
				} else {
					$sql .= "((CASE WHEN(SELECT price FROM ".DB_PREFIX."product_special ps WHERE ps.product_id = p.product_id AND ps.customer_group_id = '".(int)$data['filter_data']['customer_group_id']."' AND ((ps.date_start = '0000-00-00' OR ps.date_start < NOW()) AND (ps.date_end = '0000-00-00' OR ps.date_end > NOW())) ORDER BY ps.priority ASC, ps.price ASC LIMIT 1) > 0 THEN (SELECT price FROM ".DB_PREFIX."product_special ps WHERE ps.product_id = p.product_id AND ps.customer_group_id = '".(int)$data['filter_data']['customer_group_id']."' AND ((ps.date_start = '0000-00-00' OR ps.date_start < NOW()) AND (ps.date_end = '0000-00-00' OR ps.date_end > NOW())) ORDER BY ps.priority ASC, ps.price ASC LIMIT 1) ELSE p.price END) BETWEEN ".(float)$data['low_price']." AND ".(float)$data['high_price'].")";
				}
				/* 3359 */
			}

			if (isset($data['stock']) && !empty($data['stock'])) {
				$sql .= " ".$data['filter_data']['stock_logic_with_other']." (";

				if (is_array($data['stock'])) {
					$implode_stock = array();

					foreach ($data['stock'] as $stock) {
						if ($stock == 'in_stock') {
							$implode_stock[] = "p.quantity > '0'";
						} elseif($stock == 'out_of_stock') {
							$implode_stock[] = "p.quantity <= '0'";
						} elseif($stock == 'ending_stock') {
							$implode_stock[] = "(p.quantity BETWEEN '0' AND '".(int)$data['filter_data']['stock_ending_value']."')";	
						}
					}

					if ($implode_stock) {
						$sql .= implode(' '.$data['filter_data']['stock_logic_between_stock'].' ', $implode_stock);
					}
				} else {
					if ($data['stock'] == 'in_stock') {
						$sql .= "p.quantity > '0'";
					} elseif($data['stock'] == 'out_of_stock') {
						$sql .= "p.quantity <= '0'";
					} elseif($data['stock'] == 'ending_stock') {
						$sql .= "(p.quantity BETWEEN '0' AND '".(int)$data['filter_data']['stock_ending_value']."')";	
					}
				}
				$sql .= ")";
			}

			if (isset($data['rating']) && !empty($data['rating'])) {
				$implode_rating = array();

				if (is_array($data['rating'])) {
					foreach ($data['rating'] as $rating) {
						$implode_rating[] = "p.product_id IN (SELECT product_id FROM ".DB_PREFIX."review WHERE product_id = p.product_id AND rating = '".$rating."' AND status = '1' GROUP BY rating)";
					}
				} else {
					if ($data['rating']) {
						$implode_rating[] = "p.product_id IN (SELECT product_id FROM ".DB_PREFIX."review WHERE product_id = p.product_id AND rating = '".$data['rating']."' AND status = '1' GROUP BY rating)";
					}
				}

				if ($implode_rating) {
					$sql .= " ".$data['filter_data']['review_logic_with_other']." (" .implode(' '.$data['filter_data']['review_logic_between_review'].' ', $implode_rating) . ")";
				}
			}

			if (isset($data['sticker']) && !empty($data['sticker'])) {
				if ($data['filter_data']['sticker_logic_between_sticker'] == 'AND') {
					$implode_product_stickers = array();

					if (is_array($data['sticker'])) {
						foreach ($data['sticker'] as $product_sticker_id) {
							if ($product_sticker_id) {
								$implode_product_stickers[] = "fpst.product_id IN (SELECT product_id FROM ".DB_PREFIX."phpner_filter_product_sticker WHERE product_id = fpst.product_id AND product_sticker_id = '".(int)$product_sticker_id."' GROUP BY product_sticker_id)";
							}
						}
					} else {
						if ($data['sticker']) {
							$implode_product_stickers[] = "fpst.product_id IN (SELECT product_id FROM ".DB_PREFIX."phpner_filter_product_sticker WHERE product_id = fpst.product_id AND product_sticker_id = '".(int)$data['sticker']."' GROUP BY product_sticker_id)";
						}
					}

					if ($implode_product_stickers) {
						$sql .= " ".$data['filter_data']['sticker_logic_with_other']." (" . implode(' AND ', $implode_product_stickers) . ")";
					}
				} else {
					if (is_array($data['sticker'])) {
						$implode_product_stickers = array();

						foreach ($data['sticker'] as $product_sticker_id) {
							$implode_product_stickers[] = "fpst.product_sticker_id = '".(int)$product_sticker_id."'";
						}
					} else {
						$implode_product_stickers[] = "fpst.product_sticker_id = '".(int)$data['sticker']."'";
					}

					if ($implode_product_stickers) {
						$sql .= " ".$data['filter_data']['sticker_logic_with_other']." (".implode(' OR ', $implode_product_stickers).")";
					}
				}
			}

			if (isset($data['option']) && !empty($data['option'])) {
				if ($data['filter_data']['option_logic_between_option'] == 'AND') {
					$implode_product_options = array();

					foreach ($data['option'] as $option_name_mod => $option_value_id) {
						if (is_array($option_value_id)) {
							foreach ($option_value_id as $option_value_id_children) {
								if ($option_value_id_children) {
									$implode_product_options[] = "fpo.product_id IN (SELECT product_id FROM ".DB_PREFIX."phpner_filter_product_option WHERE product_id = fpo.product_id AND option_name_mod = '".$this->db->escape($option_name_mod)."' AND option_value_id = '".(int)$option_value_id_children."' GROUP BY option_value_id)";
								}
							}
						} else {
							if ($option_value_id) {
								$implode_product_options[] = "fpo.product_id IN (SELECT product_id FROM ".DB_PREFIX."phpner_filter_product_option WHERE product_id = fpo.product_id AND option_name_mod = '".$this->db->escape($option_name_mod)."' AND option_value_id = '".(int)$option_value_id."' GROUP BY option_value_id)";
							}
						}
					}

					if ($implode_product_options) {
						$sql .= " ".$data['filter_data']['option_logic_with_other']." (" . implode(' AND ', $implode_product_options) . ")";
					}
				} else {
					$implode_product_options = array();

					foreach ($data['option'] as $option_name_mod => $option_value_id) {
						if (is_array($option_value_id)) {
							foreach ($option_value_id as $option_value_id_children) {
								if ($option_value_id_children) {
									$implode_product_options[] = "(fpo.option_name_mod = '".$this->db->escape($option_name_mod)."' AND fpo.option_value_id = '".(int)$option_value_id_children."')";
								}
							}
						} else {
							if ($option_value_id) {
								$implode_product_options[] = "(fpo.option_name_mod = '".$this->db->escape($option_name_mod)."' AND fpo.option_value_id = '".(int)$option_value_id."')";
							}
						}
					}

					if ($implode_product_options) {
						$sql .= " ".$data['filter_data']['option_logic_with_other']." (" . implode(' OR ', $implode_product_options) . ")";
					}
				}
			}

			if (isset($data['attribute']) && !empty($data['attribute'])) {
				if ($data['filter_data']['attribute_logic_between_attribute'] == 'AND') {
					$implode_product_attributes = array();

					foreach ($data['attribute'] as $attribute_name_mod => $attribute_value_mod) {
						if (is_array($attribute_value_mod)) {
							foreach ($attribute_value_mod as $attribute_value_mod_children) {
								if ($attribute_value_mod_children) {
									$implode_product_attributes[] = "fpa.product_id IN (SELECT product_id FROM ".DB_PREFIX."phpner_filter_product_attribute WHERE product_id = fpa.product_id AND attribute_name_mod = '".$this->db->escape($attribute_name_mod)."' AND attribute_value_mod = '".$this->db->escape($attribute_value_mod_children)."' GROUP BY attribute_value_mod)";
								}
							}
						} else {
							if ($attribute_value_mod) {
								$implode_product_attributes[] = "fpa.product_id = (SELECT product_id FROM ".DB_PREFIX."phpner_filter_product_attribute WHERE product_id = fpa.product_id AND attribute_name_mod = '".$this->db->escape($attribute_name_mod)."' AND attribute_value_mod IN ('".$this->db->escape($attribute_value_mod)."') GROUP BY attribute_value_mod)";
							}
						}
					}

					if ($implode_product_attributes) {
						$sql .= " ".$data['filter_data']['attribute_logic_with_other']." (" . implode(' AND ', $implode_product_attributes) . ")";
					}
				} else {
					$implode_product_attributes = array();

					foreach ($data['attribute'] as $attribute_name_mod => $attribute_value_mod) {
						if (is_array($attribute_value_mod)) {
							foreach ($attribute_value_mod as $attribute_value_mod_children) {
								if ($attribute_value_mod_children) {
									$implode_product_attributes[] = "(fpa.attribute_name_mod = '".$this->db->escape($attribute_name_mod)."' AND fpa.attribute_value_mod = '".$this->db->escape($attribute_value_mod_children)."')";
								}
							}
						} else {
							if ($attribute_value_mod) {
								$implode_product_attributes[] = "(fpa.attribute_name_mod = '".$this->db->escape($attribute_name_mod)."' AND fpa.attribute_value_mod = '".$this->db->escape($attribute_value_mod)."')";
							}
						}
					}

					if ($implode_product_attributes) {
						$sql .= " ".$data['filter_data']['attribute_logic_with_other']." (" . implode(' OR ', $implode_product_attributes) . ")";
					}
				}
			}

			if (isset($data['standard']) && !empty($data['standard'])) {
				if ($data['filter_data']['standard_logic_between_standard'] == 'AND') {
					$implode_product_standards = array();

					foreach ($data['standard'] as $filter_name_mod => $filter_value_mod) {
						if (is_array($filter_value_mod)) {
							foreach ($filter_value_mod as $filter_value_mod_children) {
								if ($filter_value_mod_children) {
									$implode_product_standards[] = "fpsd.product_id IN (SELECT product_id FROM ".DB_PREFIX."phpner_filter_product_standard WHERE product_id = fpsd.product_id AND filter_name_mod = '".$this->db->escape($filter_name_mod)."' AND filter_value_mod = '".$this->db->escape($filter_value_mod_children)."' GROUP BY filter_value_mod)";
								}
							}
						} else {
							if ($filter_value_mod) {
								$implode_product_standards[] = "fpsd.product_id = (SELECT product_id FROM ".DB_PREFIX."phpner_filter_product_standard WHERE product_id = fpsd.product_id AND filter_name_mod = '".$this->db->escape($filter_name_mod)."' AND filter_value_mod IN ('".$this->db->escape($filter_value_mod)."') GROUP BY filter_value_mod)";
							}
						}
					}

					if ($implode_product_standards) {
						$sql .= " ".$data['filter_data']['standard_logic_with_other']." (" . implode(' AND ', $implode_product_standards) . ")";
					}
				} else {
					$implode_product_standards = array();

					foreach ($data['standard'] as $filter_name_mod => $filter_value_mod) {
						if (is_array($filter_value_mod)) {
							foreach ($filter_value_mod as $filter_value_mod_children) {
								if ($filter_value_mod_children) {
									$implode_product_standards[] = "(fpsd.filter_name_mod = '".$this->db->escape($filter_name_mod)."' AND fpsd.filter_value_mod = '".$this->db->escape($filter_value_mod_children)."')";
								}
							}
						} else {
							if ($filter_value_mod) {
								$implode_product_standards[] = "(fpsd.filter_name_mod = '".$this->db->escape($filter_name_mod)."' AND fpsd.filter_value_mod = '".$this->db->escape($filter_value_mod)."')";
							}
						}
					}

					if ($implode_product_standards) {
						$sql .= " ".$data['filter_data']['standard_logic_with_other']." (" . implode(' OR ', $implode_product_standards) . ")";
					}
				}
			}

			if (isset($data['tag']) && !empty($data['tag'])) {
				$sql .= " ".$data['filter_data']['tag_logic_with_other']." ";

				$implode_product_tag = array();
			
				$words = explode(' ', trim(preg_replace('/\s+/', ' ', $data['tag'])));
				
				foreach ($words as $word) {
					$implode_product_tag[] = "pd.tag LIKE '%".$this->db->escape($word)."%'";
				}

				if ($implode_product_tag) {
					$sql .= " ".implode(" AND ", $implode_product_tag)."";
				}

				$sql .= " AND pd.language_id = '".(int)$data['filter_data']['language_id']."'";
			}

			$sql .= " GROUP BY fpm.manufacturer_id";

			// $log = new \Log('phpner_filter_debug.log');
		 //  $log->write($sql);

			$query = $this->db->query($sql)->rows;

			$result = array();

			foreach ($query as $value) {
				$result[$value['manufacturer_id']] = $value['total'];
			}

			return $result;
		} else {
			return array();
		}
	}

	public function getFilterAttributes($global_id, $global_type, $store_id, $customer_group_id, $language_id, $lead_time_status = false) {
		$product_ids = $this->getProductIDs($global_id, $global_type, $store_id, $customer_group_id);

		if ($product_ids) {
			if ($lead_time_status) {
				$sqlTime = 0;
				$timeStart = microtime(true);
			}

			$attributes = $this->cache->get('phpner.product_filter_pids.attribute.'.(int)$store_id.'.'.(int)$customer_group_id.'.'.(int)$language_id.'.'.(int)$global_id);

			if (!$attributes) {
				$attributes = array();

				$query = $this->db->query("SELECT DISTINCT fpa.attribute_name, fpa.attribute_id, fpa.attribute_name_mod, fpa.attribute_group_id FROM ".DB_PREFIX."phpner_filter_product_attribute fpa WHERE fpa.product_id IN (".implode(',', $product_ids).") AND fpa.language_id = '".(int)$language_id."' ORDER BY fpa.sort_order, fpa.attribute_name ASC")->rows;

				foreach ($query as $value) {
					$attributes[] = array(
						'attribute_id'       => $value['attribute_id'],
						'attribute_name_mod' => $value['attribute_name_mod'],
						'attribute_group_id' => $value['attribute_group_id'],
						'name'               => $value['attribute_name'],
						'values'             => $this->getFilterAttributeValues($value['attribute_name'], $global_id, $global_type, $store_id, $customer_group_id, $language_id)
					);
				}

				$this->cache->set('phpner.product_filter_pids.attribute.'.(int)$store_id.'.'.(int)$customer_group_id.'.'.(int)$language_id.'.'.(int)$global_id, $attributes);
			}

			if ($lead_time_status) {
				$sqlTime += microtime(true) - $timeStart;
				$log = new \Log('phpner_filter_debug.log');
				$log->write("A query time : ".number_format(($sqlTime), 2)." sec");
			}

			return $attributes;
		} else {
			return array();
		}
	}

	public function getFilterAttributeValues($attribute_name, $global_id, $global_type, $store_id, $customer_group_id, $language_id) {
		$product_ids = $this->getProductIDs($global_id, $global_type, $store_id, $customer_group_id);

		if ($product_ids) {
			$query = $this->db->query("SELECT DISTINCT fpa.attribute_value_mod, fpa.attribute_value  FROM ".DB_PREFIX."phpner_filter_product_attribute fpa WHERE fpa.product_id IN (".implode(',', $product_ids).") AND fpa.language_id = '".(int)$language_id."' AND fpa.attribute_name = '".$this->db->escape($attribute_name)."' GROUP BY fpa.attribute_value ORDER BY CAST(fpa.attribute_value_mod AS SIGNED) ASC")->rows;

			$result = array();

			foreach ($query as $value) {
				$result[] = array(
					'attribute_value'     => $value['attribute_value'],
					'attribute_value_mod' => $value['attribute_value_mod']
				);
			}

			return $result;
		} else {
			return array();
		}
	}

	public function getFilterTotalAttributeValues($global_id, $global_type, $store_id, $customer_group_id, $language_id, $data = array()) {
		$product_ids = $this->getProductIDs($global_id, $global_type, $store_id, $customer_group_id);

		if ($product_ids) {
			$sql = "SELECT COUNT(DISTINCT p.product_id) AS total, fpa.attribute_name_mod, fpa.attribute_group_id, fpa.attribute_value_mod FROM ".DB_PREFIX."phpner_filter_product_attribute fpa ";

			$sql .= "INNER JOIN ".DB_PREFIX."product p USING (product_id) ";

			if (isset($data['tag']) && !empty($data['tag'])) {
				$sql .= " INNER JOIN ".DB_PREFIX."product_description pd USING (product_id)";
			}

			if (isset($data['sticker']) && !empty($data['sticker'])) {
				$sql .= " INNER JOIN ".DB_PREFIX."phpner_filter_product_sticker fpst USING (product_id)";
			}

			if (isset($data['option']) && !empty($data['option'])) {
				$sql .= " INNER JOIN ".DB_PREFIX."phpner_filter_product_option fpo USING (product_id)";
			}

			if (isset($data['standard']) && !empty($data['standard'])) {
				$sql .= " INNER JOIN ".DB_PREFIX."phpner_filter_product_standard fpsd USING (product_id)";
			}

			$sql .= " WHERE fpa.product_id IN (".implode(',', $product_ids).") AND fpa.language_id = '".(int)$language_id."' ";

			if (isset($data['attribute']) && !empty($data['attribute'])) {
				if ($data['filter_data']['attribute_logic_between_attribute'] == 'AND') {
					$implode_product_attributes = array();

					foreach ($data['attribute'] as $attribute_name_mod => $attribute_value_mod) {
						if (is_array($attribute_value_mod)) {
							foreach ($attribute_value_mod as $attribute_value_mod_children) {
								if ($attribute_value_mod_children) {
									$implode_product_attributes[] = "fpa.product_id IN (SELECT product_id FROM ".DB_PREFIX."phpner_filter_product_attribute WHERE product_id = fpa.product_id AND attribute_name_mod = '".$this->db->escape($attribute_name_mod)."' AND attribute_value_mod = '".$this->db->escape($attribute_value_mod_children)."' GROUP BY attribute_value_mod)";
								}
							}
						} else {
							if ($attribute_value_mod) {
								$implode_product_attributes[] = "fpa.product_id IN (SELECT product_id FROM ".DB_PREFIX."phpner_filter_product_attribute WHERE product_id = fpa.product_id AND attribute_name_mod = '".$this->db->escape($attribute_name_mod)."' AND attribute_value_mod = '".$this->db->escape($attribute_value_mod)."' GROUP BY attribute_value_mod)";
							}
						}
					}

					if ($implode_product_attributes) {
						$sql .= $data['filter_data']['attribute_logic_with_other']." (" . implode(' AND ', $implode_product_attributes) . ")";
					}
				}
			}

			if (isset($data['low_price']) && (isset($data['high_price']) && !empty($data['high_price']))) {
				$sql .= " AND ";
				/* 3359 */
				if (isset($data['special_only']) && !empty($data['special_only'])) {
					$sql .= "((SELECT ps.price FROM ".DB_PREFIX."product_special ps WHERE ps.product_id = p.product_id AND ps.customer_group_id = '".(int)$data['filter_data']['customer_group_id']."' AND ((ps.date_start = '0000-00-00' OR ps.date_start < NOW()) AND (ps.date_end = '0000-00-00' OR ps.date_end > NOW())) ORDER BY ps.priority ASC, ps.price ASC LIMIT 1) BETWEEN ".(float)$data['low_price']." AND ".(float)$data['high_price'].")";
				} else {
					$sql .= "((CASE WHEN(SELECT price FROM ".DB_PREFIX."product_special ps WHERE ps.product_id = p.product_id AND ps.customer_group_id = '".(int)$data['filter_data']['customer_group_id']."' AND ((ps.date_start = '0000-00-00' OR ps.date_start < NOW()) AND (ps.date_end = '0000-00-00' OR ps.date_end > NOW())) ORDER BY ps.priority ASC, ps.price ASC LIMIT 1) > 0 THEN (SELECT price FROM ".DB_PREFIX."product_special ps WHERE ps.product_id = p.product_id AND ps.customer_group_id = '".(int)$data['filter_data']['customer_group_id']."' AND ((ps.date_start = '0000-00-00' OR ps.date_start < NOW()) AND (ps.date_end = '0000-00-00' OR ps.date_end > NOW())) ORDER BY ps.priority ASC, ps.price ASC LIMIT 1) ELSE p.price END) BETWEEN ".(float)$data['low_price']." AND ".(float)$data['high_price'].")";
				}
				/* 3359 */
			}

			if (isset($data['manufacturer']) && !empty($data['manufacturer'])) {
				$sql .= " ".$data['filter_data']['manufacturer_logic_with_other']." (";

				if (is_array($data['manufacturer'])) {
					$implode_manufacturer = array();

					foreach ($data['manufacturer'] as $manufacturer) {
						$implode_manufacturer[] = "p.manufacturer_id = '".(int)$manufacturer."'";
					}

					if ($implode_manufacturer) {
						$sql .= "(".implode(' OR ', $implode_manufacturer).")";
					}
				} else {
					$sql .= "p.manufacturer_id = '".(int)$data['manufacturer']."'";
				}
				$sql .= ")";
			}

			if (isset($data['stock']) && !empty($data['stock'])) {
				$sql .= " ".$data['filter_data']['stock_logic_with_other']." (";

				if (is_array($data['stock'])) {
					$implode_stock = array();

					foreach ($data['stock'] as $stock) {
						if ($stock == 'in_stock') {
							$implode_stock[] = "p.quantity > '0'";
						} elseif($stock == 'out_of_stock') {
							$implode_stock[] = "p.quantity <= '0'";
						} elseif($stock == 'ending_stock') {
							$implode_stock[] = "(p.quantity BETWEEN '0' AND '".(int)$data['filter_data']['stock_ending_value']."')";	
						}
					}

					if ($implode_stock) {
						$sql .= implode(' '.$data['filter_data']['stock_logic_between_stock'].' ', $implode_stock);
					}
				} else {
					if ($data['stock'] == 'in_stock') {
						$sql .= "p.quantity > '0'";
					} elseif($data['stock'] == 'out_of_stock') {
						$sql .= "p.quantity <= '0'";
					} elseif($data['stock'] == 'ending_stock') {
						$sql .= "(p.quantity BETWEEN '0' AND '".(int)$data['filter_data']['stock_ending_value']."')";	
					}
				}
				$sql .= ")";
			}

			if (isset($data['rating']) && !empty($data['rating'])) {
				$implode_rating = array();

				if (is_array($data['rating'])) {
					foreach ($data['rating'] as $rating) {
						$implode_rating[] = "p.product_id IN (SELECT product_id FROM ".DB_PREFIX."review WHERE product_id = p.product_id AND rating = '".$rating."' AND status = '1' GROUP BY rating)";
					}
				} else {
					if ($data['rating']) {
						$implode_rating[] = "p.product_id IN (SELECT product_id FROM ".DB_PREFIX."review WHERE product_id = p.product_id AND rating = '".$data['rating']."' AND status = '1' GROUP BY rating)";
					}
				}

				if ($implode_rating) {
					$sql .= " ".$data['filter_data']['review_logic_with_other']." (" .implode(' '.$data['filter_data']['review_logic_between_review'].' ', $implode_rating) . ")";
				}
			}

			if (isset($data['sticker']) && !empty($data['sticker'])) {
				if ($data['filter_data']['sticker_logic_between_sticker'] == 'AND') {
					$implode_product_stickers = array();

					if (is_array($data['sticker'])) {
						foreach ($data['sticker'] as $product_sticker_id) {
							if ($product_sticker_id) {
								$implode_product_stickers[] = "fpst.product_id IN (SELECT product_id FROM ".DB_PREFIX."phpner_filter_product_sticker WHERE product_id = fpst.product_id AND product_sticker_id = '".(int)$product_sticker_id."' GROUP BY product_sticker_id)";
							}
						}
					} else {
						if ($data['sticker']) {
							$implode_product_stickers[] = "fpst.product_id IN (SELECT product_id FROM ".DB_PREFIX."phpner_filter_product_sticker WHERE product_id = fpst.product_id AND product_sticker_id = '".(int)$data['sticker']."' GROUP BY product_sticker_id)";
						}
					}

					if ($implode_product_stickers) {
						$sql .= " ".$data['filter_data']['sticker_logic_with_other']." (" . implode(' AND ', $implode_product_stickers) . ")";
					}
				} else {
					if (is_array($data['sticker'])) {
						$implode_product_stickers = array();

						foreach ($data['sticker'] as $product_sticker_id) {
							$implode_product_stickers[] = "fpst.product_sticker_id = '".(int)$product_sticker_id."'";
						}
					} else {
						$implode_product_stickers[] = "fpst.product_sticker_id = '".(int)$data['sticker']."'";
					}

					if ($implode_product_stickers) {
						$sql .= " ".$data['filter_data']['sticker_logic_with_other']." (".implode(' OR ', $implode_product_stickers).")";
					}
				}
			}

			if (isset($data['option']) && !empty($data['option'])) {
				if ($data['filter_data']['option_logic_between_option'] == 'AND') {
					$implode_product_options = array();

					foreach ($data['option'] as $option_name_mod => $option_value_id) {
						if (is_array($option_value_id)) {
							foreach ($option_value_id as $option_value_id_children) {
								if ($option_value_id_children) {
									$implode_product_options[] = "fpo.product_id IN (SELECT product_id FROM ".DB_PREFIX."phpner_filter_product_option WHERE product_id = fpo.product_id AND option_name_mod = '".$this->db->escape($option_name_mod)."' AND option_value_id = '".(int)$option_value_id_children."' GROUP BY option_value_id)";
								}
							}
						} else {
							if ($option_value_id) {
								$implode_product_options[] = "fpo.product_id IN (SELECT product_id FROM ".DB_PREFIX."phpner_filter_product_option WHERE product_id = fpo.product_id AND option_name_mod = '".$this->db->escape($option_name_mod)."' AND option_value_id = '".(int)$option_value_id."' GROUP BY option_value_id)";
							}
						}
					}

					if ($implode_product_options) {
						$sql .= " ".$data['filter_data']['option_logic_with_other']." (" . implode(' AND ', $implode_product_options) . ")";
					}
				} else {
					$implode_product_options = array();

					foreach ($data['option'] as $option_name_mod => $option_value_id) {
						if (is_array($option_value_id)) {
							foreach ($option_value_id as $option_value_id_children) {
								if ($option_value_id_children) {
									$implode_product_options[] = "(fpo.option_name_mod = '".$this->db->escape($option_name_mod)."' AND fpo.option_value_id = '".(int)$option_value_id_children."')";
								}
							}
						} else {
							if ($option_value_id) {
								$implode_product_options[] = "(fpo.option_name_mod = '".$this->db->escape($option_name_mod)."' AND fpo.option_value_id = '".(int)$option_value_id."')";
							}
						}
					}

					if ($implode_product_options) {
						$sql .= " ".$data['filter_data']['option_logic_with_other']." (" . implode(' OR ', $implode_product_options) . ")";
					}
				}
			}

			if (isset($data['standard']) && !empty($data['standard'])) {
				if ($data['filter_data']['standard_logic_between_standard'] == 'AND') {
					$implode_product_standards = array();

					foreach ($data['standard'] as $filter_name_mod => $filter_value_mod) {
						if (is_array($filter_value_mod)) {
							foreach ($filter_value_mod as $filter_value_mod_children) {
								if ($filter_value_mod_children) {
									$implode_product_standards[] = "fpsd.product_id IN (SELECT product_id FROM ".DB_PREFIX."phpner_filter_product_standard WHERE product_id = fpsd.product_id AND filter_name_mod = '".$this->db->escape($filter_name_mod)."' AND filter_value_mod = '".$this->db->escape($filter_value_mod_children)."' GROUP BY filter_value_mod)";
								}
							}
						} else {
							if ($filter_value_mod) {
								$implode_product_standards[] = "fpsd.product_id = (SELECT product_id FROM ".DB_PREFIX."phpner_filter_product_standard WHERE product_id = fpsd.product_id AND filter_name_mod = '".$this->db->escape($filter_name_mod)."' AND filter_value_mod IN ('".$this->db->escape($filter_value_mod)."') GROUP BY filter_value_mod)";
							}
						}
					}

					if ($implode_product_standards) {
						$sql .= " ".$data['filter_data']['standard_logic_with_other']." (" . implode(' AND ', $implode_product_standards) . ")";
					}
				} else {
					$implode_product_standards = array();

					foreach ($data['standard'] as $filter_name_mod => $filter_value_mod) {
						if (is_array($filter_value_mod)) {
							foreach ($filter_value_mod as $filter_value_mod_children) {
								if ($filter_value_mod_children) {
									$implode_product_standards[] = "(fpsd.filter_name_mod = '".$this->db->escape($filter_name_mod)."' AND fpsd.filter_value_mod = '".$this->db->escape($filter_value_mod_children)."')";
								}
							}
						} else {
							if ($filter_value_mod) {
								$implode_product_standards[] = "(fpsd.filter_name_mod = '".$this->db->escape($filter_name_mod)."' AND fpsd.filter_value_mod = '".$this->db->escape($filter_value_mod)."')";
							}
						}
					}

					if ($implode_product_standards) {
						$sql .= " ".$data['filter_data']['standard_logic_with_other']." (" . implode(' OR ', $implode_product_standards) . ")";
					}
				}
			}

			if (isset($data['tag']) && !empty($data['tag'])) {
				$sql .= " ".$data['filter_data']['tag_logic_with_other']." ";

				$implode_product_tag = array();
			
				$words = explode(' ', trim(preg_replace('/\s+/', ' ', $data['tag'])));
				
				foreach ($words as $word) {
					$implode_product_tag[] = "pd.tag LIKE '%".$this->db->escape($word)."%'";
				}

				if ($implode_product_tag) {
					$sql .= " ".implode(" AND ", $implode_product_tag)."";
				}

				$sql .= " AND pd.language_id = '".(int)$data['filter_data']['language_id']."'";
			}

			$sql .= " GROUP BY fpa.attribute_value_mod";

			// $log = new \Log('phpner_filter_debug.log');
		 //  $log->write($sql);

			$query = $this->db->query($sql)->rows;

			$result = array();

			foreach ($query as $value) {
				$result[$value['attribute_group_id']][$value['attribute_name_mod']][$value['attribute_value_mod']] = $value['total'];
			}

			return $result;
		} else {
			return array();
		}
	}

	public function getFilterOptions($global_id, $global_type, $store_id, $customer_group_id, $language_id, $lead_time_status = false) {
		$product_ids = $this->getProductIDs($global_id, $global_type, $store_id, $customer_group_id);

		if ($product_ids) {
			if ($lead_time_status) {
				$sqlTime = 0;
				$timeStart = microtime(true);
			}

			$options = $this->cache->get('phpner.product_filter_pids.option.'.(int)$store_id.'.'.(int)$customer_group_id.'.'.(int)$language_id.'.'.(int)$global_id);
				
			if (!$options) {
				$options = array();

				$query = $this->db->query("SELECT DISTINCT fpo.option_name, fpo.option_name_mod, fpo.option_id FROM ".DB_PREFIX."phpner_filter_product_option fpo WHERE fpo.product_id IN (".implode(',', $product_ids).") AND fpo.language_id = '".(int)$language_id."' ORDER BY fpo.option_name ASC")->rows;

				foreach ($query as $value) {
					$options[] = array(
						'option_id'       => $value['option_id'],
						'name'            => $value['option_name'],
						'option_name_mod' => $value['option_name_mod'],
						'values'          => $this->getFilterOptionValues($value['option_name'], $global_id, $global_type, $store_id, $customer_group_id, $language_id)
					);
				}

				$this->cache->set('phpner.product_filter_pids.option.'.(int)$store_id.'.'.(int)$customer_group_id.'.'.(int)$language_id.'.'.(int)$global_id, $options);
			}

			if ($lead_time_status) {
				$sqlTime += microtime(true) - $timeStart;
				$log = new \Log('phpner_filter_debug.log');
				$log->write("O query time : ".number_format(($sqlTime), 2)." sec");
			}

			return $options;
		} else {
			return array();
		}
	}

	public function getFilterOptionValues($option_name, $global_id, $global_type, $store_id, $customer_group_id, $language_id) {
		$product_ids = $this->getProductIDs($global_id, $global_type, $store_id, $customer_group_id);

		if ($product_ids) {
			$this->load->model('tool/image');
			$phpner_product_filter_data = $this->config->get('phpner_product_filter_data');
			
			$query = $this->db->query("SELECT fpo.option_value_name, fpo.option_value_name_mod, fpo.option_value_id, fpo.option_value_image FROM ".DB_PREFIX."phpner_filter_product_option fpo WHERE fpo.product_id IN (".implode(',', $product_ids).") AND fpo.language_id = '".(int)$language_id."' AND fpo.option_name = '".$this->db->escape($option_name)."' GROUP BY fpo.option_value_name ORDER BY CAST(fpo.option_value_name AS SIGNED) ASC")->rows;

			$result = array();

			foreach ($query as $value) {
				$option_value_image = ($value['option_value_image']) ? $this->model_tool_image->resize($value['option_value_image'], $phpner_product_filter_data['option_image_width'], $phpner_product_filter_data['option_image_height']) : $this->model_tool_image->resize("placeholder.png", $phpner_product_filter_data['option_image_width'], $phpner_product_filter_data['option_image_height']);

				$result[] = array(
					'option_value_id'       => $value['option_value_id'],
					'option_value_name'     => $value['option_value_name'],
					'option_value_name_mod' => $value['option_value_name_mod'],
					'option_value_image'    => $option_value_image
				);
			}

			return $result;
		} else {
			return array();
		}
	}

	public function getFilterTotalOptionValues($global_id, $global_type, $store_id, $customer_group_id, $language_id, $data = array()) {
		$product_ids = $this->getProductIDs($global_id, $global_type, $store_id, $customer_group_id);

		if ($product_ids) {
			$sql = "SELECT COUNT(DISTINCT p.product_id) AS total, fpo.option_name_mod, fpo.option_value_id FROM ".DB_PREFIX."phpner_filter_product_option fpo ";

			$sql .= "INNER JOIN ".DB_PREFIX."product p USING (product_id) ";

			if (isset($data['tag']) && !empty($data['tag'])) {
				$sql .= " INNER JOIN ".DB_PREFIX."product_description pd USING (product_id)";
			}

			if (isset($data['sticker']) && !empty($data['sticker'])) {
				$sql .= " INNER JOIN ".DB_PREFIX."phpner_filter_product_sticker fpst USING (product_id)";
			}

			if (isset($data['attribute']) && !empty($data['attribute'])) {
				$sql .= " INNER JOIN ".DB_PREFIX."phpner_filter_product_attribute fpa USING (product_id)";
			}

			if (isset($data['standard']) && !empty($data['standard'])) {
				$sql .= " INNER JOIN ".DB_PREFIX."phpner_filter_product_standard fpsd USING (product_id)";
			}

			$sql .= "WHERE fpo.product_id IN (".implode(',', $product_ids).") AND fpo.language_id = '".(int)$language_id."'";

			if (isset($data['option']) && !empty($data['option'])) {
				if ($data['filter_data']['option_logic_between_option'] == 'AND') {
					$implode_product_options = array();

					foreach ($data['option'] as $option_name_mod => $option_value_id) {
						if (is_array($option_value_id)) {
							foreach ($option_value_id as $option_value_id_children) {
								if ($option_value_id_children) {
									$implode_product_options[] = "fpo.product_id IN (SELECT product_id FROM ".DB_PREFIX."phpner_filter_product_option WHERE product_id = fpo.product_id AND option_name_mod = '".$this->db->escape($option_name_mod)."' AND option_value_id = '".(int)$option_value_id_children."' GROUP BY option_value_id)";
								}
							}
						} else {
							if ($option_value_id) {
								$implode_product_options[] = "fpo.product_id IN (SELECT product_id FROM ".DB_PREFIX."phpner_filter_product_option WHERE product_id = fpo.product_id AND option_name_mod = '".$this->db->escape($option_name_mod)."' AND option_value_id = '".(int)$option_value_id."' GROUP BY option_value_id)";
							}
						}
					}

					if ($implode_product_options) {
						$sql .= $data['filter_data']['option_logic_with_other']." (" . implode(' AND ', $implode_product_options) . ")";
					}
				}
			}

			if (isset($data['low_price']) && (isset($data['high_price']) && !empty($data['high_price']))) {
				$sql .= " AND ";
				/* 3359 */
				if (isset($data['special_only']) && !empty($data['special_only'])) {
					$sql .= "((SELECT ps.price FROM ".DB_PREFIX."product_special ps WHERE ps.product_id = p.product_id AND ps.customer_group_id = '".(int)$data['filter_data']['customer_group_id']."' AND ((ps.date_start = '0000-00-00' OR ps.date_start < NOW()) AND (ps.date_end = '0000-00-00' OR ps.date_end > NOW())) ORDER BY ps.priority ASC, ps.price ASC LIMIT 1) BETWEEN ".(float)$data['low_price']." AND ".(float)$data['high_price'].")";
				} else {
					$sql .= "((CASE WHEN(SELECT price FROM ".DB_PREFIX."product_special ps WHERE ps.product_id = p.product_id AND ps.customer_group_id = '".(int)$data['filter_data']['customer_group_id']."' AND ((ps.date_start = '0000-00-00' OR ps.date_start < NOW()) AND (ps.date_end = '0000-00-00' OR ps.date_end > NOW())) ORDER BY ps.priority ASC, ps.price ASC LIMIT 1) > 0 THEN (SELECT price FROM ".DB_PREFIX."product_special ps WHERE ps.product_id = p.product_id AND ps.customer_group_id = '".(int)$data['filter_data']['customer_group_id']."' AND ((ps.date_start = '0000-00-00' OR ps.date_start < NOW()) AND (ps.date_end = '0000-00-00' OR ps.date_end > NOW())) ORDER BY ps.priority ASC, ps.price ASC LIMIT 1) ELSE p.price END) BETWEEN ".(float)$data['low_price']." AND ".(float)$data['high_price'].")";
				}
				/* 3359 */
			}

			if (isset($data['manufacturer']) && !empty($data['manufacturer'])) {
				$sql .= " ".$data['filter_data']['manufacturer_logic_with_other']." (";

				if (is_array($data['manufacturer'])) {
					$implode_manufacturer = array();

					foreach ($data['manufacturer'] as $manufacturer) {
						$implode_manufacturer[] = "p.manufacturer_id = '".(int)$manufacturer."'";
					}

					if ($implode_manufacturer) {
						$sql .= "(".implode(' OR ', $implode_manufacturer).")";
					}
				} else {
					$sql .= "p.manufacturer_id = '".(int)$data['manufacturer']."'";
				}
				$sql .= ")";
			}

			if (isset($data['stock']) && !empty($data['stock'])) {
				$sql .= " ".$data['filter_data']['stock_logic_with_other']." (";

				if (is_array($data['stock'])) {
					$implode_stock = array();

					foreach ($data['stock'] as $stock) {
						if ($stock == 'in_stock') {
							$implode_stock[] = "p.quantity > '0'";
						} elseif($stock == 'out_of_stock') {
							$implode_stock[] = "p.quantity <= '0'";
						} elseif($stock == 'ending_stock') {
							$implode_stock[] = "(p.quantity BETWEEN '0' AND '".(int)$data['filter_data']['stock_ending_value']."')";	
						}
					}

					if ($implode_stock) {
						$sql .= implode(' '.$data['filter_data']['stock_logic_between_stock'].' ', $implode_stock);
					}
				} else {
					if ($data['stock'] == 'in_stock') {
						$sql .= "p.quantity > '0'";
					} elseif($data['stock'] == 'out_of_stock') {
						$sql .= "p.quantity <= '0'";
					} elseif($data['stock'] == 'ending_stock') {
						$sql .= "(p.quantity BETWEEN '0' AND '".(int)$data['filter_data']['stock_ending_value']."')";	
					}
				}
				$sql .= ")";
			}

			if (isset($data['rating']) && !empty($data['rating'])) {
				$implode_rating = array();

				if (is_array($data['rating'])) {
					foreach ($data['rating'] as $rating) {
						$implode_rating[] = "p.product_id IN (SELECT product_id FROM ".DB_PREFIX."review WHERE product_id = p.product_id AND rating = '".$rating."' AND status = '1' GROUP BY rating)";
					}
				} else {
					if ($data['rating']) {
						$implode_rating[] = "p.product_id IN (SELECT product_id FROM ".DB_PREFIX."review WHERE product_id = p.product_id AND rating = '".$data['rating']."' AND status = '1' GROUP BY rating)";
					}
				}

				if ($implode_rating) {
					$sql .= " ".$data['filter_data']['review_logic_with_other']." (" .implode(' '.$data['filter_data']['review_logic_between_review'].' ', $implode_rating) . ")";
				}
			}

			if (isset($data['sticker']) && !empty($data['sticker'])) {
				if ($data['filter_data']['sticker_logic_between_sticker'] == 'AND') {
					$implode_product_stickers = array();

					if (is_array($data['sticker'])) {
						foreach ($data['sticker'] as $product_sticker_id) {
							if ($product_sticker_id) {
								$implode_product_stickers[] = "fpst.product_id IN (SELECT product_id FROM ".DB_PREFIX."phpner_filter_product_sticker WHERE product_id = fpst.product_id AND product_sticker_id = '".(int)$product_sticker_id."' GROUP BY product_sticker_id)";
							}
						}
					} else {
						if ($data['sticker']) {
							$implode_product_stickers[] = "fpst.product_id IN (SELECT product_id FROM ".DB_PREFIX."phpner_filter_product_sticker WHERE product_id = fpst.product_id AND product_sticker_id = '".(int)$data['sticker']."' GROUP BY product_sticker_id)";
						}
					}

					if ($implode_product_stickers) {
						$sql .= " ".$data['filter_data']['sticker_logic_with_other']." (" . implode(' AND ', $implode_product_stickers) . ")";
					}
				} else {
					if (is_array($data['sticker'])) {
						$implode_product_stickers = array();

						foreach ($data['sticker'] as $product_sticker_id) {
							$implode_product_stickers[] = "fpst.product_sticker_id = '".(int)$product_sticker_id."'";
						}
					} else {
						$implode_product_stickers[] = "fpst.product_sticker_id = '".(int)$data['sticker']."'";
					}

					if ($implode_product_stickers) {
						$sql .= " ".$data['filter_data']['sticker_logic_with_other']." (".implode(' OR ', $implode_product_stickers).")";
					}
				}
			}

			if (isset($data['attribute']) && !empty($data['attribute'])) {
				if ($data['filter_data']['attribute_logic_between_attribute'] == 'AND') {
					$implode_product_attributes = array();

					foreach ($data['attribute'] as $attribute_name_mod => $attribute_value_mod) {
						if (is_array($attribute_value_mod)) {
							foreach ($attribute_value_mod as $attribute_value_mod_children) {
								if ($attribute_value_mod_children) {
									$implode_product_attributes[] = "fpa.product_id IN (SELECT product_id FROM ".DB_PREFIX."phpner_filter_product_attribute WHERE product_id = fpa.product_id AND attribute_name_mod = '".$this->db->escape($attribute_name_mod)."' AND attribute_value_mod = '".$this->db->escape($attribute_value_mod_children)."' GROUP BY attribute_value_mod)";
								}
							}
						} else {
							if ($attribute_value_mod) {
								$implode_product_attributes[] = "fpa.product_id IN (SELECT product_id FROM ".DB_PREFIX."phpner_filter_product_attribute WHERE product_id = fpa.product_id AND attribute_name_mod = '".$this->db->escape($attribute_name_mod)."' AND attribute_value_mod = '".$this->db->escape($attribute_value_mod)."' GROUP BY attribute_value_mod)";
							}
						}
					}

					if ($implode_product_attributes) {
						$sql .= " ".$data['filter_data']['attribute_logic_with_other']." (" . implode(' AND ', $implode_product_attributes) . ")";
					}
				} else {
					$implode_product_attributes = array();

					foreach ($data['attribute'] as $attribute_name_mod => $attribute_value_mod) {
						if (is_array($attribute_value_mod)) {
							foreach ($attribute_value_mod as $attribute_value_mod_children) {
								if ($attribute_value_mod_children) {
									$implode_product_attributes[] = "(fpa.attribute_name_mod = '".$this->db->escape($attribute_name_mod)."' AND fpa.attribute_value_mod = '".$this->db->escape($attribute_value_mod_children)."')";
								}
							}
						} else {
							if ($attribute_value_mod) {
								$implode_product_attributes[] = "(fpa.attribute_name_mod = '".$this->db->escape($attribute_name_mod)."' AND fpa.attribute_value_mod = '".$this->db->escape($attribute_value_mod)."')";
							}
						}
					}

					if ($implode_product_attributes) {
						$sql .= " ".$data['filter_data']['attribute_logic_with_other']." (" . implode(' OR ', $implode_product_attributes) . ")";
					}
				}
			}

			if (isset($data['standard']) && !empty($data['standard'])) {
				if ($data['filter_data']['standard_logic_between_standard'] == 'AND') {
					$implode_product_standards = array();

					foreach ($data['standard'] as $filter_name_mod => $filter_value_mod) {
						if (is_array($filter_value_mod)) {
							foreach ($filter_value_mod as $filter_value_mod_children) {
								if ($filter_value_mod_children) {
									$implode_product_standards[] = "fpsd.product_id IN (SELECT product_id FROM ".DB_PREFIX."phpner_filter_product_standard WHERE product_id = fpsd.product_id AND filter_name_mod = '".$this->db->escape($filter_name_mod)."' AND filter_value_mod = '".$this->db->escape($filter_value_mod_children)."' GROUP BY filter_value_mod)";
								}
							}
						} else {
							if ($filter_value_mod) {
								$implode_product_standards[] = "fpsd.product_id = (SELECT product_id FROM ".DB_PREFIX."phpner_filter_product_standard WHERE product_id = fpsd.product_id AND filter_name_mod = '".$this->db->escape($filter_name_mod)."' AND filter_value_mod IN ('".$this->db->escape($filter_value_mod)."') GROUP BY filter_value_mod)";
							}
						}
					}

					if ($implode_product_standards) {
						$sql .= " ".$data['filter_data']['standard_logic_with_other']." (" . implode(' AND ', $implode_product_standards) . ")";
					}
				} else {
					$implode_product_standards = array();

					foreach ($data['standard'] as $filter_name_mod => $filter_value_mod) {
						if (is_array($filter_value_mod)) {
							foreach ($filter_value_mod as $filter_value_mod_children) {
								if ($filter_value_mod_children) {
									$implode_product_standards[] = "(fpsd.filter_name_mod = '".$this->db->escape($filter_name_mod)."' AND fpsd.filter_value_mod = '".$this->db->escape($filter_value_mod_children)."')";
								}
							}
						} else {
							if ($filter_value_mod) {
								$implode_product_standards[] = "(fpsd.filter_name_mod = '".$this->db->escape($filter_name_mod)."' AND fpsd.filter_value_mod = '".$this->db->escape($filter_value_mod)."')";
							}
						}
					}

					if ($implode_product_standards) {
						$sql .= " ".$data['filter_data']['standard_logic_with_other']." (" . implode(' OR ', $implode_product_standards) . ")";
					}
				}
			}

			if (isset($data['tag']) && !empty($data['tag'])) {
				$sql .= " ".$data['filter_data']['tag_logic_with_other']." ";

				$implode_product_tag = array();
			
				$words = explode(' ', trim(preg_replace('/\s+/', ' ', $data['tag'])));
				
				foreach ($words as $word) {
					$implode_product_tag[] = "pd.tag LIKE '%".$this->db->escape($word)."%'";
				}

				if ($implode_product_tag) {
					$sql .= " ".implode(" AND ", $implode_product_tag)."";
				}

				$sql .= " AND pd.language_id = '".(int)$data['filter_data']['language_id']."'";
			}

			$sql .= " GROUP BY fpo.option_value_id";

			$query = $this->db->query($sql)->rows;

			$result = array();

			foreach ($query as $value) {
				$result[$value['option_name_mod']][$value['option_value_id']] = $value['total'];
			}

			return $result;
		} else {
			return array();
		}
	}

	public function getFilterStickers($global_id, $global_type, $store_id, $customer_group_id, $language_id, $lead_time_status = false) {
		$product_ids = $this->getProductIDs($global_id, $global_type, $store_id, $customer_group_id);

		if ($product_ids) {
			if ($lead_time_status) {
				$sqlTime = 0;
				$timeStart = microtime(true);
			}

			$stickers = array();

			$query = $this->db->query("SELECT DISTINCT fpst.product_sticker_value, fpst.product_sticker_id FROM ".DB_PREFIX."phpner_filter_product_sticker fpst WHERE fpst.product_id IN (".implode(',', $product_ids).") AND fpst.language_id = '".(int)$language_id."' ORDER BY fpst.product_sticker_value ASC")->rows;

			foreach ($query as $value) {
				$stickers[] = array(
					'product_sticker_id' => $value['product_sticker_id'],
					'name'               => $value['product_sticker_value']
				);
			}

			if ($lead_time_status) {
				$sqlTime += microtime(true) - $timeStart;
				$log = new \Log('phpner_filter_debug.log');
				$log->write("S query time : ".number_format(($sqlTime), 2)." sec");
			}

			return $stickers;
		} else {
			return array();
		}
	}

	public function getFilterTotalStickers($global_id, $global_type, $store_id, $customer_group_id, $language_id, $lead_time_status = false, $data = array()) {
		$product_ids = $this->getProductIDs($global_id, $global_type, $store_id, $customer_group_id);

		if ($product_ids) {
			if ($lead_time_status) {
				$sqlTime = 0;
				$timeStart = microtime(true);
			}

			$sql = "SELECT COUNT(DISTINCT p.product_id) AS total, fpst.product_sticker_id FROM ".DB_PREFIX."phpner_filter_product_sticker fpst ";

			$sql .= " INNER JOIN ".DB_PREFIX."product p USING (product_id) ";

			if (isset($data['tag']) && !empty($data['tag'])) {
				$sql .= " INNER JOIN ".DB_PREFIX."product_description pd USING (product_id)";
			}

			if (isset($data['option']) && !empty($data['option'])) {
				$sql .= " INNER JOIN ".DB_PREFIX."phpner_filter_product_option fpo USING (product_id)";
			}

			if (isset($data['attribute']) && !empty($data['attribute'])) {
				$sql .= " INNER JOIN ".DB_PREFIX."phpner_filter_product_attribute fpa USING (product_id)";
			}

			if (isset($data['standard']) && !empty($data['standard'])) {
				$sql .= " INNER JOIN ".DB_PREFIX."phpner_filter_product_standard fpsd USING (product_id)";
			}

			$sql .= " WHERE fpst.product_id IN (".implode(',', $product_ids).") AND fpst.language_id = '".(int)$language_id."' ";

			if (isset($data['sticker']) && !empty($data['sticker'])) {
				if ($data['filter_data']['sticker_logic_between_sticker'] == 'AND') {
					$implode_product_stickers = array();

					if (is_array($data['sticker'])) {
						foreach ($data['sticker'] as $product_sticker_id) {
							if ($product_sticker_id) {
								$implode_product_stickers[] = "fpst.product_id IN (SELECT product_id FROM ".DB_PREFIX."phpner_filter_product_sticker WHERE product_id = fpst.product_id AND product_sticker_id = '".(int)$product_sticker_id."' GROUP BY product_sticker_id)";
							}
						}
					} else {
						if ($data['sticker']) {
							$implode_product_stickers[] = "fpst.product_id IN (SELECT product_id FROM ".DB_PREFIX."phpner_filter_product_sticker WHERE product_id = fpst.product_id AND product_sticker_id = '".(int)$data['sticker']."' GROUP BY product_sticker_id)";
						}
					}

					if ($implode_product_stickers) {
						$sql .= $data['filter_data']['sticker_logic_with_other']." (" . implode(' AND ', $implode_product_stickers) . ")";
					}
				}
			}

			if (isset($data['low_price']) && (isset($data['high_price']) && !empty($data['high_price']))) {
				$sql .= " AND ";
				/* 3359 */
				if (isset($data['special_only']) && !empty($data['special_only'])) {
					$sql .= "((SELECT ps.price FROM ".DB_PREFIX."product_special ps WHERE ps.product_id = p.product_id AND ps.customer_group_id = '".(int)$data['filter_data']['customer_group_id']."' AND ((ps.date_start = '0000-00-00' OR ps.date_start < NOW()) AND (ps.date_end = '0000-00-00' OR ps.date_end > NOW())) ORDER BY ps.priority ASC, ps.price ASC LIMIT 1) BETWEEN ".(float)$data['low_price']." AND ".(float)$data['high_price'].")";
				} else {
					$sql .= "((CASE WHEN(SELECT price FROM ".DB_PREFIX."product_special ps WHERE ps.product_id = p.product_id AND ps.customer_group_id = '".(int)$data['filter_data']['customer_group_id']."' AND ((ps.date_start = '0000-00-00' OR ps.date_start < NOW()) AND (ps.date_end = '0000-00-00' OR ps.date_end > NOW())) ORDER BY ps.priority ASC, ps.price ASC LIMIT 1) > 0 THEN (SELECT price FROM ".DB_PREFIX."product_special ps WHERE ps.product_id = p.product_id AND ps.customer_group_id = '".(int)$data['filter_data']['customer_group_id']."' AND ((ps.date_start = '0000-00-00' OR ps.date_start < NOW()) AND (ps.date_end = '0000-00-00' OR ps.date_end > NOW())) ORDER BY ps.priority ASC, ps.price ASC LIMIT 1) ELSE p.price END) BETWEEN ".(float)$data['low_price']." AND ".(float)$data['high_price'].")";
				}
				/* 3359 */
			}

			if (isset($data['manufacturer']) && !empty($data['manufacturer'])) {
				$sql .= " ".$data['filter_data']['manufacturer_logic_with_other']." (";

				if (is_array($data['manufacturer'])) {
					$implode_manufacturer = array();

					foreach ($data['manufacturer'] as $manufacturer) {
						$implode_manufacturer[] = "p.manufacturer_id = '".(int)$manufacturer."'";
					}

					if ($implode_manufacturer) {
						$sql .= "(".implode(' OR ', $implode_manufacturer).")";
					}
				} else {
					$sql .= "p.manufacturer_id = '".(int)$data['manufacturer']."'";
				}
				$sql .= ")";
			}

			if (isset($data['stock']) && !empty($data['stock'])) {
				$sql .= " ".$data['filter_data']['stock_logic_with_other']." (";

				if (is_array($data['stock'])) {
					$implode_stock = array();

					foreach ($data['stock'] as $stock) {
						if ($stock == 'in_stock') {
							$implode_stock[] = "p.quantity > '0'";
						} elseif($stock == 'out_of_stock') {
							$implode_stock[] = "p.quantity <= '0'";
						} elseif($stock == 'ending_stock') {
							$implode_stock[] = "(p.quantity BETWEEN '0' AND '".(int)$data['filter_data']['stock_ending_value']."')";	
						}
					}

					if ($implode_stock) {
						$sql .= implode(' '.$data['filter_data']['stock_logic_between_stock'].' ', $implode_stock);
					}
				} else {
					if ($data['stock'] == 'in_stock') {
						$sql .= "p.quantity > '0'";
					} elseif($data['stock'] == 'out_of_stock') {
						$sql .= "p.quantity <= '0'";
					} elseif($data['stock'] == 'ending_stock') {
						$sql .= "(p.quantity BETWEEN '0' AND '".(int)$data['filter_data']['stock_ending_value']."')";	
					}
				}
				$sql .= ")";
			}

			if (isset($data['rating']) && !empty($data['rating'])) {
				$implode_rating = array();

				if (is_array($data['rating'])) {
					foreach ($data['rating'] as $rating) {
						$implode_rating[] = "p.product_id IN (SELECT product_id FROM ".DB_PREFIX."review WHERE product_id = p.product_id AND rating = '".$rating."' AND status = '1' GROUP BY rating)";
					}
				} else {
					if ($data['rating']) {
						$implode_rating[] = "p.product_id IN (SELECT product_id FROM ".DB_PREFIX."review WHERE product_id = p.product_id AND rating = '".$data['rating']."' AND status = '1' GROUP BY rating)";
					}
				}

				if ($implode_rating) {
					$sql .= " ".$data['filter_data']['review_logic_with_other']." (" .implode(' '.$data['filter_data']['review_logic_between_review'].' ', $implode_rating) . ")";
				}
			}

			if (isset($data['option']) && !empty($data['option'])) {
				if ($data['filter_data']['option_logic_between_option'] == 'AND') {
					$implode_product_options = array();

					foreach ($data['option'] as $option_name_mod => $option_value_id) {
						if (is_array($option_value_id)) {
							foreach ($option_value_id as $option_value_id_children) {
								if ($option_value_id_children) {
									$implode_product_options[] = "fpo.product_id IN (SELECT product_id FROM ".DB_PREFIX."phpner_filter_product_option WHERE product_id = fpo.product_id AND option_name_mod = '".$this->db->escape($option_name_mod)."' AND option_value_id = '".(int)$option_value_id_children."' GROUP BY option_value_id)";
								}
							}
						} else {
							if ($option_value_id) {
								$implode_product_options[] = "fpo.product_id IN (SELECT product_id FROM ".DB_PREFIX."phpner_filter_product_option WHERE product_id = fpo.product_id AND option_name_mod = '".$this->db->escape($option_name_mod)."' AND option_value_id = '".(int)$option_value_id."' GROUP BY option_value_id)";
							}
						}
					}

					if ($implode_product_options) {
						$sql .= " ".$data['filter_data']['option_logic_with_other']." (" . implode(' AND ', $implode_product_options) . ")";
					}
				} else {
					$implode_product_options = array();

					foreach ($data['option'] as $option_name_mod => $option_value_id) {
						if (is_array($option_value_id)) {
							foreach ($option_value_id as $option_value_id_children) {
								if ($option_value_id_children) {
									$implode_product_options[] = "(fpo.option_name_mod = '".$this->db->escape($option_name_mod)."' AND fpo.option_value_id = '".(int)$option_value_id_children."')";
								}
							}
						} else {
							if ($option_value_id) {
								$implode_product_options[] = "(fpo.option_name_mod = '".$this->db->escape($option_name_mod)."' AND fpo.option_value_id = '".(int)$option_value_id."')";
							}
						}
					}

					if ($implode_product_options) {
						$sql .= " ".$data['filter_data']['option_logic_with_other']." (" . implode(' OR ', $implode_product_options) . ")";
					}
				}
			}

			if (isset($data['attribute']) && !empty($data['attribute'])) {
				if ($data['filter_data']['attribute_logic_between_attribute'] == 'AND') {
					$implode_product_attributes = array();

					foreach ($data['attribute'] as $attribute_name_mod => $attribute_value_mod) {
						if (is_array($attribute_value_mod)) {
							foreach ($attribute_value_mod as $attribute_value_mod_children) {
								if ($attribute_value_mod_children) {
									$implode_product_attributes[] = "fpa.product_id IN (SELECT product_id FROM ".DB_PREFIX."phpner_filter_product_attribute WHERE product_id = fpa.product_id AND attribute_name_mod = '".$this->db->escape($attribute_name_mod)."' AND attribute_value_mod = '".$this->db->escape($attribute_value_mod_children)."' GROUP BY attribute_value_mod)";
								}
							}
						} else {
							if ($attribute_value_mod) {
								$implode_product_attributes[] = "fpa.product_id IN (SELECT product_id FROM ".DB_PREFIX."phpner_filter_product_attribute WHERE product_id = fpa.product_id AND attribute_name_mod = '".$this->db->escape($attribute_name_mod)."' AND attribute_value_mod = '".$this->db->escape($attribute_value_mod)."' GROUP BY attribute_value_mod)";
							}
						}
					}

					if ($implode_product_attributes) {
						$sql .= " ".$data['filter_data']['attribute_logic_with_other']." (" . implode(' AND ', $implode_product_attributes) . ")";
					}
				} else {
					$implode_product_attributes = array();

					foreach ($data['attribute'] as $attribute_name_mod => $attribute_value_mod) {
						if (is_array($attribute_value_mod)) {
							foreach ($attribute_value_mod as $attribute_value_mod_children) {
								if ($attribute_value_mod_children) {
									$implode_product_attributes[] = "(fpa.attribute_name_mod = '".$this->db->escape($attribute_name_mod)."' AND fpa.attribute_value_mod = '".$this->db->escape($attribute_value_mod_children)."')";
								}
							}
						} else {
							if ($attribute_value_mod) {
								$implode_product_attributes[] = "(fpa.attribute_name_mod = '".$this->db->escape($attribute_name_mod)."' AND fpa.attribute_value_mod = '".$this->db->escape($attribute_value_mod)."')";
							}
						}
					}

					if ($implode_product_attributes) {
						$sql .= " ".$data['filter_data']['attribute_logic_with_other']." (" . implode(' OR ', $implode_product_attributes) . ")";
					}
				}
			}

			if (isset($data['standard']) && !empty($data['standard'])) {
				if ($data['filter_data']['standard_logic_between_standard'] == 'AND') {
					$implode_product_standards = array();

					foreach ($data['standard'] as $filter_name_mod => $filter_value_mod) {
						if (is_array($filter_value_mod)) {
							foreach ($filter_value_mod as $filter_value_mod_children) {
								if ($filter_value_mod_children) {
									$implode_product_standards[] = "fpsd.product_id IN (SELECT product_id FROM ".DB_PREFIX."phpner_filter_product_standard WHERE product_id = fpsd.product_id AND filter_name_mod = '".$this->db->escape($filter_name_mod)."' AND filter_value_mod = '".$this->db->escape($filter_value_mod_children)."' GROUP BY filter_value_mod)";
								}
							}
						} else {
							if ($filter_value_mod) {
								$implode_product_standards[] = "fpsd.product_id = (SELECT product_id FROM ".DB_PREFIX."phpner_filter_product_standard WHERE product_id = fpsd.product_id AND filter_name_mod = '".$this->db->escape($filter_name_mod)."' AND filter_value_mod IN ('".$this->db->escape($filter_value_mod)."') GROUP BY filter_value_mod)";
							}
						}
					}

					if ($implode_product_standards) {
						$sql .= " ".$data['filter_data']['standard_logic_with_other']." (" . implode(' AND ', $implode_product_standards) . ")";
					}
				} else {
					$implode_product_standards = array();

					foreach ($data['standard'] as $filter_name_mod => $filter_value_mod) {
						if (is_array($filter_value_mod)) {
							foreach ($filter_value_mod as $filter_value_mod_children) {
								if ($filter_value_mod_children) {
									$implode_product_standards[] = "(fpsd.filter_name_mod = '".$this->db->escape($filter_name_mod)."' AND fpsd.filter_value_mod = '".$this->db->escape($filter_value_mod_children)."')";
								}
							}
						} else {
							if ($filter_value_mod) {
								$implode_product_standards[] = "(fpsd.filter_name_mod = '".$this->db->escape($filter_name_mod)."' AND fpsd.filter_value_mod = '".$this->db->escape($filter_value_mod)."')";
							}
						}
					}

					if ($implode_product_standards) {
						$sql .= " ".$data['filter_data']['standard_logic_with_other']." (" . implode(' OR ', $implode_product_standards) . ")";
					}
				}
			}

			if (isset($data['tag']) && !empty($data['tag'])) {
				$sql .= " ".$data['filter_data']['tag_logic_with_other']." ";

				$implode_product_tag = array();
			
				$words = explode(' ', trim(preg_replace('/\s+/', ' ', $data['tag'])));
				
				foreach ($words as $word) {
					$implode_product_tag[] = "pd.tag LIKE '%".$this->db->escape($word)."%'";
				}

				if ($implode_product_tag) {
					$sql .= " ".implode(" AND ", $implode_product_tag)."";
				}

				$sql .= " AND pd.language_id = '".(int)$data['filter_data']['language_id']."'";
			}

			$sql .= " GROUP BY fpst.product_sticker_id";

			if ($lead_time_status) {
				$sqlTime += microtime(true) - $timeStart;
				$log = new \Log('phpner_filter_debug.log');
				$log->write("St query time: ".number_format(($sqlTime), 2)." sec");
			}

			$query = $this->db->query($sql)->rows;

			$result = array();

			foreach ($query as $value) {
				$result[$value['product_sticker_id']] = $value['total'];
			}

			return $result;
		} else {
			return array();
		}
	}

	public function getFilterTotalStock($global_id, $global_type, $store_id, $customer_group_id, $language_id, $lead_time_status = false, $data = array()) {
		$product_ids = $this->getProductIDs($global_id, $global_type, $store_id, $customer_group_id);

		if ($product_ids) {
			if ($lead_time_status) {
				$sqlTime = 0;
				$timeStart = microtime(true);
			}

			$stock_check = array(
				array('name'=> "in_stock",     'query' => "AND p.quantity > '0'"),
				array('name'=> "out_of_stock", 'query' => "AND p.quantity <= '0'"),
				array('name'=> "ending_stock", 'query' => "AND (p.quantity BETWEEN '0' AND '".(int)$data['filter_data']['stock_ending_value']."')")
			);

			$query_result = array();

			foreach ($stock_check as $value) {
				$sql = "SELECT COUNT(DISTINCT p.product_id) AS total FROM ".DB_PREFIX."product p ";

				if (isset($data['tag']) && !empty($data['tag'])) {
					$sql .= " INNER JOIN ".DB_PREFIX."product_description pd USING (product_id)";
				}

				if (isset($data['sticker']) && !empty($data['sticker'])) {
					$sql .= " INNER JOIN ".DB_PREFIX."phpner_filter_product_sticker fpst USING (product_id)";
				}

				if (isset($data['option']) && !empty($data['option'])) {
					$sql .= " INNER JOIN ".DB_PREFIX."phpner_filter_product_option fpo USING (product_id)";
				}

				if (isset($data['attribute']) && !empty($data['attribute'])) {
					$sql .= " INNER JOIN ".DB_PREFIX."phpner_filter_product_attribute fpa USING (product_id)";
				}

				if (isset($data['standard']) && !empty($data['standard'])) {
					$sql .= " INNER JOIN ".DB_PREFIX."phpner_filter_product_standard fpsd USING (product_id)";
				}

				$sql .= " WHERE p.product_id IN (".implode(',', $product_ids).") ";

				if (isset($data['manufacturer']) && !empty($data['manufacturer'])) {
					$sql .= " ".$data['filter_data']['manufacturer_logic_with_other']." (";

					if (is_array($data['manufacturer'])) {
						$implode_manufacturer = array();

						foreach ($data['manufacturer'] as $manufacturer) {
							$implode_manufacturer[] = "p.manufacturer_id = '".(int)$manufacturer."'";
						}

						if ($implode_manufacturer) {
							$sql .= "(".implode(' OR ', $implode_manufacturer).")";
						}
					} else {
						$sql .= "p.manufacturer_id = '".(int)$data['manufacturer']."'";
					}
					$sql .= ")";
				}

				if (isset($data['low_price']) && (isset($data['high_price']) && !empty($data['high_price']))) {
					$sql .= " AND ";
					/* 3359 */
					if (isset($data['special_only']) && !empty($data['special_only'])) {
						$sql .= "((SELECT ps.price FROM ".DB_PREFIX."product_special ps WHERE ps.product_id = p.product_id AND ps.customer_group_id = '".(int)$data['filter_data']['customer_group_id']."' AND ((ps.date_start = '0000-00-00' OR ps.date_start < NOW()) AND (ps.date_end = '0000-00-00' OR ps.date_end > NOW())) ORDER BY ps.priority ASC, ps.price ASC LIMIT 1) BETWEEN ".(float)$data['low_price']." AND ".(float)$data['high_price'].")";
					} else {
						$sql .= "((CASE WHEN(SELECT price FROM ".DB_PREFIX."product_special ps WHERE ps.product_id = p.product_id AND ps.customer_group_id = '".(int)$data['filter_data']['customer_group_id']."' AND ((ps.date_start = '0000-00-00' OR ps.date_start < NOW()) AND (ps.date_end = '0000-00-00' OR ps.date_end > NOW())) ORDER BY ps.priority ASC, ps.price ASC LIMIT 1) > 0 THEN (SELECT price FROM ".DB_PREFIX."product_special ps WHERE ps.product_id = p.product_id AND ps.customer_group_id = '".(int)$data['filter_data']['customer_group_id']."' AND ((ps.date_start = '0000-00-00' OR ps.date_start < NOW()) AND (ps.date_end = '0000-00-00' OR ps.date_end > NOW())) ORDER BY ps.priority ASC, ps.price ASC LIMIT 1) ELSE p.price END) BETWEEN ".(float)$data['low_price']." AND ".(float)$data['high_price'].")";
					}
					/* 3359 */
				}

				if (isset($data['rating']) && !empty($data['rating'])) {
					$implode_rating = array();

					if (is_array($data['rating'])) {
						foreach ($data['rating'] as $rating) {
							$implode_rating[] = "p.product_id IN (SELECT product_id FROM ".DB_PREFIX."review WHERE product_id = p.product_id AND rating = '".$rating."' AND status = '1' GROUP BY rating)";
						}
					} else {
						if ($data['rating']) {
							$implode_rating[] = "p.product_id IN (SELECT product_id FROM ".DB_PREFIX."review WHERE product_id = p.product_id AND rating = '".$data['rating']."' AND status = '1' GROUP BY rating)";
						}
					}

					if ($implode_rating) {
						$sql .= " ".$data['filter_data']['review_logic_with_other']." (" .implode(' '.$data['filter_data']['review_logic_between_review'].' ', $implode_rating) . ")";
					}
				}

				if (isset($data['sticker']) && !empty($data['sticker'])) {
					if ($data['filter_data']['sticker_logic_between_sticker'] == 'AND') {
						$implode_product_stickers = array();

						if (is_array($data['sticker'])) {
							foreach ($data['sticker'] as $product_sticker_id) {
								if ($product_sticker_id) {
									$implode_product_stickers[] = "fpst.product_id IN (SELECT product_id FROM ".DB_PREFIX."phpner_filter_product_sticker WHERE product_id = fpst.product_id AND product_sticker_id = '".(int)$product_sticker_id."' GROUP BY product_sticker_id)";
								}
							}
						} else {
							if ($data['sticker']) {
								$implode_product_stickers[] = "fpst.product_id IN (SELECT product_id FROM ".DB_PREFIX."phpner_filter_product_sticker WHERE product_id = fpst.product_id AND product_sticker_id = '".(int)$data['sticker']."' GROUP BY product_sticker_id)";
							}
						}

						if ($implode_product_stickers) {
							$sql .= " ".$data['filter_data']['sticker_logic_with_other']." (" . implode(' AND ', $implode_product_stickers) . ")";
						}
					} else {
						if (is_array($data['sticker'])) {
							$implode_product_stickers = array();

							foreach ($data['sticker'] as $product_sticker_id) {
								$implode_product_stickers[] = "fpst.product_sticker_id = '".(int)$product_sticker_id."'";
							}
						} else {
							$implode_product_stickers[] = "fpst.product_sticker_id = '".(int)$data['sticker']."'";
						}

						if ($implode_product_stickers) {
							$sql .= " ".$data['filter_data']['sticker_logic_with_other']." (".implode(' OR ', $implode_product_stickers).")";
						}
					}
				}

				if (isset($data['option']) && !empty($data['option'])) {
					if ($data['filter_data']['option_logic_between_option'] == 'AND') {
						$implode_product_options = array();

						foreach ($data['option'] as $option_name_mod => $option_value_id) {
							if (is_array($option_value_id)) {
								foreach ($option_value_id as $option_value_id_children) {
									if ($option_value_id_children) {
										$implode_product_options[] = "fpo.product_id IN (SELECT product_id FROM ".DB_PREFIX."phpner_filter_product_option WHERE product_id = fpo.product_id AND option_name_mod = '".$this->db->escape($option_name_mod)."' AND option_value_id = '".(int)$option_value_id_children."' GROUP BY option_value_id)";
									}
								}
							} else {
								if ($option_value_id) {
									$implode_product_options[] = "fpo.product_id IN (SELECT product_id FROM ".DB_PREFIX."phpner_filter_product_option WHERE product_id = fpo.product_id AND option_name_mod = '".$this->db->escape($option_name_mod)."' AND option_value_id = '".(int)$option_value_id."' GROUP BY option_value_id)";
								}
							}
						}

						if ($implode_product_options) {
							$sql .= " ".$data['filter_data']['option_logic_with_other']." (" . implode(' AND ', $implode_product_options) . ")";
						}
					} else {
						$implode_product_options = array();

						foreach ($data['option'] as $option_name_mod => $option_value_id) {
							if (is_array($option_value_id)) {
								foreach ($option_value_id as $option_value_id_children) {
									if ($option_value_id_children) {
										$implode_product_options[] = "(fpo.option_name_mod = '".$this->db->escape($option_name_mod)."' AND fpo.option_value_id = '".(int)$option_value_id_children."')";
									}
								}
							} else {
								if ($option_value_id) {
									$implode_product_options[] = "(fpo.option_name_mod = '".$this->db->escape($option_name_mod)."' AND fpo.option_value_id = '".(int)$option_value_id."')";
								}
							}
						}

						if ($implode_product_options) {
							$sql .= " ".$data['filter_data']['option_logic_with_other']." (" . implode(' OR ', $implode_product_options) . ")";
						}
					}
				}

				if (isset($data['attribute']) && !empty($data['attribute'])) {
					if ($data['filter_data']['attribute_logic_between_attribute'] == 'AND') {
						$implode_product_attributes = array();

						foreach ($data['attribute'] as $attribute_name_mod => $attribute_value_mod) {
							if (is_array($attribute_value_mod)) {
								foreach ($attribute_value_mod as $attribute_value_mod_children) {
									if ($attribute_value_mod_children) {
										$implode_product_attributes[] = "fpa.product_id IN (SELECT product_id FROM ".DB_PREFIX."phpner_filter_product_attribute WHERE product_id = fpa.product_id AND attribute_name_mod = '".$this->db->escape($attribute_name_mod)."' AND attribute_value_mod = '".$this->db->escape($attribute_value_mod_children)."' GROUP BY attribute_value_mod)";
									}
								}
							} else {
								if ($attribute_value_mod) {
									$implode_product_attributes[] = "fpa.product_id IN (SELECT product_id FROM ".DB_PREFIX."phpner_filter_product_attribute WHERE product_id = fpa.product_id AND attribute_name_mod = '".$this->db->escape($attribute_name_mod)."' AND attribute_value_mod = '".$this->db->escape($attribute_value_mod)."' GROUP BY attribute_value_mod)";
								}
							}
						}

						if ($implode_product_attributes) {
							$sql .= " ".$data['filter_data']['attribute_logic_with_other']." (" . implode(' AND ', $implode_product_attributes) . ")";
						}
					} else {
						$implode_product_attributes = array();

						foreach ($data['attribute'] as $attribute_name_mod => $attribute_value_mod) {
							if (is_array($attribute_value_mod)) {
								foreach ($attribute_value_mod as $attribute_value_mod_children) {
									if ($attribute_value_mod_children) {
										$implode_product_attributes[] = "(fpa.attribute_name_mod = '".$this->db->escape($attribute_name_mod)."' AND fpa.attribute_value_mod = '".$this->db->escape($attribute_value_mod_children)."')";
									}
								}
							} else {
								if ($attribute_value_mod) {
									$implode_product_attributes[] = "(fpa.attribute_name_mod = '".$this->db->escape($attribute_name_mod)."' AND fpa.attribute_value_mod = '".$this->db->escape($attribute_value_mod)."')";
								}
							}
						}

						if ($implode_product_attributes) {
							$sql .= " ".$data['filter_data']['attribute_logic_with_other']." (" . implode(' OR ', $implode_product_attributes) . ")";
						}
					}
				}

				if (isset($data['standard']) && !empty($data['standard'])) {
					if ($data['filter_data']['standard_logic_between_standard'] == 'AND') {
						$implode_product_standards = array();

						foreach ($data['standard'] as $filter_name_mod => $filter_value_mod) {
							if (is_array($filter_value_mod)) {
								foreach ($filter_value_mod as $filter_value_mod_children) {
									if ($filter_value_mod_children) {
										$implode_product_standards[] = "fpsd.product_id IN (SELECT product_id FROM ".DB_PREFIX."phpner_filter_product_standard WHERE product_id = fpsd.product_id AND filter_name_mod = '".$this->db->escape($filter_name_mod)."' AND filter_value_mod = '".$this->db->escape($filter_value_mod_children)."' GROUP BY filter_value_mod)";
									}
								}
							} else {
								if ($filter_value_mod) {
									$implode_product_standards[] = "fpsd.product_id = (SELECT product_id FROM ".DB_PREFIX."phpner_filter_product_standard WHERE product_id = fpsd.product_id AND filter_name_mod = '".$this->db->escape($filter_name_mod)."' AND filter_value_mod IN ('".$this->db->escape($filter_value_mod)."') GROUP BY filter_value_mod)";
								}
							}
						}

						if ($implode_product_standards) {
							$sql .= " ".$data['filter_data']['standard_logic_with_other']." (" . implode(' AND ', $implode_product_standards) . ")";
						}
					} else {
						$implode_product_standards = array();

						foreach ($data['standard'] as $filter_name_mod => $filter_value_mod) {
							if (is_array($filter_value_mod)) {
								foreach ($filter_value_mod as $filter_value_mod_children) {
									if ($filter_value_mod_children) {
										$implode_product_standards[] = "(fpsd.filter_name_mod = '".$this->db->escape($filter_name_mod)."' AND fpsd.filter_value_mod = '".$this->db->escape($filter_value_mod_children)."')";
									}
								}
							} else {
								if ($filter_value_mod) {
									$implode_product_standards[] = "(fpsd.filter_name_mod = '".$this->db->escape($filter_name_mod)."' AND fpsd.filter_value_mod = '".$this->db->escape($filter_value_mod)."')";
								}
							}
						}

						if ($implode_product_standards) {
							$sql .= " ".$data['filter_data']['standard_logic_with_other']." (" . implode(' OR ', $implode_product_standards) . ")";
						}
					}
				}

				if (isset($data['tag']) && !empty($data['tag'])) {
					$sql .= " ".$data['filter_data']['tag_logic_with_other']." ";

					$implode_product_tag = array();
				
					$words = explode(' ', trim(preg_replace('/\s+/', ' ', $data['tag'])));
					
					foreach ($words as $word) {
						$implode_product_tag[] = "pd.tag LIKE '%".$this->db->escape($word)."%'";
					}

					if ($implode_product_tag) {
						$sql .= " ".implode(" AND ", $implode_product_tag)."";
					}

					$sql .= " AND pd.language_id = '".(int)$data['filter_data']['language_id']."'";
				}

				$sql .= $value['query'];

				$query_result[$value['name']] = $this->db->query($sql)->row['total'];
			}

			if ($lead_time_status) {
				$sqlTime += microtime(true) - $timeStart;
				$log = new \Log('phpner_filter_debug.log');
				$log->write("Qt query time: ".number_format(($sqlTime), 2)." sec");
			}

			return $query_result;
		} else {
			return array();
		}
	}

	public function getFilterTotalReview($global_id, $global_type, $store_id, $customer_group_id, $language_id, $lead_time_status = false, $data = array()) {
		$product_ids = $this->getProductIDs($global_id, $global_type, $store_id, $customer_group_id);

		if ($product_ids) {
			if ($lead_time_status) {
				$sqlTime = 0;
				$timeStart = microtime(true);
			}

			$review_check = array(
				array('name'=> "star1_total", 'query' => "AND r.rating = '1'"),
				array('name'=> "star2_total", 'query' => "AND r.rating = '2'"),
				array('name'=> "star3_total", 'query' => "AND r.rating = '3'"),
				array('name'=> "star4_total", 'query' => "AND r.rating = '4'"),
				array('name'=> "star5_total", 'query' => "AND r.rating = '5'")
			);

			$query_result = array();

			foreach ($review_check as $value) {
				$sql = "SELECT COUNT(DISTINCT p.product_id) AS total FROM ".DB_PREFIX."review r ";

				$sql .= "INNER JOIN ".DB_PREFIX."product p USING (product_id) ";

				if (isset($data['tag']) && !empty($data['tag'])) {
					$sql .= " INNER JOIN ".DB_PREFIX."product_description pd USING (product_id)";
				}

				if (isset($data['sticker']) && !empty($data['sticker'])) {
					$sql .= " INNER JOIN ".DB_PREFIX."phpner_filter_product_sticker fpst USING (product_id)";
				}

				if (isset($data['option']) && !empty($data['option'])) {
					$sql .= " INNER JOIN ".DB_PREFIX."phpner_filter_product_option fpo USING (product_id)";
				}

				if (isset($data['attribute']) && !empty($data['attribute'])) {
					$sql .= " INNER JOIN ".DB_PREFIX."phpner_filter_product_attribute fpa USING (product_id)";
				}

				if (isset($data['standard']) && !empty($data['standard'])) {
					$sql .= " INNER JOIN ".DB_PREFIX."phpner_filter_product_standard fpsd USING (product_id)";
				}

				$sql .= " WHERE r.product_id IN (".implode(',', $product_ids).") AND r.status = '1' ".$value['query'];

				if (isset($data['low_price']) && (isset($data['high_price']) && !empty($data['high_price']))) {
					$sql .= " AND ";
					/* 3359 */
					if (isset($data['special_only']) && !empty($data['special_only'])) {
						$sql .= "((SELECT ps.price FROM ".DB_PREFIX."product_special ps WHERE ps.product_id = p.product_id AND ps.customer_group_id = '".(int)$data['filter_data']['customer_group_id']."' AND ((ps.date_start = '0000-00-00' OR ps.date_start < NOW()) AND (ps.date_end = '0000-00-00' OR ps.date_end > NOW())) ORDER BY ps.priority ASC, ps.price ASC LIMIT 1) BETWEEN ".(float)$data['low_price']." AND ".(float)$data['high_price'].")";
					} else {
						$sql .= "((CASE WHEN(SELECT price FROM ".DB_PREFIX."product_special ps WHERE ps.product_id = p.product_id AND ps.customer_group_id = '".(int)$data['filter_data']['customer_group_id']."' AND ((ps.date_start = '0000-00-00' OR ps.date_start < NOW()) AND (ps.date_end = '0000-00-00' OR ps.date_end > NOW())) ORDER BY ps.priority ASC, ps.price ASC LIMIT 1) > 0 THEN (SELECT price FROM ".DB_PREFIX."product_special ps WHERE ps.product_id = p.product_id AND ps.customer_group_id = '".(int)$data['filter_data']['customer_group_id']."' AND ((ps.date_start = '0000-00-00' OR ps.date_start < NOW()) AND (ps.date_end = '0000-00-00' OR ps.date_end > NOW())) ORDER BY ps.priority ASC, ps.price ASC LIMIT 1) ELSE p.price END) BETWEEN ".(float)$data['low_price']." AND ".(float)$data['high_price'].")";
					}
					/* 3359 */
				}

				if (isset($data['manufacturer']) && !empty($data['manufacturer'])) {
					$sql .= " ".$data['filter_data']['manufacturer_logic_with_other']." (";

					if (is_array($data['manufacturer'])) {
						$implode_manufacturer = array();

						foreach ($data['manufacturer'] as $manufacturer) {
							$implode_manufacturer[] = "p.manufacturer_id = '".(int)$manufacturer."'";
						}

						if ($implode_manufacturer) {
							$sql .= "(".implode(' OR ', $implode_manufacturer).")";
						}
					} else {
						$sql .= "p.manufacturer_id = '".(int)$data['manufacturer']."'";
					}
					$sql .= ")";
				}

				if (isset($data['stock']) && !empty($data['stock'])) {
					$sql .= " ".$data['filter_data']['stock_logic_with_other']." (";

					if (is_array($data['stock'])) {
						$implode_stock = array();

						foreach ($data['stock'] as $stock) {
							if ($stock == 'in_stock') {
								$implode_stock[] = "p.quantity > '0'";
							} elseif($stock == 'out_of_stock') {
								$implode_stock[] = "p.quantity <= '0'";
							} elseif($stock == 'ending_stock') {
								$implode_stock[] = "(p.quantity BETWEEN '0' AND '".(int)$data['filter_data']['stock_ending_value']."')";	
							}
						}

						if ($implode_stock) {
							$sql .= implode(' '.$data['filter_data']['stock_logic_between_stock'].' ', $implode_stock);
						}
					} else {
						if ($data['stock'] == 'in_stock') {
							$sql .= "p.quantity > '0'";
						} elseif($data['stock'] == 'out_of_stock') {
							$sql .= "p.quantity <= '0'";
						} elseif($data['stock'] == 'ending_stock') {
							$sql .= "(p.quantity BETWEEN '0' AND '".(int)$data['filter_data']['stock_ending_value']."')";	
						}
					}
					$sql .= ")";
				}

				if (isset($data['sticker']) && !empty($data['sticker'])) {
					if ($data['filter_data']['sticker_logic_between_sticker'] == 'AND') {
						$implode_product_stickers = array();

						if (is_array($data['sticker'])) {
							foreach ($data['sticker'] as $product_sticker_id) {
								if ($product_sticker_id) {
									$implode_product_stickers[] = "fpst.product_id IN (SELECT product_id FROM ".DB_PREFIX."phpner_filter_product_sticker WHERE product_id = fpst.product_id AND product_sticker_id = '".(int)$product_sticker_id."' GROUP BY product_sticker_id)";
								}
							}
						} else {
							if ($data['sticker']) {
								$implode_product_stickers[] = "fpst.product_id IN (SELECT product_id FROM ".DB_PREFIX."phpner_filter_product_sticker WHERE product_id = fpst.product_id AND product_sticker_id = '".(int)$data['sticker']."' GROUP BY product_sticker_id)";
							}
						}

						if ($implode_product_stickers) {
							$sql .= " ".$data['filter_data']['sticker_logic_with_other']." (" . implode(' AND ', $implode_product_stickers) . ")";
						}
					} else {
						if (is_array($data['sticker'])) {
							$implode_product_stickers = array();

							foreach ($data['sticker'] as $product_sticker_id) {
								$implode_product_stickers[] = "fpst.product_sticker_id = '".(int)$product_sticker_id."'";
							}
						} else {
							$implode_product_stickers[] = "fpst.product_sticker_id = '".(int)$data['sticker']."'";
						}

						if ($implode_product_stickers) {
							$sql .= " ".$data['filter_data']['sticker_logic_with_other']." (".implode(' OR ', $implode_product_stickers).")";
						}
					}
				}

				if (isset($data['option']) && !empty($data['option'])) {
					if ($data['filter_data']['option_logic_between_option'] == 'AND') {
						$implode_product_options = array();

						foreach ($data['option'] as $option_name_mod => $option_value_id) {
							if (is_array($option_value_id)) {
								foreach ($option_value_id as $option_value_id_children) {
									if ($option_value_id_children) {
										$implode_product_options[] = "fpo.product_id IN (SELECT product_id FROM ".DB_PREFIX."phpner_filter_product_option WHERE product_id = fpo.product_id AND option_name_mod = '".$this->db->escape($option_name_mod)."' AND option_value_id = '".(int)$option_value_id_children."' GROUP BY option_value_id)";
									}
								}
							} else {
								if ($option_value_id) {
									$implode_product_options[] = "fpo.product_id IN (SELECT product_id FROM ".DB_PREFIX."phpner_filter_product_option WHERE product_id = fpo.product_id AND option_name_mod = '".$this->db->escape($option_name_mod)."' AND option_value_id = '".(int)$option_value_id."' GROUP BY option_value_id)";
								}
							}
						}

						if ($implode_product_options) {
							$sql .= " ".$data['filter_data']['option_logic_with_other']." (" . implode(' AND ', $implode_product_options) . ")";
						}
					} else {
						$implode_product_options = array();

						foreach ($data['option'] as $option_name_mod => $option_value_id) {
							if (is_array($option_value_id)) {
								foreach ($option_value_id as $option_value_id_children) {
									if ($option_value_id_children) {
										$implode_product_options[] = "(fpo.option_name_mod = '".$this->db->escape($option_name_mod)."' AND fpo.option_value_id = '".(int)$option_value_id_children."')";
									}
								}
							} else {
								if ($option_value_id) {
									$implode_product_options[] = "(fpo.option_name_mod = '".$this->db->escape($option_name_mod)."' AND fpo.option_value_id = '".(int)$option_value_id."')";
								}
							}
						}

						if ($implode_product_options) {
							$sql .= " ".$data['filter_data']['option_logic_with_other']." (" . implode(' OR ', $implode_product_options) . ")";
						}
					}
				}

				if (isset($data['attribute']) && !empty($data['attribute'])) {
					if ($data['filter_data']['attribute_logic_between_attribute'] == 'AND') {
						$implode_product_attributes = array();

						foreach ($data['attribute'] as $attribute_name_mod => $attribute_value_mod) {
							if (is_array($attribute_value_mod)) {
								foreach ($attribute_value_mod as $attribute_value_mod_children) {
									if ($attribute_value_mod_children) {
										$implode_product_attributes[] = "fpa.product_id IN (SELECT product_id FROM ".DB_PREFIX."phpner_filter_product_attribute WHERE product_id = fpa.product_id AND attribute_name_mod = '".$this->db->escape($attribute_name_mod)."' AND attribute_value_mod = '".$this->db->escape($attribute_value_mod_children)."' GROUP BY attribute_value_mod)";
									}
								}
							} else {
								if ($attribute_value_mod) {
									$implode_product_attributes[] = "fpa.product_id IN (SELECT product_id FROM ".DB_PREFIX."phpner_filter_product_attribute WHERE product_id = fpa.product_id AND attribute_name_mod = '".$this->db->escape($attribute_name_mod)."' AND attribute_value_mod = '".$this->db->escape($attribute_value_mod)."' GROUP BY attribute_value_mod)";
								}
							}
						}

						if ($implode_product_attributes) {
							$sql .= " ".$data['filter_data']['attribute_logic_with_other']." (" . implode(' AND ', $implode_product_attributes) . ")";
						}
					} else {
						$implode_product_attributes = array();

						foreach ($data['attribute'] as $attribute_name_mod => $attribute_value_mod) {
							if (is_array($attribute_value_mod)) {
								foreach ($attribute_value_mod as $attribute_value_mod_children) {
									if ($attribute_value_mod_children) {
										$implode_product_attributes[] = "(fpa.attribute_name_mod = '".$this->db->escape($attribute_name_mod)."' AND fpa.attribute_value_mod = '".$this->db->escape($attribute_value_mod_children)."')";
									}
								}
							} else {
								if ($attribute_value_mod) {
									$implode_product_attributes[] = "(fpa.attribute_name_mod = '".$this->db->escape($attribute_name_mod)."' AND fpa.attribute_value_mod = '".$this->db->escape($attribute_value_mod)."')";
								}
							}
						}

						if ($implode_product_attributes) {
							$sql .= " ".$data['filter_data']['attribute_logic_with_other']." (" . implode(' OR ', $implode_product_attributes) . ")";
						}
					}
				}

				if (isset($data['standard']) && !empty($data['standard'])) {
					if ($data['filter_data']['standard_logic_between_standard'] == 'AND') {
						$implode_product_standards = array();

						foreach ($data['standard'] as $filter_name_mod => $filter_value_mod) {
							if (is_array($filter_value_mod)) {
								foreach ($filter_value_mod as $filter_value_mod_children) {
									if ($filter_value_mod_children) {
										$implode_product_standards[] = "fpsd.product_id IN (SELECT product_id FROM ".DB_PREFIX."phpner_filter_product_standard WHERE product_id = fpsd.product_id AND filter_name_mod = '".$this->db->escape($filter_name_mod)."' AND filter_value_mod = '".$this->db->escape($filter_value_mod_children)."' GROUP BY filter_value_mod)";
									}
								}
							} else {
								if ($filter_value_mod) {
									$implode_product_standards[] = "fpsd.product_id = (SELECT product_id FROM ".DB_PREFIX."phpner_filter_product_standard WHERE product_id = fpsd.product_id AND filter_name_mod = '".$this->db->escape($filter_name_mod)."' AND filter_value_mod IN ('".$this->db->escape($filter_value_mod)."') GROUP BY filter_value_mod)";
								}
							}
						}

						if ($implode_product_standards) {
							$sql .= " ".$data['filter_data']['standard_logic_with_other']." (" . implode(' AND ', $implode_product_standards) . ")";
						}
					} else {
						$implode_product_standards = array();

						foreach ($data['standard'] as $filter_name_mod => $filter_value_mod) {
							if (is_array($filter_value_mod)) {
								foreach ($filter_value_mod as $filter_value_mod_children) {
									if ($filter_value_mod_children) {
										$implode_product_standards[] = "(fpsd.filter_name_mod = '".$this->db->escape($filter_name_mod)."' AND fpsd.filter_value_mod = '".$this->db->escape($filter_value_mod_children)."')";
									}
								}
							} else {
								if ($filter_value_mod) {
									$implode_product_standards[] = "(fpsd.filter_name_mod = '".$this->db->escape($filter_name_mod)."' AND fpsd.filter_value_mod = '".$this->db->escape($filter_value_mod)."')";
								}
							}
						}

						if ($implode_product_standards) {
							$sql .= " ".$data['filter_data']['standard_logic_with_other']." (" . implode(' OR ', $implode_product_standards) . ")";
						}
					}
				}

				if (isset($data['tag']) && !empty($data['tag'])) {
					$sql .= " ".$data['filter_data']['tag_logic_with_other']." ";

					$implode_product_tag = array();
				
					$words = explode(' ', trim(preg_replace('/\s+/', ' ', $data['tag'])));
					
					foreach ($words as $word) {
						$implode_product_tag[] = "pd.tag LIKE '%".$this->db->escape($word)."%'";
					}

					if ($implode_product_tag) {
						$sql .= " ".implode(" AND ", $implode_product_tag)."";
					}

					$sql .= " AND pd.language_id = '".(int)$data['filter_data']['language_id']."'";
				}

				$query_result[$value['name']] = $this->db->query($sql)->row['total'];
			}

			if ($lead_time_status) {
				$sqlTime += microtime(true) - $timeStart;
				$log = new \Log('phpner_filter_debug.log');
				$log->write("Rt query time: ".number_format(($sqlTime), 2)." sec");
				$log->write("########### end ##########");
			}

			return $query_result;
		} else {
			return array(
				"star1_total" => 0,
				"star2_total" => 0,
				"star3_total" => 0,
				"star4_total" => 0,
				"star5_total" => 0
			);
		}
	}

	public function getFilterStandards($global_id, $global_type, $store_id, $customer_group_id, $language_id, $lead_time_status = false) {
		$product_ids = $this->getProductIDs($global_id, $global_type, $store_id, $customer_group_id);

		if ($product_ids) {
			if ($lead_time_status) {
				$sqlTime = 0;
				$timeStart = microtime(true);
			}

			$standards = $this->cache->get('phpner.product_filter_pids.standard.'.(int)$store_id.'.'.(int)$customer_group_id.'.'.(int)$language_id.'.'.(int)$global_id);
				
			if (!$standards) {
				$standards = array();

				$query = $this->db->query("SELECT DISTINCT fpsd.filter_name, fpsd.filter_name_mod, fpsd.filter_id, fpsd.filter_group_id FROM ".DB_PREFIX."phpner_filter_product_standard fpsd WHERE fpsd.product_id IN (".implode(',', $product_ids).") AND fpsd.language_id = '".(int)$language_id."' GROUP BY fpsd.filter_name ORDER BY fpsd.filter_name ASC")->rows;

				foreach ($query as $value) {
					$standards[] = array(
						'filter_id' 		  => $value['filter_id'],
						'filter_group_id' => $value['filter_group_id'],
						'name'            => $value['filter_name'],
						'filter_name_mod' => $value['filter_name_mod'],
						'values'          => $this->getFilterStandardValues($value['filter_name'], $global_id, $global_type, $store_id, $customer_group_id, $language_id)
					);
				}

				$this->cache->set('phpner.product_filter_pids.standard.'.(int)$store_id.'.'.(int)$customer_group_id.'.'.(int)$language_id.'.'.(int)$global_id, $standards);
			}

			if ($lead_time_status) {
				$sqlTime += microtime(true) - $timeStart;
				$log = new \Log('phpner_filter_debug.log');
				$log->write("Sd query time: ".number_format(($sqlTime), 2)." sec");
			}

			return $standards;
		} else {
			return array();
		}
	}

	public function getFilterStandardValues($filter_name, $global_id, $global_type, $store_id, $customer_group_id, $language_id) {
    $product_ids = $this->getProductIDs($global_id, $global_type, $store_id, $customer_group_id);

    if ($product_ids) {
      $query = $this->db->query("SELECT DISTINCT fpsd.filter_value_mod, fpsd.filter_value FROM ".DB_PREFIX."phpner_filter_product_standard fpsd WHERE fpsd.product_id IN (".implode(',', $product_ids).") AND fpsd.language_id = '".(int)$language_id."' AND fpsd.filter_name = '".$this->db->escape($filter_name)."' GROUP BY fpsd.filter_value ORDER BY fpsd.sort_order, fpsd.filter_value ASC")->rows;

      $result = array();

      foreach ($query as $value) {
        $result[] = array(
          'filter_value'     => $value['filter_value'],
          'filter_value_mod' => $value['filter_value_mod']
        );
      }

      return $result;
    } else {
      return array();
    }
  }

  public function getFilterTotalStandardValues($global_id, $global_type, $store_id, $customer_group_id, $language_id, $data = array()) {
		$product_ids = $this->getProductIDs($global_id, $global_type, $store_id, $customer_group_id);

		if ($product_ids) {
			$sql = "SELECT COUNT(DISTINCT p.product_id) AS total, fpsd.filter_id, fpsd.filter_name_mod, fpsd.filter_value_mod FROM ".DB_PREFIX."phpner_filter_product_standard fpsd ";

			$sql .= "INNER JOIN ".DB_PREFIX."product p USING (product_id) ";

			if (isset($data['tag']) && !empty($data['tag'])) {
				$sql .= " INNER JOIN ".DB_PREFIX."product_description pd USING (product_id)";
			}

			if (isset($data['sticker']) && !empty($data['sticker'])) {
				$sql .= " INNER JOIN ".DB_PREFIX."phpner_filter_product_sticker fpst USING (product_id)";
			}

			if (isset($data['option']) && !empty($data['option'])) {
				$sql .= " INNER JOIN ".DB_PREFIX."phpner_filter_product_option fpo USING (product_id)";
			}

			if (isset($data['attribute']) && !empty($data['attribute'])) {
				$sql .= " INNER JOIN ".DB_PREFIX."phpner_filter_product_attribute fpa USING (product_id)";
			}

			$sql .= "WHERE fpsd.product_id IN (".implode(',', $product_ids).") AND fpsd.language_id = '".(int)$language_id."' ";

			if (isset($data['standard']) && !empty($data['standard'])) {
				if ($data['filter_data']['standard_logic_between_standard'] == 'AND') {
					$implode_product_standards = array();

					foreach ($data['standard'] as $filter_name_mod => $filter_value_mod) {
						if (is_array($filter_value_mod)) {
							foreach ($filter_value_mod as $filter_value_mod_children) {
								if ($filter_value_mod_children) {
									$implode_product_standards[] = "fpsd.product_id IN (SELECT product_id FROM ".DB_PREFIX."phpner_filter_product_standard WHERE product_id = fpsd.product_id AND filter_name_mod = '".$this->db->escape($filter_name_mod)."' AND filter_value_mod = '".$this->db->escape($filter_value_mod_children)."' GROUP BY filter_value_mod)";
								}
							}
						} else {
							if ($filter_value_mod) {
								$implode_product_standards[] = "fpsd.product_id IN (SELECT product_id FROM ".DB_PREFIX."phpner_filter_product_standard WHERE product_id = fpsd.product_id AND filter_name_mod = '".$this->db->escape($filter_name_mod)."' AND filter_value_mod = '".$this->db->escape($filter_value_mod)."' GROUP BY filter_value_mod)";
							}
						}
					}

					if ($implode_product_standards) {
						$sql .= $data['filter_data']['standard_logic_with_other']." (" . implode(' AND ', $implode_product_standards) . ")";
					}
				}
			}

			if (isset($data['low_price']) && (isset($data['high_price']) && !empty($data['high_price']))) {
				$sql .= " AND ";
				/* 3359 */
				if (isset($data['special_only']) && !empty($data['special_only'])) {
					$sql .= "((SELECT ps.price FROM ".DB_PREFIX."product_special ps WHERE ps.product_id = p.product_id AND ps.customer_group_id = '".(int)$data['filter_data']['customer_group_id']."' AND ((ps.date_start = '0000-00-00' OR ps.date_start < NOW()) AND (ps.date_end = '0000-00-00' OR ps.date_end > NOW())) ORDER BY ps.priority ASC, ps.price ASC LIMIT 1) BETWEEN ".(float)$data['low_price']." AND ".(float)$data['high_price'].")";
				} else {
					$sql .= "((CASE WHEN(SELECT price FROM ".DB_PREFIX."product_special ps WHERE ps.product_id = p.product_id AND ps.customer_group_id = '".(int)$data['filter_data']['customer_group_id']."' AND ((ps.date_start = '0000-00-00' OR ps.date_start < NOW()) AND (ps.date_end = '0000-00-00' OR ps.date_end > NOW())) ORDER BY ps.priority ASC, ps.price ASC LIMIT 1) > 0 THEN (SELECT price FROM ".DB_PREFIX."product_special ps WHERE ps.product_id = p.product_id AND ps.customer_group_id = '".(int)$data['filter_data']['customer_group_id']."' AND ((ps.date_start = '0000-00-00' OR ps.date_start < NOW()) AND (ps.date_end = '0000-00-00' OR ps.date_end > NOW())) ORDER BY ps.priority ASC, ps.price ASC LIMIT 1) ELSE p.price END) BETWEEN ".(float)$data['low_price']." AND ".(float)$data['high_price'].")";
				}
				/* 3359 */
			}

			if (isset($data['manufacturer']) && !empty($data['manufacturer'])) {
				$sql .= " ".$data['filter_data']['manufacturer_logic_with_other']." (";

				if (is_array($data['manufacturer'])) {
					$implode_manufacturer = array();

					foreach ($data['manufacturer'] as $manufacturer) {
						$implode_manufacturer[] = "p.manufacturer_id = '".(int)$manufacturer."'";
					}

					if ($implode_manufacturer) {
						$sql .= "(".implode(' OR ', $implode_manufacturer).")";
					}
				} else {
					$sql .= "p.manufacturer_id = '".(int)$data['manufacturer']."'";
				}
				$sql .= ")";
			}

			if (isset($data['stock']) && !empty($data['stock'])) {
				$sql .= " ".$data['filter_data']['stock_logic_with_other']." (";

				if (is_array($data['stock'])) {
					$implode_stock = array();

					foreach ($data['stock'] as $stock) {
						if ($stock == 'in_stock') {
							$implode_stock[] = "p.quantity > '0'";
						} elseif($stock == 'out_of_stock') {
							$implode_stock[] = "p.quantity <= '0'";
						} elseif($stock == 'ending_stock') {
							$implode_stock[] = "(p.quantity BETWEEN '0' AND '".(int)$data['filter_data']['stock_ending_value']."')";	
						}
					}

					if ($implode_stock) {
						$sql .= implode(' '.$data['filter_data']['stock_logic_between_stock'].' ', $implode_stock);
					}
				} else {
					if ($data['stock'] == 'in_stock') {
						$sql .= "p.quantity > '0'";
					} elseif($data['stock'] == 'out_of_stock') {
						$sql .= "p.quantity <= '0'";
					} elseif($data['stock'] == 'ending_stock') {
						$sql .= "(p.quantity BETWEEN '0' AND '".(int)$data['filter_data']['stock_ending_value']."')";	
					}
				}
				$sql .= ")";
			}

			if (isset($data['rating']) && !empty($data['rating'])) {
				$implode_rating = array();

				if (is_array($data['rating'])) {
					foreach ($data['rating'] as $rating) {
						$implode_rating[] = "p.product_id IN (SELECT product_id FROM ".DB_PREFIX."review WHERE product_id = p.product_id AND rating = '".$rating."' AND status = '1' GROUP BY rating)";
					}
				} else {
					if ($data['rating']) {
						$implode_rating[] = "p.product_id IN (SELECT product_id FROM ".DB_PREFIX."review WHERE product_id = p.product_id AND rating = '".$data['rating']."' AND status = '1' GROUP BY rating)";
					}
				}

				if ($implode_rating) {
					$sql .= " ".$data['filter_data']['review_logic_with_other']." (" .implode(' '.$data['filter_data']['review_logic_between_review'].' ', $implode_rating) . ")";
				}
			}

			if (isset($data['sticker']) && !empty($data['sticker'])) {
				if ($data['filter_data']['sticker_logic_between_sticker'] == 'AND') {
					$implode_product_stickers = array();

					if (is_array($data['sticker'])) {
						foreach ($data['sticker'] as $product_sticker_id) {
							if ($product_sticker_id) {
								$implode_product_stickers[] = "fpst.product_id IN (SELECT product_id FROM ".DB_PREFIX."phpner_filter_product_sticker WHERE product_id = fpst.product_id AND product_sticker_id = '".(int)$product_sticker_id."' GROUP BY product_sticker_id)";
							}
						}
					} else {
						if ($data['sticker']) {
							$implode_product_stickers[] = "fpst.product_id IN (SELECT product_id FROM ".DB_PREFIX."phpner_filter_product_sticker WHERE product_id = fpst.product_id AND product_sticker_id = '".(int)$data['sticker']."' GROUP BY product_sticker_id)";
						}
					}

					if ($implode_product_stickers) {
						$sql .= " ".$data['filter_data']['sticker_logic_with_other']." (" . implode(' AND ', $implode_product_stickers) . ")";
					}
				} else {
					if (is_array($data['sticker'])) {
						$implode_product_stickers = array();

						foreach ($data['sticker'] as $product_sticker_id) {
							$implode_product_stickers[] = "fpst.product_sticker_id = '".(int)$product_sticker_id."'";
						}
					} else {
						$implode_product_stickers[] = "fpst.product_sticker_id = '".(int)$data['sticker']."'";
					}

					if ($implode_product_stickers) {
						$sql .= " ".$data['filter_data']['sticker_logic_with_other']." (".implode(' OR ', $implode_product_stickers).")";
					}
				}
			}

			if (isset($data['option']) && !empty($data['option'])) {
				if ($data['filter_data']['option_logic_between_option'] == 'AND') {
					$implode_product_options = array();

					foreach ($data['option'] as $option_name_mod => $option_value_id) {
						if (is_array($option_value_id)) {
							foreach ($option_value_id as $option_value_id_children) {
								if ($option_value_id_children) {
									$implode_product_options[] = "fpo.product_id IN (SELECT product_id FROM ".DB_PREFIX."phpner_filter_product_option WHERE product_id = fpo.product_id AND option_name_mod = '".$this->db->escape($option_name_mod)."' AND option_value_id = '".(int)$option_value_id_children."' GROUP BY option_value_id)";
								}
							}
						} else {
							if ($option_value_id) {
								$implode_product_options[] = "fpo.product_id IN (SELECT product_id FROM ".DB_PREFIX."phpner_filter_product_option WHERE product_id = fpo.product_id AND option_name_mod = '".$this->db->escape($option_name_mod)."' AND option_value_id = '".(int)$option_value_id."' GROUP BY option_value_id)";
							}
						}
					}

					if ($implode_product_options) {
						$sql .= " ".$data['filter_data']['option_logic_with_other']." (" . implode(' AND ', $implode_product_options) . ")";
					}
				} else {
					$implode_product_options = array();

					foreach ($data['option'] as $option_name_mod => $option_value_id) {
						if (is_array($option_value_id)) {
							foreach ($option_value_id as $option_value_id_children) {
								if ($option_value_id_children) {
									$implode_product_options[] = "(fpo.option_name_mod = '".$this->db->escape($option_name_mod)."' AND fpo.option_value_id = '".(int)$option_value_id_children."')";
								}
							}
						} else {
							if ($option_value_id) {
								$implode_product_options[] = "(fpo.option_name_mod = '".$this->db->escape($option_name_mod)."' AND fpo.option_value_id = '".(int)$option_value_id."')";
							}
						}
					}

					if ($implode_product_options) {
						$sql .= " ".$data['filter_data']['option_logic_with_other']." (" . implode(' OR ', $implode_product_options) . ")";
					}
				}
			}

			if (isset($data['attribute']) && !empty($data['attribute'])) {
				if ($data['filter_data']['attribute_logic_between_attribute'] == 'AND') {
					$implode_product_attributes = array();

					foreach ($data['attribute'] as $attribute_name_mod => $attribute_value_mod) {
						if (is_array($attribute_value_mod)) {
							foreach ($attribute_value_mod as $attribute_value_mod_children) {
								if ($attribute_value_mod_children) {
									$implode_product_attributes[] = "fpa.product_id = (SELECT product_id FROM ".DB_PREFIX."phpner_filter_product_attribute WHERE product_id = fpa.product_id AND attribute_name_mod = '".$this->db->escape($attribute_name_mod)."'  AND attribute_value_mod = '".$this->db->escape($attribute_value_mod_children)."' GROUP BY attribute_value_mod)";
								}
							}
						} else {
							if ($attribute_value_mod) {
								$implode_product_attributes[] = "fpa.product_id = (SELECT product_id FROM ".DB_PREFIX."phpner_filter_product_attribute WHERE product_id = fpa.product_id AND attribute_name_mod = '".$this->db->escape($attribute_name_mod)."' AND attribute_value_mod = '".$this->db->escape($attribute_value_mod)."' GROUP BY attribute_value_mod)";
							}
						}
					}

					if ($implode_product_attributes) {
						$sql .= " ".$data['filter_data']['attribute_logic_with_other']." (" . implode(' AND ', $implode_product_attributes) . ")";
					}
				} else {
					$implode_product_attributes = array();

					foreach ($data['attribute'] as $attribute_name_mod => $attribute_value_mod) {
						if (is_array($attribute_value_mod)) {
							foreach ($attribute_value_mod as $attribute_value_mod_children) {
								if ($attribute_value_mod_children) {
									$implode_product_attributes[] = "(fpa.attribute_name_mod = '".$this->db->escape($attribute_name_mod)."' AND fpa.attribute_value_mod = '".$this->db->escape($attribute_value_mod_children)."')";
								}
							}
						} else {
							if ($attribute_value_mod) {
								$implode_product_attributes[] = "(fpa.attribute_name_mod = '".$this->db->escape($attribute_name_mod)."' AND fpa.attribute_value_mod = '".$this->db->escape($attribute_value_mod)."')";
							}
						}
					}

					if ($implode_product_attributes) {
						$sql .= " ".$data['filter_data']['attribute_logic_with_other']." (" . implode(' OR ', $implode_product_attributes) . ")";
					}
				}
			}

			if (isset($data['tag']) && !empty($data['tag'])) {
				$sql .= " ".$data['filter_data']['tag_logic_with_other']." ";

				$implode_product_tag = array();
			
				$words = explode(' ', trim(preg_replace('/\s+/', ' ', $data['tag'])));
				
				foreach ($words as $word) {
					$implode_product_tag[] = "pd.tag LIKE '%".$this->db->escape($word)."%'";
				}

				if ($implode_product_tag) {
					$sql .= " ".implode(" AND ", $implode_product_tag)."";
				}

				$sql .= " AND pd.language_id = '".(int)$data['filter_data']['language_id']."'";
			}

			$sql .= " GROUP BY fpsd.filter_value_mod";

			// $log = new \Log('phpner_filter_debug.log');
		  // $log->write($sql);

			$query = $this->db->query($sql)->rows;

			$result = array();

			foreach ($query as $value) {
				$result[$value['filter_name_mod']][$value['filter_value_mod']] = $value['total'];
			}

			return $result;
		} else {
			return array();
		}
	}

	public function getProducts($data, $type) {
		$product_ids = $this->getProductIDs($data['global_id'], $data['global_type'], $data['filter_data']['store_id'], $data['filter_data']['customer_group_id']);

		if ($type == 'products') {
			$sql = "SELECT p.product_id, (SELECT AVG(rating) AS total FROM ".DB_PREFIX."review r1 WHERE r1.product_id = p.product_id AND r1.status = '1' GROUP BY r1.product_id) AS rating, (SELECT price FROM ".DB_PREFIX."product_discount pd2 WHERE pd2.product_id = p.product_id AND pd2.customer_group_id = '".(int)$data['filter_data']['customer_group_id']."' AND pd2.quantity = '1' AND ((pd2.date_start = '0000-00-00' OR pd2.date_start < NOW()) AND (pd2.date_end = '0000-00-00' OR pd2.date_end > NOW())) ORDER BY pd2.priority ASC, pd2.price ASC LIMIT 1) AS discount, (SELECT price FROM ".DB_PREFIX."product_special ps WHERE ps.product_id = p.product_id AND ps.customer_group_id = '".(int)$data['filter_data']['customer_group_id']."' AND ((ps.date_start = '0000-00-00' OR ps.date_start < NOW()) AND (ps.date_end = '0000-00-00' OR ps.date_end > NOW())) ORDER BY ps.priority ASC, ps.price ASC LIMIT 1) AS special";
		} else {
			$sql = "SELECT COUNT(DISTINCT p.product_id) as total, (SELECT AVG(rating) AS total FROM ".DB_PREFIX."review r1 WHERE r1.product_id = p.product_id AND r1.status = '1' GROUP BY r1.product_id) AS rating, (SELECT price FROM ".DB_PREFIX."product_discount pd2 WHERE pd2.product_id = p.product_id AND pd2.customer_group_id = '".(int)$data['filter_data']['customer_group_id']."' AND pd2.quantity = '1' AND ((pd2.date_start = '0000-00-00' OR pd2.date_start < NOW()) AND (pd2.date_end = '0000-00-00' OR pd2.date_end > NOW())) ORDER BY pd2.priority ASC, pd2.price ASC LIMIT 1) AS discount, (SELECT price FROM ".DB_PREFIX."product_special ps WHERE ps.product_id = p.product_id AND ps.customer_group_id = '".(int)$data['filter_data']['customer_group_id']."' AND ((ps.date_start = '0000-00-00' OR ps.date_start < NOW()) AND (ps.date_end = '0000-00-00' OR ps.date_end > NOW())) ORDER BY ps.priority ASC, ps.price ASC LIMIT 1) AS special";	
		}
		
		$sql .= " FROM ";

		$sql .= DB_PREFIX."product p";

		$sql .= " INNER JOIN ".DB_PREFIX."product_description pd USING (product_id) ";

		if (isset($data['sticker']) && !empty($data['sticker'])) {
			$sql .= " INNER JOIN ".DB_PREFIX."phpner_filter_product_sticker fpst USING (product_id)";
		}

		if (isset($data['option']) && !empty($data['option'])) {
			$sql .= " INNER JOIN ".DB_PREFIX."phpner_filter_product_option fpo USING (product_id)";
		}

		if (isset($data['attribute']) && !empty($data['attribute'])) {
			$sql .= " INNER JOIN ".DB_PREFIX."phpner_filter_product_attribute fpa USING (product_id)";
		}

		if (isset($data['standard']) && !empty($data['standard'])) {
			$sql .= " INNER JOIN ".DB_PREFIX."phpner_filter_product_standard fpsd USING (product_id)";
		}

		$sql .= " WHERE ";

		$sql .= "p.product_id IN (".implode(',', $product_ids).") AND pd.language_id = '".(int)$data['filter_data']['language_id']."'";

		if (isset($data['global_type'])) {
			if ($data['global_type'] == 'manufacturer') {
				if (isset($data['global_id']) && !empty($data['global_id'])) {
					$sql .= " AND p.manufacturer_id = '".(int)$data['global_id']."'";
				}
			}
		}

		if (isset($data['low_price']) && (isset($data['high_price']) && !empty($data['high_price']))) {
			$sql .= " AND ";
			/* 3359 */
			if (isset($data['special_only']) && !empty($data['special_only'])) {
				$sql .= "((SELECT ps.price FROM ".DB_PREFIX."product_special ps WHERE ps.product_id = p.product_id AND ps.customer_group_id = '".(int)$data['filter_data']['customer_group_id']."' AND ((ps.date_start = '0000-00-00' OR ps.date_start < NOW()) AND (ps.date_end = '0000-00-00' OR ps.date_end > NOW())) ORDER BY ps.priority ASC, ps.price ASC LIMIT 1) BETWEEN ".(float)$data['low_price']." AND ".(float)$data['high_price'].")";
			} else {
				$sql .= "((CASE WHEN(SELECT price FROM ".DB_PREFIX."product_special ps WHERE ps.product_id = p.product_id AND ps.customer_group_id = '".(int)$data['filter_data']['customer_group_id']."' AND ((ps.date_start = '0000-00-00' OR ps.date_start < NOW()) AND (ps.date_end = '0000-00-00' OR ps.date_end > NOW())) ORDER BY ps.priority ASC, ps.price ASC LIMIT 1) > 0 THEN (SELECT price FROM ".DB_PREFIX."product_special ps WHERE ps.product_id = p.product_id AND ps.customer_group_id = '".(int)$data['filter_data']['customer_group_id']."' AND ((ps.date_start = '0000-00-00' OR ps.date_start < NOW()) AND (ps.date_end = '0000-00-00' OR ps.date_end > NOW())) ORDER BY ps.priority ASC, ps.price ASC LIMIT 1) ELSE p.price END) BETWEEN ".(float)$data['low_price']." AND ".(float)$data['high_price'].")";
			}
			/* 3359 */
		}

		if (isset($data['manufacturer']) && !empty($data['manufacturer'])) {
			$sql .= " ".$data['filter_data']['manufacturer_logic_with_other']." (";

			if (is_array($data['manufacturer'])) {
				$implode_manufacturer = array();

				foreach ($data['manufacturer'] as $manufacturer) {
					$implode_manufacturer[] = "p.manufacturer_id = '".(int)$manufacturer."'";
				}

				if ($implode_manufacturer) {
					$sql .= "(".implode(' OR ', $implode_manufacturer).")";
				}
			} else {
				$sql .= "p.manufacturer_id = '".(int)$data['manufacturer']."'";
			}
			$sql .= ")";
		}

		if (isset($data['stock']) && !empty($data['stock'])) {
			$sql .= " ".$data['filter_data']['stock_logic_with_other']." (";

			if (is_array($data['stock'])) {
				$implode_stock = array();

				foreach ($data['stock'] as $stock) {
					if ($stock == 'in_stock') {
						$implode_stock[] = "p.quantity > '0'";
					} elseif($stock == 'out_of_stock') {
						$implode_stock[] = "p.quantity <= '0'";
					} elseif($stock == 'ending_stock') {
						$implode_stock[] = "(p.quantity BETWEEN '0' AND '".(int)$data['filter_data']['stock_ending_value']."')";	
					}
				}

				if ($implode_stock) {
					$sql .= implode(' '.$data['filter_data']['stock_logic_between_stock'].' ', $implode_stock);
				}
			} else {
				if ($data['stock'] == 'in_stock') {
					$sql .= "p.quantity > '0'";
				} elseif($data['stock'] == 'out_of_stock') {
					$sql .= "p.quantity <= '0'";
				} elseif($data['stock'] == 'ending_stock') {
					$sql .= "(p.quantity BETWEEN '0' AND '".(int)$data['filter_data']['stock_ending_value']."')";	
				}
			}
			$sql .= ")";
		}

		if (isset($data['rating']) && !empty($data['rating'])) {
			$implode_rating = array();

			if (is_array($data['rating'])) {
				foreach ($data['rating'] as $rating) {
					$implode_rating[] = "p.product_id IN (SELECT product_id FROM ".DB_PREFIX."review WHERE product_id = p.product_id AND rating = '".$rating."' AND status = '1' GROUP BY rating)";
				}
			} else {
				if ($data['rating']) {
					$implode_rating[] = "p.product_id IN (SELECT product_id FROM ".DB_PREFIX."review WHERE product_id = p.product_id AND rating = '".$data['rating']."' AND status = '1' GROUP BY rating)";
				}
			}

			if ($implode_rating) {
				$sql .= " ".$data['filter_data']['review_logic_with_other']." (" .implode(' '.$data['filter_data']['review_logic_between_review'].' ', $implode_rating) . ")";
			}
		}

		if (isset($data['sticker']) && !empty($data['sticker'])) {
			if ($data['filter_data']['sticker_logic_between_sticker'] == 'AND') {
				$implode_product_stickers = array();

				if (is_array($data['sticker'])) {
					foreach ($data['sticker'] as $product_sticker_id) {
						if ($product_sticker_id) {
							$implode_product_stickers[] = "fpst.product_id IN (SELECT product_id FROM ".DB_PREFIX."phpner_filter_product_sticker WHERE product_id = fpst.product_id AND product_sticker_id = '".(int)$product_sticker_id."' GROUP BY product_sticker_id)";
						}
					}
				} else {
					if ($data['sticker']) {
						$implode_product_stickers[] = "fpst.product_id IN (SELECT product_id FROM ".DB_PREFIX."phpner_filter_product_sticker WHERE product_id = fpst.product_id AND product_sticker_id = '".(int)$data['sticker']."' GROUP BY product_sticker_id)";
					}
				}

				if ($implode_product_stickers) {
					$sql .= " ".$data['filter_data']['sticker_logic_with_other']." (" . implode(' AND ', $implode_product_stickers) . ")";
				}
			} else {
				if (is_array($data['sticker'])) {
					$implode_product_stickers = array();

					foreach ($data['sticker'] as $product_sticker_id) {
						$implode_product_stickers[] = "fpst.product_sticker_id = '".(int)$product_sticker_id."'";
					}
				} else {
					$implode_product_stickers[] = "fpst.product_sticker_id = '".(int)$data['sticker']."'";
				}

				if ($implode_product_stickers) {
					$sql .= " ".$data['filter_data']['sticker_logic_with_other']." (".implode(' OR ', $implode_product_stickers).")";
				}
			}
		}

		if (isset($data['option']) && !empty($data['option'])) {
			if ($data['filter_data']['option_logic_between_option'] == 'AND') {
				$implode_product_options = array();

				foreach ($data['option'] as $option_name_mod => $option_value_id) {
					if (is_array($option_value_id)) {
						foreach ($option_value_id as $option_value_id_children) {
							if ($option_value_id_children) {
								$implode_product_options[] = "fpo.product_id IN (SELECT product_id FROM ".DB_PREFIX."phpner_filter_product_option WHERE product_id = fpo.product_id AND option_name_mod = '".$this->db->escape($option_name_mod)."' AND option_value_id = '".(int)$option_value_id_children."' GROUP BY option_value_id)";
							}
						}
					} else {
						if ($option_value_id) {
							$implode_product_options[] = "fpo.product_id IN (SELECT product_id FROM ".DB_PREFIX."phpner_filter_product_option WHERE product_id = fpo.product_id AND option_name_mod = '".$this->db->escape($option_name_mod)."' AND option_value_id = '".(int)$option_value_id."' GROUP BY option_value_id)";
						}
					}
				}

				if ($implode_product_options) {
					$sql .= " ".$data['filter_data']['option_logic_with_other']." (" . implode(' AND ', $implode_product_options) . ")";
				}
			} else {
				$implode_product_options = array();

				foreach ($data['option'] as $option_name_mod => $option_value_id) {
					if (is_array($option_value_id)) {
						foreach ($option_value_id as $option_value_id_children) {
							if ($option_value_id_children) {
								$implode_product_options[] = "(fpo.option_name_mod = '".$this->db->escape($option_name_mod)."' AND fpo.option_value_id = '".(int)$option_value_id_children."')";
							}
						}
					} else {
						if ($option_value_id) {
							$implode_product_options[] = "(fpo.option_name_mod = '".$this->db->escape($option_name_mod)."' AND fpo.option_value_id = '".(int)$option_value_id."')";
						}
					}
				}

				if ($implode_product_options) {
					$sql .= " ".$data['filter_data']['option_logic_with_other']." (" . implode(' OR ', $implode_product_options) . ")";
				}
			}
		}

		if (isset($data['attribute']) && !empty($data['attribute'])) {
			if ($data['filter_data']['attribute_logic_between_attribute'] == 'AND') {
				$implode_product_attributes = array();

				foreach ($data['attribute'] as $attribute_name_mod => $attribute_value_mod) {
					if (is_array($attribute_value_mod)) {
						foreach ($attribute_value_mod as $attribute_value_mod_children) {
							if ($attribute_value_mod_children) {
								$implode_product_attributes[] = "fpa.product_id IN (SELECT product_id FROM ".DB_PREFIX."phpner_filter_product_attribute WHERE product_id = fpa.product_id AND attribute_name_mod = '".$this->db->escape($attribute_name_mod)."'  AND attribute_value_mod = '".$this->db->escape($attribute_value_mod_children)."')";
							}
						}
					} else {
						if ($attribute_value_mod) {
							$implode_product_attributes[] = "fpa.product_id IN (SELECT product_id FROM ".DB_PREFIX."phpner_filter_product_attribute WHERE product_id = fpa.product_id AND attribute_name_mod = '".$this->db->escape($attribute_name_mod)."' AND attribute_value_mod = '".$this->db->escape($attribute_value_mod)."')";
						}
					}
				}

				if ($implode_product_attributes) {
					$sql .= " ".$data['filter_data']['attribute_logic_with_other']." (" . implode(' AND ', $implode_product_attributes) . ")";
				}
			} else {
				$implode_product_attributes = array();

				foreach ($data['attribute'] as $attribute_name_mod => $attribute_value_mod) {
					if (is_array($attribute_value_mod)) {
						foreach ($attribute_value_mod as $attribute_value_mod_children) {
							if ($attribute_value_mod_children) {
								$implode_product_attributes[] = "(fpa.attribute_name_mod = '".$this->db->escape($attribute_name_mod)."' AND fpa.attribute_value_mod = '".$this->db->escape($attribute_value_mod_children)."')";
							}
						}
					} else {
						if ($attribute_value_mod) {
							$implode_product_attributes[] = "(fpa.attribute_name_mod = '".$this->db->escape($attribute_name_mod)."' AND fpa.attribute_value_mod = '".$this->db->escape($attribute_value_mod)."')";
						}
					}
				}

				if ($implode_product_attributes) {
					$sql .= " ".$data['filter_data']['attribute_logic_with_other']." (" . implode(' OR ', $implode_product_attributes) . ")";
				}
			}
		}

		if (isset($data['standard']) && !empty($data['standard'])) {
			if ($data['filter_data']['standard_logic_between_standard'] == 'AND') {
				$implode_product_standards = array();

				foreach ($data['standard'] as $filter_name_mod => $filter_value_mod) {
					if (is_array($filter_value_mod)) {
						foreach ($filter_value_mod as $filter_value_mod_children) {
							if ($filter_value_mod_children) {
								$implode_product_standards[] = "fpsd.product_id IN (SELECT product_id FROM ".DB_PREFIX."phpner_filter_product_standard WHERE product_id = fpsd.product_id AND filter_name_mod = '".$this->db->escape($filter_name_mod)."' AND filter_value_mod = '".$this->db->escape($filter_value_mod_children)."' GROUP BY filter_value_mod)";
							}
						}
					} else {
						if ($filter_value_mod) {
							$implode_product_standards[] = "fpsd.product_id = (SELECT product_id FROM ".DB_PREFIX."phpner_filter_product_standard WHERE product_id = fpsd.product_id AND filter_name_mod = '".$this->db->escape($filter_name_mod)."' AND filter_value_mod IN ('".$this->db->escape($filter_value_mod)."') GROUP BY filter_value_mod)";
						}
					}
				}

				if ($implode_product_standards) {
					$sql .= " ".$data['filter_data']['standard_logic_with_other']." (" . implode(' AND ', $implode_product_standards) . ")";
				}
			} else {
				$implode_product_standards = array();

				foreach ($data['standard'] as $filter_name_mod => $filter_value_mod) {
					if (is_array($filter_value_mod)) {
						foreach ($filter_value_mod as $filter_value_mod_children) {
							if ($filter_value_mod_children) {
								$implode_product_standards[] = "(fpsd.filter_name_mod = '".$this->db->escape($filter_name_mod)."' AND fpsd.filter_value_mod = '".$this->db->escape($filter_value_mod_children)."')";
							}
						}
					} else {
						if ($filter_value_mod) {
							$implode_product_standards[] = "(fpsd.filter_name_mod = '".$this->db->escape($filter_name_mod)."' AND fpsd.filter_value_mod = '".$this->db->escape($filter_value_mod)."')";
						}
					}
				}

				if ($implode_product_standards) {
					$sql .= " ".$data['filter_data']['standard_logic_with_other']." (" . implode(' OR ', $implode_product_standards) . ")";
				}
			}
		}

		if (isset($data['tag']) && !empty($data['tag'])) {
			$sql .= " ".$data['filter_data']['tag_logic_with_other']." ";

			$implode_product_tag = array();
		
			$words = explode(' ', trim(preg_replace('/\s+/', ' ', $data['tag'])));
			
			foreach ($words as $word) {
				$implode_product_tag[] = "pd.tag LIKE '%".$this->db->escape($word)."%'";
			}

			if ($implode_product_tag) {
				$sql .= " ".implode(" AND ", $implode_product_tag)."";
			}
		}

		if ($type == 'products') {
			$sql .= " GROUP BY p.product_id";

			$sort_data = array(
				'pd.name',
				'p.model',
				'p.quantity',
				'p.price',
				'rating',
				'p.sort_order',
				'p.date_added',
				'p.viewed'
			);

			/*3359*/
			$phpner_product_filter_data = $this->config->get('phpner_product_filter_data');
			
			if (!isset($phpner_product_filter_data['no_quantity_last'])) {
				$phpner_product_filter_data['no_quantity_last'] = 1;
			}
			
			if (isset($data['sort']) && in_array($data['sort'], $sort_data)) {
				if ($data['sort'] == 'pd.name' || $data['sort'] == 'p.model') {
					$sql .= " ORDER BY ";
					if (isset($phpner_product_filter_data['no_quantity_last']) && $phpner_product_filter_data['no_quantity_last']) {
						$sql .= "p.quantity > 0 DESC, ";
					}
					$sql .= "LCASE(" . $data['sort'] . ")";
				} elseif ($data['sort'] == 'p.price') {
					$sql .= " ORDER BY ";
					if (isset($phpner_product_filter_data['no_quantity_last']) && $phpner_product_filter_data['no_quantity_last']) {
						$sql .= "p.quantity > 0 DESC, ";
					}
					$sql .= "(CASE WHEN special IS NOT NULL THEN special WHEN discount IS NOT NULL THEN discount ELSE p.price END)";
				} else {
					$sql .= " ORDER BY ";
					if (isset($phpner_product_filter_data['no_quantity_last']) && $phpner_product_filter_data['no_quantity_last']) {
						$sql .= "p.quantity > 0 DESC, ";
					}
					$sql .= $data['sort'];
				}
			} else {
				$sql .= " ORDER BY ";
				if (isset($phpner_product_filter_data['no_quantity_last']) && $phpner_product_filter_data['no_quantity_last']) {
					$sql .= "p.quantity > 0 DESC, ";
				}
				$sql .= "p.sort_order";
			}
			/*3359*/

			if (isset($data['order']) && (strtoupper($data['order']) == 'DESC')) {
				$sql .= " DESC, LCASE(pd.name) DESC";
			} else {
				$sql .= " ASC, LCASE(pd.name) ASC";
			}

			if (isset($data['start']) || isset($data['limit'])) {
				if ($data['start'] < 0) {
					$data['start'] = 0;
				}

				if ($data['limit'] < 1) {
					$data['limit'] = 20;
				}

				$sql .= " LIMIT ".(int)$data['start'].",".(int)$data['limit'];
			}

			// $log = new \Log('phpner_filter_debug.log');
		 //  $log->write($sql);

			$query = $this->db->query($sql)->rows;

			$result = array();

			if ($this->checkphpner_IfTableExist(DB_PREFIX . "manufacturer_description") && $this->checkIfColumnExist(DB_PREFIX . "manufacturer_description", "name")) {
			  $sql_manufacturer_select = "(SELECT md.name FROM " . DB_PREFIX . "manufacturer_description md WHERE md.manufacturer_id = p.manufacturer_id AND md.language_id = '" . (int)$data['filter_data']['language_id'] . "') AS manufacturer";
			} else {
				$sql_manufacturer_select = "m.name AS manufacturer";
			}

			foreach ($query as $value) {
				$query = $this->db->query("SELECT DISTINCT *, pd.name AS name, p.image, " . $sql_manufacturer_select . ", (SELECT price FROM " . DB_PREFIX . "product_discount pd2 WHERE pd2.product_id = p.product_id AND pd2.customer_group_id = '" . (int)$data['filter_data']['customer_group_id'] . "' AND pd2.quantity = '1' AND ((pd2.date_start = '0000-00-00' OR pd2.date_start < NOW()) AND (pd2.date_end = '0000-00-00' OR pd2.date_end > NOW())) ORDER BY pd2.priority ASC, pd2.price ASC LIMIT 1) AS discount, (SELECT price FROM " . DB_PREFIX . "product_special ps WHERE ps.product_id = p.product_id AND ps.customer_group_id = '" . (int)$data['filter_data']['customer_group_id'] . "' AND ((ps.date_start = '0000-00-00' OR ps.date_start < NOW()) AND (ps.date_end = '0000-00-00' OR ps.date_end > NOW())) ORDER BY ps.priority ASC, ps.price ASC LIMIT 1) AS special, (SELECT points FROM " . DB_PREFIX . "product_reward pr WHERE pr.product_id = p.product_id AND customer_group_id = '" . (int)$data['filter_data']['customer_group_id'] . "') AS reward, (SELECT ss.name FROM " . DB_PREFIX . "stock_status ss WHERE ss.stock_status_id = p.stock_status_id AND ss.language_id = '" . (int)$data['filter_data']['language_id'] . "') AS stock_status, (SELECT wcd.unit FROM " . DB_PREFIX . "weight_class_description wcd WHERE p.weight_class_id = wcd.weight_class_id AND wcd.language_id = '" . (int)$data['filter_data']['language_id'] . "') AS weight_class, (SELECT lcd.unit FROM " . DB_PREFIX . "length_class_description lcd WHERE p.length_class_id = lcd.length_class_id AND lcd.language_id = '" . (int)$data['filter_data']['language_id'] . "') AS length_class, (SELECT AVG(rating) AS total FROM " . DB_PREFIX . "review r1 WHERE r1.product_id = p.product_id AND r1.status = '1' GROUP BY r1.product_id) AS rating, (SELECT COUNT(*) AS total FROM " . DB_PREFIX . "review r2 WHERE r2.product_id = p.product_id AND r2.status = '1' GROUP BY r2.product_id) AS reviews, p.sort_order FROM " . DB_PREFIX . "product p LEFT JOIN " . DB_PREFIX . "product_description pd ON (p.product_id = pd.product_id) LEFT JOIN " . DB_PREFIX . "manufacturer m ON (p.manufacturer_id = m.manufacturer_id) WHERE p.product_id = '" . (int)$value['product_id'] . "' AND pd.language_id = '".(int)$data['filter_data']['language_id']."'");

				if ($query->num_rows) {
					$result[] = array(
						// phpner_product_stickers start
						'phpner_product_stickers' => (isset($query->row['phpner_product_stickers'])) ? $query->row['phpner_product_stickers'] : array(),
						// phpner_product_stickers end
						// phpner_product_preorder start
						'phpner_stock_status_id'  => $query->row['stock_status_id'],
						// phpner_product_preorder end
						'product_id'           => $query->row['product_id'],
						'name'                 => $query->row['name'],
						'description'          => $query->row['description'],
						'meta_title'           => $query->row['meta_title'],
						'meta_h1'              => (isset($query->row['meta_h1'])) ? $query->row['meta_h1'] : '',
						'meta_description'     => $query->row['meta_description'],
						'meta_keyword'         => $query->row['meta_keyword'],
						'tag'                  => $query->row['tag'],
						'model'                => $query->row['model'],
						'sku'                  => $query->row['sku'],
						'upc'                  => $query->row['upc'],
						'ean'                  => $query->row['ean'],
						'jan'                  => $query->row['jan'],
						'isbn'                 => $query->row['isbn'],
						'mpn'                  => $query->row['mpn'],
						'location'             => $query->row['location'],
						'quantity'             => $query->row['quantity'],
						'stock_status'         => $query->row['stock_status'],
						'image'                => $query->row['image'],
						'manufacturer_id'      => $query->row['manufacturer_id'],
						'manufacturer'         => $query->row['manufacturer'],
						'price'                => ($query->row['discount'] ? $query->row['discount'] : $query->row['price']),
						'special'              => $query->row['special'],
						'reward'               => $query->row['reward'],
						'points'               => $query->row['points'],
						'tax_class_id'         => $query->row['tax_class_id'],
						'date_available'       => $query->row['date_available'],
						'weight'               => $query->row['weight'],
						'weight_class_id'      => $query->row['weight_class_id'],
						'length'               => $query->row['length'],
						'width'                => $query->row['width'],
						'height'               => $query->row['height'],
						'length_class_id'      => $query->row['length_class_id'],
						'subtract'             => $query->row['subtract'],
						'rating'               => round($query->row['rating']),
						'reviews'              => $query->row['reviews'] ? $query->row['reviews'] : 0,
						'minimum'              => $query->row['minimum'],
						'sort_order'           => $query->row['sort_order'],
						'status'               => $query->row['status'],
						'date_added'           => $query->row['date_added'],
						'date_modified'        => $query->row['date_modified'],
						'viewed'               => $query->row['viewed']
					);
				}
			}

			return $result;
		} else {
			return $this->db->query($sql)->row['total'];
		}
	}

	public function getSeo($seo_url) {
    return $this->db->query("
    	SELECT 
    		seo_url, 
				seo_title, 
				seo_h1, 
				seo_meta_description, 
				seo_meta_keywords, 
				seo_description 
    	FROM ".DB_PREFIX."phpner_filter_product_seo pfs 
    	LEFT JOIN ".DB_PREFIX."phpner_filter_product_seo_description pfsd ON (pfs.seo_id = pfsd.seo_id) 
      WHERE 
        pfsd.seo_url = '".$this->db->escape($seo_url)."' 
      AND 
      	pfs.status = '1' 
      AND 
      	pfsd.language_id = '".(int)$this->config->get('config_language_id')."'
    ")->row;
  }

  public function getSeos($data = array()) {
    $sql = "
      SELECT 
        DISTINCT * 
      FROM ".DB_PREFIX."phpner_filter_product_seo fps 
      LEFT JOIN ".DB_PREFIX."phpner_filter_product_seo_description fpsd ON (fps.seo_id = fpsd.seo_id) 
      WHERE 
        fpsd.language_id = '".(int)$this->config->get('config_language_id')."' 
      ORDER BY 
      	fps.date_added DESC
    ";

    return $this->db->query($sql)->rows;
  }

	public function checkphpner_IfTableExist($table_name) {
    $query = $this->db->query("SELECT COUNT(*) as total FROM information_schema.TABLES WHERE TABLE_SCHEMA = '".DB_DATABASE."' AND TABLE_NAME = '".$table_name."'")->row['total'];

    return $query;
  }

  public function checkIfColumnExist($table_name, $table_column) {
    $query = $this->db->query("SELECT COUNT(*) as total FROM information_schema.COLUMNS WHERE TABLE_SCHEMA = '".DB_DATABASE."' AND TABLE_NAME = '".$table_name."' AND COLUMN_NAME  = '".$table_column."'")->row['total'];

    return $query;
  }
}