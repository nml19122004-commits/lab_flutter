const ToDoModel = require("../models/todo.model");

class ToDoService {
  static async createToDo(userId, title, description) {
    const createToDo = new ToDoModel({ userId, title, description });
    return await createToDo.save();
  }

  static async getUserToDoList(userId) {
    return await ToDoModel.find({ userId }).sort({ createdAt: -1 });
  }

  static async deleteToDo(id) {
    return await ToDoModel.findByIdAndDelete({ _id: id });
  }
}

module.exports = ToDoService;
