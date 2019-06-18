<?php
/**************************************************************/
/*	@copyright	Phpner 2019							  */
/*	@support	http://phpner.ru					  */
/*	@license	LICENSE.txt									  */
/**************************************************************/

class ControllerExtensionModulePhpnerPopupView extends Controller {
    public function index() {
        $data = array();
        
        $this->load->model('catalog/product');
        $this->load->language('extension/module/phpner_popup_view');
        
        $phpner_data = $this->config->get('phpner_store_data');
        
        $data['phpner_popup_view_data'] = $phpner_popup_view_data = (array) $this->config->get('phpner_popup_view_data');
        
        // phpner_popup_purchase start
        $data['phpner_popup_purchase_data'] = $this->config->get('phpner_popup_purchase_data');
        // phpner_popup_purchase end
        
        // phpner_popup_found_cheaper start
        $data['phpner_popup_found_cheaper_data'] = $this->config->get('phpner_popup_found_cheaper_data');
        // phpner_popup_found_cheaper end
        
        // phpner_advanced_options_settings start
        $data['phpner_advanced_options_settings_data'] = $this->config->get('phpner_advanced_options_settings_data');
        // phpner_advanced_options_settings end
        
        // phpner_product_reviews start
        $data['phpner_product_reviews_data'] = $this->config->get('phpner_product_reviews_data');
        
        $this->load->language('extension/module/phpner_product_reviews');
        $data['entry_positive_text']   = $this->language->get('entry_positive_text');
        $data['entry_negative_text']   = $this->language->get('entry_negative_text');
        $data['text_where_bought']     = $this->language->get('text_where_bought');
        $data['text_where_bought_yes'] = $this->language->get('text_where_bought_yes');
        $data['text_where_bought_no']  = $this->language->get('text_where_bought_no');
        // phpner_product_reviews end
        
        if (isset($this->request->get['product_id'])) {
            $product_id = (int) $this->request->get['product_id'];
        } else {
            $product_id = 0;
        }
        
        $product_info = $this->model_catalog_product->getProduct($product_id);
        
        $data['product_id'] = $product_id;
        
        if ($product_info) {
            
            $data['heading_title'] = $this->language->get('heading_title');
            
            $data['button_view']              = $this->language->get('button_view');
            $data['text_select']              = $this->language->get('text_select');
            $data['text_manufacturer']        = $this->language->get('text_manufacturer');
            $data['text_model']               = $this->language->get('text_model');
            $data['text_sku']                 = $this->language->get('text_sku');
            $data['text_reward']              = $this->language->get('text_reward');
            $data['text_points']              = $this->language->get('text_points');
            $data['text_stock']               = $this->language->get('text_stock');
            $data['text_discount']            = $this->language->get('text_discount');
            $data['text_tax']                 = $this->language->get('text_tax');
            $data['text_option']              = $this->language->get('text_option');
            $data['text_minimum']             = sprintf($this->language->get('text_minimum'), $product_info['minimum']);
            $data['text_write']               = $this->language->get('text_write');
            $data['text_login']               = sprintf($this->language->get('text_login'), $this->url->link('account/login', '', 'SSL'), $this->url->link('account/register', '', 'SSL'));
            $data['text_note']                = $this->language->get('text_note');
            $data['text_tags']                = $this->language->get('text_tags');
            $data['text_related']             = $this->language->get('text_related');
            $data['text_loading']             = $this->language->get('text_loading');
            $data['text_rating']              = $this->language->get('text_rating');
            $data['text_option_disable']      = $this->language->get('text_option_disable');
            $data['text_col_option_name']     = $this->language->get('text_col_option_name');
            $data['text_col_option_image']    = $this->language->get('text_col_option_image');
            $data['text_col_option_sku']      = $this->language->get('text_col_option_sku');
            $data['text_col_option_model']    = $this->language->get('text_col_option_model');
            $data['text_col_option_price']    = $this->language->get('text_col_option_price');
            $data['text_col_option_quantity'] = $this->language->get('text_col_option_quantity');
            
            $data['entry_qty']    = $this->language->get('entry_qty');
            $data['entry_name']   = $this->language->get('entry_name');
            $data['entry_review'] = $this->language->get('entry_review');
            $data['entry_rating'] = $this->language->get('entry_rating');
            $data['entry_good']   = $this->language->get('entry_good');
            $data['entry_bad']    = $this->language->get('entry_bad');
            
            $data['button_cart']                  = $this->language->get('button_cart');
            $data['button_close']                 = $this->language->get('button_close');
            $data['button_view']                  = $this->language->get('button_view');
            $data['button_phpner_popup_view']        = $this->language->get('button_phpner_popup_view');
            $data['button_wishlist']              = $this->language->get('button_wishlist');
            $data['button_compare']               = $this->language->get('button_compare');
            $data['button_upload']                = $this->language->get('button_upload');
            $data['button_continue']              = $this->language->get('button_continue');
            $data['button_cart']                  = $this->language->get('button_cart');
            $data['button_compare']               = $this->language->get('button_compare');
            $data['button_wishlist']              = $this->language->get('button_wishlist');
            $data['text_phpner_popup_purchase']      = $this->language->get('text_phpner_popup_purchase');
            $data['text_phpner_popup_found_cheaper'] = $this->language->get('text_phpner_popup_found_cheaper');
            
            $this->load->model('catalog/review');
            
            $data['tab_description'] = $this->language->get('tab_description');
            $data['tab_attribute']   = $this->language->get('tab_attribute');
            $data['tab_review']      = sprintf($this->language->get('tab_review'), $product_info['reviews']);
            
            $data['manufacturer']  = $product_info['manufacturer'];
            $data['manufacturers'] = $this->url->link('product/manufacturer/info', 'manufacturer_id=' . $product_info['manufacturer_id']);
            $data['model']         = $product_info['model'];
            $data['reward']        = $product_info['reward'];
            $data['points']        = $product_info['points'];
            $data['sku']           = $product_info['sku'];
            
            $data['view_product_link'] = $this->url->link('product/product', 'product_id=' . $product_info['product_id']);
            
            if ($product_info['quantity'] <= 0) {
                $data['stock_warning'] = $product_info['stock_status'];
            } else {
                $data['stock_warning'] = '';
            }
            
            $phpner_product_stickers_data    = $this->config->get('phpner_product_stickers_data');
            $data['phpner_product_stickers'] = array();
            
            if (isset($phpner_product_stickers_data['status']) && $phpner_product_stickers_data['status']) {
                $this->load->model('catalog/phpner_product_stickers');
                
                if ($product_info['phpner_product_stickers']) {
                    $stickers = unserialize($product_info['phpner_product_stickers']);
                } else {
                    $stickers = array();
                }
                
                foreach ($stickers as $product_sticker_id) {
                    $sticker_info = $this->model_catalog_phpner_product_stickers->getProductSticker($product_sticker_id);
                    
                    if ($sticker_info) {
                        $data['phpner_product_stickers'][] = array(
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
                
                array_multisort($sticker_sort_order, SORT_ASC, $data['phpner_product_stickers']);
            }
            
            $phpner_product_tabs_data          = $this->config->get('phpner_product_tabs_data');
            $data['phpner_product_extra_tabs'] = array();
            
            if (isset($phpner_product_tabs_data['status']) && $phpner_product_tabs_data['status']) {
                $this->load->model('catalog/phpner_product_tabs');
                
                $phpner_product_extra_tabs = $this->model_catalog_phpner_product_tabs->getProductTabs($product_info['product_id']);
                
                if ($phpner_product_extra_tabs) {
                    foreach ($phpner_product_extra_tabs as $extra_tab) {
                        $data['phpner_product_extra_tabs'][] = array(
                            'title' => $extra_tab['title'],
                            'text' => html_entity_decode($extra_tab['text'], ENT_QUOTES, 'UTF-8')
                        );
                    }
                }
            }
            
            if ($product_info['quantity'] <= 0) {
                $data['stock'] = $product_info['stock_status'];
            } elseif ($this->config->get('config_stock_display')) {
                $data['stock'] = $product_info['quantity'];
            } else {
                $data['stock'] = $this->language->get('text_instock');
            }
            
            $data['product_name'] = $product_info['name'];
            
            $this->load->model('tool/image');
            
            $image_width  = ($phpner_popup_view_data['image_width']) ? $phpner_popup_view_data['image_width'] : '300';
            $image_height = ($phpner_popup_view_data['image_height']) ? $phpner_popup_view_data['image_height'] : '300';
            
            if ($product_info['image']) {
                $data['thumb'] = $this->model_tool_image->resize($product_info['image'], $image_width, $image_height);
            } else {
                $data['thumb'] = $this->model_tool_image->resize("placeholder.png", $image_width, $image_height);
            }
            
            $data['images'] = array();
            
            $results = $this->model_catalog_product->getProductImages($product_id);
            
            $image_additional_width  = ($phpner_popup_view_data['image_additional_width']) ? $phpner_popup_view_data['image_additional_width'] : '59';
            $image_additional_height = ($phpner_popup_view_data['image_additional_height']) ? $phpner_popup_view_data['image_additional_height'] : '59';
            
            foreach ($results as $result) {
                $data['images'][] = array(
                    'popup' => $this->model_tool_image->resize($result['image'], $image_width, $image_height),
                    'thumb' => $this->model_tool_image->resize($result['image'], $image_additional_width, $image_additional_height)
                );
            }
            
            if (($this->config->get('config_customer_price') && $this->customer->isLogged()) || !$this->config->get('config_customer_price')) {
                $data['price'] = $this->currency->format($this->tax->calculate($product_info['price'], $product_info['tax_class_id'], $this->config->get('config_tax')), $this->session->data['currency']);
            } else {
                $data['price'] = false;
            }
            
            if ((float) $product_info['special']) {
                $data['special'] = $this->currency->format($this->tax->calculate($product_info['special'], $product_info['tax_class_id'], $this->config->get('config_tax')), $this->session->data['currency']);
                
                $this->load->model('phpner/p_special_timer');

                $product_info_special = $this->model_phpner_p_special_timer->getProduct($product_id);


                if ($product_info_special) {
                    $data['special_date_start'] = $product_info_special['date_start'];
                    $data['special_date_end']   = $product_info_special['date_end'];
                }
            } else {
                $data['special']            = false;
                $data['special_date_start'] = false;
                $data['special_date_end']   = false;
            }
            
            if ((float) $product_info['special']) {
                $data['economy'] = round((($product_info['price'] - $product_info['special']) / ($product_info['price'] + 0.01)) * 100, 0);
            } else {
                $data['economy'] = false;
            }
            
            if ($this->config->get('config_tax')) {
                $data['tax'] = $this->currency->format((float) $product_info['special'] ? $product_info['special'] : $product_info['price'], $this->session->data['currency']);
            } else {
                $data['tax'] = false;
            }
            
            $data['points'] = $product_info['points'];
            
            $discounts = $this->model_catalog_product->getProductDiscounts($product_id);
            
            $data['discounts'] = array();
            
            foreach ($discounts as $discount) {
                $data['discounts'][] = array(
                    'quantity' => $discount['quantity'],
                    'price' => $this->currency->format($this->tax->calculate($discount['price'], $product_info['tax_class_id'], $this->config->get('config_tax')), $this->session->data['currency'])
                );
            }
            
            if ($phpner_popup_view_data['description_max']) {
                $data['description'] = utf8_substr(strip_tags(html_entity_decode($product_info['description'], ENT_QUOTES, 'UTF-8'), '<p><ul><li><b><strong><a><i><u><br></br><span>'), 0, $phpner_popup_view_data['description_max']) . '..';
            } else {
                $data['description'] = html_entity_decode($product_info['description'], ENT_QUOTES, 'UTF-8');
            }
            if ($product_info['minimum']) {
                $data['minimum'] = $product_info['minimum'];
            } else {
                $data['minimum'] = 1;
            }
            
            $data['options'] = array();
            
            foreach ($this->model_catalog_product->getProductOptions($product_id) as $option) {
                $product_option_value_data = array();
                
                foreach ($option['product_option_value'] as $option_value) {
                    if (!$option_value['subtract'] || ($option_value['quantity'] >= 0)) {
                        if ((($this->config->get('config_customer_price') && $this->customer->isLogged()) || !$this->config->get('config_customer_price')) && (float) $option_value['price']) {
                            $price = $this->currency->format($this->tax->calculate($option_value['price'], $product_info['tax_class_id'], $this->config->get('config_tax') ? 'P' : false), $this->session->data['currency']);
                        } else {
                            $price = false;
                        }
                        
                        $product_option_value_data[] = array(
                            'product_option_value_id' => $option_value['product_option_value_id'],
                            'quantity_status' => ($option_value['quantity'] <= 0) ? false : true,
                            'sku' => (isset($option_value['sku']) && $option_value['sku']) ? $option_value['sku'] : ($product_info['sku'] ? $product_info['sku'] : ''),
                            'model' => (isset($option_value['model']) && $option_value['model']) ? $option_value['model'] : $product_info['model'],
                            'o_v_image' => (isset($option_value['o_v_image']) && $option_value['o_v_image']) ? $this->model_tool_image->resize($option_value['o_v_image'], 50, 50) : $this->model_tool_image->resize("no_image.jpg", 50, 50),
                            'option_value_id' => $option_value['option_value_id'],
                            'name' => $option_value['name'],
                            'image' => $option_value['image'] ? $this->model_tool_image->resize($option_value['image'], 50, 50) : '',
                            'price' => $price,
                            'price_prefix' => $option_value['price_prefix']
                        );
                    }
                }
                
                $data['options'][] = array(
                    'product_option_id' => $option['product_option_id'],
                    'product_option_value' => $product_option_value_data,
                    'option_id' => $option['option_id'],
                    'name' => $option['name'],
                    'type' => $option['type'],
                    'value' => $option['value'],
                    'required' => $option['required']
                );
            }
            
            $data['review_status'] = $this->config->get('config_review_status');
            
            if ($this->config->get('config_review_guest') || $this->customer->isLogged()) {
                $data['review_guest'] = true;
            } else {
                $data['review_guest'] = false;
            }
            
            if ($this->customer->isLogged()) {
                $data['customer_name'] = $this->customer->getFirstName() . '&nbsp;' . $this->customer->getLastName();
            } else {
                $data['customer_name'] = '';
            }
            
            $data['reviews']          = sprintf($this->language->get('text_reviews'), (int) $product_info['reviews']);
            $data['rating']           = (int) $product_info['rating'];
            $data['attribute_groups'] = $this->model_catalog_product->getProductAttributes($this->request->get['product_id']);
            
            $data['recurrings'] = $this->model_catalog_product->getProfiles($product_id);
            $data['tags']       = array();
            
            if ($product_info['tag']) {
                $tags = explode(',', $product_info['tag']);
                
                foreach ($tags as $tag) {
                    $data['tags'][] = array(
                        'tag' => trim($tag),
                        'href' => $this->url->link('product/search', 'tag=' . trim($tag))
                    );
                }
            }
            
            $data['garanted_text'] = array();
            
            if (isset($phpner_data['pr_garantedtext_show']) && $phpner_data['pr_garantedtext_show'] == 'on' && isset($phpner_data['pr_garantedtext']) && $phpner_data['pr_garantedtext']) {
                foreach ($phpner_data['pr_garantedtext'] as $key => $pr_garantedtext) {
                    if ($pr_garantedtext['popup'] == 'on') {
                        $pr_garantedtext_link = (isset($pr_garantedtext['description'][$this->session->data['language']])) ? str_replace('index.php?route=information/information&', 'index.php?route=information/information/agree&', $pr_garantedtext['description'][$this->session->data['language']]['link']) : '';
                    } else {
                        $pr_garantedtext_link = (isset($pr_garantedtext['description'][$this->session->data['language']])) ? $pr_garantedtext['description'][$this->session->data['language']]['link'] : '';
                    }
                    
                    $data['garanted_text'][] = array(
                        'id' => $key,
                        'icon' => $pr_garantedtext['icon'],
                        'popup' => $pr_garantedtext['popup'],
                        'name' => (isset($pr_garantedtext['description'][$this->session->data['language']])) ? $pr_garantedtext['description'][$this->session->data['language']]['name'] : '',
                        'link' => ($pr_garantedtext_link == "#" || empty($pr_garantedtext_link)) ? "javascript:void(0);" : $pr_garantedtext_link
                    );
                }
            }
            
            $data['text_payment_recurring'] = $this->language->get('text_payment_recurring');
            
            if ($this->config->get('config_google_captcha_status')) {
                //$this->document->addScript('https://www.google.com/recaptcha/api.js');
                
                $data['site_key'] = $this->config->get('config_google_captcha_public');
            } else {
                $data['site_key'] = '';
            }
            
            if (isset($phpner_data['terms']) && $phpner_data['terms']) {
                $this->load->model('catalog/information');
                
                $information_info = $this->model_catalog_information->getInformation($phpner_data['terms']);
                
                if ($information_info) {
                    $data['text_terms'] = sprintf($this->language->get('text_phpner_terms'), $this->url->link('information/information', 'information_id=' . $phpner_data['terms'], 'SSL'), $information_info['title'], $information_info['title']);
                } else {
                    $data['text_terms'] = '';
                }
            } else {
                $data['text_terms'] = '';
            }
            
            $this->response->setOutput($this->load->view('extension/module/phpner_popup_view', $data));
        } else {
            die();
        }
    }
    
    public function update_prices() {
        $json = array();
        
        if (isset($this->request->request['product_id']) && isset($this->request->request['quantity'])) {
            
            $this->load->model('catalog/product');
            
            $product_id      = (int) $this->request->request['product_id'];
            $product_info    = (array) $this->model_catalog_product->getProduct($product_id);
            $option_price    = 0;
            $quantity        = (int) $this->request->request['quantity'];
            $product_options = (array) $this->model_catalog_product->getProductOptions($product_id);
            
            if (!empty($this->request->request['option'])) {
                $option = $this->request->request['option'];
            } else {
                $option = array();
            }
            
            foreach ($product_options as $product_option) {
                if (is_array($product_option['product_option_value'])) {
                    foreach ($product_option['product_option_value'] as $option_value) {
                        if (isset($option[$product_option['product_option_id']])) {
                            if (($option[$product_option['product_option_id']] == $option_value['product_option_value_id']) || ((is_array($option[$product_option['product_option_id']])) && (in_array($option_value['product_option_value_id'], $option[$product_option['product_option_id']])))) {
                                if ($option_value['price_prefix'] == '+') {
                                    $option_price += $option_value['price'];
                                } elseif ($option_value['price_prefix'] == '-') {
                                    $option_price -= $option_value['price'];
                                }
                            }
                        }
                    }
                }
            }
            
            $json            = array();
            $json['special'] = $this->currency->format(($this->tax->calculate($this->get_price_discount($product_id, $quantity, 'special'), $product_info['tax_class_id'], $this->config->get('config_tax')) * $quantity) + $this->tax->calculate($option_price * $quantity, $product_info['tax_class_id'], $this->config->get('config_tax')), $this->session->data['currency']);
            if ($json['special']) {
                $economy          = round(((($this->tax->calculate($product_info['price'], $product_info['tax_class_id'], $this->config->get('config_tax')) * $quantity) - ($this->tax->calculate($this->get_price_discount($product_id, $quantity, 'special'), $product_info['tax_class_id'], $this->config->get('config_tax')) * $quantity)) / (($this->tax->calculate($product_info['price'], $product_info['tax_class_id'], $this->config->get('config_tax')) * $quantity) + 0.01)) * 100, 0);
                $saver            = round(($this->tax->calculate($product_info['price'], $product_info['tax_class_id'], $this->config->get('config_tax'))) - ($this->tax->calculate($this->get_price_discount($product_id, $quantity, 'special'), $product_info['tax_class_id'], $this->config->get('config_tax'))));
                //$json['you_save'] = $this->currency->format(($this->tax->calculate($saver, $product_info['tax_class_id'], $this->config->get('config_tax')) * $quantity) + $this->tax->calculate($quantity * $product_info['tax_class_id'], $this->config->get('config_tax')), $this->session->data['currency']) . ' (-'.$economy.'%)';
                $json['you_save'] = '-' . $economy . '%';
            } else {
                $json['you_save'] = false;
            }
            $json['price'] = $this->currency->format(($this->tax->calculate($this->get_price_discount($product_id, $quantity, 'price'), $product_info['tax_class_id'], $this->config->get('config_tax')) * $quantity) + $this->tax->calculate($option_price * $quantity, $product_info['tax_class_id'], $this->config->get('config_tax')), $this->session->data['currency']);
            $json['tax']   = $this->currency->format(($this->get_price_discount($product_id, $quantity, 'price') + $option_price) * $quantity, $this->session->data['currency']);
        }
        $this->response->addHeader('Content-Type: application/json');
        $this->response->setOutput(json_encode($json));
    }
    
    public function get_price_discount($product_id, $quantity, $type) {
        $this->load->model('catalog/product');
        
        $customer_group_id = ($this->customer->isLogged()) ? (int) $this->customer->getGroupId() : (int) $this->config->get('config_customer_group_id');
        
        $product_info = (array) $this->model_catalog_product->getProduct($product_id);
        
        if ($type == 'price') {
            $product_discount_query = $this->db->query("SELECT price FROM " . DB_PREFIX . "product_discount WHERE product_id = '" . (int) $product_id . "' AND customer_group_id = '" . (int) $customer_group_id . "' AND quantity <= '" . (int) $quantity . "' AND ((date_start = '0000-00-00' OR date_start < NOW()) AND (date_end = '0000-00-00' OR date_end > NOW())) ORDER BY quantity DESC, priority ASC, price ASC LIMIT 1");
            if ($product_discount_query->row) {
                $price = $product_discount_query->row['price'];
            } else {
                $price = $product_info['price'];
            }
        }
        if ($type == 'special') {
            $product_special_query = $this->db->query("SELECT price FROM " . DB_PREFIX . "product_special WHERE product_id = '" . (int) $product_id . "' AND customer_group_id = '" . (int) $customer_group_id . "' AND ((date_start = '0000-00-00' OR date_start < NOW()) AND (date_end = '0000-00-00' OR date_end > NOW())) ORDER BY priority ASC, price ASC LIMIT 1");
            if ($product_special_query->row) {
                $price = $product_special_query->row['price'];
            } else {
                $price = $product_info['price'];
            }
        }
        return $price;
    }
    
    public function write() {
        $this->load->language('product/product');
        
        $json = array();
        
        if ($this->request->server['REQUEST_METHOD'] == 'POST') {
            if ((utf8_strlen($this->request->post['name']) < 3) || (utf8_strlen($this->request->post['name']) > 25)) {
                $json['error'] = $this->language->get('error_name');
            }
            
            if ((utf8_strlen($this->request->post['text']) < 25) || (utf8_strlen($this->request->post['text']) > 1000)) {
                $json['error'] = $this->language->get('error_text');
            }
            
            if (empty($this->request->post['rating']) || $this->request->post['rating'] < 0 || $this->request->post['rating'] > 5) {
                $json['error'] = $this->language->get('error_rating');
            }
            
            $phpner_data = $this->config->get('phpner_store_data');
            
            if (isset($phpner_data['terms']) && $phpner_data['terms']) {
                if (!isset($this->request->post['terms'])) {
                    $this->load->model('catalog/information');
                    
                    $information_info = $this->model_catalog_information->getInformation($phpner_data['terms']);
                    
                    $json['error'] = sprintf($this->language->get('error_phpner_terms'), $information_info['title']);
                }
            }
            
            if (!isset($json['error'])) {
                $this->load->model('catalog/review');
                
                $this->model_catalog_review->addReview($this->request->get['product_id'], $this->request->post);
                
                $json['success'] = $this->language->get('text_success');
            }
        }
        
        $this->response->addHeader('Content-Type: application/json');
        $this->response->setOutput(json_encode($json));
    }
}