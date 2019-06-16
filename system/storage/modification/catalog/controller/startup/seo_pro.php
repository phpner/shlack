<?php
class ControllerStartupSeoPro extends Controller {
	private $cache_data = null;

	public function __construct($registry) {
		parent::__construct($registry);
		$this->cache_data = $this->cache->get('seo_pro');
		if (!$this->cache_data) {
			$query = $this->db->query("SELECT LOWER(`keyword`) as 'keyword', `query` FROM " . DB_PREFIX . "url_alias ORDER BY url_alias_id");
			$this->cache_data = array();
			foreach ($query->rows as $row) {
				if (isset($this->cache_data['keywords'][$row['keyword']])){
					$this->cache_data['keywords'][$row['query']] = $this->cache_data['keywords'][$row['keyword']];
					continue;
				}
				$this->cache_data['keywords'][$row['keyword']] = $row['query'];
				$this->cache_data['queries'][$row['query']] = $row['keyword'];
			}
			$this->cache->set('seo_pro', $this->cache_data);
		}
	}

	public function index() {

		// Add rewrite to url class
		if ($this->config->get('config_seo_url')) {
			$this->url->addRewrite($this);
		} else {
			return;
		}

		// Decode URL

      // SEO phpner_ product filter: start
      $phpner_product_filter_data = $this->config->get('phpner_product_filter_data');
      $phpner_product_filter_status = $this->config->get('phpner_product_filter_status');
      
      if ($phpner_product_filter_status && isset($phpner_product_filter_data['enable_seo']) && $phpner_product_filter_data['enable_seo'] && (isset($this->request->get['phpner_filter']) || preg_match('/filter/', $this->request->server['REQUEST_URI']))) {
        $phpner_filter_url = explode("/", $this->request->server['REQUEST_URI']);
        
        // SEO global filter: start
        $this->cache_data['keywords']['filter'] = 'phpner_filter=1';
        $this->cache_data['queries']['phpner_filter=1'] = 'filter';
        // SEO global filter: end

        // SEO special only: start
        $this->cache_data['keywords']['special-only'] = 'special_only=1';
        $this->cache_data['queries']['special_only=1'] = 'special-only';
        // SEO special only: end

        // SEO price: start
        if (preg_match('/price-[0-9]{1,}-[0-9]{1,}/', $this->request->server['REQUEST_URI'])) {
          preg_match('/price-[0-9]{1,}-[0-9]{1,}/', $this->request->server['REQUEST_URI'], $matches);

          $phpner_filter_price = explode('-', $matches[0]);

          $min_price = preg_replace("/[^.0-9]/", '', $phpner_filter_price[1]);
          $max_price = preg_replace("/[^.0-9]/", '', $phpner_filter_price[2]);

          $this->cache_data['keywords']['price-'.$min_price.'-'.$max_price] = 'price='.$min_price.','.$max_price;
          $this->cache_data['queries']['price='.$min_price.','.$max_price] = 'price-'.$min_price.'-'.$max_price;
        } elseif (isset($this->session->data['low_price']) && isset($this->session->data['high_price'])) {
          $min_price = floor($this->session->data['low_price']);
          $max_price = ceil($this->session->data['high_price']);

          $this->cache_data['keywords']['price-'.$min_price.'-'.$max_price] = 'price='.$min_price.','.$max_price;
          $this->cache_data['queries']['price='.$min_price.','.$max_price] = 'price-'.$min_price.'-'.$max_price;
        }
        // SEO price: end

        // SEO tag: start
        if (preg_match('/tag-[a-z0-9(_|.)]{1,}/', $this->request->server['REQUEST_URI'])) {
          preg_match('/tag-[a-z0-9(_|.)]{1,}/', $this->request->server['REQUEST_URI'], $matches);

          $phpner_filter_tag = explode('-', $matches[0]);

          $this->cache_data['keywords']['tag-'.$phpner_filter_tag[1]] = 'tag='.$phpner_filter_tag[1];
          $this->cache_data['queries']['tag='.$phpner_filter_tag[1]] = 'tag-'.$phpner_filter_tag[1];
        } elseif (isset($this->request->get['tag'])) {
          $this->cache_data['keywords']['tag-'.$this->request->get['tag']] = 'tag='.$this->request->get['tag'];
          $this->cache_data['queries']['tag='.$this->request->get['tag']] = 'tag-'.$this->request->get['tag'];
        } elseif (isset($this->session->data['phpner_tag'])) {
          $this->cache_data['keywords']['tag-'.$this->session->data['phpner_tag']] = 'tag='.$this->session->data['phpner_tag'];
          $this->cache_data['queries']['tag='.$this->session->data['phpner_tag']] = 'tag-'.$this->session->data['phpner_tag'];
        }
        // SEO tag: end

        // SEO brand: start
        if (in_array("filter", $phpner_filter_url)) {
          foreach ($phpner_filter_url as $manufacturer_url_item) {
            $manufacturer_query_query = $this->db->query("SELECT query FROM " . DB_PREFIX . "url_alias WHERE keyword = '" . $this->db->escape($manufacturer_url_item) . "'");
            
            if ($manufacturer_query_query->num_rows) {
              if (preg_match('/manufacturer_id=[0-9]{1,}/', $manufacturer_query_query->row['query'])) {
                preg_match('/manufacturer_id=[0-9]{1,}/', $manufacturer_query_query->row['query'], $manufacturer_id);
                preg_match('/[0-9]{1,}/', $manufacturer_id[0], $query_value);

                if (isset($query_value[0]) && !preg_match('/brand_page=true/', $this->request->server['REQUEST_URI'])) {
                  $this->cache_data['keywords'][$manufacturer_url_item] = 'm_n_'.$query_value[0].'='.$query_value[0];
                  $this->cache_data['queries']['m_n_'.$query_value[0].'='.$query_value[0]] = $manufacturer_url_item;
                }
              }
            }
          }
        } elseif (isset($this->session->data['phpner_brand'])) {
          preg_match_all('/m_n_[0-9]{1,}=[0-9]{1,}+/', ltrim($this->session->data['phpner_brand'], "&"), $manufacturer_get_values);

          if (isset($manufacturer_get_values[0])) {
            foreach ($manufacturer_get_values[0] as $manufacturer_get_value) {
              $manufacturer_get_values_res = rtrim($manufacturer_get_value, "&");
              if (preg_match('/m_n_[0-9]{1,}/', $manufacturer_get_values_res)) {
                preg_match('/m_n_[0-9]{1,}/', $manufacturer_get_values_res, $manufacturer_value);
                preg_match('/=([0-9]{1,})/', $manufacturer_get_values_res, $manufacturer_id);
                
                if (isset($manufacturer_value[0]) && isset($manufacturer_id[1])) {
                  $manufacturer_query_keyword = $this->db->query("SELECT LOWER(`keyword`) as 'keyword' FROM " . DB_PREFIX . "url_alias WHERE query = '" . $this->db->escape('manufacturer_id='.$manufacturer_id[1]) . "'")->row['keyword'];
            
                  if ($manufacturer_query_keyword) {
                    $this->cache_data['keywords'][$manufacturer_query_keyword] = $manufacturer_value[0].'='.$manufacturer_id[1];
                    $this->cache_data['queries'][$manufacturer_value[0].'='.$manufacturer_id[1]] = $manufacturer_query_keyword;
                  }
                }
              }
            }
          }
        }
        // SEO brand: end

        // SEO attribute: start
        if (in_array("filter", $phpner_filter_url)) {
          foreach ($phpner_filter_url as $attribute_url_item) {
            $query_attribute_name_mod = $this->db->query("SELECT filter_attribute_id FROM " . DB_PREFIX . "phpner_filter_product_attribute WHERE attribute_name_mod = '" . $this->db->escape($attribute_url_item) . "'")->num_rows;
            
            if ($query_attribute_name_mod) {
              $this->cache_data['keywords'][$attribute_url_item] = 'a_nm_'.$attribute_url_item.'='.$attribute_url_item;
              $this->cache_data['queries']['a_nm_'.$attribute_url_item.'='.$attribute_url_item] = $attribute_url_item;
            }

            $query_attribute_value_mod = $this->db->query("SELECT filter_attribute_id FROM " . DB_PREFIX . "phpner_filter_product_attribute WHERE attribute_value_mod = '" . $this->db->escape($attribute_url_item) . "'")->num_rows;

            if ($query_attribute_value_mod) {
              $this->cache_data['keywords'][$attribute_url_item] = 'a_vm_'.$attribute_url_item.'='.$attribute_url_item;
              $this->cache_data['queries']['a_vm_'.$attribute_url_item.'='.$attribute_url_item] = $attribute_url_item;
            }

          }
        } elseif (isset($this->session->data['phpner_attribute'])) {
          preg_match_all('/a_nm_[a-z0-9_]{1,}=[a-z0-9_]{1,}(&a_vm_[a-z0-9_]{1,}=[a-z0-9_]{1,}(.*?){1,})+/', ltrim($this->session->data['phpner_attribute'], "&"), $attribute_get_values);

          if (isset($attribute_get_values[0])) {
            foreach ($attribute_get_values[0] as $attribute_get_value) {
              $attribute_get_values_res = rtrim($attribute_get_value, "&");

              if (preg_match('/a_nm_[a-z0-9_]{1,}/', $attribute_get_values_res)) {

                preg_match('/a_nm_[a-z0-9_]{1,}/', $attribute_get_values_res, $attribute_group_id);
                preg_match('/a_nm_[a-z0-9_]{1,}=([a-z0-9_]{1,})/', $attribute_get_values_res, $attribute_group_value);
                
                $this->cache_data['keywords'][$attribute_group_value[1]] = $attribute_group_id[0].'='.$attribute_group_value[1];
                $this->cache_data['queries'][$attribute_group_id[0].'='.$attribute_group_value[1]] = $attribute_group_value[1];
              }

              if (preg_match('/a_vm_[a-z0-9_]{1,}/', $attribute_get_values_res)) {

                if (preg_match_all('/a_vm_[a-z0-9_]{1,}=[a-z0-9_]{1,}(.*?){1,}/', $attribute_get_values_res)) {
                  preg_match_all('/a_vm_[a-z0-9_]{1,}=[a-z0-9_]{1,}(.*?){1,}/', $attribute_get_values_res, $attribute_get_values_res_array);
                  
                  if (isset($attribute_get_values_res_array[0])) {
                    foreach ($attribute_get_values_res_array[0] as $attribute_get_values_res_array_value) {
                      preg_match('/a_vm_[a-z0-9_]{1,}/', $attribute_get_values_res_array_value, $attribute_group_id);
                      preg_match('/a_vm_[a-z0-9_]{1,}=([a-z0-9_]{1,})/', $attribute_get_values_res_array_value, $attribute_group_value);
    
                      $this->cache_data['keywords'][$attribute_group_value[1]] = $attribute_group_id[0].'='.$attribute_group_value[1];
                      $this->cache_data['queries'][$attribute_group_id[0].'='.$attribute_group_value[1]] = $attribute_group_value[1];
                    }
                  }
                }
              }
            }
          }
        }
        // SEO attribute: end

        // SEO option: start
        if (in_array("filter", $phpner_filter_url)) {
          foreach ($phpner_filter_url as $option_url_item) {
            $query_option_name_mod = $this->db->query("SELECT filter_option_id FROM " . DB_PREFIX . "phpner_filter_product_option WHERE option_name_mod = '" . $this->db->escape($option_url_item) . "'")->num_rows;
            
            if ($query_option_name_mod) {
              $this->cache_data['keywords'][$option_url_item] = 'o_nm_'.$option_url_item.'='.$option_url_item;
              $this->cache_data['queries']['o_nm_'.$option_url_item.'='.$option_url_item] = $option_url_item;
            }

            $query_option_value_id = $this->db->query("SELECT option_value_id FROM " . DB_PREFIX . "phpner_filter_product_option WHERE option_value_name_mod = '" . $this->db->escape($option_url_item) . "' GROUP BY option_value_id");

            if ($query_option_value_id->num_rows) {
              $this->cache_data['keywords'][$option_url_item] = 'o_vm_'.$query_option_value_id->row['option_value_id'].'='.$query_option_value_id->row['option_value_id'];
              $this->cache_data['queries']['o_vm_'.$query_option_value_id->row['option_value_id'].'='.$query_option_value_id->row['option_value_id']] = $option_url_item;
            }

          }
        } elseif (isset($this->session->data['phpner_option'])) {
          preg_match_all('/o_nm_[a-z0-9_]{1,}=[a-z0-9_]{1,}(&o_vm_[0-9]{1,}=[0-9]{1,}(.*?){1,})+/', ltrim($this->session->data['phpner_option'], "&"), $option_get_values);

          if (isset($option_get_values[0])) {
            foreach ($option_get_values[0] as $option_get_value) {
              $option_get_values_res = rtrim($option_get_value, "&");

              if (preg_match('/o_nm_[a-z0-9_]{1,}/', $option_get_values_res)) {

                preg_match('/o_nm_[a-z0-9_]{1,}/', $option_get_values_res, $option_group_id);
                preg_match('/o_nm_[a-z0-9_]{1,}=([a-z0-9_]{1,})/', $option_get_values_res, $option_group_value);
                
                $this->cache_data['keywords'][$option_group_value[1]] = $option_group_id[0].'='.$option_group_value[1];
                $this->cache_data['queries'][$option_group_id[0].'='.$option_group_value[1]] = $option_group_value[1];
              }

              if (preg_match('/o_vm_[0-9]{1,}/', $option_get_values_res)) {

                if (preg_match_all('/o_vm_[0-9]{1,}=[0-9]{1,}(.*?){1,}/', $option_get_values_res)) {
                  preg_match_all('/o_vm_[0-9]{1,}=[0-9]{1,}(.*?){1,}/', $option_get_values_res, $option_get_values_res_array);
                  
                  if (isset($option_get_values_res_array[0])) {
                    foreach ($option_get_values_res_array[0] as $option_get_values_res_array_value) {
                      preg_match('/o_vm_[0-9]{1,}/', $option_get_values_res_array_value, $option_group_id);
                      preg_match('/o_vm_[0-9]{1,}=([0-9]{1,})/', $option_get_values_res_array_value, $option_group_value);

                      if (isset($option_group_value[1])) {
                        $query_option_value_mod = $this->db->query("SELECT option_value_name_mod FROM " . DB_PREFIX . "phpner_filter_product_option WHERE option_value_id = '" . (int)$option_group_value[1] . "' GROUP BY option_value_id");
      
                        if ($query_option_value_mod->num_rows) {
                          $this->cache_data['keywords'][$query_option_value_mod->row['option_value_name_mod']] = $option_group_id[0].'='.$option_group_value[1];
                          $this->cache_data['queries'][$option_group_id[0].'='.$option_group_value[1]] = $query_option_value_mod->row['option_value_name_mod'];
                        }
                      }
                    }
                  }
                }
              }
            }
          }
        }
        // SEO option: end

        // SEO standard: start
        if (in_array("filter", $phpner_filter_url)) {
          foreach ($phpner_filter_url as $standard_url_item) {
            $query_filter_name_mod = $this->db->query("SELECT filter_filter_id FROM " . DB_PREFIX . "phpner_filter_product_standard WHERE filter_name_mod = '" . $this->db->escape($standard_url_item) . "'")->num_rows;
            
            if ($query_filter_name_mod) {
              $this->cache_data['keywords'][$standard_url_item] = 's_nm_'.$standard_url_item.'='.$standard_url_item;
              $this->cache_data['queries']['s_nm_'.$standard_url_item.'='.$standard_url_item] = $standard_url_item;
            }

            $query_standard_value_mod = $this->db->query("SELECT filter_filter_id FROM " . DB_PREFIX . "phpner_filter_product_standard WHERE filter_value_mod = '" . $this->db->escape($standard_url_item) . "'")->num_rows;

            if ($query_standard_value_mod) {
              $this->cache_data['keywords'][$standard_url_item] = 's_vm_'.$standard_url_item.'='.$standard_url_item;
              $this->cache_data['queries']['s_vm_'.$standard_url_item.'='.$standard_url_item] = $standard_url_item;
            }

          }
        } elseif (isset($this->session->data['phpner_standard'])) {
          preg_match_all('/s_nm_[a-z0-9_]{1,}=[a-z0-9_]{1,}(&s_vm_[a-z0-9_]{1,}=[a-z0-9_]{1,}(.*?){1,})+/', ltrim($this->session->data['phpner_standard'], "&"), $standard_get_values);

          if (isset($standard_get_values[0])) {
            foreach ($standard_get_values[0] as $standard_get_value) {
              $standard_get_values_res = rtrim($standard_get_value, "&");

              if (preg_match('/s_nm_[a-z0-9_]{1,}/', $standard_get_values_res)) {

                preg_match('/s_nm_[a-z0-9_]{1,}/', $standard_get_values_res, $standard_group_id);
                preg_match('/s_nm_[a-z0-9_]{1,}=([a-z0-9_]{1,})/', $standard_get_values_res, $standard_group_value);
                
                $this->cache_data['keywords'][$standard_group_value[1]] = $standard_group_id[0].'='.$standard_group_value[1];
                $this->cache_data['queries'][$standard_group_id[0].'='.$standard_group_value[1]] = $standard_group_value[1];
              }

              if (preg_match('/s_vm_[a-z0-9_]{1,}/', $standard_get_values_res)) {

                if (preg_match_all('/s_vm_[a-z0-9_]{1,}=[a-z0-9_]{1,}(.*?){1,}/', $standard_get_values_res)) {
                  preg_match_all('/s_vm_[a-z0-9_]{1,}=[a-z0-9_]{1,}(.*?){1,}/', $standard_get_values_res, $standard_get_values_res_array);
                  
                  if (isset($standard_get_values_res_array[0])) {
                    foreach ($standard_get_values_res_array[0] as $standard_get_values_res_array_value) {
                      preg_match('/s_vm_[a-z0-9_]{1,}/', $standard_get_values_res_array_value, $standard_group_id);
                      preg_match('/s_vm_[a-z0-9_]{1,}=([a-z0-9_]{1,})/', $standard_get_values_res_array_value, $standard_group_value);
    
                      $this->cache_data['keywords'][$standard_group_value[1]] = $standard_group_id[0].'='.$standard_group_value[1];
                      $this->cache_data['queries'][$standard_group_id[0].'='.$standard_group_value[1]] = $standard_group_value[1];
                    }
                  }
                }
              }
            }
          }
        }
        // SEO standard: end

        // SEO sticker: start
        if (in_array("filter", $phpner_filter_url)) {
          foreach ($phpner_filter_url as $sticker_url_item) {
            $sticker_query_query = $this->db->query("SELECT product_sticker_id FROM " . DB_PREFIX . "phpner_filter_product_sticker WHERE product_sticker_value_mod = '" . $this->db->escape($sticker_url_item) . "' AND language_id ='".(int)$this->config->get('config_language_id')."' GROUP BY product_sticker_id");
            
            if ($sticker_query_query->num_rows) {
              $this->cache_data['keywords'][$sticker_url_item] = 'st_'.$sticker_query_query->row['product_sticker_id'].'='.$sticker_query_query->row['product_sticker_id'];
              $this->cache_data['queries']['st_'.$sticker_query_query->row['product_sticker_id'].'='.$sticker_query_query->row['product_sticker_id']] = $sticker_url_item;          
            }
          }
        } elseif (isset($this->session->data['phpner_sticker'])) {
          preg_match_all('/st_[0-9]{1,}=[0-9]{1,}+/', ltrim($this->session->data['phpner_sticker'], "&"), $sticker_get_values);

          if (isset($sticker_get_values[0])) {
            foreach ($sticker_get_values[0] as $sticker_get_value) {
              $sticker_get_values_res = rtrim($sticker_get_value, "&");

              if (preg_match('/st_[0-9]{1,}/', $sticker_get_values_res)) {
                preg_match('/st_[0-9]{1,}/', $sticker_get_values_res, $sticker_value);
                preg_match('/=([0-9]{1,})/', $sticker_get_values_res, $product_sticker_id);
                
                if (isset($sticker_value[0]) && isset($product_sticker_id[1])) {
                  $sticker_query_keyword = $this->db->query("SELECT product_sticker_value_mod FROM " . DB_PREFIX . "phpner_filter_product_sticker WHERE product_sticker_id = '" . (int)$product_sticker_id[1] . "' AND language_id ='".(int)$this->config->get('config_language_id')."' GROUP BY product_sticker_id")->row['product_sticker_value_mod'];
            
                  if ($sticker_query_keyword) {
                    $this->cache_data['keywords'][$sticker_query_keyword] = $sticker_value[0].'='.$product_sticker_id[1];
                    $this->cache_data['queries'][$sticker_value[0].'='.$product_sticker_id[1]] = $sticker_query_keyword;
                  }
                }
              }
            }
          }
        }
        // SEO sticker: end

        // SEO stock: start
        if (in_array("filter", $phpner_filter_url)) {
          foreach ($phpner_filter_url as $stock_url_item) {
            if (in_array($stock_url_item, array('in_stock', 'out_of_stock', 'ending_stock'))) {
              $this->cache_data['keywords'][$stock_url_item] = 's_s_'.$stock_url_item.'='.$stock_url_item;
              $this->cache_data['queries']['s_s_'.$stock_url_item.'='.$stock_url_item] = $stock_url_item;
            }
          }
        } elseif (isset($this->session->data['phpner_stock'])) {
          preg_match_all('/s_s_[a-z0-9_]{1,}=[a-z0-9_]{1,}+/', ltrim($this->session->data['phpner_stock'], "&"), $stock_get_values);

          if (isset($stock_get_values[0])) {
            foreach ($stock_get_values[0] as $stock_get_value) {
              $stock_get_values_res = rtrim($stock_get_value, "&");

              if (preg_match('/s_s_[a-z0-9_]{1,}/', $stock_get_values_res)) {
                preg_match('/s_s_[a-z0-9_]{1,}/', $stock_get_values_res, $stock_value);
                preg_match('/=([a-z0-9_]{1,})/', $stock_get_values_res, $stock_id);
                
                if (isset($stock_value[0]) && isset($stock_id[1])) {
                  $this->cache_data['keywords'][$stock_id[1]] = $stock_value[0].'='.$stock_id[1];
                  $this->cache_data['queries'][$stock_value[0].'='.$stock_id[1]] = $stock_id[1];
                }
              }
            }
          }
        }
        // SEO stock: end

        // SEO rating: start
        if (in_array("filter", $phpner_filter_url)) {
          foreach ($phpner_filter_url as $rating_url_item) {
            if (preg_match('/rating-[0-9]{1,}/', $rating_url_item)) {
              preg_match('/rating-[0-9]{1,}/', $rating_url_item, $rating_value);
              preg_match('/([0-9]{1,})/', $rating_url_item, $rating_id);

              $this->cache_data['keywords']['rating-'.$rating_id[1]] = 'r_'.$rating_id[1].'='.$rating_id[1];
              $this->cache_data['queries']['r_'.$rating_id[1].'='.$rating_id[1]] = 'rating-'.$rating_id[1];
            }
          }
        } elseif (isset($this->session->data['phpner_rating'])) {
          preg_match_all('/r_[0-9]{1,}=[0-9]{1,}+/', ltrim($this->session->data['phpner_rating'], "&"), $rating_get_values);

          if (isset($rating_get_values[0])) {
            foreach ($rating_get_values[0] as $rating_get_value) {
              $rating_get_values_res = rtrim($rating_get_value, "&");

              if (preg_match('/r_[0-9]{1,}/', $rating_get_values_res)) {
                preg_match('/r_[0-9]{1,}/', $rating_get_values_res, $rating_value);
                preg_match('/=([0-9]{1,})/', $rating_get_values_res, $rating_id);
                
                if (isset($rating_value[0]) && isset($rating_id[1])) {
                  $this->cache_data['keywords']['rating-'.$rating_id[1]] = $rating_value[0].'='.$rating_id[1];
                  $this->cache_data['queries'][$rating_value[0].'='.$rating_id[1]] = 'rating-'.$rating_id[1];
                }
              }
            }
          }
        }
        // SEO rating: end
      }
      // SEO phpner_ product filter: end
      
		if (!isset($this->request->get['_route_'])) {
			$this->validate();
		} else {
			$route_ = $route = $this->request->get['_route_'];
			unset($this->request->get['_route_']);
			$parts = explode('/', trim(utf8_strtolower($route), '/'));
			list($last_part) = explode('.', array_pop($parts));
			array_push($parts, $last_part);

			$rows = array();
			foreach ($parts as $keyword) {
				if (isset($this->cache_data['keywords'][$keyword])) {
					$rows[] = array('keyword' => $keyword, 'query' => $this->cache_data['keywords'][$keyword]);
				}
			}

			if (isset($this->cache_data['keywords'][$route])){
				$keyword = $route;
				$parts = array($keyword);
				$rows = array(array('keyword' => $keyword, 'query' => $this->cache_data['keywords'][$keyword]));
			}

			if (count($rows) == sizeof($parts)) {
				$queries = array();
				foreach ($rows as $row) {
					$queries[utf8_strtolower($row['keyword'])] = $row['query'];
				}

				reset($parts);
				foreach ($parts as $part) {
					if(!isset($queries[$part])) return false;
					$url = explode('=', $queries[$part], 2);

					if ($url[0] == 'category_id') {
						if (!isset($this->request->get['path'])) {
							$this->request->get['path'] = $url[1];
						} else {
							$this->request->get['path'] .= '_' . $url[1];
						}


        // phpner_blog start

        } elseif ($url[0] == 'phpner_blog_category_id') {

          if (!isset($this->request->get['cpath'])) {

            $this->request->get['cpath'] = $url[1];

          } else {

            $this->request->get['cpath'] .= '_' . $url[1];

          }

        // phpner_blog end

      
					} elseif (count($url) > 1) {
						$this->request->get[$url[0]] = $url[1];
					}
				}
			} else {
				$this->request->get['route'] = 'error/not_found';
			}

			if (isset($this->request->get['product_id'])) {
				$this->request->get['route'] = 'product/product';
				if (!isset($this->request->get['path'])) {
					$path = $this->getPathByProduct($this->request->get['product_id']);
					if ($path) $this->request->get['path'] = $path;
				}


        // phpner_blog start

        } elseif (isset($this->request->get['phpner_blog_article_id'])) {

          $this->request->get['route'] = 'phpner/blog_article';

          if (!isset($this->request->get['cpath'])) {

            $path = $this->getPathByProduct($this->request->get['phpner_blog_article_id']);

            if ($path) $this->request->get['cpath'] = $path;

          }

        } elseif (isset($this->request->get['cpath'])) {

          $this->request->get['route'] = 'phpner/blog_category';

        // phpner_blog end

      
			} elseif (isset($this->request->get['path'])) {
				$this->request->get['route'] = 'product/category';
			} elseif (isset($this->request->get['manufacturer_id'])) {
				$this->request->get['route'] = 'product/manufacturer/info';
			} elseif (isset($this->request->get['information_id'])) {
				$this->request->get['route'] = 'information/information';
			} elseif(isset($this->cache_data['queries'][$route_]) && isset($this->request->server['SERVER_PROTOCOL'])) {
					header($this->request->server['SERVER_PROTOCOL'] . ' 301 Moved Permanently');
					$this->response->redirect($this->cache_data['queries'][$route_], 301);
			} else {
				if (isset($queries[$parts[0]])) {
					$this->request->get['route'] = $queries[$parts[0]];
				}
			}

			$this->validate();

			if (isset($this->request->get['route'])) {
				return new Action($this->request->get['route']);
			}
		}
	}

	public function rewrite($link) {
		if (!$this->config->get('config_seo_url')) return $link;

		$seo_url = '';

		$component = parse_url(str_replace('&amp;', '&', $link));

		$data = array();
		parse_str($component['query'], $data);

		$route = $data['route'];
		unset($data['route']);

		switch ($route) {
			case 'product/product':
				if (isset($data['product_id'])) {
					$tmp = $data;
					$data = array();
					if ($this->config->get('config_seo_url_include_path')) {
						$data['path'] = $this->getPathByProduct($tmp['product_id']);
						if (!$data['path']) return $link;
					}
					$data['product_id'] = $tmp['product_id'];
					$seo_pro_utm = preg_replace('~\r?\n~', "\n", $this->config->get('config_seo_pro_utm'));
					$allowed_parameters = explode("\n", $seo_pro_utm);
					foreach($allowed_parameters as $ap) {
						if (isset($tmp[trim($ap)])) {
							$data[trim($ap)] = $tmp[trim($ap)];
						}
					}
				}
				break;

			case 'product/category':
				if (isset($data['path'])) {
					$category = explode('_', $data['path']);
					$category = end($category);
					$data['path'] = $this->getPathByCategory($category);
					if (!$data['path']) return $link;
				}
				break;



        // phpner_blog start

        case 'phpner/blog_article':

          if (isset($data['phpner_blog_article_id'])) {

            $tmp = $data;

            $data = array();

            if ($this->config->get('config_seo_url_include_path')) {

              $data['cpath'] = $this->getphpner_PathByBlogArticle($tmp['phpner_blog_article_id']);

              if (!$data['cpath']) return $link;

            }

            $data['phpner_blog_article_id'] = $tmp['phpner_blog_article_id'];

            if (isset($tmp['tracking'])) {

              $data['tracking'] = $tmp['tracking'];

            }

          }

          break;



        case 'phpner/blog_category':

          if (isset($data['cpath'])) {

            $category = explode('_', $data['cpath']);

            $category = end($category);

            $data['cpath'] = $this->getphpner_PathByBlogCategory($category);

            if (!$data['cpath']) return $link;

          }

        break;

        // phpner_blog end

      
			case 'product/product/review':
			case 'information/information/agree':
				return $link;
				break;

			default:
				break;
		}

		if ($component['scheme'] == 'https') {
			$link = $this->config->get('config_ssl');
		} else {
			$link = $this->config->get('config_url');
		}

		$link .= 'index.php?route=' . $route;

		if (count($data)) {
			$link .= '&amp;' . urldecode(http_build_query($data, '', '&amp;'));
		}

		$queries = array();
		if(!in_array($route, array('product/search'))) {
		foreach ($data as $key => $value) {
				switch ($key) {
					case 'product_id':
					
      // SEO phpner_ product filter: start
      // case 'manufacturer_id':
      // SEO phpner_ product filter: end
      
					case 'category_id':


        // phpner_blog start

        case 'phpner_blog_article_id':

        case 'phpner_blog_category_id':

        // phpner_blog end

      
					case 'information_id':
					case 'order_id':
						$queries[] = $key . '=' . $value;
						unset($data[$key]);
						$postfix = 1;
						break;



        // phpner_blog start

        case 'cpath':

          $categories = explode('_', $value);

          foreach($categories as $category) {

            $queries[] = 'phpner_blog_category_id=' . $category;

          }

          unset($data[$key]);

          break;

        // phpner_blog end

      
					case 'path':
						$categories = explode('_', $value);
						foreach ($categories as $category) {
							$queries[] = 'category_id=' . $category;
						}
						unset($data[$key]);
						break;


      // SEO phpner_ product filter: start
      case 'manufacturer_id':
        $queries[] = $key . '=' . $value;
        unset($data[$key]);
        // $postfix = 1;
        break;
      case 'phpner_filter':
      case 'special_only':
      case 'price':
      case 'tag':
      case (preg_match('/m_n_/', $key) ? $key : false):
      case (preg_match('/a_nm_/', $key) ? $key : false):
      case (preg_match('/a_vm_/', $key) ? $key : false):
      case (preg_match('/o_nm_/', $key) ? $key : false):
      case (preg_match('/o_vm_/', $key) ? $key : false):
      case (preg_match('/s_nm_/', $key) ? $key : false):
      case (preg_match('/s_vm_/', $key) ? $key : false):
      case (preg_match('/st_/', $key) ? $key : false):
      case (preg_match('/r_/', $key) ? $key : false):
      case (preg_match('/s_s_/', $key) ? $key : false):
        $queries[] = $key . '=' . $value;
        unset($data[$key]);
        break;
      // SEO phpner_ product filter: end
      
					default:
						break;
				}
			}
		}


		if(empty($queries)) {
			$queries[] = $route;
		}

		$rows = array();
		foreach($queries as $query) {
			if(isset($this->cache_data['queries'][$query])) {
				$rows[] = array('query' => $query, 'keyword' => $this->cache_data['queries'][$query]);
			}
		}

		if(count($rows) == count($queries)) {
			$aliases = array();
			foreach($rows as $row) {
				$aliases[$row['query']] = $row['keyword'];
			}
			foreach($queries as $query) {
				$seo_url .= '/' . rawurlencode($aliases[$query]);
			}
		}

		if ($seo_url == '') return $link;

		$seo_url = trim($seo_url, '/');

		if ($component['scheme'] == 'https') {
			$seo_url = $this->config->get('config_ssl') . $seo_url;
		} else {
			$seo_url = $this->config->get('config_url') . $seo_url;
		}

		if (isset($postfix)) {
			$seo_url .= trim($this->config->get('config_seo_url_postfix'));
		} else {
			$seo_url .= '/';
		}

		if(substr($seo_url, -2) == '//') {
			$seo_url = substr($seo_url, 0, -1);
		}

		if (count($data)) {
			$seo_url .= '?' . urldecode(http_build_query($data, '', '&amp;'));
		}

		return $seo_url;
	}

	private function getPathByProduct($product_id) {
		$product_id = (int)$product_id;
		if ($product_id < 1) return false;

		static $path = null;
		if (!isset($path)) {
			$path = $this->cache->get('product.seopath');
			if (!isset($path)) $path = array();
		}

		if (!isset($path[$product_id])) {
			$query = $this->db->query("SELECT category_id FROM " . DB_PREFIX . "product_to_category WHERE product_id = '" . $product_id . "' ORDER BY main_category DESC LIMIT 1");

			$path[$product_id] = $this->getPathByCategory($query->num_rows ? (int)$query->row['category_id'] : 0);

			$this->cache->set('product.seopath', $path);
		}

		return $path[$product_id];
	}

	private function getPathByCategory($category_id) {
		$category_id = (int)$category_id;
		if ($category_id < 1) return false;

		static $path = null;
		if (!isset($path)) {
			$path = $this->cache->get('category.seopath');
			if (!isset($path)) $path = array();
		}

		if (!isset($path[$category_id])) {
			$max_level = 10;

			$sql = "SELECT CONCAT_WS('_'";
			for ($i = $max_level-1; $i >= 0; --$i) {
				$sql .= ",t$i.category_id";
			}
			$sql .= ") AS path FROM " . DB_PREFIX . "category t0";
			for ($i = 1; $i < $max_level; ++$i) {
				$sql .= " LEFT JOIN " . DB_PREFIX . "category t$i ON (t$i.category_id = t" . ($i-1) . ".parent_id)";
			}
			$sql .= " WHERE t0.category_id = '" . $category_id . "'";

			$query = $this->db->query($sql);

			$path[$category_id] = $query->num_rows ? $query->row['path'] : false;

			$this->cache->set('category.seopath', $path);
		}

		return $path[$category_id];
	}



        // phpner_blog start

        private function getphpner_PathByBlogArticle($phpner_blog_article_id) {

          $phpner_blog_article_id = (int)$phpner_blog_article_id;

          if ($phpner_blog_article_id < 1) return false;



          static $path = null;

          if (!isset($path)) {

            $path = $this->cache->get('phpner_blog_article.seopath');

            if (!isset($path)) $path = array();

          }



          if (!isset($path[$phpner_blog_article_id])) {

            $query = $this->db->query("SELECT phpner_blog_category_id FROM " . DB_PREFIX . "phpner_blog_article_to_category WHERE phpner_blog_article_id = '" . $phpner_blog_article_id . "' ORDER BY main_phpner_blog_category_id DESC LIMIT 1");



            $path[$phpner_blog_article_id] = $this->getphpner_PathByBlogCategory($query->num_rows ? (int)$query->row['phpner_blog_category_id'] : 0);



            $this->cache->set('phpner_blog_article.seopath', $path);

          }



          return $path[$phpner_blog_article_id];

        }



        private function getphpner_PathByBlogCategory($phpner_blog_category_id) {

          $phpner_blog_category_id = (int)$phpner_blog_category_id;

          if ($phpner_blog_category_id < 1) return false;



          static $path = null;

          if (!isset($path)) {

            $path = $this->cache->get('phpner_blog_category.seopath');

            if (!isset($path)) $path = array();

          }



          if (!isset($path[$phpner_blog_category_id])) {

            $max_level = 10;



            $sql = "SELECT CONCAT_WS('_'";

            for ($i = $max_level-1; $i >= 0; --$i) {

              $sql .= ",t$i.phpner_blog_category_id";

            }

            $sql .= ") AS cpath FROM " . DB_PREFIX . "phpner_blog_category t0";

            for ($i = 1; $i < $max_level; ++$i) {

              $sql .= " LEFT JOIN " . DB_PREFIX . "phpner_blog_category t$i ON (t$i.phpner_blog_category_id = t" . ($i-1) . ".phpner_blog_category_parent_id)";

            }

            $sql .= " WHERE t0.phpner_blog_category_id = '" . $phpner_blog_category_id . "'";



            $query = $this->db->query($sql);



            $path[$phpner_blog_category_id] = $query->num_rows ? $query->row['cpath'] : false;



            $this->cache->set('phpner_blog_category.seopath', $path);

          }



          return $path[$phpner_blog_category_id];

        }

        // phpner_blog end

      
	private function validate() {
		if (isset($this->request->get['route']) && $this->request->get['route'] == 'error/not_found') {
			return;
		}
		if(empty($this->request->get['route'])) {
			$this->request->get['route'] = 'common/home';
		}

		if (isset($this->request->server['HTTP_X_REQUESTED_WITH']) && strtolower($this->request->server['HTTP_X_REQUESTED_WITH']) == 'xmlhttprequest') {
			return;
		}

		if (isset($this->request->server['HTTPS']) && (($this->request->server['HTTPS'] == 'on') || ($this->request->server['HTTPS'] == '1'))) {
			$config_ssl = substr($this->config->get('config_ssl'), 0, $this->strpos_offset('/', $this->config->get('config_ssl'), 3) + 1);
			$url = str_replace('&amp;', '&', $config_ssl . ltrim($this->request->server['REQUEST_URI'], '/'));
			$seo = str_replace('&amp;', '&', $this->url->link($this->request->get['route'], $this->getQueryString(array('route')), true));
		} else {
			$config_url = substr($this->config->get('config_url'), 0, $this->strpos_offset('/', $this->config->get('config_url'), 3) + 1);
			$url = str_replace('&amp;', '&', $config_url . ltrim($this->request->server['REQUEST_URI'], '/'));
			$seo = str_replace('&amp;', '&', $this->url->link($this->request->get['route'], $this->getQueryString(array('route')), false));
		}

		if (rawurldecode($url) != rawurldecode($seo) && isset($this->request->server['SERVER_PROTOCOL'])) {
			header($this->request->server['SERVER_PROTOCOL'] . ' 301 Moved Permanently');

			$this->response->redirect($seo, 301);
		}
	}

	private function strpos_offset($needle, $haystack, $occurrence) {
		// explode the haystack
		$arr = explode($needle, $haystack);
		// check the needle is not out of bounds
		switch($occurrence) {
			case $occurrence == 0:
				return false;
			case $occurrence > max(array_keys($arr)):
				return false;
			default:
				return strlen(implode($needle, array_slice($arr, 0, $occurrence)));
		}
	}

	private function getQueryString($exclude = array()) {
		if (!is_array($exclude)) {
			$exclude = array();
			}

		return urldecode(http_build_query(array_diff_key($this->request->get, array_flip($exclude))));
		}
	}
?>
