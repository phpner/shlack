<?php
class ControllerExtensionModuleBackupSql extends Controller {

	private $error = array();
	public $fileName = 'mysqlbackup-.sql';
	const BACKUP_DIR = './myBackups';

	public function index() {

		$this->load->language('extension/module/backup_sql');

		$this->document->setTitle($this->language->get('heading_title'));

		$this->load->model('setting/setting');

		/**
		 * getting data from db
		 */

		$this->load->model('catalog/backup_sql');


		if (!file_exists(self::BACKUP_DIR)) mkdir(self::BACKUP_DIR , 0700) ;
		if (!is_writable(self::BACKUP_DIR)) chmod(self::BACKUP_DIR , 0700) ;


		$content = 'Allow from all' ;
		$file = new SplFileObject(self::BACKUP_DIR . '/.htaccess', "w") ;
		$file->fwrite($content) ;

		if (isset($this->request->get['save_sql'])) {

			$return =  $this->model_catalog_backup_sql->getsql();

			$today = date("Y-m-H-i-s");
			$zip = new ZipArchive();
			$resOpen = $zip->open(self::BACKUP_DIR . '/' . "$today-back.zip", ZIPARCHIVE::CREATE);
			if ($resOpen) {
				$zip->addFromString($this->fileName, "$return");
			}else{
				var_dump($resOpen);
			}
			$zip->close();			

			/*echo $this->request->server['DOCUMENT_ROOT'].'admin/myBackups/back.zip' ;

			die();*/
		}

		$sql_dir = opendir(self::BACKUP_DIR);
        $i = 0;
		while (false !== ($entry = readdir($sql_dir))) {
			
			if ($entry != "." && $entry != ".." && $entry != ".htaccess") {

           			$data['files_sql'][$i]['href'] = '/admin/'.substr(self::BACKUP_DIR,1) . '/' . $entry;
           			$data['files_sql'][$i]['file'] = $entry;
           			$data['files_sql'][$i]['size'] = $this->file_size(self::BACKUP_DIR . '/' . $entry);
                $i++;
        	}
			
			
		}

		
		$data['text_save_header'] = $this->language->get('text_save_header');

		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()) {
			$this->model_setting_setting->editSetting('category', $this->request->post);

			$this->session->data['success'] = $this->language->get('text_success');

			$this->response->redirect($this->url->link('extension/extension', 'token=' . $this->session->data['token'] . '&type=module', true));
		}

		$data['heading_title'] = $this->language->get('heading_title');

		$data['text_edit'] = $this->language->get('text_edit');
		$data['text_enabled'] = $this->language->get('text_enabled');
		$data['text_disabled'] = $this->language->get('text_disabled');

		$data['entry_status'] = $this->language->get('entry_status');

		$data['button_save'] = $this->language->get('button_save');
		$data['button_cancel'] = $this->language->get('button_cancel');

		if (isset($this->error['warning'])) {
			$data['error_warning'] = $this->error['warning'];
		} else {
			$data['error_warning'] = '';
		}

		$data['breadcrumbs'] = array();

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('text_home'),
			'href' => $this->url->link('common/dashboard', 'token=' . $this->session->data['token'], true)
		);

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('text_extension'),
			'href' => $this->url->link('extension/extension', 'token=' . $this->session->data['token'] . '&type=module', true)
		);

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('heading_title'),
			'href' => $this->url->link('extension/module/category', 'token=' . $this->session->data['token'], true)
		);

		$data['action'] = $this->url->link('extension/module/backup_sql', 'token=' . $this->session->data['token'], true);
		$data['token'] = $this->session->data['token'];

		$data['cancel'] = $this->url->link('extension/extension', 'token=' . $this->session->data['token'] . '&type=module', true);

		if (isset($this->request->post['category_status'])) {
			$data['category_status'] = $this->request->post['category_status'];
		} else {
			$data['category_status'] = $this->config->get('category_status');
		}

		$data['header'] = $this->load->controller('common/header');
		$data['column_left'] = $this->load->controller('common/column_left');
		$data['footer'] = $this->load->controller('common/footer');

		$this->response->setOutput($this->load->view('extension/module/backup_sql', $data));
	}

	protected function validate() {
		if (!$this->user->hasPermission('modify', 'extension/module/category')) {
			$this->error['warning'] = $this->language->get('error_permission');
		}

		return !$this->error;
	}

	public function del_sql_zip(){

        $fileToDell = $this->request->get['del_sql'];

	    if(file_exists(self::BACKUP_DIR . '/' . $fileToDell))
	    {
	        unlink(self::BACKUP_DIR . '/' . $fileToDell);

            $this->index();

        }
             $this->index();
    }

    public function file_size($path)
    {
        $size = filesize($path);
        $units = array( 'Byte', 'KB', 'MB', 'GB', 'TB', 'PB', 'EB', 'ZB', 'YB');
        $power = $size > 0 ? floor(log($size, 1024)) : 0;
        return number_format($size / pow(1024, $power), 2, '.', ',') . ' ' . $units[$power];
    }
}