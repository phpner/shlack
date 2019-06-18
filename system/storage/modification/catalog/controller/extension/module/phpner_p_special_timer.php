<?php
/**************************************************************/
/*	@copyright	Phpner 2019							  */
/*	@support	http://phpner.ru					  */
/*	@license	LICENSE.txt									  */
/**************************************************************/

class ControllerExtensionModulePhpnerPSpecialTimer extends Controller {
    public function index($setting) {
        static $module = 0;
        
        $data['phpner_popup_view_data'] = $this->config->get('phpner_popup_view_data');
        $data['button_popup_view']   = $this->language->get('button_popup_view');
        
        $this->load->language('extension/module/phpner_p_special_timer');
        
        $data['heading_title'] = $this->language->get('heading_title');
        
        $data['text_tax'] = $this->language->get('text_tax');
        
        $data['button_cart_time'] = $this->language->get('button_cart_time');
        $data['button_wishlist']  = $this->language->get('button_wishlist');
        $data['button_compare']   = $this->language->get('button_compare');

        $data['language_code'] = $this->session->data['language'];

        $this->load->model('phpner/p_special_timer');
$data['position'] = $setting['position'];
        
        $this->load->model('tool/image');
        
        if (isset($this->request->get['path'])) {
            $parts = explode('_', (string) $this->request->get['path']);
        } else {
            $parts = array();
        }
        
        $category_id = (int) array_pop($parts);
        
        $filter_data = array(
            'filter_category_id' => (isset($setting['module_categories']) && $setting['module_categories']) ? $setting['module_categories'] : '',
            'filter_sub_category' => (isset($setting['module_categories']) && $setting['module_categories']) ? true : '',
            'sort' => 'ps.date_end',
            'order' => 'ASC',
            'start' => 0,
            'limit' => $setting['limit']
        );
        
        $products_2 = $this->model_phpner_p_special_timer->getProducts($filter_data);
        
        $products = array();
        
        if (isset($setting['module_show_in_categories']) && $setting['module_show_in_categories']) {
            if (in_array($category_id, $setting['module_show_in_categories'])) {
                $products = array_unique($products_2);
            }
        } else {
            $products = array_unique($products_2);
        }
        
        $data['products'] = array();
        
        if ($products) {
            foreach ($products as $product_id) {
                $product_info = $this->model_phpner_p_special_timer->getProduct($product_id);
                
                if ($product_info) {
                    if ($product_info['image']) {
                        $image = $this->model_tool_image->resize($product_info['image'], $setting['width'], $setting['height']);
                    } else {
                        $image = $this->model_tool_image->resize('placeholder.png', $setting['width'], $setting['height']);
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
                    
                    if ($this->config->get('config_tax')) {
                        $tax = $this->currency->format((float) $product_info['special'] ? $product_info['special'] : $product_info['price'], $this->session->data['currency']);
                    } else {
                        $tax = false;
                    }
                    
                    if ($this->config->get('config_review_status')) {
                        $rating = $product_info['rating'];
                    } else {
                        $rating = false;
                    }
                    
                    $phpner_product_stickers_data = $this->config->get('phpner_product_stickers_data');
                    $phpner_product_stickers      = array();
                    
                    if (isset($phpner_product_stickers_data['status']) && $phpner_product_stickers_data['status']) {
                        $this->load->model('catalog/phpner_product_stickers');
                        
                        if (isset($product_info['phpner_product_stickers']) && $product_info['phpner_product_stickers']) {
                            $stickers = unserialize($product_info['phpner_product_stickers']);
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
                    
                    if ($special && ($product_info['date_start'] != '0000-00-00' && $product_info['date_end'] != '0000-00-00')) {
                        $data['products'][] = array(
                            'phpner_product_stickers' => $phpner_product_stickers,
                            'product_id' => $product_info['product_id'],
                            'thumb' => $image,
                            'name' => $product_info['name'],
                            'date_start' => $product_info['date_start'],
                            'date_end' => $product_info['date_end'],
                            'description' => utf8_substr(strip_tags(html_entity_decode($product_info['description'], ENT_QUOTES, 'UTF-8')), 0, $this->config->get($this->config->get('config_theme') . '_product_description_length')) . '..',
                            'quantity' => $product_info['quantity'],
                            'product_preorder_text' => $product_preorder_text,
                            'product_preorder_status' => $product_preorder_status,
                            'price' => $price,
                            'special' => $special,
                            'saving' => round((($product_info['price'] - $product_info['special']) / ($product_info['price'] + 0.01)) * 100, 0),
                            'tax' => $tax,
                            'rating' => $rating,
                            'href' => $this->url->link('product/product', 'product_id=' . $product_info['product_id'])
                        );
                    }
                }
            }
        }
        
        $data['module'] = $module++;
        
        if ($data['products'] && count($data['products']) > 4) {
            return $this->load->view('extension/module/phpner_p_special_timer', $data);
        }
    }
}