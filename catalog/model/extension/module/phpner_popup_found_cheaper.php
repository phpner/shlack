<?php
/**************************************************************/
/*	@copyright	Phpner 2019							  */
/*	@support	http://phpner.ru					  */
/*	@license	LICENSE.txt									  */
/**************************************************************/

class ModelExtensionModulePhpnerPopupFoundCheaper extends Model {
	public function addRequest($data, $linkgood) {
		$this->db->query("INSERT INTO ".DB_PREFIX."phpner_popup_found_cheaper SET info = '".$this->db->escape($data['info'])."', note = '".$this->db->escape($linkgood)."', date_added = NOW()");
	}
}