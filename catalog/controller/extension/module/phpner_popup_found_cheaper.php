<?php
/**************************************************************/
/*	@copyright	Phpner 2019							  */
/*	@support	http://phpner.ru					  */
/*	@license	LICENSE.txt									  */
/**************************************************************/

class ControllerExtensionModulePhpnerPopupFoundCheaper extends Controller {
    public function index() {
        $data = array();
        
        $this->load->language('extension/module/phpner_popup_found_cheaper');
        
        if (isset($this->request->get['product_id'])) {
            $product_id = $this->request->get['product_id'];
        } else {
            die();
        }
        
        $this->load->model('catalog/product');
        
        $product_info = $this->model_catalog_product->getProduct($product_id);
        
        if ($product_info) {
            
            $this->load->model('tool/image');
            
            if ($product_info['image']) {
                $data['thumb'] = $this->model_tool_image->resize($product_info['image'], 300, 200);
            } else {
                $data['thumb'] = '';
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
            
            $data['heading_title_product'] = $product_info['name'];
            $data['href']                  = $this->url->link('product/product', 'product_id=' . $product_info['product_id']);
            $data['model']                 = $product_info['model'];
        }
        
        $phpner_popup_found_cheaper_data         = (array) $this->config->get('phpner_popup_found_cheaper_data');
        $data['phpner_popup_found_cheaper_data'] = $phpner_popup_found_cheaper_data;
        
        $data['heading_title']   = $this->language->get('heading_title');
        $data['button_close']    = $this->language->get('button_close');
        $data['button_send']     = $this->language->get('button_send');
        $data['enter_name']      = $this->language->get('enter_name');
        $data['enter_telephone'] = $this->language->get('enter_telephone');
        $data['enter_comment']   = $this->language->get('enter_comment');
        $data['enter_referer']   = $this->language->get('enter_referer');
        $data['enter_link']      = $this->language->get('enter_link');
        $data['text_select']     = $this->language->get('text_select');
        $data['text_loading']    = $this->language->get('text_loading');
        $data['name']            = ($this->customer->isLogged()) ? $this->customer->getFirstName() : '';
        $data['telephone']       = ($this->customer->isLogged()) ? $this->customer->getTelephone() : '';
        $data['comment']         = '';
        $data['link']            = '';
        $data['mask']            = ($phpner_popup_found_cheaper_data['mask']) ? $phpner_popup_found_cheaper_data['mask'] : '';
        
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
        
        $this->response->setOutput($this->load->view('extension/module/phpner_popup_found_cheaper', $data));
    }
    
    public function send() {
        $json = array();
        
        $this->language->load('extension/module/phpner_popup_found_cheaper');
        $this->load->model('extension/module/phpner_popup_found_cheaper');
        
        $phpner_popup_found_cheaper_data = (array) $this->config->get('phpner_popup_found_cheaper_data');
        
        if (isset($this->request->post['name'])) {
            if ((isset($phpner_popup_found_cheaper_data['name']) && $phpner_popup_found_cheaper_data['name'] == 2) && (utf8_strlen(trim($this->request->post['name'])) < 1) || (utf8_strlen(trim($this->request->post['name'])) > 32)) {
                $json['error']['field']['name'] = $this->language->get('error_name');
            }
        } else {
            if ((isset($phpner_popup_found_cheaper_data['name']) && $phpner_popup_found_cheaper_data['name'] == 2) && (utf8_strlen(trim($this->request->post['name'])) < 1) || (utf8_strlen(trim($this->request->post['name'])) > 32)) {
                $json['error']['field']['name'] = $this->language->get('error_name');
            }
        }
        
        if (isset($this->request->post['link'])) {
            if (isset($phpner_popup_found_cheaper_data['link']) && $phpner_popup_found_cheaper_data['link'] == 2) {
                if (empty($this->request->post['link'])) {
                    $json['error']['field']['link'] = $this->language->get('error_link');
                }
            }
        } else {
            if (isset($phpner_popup_found_cheaper_data['link']) && $phpner_popup_found_cheaper_data['link'] == 2) {
                if (empty($this->request->post['link'])) {
                    $json['error']['field']['link'] = $this->language->get('error_link');
                }
            }
        }
        
        if (isset($this->request->post['telephone'])) {
            if ((isset($phpner_popup_found_cheaper_data['telephone']) && $phpner_popup_found_cheaper_data['telephone'] == 2) && (utf8_strlen(str_replace(array(
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
        } else {
            if ((isset($phpner_popup_found_cheaper_data['telephone']) && $phpner_popup_found_cheaper_data['telephone'] == 2) && (utf8_strlen(str_replace(array(
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
            if ((isset($phpner_popup_found_cheaper_data['comment']) && $phpner_popup_found_cheaper_data['comment'] == 2) && (utf8_strlen($this->request->post['comment']) < 3) || (utf8_strlen($this->request->post['comment']) > 500)) {
                $json['error']['field']['comment'] = $this->language->get('error_comment');
            }
        } else {
            if ((isset($phpner_popup_found_cheaper_data['comment']) && $phpner_popup_found_cheaper_data['comment'] == 2) && (utf8_strlen($this->request->post['comment']) < 3) || (utf8_strlen($this->request->post['comment']) > 500)) {
                $json['error']['field']['comment'] = $this->language->get('error_comment');
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
            
            $post_data = $this->request->post;
            
            if (isset($post_data['name'])) {
                $data[] = array(
                    'name' => $this->language->get('enter_name'),
                    'value' => $post_data['name']
                );
            }
            
            if (isset($post_data['telephone'])) {
                $data[] = array(
                    'name' => $this->language->get('enter_telephone'),
                    'value' => $post_data['telephone']
                );
            }
            
            if (isset($post_data['comment'])) {
                $data[] = array(
                    'name' => $this->language->get('enter_comment'),
                    'value' => $post_data['comment']
                );
            }
            
            if (isset($post_data['pid'])) {
                $data[] = array(
                    'name' => $this->language->get('enter_referer'),
                    'value' => $post_data['pid']
                );
            }
            
            if (isset($post_data['link'])) {
                $data[] = array(
                    'name' => $this->language->get('enter_link'),
                    'value' => $post_data['link']
                );
            }
            
            $data_send = array(
                'info' => serialize($data)
            );
            
            $linkgood = $post_data['pid'] . "\r\n" . $post_data['mid'];
            
            $this->model_extension_module_phpner_popup_found_cheaper->addRequest($data_send, $linkgood);
            
            $json['output'] = $this->language->get('text_success_send');
            
            if ($phpner_popup_found_cheaper_data['notify_status']) {
                
                $html_data['date_added'] = date('m/d/Y h:i:s a', time());
                $html_data['logo']       = $this->config->get('config_url') . 'image/' . $this->config->get('config_logo');
                $html_data['store_name'] = $this->config->get('config_name');
                $html_data['store_url']  = $this->config->get('config_url');
                
                $html_data['text_info']       = $this->language->get('text_info');
                $html_data['text_date_added'] = $this->language->get('text_date_added');
                $html_data['data_info']       = $data;
                
                $html = $this->load->view('mail/phpner_popup_found_cheaper_mail', $html_data);
                
                if (version_compare(VERSION, '2.0.2', '<')) {
                    $mail = new Mail($this->config->get('config_mail'));
                } else {
                    $mail                = new Mail();
                    $mail->protocol      = $this->config->get('config_mail_protocol');
                    $mail->parameter     = $this->config->get('config_mail_parameter');
                    $mail->smtp_hostname = (version_compare(VERSION, '2.0.3', '<')) ? $this->config->get('config_mail_smtp_host') : $this->config->get('config_mail_smtp_hostname');
                    $mail->smtp_username = $this->config->get('config_mail_smtp_username');
                    $mail->smtp_password = html_entity_decode($this->config->get('config_mail_smtp_password'), ENT_QUOTES, 'UTF-8');
                    $mail->smtp_port     = $this->config->get('config_mail_smtp_port');
                    $mail->smtp_timeout  = $this->config->get('config_mail_smtp_timeout');
                }
                
                $mail->setFrom($this->config->get('config_email'));
                $mail->setSender($this->config->get('config_name'));
                $mail->setSubject($this->language->get('heading_title') . " -- " . $html_data['date_added']);
                $mail->setHtml($html);
                
                $emails = explode(',', $phpner_popup_found_cheaper_data['notify_email']);
                
                foreach ($emails as $email) {
                    if ($email && preg_match('/^[^\@]+@.*.[a-z]{2,15}$/i', $email)) {
                        $mail->setTo($email);
                        $mail->send();
                    }
                }
            }
        }
        
        $this->response->addHeader('Content-Type: application/json');
        $this->response->setOutput(json_encode($json));
    }
}