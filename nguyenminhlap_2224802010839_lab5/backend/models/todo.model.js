const db = require("../config/db");
const UserModel = require("./user.model");
const mongoose = require("mongoose");
const { Schema } = mongoose;

const toDoSchema = new Schema(
  {
    userId: {
      type: Schema.Types.ObjectId,
      ref: UserModel.modelName,
      required: [true, "userId is required"],
    },
    title: {
      type: String,
      required: [true, "Title is required"],
    },
    description: {
      type: String,
      required: [true, "Description is required"],
    },
  },
  { timestamps: true },
);

const ToDoModel = db.model("todo", toDoSchema);
module.exports = ToDoModel;
