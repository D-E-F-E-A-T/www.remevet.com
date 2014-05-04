$document.readyStack.push ->
	$('#contestar').click (e)->
		console.log '-------> ' + $('input[name=answer]:checked', 'form').val()
		$.ajax
			url   :  '/widget'
			type  :  'POST'
			dataType : 'json'
			data   :
				answer : $('input[name=answer]:checked', 'form').val()
			error : (data)->
				console.log 'error'
				console.log JSON.stringify data

			success : (data)->
				console.log 'success'
				console.log JSON.stringify data
				console.log data.answer
		e.preventDefault()