<?php
/**************************************************************/
/*	@copyright	Phpner 2019							  */
/*	@support	http://phpner.ru					  */
/*	@license	LICENSE.txt									  */
/**************************************************************/

class ControllerExtensionModulePhpnerPopupCart extends Controller {
    public function index() {
        $data = array();
        
        $this->load->language('extension/module/phpner_popup_cart');
        
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
        
        $data['checkout_link']   = $this->url->link('checkout/checkout');
        $data['heading_title']   = $this->language->get('heading_title');
        $data['text_cart_items'] = sprintf($this->language->get('text_items'), $this->cart->countProducts() + (isset($this->session->data['vouchers']) ? count($this->session->data['vouchers']) : 0), $this->currency->format($total, $this->session->data['currency']));
        
        $this->response->setOutput($this->load->view('extension/module/phpner_popup_cart', $data));
    }
    
    public function status_cart() {
        $json = array();
        
        $this->load->language('extension/module/phpner_popup_cart');
        
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
        
        $json['total']           = sprintf($this->language->get('text_cart_items'), $this->currency->format($total, $this->session->data['currency']), $this->cart->countProducts() + (isset($this->session->data['vouchers']) ? count($this->session->data['vouchers']) : 0));
        $json['text_items']      = sprintf($this->language->get('text_items'), $this->cart->countProducts() + (isset($this->session->data['vouchers']) ? count($this->session->data['vouchers']) : 0), $this->currency->format($total, $this->session->data['currency']));
        $json['text_cart_items'] = sprintf($this->language->get('text_cart_items'), $this->cart->countProducts() + (isset($this->session->data['vouchers']) ? count($this->session->data['vouchers']) : 0), $this->currency->format($total, $this->session->data['currency']));
        
        $this->response->addHeader('Content-Type: application/json');
        $this->response->setOutput(json_encode($json));
    }
}