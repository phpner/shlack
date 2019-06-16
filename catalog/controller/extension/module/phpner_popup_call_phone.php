<?php
/**************************************************************/
/*	@copyright	Phpner 2019							  */
/*	@support	http://phpner.ru					  */
/*	@license	LICENSE.txt									  */
/**************************************************************/

class ControllerExtensionModulePhpnerPopupCallPhone extends Controller {
    public function index() {
        $data = array();
        
        $this->load->model('catalog/product');
        $this->load->language('extension/module/phpner_popup_call_phone');
        
        $data['phpner_store_data'] = $phpner_data = $this->config->get('phpner_store_data');
        
        $phpner_popup_call_phone_data         = (array) $this->config->get('phpner_popup_call_phone_data');
        $data['phpner_popup_call_phone_data'] = $phpner_popup_call_phone_data;
        
        $data['heading_title']   = $this->language->get('heading_title');
        $data['button_close']    = $this->language->get('button_close');
        $data['button_send']     = $this->language->get('button_send');
        $data['enter_name']      = $this->language->get('enter_name');
        $data['enter_telephone'] = $this->language->get('enter_telephone');
        $data['enter_comment']   = $this->language->get('enter_comment');
        $data['enter_time']      = $this->language->get('enter_time');
        $data['text_select']     = $this->language->get('text_select');
        $data['text_loading']    = $this->language->get('text_loading');
        
        $data['name']      = ($this->customer->isLogged()) ? $this->customer->getFirstName() : '';
        $data['telephone'] = ($this->customer->isLogged()) ? $this->customer->getTelephone() : '';
        
        if (isset($phpner_data['cont_phones']) && !empty($phpner_data['cont_phones'])) {
            $data['phpner_store_cont_phones'] = array_values(array_filter(explode(PHP_EOL, $phpner_data['cont_phones'])));
        } else {
            $data['phpner_store_cont_phones'] = false;
        }
        
        $data['comment'] = '';
        $data['time']    = '';
        $data['mask']    = ($phpner_popup_call_phone_data['mask']) ? $phpner_popup_call_phone_data['mask'] : '';
        
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
        
        $this->response->setOutput($this->load->view('extension/module/phpner_popup_call_phone', $data));
    }
    
    public function send() {
        $json = array();
        
        $this->language->load('extension/module/phpner_popup_call_phone');
        
        $this->load->model('extension/module/phpner_popup_call_phone');
        
        $phpner_popup_call_phone_data = (array) $this->config->get('phpner_popup_call_phone_data');
        
        if (isset($this->request->post['name'])) {
            if ((isset($phpner_popup_call_phone_data['name']) && $phpner_popup_call_phone_data['name'] == 2) && (utf8_strlen(trim($this->request->post['name'])) < 1) || (utf8_strlen(trim($this->request->post['name'])) > 32)) {
                $json['error']['field']['name'] = $this->language->get('error_name');
            }
        } else {
            if ((isset($phpner_popup_call_phone_data['name']) && $phpner_popup_call_phone_data['name'] == 2) && (utf8_strlen(trim($this->request->post['name'])) < 1) || (utf8_strlen(trim($this->request->post['name'])) > 32)) {
                $json['error']['field']['name'] = $this->language->get('error_name');
            }
        }
        
        if (isset($this->request->post['time'])) {
            if (isset($phpner_popup_call_phone_data['time']) && $phpner_popup_call_phone_data['time'] == 2) {
                if (empty($this->request->post['time'])) {
                    $json['error']['field']['time'] = $this->language->get('error_time');
                }
            }
        } else {
            if (isset($phpner_popup_call_phone_data['time']) && $phpner_popup_call_phone_data['time'] == 2) {
                if (empty($this->request->post['time'])) {
                    $json['error']['field']['time'] = $this->language->get('error_time');
                }
            }
        }
        
        if (isset($this->request->post['telephone'])) {
            if ((isset($phpner_popup_call_phone_data['telephone']) && $phpner_popup_call_phone_data['telephone'] == 2) && (utf8_strlen(str_replace(array(
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
            if ((isset($phpner_popup_call_phone_data['telephone']) && $phpner_popup_call_phone_data['telephone'] == 2) && (utf8_strlen(str_replace(array(
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
            if ((isset($phpner_popup_call_phone_data['comment']) && $phpner_popup_call_phone_data['comment'] == 2) && (utf8_strlen($this->request->post['comment']) < 3) || (utf8_strlen($this->request->post['comment']) > 500)) {
                $json['error']['field']['comment'] = $this->language->get('error_comment');
            }
        } else {
			if (isset($phpner_popup_call_phone_data['comment']) && $phpner_popup_call_phone_data['comment'] == 2) {
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
        
        $data = array();
        
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
            
            if (isset($post_data['time'])) {
                $data[] = array(
                    'name' => $this->language->get('enter_time'),
                    'value' => $post_data['time']
                );
            }
            
            $data_send = array(
                'info' => serialize($data)
            );
            
            $this->model_extension_module_phpner_popup_call_phone->addRequest($data_send);
            
            $json['output'] = $this->language->get('text_success_send');
            
            if ($phpner_popup_call_phone_data['notify_status']) {
                $html_data['date_added']      = date('d.m.Y H:i:s', time());
                $html_data['logo']            = $this->config->get('config_url') . 'image/' . $this->config->get('config_logo');
                $html_data['store_name']      = $this->config->get('config_name');
                $html_data['store_url']       = $this->config->get('config_url');
                $html_data['text_info']       = $this->language->get('text_info');
                $html_data['text_date_added'] = $this->language->get('text_date_added');
                $html_data['data_info']       = $data;
                
                $html = $this->load->view('mail/phpner_popup_call_phone_mail', $html_data);
                
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
                
                $emails = explode(',', $phpner_popup_call_phone_data['notify_email']);
                
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