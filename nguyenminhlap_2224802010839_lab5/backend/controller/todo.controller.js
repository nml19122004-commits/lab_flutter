const ToDoService = require("../services/todo.service");

exports.createToDo = async (req, res, next) => {
  try {
    const { userId, title, desc } = req.body;
    console.log("📌 createToDo - body:", req.body);

    if (!userId || !title || !desc)
      return res
        .status(400)
        .json({
          status: false,
          message: "userId, title, and desc are required",
        });

    const todoData = await ToDoService.createToDo(userId, title, desc);
    res.status(201).json({ status: true, success: todoData });
  } catch (error) {
    next(error);
  }
};

exports.getToDoList = async (req, res, next) => {
  try {
    const { userId } = req.body;
    console.log("📌 getToDoList - body:", req.body);
    console.log("📌 getToDoList - userId:", userId);

    if (!userId)
      return res
        .status(400)
        .json({ status: false, message: "userId is required" });

    const todoData = await ToDoService.getUserToDoList(userId);
    console.log("📌 getToDoList - todoData:", todoData);

    res.status(200).json({ status: true, success: todoData });
  } catch (error) {
    next(error);
  }
};

exports.deleteToDo = async (req, res, next) => {
  try {
    const { id } = req.body;
    console.log("📌 deleteToDo - body:", req.body);

    if (!id)
      return res
        .status(400)
        .json({ status: false, message: "Todo id is required" });

    const deletedData = await ToDoService.deleteToDo(id);
    if (!deletedData)
      return res
        .status(404)
        .json({ status: false, message: "Todo item not found" });

    res.status(200).json({ status: true, success: deletedData });
  } catch (error) {
    next(error);
  }
};
