<?php
class ControllerCommonFooter extends Controller {
	public function index() {

        // subscribe start
        $data['phpner_popup_subscribe_form_data'] = $this->config->get('phpner_popup_subscribe_form_data');
        $data['phpner_popup_subscribe'] = $this->load->controller('extension/module/phpner_static_subscribe');
        // subscribe end
        

        // popup_product_options start
        $data['phpner_popup_product_options_data'] = $this->config->get('phpner_popup_product_options_data');
        // popup_product_options end
      

        // phpner_popup_call_phone start
        $data['phpner_popup_call_phone_data'] = $this->config->get('phpner_popup_call_phone_data');
        $data['popup_call_phone_text'] = $this->language->load('extension/module/phpner_popup_call_phone');
        // phpner_popup_call_phone end
      
		//loan
		$this->load->model('extension/module');
		$select_module = $this->model_extension_module->getModule(63);
	if (isset($select_module['module_description'][$this->config->get('config_language_id')])) {
			$data['module_title'] = html_entity_decode($select_module['module_description'][$this->config->get('config_language_id')]['title'], ENT_QUOTES, 'UTF-8');
			$data['module_description'] = html_entity_decode($select_module['module_description'][$this->config->get('config_language_id')]['description'], ENT_QUOTES, 'UTF-8');
		}
		$select_module = $this->model_extension_module->getModule(64);
		if (isset($select_module['module_description'][$this->config->get('config_language_id')])) {
			$data['module_title_copyright'] = html_entity_decode($select_module['module_description'][$this->config->get('config_language_id')]['title'], ENT_QUOTES, 'UTF-8');
			$data['module_description_copyright'] = html_entity_decode($select_module['module_description'][$this->config->get('config_language_id')]['description'], ENT_QUOTES, 'UTF-8');
		}

		$this->load->language('common/footer');

		$data['scripts'] = $this->document->getScripts('footer');

		$data['text_information'] = $this->language->get('text_information');
		$data['text_service'] = $this->language->get('text_service');
		$data['text_extra'] = $this->language->get('text_extra');
		$data['text_contact'] = $this->language->get('text_contact');
		$data['text_return'] = $this->language->get('text_return');
		$data['text_sitemap'] = $this->language->get('text_sitemap');
		$data['text_manufacturer'] = $this->language->get('text_manufacturer');
		$data['text_voucher'] = $this->language->get('text_voucher');
		$data['text_affiliate'] = $this->language->get('text_affiliate');
		$data['text_special'] = $this->language->get('text_special');
		$data['text_account'] = $this->language->get('text_account');
		$data['text_order'] = $this->language->get('text_order');
		$data['text_wishlist'] = $this->language->get('text_wishlist');
		$data['text_newsletter'] = $this->language->get('text_newsletter');

		$this->load->model('catalog/information');

		$data['informations'] = array();

		foreach ($this->model_catalog_information->getInformations() as $result) {
			if ($result['bottom']) {
				$data['informations'][] = array(
					'title' => $result['title'],
					'href'  => $this->url->link('information/information', 'information_id=' . $result['information_id'])
				);
			}
		}


        // start: phpner_page_bar
        $data['phpner_page_bar_data'] = $this->config->get('phpner_page_bar_data');
        $phpner_page_bar_data = $this->config->get('phpner_page_bar_data');
        $data['phpner_page_bar'] = (isset($phpner_page_bar_data['status']) && $phpner_page_bar_data['status'] == 1) ? $this->load->controller('extension/module/phpner_page_bar') : '';
        // end: phpner_page_bar
      

        $data['phpner_store_data'] = $phpner_data = $this->config->get('phpner_store_data');
        $this->load->language('phpner/phpner_store');
        $data['phpner_store_contact_us'] = $this->language->get('phpner_store_contact_us');
        $data['phpner_store_categories'] = $this->language->get('phpner_store_categories');
        $data['phpner_store_our_contacts'] = $this->language->get('phpner_store_our_contacts');
        $data['phpner_store_payments'] = $this->language->get('phpner_store_payments');
        $data['phpner_store_powered'] = $this->language->get('phpner_store_powered');
        $data['text_contact_us'] = $this->language->get('phpner_store_contact_us');
        $data['text_categories'] = $this->language->get('phpner_store_categories');
        $data['text_our_contacts'] = $this->language->get('phpner_store_our_contacts');
        $data['text_payments'] = $this->language->get('phpner_store_payments');
        $data['phpner_powered'] = sprintf($this->language->get('phpner_store_powered'), $this->config->get('config_name'));
        // Вывод ссылок на статьи
        $data['phpner_store_footer_informations'] = array();
        if (isset($phpner_data['foot_info_links'])) {
          foreach ($this->model_catalog_information->getInformations() as $result) {
            if (in_array($result['information_id'], $phpner_data['foot_info_links'])) {
              $data['phpner_store_footer_informations'][] = array(
                'title' => $result['title'],
                'href' => $this->url->link('information/information', 'information_id=' . $result['information_id'])
              );
            }
          }
        }
        $this->load->model('catalog/category');
        $data['phpner_store_footer_categories'] = array();
        if (isset($phpner_data['foot_cat_links'])) {
          foreach ($phpner_data['foot_cat_links'] as $category_id) {
            $category_info = $this->model_catalog_category->getCategory($category_id);
            if ($category_info) {
              $data['phpner_store_footer_categories'][] = array(
                'name' => $category_info['name'],
                'href' => $this->url->link('product/category', 'path=' . $category_info['category_id'])
              );
            }
          }
        }
        $data['garanted_text'] = array();
        if (isset($phpner_data['foot_garantedtext_show']) && $phpner_data['foot_garantedtext_show'] == 'on' && isset($phpner_data['foot_garantedtext']) && $phpner_data['foot_garantedtext']) {
          foreach ($phpner_data['foot_garantedtext'] as $key => $foot_garantedtext) {
            if ($foot_garantedtext['popup'] == 'on') {
              $foot_garantedtext_link = (isset($foot_garantedtext['description'][$this->session->data['language']])) ? str_replace('index.php?route=information/information&', 'index.php?route=information/information/agree&', $foot_garantedtext['description'][$this->session->data['language']]['link']) : '';
            } else {
              $foot_garantedtext_link = (isset($foot_garantedtext['description'][$this->session->data['language']])) ? $foot_garantedtext['description'][$this->session->data['language']]['link'] : '';
            }
            $data['garanted_text'][] = array(
              'id'    => $key,
              'icon'  => $foot_garantedtext['icon'],
              'popup' => $foot_garantedtext['popup'],
              'name'  => (isset($foot_garantedtext['description'][$this->session->data['language']])) ? $foot_garantedtext['description'][$this->session->data['language']]['name'] : '',
              'text'  => (isset($foot_garantedtext['description'][$this->session->data['language']])) ? $foot_garantedtext['description'][$this->session->data['language']]['text'] : '',
              'link'  => ($foot_garantedtext_link == "#" || empty($foot_garantedtext_link)) ? "javascript:void(0);" : $foot_garantedtext_link
            );
          }
        }
        $phpner_store_cont_adress = $phpner_data['cont_adress'];
        if (isset($phpner_store_cont_adress[$this->session->data['language']]) && !empty($phpner_store_cont_adress[$this->session->data['language']])) {
          $data['phpner_store_cont_adress'] = html_entity_decode($phpner_store_cont_adress[$this->session->data['language']], ENT_QUOTES, 'UTF-8');
        } else {
          $data['phpner_store_cont_adress'] = false;
        }   
        if (isset($phpner_data['cont_phones']) && !empty($phpner_data['cont_phones'])) {
          $data['phpner_store_cont_phones'] = array_values(array_filter(explode(PHP_EOL, $phpner_data['cont_phones'])));
        } else {
          $data['phpner_store_cont_phones'] = false;
        }
        if (isset($phpner_data['cont_email']) && !empty($phpner_data['cont_email'])) {
          $data['phpner_store_cont_email'] = html_entity_decode($phpner_data['cont_email'], ENT_QUOTES, 'UTF-8');
        } else {
          $data['phpner_store_cont_email'] = false;
        }  
        if (isset($phpner_data['cont_skype']) && !empty($phpner_data['cont_skype'])) {
          $data['phpner_store_cont_skype'] = html_entity_decode($phpner_data['cont_skype'], ENT_QUOTES, 'UTF-8');
        } else {
          $data['phpner_store_cont_skype'] = false;
        }  
        $phpner_store_cont_clock = $phpner_data['cont_clock'];
        if (isset($phpner_store_cont_clock[$this->session->data['language']]) && !empty($phpner_store_cont_clock[$this->session->data['language']])) {
          $data['phpner_store_cont_clock'] = array_values(array_filter(explode(PHP_EOL, $phpner_store_cont_clock[$this->session->data['language']])));
        } else {
          $data['phpner_store_cont_clock'] = false;
        }

        $data['ps_additional_icons'] = array();

        if (isset($phpner_data['ps_additional_icons']) && $phpner_data['ps_additional_icons']) {
          foreach ($phpner_data['ps_additional_icons'] as $ps_additional_icon) {
            $data['ps_additional_icons'][] = array(
              'image'      => $this->model_tool_image->resize($ps_additional_icon['image'], 53, 33),
              'sort_order' => ($ps_additional_icon['sort_order']) ? $ps_additional_icon['sort_order'] : 0
            );
          }

          foreach ($data['ps_additional_icons'] as $key => $value) {
            $sort_order[$key] = $value['sort_order'];
          }

          array_multisort($sort_order, SORT_ASC, $data['ps_additional_icons']);
        }
      
		$data['contact'] = $this->url->link('information/contact');
		$data['return'] = $this->url->link('account/return/add', '', true);
		$data['sitemap'] = $this->url->link('information/sitemap');
		$data['manufacturer'] = $this->url->link('product/manufacturer');
		$data['voucher'] = $this->url->link('account/voucher', '', true);
		$data['affiliate'] = $this->url->link('affiliate/account', '', true);
		$data['special'] = $this->url->link('product/special');
		$data['account'] = $this->url->link('account/account', '', true);
		$data['order'] = $this->url->link('account/order', '', true);
		$data['wishlist'] = $this->url->link('account/wishlist', '', true);
		$data['newsletter'] = $this->url->link('account/newsletter', '', true);
$data['yandex_metrika'] = $this->config->get('ya_metrika_code') ? html_entity_decode($this->config->get('ya_metrika_code'), ENT_QUOTES, 'UTF-8') : '';
			$data['ya_metrika_active'] = $this->config->get('ya_metrika_active') ? true : false;
			$data['ya_kassa_show_in_footer'] = $this->config->get('ya_kassa_active') && $this->config->get('ya_kassa_show_in_footer');
			

		$data['powered'] = sprintf($this->language->get('text_powered'), $this->config->get('config_name'), date('Y', time()));

		// Whos Online
		if ($this->config->get('config_customer_online')) {
			$this->load->model('tool/online');

			if (isset($this->request->server['REMOTE_ADDR'])) {
				$ip = $this->request->server['REMOTE_ADDR'];
			} else {
				$ip = '';
			}

			if (isset($this->request->server['HTTP_HOST']) && isset($this->request->server['REQUEST_URI'])) {
				$url = 'http://' . $this->request->server['HTTP_HOST'] . $this->request->server['REQUEST_URI'];
			} else {
				$url = '';
			}

			if (isset($this->request->server['HTTP_REFERER'])) {
				$referer = $this->request->server['HTTP_REFERER'];
			} else {
				$referer = '';
			}

			$this->model_tool_online->addOnline($ip, $this->customer->getId(), $url, $referer);
		}

		return $this->load->view('common/footer', $data);
	}
}
