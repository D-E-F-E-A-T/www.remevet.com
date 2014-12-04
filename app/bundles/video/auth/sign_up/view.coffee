repetir_password = ->
	$('input[name="repeatPassword"]').attr 'pattern', $('input[name="_password"]').val()
repetir_correo = ->
	$('input[name="RepeatMail"]').attr 'pattern', $('input[name="email"]').val()
$('input[name="_password"]').on 'change', repetir_password
$('input[name="email"]').on 'change', repetir_correo

$.getScript("/static/lib/datepicker/js/foundation-datepicker.js").done((script, textStatus) ->
	console.log "script cargado"
	return
).fail (jqxhr, settings, exception) ->
	console.log "Error al cargar el script"
	return