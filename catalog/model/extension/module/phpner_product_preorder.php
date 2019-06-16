<?php
/**************************************************************/
/*	@copyright	Phpner 2019							  */
/*	@support	http://phpner.ru					  */
/*	@license	LICENSE.txt									  */
/**************************************************************/

class ModelExtensionModulePhpnerProductPreorder extends Model {
	public function addRequest($data, $linkgood) {
		$this->db->query("INSERT INTO ".DB_PREFIX."phpner_product_preorder SET info = '".$this->db->escape($data['info'])."', note = '".$this->db->escape($linkgood)."', date_added = NOW()");
	}
}