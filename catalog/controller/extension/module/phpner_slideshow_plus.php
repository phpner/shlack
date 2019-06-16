<?php
/**************************************************************/
/*	@copyright	Phpner 2019							  */
/*	@support	http://phpner.ru					  */
/*	@license	LICENSE.txt									  */
/**************************************************************/

class ControllerExtensionModulePhpnerSlideshowPlus extends Controller {
	public function index($setting) {
		static $module = 0;

		$this->load->model('design/phpner_banner_plus');
		$this->load->model('tool/image');      
        
		$data['phpner_banners_plus'] = array();

		$results = $this->model_design_phpner_banner_plus->getBanner($setting['banner_id']);

		foreach ($results as $result) {
			if (is_file(DIR_IMAGE . $result['image'])) {
				$data['phpner_banners_plus'][] = array(
					'title' 	  => $result['title'],
					'button' 	  => $result['button'],
					'link'  	  => $result['link'],
					'description' => html_entity_decode($result['description'], ENT_QUOTES, 'UTF-8'),
					'image' 	  => $this->model_tool_image->resize($result['image'], $setting['width'], $setting['height'])
				);
			}
		}

		$data['module'] = $module++;

		$data['banner_id'] = $setting['banner_id'];
		$data['arrows'][$setting['banner_id']]     = $setting['arrows_status'];
		$data['pagination'][$setting['banner_id']] = $setting['paginations_status'];

		return $this->load->view('extension/module/phpner_slideshow_plus', $data);
	}
}