henry = ["mascotas24h@gmail.com",
"jorgereyes1959@hotmail.com",
"vetsobe@yahoo.com",
"vetsv@outlook.com",
"vetsobe@hotmail.com",
"cvdlaboratorio@dover.com.co",
"dianamir7@hotmail.com",
"jsamaca86@gmail.com",
"consulta@dover.com.co",
"lina@dover.com.co",
"ariel@dover.com.co",
"cmilena321@hotmail.com",
"paola.barato@corpavet.com",
"pamelandreagomez@hotmail.com",
"edibarcelona@yahoo.es",
"cataruba289@hotmail.com",
"cachy70@hotmail.com",
"cachy707@hotmail.com",
"walterbarcenas@hotmail.com",
"eming1957@gmail.com",
"dra.angelicabarrera@gmail.com",
"foxveterinaria@hotmail.com",
"bckaren88@hotmail.com",
"ximenabenitez84@hotmail.com",
"benjaminmanrique@hotmail.com",
"abernalm@hotmail.com",
"bejarano-84@hotmail.com",
"urielbernal91@hotmail.com",
"andreitab15@hotmail.com",
"betancurcarolina@yahoo.com",
"betansy@yahoo.com",
"bibibenavides@gmail.com",
"cgalvis@biodyne-world.com",
"biovetc_s@yahoo.com.co",
"bhisma91@hotmail.com",
"willam19_84@hotmail.com",
"willow19_84@hotmail.com",
"gebb1978@hotmail.com",
"carmenbonill@hotmail.com",
"chagothiago_20@hotmail.com",
"bosque_verde@hotmail.com",
"gcastro@ces.edu.co",
"vepaboyaca2008@gmail.com",
"brasayed@hotmail.com",
"apolosergi21@hotmail.com",
"bretapega@gmail.com",
"brigidocabello@yahoo.com.mx",
"brianmvz@hotmail.com",
"brunohenao@hotmail.com",
"brigitte@une.net.co",
"viviana.buelvas@merck.com",
"luzceina@hotmail.com",
"buriticaes@hotmail.com",
"jyn121@hotmail.com",
"caritobui@hotmail.com",
"especies17@yahoo.com",
"mccolon@agoracomunicaciones.com",
"elestablo_bucaramanga@yahoo.com",
"neurologiagdl@hotmail.com",
"oscar@dover.com.co",
"juliolopezbuitrago@hotmail.com",
"lfernando52@prodigy.net.mx",
"info@remevet.com"]

FS = require 'fs'

Model = require './model'

module.exports = (request, response, next)->

	remevet = []

	response.locals.TITLE = 'reporte'
	
	Model request, (error, data) ->
		if error
			response.status = error.status
			response.flash 'notice-error', error.message
			return response.render()
		for user in data
			remevet.push user.email

		for h in henry
			continue if remevet.indexOf(h) is -1
			ﬁ.log.error '--> ' + h



		response.render
			data:data
