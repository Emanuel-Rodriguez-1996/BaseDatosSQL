db.MultimediaConsultas.find(
  { paciente_id: 1 }
).sort({ tipo: 1, _id: 1 });
