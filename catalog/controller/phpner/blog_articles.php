<?php
/**************************************************************/
/*	@copyright	Phpner 2019							  */
/*	@support	http://phpner.ru					  */
/*	@license	LICENSE.txt									  */
/**************************************************************/

class ControllerPhpnerBlogArticles extends Controller {
    public function index() {
        $this->load->language('phpner/blog_articles');
        
        $data['phpner_home_text'] = $this->language->get('phpner_home_text');
        
        $phpner_blog_setting_data = $this->config->get('phpner_blog_setting_data');
        
        $this->load->model('phpner/blog_article');
        
        $this->load->model('tool/image');
        
        if (isset($this->request->get['sort'])) {
            $sort = $this->request->get['sort'];
        } else {
            $sort = 'a.date_added_desc';
        }
        
        if (isset($this->request->get['page'])) {
            $page = $this->request->get['page'];
        } else {
            $page = 1;
        }
        
        if (isset($this->request->get['limit'])) {
            $limit = (int) $this->request->get['limit'];
        } else {
            $limit = $this->config->get($this->config->get('config_theme') . '_product_limit');
        }
        
        $data['breadcrumbs'] = array();
        
        $data['breadcrumbs'][] = array(
            'text' => $this->language->get('text_home'),
            'href' => $this->url->link('common/home')
        );
        
        $url = '';
        
        if (isset($this->request->get['sort'])) {
            $url .= '&sort=' . $this->request->get['sort'];
        }
        
        if (isset($this->request->get['order'])) {
            $url .= '&order=' . $this->request->get['order'];
        }
        
        if (isset($this->request->get['limit'])) {
            $url .= '&limit=' . $this->request->get['limit'];
        }
        
        $data['breadcrumbs'][] = array(
            'text' => $this->language->get('text_articles'),
            'href' => $this->url->link('phpner/blog_articles' . $url)
        );
        
        if (isset($phpner_blog_setting_data['language'][$this->config->get('config_language_id')])) {
            $this->document->setTitle($phpner_blog_setting_data['language'][$this->config->get('config_language_id')]['seo_title']);
            $this->document->setDescription($phpner_blog_setting_data['language'][$this->config->get('config_language_id')]['seo_meta_description']);
            $this->document->setKeywords($phpner_blog_setting_data['language'][$this->config->get('config_language_id')]['seo_meta_keywords']);
            $data['heading_title'] = $phpner_blog_setting_data['language'][$this->config->get('config_language_id')]['seo_h1'];
            $data['description']   = html_entity_decode($phpner_blog_setting_data['language'][$this->config->get('config_language_id')]['seo_description'], ENT_QUOTES, 'UTF-8');
        } else {
            $this->document->setTitle($this->language->get('text_articles'));
            $data['heading_title'] = $this->language->get('text_articles');
            $data['description']   = '';
        }
        
        $data['text_empty']      = $this->language->get('text_empty');
        $data['text_sort']       = $this->language->get('text_sort');
        $data['text_limit']      = $this->language->get('text_limit');
        $data['text_comments']   = $this->language->get('text_comments');
        $data['text_viewed']     = $this->language->get('text_viewed');
        $data['text_date_added'] = $this->language->get('text_date_added');
        $data['text_rating']     = $this->language->get('text_rating');
        $data['button_continue'] = $this->language->get('button_continue');
        
        $url = '';
        
        if (isset($this->request->get['sort'])) {
            $url .= '&sort=' . $this->request->get['sort'];
        }
        
        if (isset($this->request->get['limit'])) {
            $url .= '&limit=' . $this->request->get['limit'];
        }
        
        $data['products'] = array();
        
        $filter_data = array(
            'sort' => $sort,
            'start' => ($page - 1) * $limit,
            'limit' => $limit
        );
        
        $article_total = $this->model_phpner_blog_article->getTotalArticles($filter_data);
        
        $data['articles'] = array();
        
        $a_results = $this->model_phpner_blog_article->getArticles($filter_data);
        
        foreach ($a_results as $result) {
            if ($result['image']) {
                $image = $this->model_tool_image->resize($result['image'], $phpner_blog_setting_data['a_image_width_in_category'], $phpner_blog_setting_data['a_image_height_in_category']);
            } else {
                $image = $this->model_tool_image->resize('placeholder.png', $phpner_blog_setting_data['a_image_width_in_category'], $phpner_blog_setting_data['a_image_height_in_category']);
            }
            
            if ($this->config->get('config_review_status')) {
                $rating = (int) $result['rating'];
            } else {
                $rating = false;
            }
            
            $data['articles'][] = array(
                'phpner_blog_article_id' => $result['phpner_blog_article_id'],
                'thumb' => $image,
                'name' => $result['name'],
                'date_added' => date($this->language->get('date_format_short'), strtotime($result['date_added'])),
                'comments' => $result['comments'] ? $result['comments'] : 0,
                'viewed' => $result['viewed'],
                'description' => utf8_substr(strip_tags(html_entity_decode($result['description'], ENT_QUOTES, 'UTF-8')), 0, $phpner_blog_setting_data['desc_limit']) . '..',
                'rating' => $rating,
                'href' => $this->url->link('phpner/blog_article', '&phpner_blog_article_id=' . $result['phpner_blog_article_id'])
            );
        }
        
        $url = '';
        
        if (isset($this->request->get['limit'])) {
            $url .= '&limit=' . $this->request->get['limit'];
        }
        
        $data['sorts'] = array();
        
        $data['sorts'][] = array(
            'text' => $this->language->get('text_sort_order_asc'),
            'value' => 'a.sort_order_asc',
            'href' => $this->url->link('phpner/blog_articles', '&sort=a.sort_order_asc' . $url)
        );
        
        $data['sorts'][] = array(
            'text' => $this->language->get('text_sort_order_desc'),
            'value' => 'a.sort_order_desc',
            'href' => $this->url->link('phpner/blog_articles', '&sort=a.sort_order_desc' . $url)
        );
        
        $data['sorts'][] = array(
            'text' => $this->language->get('text_name_asc'),
            'value' => 'ad.name_asc',
            'href' => $this->url->link('phpner/blog_articles', '&sort=ad.name_asc' . $url)
        );
        
        $data['sorts'][] = array(
            'text' => $this->language->get('text_name_desc'),
            'value' => 'ad.name_desc',
            'href' => $this->url->link('phpner/blog_articles', '&sort=ad.name_desc' . $url)
        );
        
        $url = '';
        
        if (isset($this->request->get['sort'])) {
            $url .= '&sort=' . $this->request->get['sort'];
        }
        
        $data['limits'] = array();
        
        $limits = array_unique(array(
            $this->config->get($this->config->get('config_theme') . '_product_limit'),
            25,
            50,
            75,
            100
        ));
        
        sort($limits);
        
        foreach ($limits as $value) {
            $data['limits'][] = array(
                'text' => $value,
                'value' => $value,
                'href' => $this->url->link('phpner/blog_articles', $url . '&limit=' . $value)
            );
        }
        
        $url = '';
        
        if (isset($this->request->get['sort'])) {
            $url .= '&sort=' . $this->request->get['sort'];
        }
        
        if (isset($this->request->get['limit'])) {
            $url .= '&limit=' . $this->request->get['limit'];
        }
        
        $pagination        = new Pagination();
        $pagination->total = $article_total;
        $pagination->page  = $page;
        $pagination->limit = $limit;
        $pagination->url   = $this->url->link('phpner/blog_articles', $url . '&page={page}');
        
        $data['pagination'] = $pagination->render();
        
        $data['results'] = sprintf($this->language->get('text_pagination'), ($article_total) ? (($page - 1) * $limit) + 1 : 0, ((($page - 1) * $limit) > ($article_total - $limit)) ? $article_total : ((($page - 1) * $limit) + $limit), $article_total, ceil($article_total / $limit));
        
        // http://googlewebmastercentral.blogspot.com/2011/09/pagination-with-relnext-and-relprev.html
        if ($page == 1) {
            $this->document->addLink($this->url->link('phpner/blog_articles'), 'canonical');
        } elseif ($page == 2) {
            $this->document->addLink($this->url->link('phpner/blog_articles'), 'prev');
        } else {
            $this->document->addLink($this->url->link('phpner/blog_articles', '&page=' . ($page - 1), 'SSL'), 'prev');
        }
        
        if ($limit && ceil($article_total / $limit) > $page) {
            $this->document->addLink($this->url->link('phpner/blog_articles', '&page=' . ($page + 1), 'SSL'), 'next');
        }
        
        $data['sort']  = $sort;
        $data['limit'] = $limit;
        
        $data['continue'] = $this->url->link('common/home');
        
        $data['column_left']    = $this->load->controller('common/column_left');
        $data['column_right']   = $this->load->controller('common/column_right');
        $data['content_top']    = $this->load->controller('common/content_top');
        $data['content_bottom'] = $this->load->controller('common/content_bottom');
        $data['footer']         = $this->load->controller('common/footer');
        $data['header']         = $this->load->controller('common/header');
        
        $this->response->setOutput($this->load->view('phpner_store/blog_articles', $data));
    }
}