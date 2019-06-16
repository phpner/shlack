<?php
/**************************************************************/
/*	@copyright	Phpner 2019							  */
/*	@support	http://phpner.ru					  */
/*	@license	LICENSE.txt									  */
/**************************************************************/

class ControllerExtensionModulePhpnerProductTab extends Controller {
    public function index($setting) {
        static $module = 0;
        
        $data['phpner_popup_view_data'] = $this->config->get('phpner_popup_view_data');
        $data['button_popup_view']   = $this->language->get('button_popup_view');
        
        $this->load->language('extension/module/phpner_product_tab');
        
        $data['heading_title'] = $this->language->get('heading_title');
        
        $data['tab_latest']     = $this->language->get('tab_latest');
        $data['tab_featured']   = $this->language->get('tab_featured');
        $data['tab_bestseller'] = $this->language->get('tab_bestseller');
        $data['tab_special']    = $this->language->get('tab_special');
        $data['tab_top_viewed'] = $this->language->get('tab_top_viewed');
        
        $data['button_cart']     = $this->language->get('button_cart');
        $data['button_wishlist'] = $this->language->get('button_wishlist');
        $data['button_compare']  = $this->language->get('button_compare');
        
        $this->load->model('catalog/product');
        $this->load->model('extension/module/phpner_product_tab');
        $this->load->model('tool/image');
        
        //Latest Products
        $data['latest_products'] = array();
        
        $latest_results = $this->model_catalog_product->getLatestProducts($setting['limit']);
        if (!empty($latest_results)) {
            foreach ($latest_results as $result) {
                if ($result['image']) {
                    $image = $this->model_tool_image->resize($result['image'], $setting['width'], $setting['height']);
                } else {
                    $image = $this->model_tool_image->resize("placeholder.png", $setting['width'], $setting['height']);
                }
                
                if (($this->config->get('config_customer_price') && $this->customer->isLogged()) || !$this->config->get('config_customer_price')) {
                    $price = $this->currency->format($this->tax->calculate($result['price'], $result['tax_class_id'], $this->config->get('config_tax')), $this->session->data['currency']);
                } else {
                    $price = false;
                }
                
                if ((float) $result['special']) {
                    $special = $this->currency->format($this->tax->calculate($result['special'], $result['tax_class_id'], $this->config->get('config_tax')), $this->session->data['currency']);
                } else {
                    $special = false;
                }
                
                if ($this->config->get('config_review_status')) {
                    $rating = $result['rating'];
                } else {
                    $rating = false;
                }
                
                $product_stickers_data = $this->config->get('phpner_product_stickers_data');
                $product_stickers      = array();
                
                if (isset($product_stickers_data['status']) && $product_stickers_data['status']) {
                    $this->load->model('catalog/phpner_product_stickers');
                    
                    if (isset($result['phpner_product_stickers']) && $result['phpner_product_stickers']) {
                        $stickers = unserialize($result['phpner_product_stickers']);
                    } else {
                        $stickers = array();
                    }
                    
                    foreach ($stickers as $product_sticker_id) {
                        $sticker_info = $this->model_catalog_phpner_product_stickers->getProductSticker($product_sticker_id);
                        
                        if ($sticker_info) {
                            $product_stickers[] = array(
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
                    
                    array_multisort($sticker_sort_order, SORT_ASC, $product_stickers);
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
                
                $data['latest_products'][] = array(
                    'phpner_product_stickers' => $product_stickers,
                    'product_id' => $result['product_id'],
                    'thumb' => $image,
                    'name' => $result['name'],
                    'quantity' => $result['quantity'],
                    'product_preorder_text' => $product_preorder_text,
                    'product_preorder_status' => $product_preorder_status,
                    'price' => $price,
                    'special' => $special,
                    'saving' => round((($result['price'] - $result['special']) / ($result['price'] + 0.01)) * 100, 0),
                    'rating' => $rating,
                    'reviews' => sprintf($this->language->get('text_reviews'), (int) $result['reviews']),
                    'href' => $this->url->link('product/product', 'product_id=' . $result['product_id'])
                );
            }
        }
        //Specials product
        $data['special_products'] = array();
        
        $special_data = array(
            'sort' => 'pd.name',
            'order' => 'ASC',
            'start' => 0,
            'limit' => $setting['limit']
        );
        
        $special_results = $this->model_catalog_product->getProductSpecials($special_data);
        if (!empty($special_results)) {
            foreach ($special_results as $result) {
                if ($result['image']) {
                    $image = $this->model_tool_image->resize($result['image'], $setting['width'], $setting['height']);
                } else {
                    $image = $this->model_tool_image->resize("placeholder.png", $setting['width'], $setting['height']);
                }
                
                if (($this->config->get('config_customer_price') && $this->customer->isLogged()) || !$this->config->get('config_customer_price')) {
                    $price = $this->currency->format($this->tax->calculate($result['price'], $result['tax_class_id'], $this->config->get('config_tax')), $this->session->data['currency']);
                } else {
                    $price = false;
                }
                
                if ((float) $result['special']) {
                    $special = $this->currency->format($this->tax->calculate($result['special'], $result['tax_class_id'], $this->config->get('config_tax')), $this->session->data['currency']);
                } else {
                    $special = false;
                }
                
                if ($this->config->get('config_review_status')) {
                    $rating = $result['rating'];
                } else {
                    $rating = false;
                }
                
                $product_stickers_data = $this->config->get('phpner_product_stickers_data');
                $product_stickers      = array();
                
                if (isset($product_stickers_data['status']) && $product_stickers_data['status']) {
                    $this->load->model('catalog/phpner_product_stickers');
                    
                    if (isset($result['phpner_product_stickers']) && $result['phpner_product_stickers']) {
                        $stickers = unserialize($result['phpner_product_stickers']);
                    } else {
                        $stickers = array();
                    }
                    
                    foreach ($stickers as $product_sticker_id) {
                        $sticker_info = $this->model_catalog_phpner_product_stickers->getProductSticker($product_sticker_id);
                        
                        if ($sticker_info) {
                            $product_stickers[] = array(
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
                    
                    array_multisort($sticker_sort_order, SORT_ASC, $product_stickers);
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
                
                $data['special_products'][] = array(
                    'phpner_product_stickers' => $product_stickers,
                    'product_id' => $result['product_id'],
                    'thumb' => $image,
                    'name' => $result['name'],
                    'quantity' => $result['quantity'],
                    'product_preorder_text' => $product_preorder_text,
                    'product_preorder_status' => $product_preorder_status,
                    'price' => $price,
                    'special' => $special,
                    'saving' => round((($result['price'] - $result['special']) / ($result['price'] + 0.01)) * 100, 0),
                    'rating' => $rating,
                    'reviews' => sprintf($this->language->get('text_reviews'), (int) $result['reviews']),
                    'href' => $this->url->link('product/product', 'product_id=' . $result['product_id'])
                );
            }
        }
        //BestSeller
        $data['bestseller_products'] = array();
        
        $bestseller_results = $this->model_catalog_product->getBestSellerProducts($setting['limit']);
        
        if (!empty($bestseller_results)) {
            foreach ($bestseller_results as $result) {
                if ($result['image']) {
                    $image = $this->model_tool_image->resize($result['image'], $setting['width'], $setting['height']);
                } else {
                    $image = $this->model_tool_image->resize("placeholder.png", $setting['width'], $setting['height']);
                }
                
                if (($this->config->get('config_customer_price') && $this->customer->isLogged()) || !$this->config->get('config_customer_price')) {
                    $price = $this->currency->format($this->tax->calculate($result['price'], $result['tax_class_id'], $this->config->get('config_tax')), $this->session->data['currency']);
                } else {
                    $price = false;
                }
                
                if ((float) $result['special']) {
                    $special = $this->currency->format($this->tax->calculate($result['special'], $result['tax_class_id'], $this->config->get('config_tax')), $this->session->data['currency']);
                } else {
                    $special = false;
                }
                
                if ($this->config->get('config_review_status')) {
                    $rating = $result['rating'];
                } else {
                    $rating = false;
                }
                
                $product_stickers_data = $this->config->get('phpner_product_stickers_data');
                $product_stickers      = array();
                
                if (isset($product_stickers_data['status']) && $product_stickers_data['status']) {
                    $this->load->model('catalog/phpner_product_stickers');
                    
                    if (isset($result['phpner_product_stickers']) && $result['phpner_product_stickers']) {
                        $stickers = unserialize($result['phpner_product_stickers']);
                    } else {
                        $stickers = array();
                    }
                    
                    foreach ($stickers as $product_sticker_id) {
                        $sticker_info = $this->model_catalog_phpner_product_stickers->getProductSticker($product_sticker_id);
                        
                        if ($sticker_info) {
                            $product_stickers[] = array(
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
                    
                    array_multisort($sticker_sort_order, SORT_ASC, $product_stickers);
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
                
                $data['bestseller_products'][] = array(
                    'phpner_product_stickers' => $product_stickers,
                    'product_id' => $result['product_id'],
                    'thumb' => $image,
                    'name' => $result['name'],
                    'quantity' => $result['quantity'],
                    'product_preorder_text' => $product_preorder_text,
                    'product_preorder_status' => $product_preorder_status,
                    'price' => $price,
                    'special' => $special,
                    'saving' => round((($result['price'] - $result['special']) / ($result['price'] + 0.01)) * 100, 0),
                    'rating' => $rating,
                    'reviews' => sprintf($this->language->get('text_reviews'), (int) $result['reviews']),
                    'href' => $this->url->link('product/product', 'product_id=' . $result['product_id'])
                );
            }
        }
        //Featured
        $data['featured_products'] = array();
        
        $products = explode(',', $this->config->get('featured_product'));
        
        if (empty($setting['limit'])) {
            $setting['limit'] = 5;
        }
        
        if (!empty($setting['product'])) {
            $products = array_slice($setting['product'], 0, (int) $setting['limit']);
            
            foreach ($products as $product_id) {
                $product_info = $this->model_catalog_product->getProduct($product_id);
                
                if ($product_info) {
                    if ($product_info['image']) {
                        $image = $this->model_tool_image->resize($product_info['image'], $setting['width'], $setting['height']);
                    } else {
                        $image = $this->model_tool_image->resize("placeholder.png", $setting['width'], $setting['height']);
                    }
                    
                    if (($this->config->get('config_customer_price') && $this->customer->isLogged()) || !$this->config->get('config_customer_price')) {
                        $price = $this->currency->format($this->tax->calculate($product_info['price'], $product_info['tax_class_id'], $this->config->get('config_tax')), $this->session->data['currency']);
                    } else {
                        $price = false;
                    }
                    
                    if ((float) $product_info['special']) {
                        $special = $this->currency->format($this->tax->calculate($product_info['special'], $product_info['tax_class_id'], $this->config->get('config_tax')), $this->session->data['currency']);
                    } else {
                        $special = false;
                    }
                    
                    if ($this->config->get('config_review_status')) {
                        $rating = $product_info['rating'];
                    } else {
                        $rating = false;
                    }
                    
                    $product_stickers_data = $this->config->get('phpner_product_stickers_data');
                    $product_stickers      = array();
                    
                    if (isset($product_stickers_data['status']) && $product_stickers_data['status']) {
                        $this->load->model('catalog/phpner_product_stickers');
                        
                        if ($product_info['phpner_product_stickers']) {
                            $stickers = unserialize($product_info['phpner_product_stickers']);
                        } else {
                            $stickers = array();
                        }
                        
                        foreach ($stickers as $product_sticker_id) {
                            $sticker_info = $this->model_catalog_phpner_product_stickers->getProductSticker($product_sticker_id);
                            
                            if ($sticker_info) {
                                $product_stickers[] = array(
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
                        
                        array_multisort($sticker_sort_order, SORT_ASC, $product_stickers);
                    }
                    
                    $phpner_product_preorder_text     = $this->config->get('phpner_product_preorder_text');
                    $phpner_product_preorder_data     = $this->config->get('phpner_product_preorder_data');
                    $phpner_product_preorder_language = $this->load->language('extension/module/phpner_product_preorder');
                    
                    if (isset($phpner_product_preorder_data['status']) && $phpner_product_preorder_data['status'] && isset($phpner_product_preorder_data['stock_statuses']) && isset($product_info['phpner_stock_status_id']) && in_array($product_info['phpner_stock_status_id'], $phpner_product_preorder_data['stock_statuses'])) {
                        $product_preorder_text   = $phpner_product_preorder_text[$this->session->data['language']]['call_button'];
                        $product_preorder_status = 1;
                    } else {
                        $product_preorder_text   = $phpner_product_preorder_language['text_out_of_stock'];
                        $product_preorder_status = 2;
                    }
                    
                    $data['featured_products'][] = array(
                        'phpner_product_stickers' => $product_stickers,
                        'product_id' => $product_info['product_id'],
                        'thumb' => $image,
                        'name' => $product_info['name'],
                        'quantity' => $product_info['quantity'],
                        'product_preorder_text' => $product_preorder_text,
                        'product_preorder_status' => $product_preorder_status,
                        'price' => $price,
                        'special' => $special,
                        'saving' => round((($product_info['price'] - $product_info['special']) / ($product_info['price'] + 0.01)) * 100, 0),
                        'rating' => $rating,
                        'reviews' => sprintf($this->language->get('text_reviews'), (int) $product_info['reviews']),
                        'href' => $this->url->link('product/product', 'product_id=' . $product_info['product_id'])
                    );
                }
            }
        }
        
        //Top Viewed
        $data['top_viewed_products'] = array();
        
        $top_viewed_results = $this->model_extension_module_phpner_product_tab->getTopViewedProducts($setting['limit']);
        if (!empty($top_viewed_results)) {
            foreach ($top_viewed_results as $result) {
                if ($result['image']) {
                    $image = $this->model_tool_image->resize($result['image'], $setting['width'], $setting['height']);
                } else {
                    $image = $this->model_tool_image->resize("placeholder.png", $setting['width'], $setting['height']);
                }
                
                if (($this->config->get('config_customer_price') && $this->customer->isLogged()) || !$this->config->get('config_customer_price')) {
                    $price = $this->currency->format($this->tax->calculate($result['price'], $result['tax_class_id'], $this->config->get('config_tax')), $this->session->data['currency']);
                } else {
                    $price = false;
                }
                
                if ((float) $result['special']) {
                    $special = $this->currency->format($this->tax->calculate($result['special'], $result['tax_class_id'], $this->config->get('config_tax')), $this->session->data['currency']);
                } else {
                    $special = false;
                }
                
                if ($this->config->get('config_review_status')) {
                    $rating = $result['rating'];
                } else {
                    $rating = false;
                }
                
                $product_stickers_data = $this->config->get('phpner_product_stickers_data');
                $product_stickers      = array();
                
                if (isset($product_stickers_data['status']) && $product_stickers_data['status']) {
                    $this->load->model('catalog/phpner_product_stickers');
                    
                    if (isset($result['phpner_product_stickers']) && $result['phpner_product_stickers']) {
                        $stickers = unserialize($result['phpner_product_stickers']);
                    } else {
                        $stickers = array();
                    }
                    
                    foreach ($stickers as $product_sticker_id) {
                        $sticker_info = $this->model_catalog_phpner_product_stickers->getProductSticker($product_sticker_id);
                        
                        if ($sticker_info) {
                            $product_stickers[] = array(
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
                    
                    array_multisort($sticker_sort_order, SORT_ASC, $product_stickers);
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
                
                $data['top_viewed_products'][] = array(
                    'phpner_product_stickers' => $product_stickers,
                    'product_id' => $result['product_id'],
                    'thumb' => $image,
                    'name' => $result['name'],
                    'quantity' => $result['quantity'],
                    'product_preorder_text' => $product_preorder_text,
                    'product_preorder_status' => $product_preorder_status,
                    'price' => $price,
                    'special' => $special,
                    'saving' => round((($result['price'] - $result['special']) / ($result['price'] + 0.01)) * 100, 0),
                    'rating' => $rating,
                    'reviews' => sprintf($this->language->get('text_reviews'), (int) $result['reviews']),
                    'href' => $this->url->link('product/product', 'product_id=' . $result['product_id'])
                );
            }
        }
        
        $data['module'] = $module++;
        
        return $this->load->view('extension/module/phpner_product_tab', $data);
    }
}