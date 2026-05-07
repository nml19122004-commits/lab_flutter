const UserServices = require("../services/user.service");

const JWT_SECRET = process.env.JWT_SECRET || "your_jwt_secret_key";
const JWT_EXPIRY = "1h";

exports.register = async (req, res, next) => {
  try {
    const { email, password } = req.body;
    if (!email || !password)
      return res
        .status(400)
        .json({ status: false, message: "Email and password are required" });

    const duplicate = await UserServices.getUserByEmail(email);
    if (duplicate)
      return res
        .status(409)
        .json({
          status: false,
          message: `Email ${email} is already registered`,
        });

    await UserServices.registerUser(email, password);
    res
      .status(201)
      .json({ status: true, success: "User registered successfully" });
  } catch (err) {
    next(err);
  }
};

exports.login = async (req, res, next) => {
  try {
    const { email, password } = req.body;
    if (!email || !password)
      return res
        .status(400)
        .json({ status: false, message: "Email and password are required" });

    const user = await UserServices.checkUser(email);
    if (!user)
      return res
        .status(404)
        .json({ status: false, message: "User does not exist" });

    const isPasswordCorrect = await user.comparePassword(password);
    if (!isPasswordCorrect)
      return res
        .status(401)
        .json({ status: false, message: "Email or password is incorrect" });

    const tokenData = { _id: user._id, email: user.email };
    const token = await UserServices.generateAccessToken(
      tokenData,
      JWT_SECRET,
      JWT_EXPIRY,
    );

    res.status(200).json({ status: true, success: "Login successful", token });
  } catch (error) {
    next(error);
  }
};
