<?php
class ControllerProductCategory extends Controller {
	public function index() {

        // phpner_store start
        $data['phpner_store_data'] = $this->config->get('phpner_store_data');
        // phpner_store end
      

      $phpner_product_filter_data = $this->config->get('phpner_product_filter_data');
      $phpner_product_filter_status = $this->config->get('phpner_product_filter_status');
      $this->load->model('extension/module/phpner_product_filter');
      

        $data['phpner_popup_view_data'] = $this->config->get('phpner_popup_view_data');
        $data['button_popup_view'] = $this->language->get('button_popup_view');
      
		$this->load->language('product/category');

		$this->load->model('catalog/category');

		$this->load->model('catalog/product');

		$this->load->model('tool/image');

		if (isset($this->request->get['filter'])) {
			$filter = $this->request->get['filter'];
		} else {
			$filter = '';
		}


      if (isset($phpner_product_filter_data['default_sort'])) {
        $phpner_product_filter_default_sort = explode('|', $phpner_product_filter_data['default_sort']);
      } else {
        $phpner_product_filter_default_sort = array(0 => 'p.sort_order', 1 => 'order=ASC');
      }
      $phpner_product_filter_default_order = str_replace('order=', '', $phpner_product_filter_default_sort[1]);
      
		if (isset($this->request->get['sort'])) {
			$sort = $this->request->get['sort'];

      } elseif ($phpner_product_filter_status && $phpner_product_filter_data['default_sort']) {
        $sort = $phpner_product_filter_default_sort[0];
      
		} else {
			$sort = 'p.sort_order';
		}

		if (isset($this->request->get['order'])) {
			$order = $this->request->get['order'];

      } elseif ($phpner_product_filter_status && $phpner_product_filter_data['default_sort']) {
        $order = $phpner_product_filter_default_order;
      
		} else {
			$order = 'ASC';
		}

		if (isset($this->request->get['page'])) {
			$page = $this->request->get['page'];
		} else {
			$page = 1;
		}

		if (isset($this->request->get['limit'])) {
			$limit = (int)$this->request->get['limit'];
		} else {
			$limit = $this->config->get($this->config->get('config_theme') . '_product_limit');
		}

		$data['breadcrumbs'] = array();

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('text_home'),
			'href' => $this->url->link('common/home')
		);

		if (isset($this->request->get['path'])) {
			$url = '';

			if (isset($this->request->get['sort'])) {
				$url .= '&sort=' . $this->request->get['sort'];
			}

			if (isset($this->request->get['order'])) {
				$url .= '&order=' . $this->request->get['order'];
			}

			if (isset($this->request->get['limit'])) {
				$url .= '&limit=' . $this->request->get['limit'];
			}

			$path = '';

			$parts = explode('_', (string)$this->request->get['path']);

			$category_id = (int)array_pop($parts);

			foreach ($parts as $path_id) {
				if (!$path) {
					$path = (int)$path_id;
				} else {
					$path .= '_' . (int)$path_id;
				}

				$category_info = $this->model_catalog_category->getCategory($path_id);

				if ($category_info) {
					$data['breadcrumbs'][] = array(
						'text' => $category_info['name'],
						'href' => 
      (isset($phpner_product_filter_data['enable_seo']) && $phpner_product_filter_data['enable_seo'] && isset($this->request->get['route']) && preg_match('/filter/', $this->request->server['REQUEST_URI'])) ? $this->url->link('product/category', 'path=' . $path) : $this->url->link('product/category', 'path=' . $path . $url)
      
					);
				}
			}
		} else {
			$category_id = 0;
		}

		$category_info = $this->model_catalog_category->getCategory($category_id);

		if ($category_info) {

			if ($category_info['meta_title']) {
				$this->document->setTitle($category_info['meta_title']);
			} else {
				$this->document->setTitle($category_info['name']);
			}

			$this->document->setDescription($category_info['meta_description']);
			$this->document->setKeywords($category_info['meta_keyword']);

			if ($category_info['meta_h1']) {
				$data['heading_title'] = $category_info['meta_h1'];
			} else {
				$data['heading_title'] = $category_info['name'];
			}

			$data['text_refine'] = $this->language->get('text_refine');
			$data['text_empty'] = $this->language->get('text_empty');
			$data['text_quantity'] = $this->language->get('text_quantity');
			$data['text_manufacturer'] = $this->language->get('text_manufacturer');
			$data['text_model'] = $this->language->get('text_model');
			$data['text_price'] = $this->language->get('text_price');
			$data['text_tax'] = $this->language->get('text_tax');
			$data['text_points'] = $this->language->get('text_points');
			$data['text_compare'] = sprintf($this->language->get('text_compare'), (isset($this->session->data['compare']) ? count($this->session->data['compare']) : 0));
			$data['text_sort'] = $this->language->get('text_sort');
			$data['text_limit'] = $this->language->get('text_limit');

			$data['button_cart'] = $this->language->get('button_cart');
			$data['button_wishlist'] = $this->language->get('button_wishlist');
			$data['button_compare'] = $this->language->get('button_compare');
			$data['button_continue'] = $this->language->get('button_continue');
			$data['button_list'] = $this->language->get('button_list');
			$data['button_grid'] = $this->language->get('button_grid');

        // phpner_store start
        $data['text_model'] = $this->language->get('text_model');
        $data['text_stock'] = $this->language->get('text_stock');
        $this->load->language('phpner/phpner_store');
        $data['phpner_home_text'] = $this->language->get('phpner_home_text');
        $data['text_model'] = $this->language->get('text_model');
        $data['text_stock'] = $this->language->get('text_stock');
        $data['text_instock'] = $this->language->get('text_instock');
        $data['phpner_choose_subcategory'] = $this->language->get('phpner_choose_subcategory');
        // phpner_store end
      

			// Set the last category breadcrumb
			$data['breadcrumbs'][] = array(
				'text' => $category_info['name'],
				'href' => $this->url->link('product/category', 'path=' . $this->request->get['path'])
			);

			if ($category_info['image']) {
				$data['thumb'] = $this->model_tool_image->resize($category_info['image'], $this->config->get($this->config->get('config_theme') . '_image_category_width'), $this->config->get($this->config->get('config_theme') . '_image_category_height'));
				$this->document->setOgImage($data['thumb']);
			} else {
				$data['thumb'] = '';
			}

			
       $data['description'] = str_replace("<img", "<img class=\"img-responsive\"",  html_entity_decode($category_info['description'], ENT_QUOTES, 'UTF-8'));
      
			$data['compare'] = $this->url->link('product/compare');

			$url = '';

			if (isset($this->request->get['filter'])) {
				$url .= '&filter=' . $this->request->get['filter'];
			}

			if (isset($this->request->get['sort'])) {
				$url .= '&sort=' . $this->request->get['sort'];
			}

			if (isset($this->request->get['order'])) {
				$url .= '&order=' . $this->request->get['order'];
			}

			if (isset($this->request->get['limit'])) {
				$url .= '&limit=' . $this->request->get['limit'];
			}


        $protocol = strtolower(substr($this->request->server["SERVER_PROTOCOL"], 0, 5)) == 'https' ? HTTPS_SERVER : HTTP_SERVER;

        $value_seo_url = preg_replace('/\?sort=.{1,}/', '', $this->request->server['REQUEST_URI']);
        $value_seo_url = preg_replace('/(\?|&)page=.{1,}/', '', $value_seo_url);

        $phpner_server = rtrim($protocol, "/").$value_seo_url;

	  if ($phpner_product_filter_status && isset($phpner_product_filter_data['enable_seo']) && $phpner_product_filter_data['enable_seo']) {
        $get_main_url = parse_url($this->request->server['REQUEST_URI']);

        if (isset($get_main_url['path'])) {
          $seo_main_url = ltrim($get_main_url['path'], "/");
        } else {
          $seo_main_url = false;
        }

        $seo_data_info = $this->model_extension_module_phpner_product_filter->getSeo($seo_main_url);

        if ($seo_data_info) {
          $this->document->setTitle($seo_data_info['seo_title']);
          $this->document->setDescription($seo_data_info['seo_meta_description']);
          $this->document->setKeywords($seo_data_info['seo_meta_keywords']);
          $data['heading_title'] = $seo_data_info['seo_h1'];
          $data['description'] = html_entity_decode($seo_data_info['seo_description'], ENT_QUOTES, 'UTF-8');
        }
      }
      
			$data['categories'] = array();

			$results = $this->model_catalog_category->getCategories($category_id);

			foreach ($results as $result) {
				$filter_data = array(
					'filter_category_id'  => $result['category_id'],
					'filter_sub_category' => true
				);


        // phpner_store start
        if (isset($result['image']) && $result['image'] !="") { 
          $cat_image = $this->model_tool_image->resize($result['image'], 100, 100); 
        } else {
          $cat_image = $this->model_tool_image->resize("no-image.png", 100, 100); 
        }
        // phpner_store end
      
				$data['categories'][] = array(

        // phpner_store start
        'thumb' => $cat_image,
        // phpner_store end
      
					'name' => $result['name'] . ($this->config->get('config_product_count') ? ' (' . $this->model_catalog_product->getTotalProducts($filter_data) . ')' : ''),
					'href' => $this->url->link('product/category', 'path=' . $this->request->get['path'] . '_' . $result['category_id'] . $url)
				);
			}

			$data['products'] = array();

			$filter_data = array(
				'filter_category_id' => $category_id,
				'filter_filter'      => $filter,
				'sort'               => $sort,
				'order'              => $order,
				'start'              => ($page - 1) * $limit,
				'limit'              => $limit
			);

			
      // SEO phpner_ product filter: start
      if ($phpner_product_filter_status && isset($phpner_product_filter_data['enable_seo']) && $phpner_product_filter_data['enable_seo'] && isset($this->request->get['route']) && preg_match('/filter/', $this->request->server['REQUEST_URI'])) {
        if ($this->request->get['route'] == 'product/category') {
          $phpner_filter_path = (isset($this->request->get['path'])) ? explode('_', (string)$this->request->get['path']) : array();
          $phpner_filter_global_id = end($phpner_filter_path);
          $phpner_filter_global_type = 'category';
        } elseif ($this->request->get['route'] == 'product/manufacturer/info') {
          $phpner_filter_global_id = (isset($this->request->get['manufacturer_id'])) ? (int)$this->request->get['manufacturer_id'] : 0;
          $phpner_filter_global_type = 'manufacturer';
        } elseif ($this->request->get['route'] == 'product/special') {
          $phpner_filter_global_type = 'special';
        } else {
          $phpner_filter_global_id = 0;
          $phpner_filter_global_type = 'category';
        }

        $customer_group_id = ($this->customer->isLogged()) ? (int)$this->customer->getGroupId() : (int)$this->config->get('config_customer_group_id');
        $store_id = (int)$this->config->get('config_store_id');
        $language_id = (int)$this->config->get('config_language_id');
        $phpner_filter_page = (isset($this->request->get['page'])) ? (int)$this->request->get['page'] : 1;
        $phpner_filter_limit = (isset($this->request->get['limit'])) ? (int)$this->request->get['limit'] : $this->config->get($this->config->get('config_theme') . '_product_limit');

        $get_main_url = parse_url($this->request->server['REQUEST_URI']);

        if (isset($get_main_url['path'])) {
          $seo_main_url = ltrim($get_main_url['path'], "/");
        } else {
          $seo_main_url = false;
        }

        $seo_data_info = $this->model_extension_module_phpner_product_filter->getSeo($seo_main_url);

        $seo_main_url_md5 = md5($seo_main_url);

        if ($seo_data_info) {
          $filter_data = $this->cache->get('phpner.seo_page.'.$phpner_filter_global_type.'.'.(int)$store_id.'.'.(int)$customer_group_id.'.'.(int)$language_id.'.'.(int)$phpner_filter_global_id.'.'.(int)$phpner_filter_page.'.'.$seo_main_url_md5);
        
          if (!$filter_data) {
            $phpner_filter_url = explode("/", $this->request->server['REQUEST_URI']);

            // SEO special only: start
            if (preg_match('/special-only/', $this->request->server['REQUEST_URI'])) {
              preg_match('/special-only/', $this->request->server['REQUEST_URI'], $matches);
              
              if ($matches[0]) {
                $phpner_filter_special_only = 1;
              }
            }
            // SEO special only: end

            // SEO price: start
            if (preg_match('/price-[0-9]{1,}-[0-9]{1,}/', $this->request->server['REQUEST_URI'])) {
              preg_match('/price-[0-9]{1,}-[0-9]{1,}/', $this->request->server['REQUEST_URI'], $matches);

              $phpner_filter_price = explode('-', $matches[0]);

              if (isset($phpner_filter_price[1]) && $phpner_filter_price[2]) {
                $phpner_filter_min_price = preg_replace("/[^.0-9]/", '', $phpner_filter_price[1]);
                $phpner_filter_max_price = preg_replace("/[^.0-9]/", '', $phpner_filter_price[2]);
              }
            }
            // SEO price: end

            // SEO tag: start
            if (preg_match('/tag-[a-z0-9(_|.)]{1,}/', $this->request->server['REQUEST_URI'])) {
              preg_match('/tag-[a-z0-9(_|.)]{1,}/', $this->request->server['REQUEST_URI'], $matches);

              $get_phpner_filter_tag = explode('-', $matches[0]);

              if (isset($get_phpner_filter_tag[1])) {
                $phpner_filter_tag = $get_phpner_filter_tag[1];
              }
            }
            // SEO tag: end

            // SEO brand: start
            if (in_array("filter", $phpner_filter_url)) {
              $phpner_filter_brand = array();

              foreach ($phpner_filter_url as $manufacturer_url_item) {
                $manufacturer_query_query = $this->db->query("SELECT query FROM " . DB_PREFIX . "url_alias WHERE keyword = '" . $this->db->escape($manufacturer_url_item) . "'");
                
                if ($manufacturer_query_query->num_rows) {
                  if (preg_match('/manufacturer_id=[0-9]{1,}/', $manufacturer_query_query->row['query'])) {
                    preg_match('/manufacturer_id=[0-9]{1,}/', $manufacturer_query_query->row['query'], $manufacturer_id);
                    preg_match('/[0-9]{1,}/', $manufacturer_id[0], $query_value);

                    if (isset($query_value[0])) {
                      $phpner_filter_brand[] = $query_value[0];
                    }
                  }
                }
              }
            }
            // SEO brand: end

            // SEO attribute: start
            if (in_array("filter", $phpner_filter_url)) {
              $phpner_filter_attribute = array();

              foreach ($phpner_filter_url as $attribute_url_item) {
                $query_attribute_name_mod = $this->db->query("SELECT filter_attribute_id FROM " . DB_PREFIX . "phpner_filter_product_attribute WHERE attribute_name_mod = '" . $this->db->escape($attribute_url_item) . "' AND language_id ='".(int)$this->config->get('config_language_id')."'");
                
                if ($query_attribute_name_mod->num_rows) {
                  foreach ($phpner_filter_url as $attribute_url_item_2) {
                    $query_attribute_value_mod = $this->db->query("SELECT filter_attribute_id FROM " . DB_PREFIX . "phpner_filter_product_attribute WHERE attribute_value_mod = '" . $this->db->escape($attribute_url_item_2) . "' AND attribute_name_mod = '".$this->db->escape($attribute_url_item)."' AND language_id ='".(int)$this->config->get('config_language_id')."'")->num_rows;

                    if ($query_attribute_value_mod) {
                      $phpner_filter_attribute[$attribute_url_item][] = $attribute_url_item_2;
                    }
                  }
                }
              }
            }
            // SEO attribute: end

            // SEO option: start
            if (in_array("filter", $phpner_filter_url)) {
              $phpner_filter_option = array();

              foreach ($phpner_filter_url as $option_url_item) {
                $query_option_name_mod = $this->db->query("SELECT filter_option_id FROM " . DB_PREFIX . "phpner_filter_product_option WHERE option_name_mod = '" . $this->db->escape($option_url_item) . "'AND language_id ='".(int)$this->config->get('config_language_id')."'");
                
                if ($query_option_name_mod->num_rows) {
                  foreach ($phpner_filter_url as $option_url_item_2) {
                    $query_option_value_id = $this->db->query("SELECT option_value_id FROM " . DB_PREFIX . "phpner_filter_product_option WHERE option_value_name_mod = '" . $this->db->escape($option_url_item_2) . "' AND option_name_mod = '" . $this->db->escape($option_url_item) . "' AND language_id ='".(int)$this->config->get('config_language_id')."' GROUP BY option_value_id");

                    if ($query_option_value_id->num_rows) {
                      $phpner_filter_option[$option_url_item][] = $query_option_value_id->row['option_value_id'];
                    }
                  }
                }
              }
            }
            // SEO option: end

            // SEO standard: start
            if (in_array("filter", $phpner_filter_url)) {
              $phpner_filter_standard = array();

              foreach ($phpner_filter_url as $standard_url_item) {
                $query_filter_name_mod = $this->db->query("SELECT filter_filter_id FROM " . DB_PREFIX . "phpner_filter_product_standard WHERE filter_name_mod = '" . $this->db->escape($standard_url_item) . "' AND language_id ='".(int)$this->config->get('config_language_id')."'");
                
                if ($query_filter_name_mod->num_rows) {
                  foreach ($phpner_filter_url as $standard_url_item_2) {
                    $query_standard_value_mod = $this->db->query("SELECT filter_filter_id FROM " . DB_PREFIX . "phpner_filter_product_standard WHERE filter_value_mod = '" . $this->db->escape($standard_url_item_2) . "' AND filter_name_mod = '" . $this->db->escape($standard_url_item) . "' AND language_id ='".(int)$this->config->get('config_language_id')."'")->num_rows;

                    if ($query_standard_value_mod) {
                      $phpner_filter_standard[$standard_url_item][] = $standard_url_item_2;
                    }
                  }
                }
              }
            }
            // SEO standard: end

            // SEO sticker: start
            if (in_array("filter", $phpner_filter_url)) {
              $phpner_filter_sticker = array();

              foreach ($phpner_filter_url as $sticker_url_item) {
                $sticker_query_query = $this->db->query("SELECT product_sticker_id FROM " . DB_PREFIX . "phpner_filter_product_sticker WHERE product_sticker_value_mod = '" . $this->db->escape($sticker_url_item) . "' AND language_id ='".(int)$this->config->get('config_language_id')."' GROUP BY product_sticker_id");
                
                if ($sticker_query_query->num_rows) {
                  $phpner_filter_sticker[] = $sticker_query_query->row['product_sticker_id'];
                }
              }
            }
            // SEO sticker: end

            // SEO stock: start
            if (in_array("filter", $phpner_filter_url)) {
              $phpner_filter_stock = array();
              foreach ($phpner_filter_url as $stock_url_item) {
                if (in_array($stock_url_item, array('in_stock', 'out_of_stock', 'ending_stock'))) {
                  $phpner_filter_stock[] = $stock_url_item;
                }
              }
            }
            // SEO stock: end

            // SEO rating: start
            if (in_array("filter", $phpner_filter_url)) {
              $phpner_filter_rating = array();

              foreach ($phpner_filter_url as $rating_url_item) {
                if (preg_match('/rating-[0-9]{1,}/', $rating_url_item)) {
                  preg_match('/rating-[0-9]{1,}/', $rating_url_item, $rating_value);
                  preg_match('/([0-9]{1,})/', $rating_url_item, $rating_id);

                  $phpner_filter_rating[] = $rating_id[1];
                }
              }
            }
            // SEO rating: end

            if (isset($phpner_product_filter_data['default_sort'])) {
              $phpner_product_filter_default_sort = explode('|', $phpner_product_filter_data['default_sort']);
            } else {
              $phpner_product_filter_default_sort = array(0 => 'p.sort_order', 1 => 'order=ASC');
            }

            $phpner_product_filter_default_order = str_replace('order=', '', $phpner_product_filter_default_sort[1]);

            $filter_data = array(
              'filter_data'       => array(
                'option_logic_with_other'                  => $phpner_product_filter_data['option_logic_with_other'],
                'option_logic_between_option'              => $phpner_product_filter_data['option_logic_between_option'],
                'attribute_logic_with_other'               => $phpner_product_filter_data['attribute_logic_with_other'],
                'attribute_logic_between_attribute'        => $phpner_product_filter_data['attribute_logic_between_attribute'],
                'standard_logic_with_other'                => $phpner_product_filter_data['standard_logic_with_other'],
                'standard_logic_between_standard'          => $phpner_product_filter_data['standard_logic_between_standard'],
                'manufacturer_logic_with_other'            => $phpner_product_filter_data['manufacturer_logic_with_other'],
                'stock_ending_value'                       => $phpner_product_filter_data['stock_ending_value'],
                'stock_logic_with_other'                   => $phpner_product_filter_data['stock_logic_with_other'],
                'stock_logic_between_stock'                => $phpner_product_filter_data['stock_logic_between_stock'],
                'review_logic_with_other'                  => $phpner_product_filter_data['review_logic_with_other'],
                'review_logic_between_review'              => $phpner_product_filter_data['review_logic_between_review'],
                'sticker_logic_with_other'                 => $phpner_product_filter_data['sticker_logic_with_other'],
                'sticker_logic_between_sticker'            => $phpner_product_filter_data['sticker_logic_between_sticker'],
                'tag_logic_with_other'                     => $phpner_product_filter_data['tag_logic_with_other'],
                'customer_group_id'                        => ($this->customer->isLogged()) ? (int)$this->customer->getGroupId() : (int)$this->config->get('config_customer_group_id'),
                'store_id'                                 => $this->config->get('config_store_id'),
                'language_id'                              => $this->config->get('config_language_id')
              ),
              'special_only'      => (isset($phpner_filter_special_only)) ? $phpner_filter_special_only : '',
              'global_type'       => $phpner_filter_global_type,
              'global_id'         => $phpner_filter_global_id,
              'sort'              => (isset($phpner_filter_sort)) ? $phpner_filter_sort : $phpner_product_filter_default_sort[0],
              'order'             => (isset($phpner_filter_order)) ? $phpner_filter_order : $phpner_product_filter_default_order,
              'start'             => ($phpner_filter_page - 1) * $phpner_filter_limit,
              'limit'             => $phpner_filter_limit,
              'page'              => $phpner_filter_page,
              'low_price'         => (isset($phpner_filter_min_price)) ? floor($phpner_filter_min_price / $this->currency->getValue($this->session->data['currency'])) : '',
              'high_price'        => (isset($phpner_filter_max_price)) ? ceil($phpner_filter_max_price / $this->currency->getValue($this->session->data['currency'])) : '',
              'tag'               => (isset($phpner_filter_tag)) ? $phpner_filter_tag : '',
              'manufacturer'      => (isset($phpner_filter_brand)) ? $phpner_filter_brand : array(),
              'stock'             => (isset($phpner_filter_stock)) ? $phpner_filter_stock : array(),
              'rating'            => (isset($phpner_filter_rating)) ? $phpner_filter_rating : array(),
              'sticker'           => (isset($phpner_filter_sticker)) ? $phpner_filter_sticker : array(),
              'option'            => (isset($phpner_filter_option)) ? $phpner_filter_option : array(),
              'attribute'         => (isset($phpner_filter_attribute)) ? $phpner_filter_attribute : array(),
              'standard'          => (isset($phpner_filter_standard)) ? $phpner_filter_standard : array(),
            );

            $this->cache->set('phpner.seo_page.'.$phpner_filter_global_type.'.'.(int)$store_id.'.'.(int)$customer_group_id.'.'.(int)$language_id.'.'.(int)$phpner_filter_global_id.'.'.(int)$phpner_filter_page.'.'.$seo_main_url_md5, $filter_data);
          }

          $results = $this->model_extension_module_phpner_product_filter->getProducts($filter_data, 'products');

          $product_total = $this->model_extension_module_phpner_product_filter->getProducts($filter_data, 'total');
        } else {
          $product_total = $this->model_catalog_product->getTotalProducts($filter_data);

          $results = $this->model_catalog_product->getProducts($filter_data);
        }
      } else {
        $product_total = $this->model_catalog_product->getTotalProducts($filter_data);

        $results = $this->model_catalog_product->getProducts($filter_data);
      }
      // SEO phpner_ product filter: end
      
			foreach ($results as $result) {
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

				if ((float)$result['special']) {
					$special = $this->currency->format($this->tax->calculate($result['special'], $result['tax_class_id'], $this->config->get('config_tax')), $this->session->data['currency']);
				} else {
					$special = false;
				}

				if ($this->config->get('config_tax')) {
					$tax = $this->currency->format((float)$result['special'] ? $result['special'] : $result['price'], $this->session->data['currency']);
				} else {
					$tax = false;
				}

				if ($this->config->get('config_review_status')) {
					$rating = (int)$result['rating'];
				} else {
					$rating = false;
				}


        // phpner_advanced_attributes_settings start
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
        // phpner_advanced_attributes_settings end
      

        // phpner_advanced_options_settings start
        $phpner_options = array();
        $phpner_advanced_options_settings_data = $this->config->get('phpner_advanced_options_settings_data');
        foreach ($this->model_catalog_product->getProductOptions($result['product_id']) as $option) {
          $product_option_value_data = array();
          if (isset($phpner_advanced_options_settings_data['allowed_options']) && (in_array($option['option_id'], $phpner_advanced_options_settings_data['allowed_options']))) {
            foreach ($option['product_option_value'] as $option_value) {
              if (!$option_value['subtract'] || ($option_value['quantity'] >= 0)) {
                if ((($this->config->get('config_customer_price') && $this->customer->isLogged()) || !$this->config->get('config_customer_price')) && (float)$option_value['price']) {
                  $phpner_option_price = $this->currency->format($this->tax->calculate($option_value['price'], $result['tax_class_id'], $this->config->get('config_tax') ? 'P' : false), $this->session->data['currency']);
                } else {
                  $phpner_option_price = false;
                }
                $product_option_value_data[] = array(
                  'product_option_value_id' => $option_value['product_option_value_id'],
                  'option_value_id'         => $option_value['option_value_id'],
                  'name'                    => $option_value['name'],
                  'image'                   => $option_value['image'] ? $this->model_tool_image->resize($option_value['image'], 50, 50) : '',
                  'price'                   => $phpner_option_price,
                  'price_prefix'            => $option_value['price_prefix']
               );
              }
            }
            $phpner_options[] = array(
              'product_option_id'    => $option['product_option_id'],
              'product_option_value' => $product_option_value_data,
              'option_id'            => $option['option_id'],
              'name'                 => $option['name'],
              'type'                 => $option['type'],
              'value'                => $option['value'],
              'required'             => $option['required']
            );
          }
        }
        // phpner_advanced_options_settings end
      

        $phpner_product_stickers_data = $this->config->get('phpner_product_stickers_data');
        $phpner_product_stickers = array();

        if (isset($phpner_product_stickers_data['status']) && $phpner_product_stickers_data['status']) {
          $this->load->model('catalog/phpner_product_stickers');

          if (isset($result['phpner_product_stickers']) && $result['phpner_product_stickers']) {
            $stickers = unserialize($result['phpner_product_stickers']);
          } else {
            $stickers = array();
          }

          if ($stickers) {
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
        }
      

        // phpner_store start
        if ($result['quantity'] <= 0) {
          $stock = $result['stock_status'];
        } elseif ($this->config->get('config_stock_display')) {
          $stock = $result['quantity'];
        } else {
          $stock = $this->language->get('text_instock');
        }
        // phpner_store end
      

				$phpner_product_preorder_text = $this->config->get('phpner_product_preorder_text');
				$phpner_product_preorder_data = $this->config->get('phpner_product_preorder_data');
				$phpner_product_preorder_language = $this->load->language('extension/module/phpner_product_preorder');
				$data['text_stock'] = $this->language->get('text_stock');
			
				if (isset($phpner_product_preorder_data['status']) && $phpner_product_preorder_data['status'] && isset($phpner_product_preorder_data['stock_statuses']) && isset($result['phpner_stock_status_id']) && in_array($result['phpner_stock_status_id'], $phpner_product_preorder_data['stock_statuses'])) {
					$product_preorder_text = $phpner_product_preorder_text[$this->session->data['language']]['call_button'];
					$product_preorder_status = 1;
				} else {
					$product_preorder_text = $phpner_product_preorder_language['text_out_of_stock'];
					$product_preorder_status = 2;
				}
			
				$data['products'][] = array(

        // phpner_store start
        'saving'      => round((($result['price'] - $result['special'])/($result['price'] + 0.01))*100, 0),
        'model'       => $result['model'],
        'stock'       => $stock,
        // phpner_store end
      

        'phpner_product_stickers' => $phpner_product_stickers,
      

        // phpner_advanced_options_settings start
        'phpner_options' => $phpner_options,
        // phpner_advanced_options_settings end
      

        // phpner_advanced_attributes_settings start
        'phpner_attributes' => $phpner_attributes,
        // phpner_advanced_attributes_settings end
      
					'product_id'  => $result['product_id'],
					'thumb'       => $image,
					'name'        => $result['name'],
					'description' => utf8_substr(strip_tags(html_entity_decode($result['description'], ENT_QUOTES, 'UTF-8')), 0, $this->config->get($this->config->get('config_theme') . '_product_description_length')) . '..',

				'quantity'       => $result['quantity'], 
				'product_preorder_text' => $product_preorder_text,
				'product_preorder_status' => $product_preorder_status,
			
					'price'       => $price,
					'special'     => $special,
					'tax'         => $tax,
					'minimum'     => ($result['minimum'] > 0) ? $result['minimum'] : 1,
					'rating'      => $rating,
					'href'        => $this->url->link('product/product', 'path=' . $this->request->get['path'] . '&product_id=' . $result['product_id'] . $url)
				);
			}

			$url = '';

			if (isset($this->request->get['filter'])) {
				$url .= '&filter=' . $this->request->get['filter'];
			}

			if (isset($this->request->get['limit'])) {
				$url .= '&limit=' . $this->request->get['limit'];
			}

			$data['sorts'] = array();

			$data['sorts'][] = array(
				'text'  => $this->language->get('text_default'),
				'value' => 'p.sort_order-ASC',
				'href'  => $this->url->link('product/category', 'path=' . $this->request->get['path'] . '&sort=p.sort_order&order=ASC' . $url)
			);

			$data['sorts'][] = array(
				'text'  => $this->language->get('text_name_asc'),
				'value' => 'pd.name-ASC',
				'href'  => $this->url->link('product/category', 'path=' . $this->request->get['path'] . '&sort=pd.name&order=ASC' . $url)
			);

			$data['sorts'][] = array(
				'text'  => $this->language->get('text_name_desc'),
				'value' => 'pd.name-DESC',
				'href'  => $this->url->link('product/category', 'path=' . $this->request->get['path'] . '&sort=pd.name&order=DESC' . $url)
			);

			$data['sorts'][] = array(
				'text'  => $this->language->get('text_price_asc'),
				'value' => 'p.price-ASC',
				'href'  => $this->url->link('product/category', 'path=' . $this->request->get['path'] . '&sort=p.price&order=ASC' . $url)
			);

			$data['sorts'][] = array(
				'text'  => $this->language->get('text_price_desc'),
				'value' => 'p.price-DESC',
				'href'  => $this->url->link('product/category', 'path=' . $this->request->get['path'] . '&sort=p.price&order=DESC' . $url)
			);

			if ($this->config->get('config_review_status')) {
				$data['sorts'][] = array(
					'text'  => $this->language->get('text_rating_desc'),
					'value' => 'rating-DESC',
					'href'  => $this->url->link('product/category', 'path=' . $this->request->get['path'] . '&sort=rating&order=DESC' . $url)
				);

				$data['sorts'][] = array(
					'text'  => $this->language->get('text_rating_asc'),
					'value' => 'rating-ASC',
					'href'  => $this->url->link('product/category', 'path=' . $this->request->get['path'] . '&sort=rating&order=ASC' . $url)
				);
			}

			$data['sorts'][] = array(
				'text'  => $this->language->get('text_model_asc'),
				'value' => 'p.model-ASC',
				'href'  => $this->url->link('product/category', 'path=' . $this->request->get['path'] . '&sort=p.model&order=ASC' . $url)
			);

			$data['sorts'][] = array(
				'text'  => $this->language->get('text_model_desc'),
				'value' => 'p.model-DESC',
				'href'  => $this->url->link('product/category', 'path=' . $this->request->get['path'] . '&sort=p.model&order=DESC' . $url)
			);

			$url = '';

			if (isset($this->request->get['filter'])) {
				$url .= '&filter=' . $this->request->get['filter'];
			}

			if (isset($this->request->get['sort'])) {
				$url .= '&sort=' . $this->request->get['sort'];
			}

			if (isset($this->request->get['order'])) {
				$url .= '&order=' . $this->request->get['order'];
			}

			$data['limits'] = array();

			$limits = array_unique(array($this->config->get($this->config->get('config_theme') . '_product_limit'), 25, 50, 75, 100));

			sort($limits);

			foreach($limits as $value) {
				$data['limits'][] = array(
					'text'  => $value,
					'value' => $value,
					'href'  => $this->url->link('product/category', 'path=' . $this->request->get['path'] . $url . '&limit=' . $value)
				);
			}

			$url = '';

			if (isset($this->request->get['filter'])) {
				$url .= '&filter=' . $this->request->get['filter'];
			}

			if (isset($this->request->get['sort'])) {
				$url .= '&sort=' . $this->request->get['sort'];
			}

			if (isset($this->request->get['order'])) {
				$url .= '&order=' . $this->request->get['order'];
			}

			if (isset($this->request->get['limit'])) {
				$url .= '&limit=' . $this->request->get['limit'];
			}

			$pagination = new Pagination();
			$pagination->total = $product_total;
			$pagination->page = $page;
			$pagination->limit = $limit;
			$pagination->url = ((isset($seo_data_info) && $seo_data_info) || $phpner_product_filter_status) ? (rtrim($phpner_server, "/"). '&page={page}') : ($this->url->link('product/category', 'path=' . $this->request->get['path'] . $url . '&page={page}'));

			$data['pagination'] = $pagination->render();

			$data['results'] = sprintf($this->language->get('text_pagination'), ($product_total) ? (($page - 1) * $limit) + 1 : 0, ((($page - 1) * $limit) > ($product_total - $limit)) ? $product_total : ((($page - 1) * $limit) + $limit), $product_total, ceil($product_total / $limit));

			// http://googlewebmastercentral.blogspot.com/2011/09/pagination-with-relnext-and-relprev.html
			if ($page == 1) {
			    (isset($seo_data_info) && $seo_data_info && isset($phpner_server)) ? ($this->document->addLink($phpner_server, 'canonical')) : ($this->document->addLink($this->url->link('product/category', 'path=' . $category_info['category_id'], true), 'canonical'));
			} elseif ($page == 2) {
			    (isset($seo_data_info) && $seo_data_info && isset($phpner_server)) ? '' : ($this->document->addLink($this->url->link('product/category', 'path=' . $category_info['category_id'], true), 'prev'));
			} else {
			    (isset($seo_data_info) && $seo_data_info && isset($phpner_server)) ? '' : ($this->document->addLink($this->url->link('product/category', 'path=' . $category_info['category_id'] . '&page='. ($page - 1), true), 'prev'));
			}

			if ($limit && ceil($product_total / $limit) > $page) {
			    (isset($seo_data_info) && $seo_data_info && isset($phpner_server)) ? '' : ($this->document->addLink($this->url->link('product/category', 'path=' . $category_info['category_id'] . '&page='. ($page + 1), true), 'next'));
			}

			$data['sort'] = $sort;
			$data['order'] = $order;
			$data['limit'] = $limit;

			$data['continue'] = $this->url->link('common/home');

			$data['column_left'] = $this->load->controller('common/column_left');
			$data['column_right'] = $this->load->controller('common/column_right');
			$data['content_top'] = $this->load->controller('common/content_top');
			$data['content_bottom'] = $this->load->controller('common/content_bottom');
			$data['footer'] = $this->load->controller('common/footer');
			$data['header'] = $this->load->controller('common/header');

			$this->response->setOutput($this->load->view('product/category', $data));
		} else {
			$url = '';

			if (isset($this->request->get['path'])) {
				$url .= '&path=' . $this->request->get['path'];
			}

			if (isset($this->request->get['filter'])) {
				$url .= '&filter=' . $this->request->get['filter'];
			}

			if (isset($this->request->get['sort'])) {
				$url .= '&sort=' . $this->request->get['sort'];
			}

			if (isset($this->request->get['order'])) {
				$url .= '&order=' . $this->request->get['order'];
			}

			if (isset($this->request->get['page'])) {
				$url .= '&page=' . $this->request->get['page'];
			}

			if (isset($this->request->get['limit'])) {
				$url .= '&limit=' . $this->request->get['limit'];
			}

			$data['breadcrumbs'][] = array(
				'text' => $this->language->get('text_error'),
				'href' => $this->url->link('product/category', $url)
			);

			$this->document->setTitle($this->language->get('text_error'));

			$data['heading_title'] = $this->language->get('text_error');

			$data['text_error'] = $this->language->get('text_error');

			$data['button_continue'] = $this->language->get('button_continue');

			$data['continue'] = $this->url->link('common/home');

			$this->response->addHeader($this->request->server['SERVER_PROTOCOL'] . ' 404 Not Found');

			$data['column_left'] = $this->load->controller('common/column_left');
			$data['column_right'] = $this->load->controller('common/column_right');
			$data['content_top'] = $this->load->controller('common/content_top');
			$data['content_bottom'] = $this->load->controller('common/content_bottom');
			$data['footer'] = $this->load->controller('common/footer');
			$data['header'] = $this->load->controller('common/header');

			$this->response->setOutput($this->load->view('error/not_found', $data));
		}
	}
}
