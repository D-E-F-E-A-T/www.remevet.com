ﬁ.routes.get  '/' , 'home'

ﬁ.routes.get  '/sesion/entrar' , 'auth'
ﬁ.routes.post '/sesion/entrar' , 'auth/login'
ﬁ.routes.get  '/sesion/salir'  , 'auth/logout'

ﬁ.routes.get  '/nosotros'            , 'aboutus'
ﬁ.routes.get  '/eventos'             , 'events'
ﬁ.routes.get  '/contacto'            , 'contact'
ﬁ.routes.post '/contacto'            , 'contact'
ﬁ.routes.get  '/orientacion'         , 'orientation'

