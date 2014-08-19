Secure = ﬁ.require 'app', 'secure'

ﬁ.routes.get  '/' , 'home'

ﬁ.routes.get  '/sesion/entrar'           , 'auth'
ﬁ.routes.post '/sesion/entrar'           , 'auth/login'
ﬁ.routes.get  '/sesion/salir'            , 'auth/logout'

ﬁ.routes.all '/sesion/registrar'         , 'auth/signup'

ﬁ.routes.get  '/nosotros'                , 'aboutus'

ﬁ.routes.get  '/contacto'                , 'contact'
ﬁ.routes.post '/contacto'                , 'contact' 

ﬁ.routes.get  '/eventos'   ,Secure              , 'calendar'

ﬁ.routes.get  '/revistas'  ,Secure              , 'magazines'

ﬁ.routes.get  '/patrocinadores/articulos', Secure, 'sponsorship'


ﬁ.routes.error '/error', 'error'
