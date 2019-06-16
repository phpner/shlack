<?php
/**************************************************************/
/*	@copyright	Phpner 2019							  */
/*	@support	http://phpner.ru					  */
/*	@license	LICENSE.txt									  */
/**************************************************************/

class ModelCatalogPhpnerProductStickers extends Model {
	public function getProductSticker($product_sticker_id) {
		$query = $this->db->query("SELECT DISTINCT * FROM " . DB_PREFIX . "phpner_product_stickers ps LEFT JOIN " . DB_PREFIX . "phpner_product_stickers_description psd ON (ps.product_sticker_id = psd.product_sticker_id) WHERE ps.product_sticker_id = '" . (int)$product_sticker_id . "' AND psd.language_id = '" . (int)$this->config->get('config_language_id') . "' AND ps.status = '1' ORDER BY ps.sort_order ASC");

		return $query->row;
	}
}