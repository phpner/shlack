<?php
/**************************************************************/
/*	@copyright	Phpner 2019							  */
/*	@support	http://phpner.ru					  */
/*	@license	LICENSE.txt									  */
/**************************************************************/

class ControllerExtensionModulePhpnerAdvancedOptionsSettings extends Controller {
    private $error = array();
    
    public function index() {
        $this->load->language('extension/module/phpner_advanced_options_settings');
        
        $this->document->setTitle($this->language->get('heading_title'));
        
        $this->load->model('setting/setting');
        
        $data['token'] = $this->session->data['token'];
        
        if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()) {
            $this->model_setting_setting->editSetting('phpner_advanced_options_settings', $this->request->post);
            
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
        $data['text_options']      = $this->language->get('text_options');
        $data['text_select_all']   = $this->language->get('text_select_all');
        $data['text_unselect_all'] = $this->language->get('text_unselect_all');
        
        $data['tab_setting'] = $this->language->get('tab_setting');
        
        $data['entry_status']          = $this->language->get('entry_status');
        $data['entry_quantity_status'] = $this->language->get('entry_quantity_status');
        ;
        $data['entry_allow_zoom']              = $this->language->get('entry_allow_zoom');
        $data['entry_allow_sku']               = $this->language->get('entry_allow_sku');
        $data['entry_allow_model']             = $this->language->get('entry_allow_model');
        $data['entry_allow_autoselect_option'] = $this->language->get('entry_allow_autoselect_option');
        $data['entry_allow_column_q_image']    = $this->language->get('entry_allow_column_q_image');
        $data['entry_allow_column_q_sku']      = $this->language->get('entry_allow_column_q_sku');
        $data['entry_allow_column_q_model']    = $this->language->get('entry_allow_column_q_model');
        $data['entry_option']                  = $this->language->get('entry_option');
        
        $data['help_option'] = $this->language->get('help_option');
        
        $data['button_save']   = $this->language->get('button_save');
        $data['button_cancel'] = $this->language->get('button_cancel');
        
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
            'href' => $this->url->link('extension/module/phpner_advanced_options_settings', 'token=' . $this->session->data['token'], true)
        );
        
        $data['action'] = $this->url->link('extension/module/phpner_advanced_options_settings', 'token=' . $this->session->data['token'], true);
        
        $data['cancel'] = $this->url->link('extension/extension', 'token=' . $this->session->data['token'] . '&type=module', true);
        
        if (isset($this->request->post['phpner_advanced_options_settings_data'])) {
            $data['phpner_advanced_options_settings_data'] = $this->request->post['phpner_advanced_options_settings_data'];
        } else {
            $data['phpner_advanced_options_settings_data'] = $this->config->get('phpner_advanced_options_settings_data');
        }
        
        $this->load->model('catalog/option');
        $data['options'] = array();
        
        if (isset($data['phpner_advanced_options_settings_data']['allowed_options']) && $data['phpner_advanced_options_settings_data']['allowed_options']) {
            $options = $data['phpner_advanced_options_settings_data']['allowed_options'];
        } else {
            $options = array();
        }
        
        if ($options) {
            foreach ($options as $option_id) {
                $option_info = $this->model_catalog_option->getOption($option_id);
                
                if ($option_info) {
                    $data['options'][] = array(
                        'option_id' => $option_info['option_id'],
                        'name' => $option_info['name']
                    );
                }
            }
        }
        
        $data['header']      = $this->load->controller('common/header');
        $data['column_left'] = $this->load->controller('common/column_left');
        $data['footer']      = $this->load->controller('common/footer');
        
        $this->response->setOutput($this->load->view('extension/module/phpner_advanced_options_settings.tpl', $data));
    }
    
    public function install() {
        $this->load->language('extension/module/phpner_advanced_options_settings');
        
        $this->load->model('extension/module/phpner_advanced_options_settings');
        $this->load->model('extension/extension');
        $this->load->model('setting/setting');
        $this->load->model('user/user_group');
        
        $this->model_user_user_group->addPermission($this->user->getId(), 'access', 'extension/module/phpner_advanced_options_settings');
        $this->model_user_user_group->addPermission($this->user->getId(), 'modify', 'extension/module/phpner_advanced_options_settings');
        
        $this->model_setting_setting->editSetting('phpner_advanced_options_settings', array(
            'phpner_advanced_options_settings_data' => array(
                'status' => '1',
                'quantity_status' => '1',
                'allow_zoom' => '1',
                'allow_sku' => '1',
                'allow_model' => '1',
                'allow_autoselect_option' => '1',
                'allowed_options' => array(),
                'allow_column_q_image' => '1',
                'allow_column_q_sku' => '1',
                'allow_column_q_model' => '1'
            )
        ));
        
        if (!in_array('phpner_advanced_options_settings', $this->model_extension_extension->getInstalled('module'))) {
            $this->model_extension_extension->install('module', 'phpner_advanced_options_settings');
        }
        
        $this->model_extension_module_phpner_advanced_options_settings->makeDB();
        
        $this->session->data['success'] = $this->language->get('text_success_install');
    }
    
    public function uninstall() {
        $this->load->model('extension/extension');
        $this->load->model('setting/setting');
        $this->load->model('extension/module/phpner_advanced_options_settings');
        
        $this->model_extension_module_phpner_advanced_options_settings->removeDB();
        $this->model_extension_extension->uninstall('module', 'phpner_advanced_options_settings');
        $this->model_setting_setting->deleteSetting('phpner_advanced_options_settings_data');
    }
    
    protected function validate() {
        if (!$this->user->hasPermission('modify', 'extension/module/phpner_advanced_options_settings')) {
            $this->error['warning'] = $this->language->get('error_permission');
        }
        
        return !$this->error;
    }
    
    public function autocomplete() {
        $json = array();
        
        if (isset($this->request->get['filter_name'])) {
            $this->load->model('catalog/option');
            
            $filter_data = array(
                'filter_name' => $this->request->get['filter_name'],
                'start' => 0,
                'limit' => 15
            );
            
            $options = $this->model_catalog_option->getOptions($filter_data);
            
            foreach ($options as $option) {
                $json[] = array(
                    'option_id' => $option['option_id'],
                    'name' => strip_tags(html_entity_decode($option['name'], ENT_QUOTES, 'UTF-8'))
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