<?php
/**************************************************************/
/*	@copyright	Phpner 2019							  */
/*	@support	http://phpner.ru					  */
/*	@license	LICENSE.txt									  */
/**************************************************************/

class ControllerExtensionModulePhpnerPageBar extends Controller {
    public function index() {
        $this->load->language('extension/module/phpner_page_bar');
        
        $this->load->model('tool/image');
        $this->load->model('catalog/product');
        $this->load->model('account/wishlist');
        
        $data['total_viewed'] = isset($this->session->data['phpner_product_viewed']) ? count(array_unique($this->session->data['phpner_product_viewed'])) : 0;
        if ($this->customer->isLogged()) {
            $data['total_wishlist'] = $this->model_account_wishlist->getTotalWishlist();
        } else {
            $data['total_wishlist'] = isset($this->session->data['wishlist']) ? count($this->session->data['wishlist']) : 0;
        }
        $data['total_compare'] = isset($this->session->data['compare']) ? count($this->session->data['compare']) : 0;
        $data['total_cart']    = $this->cart->countProducts() + (isset($this->session->data['vouchers']) ? count($this->session->data['vouchers']) : 0);
        
        $data['tab_viewed']   = $this->language->get('tab_viewed');
        $data['tab_wishlist'] = $this->language->get('tab_wishlist');
        $data['tab_compare']  = $this->language->get('tab_compare');
        $data['tab_cart']     = $this->language->get('tab_cart');
        
        $data['text_viewed']   = $this->language->get('text_viewed');
        $data['text_wishlist'] = $this->language->get('text_wishlist');
        $data['text_compare']  = $this->language->get('text_compare');
        $data['text_cart']     = $this->language->get('text_cart');
        
        $data['button_cart']     = $this->language->get('button_cart');
        $data['button_wishlist'] = $this->language->get('button_wishlist');
        $data['button_compare']  = $this->language->get('button_compare');
        
        $phpner_page_bar_data         = $this->config->get('phpner_page_bar_data');
        $data['phpner_page_bar_data'] = $phpner_page_bar_data;
        
        return $this->load->view('extension/module/phpner_page_bar', $data);
    }
    
    public function remove_compare() {
        $json = array();
        
        if (isset($this->request->request['remove']) && isset($this->session->data['compare'])) {
            $key = array_search($this->request->request['remove'], $this->session->data['compare']);
            
            if ($key !== false) {
                unset($this->session->data['compare'][$key]);
            }
        }
        
        $this->response->addHeader('Content-Type: application/json');
        $this->response->setOutput(json_encode($json));
    }
    
    public function remove_wishlist() {
        $json = array();
        
        $this->load->model('account/wishlist');
        
        if ($this->customer->isLogged()) {
            $this->model_account_wishlist->deleteWishlist($this->request->request['remove']);
        } else {
            $key = array_search($this->request->request['remove'], $this->session->data['wishlist']);
            
            if ($key !== false) {
                unset($this->session->data['wishlist'][$key]);
            }
        }
        
        $this->response->addHeader('Content-Type: application/json');
        $this->response->setOutput(json_encode($json));
    }
    
    public function block_viewed() {
        $this->load->language('extension/module/phpner_page_bar');
        
        $this->load->model('tool/image');
        $this->load->model('catalog/product');
        
        $data['phpner_popup_view_data'] = $this->config->get('phpner_popup_view_data');
        $data['button_popup_view']   = $this->language->get('button_popup_view');
        
        $data['text_viewed'] = $this->language->get('text_viewed');
        
        $data['button_cart']     = $this->language->get('button_cart');
        $data['button_wishlist'] = $this->language->get('button_wishlist');
        $data['button_compare']  = $this->language->get('button_compare');
        
        $phpner_page_bar_data = $this->config->get('phpner_page_bar_data');
        
        $data['products'] = array();
        
        if (isset($this->session->data['phpner_product_viewed']) && !empty($this->session->data['phpner_product_viewed'])) {
            
            $products = array_unique($this->session->data['phpner_product_viewed']);
            
            krsort($products);
            
            foreach ($products as $product_id) {
                $product_info = $this->model_catalog_product->getProduct($product_id);
                
                if ($product_info) {
                    if ($product_info['image']) {
                        $image = $this->model_tool_image->resize($product_info['image'], $phpner_page_bar_data['width'], $phpner_page_bar_data['height']);
                    } else {
                        $image = $this->model_tool_image->resize('placeholder.png', $phpner_page_bar_data['width'], $phpner_page_bar_data['height']);
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
                        
                        if ($product_info['phpner_product_stickers']) {
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
                    
                    if (isset($phpner_product_preorder_data['status']) && $phpner_product_preorder_data['status'] && isset($phpner_product_preorder_data['stock_statuses']) && in_array($product_info['phpner_stock_status_id'], $phpner_product_preorder_data['stock_statuses'])) {
                        $product_preorder_text   = $phpner_product_preorder_text[$this->session->data['language']]['call_button'];
                        $product_preorder_status = 1;
                    } else {
                        $product_preorder_text   = $phpner_product_preorder_language['text_out_of_stock'];
                        $product_preorder_status = 2;
                    }
                    
                    $data['products'][] = array(
                        'phpner_product_stickers' => $phpner_product_stickers,
                        'product_id' => $product_info['product_id'],
                        'thumb' => $image,
                        'name' => $product_info['name'],
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
        
        $this->response->setOutput($this->load->view('extension/module/phpner_page_bar_block_viewed', $data));
    }
    
    public function block_wishlist() {
        $this->load->language('extension/module/phpner_page_bar');
        
        $this->load->model('tool/image');
        $this->load->model('catalog/product');
        $this->load->model('account/wishlist');
        
        $data['phpner_popup_view_data'] = $this->config->get('phpner_popup_view_data');
        $data['button_popup_view']   = $this->language->get('button_popup_view');
        
        $data['text_wishlist'] = $this->language->get('text_wishlist');
        
        $data['button_cart']     = $this->language->get('button_cart');
        $data['remove_wishlist'] = $this->language->get('remove_wishlist');
        $data['button_compare']  = $this->language->get('button_compare');
        
        $data['wishlist'] = $this->url->link('account/wishlist', '', true);
        
        $phpner_page_bar_data = $this->config->get('phpner_page_bar_data');
        
        $data['products'] = array();
        
        if ($this->customer->isLogged()) {
            $results = $this->model_account_wishlist->getWishlist();
        } else {
            $results = isset($this->session->data['wishlist']) ? $this->session->data['wishlist'] : array();
        }
        
        foreach ($results as $result) {
            
            if ($this->customer->isLogged()) {
                $product_info = $this->model_catalog_product->getProduct($result['product_id']);
            } else {
                $product_info = $this->model_catalog_product->getProduct($result);
            }
            
            if ($product_info) {
                if ($product_info['image']) {
                    $image = $this->model_tool_image->resize($product_info['image'], $phpner_page_bar_data['width'], $phpner_page_bar_data['height']);
                } else {
                    $image = $this->model_tool_image->resize('placeholder.png', $phpner_page_bar_data['width'], $phpner_page_bar_data['height']);
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
                    
                    if ($product_info['phpner_product_stickers']) {
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
                
                if (isset($phpner_product_preorder_data['status']) && $phpner_product_preorder_data['status'] && isset($phpner_product_preorder_data['stock_statuses']) && in_array($product_info['phpner_stock_status_id'], $phpner_product_preorder_data['stock_statuses'])) {
                    $product_preorder_text   = $phpner_product_preorder_text[$this->session->data['language']]['call_button'];
                    $product_preorder_status = 1;
                } else {
                    $product_preorder_text   = $phpner_product_preorder_language['text_out_of_stock'];
                    $product_preorder_status = 2;
                }
                
                $data['products'][] = array(
                    'phpner_product_stickers' => $phpner_product_stickers,
                    'product_id' => $product_info['product_id'],
                    'thumb' => $image,
                    'name' => $product_info['name'],
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
        
        $this->response->setOutput($this->load->view('extension/module/phpner_page_bar_block_wishlist', $data));
    }
    
    public function block_compare() {
        $this->load->language('extension/module/phpner_page_bar');
        
        $this->load->model('tool/image');
        $this->load->model('catalog/product');
        
        $data['phpner_popup_view_data'] = $this->config->get('phpner_popup_view_data');
        $data['button_popup_view']   = $this->language->get('button_popup_view');
        
        $data['text_compare'] = $this->language->get('text_compare');
        
        $data['button_cart']     = $this->language->get('button_cart');
        $data['button_wishlist'] = $this->language->get('button_wishlist');
        $data['remove_compare']  = $this->language->get('remove_compare');
        
        $phpner_page_bar_data = $this->config->get('phpner_page_bar_data');
        
        $data['compare'] = $this->url->link('product/compare');
        
        $data['products'] = array();
        
        $results = isset($this->session->data['compare']) ? $this->session->data['compare'] : array();
        
        foreach ($results as $product_id) {
            
            $product_info = $this->model_catalog_product->getProduct($product_id);
            
            if ($product_info) {
                if ($product_info['image']) {
                    $image = $this->model_tool_image->resize($product_info['image'], $phpner_page_bar_data['width'], $phpner_page_bar_data['height']);
                } else {
                    $image = $this->model_tool_image->resize('placeholder.png', $phpner_page_bar_data['width'], $phpner_page_bar_data['height']);
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
                    
                    if ($product_info['phpner_product_stickers']) {
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
                
                if (isset($phpner_product_preorder_data['status']) && $phpner_product_preorder_data['status'] && isset($phpner_product_preorder_data['stock_statuses']) && in_array($product_info['phpner_stock_status_id'], $phpner_product_preorder_data['stock_statuses'])) {
                    $product_preorder_text   = $phpner_product_preorder_text[$this->session->data['language']]['call_button'];
                    $product_preorder_status = 1;
                } else {
                    $product_preorder_text   = $phpner_product_preorder_language['text_out_of_stock'];
                    $product_preorder_status = 2;
                }
                
                $data['products'][] = array(
                    'phpner_product_stickers' => $phpner_product_stickers,
                    'product_id' => $product_info['product_id'],
                    'thumb' => $image,
                    'name' => $product_info['name'],
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
        
        $this->response->setOutput($this->load->view('extension/module/phpner_page_bar_block_compare', $data));
    }
    
    public function block_cart() {
        $data = array();
        
        $this->load->language('extension/module/phpner_page_bar');
        
        $data['text_cart']           = $this->language->get('text_cart');
        $data['text_recurring_item'] = $this->language->get('text_recurring_item');
        $data['text_next']           = $this->language->get('text_next');
        $data['text_next_choice']    = $this->language->get('text_next_choice');
        $data['button_shopping']     = $this->language->get('button_shopping');
        $data['button_checkout']     = $this->language->get('button_checkout');
        $data['empty']               = $this->language->get('text_empty');
        $data['column_image']        = $this->language->get('column_image');
        $data['column_name']         = $this->language->get('column_name');
        $data['column_quantity']     = $this->language->get('column_quantity');
        $data['column_price']        = $this->language->get('column_price');
        
        $phpner_page_bar_data = $this->config->get('phpner_page_bar_data');
        
        if (isset($this->request->request['remove'])) {
            $this->cart->remove($this->request->request['remove']);
            unset($this->session->data['vouchers'][$this->request->request['remove']]);
        }
        
        if (isset($this->request->request['update'])) {
            $this->cart->update($this->request->request['update'], $this->request->request['quantity']);
        }
        
        if (isset($this->request->request['add'])) {
            $this->cart->add($this->request->request['add'], $this->request->request['quantity']);
        }
        
        if (!$this->cart->hasStock() && (!$this->config->get('config_stock_checkout') || $this->config->get('config_stock_warning'))) {
            $data['error_warning'] = $this->language->get('error_stock');
        } elseif (isset($this->session->data['error'])) {
            $data['error_warning'] = $this->session->data['error'];
            
            unset($this->session->data['error']);
        } else {
            $data['error_warning'] = '';
        }
        
        if ($this->config->get('config_customer_price') && !$this->customer->isLogged()) {
            $data['attention'] = sprintf($this->language->get('text_login'), $this->url->link('account/login'), $this->url->link('account/register'));
        } else {
            $data['attention'] = '';
        }
        
        if (isset($this->session->data['success'])) {
            $data['success'] = $this->session->data['success'];
            
            unset($this->session->data['success']);
        } else {
            $data['success'] = '';
        }
        
        $this->load->model('tool/image');
        $this->load->model('tool/upload');
        
        $data['products'] = array();
        
        $products = $this->cart->getProducts();
        
        foreach ($products as $product) {
            $product_total = 0;
            
            foreach ($products as $product_2) {
                if ($product_2['product_id'] == $product['product_id']) {
                    $product_total += $product_2['quantity'];
                }
            }
            
            if ($product['minimum'] > $product_total) {
                $data['error_warning'] = sprintf($this->language->get('error_minimum'), $product['name'], $product['minimum']);
            }
            
            if ($product['image']) {
                $image = $this->model_tool_image->resize($product['image'], 70, 95);
            } else {
                $image = $this->model_tool_image->resize("placeholder.png", 70, 95);
            }
            
            $option_data = array();
            
            foreach ($product['option'] as $option) {
                if ($option['type'] != 'file') {
                    $value = $option['value'];
                } else {
                    $upload_info = $this->model_tool_upload->getUploadByCode($option['value']);
                    
                    if ($upload_info) {
                        $value = $upload_info['name'];
                    } else {
                        $value = '';
                    }
                }
                
                $option_data[] = array(
                    'name' => $option['name'],
                    'value' => (utf8_strlen($value) > 20 ? utf8_substr($value, 0, 20) . '..' : $value)
                );
            }
            
            // Display prices
            if (($this->config->get('config_customer_price') && $this->customer->isLogged()) || !$this->config->get('config_customer_price')) {
                $p_price = $this->currency->format($this->tax->calculate($product['price'], $product['tax_class_id'], $this->config->get('config_tax')), $this->session->data['currency']);
            } else {
                $p_price = false;
            }
            
            // Display prices
            if (($this->config->get('config_customer_price') && $this->customer->isLogged()) || !$this->config->get('config_customer_price')) {
                $p_total = $this->currency->format($this->tax->calculate($product['price'], $product['tax_class_id'], $this->config->get('config_tax')) * $product['quantity'], $this->session->data['currency']);
            } else {
                $p_total = false;
            }
            
            $recurring = '';
            
            if ($product['recurring']) {
                $frequencies = array(
                    'day' => $this->language->get('text_day'),
                    'week' => $this->language->get('text_week'),
                    'semi_month' => $this->language->get('text_semi_month'),
                    'month' => $this->language->get('text_month'),
                    'year' => $this->language->get('text_year')
                );
                
                if ($product['recurring']['trial']) {
                    $recurring = sprintf($this->language->get('text_trial_description'), $this->currency->format($this->tax->calculate($product['recurring']['trial_price'] * $product['quantity'], $product['tax_class_id'], $this->config->get('config_tax')), $this->session->data['currency']), $product['recurring']['trial_cycle'], $frequencies[$product['recurring']['trial_frequency']], $product['recurring']['trial_duration']) . ' ';
                }
                
                if ($product['recurring']['duration']) {
                    $recurring .= sprintf($this->language->get('text_payment_description'), $this->currency->format($this->tax->calculate($product['recurring']['price'] * $product['quantity'], $product['tax_class_id'], $this->config->get('config_tax')), $this->session->data['currency']), $product['recurring']['cycle'], $frequencies[$product['recurring']['frequency']], $product['recurring']['duration']);
                } else {
                    $recurring .= sprintf($this->language->get('text_payment_cancel'), $this->currency->format($this->tax->calculate($product['recurring']['price'] * $product['quantity'], $product['tax_class_id'], $this->config->get('config_tax')), $this->session->data['currency']), $product['recurring']['cycle'], $frequencies[$product['recurring']['frequency']], $product['recurring']['duration']);
                }
            }
            
            $data['products'][] = array(
                'key' => $product['cart_id'],
                'product_id' => $product['product_id'],
                'thumb' => $image,
                'name' => $product['name'],
                'model' => $product['model'],
                'option' => $option_data,
                'recurring' => $recurring,
                'quantity' => $product['quantity'],
                'stock' => $product['stock'] ? true : !(!$this->config->get('config_stock_checkout') || $this->config->get('config_stock_warning')),
                'reward' => ($product['reward'] ? sprintf($this->language->get('text_points'), $product['reward']) : ''),
                'price' => $p_price,
                'total' => $p_total,
                'href' => $this->url->link('product/product', 'product_id=' . $product['product_id'])
            );
        }
        
        // Gift Voucher
        $data['vouchers'] = array();
        
        if (!empty($this->session->data['vouchers'])) {
            foreach ($this->session->data['vouchers'] as $key => $voucher) {
                $data['vouchers'][] = array(
                    'key' => $key,
                    'description' => $voucher['description'],
                    'amount' => $this->currency->format($voucher['amount'], $this->session->data['currency']),
                    'remove' => $this->url->link('checkout/cart', 'remove=' . $key)
                );
            }
        }
        
        // Totals
        $this->load->model('extension/extension');
        
        $totals = array();
        $taxes  = $this->cart->getTaxes();
        $total  = 0;
        
        // Because __call can not keep var references so we put them into an array. 			
        $total_data = array(
            'totals' => &$totals,
            'taxes' => &$taxes,
            'total' => &$total
        );
        
        // Display prices
        if ($this->customer->isLogged() || !$this->config->get('config_customer_price')) {
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
        }
        
        $data['totals'] = array();
        
        foreach ($totals as $total_value) {
            if ($total_value['code'] == 'total') {
                $data['totals'][] = array(
                    'title' => $total_value['title'],
                    'text' => $this->currency->format($total_value['value'], $this->session->data['currency'])
                );
            }
        }
        
        $data['checkout_link']    = $this->url->link('checkout/checkout');
        $data['heading_title']    = $this->language->get('heading_title');
        $data['text_cart_items']  = sprintf($this->language->get('text_cart_items'), $this->cart->countProducts() + (isset($this->session->data['vouchers']) ? count($this->session->data['vouchers']) : 0), $this->currency->format($total, $this->session->data['currency']));
        $data['text_cart_items2'] = sprintf($this->language->get('text_cart_items2'), $this->currency->format($total, $this->session->data['currency']), $this->cart->countProducts() + (isset($this->session->data['vouchers']) ? count($this->session->data['vouchers']) : 0));
        
        $this->response->setOutput($this->load->view('extension/module/phpner_page_bar_block_cart', $data));
    }
    
    public function status_cart() {
        $json = array();
        
        $this->load->language('extension/module/phpner_page_bar');
        
        // Totals
        $this->load->model('extension/extension');
        
        $totals = array();
        $taxes  = $this->cart->getTaxes();
        $total  = 0;
        
        // Because __call can not keep var references so we put them into an array. 			
        $total_data = array(
            'totals' => &$totals,
            'taxes' => &$taxes,
            'total' => &$total
        );
        
        // Display prices
        if ($this->customer->isLogged() || !$this->config->get('config_customer_price')) {
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
        }
        
        $json['total']           = $this->cart->countProducts() + (isset($this->session->data['vouchers']) ? count($this->session->data['vouchers']) : 0);
        $json['text_cart_items'] = sprintf($this->language->get('text_cart_items2'), $this->currency->format($total, $this->session->data['currency']), $this->cart->countProducts() + (isset($this->session->data['vouchers']) ? count($this->session->data['vouchers']) : 0));
        
        $this->response->addHeader('Content-Type: application/json');
        $this->response->setOutput(json_encode($json));
    }
    
    public function update_html() {
        $json = array();
        
        $this->load->model('account/wishlist');
        
        $json['total_viewed'] = isset($this->session->data['phpner_product_viewed']) ? count(array_unique($this->session->data['phpner_product_viewed'])) : 0;
        if ($this->customer->isLogged()) {
            $json['total_wishlist'] = $this->model_account_wishlist->getTotalWishlist();
        } else {
            $json['total_wishlist'] = isset($this->session->data['wishlist']) ? count($this->session->data['wishlist']) : 0;
        }
        $json['total_compare'] = isset($this->session->data['compare']) ? count($this->session->data['compare']) : 0;
        $json['total_cart']    = $this->cart->countProducts() + (isset($this->session->data['vouchers']) ? count($this->session->data['vouchers']) : 0);
        
        $this->response->addHeader('Content-Type: application/json');
        $this->response->setOutput(json_encode($json));
    }
}