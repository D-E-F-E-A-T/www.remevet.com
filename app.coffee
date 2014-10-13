# Enable FI
require './fi'

ﬁ.datemonth = (month)->
	month = switch month
		when 0 then 'Enero'
		when 1 then 'Febrero'
		when 2 then 'Marzo'
		when 3 then 'Abril'
		when 4 then 'Mayo'
		when 5 then 'Junio'
		when 6 then 'Julio'
		when 7 then 'Agosto'
		when 8 then 'Septiembre'
		when 9 then 'Octubre'
		when 10 then 'Noviembre'
		when 11 then 'Diciembre'
	return month

ﬁ.require('session') (store, session, instance, server, mongo)->

	ﬁ.db    = instance
	ﬁ.mongo = mongo

	ﬁ.extend 'pdf'

	ﬁ.listen()
