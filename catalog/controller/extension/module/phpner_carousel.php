<?php
/**************************************************************/
/*	@copyright	Phpner 2019							  */
/*	@support	http://phpner.ru					  */
/*	@license	LICENSE.txt									  */
/**************************************************************/

class ControllerExtensionModulePhpnerCarousel extends Controller {
    public function index($setting) {
        static $module = 0;
        
        $this->load->model('design/banner');
        $this->load->model('tool/image');
        
        $this->load->language('extension/module/phpner_carousel');
        
        $data['heading_title'] = $this->language->get('heading_title');
        $data['button_more']   = $this->language->get('button_more');
        
        $data['manufacturer_url'] = $this->url->link('product/manufacturer');
        
        $this->document->addStyle('catalog/view/javascript/jquery/owl-carousel/owl.carousel.css');
        $this->document->addScript('catalog/view/javascript/jquery/owl-carousel/owl.carousel.min.js');
        
        $data['banners'] = array();
        
        $results = $this->model_design_banner->getBanner($setting['banner_id']);
        
        foreach ($results as $result) {
            if (is_file(DIR_IMAGE . $result['image'])) {
                $data['banners'][] = array(
                    'title' => $result['title'],
                    'link' => $result['link'],
                    'image' => $this->model_tool_image->resize($result['image'], $setting['width'], $setting['height'])
                );
            }
        }
        
        $data['module'] = $module++;
        
        return $this->load->view('extension/module/phpner_carousel', $data);
    }
}