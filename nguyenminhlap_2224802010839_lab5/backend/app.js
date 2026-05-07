const express = require("express");
const bodyParser = require("body-parser");
const UserRoute = require("./routes/user.routes");
const ToDoRoute = require("./routes/todo.routes");

const app = express();

app.use(bodyParser.json());

app.get("/", (req, res) => {
  res.json({ status: true, message: "🚀 Todo API is running" });
});

app.use("/", UserRoute);
app.use("/", ToDoRoute);

app.use((err, req, res, next) => {
  res
    .status(500)
    .json({ status: false, message: err.message || "Internal Server Error" });
});

module.exports = app;
