db.MultimediaConsultas.find(
  {
    id_consulta: 1,
    tipo: { $in: ["audio", "video"] }
  }
);
