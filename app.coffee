# Enable FI
require './fi'

ﬁ.extend 'datemonth'
ﬁ.require('session') (store, session, instance, server, mongo)->

	ﬁ.db    = instance
	ﬁ.mongo = mongo

	ﬁ.listen()
