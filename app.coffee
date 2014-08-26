# Enable FI
require './fi'

ﬁ.require('session') (store, session, instance, server, mongo)->

	ﬁ.db    = instance
	ﬁ.mongo = mongo

	require './pdf'

	ﬁ.listen()
