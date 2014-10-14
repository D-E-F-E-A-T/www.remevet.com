# Enable FI
require './fi'

ﬁ.datemonth = (month, small=false)->
	month = switch month
		when 0 then  (if small then 'ENE' else 'Enero')
		when 1 then  (if small then 'FEB' else 'Febrero')
		when 2 then  (if small then 'MAR' else 'Marzo')
		when 3 then  (if small then 'ABR' else 'Abril')
		when 4 then  (if small then 'MAY' else 'Mayo')
		when 5 then  (if small then 'JUN' else 'Junio')
		when 6 then  (if small then 'JUL' else 'Julio')
		when 7 then  (if small then 'AGO' else 'Agosto')
		when 8 then  (if small then 'SEP' else 'Septiembre')
		when 9 then  (if small then 'OCT' else 'Octubre')
		when 10 then (if small then 'NOV' else 'Noviembre')
		when 11 then (if small then 'DIC' else 'Diciembre')
	return month

ﬁ.require('session') (store, session, instance, server, mongo)->

	ﬁ.db    = instance
	ﬁ.mongo = mongo

	ﬁ.extend 'magazines'

	ﬁ.listen()
