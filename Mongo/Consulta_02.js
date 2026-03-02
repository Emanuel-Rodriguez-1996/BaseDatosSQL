db.ChatsConPacientes.find({
  $expr: {
    $let: {
      vars: {
        horaLocal: {
          $mod: [
            { $add: [{ $hour: "$fecha" }, 21] }, // Ajuste UTC → local (UTC-3)
            24
          ]
        }
      },
      in: {
        $or: [
          { $gte: ["$$horaLocal", 22] }, // desde 22:00 local
          { $lt: ["$$horaLocal", 6] }    // hasta 06:00 local
        ]
      }
    }
  }
})
