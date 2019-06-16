<?php
/**************************************************************/
/*	@copyright	Phpner 2019							  */
/*	@support	http://phpner.ru					  */
/*	@license	LICENSE.txt									  */
/**************************************************************/

class ControllerExtensionModulePhpnerAdvancedAttributesSettings extends Controller {
    private $error = array();
    
    public function index() {
        $this->load->language('extension/module/phpner_advanced_attributes_settings');
        
        $this->document->setTitle($this->language->get('heading_title'));
        
        $this->load->model('setting/setting');
        
        $data['token'] = $this->session->data['token'];
        
        if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()) {
            $this->model_setting_setting->editSetting('phpner_advanced_attributes_settings', $this->request->post);
            
            $this->session->data['success'] = $this->language->get('text_success');
            
            $this->response->redirect($this->url->link('extension/extension', 'token=' . $this->session->data['token'] . '&type=module', true));
        }
        
        $data['heading_title'] = $this->language->get('heading_title');
        
        $data['text_edit']         = $this->language->get('text_edit');
        $data['text_enabled']      = $this->language->get('text_enabled');
        $data['text_disabled']     = $this->language->get('text_disabled');
        $data['text_confirm']      = $this->language->get('text_confirm');
        $data['text_yes']          = $this->language->get('text_yes');
        $data['text_no']           = $this->language->get('text_no');
        $data['text_attributes']   = $this->language->get('text_attributes');
        $data['text_select_all']   = $this->language->get('text_select_all');
        $data['text_unselect_all'] = $this->language->get('text_unselect_all');
        
        $data['tab_setting'] = $this->language->get('tab_setting');
        
        $data['entry_status']    = $this->language->get('entry_status');
        $data['entry_attribute'] = $this->language->get('entry_attribute');
        
        $data['help_attribute'] = $this->language->get('help_attribute');
        
        $data['button_save']   = $this->language->get('button_save');
        $data['button_cancel'] = $this->language->get('button_cancel');
        
        $data['token'] = $this->session->data['token'];
        
        if (isset($this->error['warning'])) {
            $data['error_warning'] = $this->error['warning'];
        } else {
            $data['error_warning'] = '';
        }
        
        if (isset($this->session->data['success'])) {
            $data['success'] = $this->session->data['success'];
            
            unset($this->session->data['success']);
        } else {
            $data['success'] = '';
        }
        
        $data['breadcrumbs'] = array();
        
        $data['breadcrumbs'][] = array(
            'text' => $this->language->get('text_home'),
            'href' => $this->url->link('common/dashboard', 'token=' . $this->session->data['token'], true)
        );
        
        $data['breadcrumbs'][] = array(
            'text' => $this->language->get('text_module'),
            'href' => $this->url->link('extension/extension', 'token=' . $this->session->data['token'] . '&type=module', true)
        );
        
        $data['breadcrumbs'][] = array(
            'text' => $this->language->get('heading_title'),
            'href' => $this->url->link('extension/module/phpner_advanced_attributes_settings', 'token=' . $this->session->data['token'], true)
        );
        
        $data['action'] = $this->url->link('extension/module/phpner_advanced_attributes_settings', 'token=' . $this->session->data['token'], true);
        
        $data['cancel'] = $this->url->link('extension/extension', 'token=' . $this->session->data['token'] . '&type=module', true);
        
        if (isset($this->request->post['phpner_advanced_attributes_settings_data'])) {
            $data['phpner_advanced_attributes_settings_data'] = $this->request->post['phpner_advanced_attributes_settings_data'];
        } else {
            $data['phpner_advanced_attributes_settings_data'] = $this->config->get('phpner_advanced_attributes_settings_data');
        }
        
        $this->load->model('catalog/attribute');
        
        $data['attributes'] = array();
        
        if (isset($data['phpner_advanced_attributes_settings_data']['allowed_attributes']) && $data['phpner_advanced_attributes_settings_data']['allowed_attributes']) {
            $attributes = $data['phpner_advanced_attributes_settings_data']['allowed_attributes'];
        } else {
            $attributes = array();
        }
        
        if ($attributes) {
            foreach ($attributes as $attribute_id) {
                $attribute_info = $this->model_catalog_attribute->getAttribute($attribute_id);
                
                if ($attribute_info) {
                    $data['attributes'][] = array(
                        'attribute_id' => $attribute_info['attribute_id'],
                        'name' => $attribute_info['name']
                    );
                }
            }
        }
        
        $data['header']      = $this->load->controller('common/header');
        $data['column_left'] = $this->load->controller('common/column_left');
        $data['footer']      = $this->load->controller('common/footer');
        
        $this->response->setOutput($this->load->view('extension/module/phpner_advanced_attributes_settings.tpl', $data));
    }
    
    public function install() {
        $this->load->language('extension/module/phpner_advanced_attributes_settings');
        
        $this->load->model('extension/extension');
        $this->load->model('setting/setting');
        $this->load->model('user/user_group');
        
        $this->model_user_user_group->addPermission($this->user->getId(), 'access', 'extension/module/phpner_advanced_attributes_settings');
        $this->model_user_user_group->addPermission($this->user->getId(), 'modify', 'extension/module/phpner_advanced_attributes_settings');
        
        $this->model_setting_setting->editSetting('phpner_advanced_attributes_settings', array(
            'phpner_advanced_attributes_settings_data' => array(
                'status' => '1',
                'allowed_attributes' => array()
            )
        ));
        
        if (!in_array('phpner_advanced_attributes_settings', $this->model_extension_extension->getInstalled('module'))) {
            $this->model_extension_extension->install('module', 'phpner_advanced_attributes_settings');
        }
        
        $this->session->data['success'] = $this->language->get('text_success_install');
    }
    
    public function uninstall() {
        $this->load->model('extension/extension');
        $this->load->model('setting/setting');
        
        $this->model_extension_extension->uninstall('module', 'phpner_advanced_attributes_settings');
        $this->model_setting_setting->deleteSetting('phpner_advanced_attributes_settings_data');
    }
    
    protected function validate() {
        if (!$this->user->hasPermission('modify', 'extension/module/phpner_advanced_attributes_settings')) {
            $this->error['warning'] = $this->language->get('error_permission');
        }
        
        return !$this->error;
    }
    
    public function autocomplete() {
        $json = array();
        
        if (isset($this->request->get['filter_name'])) {
            $this->load->model('catalog/attribute');
            
            $filter_data = array(
                'filter_name' => $this->request->get['filter_name'],
                'start' => 0,
                'limit' => 15
            );
            
            $results = $this->model_catalog_attribute->getAttributes($filter_data);
            
            foreach ($results as $result) {
                $json[] = array(
                    'attribute_id' => $result['attribute_id'],
                    'name' => strip_tags(html_entity_decode($result['name'], ENT_QUOTES, 'UTF-8'))
                );
            }
        }
        
        $sort_order = array();
        
        foreach ($json as $key => $value) {
            $sort_order[$key] = $value['name'];
        }
        
        array_multisort($sort_order, SORT_ASC, $json);
        
        $this->response->addHeader('Content-Type: application/json');
        $this->response->setOutput(json_encode($json));
    }
}