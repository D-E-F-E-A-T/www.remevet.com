# Enable FI
require './fi'

ﬁ.extend 'datemonth'
ﬁ.require('session') (store, session, instance, server, mongo)->

	ﬁ.db    = instance
	ﬁ.mongo = mongo

	ﬁ.settings.domain = {}
	ﬁ.settings.email = {}
	collection = ﬁ.db.collection 'general_property'

	collection.find({ _id: { $in: [ /^domain./ ] } }).toArray (error, data)->
		if error or not data
			error =
				if error
				then message: [String error], status: 500
				else message: ['No se pudo consultar la lista de dominios.'], status: 403

		for k,v of data
			ﬁ.settings.domain[v._id.replace /domain./, ""] = v.value
	
		collection.find({ _id: { $in: [ /^email./ ] } }).toArray (error, data_email)->
			if error or not data_email
				error =
					if error
					then message: [String error], status: 500
					else message: ['No se pudo consultar los datos de envío de mail.'], status: 403

			for v,k in data_email
				ﬁ.settings.email[v._id.replace /email./, ""] = v.value

			ﬁ.listen()
