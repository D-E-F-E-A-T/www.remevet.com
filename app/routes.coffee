Secure = ﬁ.require 'templates', 'controls/secure'
Subscription   = ﬁ.require 'templates', 'controls/subscription'

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

ﬁ.routes.get  '/video/sign_in'                 , 'video/auth/sign_in'
ﬁ.routes.post '/video/sign_in'                 , 'video/auth/sign_in'

ﬁ.routes.get  '/video/sign_up'                           , 'video/auth/sign_up'
ﬁ.routes.post  '/video/sign_up'                          , 'video/auth/sign_up'

ﬁ.routes.get  'video/password/change/recovery/:mail/:password'          , 'video/auth/recovery/change'
ﬁ.routes.post 'video/password/change/recovery/:mail/:password'          , 'video/auth/recovery/change'


ﬁ.routes.get  '/video/subscription'						, 'video/subscription'
ﬁ.routes.get  '/video/subscription/success'				, 'video/subscription/success'
ﬁ.routes.post '/video/subscription/success'				, 'video/subscription/success'

ﬁ.routes.get  '/video/'                                  , Secure,Subscription,'video/welcome'
ﬁ.routes.get  '/video/home/:interest'                    , Secure,Subscription, 'video/home'

ﬁ.routes.get  '/video/player/:resource_id'              , Secure,Subscription,'video/player'


ﬁ.routes.get  '/revistas'                				,  Secure, 'magazines'
ﬁ.routes.get  '/revistas/:section'       				,  Secure, 'magazines/section'
	
ﬁ.routes.get  '/eventos'                 				,  Secure, 'events'
ﬁ.routes.get  '/patrocinadores/articulos'				,  Secure, 'sponsors'

ﬁ.routes.get   '/ping'  , 'util/ping'
ﬁ.routes.error '/error' , 'util/error'