/**
 * Javascrip gerenciador de ações a serem efetuadas no mapa (hotspot)
 * @author Márcio Ribeiro Gurgel do Amaral
 */
jQuery.noConflict();
jQuery(document).ready(function(){
	
	jQuery("[regiao]").mouseenter(function(){
		var regionId = jQuery(this).attr("regiao");
		jQuery("#mapa-brasil").attr("src", jQuery("#contextPath").val() + "/image/deposita_" + regionId + ".png");
		
	});
	
	jQuery("[regiao]").mouseleave(function(){
		var regionId = jQuery(this).attr("regiao");
		jQuery("#mapa-brasil").attr("src", jQuery("#contextPath").val() + "/image/colecoes_deposita.png");
		
	});
	
});
	