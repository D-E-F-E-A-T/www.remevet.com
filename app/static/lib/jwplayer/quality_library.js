var calidades = [
	"480",
	"400",
	"270",
	"180"
];

var formato = ".mp4";

var temporizador_cambio_calidad;
var temporizador_cargado_reproductor;

//milisegundos
var tiempo_espera_buffer = 10000; 
var tiempo_espera_flash  = 390;

var anterior;

var cambiar_video;
var calidad_reproduciendo;
var bloqueado;

var buffer = 0;

var configuracion = { tipo_reproductor : false }; //false : html -> true : flash

function genera_opciones_reproductor (host, path, nombre, imagen, tipo){
	var opciones;
	if (configuracion.tipo_reproductor){
		//flash	
		opciones = {
			file   : host + path + nombre + ".smil",
			image  : host + path + imagen,
			width  : "100%",
			aspectratio : "16:9"
		};
		if (!tipo){
			opciones.file = resource.rtmp + "mp4:" + path + "preview" + formato;
		}
	} else {
		//html
		opciones = {
			image   : host + path + imagen,
			sources : [{
				file  : host + path + nombre + "_" + calidades[0] + formato,
				label : calidades[0]+"p",
				"default" : true
			},{ 
				file  : host + path + nombre + "_" + calidades[1] + formato,
				label : calidades[1]+"p"  
			},{
				file  : host + path + nombre + "_" + calidades[2] + formato,
				label : calidades[2]+"p"  
			},{
				file  : host + path + nombre + "_" + calidades[3] + formato,
				label : calidades[3]+"p"
			}],
			width  : "100%",
			aspectratio : "16:9"
		};
		if (!tipo){
			delete opciones.sources;
			opciones.file = host + path + "preview" + formato;
		}
	} //if
	return opciones; 
} //genera_opciones_reproductor

function inicializa_eventos (){
	jwplayer().onPlay( function (){
		control_estados();
	});

	jwplayer().onPause( function (){
		control_estados();
	});

	jwplayer().onComplete( function (){
		mensaje("--- comp ---");
		// control_estados();
		// mensaje("------------");
	});

	jwplayer().onBuffer( function (){
		control_estados();
	});

	jwplayer().onIdle( function (){
		control_estados();
	});

	jwplayer().onBufferChange( function (){
		// mensaje("--- b ch ---");
		// mensaje("------------");
		calcula_interseccion();
		control_estados();
	});
	jwplayer().onSeek( function (){
		mensaje("--- seek ---");
		control_estados();
		mensaje("------------");
		temporizador_cambio_calidad = setTimeout("cambia_calidad()", tiempo_espera_buffer);
	});
	jwplayer().onQualityChange( function (evento){
		mensaje("--- q ch --- :"+evento.currentQuality);
		control_estados();
		mensaje("------------");
		temporizador_cambio_calidad = setTimeout("cambia_calidad()", tiempo_espera_buffer);
	});
} //inicializa_eventos



function habilita_cambio_video (){
	mensaje("									                     desbloqueado");
	cambiar_video = true;
} //habilita_cambio_video


function deshabilita_cambio_video (){
	mensaje("									                     bloqueado");
	cambiar_video = false;
	
} //deshabilita_cambio_video

function mensaje (texto){
	var tiempo = new Date();
	tiempo = tiempo.getHours()+":"+tiempo.getMinutes()+":"+tiempo.getSeconds()+":"+tiempo.getMilliseconds();
	console.log(tiempo + " # " + texto);
} //mensaje

function reproductor_flash (){
	mensaje("flash");
	clearTimeout(temporizador_cargado_reproductor);
	cambia_tipo_reproductor();
	carga_video( 0 );
} //reproductor_flash

function cambia_tipo_reproductor (){
	configuracion.tipo_reproductor = !configuracion.tipo_reproductor;
} //cambia_tipo_reproductor

function carga_video (){
	mensaje("carga_video");
	try {
		var opciones = genera_opciones_reproductor(resource.web, configuracion.path, configuracion.nombre, configuracion.imagen, configuracion.tipo);

		//imprimeParametros(check+"<->"+opciones);
		jwplayer('mediaplayer').setup(opciones);
		
		// contro de la calidad manual [HTML]
		
		anterior = 'IDLE';
		if (!configuracion.tipo){
			$("#advertencia").css("display","block");
		}
		jwplayer().onReady ( function (){
			if (jwplayer().getRenderingMode() != "flash" && !configuracion.tipo){
				inicializa_eventos();
			}
		});
	} catch (error){
		console.log("->>"+error);
	}
} //carga_video

function configura_reproductor (datos, tipo){
	if(datos.description)
		$("#descripcion p").html(datos.description.replace(/\n/g, '<br/>'));
	configuracion.path   = datos.path;
	configuracion.nombre = datos.name;
	configuracion.imagen = datos.image;
	configuracion.tipo   = tipo;
	temporizador_cargado_reproductor = setTimeout("carga_video()", tiempo_espera_flash);
} //configura_reproductor

var estados = [];
estados['IDLE']      = 0;
estados['BUFFERING'] = 1;
estados['PLAYING']   = 2;
estados['PAUSED']    = 3;
// bufferChange
// complete

function control_estados (siguiente){
	switch ( ( estados[anterior]*10 ) + parseInt( estados[jwplayer().getState()] ) ){
		case 0:
			mensaje("Video : detenido -> detenido");
			deshabilita_cambio_video();
			clearTimeout(temporizador_cambio_calidad);
			break;
		case 1:
			mensaje("Video : inicio -> cargando");
			habilita_cambio_video();
			temporizador_cambio_calidad = setTimeout("cambia_calidad()", tiempo_espera_buffer);
			break;
		case 2:
			mensaje("Video : inicio -> reproduciendo");
			habilita_cambio_video();
			break;
		case 3:
			mensaje("Video : inicio -> pausa");
			clearTimeout(temporizador_cambio_calidad);
			deshabilita_cambio_video();
			//cuando ya no se carga buffer?
			break;
		case 10:
			mensaje("Video : cargando -> detenido");
			clearTimeout(temporizador_cambio_calidad);
			deshabilita_cambio_video();
			break;
		case 11:
			mensaje("Video : cargando -> cargando");
			//habilita_cambio_video();
			// calcula tiempo interseccion
			break;	
		case 12:
			mensaje("Video : cargando -> reproduciendo");
			habilita_cambio_video();
			// calcula tiempo interseccion
			break;
		case 13:
			mensaje("Video : cargando -> pausado");
			clearTimeout(temporizador_cambio_calidad);
			deshabilita_cambio_video();
			break;
		case 20:
			mensaje("Video : reproduciendo -> stop");
			clearTimeout(temporizador_cambio_calidad);
			deshabilita_cambio_video();
			break;
		case 21:
			mensaje("Video : reproduciendo -> cargando");
			//cambia calidad
			// habilita_cambio_video();
			// calcula tiempo interseccion
			// setTimeout("cambia_calidad()", tiempo_espera_buffer);
			break;
		case 22:
			mensaje("Video : reproduciendo -> reproduciendo");
			// habilita_cambio_video();
			// calcula tiempo interseccion
			break;
		case 23:
			mensaje("Video : reproduciendo -> pausa");
			clearTimeout(temporizador_cambio_calidad);
			deshabilita_cambio_video();
			break;
		case 30:
			mensaje("Video : pausa -> stop");
			clearTimeout(temporizador_cambio_calidad);
			deshabilita_cambio_video();
			break;
		case 31:
			mensaje("Video : pausa -> cargando");
			//habilita_cambio_video();
			//cambia calidad
			// setTimeout("cambia_calidad()", tiempo_espera_buffer);
			break;
		case 32:
			mensaje("Video : pausa -> reproduciendo");
			habilita_cambio_video();
			// calcula tiempo interseccion
			break;
		case 33:
			mensaje("Video : pausa -> pausa");
			// habilita_cambio_video();
			break;
		default:
			mensaje("Video -> "+( ( estados[anterior]*10 ) + parseInt( estados[jwplayer().getState()] ) ) );
			break;
	} //switch
	anterior = jwplayer().getState();
} //control_estados

function cambia_calidad (){
	mensaje("cambia_calidad");
	mensaje("----- ? : \t\t\t"+(bloqueado ? "Y" : "n") + (cambiar_video ? "Y" : "n"));
	if (!bloqueado && cambiar_video){
	// if (cambiar_video && jwplayer().getState().localeCompare("PLAYING") != 0){
	// if (jwplayer().getState() != "BUFFERING"){
		// var posicion_cambio = jwplayer().getPosition();
		calidad_reproduciendo = jwplayer().getCurrentQuality();

		if (calidad_reproduciendo != calidades.length){
			calidad_reproduciendo++;
			// mensaje("--\t\turl -> "+host + path_video + nombre_video + calidades[calidad_reproduciendo]);
			// jwplayer().load( [{ file : host + path_video + nombre_video + calidades[calidad_reproduciendo] }]);
			jwplayer().setCurrentQuality(calidad_reproduciendo);
			// jwplayer().seek(posicion_cambio);
			// jwplayer().play();
			// deshabilita_cambio_video();
			bloquea_cambio_calidad();
			mensaje("----- OK");
		} else{
			mensaje("----- NO");
		}
	} //if
} //cambia_calidad

function bloquea_cambio_calidad (){
	bloqueado = true;
	setTimeout("desbloquea_cambio_calidad()", tiempo_espera_buffer);
}

function desbloquea_cambio_calidad (){
	bloqueado = false;
}

function calcula_interseccion (){
	mensaje("calcula_interseccion");
	clearTimeout(temporizador_cambio_calidad);
	mensaje("--\t\treseteando temporizador_cambio_calidad");
	//clearInterval(temporizador_cambio_mensaje);
	//detener_video = 0;
	// if ($("input[name='tipo_calidad']:checked").value != "fijo" && jwplayer().getBuffer() < 100){
	if (jwplayer().getBuffer() < 100){
		mensaje("--\t\tidentificando tiempo buffer");

		//getBuffer 		%
		//getPosition 		s

		var posicion_limite = jwplayer().getBuffer()*jwplayer().getDuration()/100;
		var tiempo_interseccion = posicion_limite - jwplayer().getPosition();

		buffer = jwplayer().getBuffer();

		//detener_video = tiempo_interseccion * 1000;
		temporizador_cambio_calidad = setTimeout("cambia_calidad()", tiempo_interseccion * 1000);
		// habilita_cambio_video();
		mensaje("--\t\tiniciando temporizador_cambio_calidad en "+tiempo_interseccion);
		// temporizador_cambio_mensaje = setInterval("mensaje_tiempo_cambio()", 300);

		// clearInterval(temporizador_control);
		// clearInterval(temporizador_info);
		// clearInterval(temporizador_cambio);
		// mensaje("Eventos detenidos");
		// contador_buffer++;
	} //if
} //calcula_interseccion