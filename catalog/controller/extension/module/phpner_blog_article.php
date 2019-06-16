<?php
/**************************************************************/
/*	@copyright	Phpner 2019							  */
/*	@support	http://phpner.ru					  */
/*	@license	LICENSE.txt									  */
/**************************************************************/

class ControllerExtensionModulePhpnerBlogArticle extends Controller {
    public function index($setting) {
        static $module = 0;
        
        $this->load->language('extension/module/phpner_blog_article');
        
        $data['heading_title']   = $setting['heading'][$this->session->data['language']];
        $data['link']            = $setting['link'][$this->session->data['language']];
        $data['button_readmore'] = $this->language->get('button_readmore');
        
        $this->load->model('phpner/blog_article');
        
        $data['position'] = $setting['position'];
        
        $data['articles'] = array();
        $filter_data      = array(
            'sort' => $setting['sort_order'],
            'limit' => $setting['limit'],
            'start' => 0,
            'filter_category_id' => ($setting['phpner_blog']) ? implode(',', $setting['phpner_blog']) : array()
        );
        
        $this->load->model('tool/image');
        
        $results = $this->model_phpner_blog_article->getArticles($filter_data);
        
        foreach ($results as $result) {
            if ($result['image']) {
                $image = $this->model_tool_image->resize($result['image'], $setting['width'], $setting['height']);
            } else {
                $image = $this->model_tool_image->resize('placeholder.png', $setting['width'], $setting['height']);
            }
            
            $data['articles'][] = array(
                'name' => $result['name'],
                'date_added' => date("d.m.Y", strtotime($result['date_added'])),
                'thumb' => ($setting['show_image']) ? $image : false,
                'description' => utf8_substr(strip_tags(html_entity_decode($result['description'], ENT_QUOTES, 'UTF-8')), 0, $setting['desc_limit']) . '..',
                'href' => $this->url->link('phpner/blog_article', 'phpner_blog_article_id=' . $result['phpner_blog_article_id'])
            );
        }
        
        $data['module'] = $module++;
        
        if ($data['articles']) {
            return $this->load->view('extension/module/phpner_blog_article', $data);
        }
    }
}