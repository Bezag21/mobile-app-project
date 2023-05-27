const express = require("express");
const app = express();
const mongoose = require("mongoose");
const { MONGO_DB_CONFIG } = require("./config/app.config");
const errors = require("./middleware/errors.js");
const swaggerUi = require("swagger-ui-express"), swaggerDocument = require("./swagger.json");
const cors = require("cors")
const multer= require("multer");

mongoose.Promise = global.Promise;
mongoose.set('strictQuery', true);
mongoose
  .connect(MONGO_DB_CONFIG.DB, {
    useNewUrlParser: true,
    useUnifiedTopology: true,
  })
  .then(
    () => {
      console.log("Database connected");
    },
    (error) => {
      console.log("Database can't be connected: " + error);
    }
  );

app.use(express.json());

app.use("/uploads", express.static("uploads"));

// initialize routes
app.use("/api", require("./routes/app.routes"));

app.use(errors.errorHandler);

app.use("/api-docs", swaggerUi.serve, swaggerUi.setup(swaggerDocument));




const Path = require('path');

const storage = multer.diskStorage({
  destination: function (req, file, cb) {
    cb(null, "./uploads");
  },
  filename: function (req, file, cb) {
    cb(null, Date.now() + "--" + file.originalname);
  },
});

const fileFilter = (req, file, callback) => {
  const acceptableExtensions = [".png", ".jpg", ".mp4"];
  if (!acceptableExtensions.includes(Path.extname(file.originalname))) {
    return callback(new Error("Only .png, .jpg and .jpeg format allowed!"));
  }

  const fileSize = parseInt(req.headers["content-length"]);
  if (fileSize > 1048576) {
    return callback(new Error("File Size Big"));
  }

  callback(null, true);
};

let upload = multer({
  storage: storage,
  fileFilter: fileFilter,
  fileSize: 1048576, // 10 Mb
});

module.exports = upload.single("productImage");

app.post('/upload', upload.single('file'), (req, res) => {
  // Return URL of uploaded file as a response
  res.json({ url: `http://localhost:53807/${req.file.filename}` });
});
// listen for requests
app.listen(process.env.port || 5000, function () {
  console.log("Ready to Go!");
});
