Secure = ﬁ.require 'app', 'secure'

ﬁ.routes.get  '/'    , '_home_'

ﬁ.routes.get  '/sesion/entrar'           , 'auth/login'
ﬁ.routes.post '/sesion/entrar'           , 'auth/login'
ﬁ.routes.get  '/sesion/registro'         , 'auth/signup'
ﬁ.routes.post '/sesion/registro'         , 'auth/signup'
ﬁ.routes.get  '/sesion/salir'            , 'auth/logout'
ﬁ.routes.all  '/sesion/recuperar'        , 'auth/recovery'

ﬁ.routes.get  '/contacto'                , 'contact'
ﬁ.routes.post '/contacto'                , 'contact'
ﬁ.routes.get  '/nosotros'                , 'about'
ﬁ.routes.get  '/directorio'              , 'directory'
ﬁ.routes.get  '/comunidad'               , 'community'
ﬁ.routes.get  '/aviso-de-privacidad'	 , 'privacy'

ﬁ.routes.get  '/revistas'                , Secure, 'magazines'
ﬁ.routes.get  '/revistas/:section'       , Secure, 'magazines/section'

ﬁ.routes.get  '/eventos'                 , Secure, 'events'
ﬁ.routes.get  '/patrocinadores/articulos', Secure, 'sponsors'

ﬁ.routes.get  '/poc', Secure, 'poc'

ﬁ.routes.get   '/ping'  , 'util/ping'
ﬁ.routes.error '/error' , 'util/error'
