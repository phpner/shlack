<?php
/**************************************************************/
/*	@copyright	Phpner 2019							  */
/*	@support	http://phpner.ru					  */
/*	@license	LICENSE.txt									  */
/**************************************************************/

class ControllerExtensionModulePhpnerProductsFromCategory extends Controller {
    public function index($setting) {
        static $module = 0;
        
        $data['phpner_popup_view_data'] = $this->config->get('phpner_popup_view_data');
        $data['button_popup_view']   = $this->language->get('button_popup_view');
        
        $this->load->language('extension/module/phpner_products_from_category');
        
        $data['heading_title'] = $setting['heading'][$this->session->data['language']];
        $data['link']          = $setting['link'][$this->session->data['language']];
        
        $data['button_cart']     = $this->language->get('button_cart');
        $data['button_wishlist'] = $this->language->get('button_wishlist');
        $data['button_compare']  = $this->language->get('button_compare');
        
        $data['position'] = $setting['position'];
        
        $this->load->model('catalog/product');
        $this->load->model('extension/module/phpner_products_from_category');
        $this->load->model('tool/image');
        
        if (isset($this->request->get['path'])) {
            $parts = explode('_', (string) $this->request->get['path']);
        } else {
            $parts = array();
        }
        
        $category_id = (int) array_pop($parts);
        
        $products_1 = array();
        
        if (isset($setting['product']) && $setting['product']) {
            $products_1 = $setting['product'];
        }
        
        $products_2 = array();
        
        if (isset($setting['module_categories']) && $setting['module_categories']) {
            $filter_data_2 = array(
                'filter_category_id' => $setting['module_categories'],
                'filter_sub_category' => true
            );
            
            $products_2 = $this->model_extension_module_phpner_products_from_category->getProducts($filter_data_2);
        }
        
        $products = array();
        
        if (isset($setting['module_show_in_categories']) && $setting['module_show_in_categories']) {
            if (in_array($category_id, $setting['module_show_in_categories'])) {
                $products = array_unique(array_merge($products_1, $products_2));
            }
        } else {
            $products = array_unique(array_merge($products_1, $products_2));
        }
        
        $data['products'] = array();
        
        if (!empty($products)) {
            
            if (empty($setting['limit'])) {
                $setting['limit'] = 5;
            }
            
            $products = array_slice($products, 0, (int) $setting['limit']);
            
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
                        
                        if (isset($product_info['phpner_product_stickers']) && $product_info['phpner_product_stickers']) {
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
                    
                    $data['products'][] = array(
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
        
        $data['module'] = $module++;
        
        if ($data['products']) {
            return $this->load->view('extension/module/phpner_products_from_category', $data);
        }
    }
}