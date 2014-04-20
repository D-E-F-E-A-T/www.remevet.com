window.$window   = $ window
window.$document = $ document

$document.readyStack = []

$document.foundation().ready ->

	# Execute all onReady functions
	(fn.call(this) if typeof fn is 'function') for fn in $document.readyStack

	