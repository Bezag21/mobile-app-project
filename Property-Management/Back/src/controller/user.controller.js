
const User = require("../models/user");


const edit_password = async (req, res) => {
  var user = await User.findById(req.userId);
  if (!user) {
    res.status(401).json({
      message: "no user found",
    });
    return;
  }

  const matchPassword = await User.comparePassword(req.body.old_password, user.password);

  if (matchPassword){
    const hashedPassword = await User.encryptPassword(req.body.new_password);
    user.password = hashedPassword;
    await user.save(function (err) {
    if (err) {
     res.status(404).json({ message: "error occurred during saving" });
        }
     });
  }
};

const delete_user = async (req, res) => {
  try {
   
    const user = await User.findByIdAndRemove(req.userId);

    res.status(200).json({
      message: "succesfully delete",
      editeduser: {
        name: user.name,
        username: user.username,
       
      },
    });
  } catch (err) {
    res.status(404).json({ message: "Unable to Delete"});
  }
};

const user_detail = async (req, res) => {
  var user = await User.findById(req.userId);
  if (!user) {
    res.status(401).json({
      message: "there is no user with this id ",
    });
    return;
  }

  res.status(200).json(user);
};

module.exports = {
  delete_user,
  user_detail,
  edit_password,
};
