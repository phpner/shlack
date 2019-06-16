<?php
/**************************************************************/
/*	@copyright	Phpner 2019							  */
/*	@support	http://phpner.ru					  */
/*	@license	LICENSE.txt									  */
/**************************************************************/

class ControllerExtensionModulePhpnerProductReview extends Controller {
    public function index($setting) {
        static $module = 0;
        
        $this->load->language('extension/module/phpner_product_review');
        
        $data['heading_title'] = $this->language->get('heading_title');
        
        $this->load->model('catalog/product');
        $this->load->model('extension/module/phpner_product_review');
        
        $this->load->model('tool/image');
        
        $data['reviews'] = array();
        
        if (!$setting['limit']) {
            $setting['limit'] = 4;
        }
        
        $filter_data = array(
            'limit' => $setting['limit'],
            'start' => 0
        );
        
        $data['position'] = $setting['position'];
        
        $reviews = $this->model_extension_module_phpner_product_review->getAllReviews($filter_data);
        
        foreach ($reviews as $review) {
            if ($review['image']) {
                $image = $this->model_tool_image->resize($review['image'], $setting['width'], $setting['height']);
            } else {
                $image = $this->model_tool_image->resize('placeholder.png', $setting['width'], $setting['height']);
            }
            
            $data['reviews'][] = array(
                'product_id' => $review['product_id'],
                'thumb' => $image,
                'name' => $review['name'],
                'text' => utf8_substr(strip_tags(html_entity_decode($review['text'], ENT_QUOTES, 'UTF-8')), 0, 200) . '..',
                'rating' => $review['rating'],
                'href' => $this->url->link('product/product', 'product_id=' . $review['product_id'])
            );
        }
        
        $data['module'] = $module++;
        
        if ($data['reviews']) {
            return $this->load->view('extension/module/phpner_product_review', $data);
        }
    }
}