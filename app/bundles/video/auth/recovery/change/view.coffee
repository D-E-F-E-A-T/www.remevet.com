repetir_password = ->
	$('input[name="repeatPassword"]').attr 'pattern', $('input[name="_password"]').val()
$('input[name="_password"]').on 'change', repetir_password