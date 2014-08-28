Secure = ﬁ.require 'app', 'secure'

ﬁ.routes.get  '/' , 'home'

ﬁ.routes.get '/ping', (req, res)-> res.end 'OK'

ﬁ.routes.get  '/sesion/entrar'           , 'auth/login'
ﬁ.routes.post '/sesion/entrar'           , 'auth/login'
ﬁ.routes.get  '/sesion/registro'         , 'auth/signup'
ﬁ.routes.post '/sesion/registro'         , 'auth/signup'
ﬁ.routes.get  '/sesion/salir'            , 'auth/logout'
ﬁ.routes.all  '/sesion/recuperar'        , 'auth/recovery'


ﬁ.routes.get  '/nosotros'                , 'aboutus'

ﬁ.routes.get  '/contacto'                , 'contact'
ﬁ.routes.post '/contacto'                , 'contact' 

ﬁ.routes.get  '/eventos'   ,Secure              , 'calendar'

ﬁ.routes.get  '/revistas'  ,Secure              , 'magazines'

ﬁ.routes.get  '/patrocinadores/articulos', Secure, 'sponsorship'

ﬁ.routes.get  '/directorio'      ,                   'clinics'

ﬁ.routes.get  '/comunidad'      ,                   'community'


ﬁ.routes.error '/error', 'error'
