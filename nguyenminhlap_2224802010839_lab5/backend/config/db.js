const mongoose = require("mongoose");

const MONGO_URI = process.env.MONGO_URI || "mongodb://127.0.0.1:27017/ToDoDB";

const connection = mongoose
  .createConnection(MONGO_URI)
  .on("open", () => {
    console.log("✅ MongoDB Connected");
  })
  .on("error", (err) => {
    console.error("❌ MongoDB Connection Error:", err.message);
  });

module.exports = connection;
