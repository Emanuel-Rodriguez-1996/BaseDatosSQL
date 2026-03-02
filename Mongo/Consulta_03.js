db.EncuestasBienestar.aggregate([
  { $unwind: "$respuestas" },

  {
    $group: {
      _id: {
        year: { $year: "$fecha" },
        month: { $month: "$fecha" }
      },
      promedioSatisfaccion: { $avg: "$respuestas.valor" },
      cantidadEncuestas: { $sum: 1 }
    }
  },

  { $sort: { "_id.year": 1, "_id.month": 1 } }
]);
