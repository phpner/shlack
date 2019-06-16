<?php
/**************************************************************/
/*	@copyright	Phpner 2019							  */
/*	@support	http://phpner.ru					  */
/*	@license	LICENSE.txt									  */
/**************************************************************/

class ModelExtensionModulePhpnerPopupCallPhone extends Model {
	public function addRequest($data) {
		$this->db->query("INSERT INTO ".DB_PREFIX."phpner_popup_call_phone SET info = '".$this->db->escape($data['info'])."', date_added = NOW()");
	}
}