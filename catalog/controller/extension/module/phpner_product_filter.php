<?php
/**************************************************************/
/*	@copyright	Phpner 2019							  */
/*	@support	http://phpner.ru					  */
/*	@license	LICENSE.txt									  */
/**************************************************************/

class ControllerExtensionModulePhpnerProductFilter extends Controller {
    private $global_id = 0;
    private $global_type = '';
    private $global_url;
    
    public function checkSeoData($uri) {
        $this->load->model('extension/module/phpner_product_filter');
        
        $get_main_url = parse_url($uri);
        
        if (isset($get_main_url['path'])) {
            $seo_main_url = ltrim($get_main_url['path'], "/");
        } else {
            $seo_main_url = false;
        }
        
        return $this->model_extension_module_phpner_product_filter->getSeo($seo_main_url);
    }
    
    public function prepareFilterData($uri, $get) {
        $phpner_product_filter_data   = $this->config->get('phpner_product_filter_data');
        $phpner_product_filter_status = $this->config->get('phpner_product_filter_status');
        
        $this->load->model('extension/module/phpner_product_filter');
        
        if ($phpner_product_filter_status && isset($phpner_product_filter_data['enable_seo']) && $phpner_product_filter_data['enable_seo'] && isset($get['route']) && preg_match('/filter/', $uri)) {
            if ($get['route'] == 'product/category') {
                $phpner_filter_path        = (isset($get['path'])) ? explode('_', (string) $get['path']) : array();
                $phpner_filter_global_id   = end($phpner_filter_path);
                $phpner_filter_global_type = 'category';
            } elseif ($get['route'] == 'product/manufacturer/info') {
                $phpner_filter_global_id   = (isset($get['manufacturer_id'])) ? (int) $get['manufacturer_id'] : 0;
                $phpner_filter_global_type = 'manufacturer';
            } elseif ($get['route'] == 'product/special') {
                $phpner_filter_global_type = 'special';
            } else {
                $phpner_filter_global_id   = 0;
                $phpner_filter_global_type = 'category';
            }
            
            $customer_group_id = ($this->customer->isLogged()) ? (int) $this->customer->getGroupId() : (int) $this->config->get('config_customer_group_id');
            $store_id          = (int) $this->config->get('config_store_id');
            $language_id       = (int) $this->config->get('config_language_id');
            
            $get_main_url = parse_url($uri);
            
            if (isset($get_main_url['path'])) {
                $seo_main_url = ltrim($get_main_url['path'], "/");
            } else {
                $seo_main_url = false;
            }
            
            $seo_data_info = $this->model_extension_module_phpner_product_filter->getSeo($seo_main_url);
            
            $seo_main_url_md5 = md5($seo_main_url);
            
            
            if ($seo_data_info) {
                $filter_data = $this->cache->get('phpner.seo_page.' . $phpner_filter_global_type . '.' . (int) $store_id . '.' . (int) $customer_group_id . '.' . (int) $language_id . '.' . (int) $phpner_filter_global_id . '.' . $seo_main_url_md5);
                
                if (!$filter_data) {
                    $phpner_filter_url = explode("/", $uri);
                    
                    if (isset($phpner_product_filter_data['enable_seo']) && $phpner_product_filter_data['enable_seo']) {
                        if ($this->checkSeoData($uri)) {
                            if (preg_match('/price-[0-9]{1,}-[0-9]{1,}/', $uri)) {
                                preg_match('/price-[0-9]{1,}-[0-9]{1,}/', $uri, $matches);
                                
                                $phpner_filter_price = explode('-', $matches[0]);
                                
                                if (isset($phpner_filter_price[1]) && isset($phpner_filter_price[2])) {
                                    $filter_data['low_price']  = preg_replace("/[^,.0-9]/", '', $phpner_filter_price[1]);
                                    $filter_data['high_price'] = preg_replace("/[^,.0-9]/", '', $phpner_filter_price[2]);
                                }
                            }
                        }
                    }
                    
                    if (isset($phpner_product_filter_data['enable_seo']) && $phpner_product_filter_data['enable_seo']) {
                        if ($this->checkSeoData($uri)) {
                            if (preg_match('/tag-[a-z0-9(_|.)]{1,}/', $uri)) {
                                preg_match('/tag-[a-z0-9(_|.)]{1,}/', $uri, $matches);
                                
                                $get_phpner_filter_tag = explode('-', $matches[0]);
                                
                                if (isset($get_phpner_filter_tag[1])) {
                                    $filter_data['tag'] = $get_phpner_filter_tag[1];
                                }
                            }
                        }
                    }
                    
                    if (isset($phpner_product_filter_data['enable_seo']) && $phpner_product_filter_data['enable_seo']) {
                        if ($this->checkSeoData($uri)) {
                            if (preg_match('/special-only/', $uri)) {
                                preg_match('/special-only/', $uri, $matches);
                                
                                if ($matches[0]) {
                                    $filter_data['special_only'] = 1;
                                }
                            }
                        }
                    }
                    
                    if (isset($phpner_product_filter_data['enable_seo']) && $phpner_product_filter_data['enable_seo']) {
                        if ($this->checkSeoData($uri)) {
                            if (in_array("filter", $phpner_filter_url)) {
                                foreach ($phpner_filter_url as $manufacturer_url_item) {
                                    $manufacturer_query_query = $this->db->query("SELECT query FROM " . DB_PREFIX . "url_alias WHERE keyword = '" . $this->db->escape($manufacturer_url_item) . "'");
                                    
                                    if ($manufacturer_query_query->num_rows) {
                                        if (preg_match('/manufacturer_id=[0-9]{1,}/', $manufacturer_query_query->row['query'])) {
                                            preg_match('/manufacturer_id=[0-9]{1,}/', $manufacturer_query_query->row['query'], $manufacturer_id);
                                            preg_match('/[0-9]{1,}/', $manufacturer_id[0], $query_value);
                                            
                                            if (isset($query_value[0])) {
                                                $filter_data['manufacturer'][] = $query_value[0];
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                    
                    if (isset($phpner_product_filter_data['enable_seo']) && $phpner_product_filter_data['enable_seo']) {
                        if ($this->checkSeoData($uri)) {
                            if (in_array("filter", $phpner_filter_url)) {
                                foreach ($phpner_filter_url as $stock_url_item) {
                                    if (in_array($stock_url_item, array(
                                        'in_stock',
                                        'out_of_stock',
                                        'ending_stock'
                                    ))) {
                                        $filter_data['stock'][] = $stock_url_item;
                                    }
                                }
                            }
                        }
                    }
                    
                    if (isset($phpner_product_filter_data['enable_seo']) && $phpner_product_filter_data['enable_seo']) {
                        if ($this->checkSeoData($uri)) {
                            if (in_array("filter", $phpner_filter_url)) {
                                foreach ($phpner_filter_url as $attribute_url_item) {
                                    $query_attribute_name_mod = $this->db->query("SELECT filter_attribute_id FROM " . DB_PREFIX . "phpner_filter_product_attribute WHERE attribute_name_mod = '" . $this->db->escape($attribute_url_item) . "' AND language_id ='" . (int) $this->config->get('config_language_id') . "'");
                                    
                                    if ($query_attribute_name_mod->num_rows) {
                                        foreach ($phpner_filter_url as $attribute_url_item_2) {
                                            $query_attribute_value_mod = $this->db->query("SELECT filter_attribute_id FROM " . DB_PREFIX . "phpner_filter_product_attribute WHERE attribute_value_mod = '" . $this->db->escape($attribute_url_item_2) . "' AND attribute_name_mod = '" . $this->db->escape($attribute_url_item) . "' AND language_id ='" . (int) $this->config->get('config_language_id') . "'")->num_rows;
                                            
                                            if ($query_attribute_value_mod) {
                                                $filter_data['attribute'][$attribute_url_item][] = $attribute_url_item_2;
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                    
                    if (isset($phpner_product_filter_data['enable_seo']) && $phpner_product_filter_data['enable_seo']) {
                        if ($this->checkSeoData($uri)) {
                            if (in_array("filter", $phpner_filter_url)) {
                                foreach ($phpner_filter_url as $option_url_item) {
                                    $query_option_name_mod = $this->db->query("SELECT filter_option_id FROM " . DB_PREFIX . "phpner_filter_product_option WHERE option_name_mod = '" . $this->db->escape($option_url_item) . "'AND language_id ='" . (int) $this->config->get('config_language_id') . "'");
                                    
                                    if ($query_option_name_mod->num_rows) {
                                        foreach ($phpner_filter_url as $option_url_item_2) {
                                            $query_option_value_id = $this->db->query("SELECT option_value_id FROM " . DB_PREFIX . "phpner_filter_product_option WHERE option_value_name_mod = '" . $this->db->escape($option_url_item_2) . "' AND option_name_mod = '" . $this->db->escape($option_url_item) . "' AND language_id ='" . (int) $this->config->get('config_language_id') . "' GROUP BY option_value_id");
                                            
                                            if ($query_option_value_id->num_rows) {
                                                $filter_data['option'][$option_url_item][] = $query_option_value_id->row['option_value_id'];
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                    
                    if (isset($phpner_product_filter_data['enable_seo']) && $phpner_product_filter_data['enable_seo']) {
                        if ($this->checkSeoData($uri)) {
                            if (in_array("filter", $phpner_filter_url)) {
                                foreach ($phpner_filter_url as $sticker_url_item) {
                                    $sticker_query_query = $this->db->query("SELECT product_sticker_id FROM " . DB_PREFIX . "phpner_filter_product_sticker WHERE product_sticker_value_mod = '" . $this->db->escape($sticker_url_item) . "' AND language_id ='" . (int) $this->config->get('config_language_id') . "' GROUP BY product_sticker_id");
                                    
                                    if ($sticker_query_query->num_rows) {
                                        $filter_data['sticker'][] = $sticker_query_query->row['product_sticker_id'];
                                    }
                                }
                            }
                        }
                    }
                    
                    if (isset($phpner_product_filter_data['enable_seo']) && $phpner_product_filter_data['enable_seo']) {
                        if ($this->checkSeoData($uri)) {
                            if (in_array("filter", $phpner_filter_url)) {
                                foreach ($phpner_filter_url as $standard_url_item) {
                                    $query_filter_name_mod = $this->db->query("SELECT filter_filter_id FROM " . DB_PREFIX . "phpner_filter_product_standard WHERE filter_name_mod = '" . $this->db->escape($standard_url_item) . "' AND language_id ='" . (int) $this->config->get('config_language_id') . "'");
                                    
                                    if ($query_filter_name_mod->num_rows) {
                                        foreach ($phpner_filter_url as $standard_url_item_2) {
                                            $query_standard_value_mod = $this->db->query("SELECT filter_filter_id FROM " . DB_PREFIX . "phpner_filter_product_standard WHERE filter_value_mod = '" . $this->db->escape($standard_url_item_2) . "' AND filter_name_mod = '" . $this->db->escape($standard_url_item) . "' AND language_id ='" . (int) $this->config->get('config_language_id') . "'")->num_rows;
                                            
                                            if ($query_standard_value_mod) {
                                                $filter_data['standard'][$standard_url_item][] = $standard_url_item_2;
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                    
                    if (isset($phpner_product_filter_data['enable_seo']) && $phpner_product_filter_data['enable_seo']) {
                        if ($this->checkSeoData($uri)) {
                            if (in_array("filter", $phpner_filter_url)) {
                                foreach ($phpner_filter_url as $rating_url_item) {
                                    if (preg_match('/rating-[0-9]{1,}/', $rating_url_item)) {
                                        preg_match('/rating-[0-9]{1,}/', $rating_url_item, $rating_value);
                                        preg_match('/([0-9]{1,})/', $rating_url_item, $rating_id);
                                        
                                        $filter_data['rating'][] = $rating_id[1];
                                    }
                                }
                            }
                        }
                    }
                    
                    $this->cache->set('phpner.seo_page.' . $phpner_filter_global_type . '.' . (int) $store_id . '.' . (int) $customer_group_id . '.' . (int) $language_id . '.' . (int) $phpner_filter_global_id . '.' . $seo_main_url_md5, $filter_data);
                }
                
                return $filter_data;
            }
        }
    }
    
    public function index() {
        $data = array();
        $data = array_merge($data, $this->load->language('extension/module/phpner_product_filter'));
        
        $this->document->addScript('catalog/view/javascript/phpner/phpner_product_filter/nouislider.js');
        $this->document->addScript('catalog/view/javascript/phpner/phpner_product_filter/wNumb.js');
        $this->document->addStyle('catalog/view/javascript/phpner/phpner_product_filter/nouislider.css');
        
        $this->load->model('extension/module/phpner_product_filter');
        $this->load->model('tool/image');
        
        $data['phpner_product_filter_data'] = $phpner_product_filter_data = $this->config->get('phpner_product_filter_data');
        
		/* 3359 */
		if (!isset($data['phpner_product_filter_data']['display_empty_totals'])) {
			$data['phpner_product_filter_data']['display_empty_totals'] = 1;
		}
		/* 3359 */
		
        $data['page']           = (isset($this->request->get['page'])) ? $this->request->get['page'] : 1;
        $data['config_seo_url'] = $this->config->get('config_seo_url');
        $customer_group_id      = ($this->customer->isLogged()) ? (int) $this->customer->getGroupId() : (int) $this->config->get('config_customer_group_id');
        $store_id               = (int) $this->config->get('config_store_id');
        $language_id            = (int) $this->config->get('config_language_id');
        $lead_time_status       = '';
        
        $post_data = isset($this->request->post) ? $this->request->post : array();
        
        if (isset($phpner_product_filter_data['enable_seo']) && $phpner_product_filter_data['enable_seo'] && $this->checkSeoData($this->request->server['REQUEST_URI'])) {
            $data['filter_start'] = 0;
        } else {
            $data['filter_start'] = (isset($this->request->get['phpner_filter'])) ? 1 : 0;
        }
        
        if (isset($post_data['route'])) {
            $route = $post_data['route'];
        } elseif (isset($this->request->get['route'])) {
            $route = $this->request->get['route'];
        }

        $data['route'] = $route;
        
        $phpner_filter_url = explode("/", $this->request->server['REQUEST_URI']);
        
        $this->global_url = '';
        
        if (isset($route)) {
            if ($route == 'product/category') {
                $path = (isset($this->request->get['path'])) ? explode('_', (string) $this->request->get['path']) : array();
                
                if (isset($post_data['global_id']) && $post_data['global_id']) {
                    $data['global_id'] = $this->global_id = $post_data['global_id'];
                } else {
                    $data['global_id'] = $this->global_id = end($path);
                }
                
                $data['global_type'] = $this->global_type = 'category';
                
                $this->global_url .= '&path=' . $this->global_id;
                
            } elseif ($route == 'product/manufacturer/info') {
                $path = (isset($this->request->get['manufacturer_id'])) ? (int) $this->request->get['manufacturer_id'] : 0;
                
                if (isset($post_data['global_id']) && $post_data['global_id']) {
                    $data['global_id'] = $this->global_id = $post_data['global_id'];
                } else {
                    $data['global_id'] = $this->global_id = $path;
                }
                
                $data['global_type'] = $this->global_type = 'manufacturer';
                
                $this->global_url .= '&manufacturer_id=' . $this->global_id;
            } elseif ($route == 'product/special') {
                $data['global_type'] = $this->global_type = 'special';
            }
        }
        
        $this->global_url .= '&phpner_filter=1';
        
        $filter_data = array(
            'filter_data' => array(
                'option_logic_with_other' => $phpner_product_filter_data['option_logic_with_other'],
                'option_logic_between_option' => $phpner_product_filter_data['option_logic_between_option'],
                'attribute_logic_with_other' => $phpner_product_filter_data['attribute_logic_with_other'],
                'attribute_logic_between_attribute' => $phpner_product_filter_data['attribute_logic_between_attribute'],
                'standard_logic_with_other' => $phpner_product_filter_data['standard_logic_with_other'],
                'standard_logic_between_standard' => $phpner_product_filter_data['standard_logic_between_standard'],
                'manufacturer_logic_with_other' => $phpner_product_filter_data['manufacturer_logic_with_other'],
                'stock_ending_value' => $phpner_product_filter_data['stock_ending_value'],
                'stock_logic_with_other' => $phpner_product_filter_data['stock_logic_with_other'],
                'stock_logic_between_stock' => $phpner_product_filter_data['stock_logic_between_stock'],
                'review_logic_with_other' => $phpner_product_filter_data['review_logic_with_other'],
                'review_logic_between_review' => $phpner_product_filter_data['review_logic_between_review'],
                'sticker_logic_with_other' => $phpner_product_filter_data['sticker_logic_with_other'],
                'sticker_logic_between_sticker' => $phpner_product_filter_data['sticker_logic_between_sticker'],
                'tag_logic_with_other' => $phpner_product_filter_data['tag_logic_with_other'],
                'customer_group_id' => $customer_group_id,
                'store_id' => $store_id,
                'language_id' => $language_id
            )
        );
        
        if (isset($phpner_product_filter_data['enable_seo']) && $phpner_product_filter_data['enable_seo'] && $this->checkSeoData($this->request->server['REQUEST_URI'])) {
            $filter_data = array_merge($filter_data, $this->prepareFilterData($this->request->server['REQUEST_URI'], $this->request->get));
        } else {
            $filter_data['special_only'] = (isset($post_data['special_only'])) ? $post_data['special_only'] : '';
            $filter_data['low_price']    = (isset($post_data['low_price'])) ? floor($post_data['low_price'] / $this->currency->getValue($this->session->data['currency'])) : '';
            $filter_data['high_price']   = (isset($post_data['high_price'])) ? ceil($post_data['high_price'] / $this->currency->getValue($this->session->data['currency'])) : '';
            $filter_data['tag']          = (isset($post_data['tag'])) ? $post_data['tag'] : '';
            $filter_data['manufacturer'] = (isset($post_data['m_id'])) ? $post_data['m_id'] : '';
            $filter_data['stock']        = (isset($post_data['stock'])) ? $post_data['stock'] : '';
            $filter_data['rating']       = (isset($post_data['rating'])) ? $post_data['rating'] : '';
            $filter_data['sticker']      = (isset($post_data['sticker'])) ? $post_data['sticker'] : '';
            $filter_data['option']       = (isset($post_data['option'])) ? $post_data['option'] : '';
            $filter_data['attribute']    = (isset($post_data['attribute'])) ? $post_data['attribute'] : '';
            $filter_data['standard']     = (isset($post_data['standard'])) ? $post_data['standard'] : '';
        }
        
        $data['filter_prices']       = array();
        $data['filter_range_prices'] = array();
        
        if ($phpner_product_filter_data['price_status']) {
            $price_data = $this->model_extension_module_phpner_product_filter->getFilterMINMAXPrices($this->global_id, $this->global_type, $store_id, $customer_group_id, $filter_data, $lead_time_status);
            
            if (isset($post_data['low_price']) && isset($post_data['high_price'])) {
                $data['filter_prices'] = array(
                    'low_price' => preg_replace("/[^,.0-9]/", '', $post_data['low_price']),
                    'high_price' => preg_replace("/[^,.0-9]/", '', $post_data['high_price'])
                );
                
                $this->session->data['low_price']  = $data['filter_prices']['low_price'];
                $this->session->data['high_price'] = $data['filter_prices']['high_price'];
                
                $this->global_url .= '&price=' . $data['filter_prices']['low_price'] . ',' . $data['filter_prices']['high_price'];
            } elseif (isset($this->request->get['price'])) {
                $url_price = explode(',', $this->request->get['price']);
                
                $data['filter_prices'] = array(
                    'low_price' => preg_replace("/[^,.0-9]/", '', $url_price[0]),
                    'high_price' => preg_replace("/[^,.0-9]/", '', $url_price[1])
                );
                
                $this->session->data['low_price']  = $data['filter_prices']['low_price'];
                $this->session->data['high_price'] = $data['filter_prices']['high_price'];
                
                $this->global_url .= '&price=' . $data['filter_prices']['low_price'] . ',' . $data['filter_prices']['high_price'];
            } else {
                $data['filter_prices'] = array(
                    'low_price' => floor(preg_replace("/[^,.0-9]/", '', $this->currency->format($price_data['low_price'], $this->session->data['currency']))),
                    'high_price' => ceil(preg_replace("/[^,.0-9]/", '', $this->currency->format($price_data['high_price'], $this->session->data['currency'])))
                );
                
                $this->session->data['low_price']  = $data['filter_prices']['low_price'];
                $this->session->data['high_price'] = $data['filter_prices']['high_price'];
                
                $this->global_url .= '&price=' . $data['filter_prices']['low_price'] . ',' . $data['filter_prices']['high_price'];
            }
            
            $data['filter_range_prices'] = array(
                'low_price' => floor(preg_replace("/[^,.0-9]/", '', $this->currency->format($price_data['low_price'], $this->session->data['currency']))),
                'high_price' => ceil(preg_replace("/[^,.0-9]/", '', $this->currency->format($price_data['high_price'], $this->session->data['currency'])))
            );
        }
        
        $data['filter_tag'] = '';
        $data['tag']        = '';
        
        if ($phpner_product_filter_data['tag_status']) {
            $data['filter_tag'] = true;
            
            if (isset($post_data['tag'])) {
                $data['tag'] = $post_data['tag'];
                
                $this->session->data['phpner_tag'] = $data['tag'];
                $this->global_url .= '&tag=' . $data['tag'];
            } elseif (isset($this->request->get['tag'])) {
                $data['tag'] = $this->request->get['tag'];
                
                $this->session->data['phpner_tag'] = $data['tag'];
                $this->global_url .= '&tag=' . $data['tag'];
            }
        }
        
        $data['filter_special_only'] = '';
        $data['special_only']        = '';
        
        if ($phpner_product_filter_data['price_status'] && $phpner_product_filter_data['show_special_only_bytton']) {
            $data['filter_special_only'] = true;
            
            if (isset($post_data['special_only'])) {
                $data['special_only'] = $post_data['special_only'];
                
                $this->global_url .= '&special_only=1';
            } elseif (isset($this->request->get['special_only'])) {
                $data['special_only'] = $this->request->get['special_only'];
                
                $this->global_url .= '&special_only=1';
            }
            
            $data['special_only_total'] = $this->model_extension_module_phpner_product_filter->getFilterTotalSpecialOnly($this->global_id, $this->global_type, $store_id, $customer_group_id, $language_id, $lead_time_status, $filter_data);
        }
        
        $data['filter_manufacturer'] = array();
        
        if ($phpner_product_filter_data['manufacturer_status'] && $this->global_type != 'manufacturer') {
            $manufacturer_data = $this->model_extension_module_phpner_product_filter->getFilterManufacturers($this->global_id, $this->global_type, $store_id, $customer_group_id, $language_id, $lead_time_status);
            
            if ($manufacturer_data) {
                $filter_manufacturer_total = $this->model_extension_module_phpner_product_filter->getFilterTotalManufacturers($this->global_id, $this->global_type, $store_id, $customer_group_id, $language_id, $filter_data);
                
                foreach ($manufacturer_data as $manufacturer) {
                    $brands = array();
                    
                    if (isset($post_data['m_id'])) {
                        $get_brand = $post_data['m_id'];
                        
                        if (is_array($get_brand)) {
                            foreach ($get_brand as $manufacturer_id) {
                                $brands[] = $manufacturer_id;
                            }
                        } else {
                            $brands[] = $get_brand;
                        }
                    } elseif ($this->request->get) {
                        $make_get_url = http_build_query($this->request->get);
                        
                        preg_match_all('/m_n_[0-9]{1,}=[0-9]{1,}+&/', $make_get_url, $brand_get_values);
                        
                        if (isset($brand_get_values[0])) {
                            foreach ($brand_get_values[0] as $brand_get_value) {
                                $brand_get_values_res = rtrim($brand_get_value, "&");
                                
                                preg_match('/=([0-9]{1,})/', $brand_get_values_res, $brand_id);
                                
                                if (isset($brand_id[1])) {
                                    $brands[] = $brand_id[1];
                                }
                            }
                        }
                    }
                    
                    $data['filter_manufacturer'][] = array(
                        'manufacturer_id' => $manufacturer['manufacturer_id'],
                        'name' => $manufacturer['name'],
                        'image' => $manufacturer['image'],
                        'total' => $filter_manufacturer_total,
                        'checked' => $brands
                    );
                }
            }
            
            if (isset($post_data['m_id'])) {
                $get_brand = $post_data['m_id'];
                
                if (is_array($get_brand)) {
                    $url_brand_ids = '';
                    
                    foreach ($get_brand as $manufacturer_id) {
                        $url_brand_ids .= '&m_n_' . $manufacturer_id . '=' . $manufacturer_id;
                    }
                } else {
                    $url_brand_ids = '&m_n_' . $get_brand . '=' . $get_brand;
                }
                
                $this->session->data['phpner_brand'] = $url_brand_ids;
                $this->global_url .= $url_brand_ids;
            } elseif ($this->request->get) {
                $brands_result = '';
                
                foreach ($this->request->get as $key => $get_value) {
                    if (preg_match('/m_n_[0-9]{1,}/', $key)) {
                        $brands_result .= '&' . $key . '=' . $get_value;
                    }
                }
                
                $this->session->data['phpner_brand'] = $brands_result;
                $this->global_url .= $brands_result;
            }
        }
        
        $data['filter_stock'] = array();
        
        if ($phpner_product_filter_data['stock_status']) {
            $filter_stock_total = $this->model_extension_module_phpner_product_filter->getFilterTotalStock($this->global_id, $this->global_type, $store_id, $customer_group_id, $language_id, $lead_time_status, $filter_data);
            
            $stock_array = array(
                'in_stock',
                'out_of_stock'
            );
            
            if ($phpner_product_filter_data['stock_ending_value_status']) {
                $stock_array[] = 'ending_stock';
            }
            
            foreach ($stock_array as $stock_key) {
                $stocks = array();
                
                if (isset($post_data['stock'])) {
                    $get_stock = $post_data['stock'];
                    
                    if (is_array($get_stock)) {
                        foreach ($get_stock as $stock_value) {
                            $stocks[] = $stock_value;
                        }
                    } else {
                        $stocks[] = $get_stock;
                    }
                } elseif ($this->request->get) {
                    $make_get_url = http_build_query($this->request->get);
                    
                    preg_match_all('/s_s_[a-z0-9_]{1,}=[a-z0-9_]{1,}+&/', $make_get_url, $stock_get_values);
                    
                    if (isset($stock_get_values[0])) {
                        foreach ($stock_get_values[0] as $stock_get_value) {
                            $stock_get_values_res = rtrim($stock_get_value, "&");
                            
                            preg_match('/=([a-z0-9_]{1,})/', $stock_get_values_res, $stock_id);
                            
                            if (isset($stock_id[1])) {
                                $stocks[] = $stock_id[1];
                            }
                        }
                    }
                }
                
                $data['filter_stock'][$stock_key] = array(
                    'stock_key' => $stock_key,
                    'name' => $this->language->get('text_filter_' . $stock_key),
                    'total' => $filter_stock_total,
                    'checked' => $stocks
                );
            }
            
            if (isset($post_data['stock'])) {
                $get_stock = $post_data['stock'];
                
                if (is_array($get_stock)) {
                    $url_stock_ids = '';
                    
                    foreach ($get_stock as $stock_value) {
                        $url_stock_ids .= '&s_s_' . $stock_value . '=' . $stock_value;
                    }
                } else {
                    $url_stock_ids = '&s_s_' . $get_stock . '=' . $get_stock;
                }
                
                $this->session->data['phpner_stock'] = $url_stock_ids;
                $this->global_url .= $url_stock_ids;
            } elseif ($this->request->get) {
                $stock_result = '';
                
                foreach ($this->request->get as $key => $get_value) {
                    if (preg_match('/s_s_[a-z0-9_]{1,}/', $key)) {
                        $stock_result .= '&' . $key . '=' . $get_value;
                    }
                }
                
                $this->session->data['phpner_stock'] = $stock_result;
                $this->global_url .= $stock_result;
            }
        }
        
        $data['filter_attribute'] = array();
        
        if ($phpner_product_filter_data['attribute_status']) {
            $attribute_data = $this->model_extension_module_phpner_product_filter->getFilterAttributes($this->global_id, $this->global_type, $store_id, $customer_group_id, $language_id, $lead_time_status);
            
            if ($attribute_data) {
                $filter_attribute_total = $this->model_extension_module_phpner_product_filter->getFilterTotalAttributeValues($this->global_id, $this->global_type, $store_id, $customer_group_id, $language_id, $filter_data);
                
                foreach ($attribute_data as $attribute) {
                    $attributes = array();
                    
                    if (isset($post_data['attribute'])) {
                        $get_attribute = $post_data['attribute'];
                        $attribute_ids = array();
                        
                        foreach ($get_attribute as $attribute_name_mod => $attribute_value_mod) {
                            if (is_array($attribute_value_mod)) {
                                foreach ($attribute_value_mod as $attribute_value_mod_children) {
                                    if ($attribute_value_mod_children) {
                                        $attribute_ids[$attribute_name_mod][] = $attribute_value_mod_children;
                                    }
                                }
                            } else {
                                if ($attribute_value_mod) {
                                    $attribute_ids[$attribute_name_mod][] = $attribute_value_mod;
                                }
                            }
                            
                            if ($attribute['values'] && $attribute_ids) {
                                foreach ($attribute['values'] as $attribute_value) {
                                    if (in_array($attribute_value['attribute_value_mod'], $attribute_ids[$attribute_name_mod]) && $attribute_name_mod == $attribute['attribute_name_mod']) {
                                        $attributes[$attribute_name_mod][] = $attribute_value['attribute_value_mod'];
                                    }
                                }
                            }
                        }
                    } elseif ($this->request->get) {
                        $make_get_url = http_build_query($this->request->get);
                        
                        preg_match_all('/a_nm_[a-z0-9_]{1,}=[a-z0-9_]{1,}(&a_vm_[a-z0-9_]{1,}=[a-z0-9_]{1,}(.*?){1,})+&/', $make_get_url, $attribute_get_values);
                        
                        if (isset($attribute_get_values[0])) {
                            foreach ($attribute_get_values[0] as $attribute_get_value) {
                                $attribute_get_values_res = rtrim($attribute_get_value, "&");
                                
                                preg_match('/=([a-z0-9_]{1,})/', $attribute_get_values_res, $attribute_group_id);
                                preg_match_all('/a_vm_[a-z0-9_]*=([a-z0-9_]*)/', $attribute_get_values_res, $attribute_get_value_mod);
                                
                                if (isset($attribute_group_id[1]) && isset($attribute_get_value_mod[1])) {
                                    if ($attribute['values']) {
                                        foreach ($attribute['values'] as $attribute_value) {
                                            if (in_array($attribute_value['attribute_value_mod'], $attribute_get_value_mod[1]) && $attribute_group_id[1] == $attribute['attribute_name_mod']) {
                                                $attributes[$attribute_group_id[1]][] = $attribute_value['attribute_value_mod'];
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                    
                    $data['filter_attribute'][] = array(
                        'attribute_id' => $attribute['attribute_id'],
                        'attribute_name_mod' => $attribute['attribute_name_mod'],
                        'attribute_group_id' => $attribute['attribute_group_id'],
                        'name' => $attribute['name'],
                        'values' => $attribute['values'],
                        'total' => $filter_attribute_total,
                        'checked' => (isset($attributes[$attribute['attribute_name_mod']])) ? $attributes[$attribute['attribute_name_mod']] : array()
                    );
                }
            }
            
            $url_attribute_ids = array();
            $attributes_result = '';
            
            if (isset($post_data['attribute'])) {
                $get_attribute = $post_data['attribute'];
                
                foreach ($post_data['attribute'] as $url_attribute_name_mod => $attribute_value_mod) {
                    if (is_array($attribute_value_mod)) {
                        foreach ($attribute_value_mod as $attribute_value_mod_children) {
                            if ($attribute_value_mod_children) {
                                $url_attribute_ids[$url_attribute_name_mod][] = $attribute_value_mod_children;
                            }
                        }
                    } else {
                        if ($attribute_value_mod) {
                            $url_attribute_ids[$url_attribute_name_mod] = $attribute_value_mod;
                        }
                    }
                    
                    if ($url_attribute_ids) {
                        if (is_array($url_attribute_ids[$url_attribute_name_mod])) {
                            $url_attribute_ids_attribute_name_mod_array = '';
                            
                            foreach ($url_attribute_ids[$url_attribute_name_mod] as $key => $url_attribute_ids_attribute_name_mod) {
                                $url_attribute_ids_attribute_name_mod_array .= '&a_vm_' . $url_attribute_ids_attribute_name_mod . '=' . $url_attribute_ids_attribute_name_mod;
                            }
                            
                            $attributes_result .= '&a_nm_' . $url_attribute_name_mod . '=' . $url_attribute_name_mod . $url_attribute_ids_attribute_name_mod_array;
                        } else {
                            $attributes_result .= '&a_nm_' . $url_attribute_name_mod . '=' . $url_attribute_name_mod . '&a_vm_' . $url_attribute_ids[$url_attribute_name_mod] . '=' . $url_attribute_ids[$url_attribute_name_mod];
                        }
                    }
                }
                
                $this->session->data['phpner_attribute'] = $attributes_result;
                $this->global_url .= $attributes_result;
            } elseif ($this->request->get) {
                $attributes_result = '';
                
                foreach ($this->request->get as $key => $get_value) {
                    if (preg_match('/a_nm_[0-9]{1,}/', $key)) {
                        $attributes_result .= '&' . $key . '=' . $get_value;
                    }
                    if (preg_match('/a_vm_[a-z0-9_]{1,}/', $key)) {
                        $attributes_result .= '&' . $key . '=' . $get_value;
                    }
                }
                
                $this->session->data['phpner_attribute'] = $attributes_result;
                $this->global_url .= $attributes_result;
            }
        }
        
        $data['filter_option'] = array();
        
        if ($phpner_product_filter_data['option_status']) {
            $option_data = $this->model_extension_module_phpner_product_filter->getFilterOptions($this->global_id, $this->global_type, $store_id, $customer_group_id, $language_id, $lead_time_status);
            
            if ($option_data) {
                $filter_option_total = $this->model_extension_module_phpner_product_filter->getFilterTotalOptionValues($this->global_id, $this->global_type, $store_id, $customer_group_id, $language_id, $filter_data);
                
                foreach ($option_data as $option) {
                    $options = array();
                    
                    if (isset($post_data['option'])) {
                        $get_option = $post_data['option'];
                        $option_ids = array();
                        
                        foreach ($get_option as $option_name_mod => $option_inner) {
                            if (is_array($option_inner)) {
                                foreach ($option_inner as $option_value_id) {
                                    if ($option_value_id) {
                                        $option_ids[$option_name_mod][] = $option_value_id;
                                    }
                                }
                            } else {
                                if ($option_inner) {
                                    $option_ids[$option_name_mod][] = $option_inner;
                                }
                            }
                            
                            if ($option['values'] && $option_ids) {
                                foreach ($option['values'] as $option_value) {
                                    if (in_array($option_value['option_value_id'], $option_ids[$option_name_mod]) && $option_name_mod == $option['option_name_mod']) {
                                        $options[$option_name_mod][] = $option_value['option_value_id'];
                                    }
                                }
                            }
                        }
                    } elseif ($this->request->get) {
                        $make_get_url = http_build_query($this->request->get);
                        
                        preg_match_all('/o_nm_[a-z0-9_]{1,}=[a-z0-9_]{1,}(&o_vm_[0-9]{1,}=[0-9]{1,}(.*?){1,})+&/', $make_get_url, $option_get_values);
                        
                        if (isset($option_get_values[0])) {
                            
                            foreach ($option_get_values[0] as $option_get_value) {
                                $option_get_values_res = rtrim($option_get_value, "&");
                                
                                preg_match('/=([a-z0-9_]{1,})/', $option_get_values_res, $option_group_id);
                                
                                preg_match_all('/o_vm_[0-9]*=([0-9]*)/', $option_get_values_res, $option_value_id);
                                
                                if (isset($option_group_id[1]) && isset($option_value_id[1])) {
                                    if ($option['values']) {
                                        foreach ($option['values'] as $option_value) {
                                            if (in_array($option_value['option_value_id'], $option_value_id[1]) && $option_group_id[1] == $option['option_name_mod']) {
                                                $options[$option_group_id[1]][] = $option_value['option_value_id'];
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                    
                    $data['filter_option'][] = array(
                        'option_id' => $option['option_id'],
                        'name' => $option['name'],
                        'option_name_mod' => $option['option_name_mod'],
                        'values' => $option['values'],
                        'total' => $filter_option_total,
                        'checked' => (isset($options[$option['option_name_mod']])) ? $options[$option['option_name_mod']] : array()
                    );
                }
            }
            
            $url_option_ids = array();
            $options_result = '';
            
            if (isset($post_data['option'])) {
                $get_option = $post_data['option'];
                
                foreach ($post_data['option'] as $url_option_name_mod => $url_option_value) {
                    if (is_array($url_option_value)) {
                        foreach ($url_option_value as $url_option_value_id) {
                            if ($url_option_value_id) {
                                $url_option_ids[$url_option_name_mod][] = $url_option_value_id;
                            }
                        }
                    } else {
                        if ($url_option_value) {
                            $url_option_ids[$url_option_name_mod] = $url_option_value;
                        }
                    }
                    
                    if ($url_option_ids) {
                        if (is_array($url_option_ids[$url_option_name_mod])) {
                            $url_option_ids_option_name_mod_array = '';
                            
                            foreach ($url_option_ids[$url_option_name_mod] as $key => $url_option_value_id) {
                                $url_option_ids_option_name_mod_array .= '&o_vm_' . $url_option_value_id . '=' . $url_option_value_id;
                            }
                            
                            $options_result .= '&o_nm_' . $url_option_name_mod . '=' . $url_option_name_mod . $url_option_ids_option_name_mod_array;
                        } else {
                            $options_result .= '&o_nm_' . $url_option_name_mod . '=' . $url_option_name_mod . '&o_vm_' . $url_option_value . '=' . $url_option_value;
                        }
                    }
                }
                
                $this->session->data['phpner_option'] = $options_result;
                $this->global_url .= $options_result;
            } elseif ($this->request->get) {
                $options_result = '';
                
                foreach ($this->request->get as $key => $get_value) {
                    if (preg_match('/o_nm_[0-9]{1,}/', $key)) {
                        $options_result .= '&' . $key . '=' . $get_value;
                    }
                    if (preg_match('/o_vm_[a-z0-9_]{1,}/', $key)) {
                        $options_result .= '&' . $key . '=' . $get_value;
                    }
                }
                
                $this->session->data['phpner_option'] = $options_result;
                $this->global_url .= $options_result;
            }
        }
        
        $data['filter_sticker'] = array();
        
        $phpner_product_stickers_data = $this->config->get('phpner_product_stickers_data');
        
        if (isset($phpner_product_stickers_data['status']) && $phpner_product_stickers_data['status'] && $phpner_product_filter_data['sticker_status']) {
            $sticker_data = $this->model_extension_module_phpner_product_filter->getFilterStickers($this->global_id, $this->global_type, $store_id, $customer_group_id, $language_id, $lead_time_status);
            
            if ($sticker_data) {
                $filter_sticker_total = $this->model_extension_module_phpner_product_filter->getFilterTotalStickers($this->global_id, $this->global_type, $store_id, $customer_group_id, $language_id, $lead_time_status, $filter_data);
                
                foreach ($sticker_data as $sticker) {
                    $stickers = array();
                    
                    if (isset($post_data['sticker'])) {
                        $get_sticker = $post_data['sticker'];
                        
                        if (is_array($get_sticker)) {
                            foreach ($get_sticker as $product_sticker_id) {
                                $stickers[] = $product_sticker_id;
                            }
                        } else {
                            $stickers[] = $get_sticker;
                        }
                    } elseif ($this->request->get) {
                        $make_get_url = http_build_query($this->request->get);
                        
                        preg_match_all('/st_[0-9]{1,}=[0-9]{1,}+&/', $make_get_url, $sticker_get_values);
                        
                        if (isset($sticker_get_values[0])) {
                            foreach ($sticker_get_values[0] as $sticker_get_value) {
                                $sticker_get_values_res = rtrim($sticker_get_value, "&");
                                
                                preg_match('/=([0-9]{1,})/', $sticker_get_values_res, $product_sticker_id);
                                
                                if (isset($product_sticker_id[1])) {
                                    $stickers[] = $product_sticker_id[1];
                                }
                            }
                        }
                    }
                    
                    $data['filter_sticker'][] = array(
                        'product_sticker_id' => $sticker['product_sticker_id'],
                        'name' => $sticker['name'],
                        'total' => $filter_sticker_total,
                        'checked' => $stickers
                    );
                }
            }
            
            if (isset($post_data['sticker'])) {
                $get_sticker = $post_data['sticker'];
                
                if (is_array($get_sticker)) {
                    $url_sticker_ids = '';
                    
                    foreach ($get_sticker as $product_sticker_id) {
                        $url_sticker_ids .= '&st_' . $product_sticker_id . '=' . $product_sticker_id;
                    }
                } else {
                    $url_sticker_ids = '&st_' . $get_sticker . '=' . $get_sticker;
                }
                
                $this->session->data['phpner_sticker'] = $url_sticker_ids;
                $this->global_url .= $url_sticker_ids;
            } elseif ($this->request->get) {
                $stickers_result = '';
                
                foreach ($this->request->get as $key => $get_value) {
                    if (preg_match('/st_[0-9]{1,}/', $key)) {
                        $stickers_result .= '&' . $key . '=' . $get_value;
                    }
                }
                
                $this->session->data['phpner_sticker'] = $stickers_result;
                $this->global_url .= $stickers_result;
            }
        }
        
        $data['filter_standard'] = array();
        
        if ($phpner_product_filter_data['standard_status']) {
            $standard_data = $this->model_extension_module_phpner_product_filter->getFilterStandards($this->global_id, $this->global_type, $store_id, $customer_group_id, $language_id, $lead_time_status);
            
            if ($standard_data) {
                $filter_standard_total = $this->model_extension_module_phpner_product_filter->getFilterTotalStandardValues($this->global_id, $this->global_type, $store_id, $customer_group_id, $language_id, $filter_data);
                
                foreach ($standard_data as $standard) {
                    $standards = array();
                    
                    if (isset($post_data['standard'])) {
                        $get_standard = $post_data['standard'];
                        $standard_ids = array();
                        
                        foreach ($get_standard as $standard_name_mod => $standard_value_mod) {
                            if (is_array($standard_value_mod)) {
                                foreach ($standard_value_mod as $standard_value_mod_children) {
                                    if ($standard_value_mod_children) {
                                        $standard_ids[$standard_name_mod][] = $standard_value_mod_children;
                                    }
                                }
                            } else {
                                if ($standard_value_mod) {
                                    $standard_ids[$standard_name_mod][] = $standard_value_mod;
                                }
                            }
                            
                            if ($standard['values'] && $standard_ids) {
                                foreach ($standard['values'] as $standard_value) {
                                    if (in_array($standard_value['filter_value_mod'], $standard_ids[$standard_name_mod]) && $standard_name_mod == $standard['filter_name_mod']) {
                                        $standards[$standard_name_mod][] = $standard_value['filter_value_mod'];
                                    }
                                }
                            }
                        }
                    } elseif ($this->request->get) {
                        $make_get_url = http_build_query($this->request->get);
                        
                        preg_match_all('/s_nm_[a-z0-9_]{1,}=[a-z0-9_]{1,}(&s_vm_[a-z0-9_]{1,}=[a-z0-9_]{1,}(.*?){1,})+&/', $make_get_url, $standard_get_values);
                        
                        if (isset($standard_get_values[0])) {
                            foreach ($standard_get_values[0] as $standard_get_value) {
                                $standard_get_values_res = rtrim($standard_get_value, "&");
                                
                                preg_match('/=([a-z0-9_]{1,})/', $standard_get_values_res, $standard_group_id);
                                preg_match_all('/s_vm_[a-z0-9_]*=([a-z0-9_]*)/', $standard_get_values_res, $standard_get_value_mod);
                                
                                if (isset($standard_group_id[1]) && isset($standard_get_value_mod[1])) {
                                    if ($standard['values']) {
                                        foreach ($standard['values'] as $standard_value) {
                                            if (in_array($standard_value['filter_value_mod'], $standard_get_value_mod[1]) && $standard_group_id[1] == $standard['filter_name_mod']) {
                                                $standards[$standard_group_id[1]][] = $standard_value['filter_value_mod'];
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                    
                    $data['filter_standard'][] = array(
                        'filter_id' => $standard['filter_id'],
                        'filter_group_id' => $standard['filter_group_id'],
                        'filter_name_mod' => $standard['filter_name_mod'],
                        'name' => $standard['name'],
                        'values' => $standard['values'],
                        'total' => $filter_standard_total,
                        'checked' => (isset($standards[$standard['filter_name_mod']])) ? $standards[$standard['filter_name_mod']] : array()
                    );
                }
            }
            
            $url_standard_ids = array();
            $standards_result = '';
            
            if (isset($post_data['standard'])) {
                $get_standard = $post_data['standard'];
                
                foreach ($post_data['standard'] as $url_standard_name_mod => $standard_value_mod) {
                    if (is_array($standard_value_mod)) {
                        foreach ($standard_value_mod as $standard_value_mod_children) {
                            if ($standard_value_mod_children) {
                                $url_standard_ids[$url_standard_name_mod][] = $standard_value_mod_children;
                            }
                        }
                    } else {
                        if ($standard_value_mod) {
                            $url_standard_ids[$url_standard_name_mod] = $standard_value_mod;
                        }
                    }
                    
                    if ($url_standard_ids) {
                        if (is_array($url_standard_ids[$url_standard_name_mod])) {
                            $url_standard_ids_standard_name_mod_array = '';
                            
                            foreach ($url_standard_ids[$url_standard_name_mod] as $key => $url_standard_ids_standard_name_mod) {
                                $url_standard_ids_standard_name_mod_array .= '&s_vm_' . $url_standard_ids_standard_name_mod . '=' . $url_standard_ids_standard_name_mod;
                            }
                            
                            $standards_result .= '&s_nm_' . $url_standard_name_mod . '=' . $url_standard_name_mod . $url_standard_ids_standard_name_mod_array;
                        } else {
                            $standards_result .= '&s_nm_' . $url_standard_name_mod . '=' . $url_standard_name_mod . '&s_vm_' . $url_standard_ids[$url_standard_name_mod] . '=' . $url_standard_ids[$url_standard_name_mod];
                        }
                    }
                }
                
                $this->session->data['phpner_standard'] = $standards_result;
                $this->global_url .= $standards_result;
            } elseif ($this->request->get) {
                $standards_result = '';
                
                foreach ($this->request->get as $key => $get_value) {
                    if (preg_match('/s_nm_[0-9]{1,}/', $key)) {
                        $standards_result .= '&' . $key . '=' . $get_value;
                    }
                    if (preg_match('/s_vm_[a-z0-9_]{1,}/', $key)) {
                        $standards_result .= '&' . $key . '=' . $get_value;
                    }
                }
                
                $this->session->data['phpner_standard'] = $standards_result;
                $this->global_url .= $standards_result;
            }
        }
        
        $data['filter_review'] = array();
        
        if ($phpner_product_filter_data['review_status']) {
            $filter_review_total = $this->model_extension_module_phpner_product_filter->getFilterTotalReview($this->global_id, $this->global_type, $store_id, $customer_group_id, $language_id, $lead_time_status, $filter_data);
            
            for ($review_key = 1; $review_key <= 5; $review_key++) {
                $ratings = array();
                
                if (isset($post_data['rating'])) {
                    $get_rating = $post_data['rating'];
                    
                    if (is_array($get_rating)) {
                        foreach ($get_rating as $rating_value) {
                            $ratings[] = $rating_value;
                        }
                    } else {
                        $ratings[] = $get_rating;
                    }
                } elseif ($this->request->get) {
                    $make_get_url = http_build_query($this->request->get);
                    
                    preg_match_all('/r_[0-9]{1,}=[0-9]{1,}+&/', $make_get_url, $rating_get_values);
                    
                    if (isset($rating_get_values[0])) {
                        foreach ($rating_get_values[0] as $rating_get_value) {
                            $rating_get_values_res = rtrim($rating_get_value, "&");
                            
                            preg_match('/=([0-9]{1,})/', $rating_get_values_res, $rating_id);
                            
                            if (isset($rating_id[1])) {
                                $ratings[] = $rating_id[1];
                            }
                        }
                    }
                }
                
                $data['filter_review'][] = array(
                    'review_value_id' => $review_key,
                    'review_key' => 'star' . $review_key . '_total',
                    'name' => $this->language->get('text_star_' . $review_key),
                    'thumb' => 'image/phpner/phpner_product_filter/star_' . $review_key . '.png',
                    'total' => $filter_review_total,
                    'checked' => $ratings
                );
            }
            
            if (isset($post_data['rating'])) {
                $get_rating = $post_data['rating'];
                
                if (is_array($get_rating)) {
                    $url_rating_ids = '';
                    
                    foreach ($get_rating as $product_rating_id) {
                        $url_rating_ids .= '&r_' . $product_rating_id . '=' . $product_rating_id;
                    }
                } else {
                    $url_rating_ids = '&r_' . $get_rating . '=' . $get_rating;
                }
                
                $this->session->data['phpner_rating'] = $url_rating_ids;
                $this->global_url .= $url_rating_ids;
            } elseif ($this->request->get) {
                $ratings_result = '';
                
                foreach ($this->request->get as $key => $get_value) {
                    if (preg_match('/r_[0-9]{1,}/', $key)) {
                        $ratings_result .= '&' . $key . '=' . $get_value;
                    }
                }
                
                $this->session->data['phpner_rating'] = $ratings_result;
                $this->global_url .= $ratings_result;
            }
        }
        
        $data['custom_sort'] = array();
        
        if (isset($post_data['sort'])) {
            $sort_value                      = strtolower($post_data['sort']);
            $this->session->data['phpner_sort'] = strtolower($post_data['sort']);
            // $this->global_url .= '&sort='.$post_data['sort'];
        } elseif (isset($this->request->get['sort'])) {
            $sort_value = strtolower($this->request->get['sort']);
            $this->global_url .= '&sort=' . $this->request->get['sort'];
            // $this->session->data['phpner_sort'] = strtolower($this->request->get['sort']);
        } else {
            $sort_value = '';
        }
        
        if (isset($post_data['order'])) {
            $order_value = strtolower($post_data['order']);
            $this->global_url .= '&order=' . strtolower($post_data['order']);
            // $this->session->data['phpner_order'] = strtolower($post_data['order']);
        } elseif (isset($this->request->get['order'])) {
            $order_value = strtolower($this->request->get['order']);
            $this->global_url .= '&order=' . strtolower($this->request->get['order']);
            // $this->session->data['phpner_order'] = strtolower($this->request->get['order']);
        } else {
            $order_value = '';
        }
        
        $data['custom_sort'][] = array(
            'name' => $this->language->get('text_sort_' . str_replace('|', '_', strtolower(str_replace(array(
                'p.',
                'pd.',
                'order='
            ), '', $phpner_product_filter_data['default_sort'])))),
            'value' => str_replace('|', '&', strtolower($phpner_product_filter_data['default_sort'])),
            'checked' => (str_replace('|', '&', strtolower($phpner_product_filter_data['default_sort'])) == $sort_value . '&order=' . $order_value) ? true : false
        );
        
        foreach ($phpner_product_filter_data['custom_sort'] as $custom_sort) {
            $custom_sort_mod      = strtolower(str_replace('|', '&', $custom_sort));
            $custom_sort_mod_deep = strtolower(str_replace(array(
                'p.',
                'pd.',
                'order='
            ), '', $custom_sort));
            
            if (strtolower($custom_sort) != strtolower($phpner_product_filter_data['default_sort'])) {
                $data['custom_sort'][] = array(
                    'name' => $this->language->get('text_sort_' . str_replace('|', '_', $custom_sort_mod_deep)),
                    'value' => $custom_sort_mod,
                    'checked' => ($custom_sort_mod == $sort_value . '&order=' . $order_value) ? true : false
                );
            }
        }
        
        if (isset($post_data['limit'])) {
            $this->global_url .= '&limit=' . $post_data['limit'];
            // $this->session->data['phpner_limit'] = $post_data['limit'];
        } elseif (isset($this->request->get['limit'])) {
            $this->global_url .= '&limit=' . $this->request->get['limit'];
            // $this->session->data['phpner_limit'] = $this->request->get['limit'];
        }
        
        $custom_limits        = explode(',', $phpner_product_filter_data['custom_limit']);
        $data['custom_limit'] = array();
        $limit_value          = '';
        
        if ($custom_limits) {
            foreach ($custom_limits as $custom_limit) {
                if (isset($post_data['limit'])) {
                    $limit_value = $post_data['limit'];
                } elseif (isset($this->request->get['limit'])) {
                    $limit_value = $this->request->get['limit'];
                }
                
                $data['custom_limit'][] = array(
                    'value' => $custom_limit,
                    'checked' => $custom_limit == $limit_value
                );
            }
        }
        
        if (isset($post_data['page'])) {
            $this->global_url .= '&page=' . $post_data['page'];
            // $this->session->data['phpner_page'] = $post_data['page'];
        } elseif (isset($this->request->get['page'])) {
            $this->global_url .= '&page=' . $this->request->get['page'];
            // $this->session->data['phpner_page'] = $this->request->get['page'];
        }
        
        $data['url'] = urldecode($this->url->link($route, $this->global_url, true));
        
        $product_ids = $this->model_extension_module_phpner_product_filter->getProductIDs($this->global_id, $this->global_type, $store_id, $customer_group_id);
        
        if ($product_ids) {
            if ($post_data) {
                $this->response->setOutput($this->load->view('extension/module/phpner_product_filter', $data));
            } else {
                return $this->load->view('extension/module/phpner_product_filter', $data);
            }
        }
    }
    
    public function filterProducts() {
        $json = array();
        $this->load->model('extension/module/phpner_product_filter');
        $this->load->model('tool/image');
        $this->load->model('catalog/product');
        $this->load->language('extension/module/phpner_product_filter');
        
        $language_keys = array(
            'button_popup_view',
            'button_cart',
            'text_model',
            'text_stock'
        );
        foreach ($language_keys as $language_key) {
            $json['language'][$language_key] = $this->language->get($language_key);
        }
        
        $phpner_product_filter_data = $this->config->get('phpner_product_filter_data');
        
        // popup_view start
        $phpner_popup_view_data = $this->config->get('phpner_popup_view_data');
        
        if (isset($phpner_popup_view_data['status']) && $phpner_popup_view_data['status']) {
            $json['phpner_popup_view_status'] = 1;
        } else {
            $json['phpner_popup_view_status'] = 0;
        }
        // popup_view end
        
        $post_data = isset($this->request->post) ? $this->request->post : array();
        
        if ($post_data) {
            $filter_data = array(
                'filter_data' => array(
                    'option_logic_with_other' => $phpner_product_filter_data['option_logic_with_other'],
                    'option_logic_between_option' => $phpner_product_filter_data['option_logic_between_option'],
                    'attribute_logic_with_other' => $phpner_product_filter_data['attribute_logic_with_other'],
                    'attribute_logic_between_attribute' => $phpner_product_filter_data['attribute_logic_between_attribute'],
                    'standard_logic_with_other' => $phpner_product_filter_data['standard_logic_with_other'],
                    'standard_logic_between_standard' => $phpner_product_filter_data['standard_logic_between_standard'],
                    'manufacturer_logic_with_other' => $phpner_product_filter_data['manufacturer_logic_with_other'],
                    'stock_ending_value' => $phpner_product_filter_data['stock_ending_value'],
                    'stock_logic_with_other' => $phpner_product_filter_data['stock_logic_with_other'],
                    'stock_logic_between_stock' => $phpner_product_filter_data['stock_logic_between_stock'],
                    'review_logic_with_other' => $phpner_product_filter_data['review_logic_with_other'],
                    'review_logic_between_review' => $phpner_product_filter_data['review_logic_between_review'],
                    'sticker_logic_with_other' => $phpner_product_filter_data['sticker_logic_with_other'],
                    'sticker_logic_between_sticker' => $phpner_product_filter_data['sticker_logic_between_sticker'],
                    'tag_logic_with_other' => $phpner_product_filter_data['tag_logic_with_other'],
                    'customer_group_id' => ($this->customer->isLogged()) ? (int) $this->customer->getGroupId() : (int) $this->config->get('config_customer_group_id'),
                    'store_id' => $this->config->get('config_store_id'),
                    'language_id' => $this->config->get('config_language_id')
                ),
                'special_only' => (isset($post_data['special_only'])) ? $post_data['special_only'] : '',
                'global_type' => $post_data['global_type'],
                'global_id' => $post_data['global_id'],
                'sort' => $post_data['sort'],
                'order' => $post_data['order'],
                'start' => ($post_data['page'] - 1) * $post_data['limit'],
                'limit' => $post_data['limit'],
                'page' => $post_data['page'],
                'low_price' => (isset($post_data['low_price'])) ? floor($post_data['low_price'] / $this->currency->getValue($this->session->data['currency'])) : '',
                'high_price' => (isset($post_data['high_price'])) ? ceil($post_data['high_price'] / $this->currency->getValue($this->session->data['currency'])) : '',
                'tag' => (isset($post_data['tag'])) ? $post_data['tag'] : '',
                'manufacturer' => (isset($post_data['m_id'])) ? $post_data['m_id'] : '',
                'stock' => (isset($post_data['stock'])) ? $post_data['stock'] : '',
                'rating' => (isset($post_data['rating'])) ? $post_data['rating'] : '',
                'sticker' => (isset($post_data['sticker'])) ? $post_data['sticker'] : '',
                'option' => (isset($post_data['option'])) ? $post_data['option'] : '',
                'attribute' => (isset($post_data['attribute'])) ? $post_data['attribute'] : '',
                'standard' => (isset($post_data['standard'])) ? $post_data['standard'] : ''
            );
        }
        
        if (isset($post_data['route'])) {
            $route = $post_data['route'];
        }
        
        if (isset($route)) {
            $this->global_url = '';
            
            if ($route == 'product/category') {
                
                if (isset($post_data['url'])) {
                    parse_str(str_replace('&amp;', '&', $post_data['url']), $url_parsed);
                    
                    if (isset($url_parsed['path'])) {
                        $path = $url_parsed['path'];
                    } else {
                        $path = array();
                    }
                }
                
                if (isset($post_data['global_id']) && $post_data['global_id']) {
                    $this->global_id = $post_data['global_id'];
                } else {
                    $this->global_id = end($path);
                }
                
                $this->global_type = 'category';
                
                $this->global_url .= '&path=' . $this->global_id;
                
            } elseif ($route == 'product/manufacturer/info') {
                if (isset($post_data['url'])) {
                    parse_str(str_replace('&amp;', '&', $post_data['url']), $url_parsed);
                    
                    if (isset($url_parsed['manufacturer_id'])) {
                        $path = $url_parsed['manufacturer_id'];
                    } else {
                        $path = 0;
                    }
                }
                
                if (isset($post_data['global_id']) && $post_data['global_id']) {
                    $this->global_id = $post_data['global_id'];
                } else {
                    $this->global_id = $path;
                }
                
                $this->global_type = 'manufacturer';
                
                $this->global_url .= '&manufacturer_id=' . $this->global_id;
            } elseif ($route == 'product/special') {
                $this->global_type = 'special';
            }
        }
        
        $this->global_url .= '&phpner_filter=1';
        
        if ($phpner_product_filter_data['price_status']) {
            if (isset($post_data['low_price']) && isset($post_data['high_price'])) {
                $filter_prices = array(
                    'low_price' => preg_replace("/[^,.0-9]/", '', $post_data['low_price']),
                    'high_price' => preg_replace("/[^,.0-9]/", '', $post_data['high_price'])
                );
                
                $this->session->data['low_price']  = $filter_prices['low_price'];
                $this->session->data['high_price'] = $filter_prices['high_price'];
                
                $this->global_url .= '&price=' . $filter_prices['low_price'] . ',' . $filter_prices['high_price'];
            }
        }
        
        if ($phpner_product_filter_data['tag_status']) {
            if (isset($post_data['tag'])) {
                $this->session->data['phpner_tag'] = $post_data['tag'];
                $this->global_url .= '&tag=' . $post_data['tag'];
            } elseif (isset($this->request->get['tag'])) {
                $this->session->data['phpner_tag'] = $this->request->get['tag'];
                $this->global_url .= '&tag=' . $this->request->get['tag'];
            }
        }
        
        if ($phpner_product_filter_data['show_special_only_bytton']) {
            if (isset($post_data['special_only'])) {
                $this->global_url .= '&special_only=1';
            } elseif (isset($this->request->get['special_only'])) {
                $this->global_url .= '&special_only=1';
            }
        }
        
        if ($phpner_product_filter_data['manufacturer_status']) {
            if (isset($post_data['m_id'])) {
                if (is_array($post_data['m_id'])) {
                    $brands = '';
                    
                    foreach ($post_data['m_id'] as $manufacturer_id) {
                        $brands .= '&m_n_' . $manufacturer_id . '=' . $manufacturer_id;
                    }
                    
                    $this->session->data['phpner_brand'] = $brands;
                    $this->global_url .= $brands;
                } else {
                    $this->session->data['phpner_brand'] = $post_data['m_id'];
                    $this->global_url .= '&m_n_' . $post_data['m_id'] . '=' . $post_data['m_id'];
                }
            }
        }
        
        if ($phpner_product_filter_data['stock_status']) {
            if (isset($post_data['stock'])) {
                if (is_array($post_data['stock'])) {
                    $stocks = '';
                    
                    foreach ($post_data['stock'] as $stock_value) {
                        $stocks .= '&s_s_' . $stock_value . '=' . $stock_value;
                    }
                    
                    $this->session->data['phpner_stock'] = $stocks;
                    $this->global_url .= $stocks;
                } else {
                    $this->session->data['phpner_stock'] = $post_data['stock'];
                    $this->global_url .= '&s_s_' . $post_data['stock'] . '=' . $post_data['stock'];
                }
            }
        }
        
        if ($phpner_product_filter_data['attribute_status']) {
            if (isset($post_data['attribute'])) {
                $attribute_ids     = array();
                $attributes_result = '';
                
                foreach ($post_data['attribute'] as $attribute_name_mod => $attribute_value_mod) {
                    if (is_array($attribute_value_mod)) {
                        foreach ($attribute_value_mod as $attribute_value_mod_children) {
                            if ($attribute_value_mod_children) {
                                $attribute_ids[$attribute_name_mod][] = $attribute_value_mod_children;
                            }
                        }
                    } else {
                        if ($attribute_value_mod) {
                            $attribute_ids[$attribute_name_mod] = $attribute_value_mod;
                        }
                    }
                    
                    if ($attribute_ids) {
                        if (is_array($attribute_ids[$attribute_name_mod])) {
                            $attributes_result_inner = '';
                            
                            foreach ($attribute_ids[$attribute_name_mod] as $value) {
                                $attributes_result_inner .= '&a_vm_' . $value . '=' . $value;
                            }
                            
                            $attributes_result .= '&a_nm_' . $attribute_name_mod . '=' . $attribute_name_mod . $attributes_result_inner;
                        } else {
                            $attributes_result .= '&a_nm_' . $attribute_name_mod . '=' . $attribute_name_mod . '&a_vm_' . $attribute_ids[$attribute_name_mod] . '=' . $attribute_ids[$attribute_name_mod];
                        }
                    }
                }
                
                $this->session->data['phpner_attribute'] = $attributes_result;
                $this->global_url .= $attributes_result;
            }
        }
        
        if ($phpner_product_filter_data['option_status']) {
            if (isset($post_data['option'])) {
                $option_ids     = array();
                $options_result = '';
                
                foreach ($post_data['option'] as $option_name_mod => $option_value_mod) {
                    if (is_array($option_value_mod)) {
                        foreach ($option_value_mod as $option_value_mod_children) {
                            if ($option_value_mod_children) {
                                $option_ids[$option_name_mod][] = $option_value_mod_children;
                            }
                        }
                    } else {
                        if ($option_value_mod) {
                            $option_ids[$option_name_mod] = $option_value_mod;
                        }
                    }
                    
                    if ($option_ids) {
                        if (is_array($option_ids[$option_name_mod])) {
                            $options_result_inner = '';
                            
                            foreach ($option_ids[$option_name_mod] as $value) {
                                $options_result_inner .= '&o_vm_' . $value . '=' . $value;
                            }
                            
                            $options_result .= '&o_nm_' . $option_name_mod . '=' . $option_name_mod . $options_result_inner;
                        } else {
                            $options_result .= '&o_nm_' . $option_name_mod . '=' . $option_name_mod . '&o_vm_' . $option_ids[$option_name_mod] . '=' . $option_ids[$option_name_mod];
                        }
                    }
                }
                
                $this->session->data['phpner_option'] = $options_result;
                $this->global_url .= $options_result;
            }
        }
        
        if ($phpner_product_filter_data['sticker_status']) {
            if (isset($post_data['sticker'])) {
                if (is_array($post_data['sticker'])) {
                    $stickers = '';
                    
                    foreach ($post_data['sticker'] as $sticker_id) {
                        $stickers .= '&st_' . $sticker_id . '=' . $sticker_id;
                    }
                    
                    $this->session->data['phpner_sticker'] = $stickers;
                    $this->global_url .= $stickers;
                } else {
                    $this->session->data['phpner_sticker'] = $post_data['sticker'];
                    $this->global_url .= '&st_' . $post_data['sticker'] . '=' . $post_data['sticker'];
                }
            }
        }
        
        if ($phpner_product_filter_data['standard_status']) {
            if (isset($post_data['standard'])) {
                $standard_ids     = array();
                $standards_result = '';
                
                foreach ($post_data['standard'] as $standard_name_mod => $standard_value_mod) {
                    if (is_array($standard_value_mod)) {
                        foreach ($standard_value_mod as $standard_value_mod_children) {
                            if ($standard_value_mod_children) {
                                $standard_ids[$standard_name_mod][] = $standard_value_mod_children;
                            }
                        }
                    } else {
                        if ($standard_value_mod) {
                            $standard_ids[$standard_name_mod] = $standard_value_mod;
                        }
                    }
                    
                    if ($standard_ids) {
                        if (is_array($standard_ids[$standard_name_mod])) {
                            $standards_result_inner = '';
                            
                            foreach ($standard_ids[$standard_name_mod] as $value) {
                                $standards_result_inner .= '&s_vm_' . $value . '=' . $value;
                            }
                            
                            $standards_result .= '&s_nm_' . $standard_name_mod . '=' . $standard_name_mod . $standards_result_inner;
                        } else {
                            $standards_result .= '&s_nm_' . $standard_name_mod . '=' . $standard_name_mod . '&s_vm_' . $standard_ids[$standard_name_mod] . '=' . $standard_ids[$standard_name_mod];
                        }
                    }
                }
                
                $this->session->data['phpner_standard'] = $standards_result;
                $this->global_url .= $standards_result;
            }
        }
        
        if ($phpner_product_filter_data['review_status']) {
            if (isset($post_data['rating'])) {
                if (is_array($post_data['rating'])) {
                    $ratings = '';
                    
                    foreach ($post_data['rating'] as $rating_id) {
                        $ratings .= '&r_' . $rating_id . '=' . $rating_id;
                    }
                    
                    $this->session->data['phpner_rating'] = $ratings;
                    $this->global_url .= $ratings;
                } else {
                    $this->session->data['phpner_rating'] = $post_data['rating'];
                    $this->global_url .= '&r_' . $post_data['rating'] . '=' . $post_data['rating'];
                }
            }
        }
        
        if (isset($post_data['sort'])) {
            $this->global_url .= '&sort=' . strtolower($post_data['sort']);
            // $this->session->data['phpner_sort'] = strtolower($post_data['sort']);
        }
        
        if (isset($post_data['order'])) {
            $this->global_url .= '&order=' . strtolower($post_data['order']);
            // $this->session->data['phpner_order'] = strtolower($post_data['order']);
        }
        
        if (isset($post_data['limit'])) {
            $this->global_url .= '&limit=' . (int) $post_data['limit'];
            // $this->session->data['phpner_limit'] = (int)$post_data['limit'];
        }
        
        if (isset($post_data['page'])) {
            $this->global_url .= '&page=' . (int) $post_data['page'];
            // $this->session->data['phpner_page'] = (int)$post_data['page'];
        }
        
        if ($this->global_type == 'manufacturer') {
            $this->global_url .= '&brand_page=true';
        }
        
        $json['url'] = urldecode($this->url->link($route, $this->global_url, true));
        
        $json['products'] = array();
        
        if (!isset($this->request->get['update_seo_url'])) {
            $results = $this->model_extension_module_phpner_product_filter->getProducts($filter_data, 'products');
            
            $product_total = $this->model_extension_module_phpner_product_filter->getProducts($filter_data, 'total');
            
            if ($results) {
                foreach ($results as $result) {
                    if ($result) {
                        if ($result['image']) {
                            $image = $this->model_tool_image->resize($result['image'], $this->config->get($this->config->get('config_theme') . '_image_product_width'), $this->config->get($this->config->get('config_theme') . '_image_product_height'));
                        } else {
                            $image = $this->model_tool_image->resize('placeholder.png', $this->config->get($this->config->get('config_theme') . '_image_product_width'), $this->config->get($this->config->get('config_theme') . '_image_product_height'));
                        }
                        
                        if ($this->customer->isLogged() || !$this->config->get('config_customer_price')) {
                            $price = $this->currency->format($this->tax->calculate($result['price'], $result['tax_class_id'], $this->config->get('config_tax')), $this->session->data['currency']);
                        } else {
                            $price = false;
                        }
                        
                        if ((float) $result['special']) {
                            $economy = round((($result['price'] - $result['special']) / ($result['price'] + 0.01)) * 100, 0);
                        } else {
                            $economy = false;
                        }
                        
                        if ((float) $result['special']) {
                            $special = $this->currency->format($this->tax->calculate($result['special'], $result['tax_class_id'], $this->config->get('config_tax')), $this->session->data['currency']);
                        } else {
                            $special = false;
                        }
                        
                        if ($this->config->get('config_tax')) {
                            $tax = $this->currency->format((float) $result['special'] ? $result['special'] : $result['price'], $this->session->data['currency']);
                        } else {
                            $tax = false;
                        }
                        
                        if ($this->config->get('config_review_status')) {
                            $rating = (int) $result['rating'];
                        } else {
                            $rating = false;
                        }
                        
                        $phpner_product_stickers_data = $this->config->get('phpner_product_stickers_data');
                        $phpner_product_stickers      = array();
                        
                        if (isset($phpner_product_stickers_data['status']) && $phpner_product_stickers_data['status']) {
                            $this->load->model('catalog/phpner_product_stickers');
                            
                            if (isset($result['phpner_product_stickers']) && $result['phpner_product_stickers']) {
                                $stickers = unserialize($result['phpner_product_stickers']);
                            } else {
                                $stickers = array();
                            }
                            
                            foreach ($stickers as $product_sticker_id) {
                                $sticker_info = $this->model_catalog_phpner_product_stickers->getProductSticker($product_sticker_id);
                                
                                if ($sticker_info) {
                                    $phpner_product_stickers[] = array(
                                        'text' => $sticker_info['text'],
                                        'color' => $sticker_info['color'],
                                        'background' => $sticker_info['background']
                                    );
                                }
                            }
                            
                            $sticker_sort_order = array();
                            
                            foreach ($stickers as $key => $product_sticker_id) {
                                $sticker_info = $this->model_catalog_phpner_product_stickers->getProductSticker($product_sticker_id);
                                
                                if ($sticker_info) {
                                    $sticker_sort_order[$key] = $sticker_info['sort_order'];
                                }
                            }
                            
                            array_multisort($sticker_sort_order, SORT_ASC, $phpner_product_stickers);
                        }
                        
                        $phpner_options = array();
                        
                        $phpner_advanced_options_settings_data = $this->config->get('phpner_advanced_options_settings_data');
                        
                        foreach ($this->model_catalog_product->getProductOptions($result['product_id']) as $option) {
                            $product_option_value_data = array();
                            
                            if (isset($phpner_advanced_options_settings_data['allowed_options']) && (in_array($option['option_id'], $phpner_advanced_options_settings_data['allowed_options']))) {
                                foreach ($option['product_option_value'] as $option_value) {
                                    if (!$option_value['subtract'] || ($option_value['quantity'] > 0)) {
                                        
                                        if ((($this->config->get('config_customer_price') && $this->customer->isLogged()) || !$this->config->get('config_customer_price')) && (float) $option_value['price']) {
                                            $phpner_option_price = $this->currency->format($this->tax->calculate($option_value['price'], $result['tax_class_id'], $this->config->get('config_tax') ? 'P' : false), $this->session->data['currency']);
                                        } else {
                                            $phpner_option_price = false;
                                        }
                                        
                                        $product_option_value_data[] = array(
                                            'product_option_value_id' => $option_value['product_option_value_id'],
                                            'option_value_id' => $option_value['option_value_id'],
                                            'name' => $option_value['name'],
                                            'image' => $option_value['image'] ? $this->model_tool_image->resize($option_value['image'], 50, 50) : '',
                                            'price' => $phpner_option_price,
                                            'price_prefix' => $option_value['price_prefix']
                                        );
                                    }
                                }
                                
                                $phpner_options[] = array(
                                    'product_option_id' => $option['product_option_id'],
                                    'product_option_value' => $product_option_value_data,
                                    'option_id' => $option['option_id'],
                                    'name' => $option['name'],
                                    'type' => $option['type'],
                                    'value' => $option['value'],
                                    'required' => $option['required']
                                );
                            }
                        }
                        
                        $phpner_product_preorder_text     = $this->config->get('phpner_product_preorder_text');
                        $phpner_product_preorder_data     = $this->config->get('phpner_product_preorder_data');
                        $phpner_product_preorder_language = $this->load->language('extension/module/phpner_product_preorder');
                        
                        if (isset($phpner_product_preorder_data['status']) && $phpner_product_preorder_data['status'] && isset($phpner_product_preorder_data['stock_statuses']) && isset($result['phpner_stock_status_id']) && in_array($result['phpner_stock_status_id'], $phpner_product_preorder_data['stock_statuses'])) {
                            $product_preorder_text   = $phpner_product_preorder_text[$this->session->data['language']]['call_button'];
                            $product_preorder_status = 1;
                        } else {
                            $product_preorder_text   = $phpner_product_preorder_language['text_out_of_stock'];
                            $product_preorder_status = 2;
                        }
                        
                        if ($result['quantity'] <= 0) {
                            $stock = $result['stock_status'];
                        } elseif ($this->config->get('config_stock_display')) {
                            $stock = $result['quantity'];
                        } else {
                            $stock = $this->language->get('text_instock');
                        }
                        
                        $phpner_attributes = array();
                        
                        $phpner_advanced_attributes_settings_data = $this->config->get('phpner_advanced_attributes_settings_data');
                        
                        if (isset($phpner_advanced_attributes_settings_data['status']) && $phpner_advanced_attributes_settings_data['status']) {
                            foreach ($this->model_catalog_product->getProductAttributes($result['product_id']) as $attribute_group) {
                                foreach ($attribute_group['attribute'] as $attribute) {
                                    if (isset($phpner_advanced_attributes_settings_data['allowed_attributes']) && (in_array($attribute['attribute_id'], $phpner_advanced_attributes_settings_data['allowed_attributes']))) {
                                        $phpner_attributes[] = array(
                                            'name' => $attribute['name'],
                                            'text' => $attribute['text']
                                        );
                                    }
                                }
                            }
                        }
                        
                        $json['products'][] = array(
                            'product_id' => $result['product_id'],
                            'thumb' => $image,
                            'name' => $result['name'],
                            'description' => utf8_substr(strip_tags(html_entity_decode($result['description'], ENT_QUOTES, 'UTF-8')), 0, $this->config->get($this->config->get('config_theme') . '_product_description_length')) . '..',
                            'price' => $price,
                            'special' => $special,
                            'tax' => $tax,
                            'minimum' => $result['minimum'] > 0 ? $result['minimum'] : 1,
                            'rating' => $result['rating'],
                            'phpner_options' => $phpner_options,
                            'phpner_attributes' => $phpner_attributes,
                            'phpner_product_stickers' => $phpner_product_stickers,
                            'economy' => $economy,
                            'quantity' => $result['quantity'],
                            'product_preorder_text' => $product_preorder_text,
                            'product_preorder_status' => $product_preorder_status,
                            'model' => $result['model'],
                            'stock' => $stock,
                            'href' => $this->url->link('product/product', 'product_id=' . $result['product_id'])
                        );
                    }
                }
            } else {
                $json['error'] = $this->language->get('error_no_products');
            }
            
            $pagination        = new Pagination();
            $pagination->total = $product_total;
            $pagination->page  = $post_data['page'];
            $pagination->limit = $post_data['limit'];
            $pagination->url   = urldecode($this->url->link($route, $this->global_url . '&page={page}', true));
            
            $json['total'] = $product_total;
            
            $json['pagination'] = $pagination->render();
            
            $current_total = ((($post_data['page'] - 1) * $post_data['limit']) > ($product_total - $post_data['limit'])) ? $product_total : ((($post_data['page'] - 1) * $post_data['limit']) + $post_data['limit']);
            
            // $json['results'] = sprintf($this->language->get('text_pagination'), ($product_total) ? (($post_data['page'] - 1) * $post_data['limit']) + 1 : 0, $current_total, $product_total, ceil($product_total / $post_data['limit']));
            
            $json['results_button_show_more_products'] = sprintf($this->language->get('button_show_more_products'), $current_total, $product_total);
            
            if ($phpner_product_filter_data['show_more_limit_show']) {
                if ($current_total == $product_total) {
                    $json['show_more_limit_show'] = '';
                } else {
                    $json['show_more_limit_show'] = 1;
                }
            } else {
                $json['show_more_limit_show'] = '';
            }
            
            if ($post_data['page'] == 1) {
                $this->document->addLink($this->url->link($route, $this->global_url, 'SSL'), 'canonical');
            } elseif ($post_data['page'] == 2) {
                $this->document->addLink($this->url->link($route, $this->global_url, 'SSL'), 'prev');
            } else {
                $this->document->addLink($this->url->link($route, $this->global_url . '&page=' . ($post_data['page'] - 1), 'SSL'), 'prev');
            }
            
            if ($post_data['limit'] && ceil($product_total / $post_data['limit']) > $post_data['page']) {
                $this->document->addLink($this->url->link($route, $this->global_url . '&page=' . ($post_data['page'] + 1), 'SSL'), 'next');
            }
        }
        
        $this->response->addHeader('Content-Type: application/json');
        $this->response->setOutput(json_encode($json));
    }
    
    public function sitemap() {
        $this->load->model('extension/module/phpner_product_filter');
        $phpner_product_filter_data   = $this->config->get('phpner_product_filter_data');
        $phpner_product_filter_status = $this->config->get('phpner_product_filter_status');
        
        if ($phpner_product_filter_status && isset($phpner_product_filter_data['enable_seo']) && $phpner_product_filter_data['enable_seo']) {
            
            $results = $this->model_extension_module_phpner_product_filter->getSeos();
            
            $output = '';
            
            if ($results) {
                $output .= '<?xml version="1.0" encoding="UTF-8"?>';
                $output .= '<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">';
                
                $protocol = strtolower(substr($this->request->server["SERVER_PROTOCOL"], 0, 5)) == 'https' ? HTTPS_SERVER : HTTP_SERVER;
                
                foreach ($results as $result) {
                    $output .= '<url>';
                    $output .= '	<loc>' . $protocol . $result['seo_url'] . '</loc>';
                    $output .= '	<changefreq>weekly</changefreq>';
                    $output .= '	<priority>0.9</priority>';
                    $output .= '</url>';
                }
                
                $output .= '</urlset>';
            }
            
            $this->response->addHeader('Content-Type: application/xml');
            $this->response->setOutput($output);
        }
    }
}