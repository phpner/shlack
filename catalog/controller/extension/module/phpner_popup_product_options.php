<?php
/**************************************************************/
/*	@copyright	Phpner 2019							  */
/*	@support	http://phpner.ru					  */
/*	@license	LICENSE.txt									  */
/**************************************************************/

class ControllerExtensionModulePhpnerPopupProductOptions extends Controller {
    public function index() {
        $data = array();
        
        $this->load->model('catalog/product');
        $this->load->model('tool/image');
        
        $this->load->language('extension/module/phpner_popup_product_options');
        
        $phpner_popup_product_options_data         = (array) $this->config->get('phpner_popup_product_options_data');
        $data['phpner_popup_product_options_data'] = $phpner_popup_product_options_data;
        
        $data['phpner_advanced_options_settings_data'] = $this->config->get('phpner_advanced_options_settings_data');
        
        if (isset($this->request->get['product_id'])) {
            $product_id = (int) $this->request->get['product_id'];
        } else {
            $product_id = 0;
        }
        
        $product_info = $this->model_catalog_product->getProduct($product_id);
        
        $data['product_id']   = $product_id;
        $data['product_name'] = $product_info['name'];
        
        if ($product_info) {
            $data['heading_title']            = $this->language->get('heading_title');
            $data['button_shopping']          = $this->language->get('button_shopping');
            $data['button_checkout']          = $this->language->get('button_checkout');
            $data['button_upload']            = $this->language->get('button_upload');
            $data['text_stock']               = $this->language->get('text_stock');
            $data['entry_quantity']           = $this->language->get('entry_quantity');
            $data['text_minimum']             = sprintf($this->language->get('text_minimum'), $product_info['minimum']);
            $data['text_select']              = $this->language->get('text_select');
            $data['text_option']              = $this->language->get('text_option');
            $data['text_loading']             = $this->language->get('text_loading');
            $data['text_option_disable']      = $this->language->get('text_option_disable');
            $data['text_col_option_name']     = $this->language->get('text_col_option_name');
            $data['text_col_option_image']    = $this->language->get('text_col_option_image');
            $data['text_col_option_sku']      = $this->language->get('text_col_option_sku');
            $data['text_col_option_model']    = $this->language->get('text_col_option_model');
            $data['text_col_option_price']    = $this->language->get('text_col_option_price');
            $data['text_col_option_quantity'] = $this->language->get('text_col_option_quantity');
            
            if ($product_info['quantity'] <= 0) {
                $data['stock_warning'] = $product_info['stock_status'];
            } else {
                $data['stock_warning'] = '';
            }
            
            if ($product_info['minimum']) {
                $data['minimum'] = $product_info['minimum'];
            } else {
                $data['minimum'] = 1;
            }
            
            $data['model'] = $product_info['model'];
            $data['sku']   = $product_info['sku'];
            
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
            
            $data['recurrings'] = $this->model_catalog_product->getProfiles($product_id);
            
            $this->response->setOutput($this->load->view('extension/module/phpner_popup_product_options', $data));
        } else {
            $this->response->redirect($this->url->link('checkout/cart'));
        }
    }
    
    public function add() {
        $this->load->language('checkout/cart');
        
        $json = array();
        
        if (isset($this->request->post['product_id'])) {
            $product_id = (int) $this->request->post['product_id'];
        } else {
            $product_id = 0;
        }
        
        $this->load->model('catalog/product');
        
        $product_info = $this->model_catalog_product->getProduct($product_id);
        
        if ($product_info) {
            if (isset($this->request->post['quantity']) && ((int) $this->request->post['quantity'] >= $product_info['minimum'])) {
                $quantity = (int) $this->request->post['quantity'];
            } else {
                $quantity = $product_info['minimum'] ? $product_info['minimum'] : 1;
            }
            
            if (isset($this->request->post['option'])) {
                $option = array_filter($this->request->post['option']);
            } else {
                $option = array();
            }
            
            $product_options = $this->model_catalog_product->getProductOptions($this->request->post['product_id']);
            
            foreach ($product_options as $product_option) {
                if ($product_option['required'] && empty($option[$product_option['product_option_id']])) {
                    $json['error']['option'][$product_option['product_option_id']] = sprintf($this->language->get('error_required'), $product_option['name']);
                }
            }
            
            if (isset($this->request->post['recurring_id'])) {
                $recurring_id = $this->request->post['recurring_id'];
            } else {
                $recurring_id = 0;
            }
            
            $recurrings = $this->model_catalog_product->getProfiles($product_info['product_id']);
            
            if ($recurrings) {
                $recurring_ids = array();
                
                foreach ($recurrings as $recurring) {
                    $recurring_ids[] = $recurring['recurring_id'];
                }
                
                if (!in_array($recurring_id, $recurring_ids)) {
                    $json['error']['recurring'] = $this->language->get('error_recurring_required');
                }
            }
            
            if (!$json) {
                $this->cart->add($this->request->post['product_id'], $quantity, $option, $recurring_id);
                
                $json['success'] = sprintf($this->language->get('text_success'), $this->url->link('product/product', 'product_id=' . $this->request->post['product_id']), $product_info['name'], $this->url->link('checkout/cart'));
                
                // Unset all shipping and payment methods
                unset($this->session->data['shipping_method']);
                unset($this->session->data['shipping_methods']);
                unset($this->session->data['payment_method']);
                unset($this->session->data['payment_methods']);
                
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
                
                $json['success'] = sprintf($this->language->get('text_success'), $this->url->link('product/product', 'product_id=' . $this->request->post['product_id']), $product_info['name'], $this->url->link('checkout/cart'));
                $json['total']   = sprintf($this->language->get('text_cart_items'), $this->currency->format($total, $this->session->data['currency']), $this->cart->countProducts() + (isset($this->session->data['vouchers']) ? count($this->session->data['vouchers']) : 0));
            }
        }
        
        $this->response->addHeader('Content-Type: application/json');
        $this->response->setOutput(json_encode($json));
    }
}