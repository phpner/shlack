<?php
/**************************************************************/
/*	@copyright	Phpner 2019							  */
/*	@support	http://phpner.ru					  */
/*	@license	LICENSE.txt									  */
/**************************************************************/

class ControllerExtensionModulePhpnerPopupPurchase extends Controller {
    public function index() {
        $data = array();
        
        $this->load->model('catalog/product');
        $this->load->language('extension/module/phpner_popup_purchase');
        
        $phpner_popup_purchase_data         = (array) $this->config->get('phpner_popup_purchase_data');
        $data['phpner_popup_purchase_data'] = $phpner_popup_purchase_data;
        
        // phpner_advanced_options_settings start
        $data['phpner_advanced_options_settings_data'] = $this->config->get('phpner_advanced_options_settings_data');
        // phpner_advanced_options_settings end
        
        if (isset($this->request->get['product_id'])) {
            $product_id = (int) $this->request->get['product_id'];
        } else {
            $product_id = 0;
        }
        
        $data['mask'] = ($phpner_popup_purchase_data['mask']) ? $phpner_popup_purchase_data['mask'] : '';
        
        $product_info = $this->model_catalog_product->getProduct($product_id);
        
        $data['product_id'] = $product_id;
        
        if ($product_info) {
            $data['heading_title']   = $this->language->get('heading_title');
            $data['button_shopping'] = $this->language->get('button_shopping');
            $data['button_checkout'] = $this->language->get('button_checkout');
            $data['button_upload']   = $this->language->get('button_upload');
            $data['text_price']      = $this->language->get('text_price');
            $data['text_reward']     = $this->language->get('text_reward');
            $data['text_points']     = $this->language->get('text_points');
            $data['text_stock']      = $this->language->get('text_stock');
            $data['text_discount']   = $this->language->get('text_discount');
            $data['text_tax']        = $this->language->get('text_tax');
            $data['enter_firstname'] = $this->language->get('enter_firstname');
            $data['enter_telephone'] = $this->language->get('enter_telephone');
            $data['enter_email']     = $this->language->get('enter_email');
            $data['enter_comment']   = $this->language->get('enter_comment');
            $data['entry_quantity']  = $this->language->get('entry_quantity');
            $data['text_minimum']    = sprintf($this->language->get('text_minimum'), $product_info['minimum']);
            $data['text_select']     = $this->language->get('text_select');
            $data['text_option']     = $this->language->get('text_option');
            $data['text_loading']    = $this->language->get('text_loading');
            
            if (!$phpner_popup_purchase_data['stock_check'] && $product_info['quantity'] <= 0) {
                $data['stock_warning'] = $product_info['stock_status'];
            } else {
                $data['stock_warning'] = '';
            }
            
            $data['product_name'] = $product_info['name'];
            
            $this->load->model('tool/image');
            
            $image_width  = ($phpner_popup_purchase_data['image_width']) ? $phpner_popup_purchase_data['image_width'] : '152';
            $image_height = ($phpner_popup_purchase_data['image_height']) ? $phpner_popup_purchase_data['image_height'] : '152';
            
            if ($product_info['image']) {
                $data['thumb'] = $this->model_tool_image->resize($product_info['image'], $image_width, $image_height);
            } else {
                $data['thumb'] = $this->model_tool_image->resize("placeholder.png", $image_width, $image_height);
            }
            
            if (($this->config->get('config_customer_price') && $this->customer->isLogged()) || !$this->config->get('config_customer_price')) {
                $data['price'] = $this->currency->format($this->tax->calculate($product_info['price'], $product_info['tax_class_id'], $this->config->get('config_tax')), $this->session->data['currency']);
            } else {
                $data['price'] = false;
            }
            
            if ((float) $product_info['special']) {
                $data['special'] = $this->currency->format($this->tax->calculate($product_info['special'], $product_info['tax_class_id'], $this->config->get('config_tax')), $this->session->data['currency']);
            } else {
                $data['special'] = false;
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
            
            if ($phpner_popup_purchase_data['description_max']) {
                $data['description'] = utf8_substr(strip_tags(html_entity_decode($product_info['description'], ENT_QUOTES, 'UTF-8')), 0, $phpner_popup_purchase_data['description_max']) . '...';
            } else {
                $data['description'] = html_entity_decode($product_info['description'], ENT_QUOTES, 'UTF-8');
            }
            
            $data['firstname'] = ($this->customer->isLogged()) ? $this->customer->getFirstName() : '';
            $data['email']     = ($this->customer->isLogged()) ? $this->customer->getEmail() : '';
            $data['telephone'] = ($this->customer->isLogged()) ? $this->customer->getTelephone() : '';
            $data['comment']   = '';
            
            if ($product_info['minimum']) {
                $data['minimum'] = $product_info['minimum'];
            } else {
                $data['minimum'] = 1;
            }
            
            $phpner_data = $this->config->get('phpner_store_data');
            
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
            
            $data['options'] = array();
            
            foreach ($this->model_catalog_product->getProductOptions($product_id) as $option) {
                $product_option_value_data = array();
                
                if (isset($phpner_popup_purchase_data['allowed_options']) && (in_array($option['option_id'], $phpner_popup_purchase_data['allowed_options']))) {
                    foreach ($option['product_option_value'] as $option_value) {
                        if (!$option_value['subtract'] || ($option_value['quantity'] > 0)) {
                            if ((($this->config->get('config_customer_price') && $this->customer->isLogged()) || !$this->config->get('config_customer_price')) && (float) $option_value['price']) {
                                $price = $this->currency->format($this->tax->calculate($option_value['price'], $product_info['tax_class_id'], $this->config->get('config_tax') ? 'P' : false), $this->session->data['currency']);
                            } else {
                                $price = false;
                            }
                            
                            $product_option_value_data[] = array(
                                'product_option_value_id' => $option_value['product_option_value_id'],
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
            }
            
            $data['recurrings'] = $this->model_catalog_product->getProfiles($product_id);
            
            $this->response->setOutput($this->load->view('extension/module/phpner_popup_purchase', $data));
        } else {
            $this->response->redirect($this->url->link('checkout/cart'));
        }
    }
    
    public function make_order() {
        $json = array();
        
        $this->language->load('extension/module/phpner_popup_purchase');
        $this->load->model('catalog/product');
        $this->load->model('extension/extension');
        $this->load->model('account/customer');
        $this->load->model('affiliate/affiliate');
        $this->load->model('checkout/order');
        $this->load->model('checkout/marketing');
        
        if (isset($this->request->request['product_id'])) {
            $product_id = (int) $this->request->request['product_id'];
        } else {
            die();
        }
        
        if (isset($this->request->request['option'])) {
            $option = $this->request->request['option'];
        } else {
            $option = array();
        }
        
        if (isset($this->request->request['quantity'])) {
            $quantity = (int) $this->request->request['quantity'];
        } else {
            $quantity = 1;
        }
        
        $phpner_popup_purchase_data = (array) $this->config->get('phpner_popup_purchase_data');
        
        $product_info    = (array) $this->model_catalog_product->getProduct($product_id);
        $product_options = (array) $this->model_catalog_product->getProductOptions($product_id);
        
        $order_status_id = (!empty($phpner_popup_purchase_data['order_status_id'])) ? (int) $phpner_popup_purchase_data['order_status_id'] : (int) $this->config->get('config_order_status_id');
        $customer_info   = ($this->customer->isLogged()) ? $this->model_account_customer->getCustomer($this->customer->getId()) : FALSE;
        
        foreach ($product_options as $product_option) {
            if (isset($phpner_popup_purchase_data['allowed_options']) && (in_array($product_option['option_id'], $phpner_popup_purchase_data['allowed_options']))) {
                if ($product_option['required'] && (empty($option[$product_option['product_option_id']]) || !isset($option[$product_option['product_option_id']]))) {
                    $json['error']['option'][$product_option['product_option_id']] = sprintf($this->language->get('error_option'), $product_option['name']);
                }
                
                if (!$this->config->get('config_stock_checkout') && isset($option[$product_option['product_option_id']])) {
                    foreach ($product_option['product_option_value'] as $product_option_value) {
                        if ($product_option_value['quantity'] > 0 && ($option[$product_option['product_option_id']] == $product_option_value['product_option_value_id'])) {
                            if (isset($this->request->post['quantity']) && $this->request->post['quantity'] > $product_option_value['quantity']) {
                                $json['error']['option'][$product_option['product_option_id']] = sprintf($this->language->get('error_option_quantity_stock'), $product_option['name'], $product_option_value['name']);
                            }
                        }
                    }
                }
            }
        }
        
        if (isset($this->request->post['firstname'])) {
            if ((isset($phpner_popup_purchase_data['firstname']) && $phpner_popup_purchase_data['firstname'] == 2) && (utf8_strlen(trim($this->request->post['firstname'])) < 1) || (utf8_strlen(trim($this->request->post['firstname'])) > 32)) {
                $json['error']['field']['firstname'] = $this->language->get('error_firstname');
            }
        }
        
        if (isset($this->request->post['email'])) {
            if (isset($phpner_popup_purchase_data['email']) && $phpner_popup_purchase_data['email'] == 2) {
                if ((utf8_strlen($this->request->post['email']) > 96) || !preg_match('/^[^\@]+@.*.[a-z]{2,15}$/i', $this->request->post['email'])) {
                    $json['error']['field']['email'] = $this->language->get('error_email');
                }
            }
        }
        
        if (isset($this->request->post['telephone'])) {
            if ((isset($phpner_popup_purchase_data['telephone']) && $phpner_popup_purchase_data['telephone'] == 2) && (utf8_strlen(str_replace(array(
                '_',
                '-',
                '(',
                ')',
                '+'
            ), "", $this->request->post['telephone'])) < 3 || utf8_strlen(str_replace(array(
                '_',
                '-',
                '(',
                ')',
                '+'
            ), "", $this->request->post['telephone'])) > 32)) {
                $json['error']['field']['telephone'] = $this->language->get('error_telephone');
            }
        }
        
        if (isset($this->request->post['comment'])) {
            if ((isset($phpner_popup_purchase_data['comment']) && $phpner_popup_purchase_data['comment'] == 2) && (utf8_strlen($this->request->post['comment']) < 3) || (utf8_strlen($this->request->post['comment']) > 500)) {
                $json['error']['field']['comment'] = $this->language->get('error_comment');
            }
        }
        
        if (!$this->config->get('config_stock_checkout')) {
            if (isset($this->request->post['quantity']) && $this->request->post['quantity'] > $product_info['quantity']) {
                $json['error']['quantity'] = $this->language->get('error_quantity_stock');
            }
        }
        
        $phpner_data = $this->config->get('phpner_store_data');
        
        if (isset($phpner_data['terms']) && $phpner_data['terms']) {
            if (!isset($this->request->post['terms'])) {
                $this->load->model('catalog/information');
                
                $information_info = $this->model_catalog_information->getInformation($phpner_data['terms']);
                
                $json['error']['field']['terms'] = sprintf($this->language->get('error_phpner_terms'), $information_info['title']);
            }
        }
        
        if (!isset($json['error'])) {
            
            $order_data = array();
            
            if (version_compare(VERSION, '2.1.0.1') < 0) {
                $cart_product_key = ($option) ? (int) $product_id . ':' . base64_encode(serialize($option)) : (int) $product_id;
            } else {
                $cart_product_key = (int) $product_id;
            }
            
            $old_cart_product_id = $this->cart->getProducts();
            
            if (isset($old_cart_product_id[$cart_product_key])) {
                $this->cart->remove($cart_product_key);
            }
            
            if (version_compare(VERSION, '2.1.0.1') < 0) {
                $cart = $this->session->data['cart'];
                unset($this->session->data['cart']);
            } else {
                $cart = $this->cart->getProducts();
                $this->cart->clear();
            }
            
            $this->cart->add($product_id, $quantity, $option);
            
            if (!empty($this->request->server['HTTP_X_FORWARDED_FOR'])) {
                $forwarded_ip = $this->request->server['HTTP_X_FORWARDED_FOR'];
            } elseif (!empty($this->request->server['HTTP_CLIENT_IP'])) {
                $forwarded_ip = $this->request->server['HTTP_CLIENT_IP'];
            } else {
                $forwarded_ip = '';
            }
            
            $accept_language = isset($this->request->server['HTTP_ACCEPT_LANGUAGE']) ? $this->request->server['HTTP_ACCEPT_LANGUAGE'] : '';
            $user_agent      = isset($this->request->server['HTTP_USER_AGENT']) ? $this->request->server['HTTP_USER_AGENT'] : '';
            
            // Affiliate
            if (isset($this->request->cookie['tracking'])) {
                $affiliate_info = $this->model_affiliate_affiliate->getAffiliateByCode($this->request->cookie['tracking']);
                $tracking       = $this->request->cookie['tracking'];
                $subtotal       = $this->cart->getSubTotal();
                
                if ($affiliate_info) {
                    $affiliate_id = $affiliate_info['affiliate_id'];
                    $commission   = ($subtotal / 100) * $affiliate_info['commission'];
                } else {
                    $affiliate_id = 0;
                    $commission   = 0;
                }
                
                // Marketing
                $marketing_info = $this->model_checkout_marketing->getMarketingByCode($this->request->cookie['tracking']);
                
                if ($marketing_info) {
                    $marketing_id = $marketing_info['marketing_id'];
                } else {
                    $marketing_id = 0;
                }
                
            } else {
                $affiliate_id = 0;
                $commission   = 0;
                $marketing_id = 0;
                $tracking     = '';
            }
            
            $order_products = array();
            
            foreach ($this->cart->getProducts() as $product) {
                $option_data = array();
                
                foreach ($product['option'] as $option) {
                    $option_data[] = array(
                        'product_option_id' => $option['product_option_id'],
                        'product_option_value_id' => $option['product_option_value_id'],
                        'option_id' => $option['option_id'],
                        'option_value_id' => $option['option_value_id'],
                        'name' => $option['name'],
                        'value' => $option['value'],
                        'sku' => isset($option['sku']) ? $option['sku'] : '',
                        'model' => isset($option['model']) ? $option['model'] : '',
                        'phpner_quantity_value' => isset($option['phpner_quantity_value']) ? $option['phpner_quantity_value'] : '',
                        'type' => $option['type']
                    );
                }
                
                $order_products[] = array(
                    'product_id' => $product['product_id'],
                    'name' => $product['name'],
                    'model' => $product['model'],
                    'option' => $option_data,
                    'download' => $product['download'],
                    'quantity' => $product['quantity'],
                    'subtract' => $product['subtract'],
                    'price' => $product['price'],
                    'total' => $product['total'],
                    'tax' => $this->tax->getTax($product['price'], $product['tax_class_id']),
                    'reward' => $product['reward']
                );
            }
            
            $totals = array();
            $taxes  = $this->cart->getTaxes();
            $total  = 0;
            
            // Because __call can not keep var references so we put them into an array.
            $total_data = array(
                'totals' => &$totals,
                'taxes' => &$taxes,
                'total' => &$total
            );
            
            $this->load->model('extension/extension');
            
            $sort_order = array();
            
            $results = $this->model_extension_extension->getExtensions('total');
            
            foreach ($results as $key => $value) {
                $sort_order[$key] = $this->config->get($value['code'] . '_sort_order');
            }
            
            array_multisort($sort_order, SORT_ASC, $results);
            
            foreach ($results as $result) {
                if ($this->config->get($result['code'] . '_status')) {
                    $this->load->model('extension/total/' . $result['code']);
                    
                    // We have to put the totals in an array so that they pass by reference.
                    $this->{'model_extension_total_' . $result['code']}->getTotal($total_data);
                }
            }
            
            $sort_order = array();
            
            foreach ($totals as $key => $value) {
                $sort_order[$key] = $value['sort_order'];
            }
            
            array_multisort($sort_order, SORT_ASC, $totals);
            
            $alt_notify_email = (isset($phpner_popup_purchase_data['notify_email'])) ? $phpner_popup_purchase_data['notify_email'] : $this->config->get('config_email');
            
            $order_data = array(
                'invoice_prefix' => $this->config->get('config_invoice_prefix'),
                'store_id' => $store_id = (int) $this->config->get('config_store_id'),
                'store_name' => $this->config->get('config_name'),
                'store_url' => $store_id ? $this->config->get('config_url') : HTTP_SERVER,
                'customer_id' => $this->customer->isLogged() ? $this->customer->getId() : 0,
                'customer_group_id' => $this->customer->isLogged() ? $this->customer->getGroupId() : $this->config->get('config_customer_group_id'),
                'firstname' => (isset($this->request->request['firstname'])) ? $this->request->request['firstname'] : $this->language->get('heading_title'),
                'lastname' => '',
                'email' => (isset($this->request->request['email'])) ? (!empty($this->request->request['email']) ? $this->request->request['email'] : $alt_notify_email) : $alt_notify_email,
                'telephone' => (isset($this->request->request['telephone'])) ? $this->request->request['telephone'] : '',
                'fax' => '',
                'shipping_city' => '',
                'shipping_postcode' => '',
                'shipping_country' => '',
                'shipping_country_id' => '',
                'shipping_zone_id' => '',
                'shipping_zone' => '',
                'shipping_address_format' => '',
                'shipping_firstname' => (isset($this->request->request['firstname'])) ? $this->request->request['firstname'] : $this->language->get('heading_title'),
                'shipping_lastname' => '',
                'shipping_company' => '',
                'shipping_address_1' => '',
                'shipping_address_2' => '',
                'shipping_code' => '',
                'shipping_method' => '',
                'payment_city' => '',
                'payment_postcode' => '',
                'payment_country' => '',
                'payment_country_id' => '',
                'payment_zone' => '',
                'payment_zone_id' => '',
                'payment_address_format' => '',
                'payment_firstname' => (isset($this->request->request['firstname'])) ? $this->request->request['firstname'] : $this->language->get('heading_title'),
                'payment_lastname' => '',
                'payment_company' => '',
                'payment_address_1' => '',
                'payment_address_2' => '',
                'payment_company_id' => '',
                'payment_tax_id' => '',
                'payment_code' => (version_compare(VERSION, '2.1.0.1') < 0) ? '' : 'free_checkout',
                'payment_method' => (version_compare(VERSION, '2.1.0.1') < 0) ? '' : '--',
                'forwarded_ip' => $forwarded_ip,
                'user_agent' => $user_agent,
                'accept_language' => $accept_language,
                'vouchers' => array(),
                'comment' => (isset($this->request->request['comment'])) ? $this->request->request['comment'] : '',
                'total' => $total,
                'reward' => '',
                'affiliate_id' => $affiliate_id,
                'tracking' => $tracking,
                'commission' => $commission,
                'marketing_id' => $marketing_id,
                'language_id' => $this->config->get('config_language_id'),
                'currency_id' => $this->currency->getId($this->session->data['currency']),
                'currency_code' => $this->session->data['currency'],
                'currency_value' => $this->currency->getValue($this->session->data['currency']),
                'ip' => $this->request->server['REMOTE_ADDR'],
                'products' => $order_products,
                'totals' => $totals
            );
            
            $this->session->data['order_id'] = $this->model_checkout_order->addOrder($order_data);
            
            $order_id = (int) $this->session->data['order_id'];
            
            $this->model_checkout_order->addOrderHistory($this->session->data['order_id'], $this->config->get('config_order_status_id'));
            
            $this->db->query("UPDATE `" . DB_PREFIX . "order` SET order_status_id = '" . (int) $this->config->get('config_order_status_id') . "', date_modified = NOW() WHERE order_id = '" . $order_id . "'");
            
            if (version_compare(VERSION, '2.1.0.1') < 0) {
                $this->session->data['cart'] = $cart;
            } else {
                $this->cart->clear();
                if ($cart) {
                    foreach ($cart as $value) {
                        $this->cart->add($value['product_id'], $value['quantity'], $value['option']);
                    }
                }
            }
            
            $json['output'] = sprintf($this->language->get('text_success_order'), $order_id);
        }
        
        $this->response->addHeader('Content-Type: application/json');
        $this->response->setOutput(json_encode($json));
    }
    
    public function update_prices() {
        $json = array();
        
        if (isset($this->request->request['product_id']) && isset($this->request->request['quantity'])) {
            $this->load->model('catalog/product');
            
            $option_price    = 0;
            $product_id      = (int) $this->request->request['product_id'];
            $quantity        = (int) $this->request->request['quantity'];
            $product_info    = $this->model_catalog_product->getProduct($product_id);
            $product_options = $this->model_catalog_product->getProductOptions($product_id);
            
            if (!empty($this->request->request['option'])) {
                $options = $this->request->request['option'];
            } else {
                $options = array();
            }
            
            $options_arr = array();
            
            if ($options) {
                foreach ($options as $key => $option) {
                    if (is_array($option)) {
                        foreach ($option as $option_value) {
                            $product_option_value_id_data = explode("|", $option_value);
                            if (isset($product_option_value_id_data[0]) && isset($product_option_value_id_data[1])) {
                                $options_arr[$key][$product_option_value_id_data[0]] = array(
                                    'product_option_value_id' => $product_option_value_id_data[0],
                                    'quantity' => $product_option_value_id_data[1]
                                );
                            }
                        }
                    }
                }
            }
            
            foreach ($product_options as $product_option) {
                if (is_array($product_option['product_option_value'])) {
                    foreach ($product_option['product_option_value'] as $option_value) {
                        if ($product_option['type'] == 'phpner_quantity') {
                            if (isset($options_arr[$product_option['product_option_id']][$option_value['product_option_value_id']])) {
                                if (($options_arr[$product_option['product_option_id']][$option_value['product_option_value_id']]['product_option_value_id'] == $option_value['product_option_value_id'])) {
                                    $phpner_quantity = (isset($options_arr[$product_option['product_option_id']][$option_value['product_option_value_id']]['quantity'])) ? $options_arr[$product_option['product_option_id']][$option_value['product_option_value_id']]['quantity'] : 1;
                                    if ($option_value['price_prefix'] == '+') {
                                        $option_price += $option_value['price'] * $phpner_quantity;
                                    } elseif ($option_value['price_prefix'] == '-') {
                                        $option_price -= $option_value['price'] * $phpner_quantity;
                                    }
                                }
                            }
                        } else {
                            if (isset($options[$product_option['product_option_id']])) {
                                if (($options[$product_option['product_option_id']] == $option_value['product_option_value_id']) || ((is_array($options[$product_option['product_option_id']])) && (in_array($option_value['product_option_value_id'], $options[$product_option['product_option_id']])))) {
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
            }
            
            $json = array();
            
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
            
            $json['tax'] = $this->currency->format(($this->get_price_discount($product_id, $quantity, 'price') + $option_price) * $quantity, $this->session->data['currency']);
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
}