use ClinicaNewAgeMongoObligatorio;
/*db.Multimedia.drop();
db.ChatsConPacientes.drop();
db.EncuestasSatisfaccion.drop();*/


/*ChatsConPacientes*/
db.ChatsConPacientes.insertMany([
  {
    id_chat: 1,
    paciente_id: 1,
    profesional_id: 1,
    fecha: ISODate("2023-02-14T23:30:00Z"), // NOCTURNO
    mensajes: [
      {
        fecha: ISODate("2023-02-14T23:31:00Z"),
        texto: "Doctor, me subió la presión recién.",
        audio: null,
        adjunto: null
      },
      {
        fecha: ISODate("2023-02-14T23:33:00Z"),
        texto: "Controlate nuevamente en 10 minutos y avísame.",
        audio: null,
        adjunto: null
      }
    ]
  },
  {
    id_chat: 2,
    paciente_id: 6,
    profesional_id: 1,
    fecha: ISODate("2024-01-10T20:00:00Z"),
    mensajes: [
      {
        fecha: ISODate("2024-01-10T20:02:00Z"),
        texto: "Doctor, sigo sintiendo palpitaciones.",
        audio: null,
        adjunto: null
      }
    ]
  },
  {
    id_chat: 3,
    paciente_id: 8,
    profesional_id: 2,
    fecha: ISODate("2024-02-12T02:30:00Z"), // NOCTURNO
    mensajes: [
      {
        fecha: ISODate("2024-02-12T02:31:00Z"),
        texto: "Me comenzó picazón fuerte.",
        audio: null,
        adjunto: "foto_lesion_base64"
      }
    ]
  },
  {
    id_chat: 4,
    paciente_id: 10,
    profesional_id: 3,
    fecha: ISODate("2024-03-05T17:00:00Z"),
    mensajes: [
      {
        fecha: ISODate("2024-03-05T17:05:00Z"),
        texto: "Mi hijo sigue con tos.",
        audio: null,
        adjunto: null
      }
    ]
  },
  {
    id_chat: 5,
    paciente_id: 5,
    profesional_id: 5,
    fecha: ISODate("2025-02-20T21:00:00Z"),
    mensajes: [
      {
        fecha: ISODate("2025-02-20T21:02:00Z"),
        texto: "Doctor, ¿me confirma hora de mi terapia?",
        audio: null,
        adjunto: null
      }
    ]
  }
]);

/*MultimediaConsultas*/
db.MultimediaConsultas.insertMany([
  {
    id_consulta: 1,
    paciente_id: 1,
    profesional_id: 1,
    tipo: "pdf",
    archivo_base64: "receta_losartan_base64",
    descripcion: "Plan de control de hipertensión"
  },
  {
    id_consulta: 1,
    paciente_id: 1,
    profesional_id: 1,
    tipo: "audio",
    archivo_base64: "audio_indicaciones_base64",
    descripcion: "Audio explicando dosis correcta"
  },
  {
    id_consulta: 8,
    paciente_id: 8,
    profesional_id: 2,
    tipo: "imagen",
    archivo_base64: "foto_dermatitis_base64",
    descripcion: "Imagen de dermatitis enviada por paciente"
  },
  {
    id_consulta: 11,
    paciente_id: 10,
    profesional_id: 3,
    tipo: "audio",
    archivo_base64: "ejercicios_respiratorios_audio_base64",
    descripcion: "Instrucciones vocales"
  },
  {
    id_consulta: 15,
    paciente_id: 4,
    profesional_id: 6,
    tipo: "video",
    archivo_base64: "video_estiramientos_lumbar_base64",
    descripcion: "Video ejercicios de espalda"
  },
  {
    id_consulta: 20,
    paciente_id: 4,
    profesional_id: 4,
    tipo: "pdf",
    archivo_base64: "guia_migrana_pdf_base64",
    descripcion: "Guía para migraña crónica"
  }
]);


/*EncuestasBienestar*/
db.EncuestasBienestar.insertMany([
  {
    paciente_id: 1,
    fecha: ISODate("2024-06-10"),
    respuestas: [
      { pregunta: "Nivel de estrés (1-10)", valor: 7 },
      { pregunta: "Calidad del sueño (1-10)", valor: 6 }
    ],
    observaciones: "Estrés laboral"
  },
  {
    paciente_id: 1,
    fecha: ISODate("2024-07-10"),
    respuestas: [
      { pregunta: "Nivel de estrés (1-10)", valor: 5 },
      { pregunta: "Calidad del sueño (1-10)", valor: 7 }
    ],
    observaciones: "Mejoría significativa"
  },
  {
    paciente_id: 8,
    fecha: ISODate("2024-07-07"),
    respuestas: [
      { pregunta: "Bienestar general (1-10)", valor: 8 },
      { pregunta: "Ansiedad (1-10)", valor: 3 }
    ],
    observaciones: "Mejora dermatológica"
  },
  {
    paciente_id: 5,
    fecha: ISODate("2025-02-20"),
    respuestas: [
      { pregunta: "Estrés (1-10)", valor: 5 },
      { pregunta: "Motivación (1-10)", valor: 7 }
    ],
    observaciones: "Inicio de terapia"
  },
  {
    paciente_id: 3,
    fecha: ISODate("2024-09-15"),
    respuestas: [
      { pregunta: "Estado de ánimo (1-10)", valor: 4 },
      { pregunta: "Estrés (1-10)", valor: 8 }
    ],
    observaciones: "Alta carga laboral"
  }
]);


