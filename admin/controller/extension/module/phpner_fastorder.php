<?php
class ControllerExtensionModulePhpnerFastorder extends Controller {
	private $error = array();

	public function index() {
		$this->load->language('extension/module/phpner_fastorder');

		$this->document->setTitle($this->language->get('heading_title'));

		$this->document->addScript('view/javascript/phpner_fastorder/jquery.minicolors.min.js');
		$this->document->addScript('view/javascript/phpner_fastorder/lib/toastr/toastr.min.js');
		$this->document->addScript('view/javascript/phpner_fastorder/lib/bootbox.min.js');
		$this->document->addStyle('view/javascript/phpner_fastorder/jquery.minicolors.css');
		$this->document->addStyle('view/javascript/phpner_fastorder/lib/toastr/toastr.min.css');
		
		$this->load->model('setting/setting');
		$this->load->model('localisation/country');


		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()) {
			$this->model_setting_setting->editSetting('phpner_fastorder_data', $this->request->post);

			$this->session->data['success'] = $this->language->get('text_success');

			$this->response->redirect($this->url->link('extension/extension', 'token=' . $this->session->data['token'] . '&type=module', true));
		}

		$data['heading_title'] = $this->language->get('heading_title');

		$data['text_edit'] = $this->language->get('text_edit');
		$data['text_enabled'] = $this->language->get('text_enabled');
		$data['text_disabled'] = $this->language->get('text_disabled');
		$data['text_select'] = $this->language->get('text_select');
		$data['text_none'] = $this->language->get('text_none');

		$data['tab_setting'] = $this->language->get('tab_setting');
		$data['tab_display'] = $this->language->get('tab_display');

		$data['entry_status'] = $this->language->get('entry_status');
		$data['entry_fax'] = $this->language->get('entry_fax');
		$data['entry_company'] = $this->language->get('entry_company');
		$data['entry_address_1'] = $this->language->get('entry_address_1');
		$data['entry_address_2'] = $this->language->get('entry_address_2');
		$data['entry_postcode'] = $this->language->get('entry_postcode');
		$data['entry_comment'] = $this->language->get('entry_comment');
		$data['entry_lastname'] = $this->language->get('entry_lastname');
		$data['entry_customer_groups'] = $this->language->get('entry_customer_groups');
		$data['entry_backgorund_color_block_border'] = $this->language->get('entry_backgorund_color_block_border');
		$data['entry_backgorund_color_block_heading'] = $this->language->get('entry_backgorund_color_block_heading');
		$data['entry_text_color_block_heading'] = $this->language->get('entry_text_color_block_heading');
		$data['entry_backgorund_color_block_body'] = $this->language->get('entry_backgorund_color_block_body');
		$data['entry_text_color_block_body'] = $this->language->get('entry_text_color_block_body');
		$data['entry_backgorund_color_remove_button'] = $this->language->get('entry_backgorund_color_remove_button');
		$data['entry_text_color_remove_button'] = $this->language->get('entry_text_color_remove_button');
		$data['entry_backgorund_color_quantity_button'] = $this->language->get('entry_backgorund_color_quantity_button');
		$data['entry_text_color_quantity_button'] = $this->language->get('entry_text_color_quantity_button');
		$data['entry_backgorund_color_checkout_button'] = $this->language->get('entry_backgorund_color_checkout_button');
		$data['entry_text_color_checkout_button'] = $this->language->get('entry_text_color_checkout_button');
		$data['entry_mask'] = $this->language->get('entry_mask');
		$data['entry_mask_info'] = $this->language->get('entry_mask_info');

		$data['entry_city'] = $this->language->get('entry_city');
		$data['entry_country_and_region'] = $this->language->get('entry_country_and_region');
		$data['entry_default_country'] = $this->language->get('entry_default_country');
		$data['entry_default_region'] = $this->language->get('entry_default_region');
		$data['entry_default_city'] = $this->language->get('entry_default_city');
		$data['entry_registration'] = $this->language->get('entry_registration');
		
		/* 3359 */
		$data['tab_filds'] = $this->language->get('tab_filds');
		$data['tab_cart'] = $this->language->get('tab_cart');
		$data['entry_email'] = $this->language->get('entry_email');
		$data['entry_order_in_popup'] = $this->language->get('entry_order_in_popup');
		$data['entry_minimum_order'] = $this->language->get('entry_minimum_order');
		$data['entry_max_order'] = $this->language->get('entry_max_order');
		$data['entry_cart_weight'] = $this->language->get('entry_cart_weight');
		$data['text_enabled_required'] = $this->language->get('text_enabled_required');
		$data['text_fields_settings'] = $this->language->get('text_fields_settings');
		$data['text_cart_settings'] = $this->language->get('text_cart_settings');
		$data['entry_notify_email'] = $this->language->get('entry_notify_email');
		$data['entry_is_shipping_dop'] = $this->language->get('entry_is_shipping_dop');
		$data['entry_cart_rewards'] = $this->language->get('entry_cart_rewards');
		$data['entry_model_view'] = $this->language->get('entry_model_view');
		$data['text_dop_filds'] = $this->language->get('text_dop_filds');
		$data['entry_cart_view_is'] = $this->language->get('entry_cart_view_is');
		$data['entry_image_view_is'] = $this->language->get('entry_image_view_is');
		$data['entry_name_view'] = $this->language->get('entry_name_view');
		$data['entry_quantity_view'] = $this->language->get('entry_quantity_view');
		$data['entry_price_view'] = $this->language->get('entry_price_view');
		$data['entry_total_view'] = $this->language->get('entry_total_view');
		$data['entry_cart_coupon'] = $this->language->get('entry_cart_coupon');
		$data['entry_cart_voucher'] = $this->language->get('entry_cart_voucher');
		
		$data['button_add'] = $this->language->get('button_add');
		$data['button_edit'] = $this->language->get('button_edit');
		$data['button_delete'] = $this->language->get('button_delete');
		$data['button_create'] = $this->language->get('button_create');
		
		$data['column_name'] = $this->language->get('column_name');
		$data['column_location'] = $this->language->get('column_location');
		$data['column_type'] = $this->language->get('column_type');
		$data['column_status'] = $this->language->get('column_status');
		$data['column_sort_order'] = $this->language->get('column_sort_order');
		$data['column_action'] = $this->language->get('column_action');
		$data['text_no_results'] = $this->language->get('text_no_results');
		
		/* DOP FIELDS*/
		$data['text_choose'] = $this->language->get('text_choose');
		$data['text_select'] = $this->language->get('text_select');
		$data['text_radio'] = $this->language->get('text_radio');
		$data['text_checkbox'] = $this->language->get('text_checkbox');
		$data['text_input'] = $this->language->get('text_input');
		$data['text_text'] = $this->language->get('text_text');
		$data['text_textarea'] = $this->language->get('text_textarea');
		$data['text_file'] = $this->language->get('text_file');
		$data['text_date'] = $this->language->get('text_date');
		$data['text_datetime'] = $this->language->get('text_datetime');
		$data['text_time'] = $this->language->get('text_time');
		$data['text_account'] = $this->language->get('text_account');
		$data['text_address'] = $this->language->get('text_address');
		$data['text_enabled'] = $this->language->get('text_enabled');
		$data['text_disabled'] = $this->language->get('text_disabled');
		$data['text_regex'] = $this->language->get('text_regex');
		
		$data['help_regex'] = $this->language->get('help_regex');
		$data['help_sort_order'] = $this->language->get('help_sort_order');
		
		$data['entry_name'] = $this->language->get('entry_name');
		$data['entry_location'] = $this->language->get('entry_location');
		$data['entry_type'] = $this->language->get('entry_type');
		$data['entry_value'] = $this->language->get('entry_value');
		$data['entry_validation'] = $this->language->get('entry_validation');
		$data['entry_custom_value'] = $this->language->get('entry_custom_value');
		$data['entry_customer_group'] = $this->language->get('entry_customer_group');
		$data['entry_required'] = $this->language->get('entry_required');
		$data['entry_status'] = $this->language->get('entry_status');
		$data['entry_sort_order'] = $this->language->get('entry_sort_order');
		
		$data['button_custom_field_value_add'] = $this->language->get('button_custom_field_value_add');
		
		$this->load->model('localisation/language');

		$data['languages'] = $this->model_localisation_language->getLanguages();
		
		$this->load->model('customer/customer_group');

		$data['customer_groups'] = $this->model_customer_customer_group->getCustomerGroups();
		
		/* 3359 */
		
		$data['button_save'] = $this->language->get('button_save');
		$data['button_cancel'] = $this->language->get('button_cancel');

		$data['token'] = $this->session->data['token'];
		
		/* 3359 */
		if (isset($this->error['notify_email'])) {
			$data['error_notify_email'] = $this->error['notify_email'];
		} else {
			$data['error_notify_email'] = '';
		}
		/* 3359 */
		
		if (isset($this->error['warning'])) {
			$data['error_warning'] = $this->error['warning'];
		} else {
			$data['error_warning'] = '';
		}

		if (isset($this->error['default_country'])) {
			$data['error_default_country'] = $this->error['default_country'];
		} else {
			$data['error_default_country'] = '';
		}

		if (isset($this->error['default_region'])) {
			$data['error_default_region'] = $this->error['default_region'];
		} else {
			$data['error_default_region'] = '';
		}

		if (isset($this->error['default_city'])) {
			$data['error_default_city'] = $this->error['default_city'];
		} else {
			$data['error_default_city'] = '';
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
			'href' => $this->url->link('extension/module/phpner_fastorder', 'token=' . $this->session->data['token'], true)
		);

		$data['action'] = $this->url->link('extension/module/phpner_fastorder', 'token=' . $this->session->data['token'], true);

		$data['cancel'] = $this->url->link('extension/extension', 'token=' . $this->session->data['token'] . '&type=module', true);

		if (isset($this->request->post['phpner_fastorder_data'])) {
			$data['phpner_fastorder_data'] = $this->request->post['phpner_fastorder_data'];
		} else {
			$data['phpner_fastorder_data'] = $this->config->get('phpner_fastorder_data');
		}

		$data['countries'] = array();

		$countries = $this->model_localisation_country->getCountries();

		foreach ($countries as $country) {
			$data['countries'][] = array(
				'country_id' => $country['country_id'],
				'name'       => $country['name'] . (($country['country_id'] == $this->config->get('config_country_id')) ? $this->language->get('text_default') : null)
			);
		}
		
		/*3359 Dop Fields*/
		$this->load->model('customer/custom_field');
		$data['custom_fields'] = array();

		$filter_data = array(
			'start' => 0,
			'limit' => 1000
		);

		$custom_field_total = $this->model_customer_custom_field->getTotalCustomFields();

		$results = $this->model_customer_custom_field->getCustomFields($filter_data);

		foreach ($results as $result) {
			$type = '';

			switch ($result['type']) {
				case 'select':
					$type = $this->language->get('text_select');
					break;
				case 'radio':
					$type = $this->language->get('text_radio');
					break;
				case 'checkbox':
					$type = $this->language->get('text_checkbox');
					break;
				case 'input':
					$type = $this->language->get('text_input');
					break;
				case 'text':
					$type = $this->language->get('text_text');
					break;
				case 'textarea':
					$type = $this->language->get('text_textarea');
					break;
				case 'file':
					$type = $this->language->get('text_file');
					break;
				case 'date':
					$type = $this->language->get('text_date');
					break;
				case 'datetime':
					$type = $this->language->get('text_datetime');
					break;
				case 'time':
					$type = $this->language->get('text_time');
					break;
			}

			$data['custom_fields'][] = array(
				'custom_field_id' => $result['custom_field_id'],
				'name'            => $result['name'],
				'location'        => $this->language->get('text_' . $result['location']),
				'type'            => $type,
				'status'          => $result['status'],
				'sort_order'      => $result['sort_order']
			);
		}
		
		/*3359*/
		
		$data['header'] = $this->load->controller('common/header');
		$data['column_left'] = $this->load->controller('common/column_left');
		$data['footer'] = $this->load->controller('common/footer');

		$this->response->setOutput($this->load->view('extension/module/phpner_fastorder.tpl', $data));
	}
	
	public function addCustomerField() {
		$this->load->language('extension/module/phpner_fastorder');
		$this->load->model('customer/custom_field');
		
		$json = array();
		
		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validateCustomerForm()) {
			$this->model_customer_custom_field->addCustomField($this->request->post);

			$json['success']['text'] = $this->language->get('text_success_dop');
			$json['success']['name'] = $this->request->post['custom_field_description'][(int)$this->config->get('config_language_id')]['name'];
			$json['success']['location'] = $this->language->get('text_' . $this->request->post['location']);
			$json['success']['sort_order'] = $this->request->post['sort_order'] ? $this->request->post['sort_order'] : 0;
			
			$type = '';
			
			switch ($this->request->post['type']) {
				case 'select':
					$type = $this->language->get('text_select');
					break;
				case 'radio':
					$type = $this->language->get('text_radio');
					break;
				case 'checkbox':
					$type = $this->language->get('text_checkbox');
					break;
				case 'input':
					$type = $this->language->get('text_input');
					break;
				case 'text':
					$type = $this->language->get('text_text');
					break;
				case 'textarea':
					$type = $this->language->get('text_textarea');
					break;
				case 'file':
					$type = $this->language->get('text_file');
					break;
				case 'date':
					$type = $this->language->get('text_date');
					break;
				case 'datetime':
					$type = $this->language->get('text_datetime');
					break;
				case 'time':
					$type = $this->language->get('text_time');
					break;
			}
			
			$json['success']['type'] = $type;
		} else {
			$json['error'] = $this->error;
		}
		
		$this->response->addHeader('Content-Type: application/json');
		$this->response->setOutput(json_encode($json));
	}
	
	private function validateCustomerForm() {
		if (!$this->user->hasPermission('modify', 'customer/custom_field')) {
			$this->error['warning'] = $this->language->get('error_permission');
		}

		foreach ($this->request->post['custom_field_description'] as $language_id => $value) {
			if ((utf8_strlen($value['name']) < 1) || (utf8_strlen($value['name']) > 128)) {
				$this->error['name'][$language_id] = $this->language->get('error_name');
			}
		}

		if (($this->request->post['type'] == 'select' || $this->request->post['type'] == 'radio' || $this->request->post['type'] == 'checkbox')) {
			if (!isset($this->request->post['custom_field_value'])) {
				$this->error['warning'] = $this->language->get('error_type');
			}

			if (isset($this->request->post['custom_field_value'])) {
				foreach ($this->request->post['custom_field_value'] as $custom_field_value_id => $custom_field_value) {
					foreach ($custom_field_value['custom_field_value_description'] as $language_id => $custom_field_value_description) {
						if ((utf8_strlen($custom_field_value_description['name']) < 1) || (utf8_strlen($custom_field_value_description['name']) > 128)) {
							$this->error['custom_field_value'][$custom_field_value_id][$language_id] = $this->language->get('error_custom_value');
						}
					}
				}
			}
		}

		return !$this->error;
	}
	
	public function install() {   
		$this->load->language('extension/module/phpner_fastorder');

		$this->load->model('extension/extension');
		$this->load->model('setting/setting');
		$this->load->model('user/user_group');

		$this->model_user_user_group->addPermission($this->user->getId(), 'access', 'extension/module/phpner_fastorder');
		$this->model_user_user_group->addPermission($this->user->getId(), 'modify', 'extension/module/phpner_fastorder');

		$this->model_setting_setting->editSetting('phpner_fastorder_data', array(
			'phpner_fastorder_data' => array(
				'status'                           	=> '1',
				'fax'                              	=> '1',
				'company'                          	=> '1',
				'address_1'                        	=> '1',
				'address_2'                        	=> '1',
				'postcode'                         	=> '0',
				'city'							 	=> '1',
				'comment'                          	=> '1',
				'country_and_region'				=> '1',
				'registration'						=> '1',
				'lastname'                         	=> '1',
				/* 3359 */
				'email'								=> '2',
				'minimum_order'						=> '',
				'max_order'							=> '',
				'order_in_popup'					=> '0',
				'model_view'						=> '0',
				'cart_weight'						=> '0',
				'cart_rewards'						=> '0',
				'is_shipping_dop'					=> '0',
				'cart_view_is'						=> '1',
				'image_view_is'						=> '1',
				'name_view'							=> '1',
				'quantity_view'						=> '1',
				'price_view'						=> '1',
				'total_view'						=> '1',
				'cart_coupon'						=> '1',
				'cart_voucher'						=> '0',
				'notify_email' 	  				    => $this->config->get('config_email'),
				/* 3359 */
				'customer_groups'					=> '1',
				'default_country'					=> $this->config->get('config_country_id'),
				'default_region'					=> $this->config->get('config_zone_id'),
				'default_city'						=> '',
				'backgorund_color_block_border'    => '',
				'backgorund_color_block_heading'   => '',
				'text_color_block_heading'         => '',
				'backgorund_color_block_body'      => '',
				'text_color_block_body'            => '',
				'backgorund_color_remove_button'   => '',
				'text_color_remove_button'         => '',
				'backgorund_color_quantity_button' => '',
				'text_color_quantity_button'       => '',
				'backgorund_color_checkout_button' => '',
				'text_color_checkout_button'       => '',
				'mask'								=> '(999) 999-99-99'
      )
   	));        

    if (!in_array('phpner_fastorder', $this->model_extension_extension->getInstalled('module'))) {
      $this->model_extension_extension->install('module', 'phpner_fastorder');
    }
    
    $this->session->data['success'] = $this->language->get('text_success_install');
  }

  public function uninstall() {
    $this->load->model('extension/extension');
    $this->load->model('setting/setting');

    $this->model_extension_extension->uninstall('module', 'phpner_fastorder');
    $this->model_setting_setting->deleteSetting('phpner_fastorder_data');
  }

  public function country() {
		$json = array();

		$this->load->model('localisation/country');

		$country_info = $this->model_localisation_country->getCountry($this->request->get['country_id']);

		if ($country_info) {
			$this->load->model('localisation/zone');

			$json = array(
				'country_id'        => $country_info['country_id'],
				'name'              => $country_info['name'],
				'iso_code_2'        => $country_info['iso_code_2'],
				'iso_code_3'        => $country_info['iso_code_3'],
				'address_format'    => $country_info['address_format'],
				'postcode_required' => $country_info['postcode_required'],
				'zone'              => $this->model_localisation_zone->getZonesByCountryId($this->request->get['country_id']),
				'status'            => $country_info['status']
			);
		}

		$this->response->addHeader('Content-Type: application/json');
		$this->response->setOutput(json_encode($json));
	}	

	protected function validate() {
		if (!$this->user->hasPermission('modify', 'extension/module/phpner_fastorder')) {
			$this->error['warning'] = $this->language->get('error_permission');
		}

		foreach ($this->request->post['phpner_fastorder_data'] as $key => $field) {
      if (empty($field) && $key == "default_country") {
        $this->error['default_country'] = $this->language->get('error_default_country');
      }
		/* 3359 */
		if (empty($field) && $key == "notify_email") {
			$this->error['notify_email'] = $this->language->get('error_notify_email');
		}
		/* 3359 */
      if (empty($field) && $key == "default_region") {
        $this->error['default_region'] = $this->language->get('error_default_region');
      }

      if (empty($field) && $key == "default_city") {
        $this->error['default_city'] = $this->language->get('error_default_city');
      }
    }

		return !$this->error;
	}
}