
const Upload = require("../models/products.js");
const { uploadValidation } = require("../validation/uploadValidation");

const add_upload= async (req, res) => {
  
  var up = await Upload.findOne({ address: req.body.address });
  if (up) {
    res.status(401).json({
      message: "space already exist",
    });
    return;
  }
  var upload = await new Upload({
    price: req.body.price,
    address: req.body.address,
    descrption: req.body.descrption,
    image: req.body.image,
  });

  await upload.save(function (err, output) {
    if (err) {
      return console.log(err);
    }

    res.status(201).json({
      message: "Created successfully",
      createdProduct: {
        name: upload.name,
        address: upload.address,
        descrption: upload.descrption,
        image: upload.image
      },
    });
  });
};
const edit_upload = async (req, res) => {
  const { error } = uploadValidation(req.body);
  if (error) return res.status(400).send({ message: error.details[0].message });

  var up= await Upload.findById(req.params.id);
  if (!up) {
    res.status(401).json({
      message: "no such Entry",
    });
    return;
  }

  Inspection.findOne(
    { address: req.body.address },
    async function (err, insp) {
      if (insp) {
        console.log("ok");
        (existing_insp.price = req.body.price),
        (existing_insp.address = req.body.address),
        (existing_insp.descrption = req.body.descrption),
        (existing_insp.image = req.body.image),
        await existing_insp.save(function (err) {
          if (err) {
            res.status(404).json({ message: "error occurred during saving" });
          }
        });
  
      res.status(200).json({
        message: "succesfully edited",
        editedProduct: {
          price: existing_insp.price,
          address: existing_insp.address,
          descrption: existing_insp.descrption,
          image: existing_insp.image,
        },
      });
      }
     

      // Inspection.findById(req.body.id, async function (err, existing_insp) {
      //   if (err) {
      //     res.status(404).json({ message: "inspection not found" });
      //     return;
      //   }
      //   (existing_insp.name = req.body.name),
      //     (existing_insp.address = req.body.address),
      //     (existing_insp.descrption = req.body.descrption),
      //     await existing_insp.save(function (err) {
      //       if (err) {
      //         res.status(404).json({ message: "error occurred during saving" });
      //       }
      //     });

      //   res.status(200).json({
      //     message: "succesfully edit",
      //     editedProduct: {
      //       name: existing_insp.name,
      //       address: existing_insp.address,
      //       descrption: existing_insp.descrption,
      //     },
      //   });
      });
    }
 



const all_upload = async (req, res) => {
  var up= await Upload.find();
  if (!up) {
    res.status(401).json({
      message: "there is no data in the store ",
    });
    return;
  }

  res.status(200).json({uploads:up});
};



const delete_upload = async (req, res) => {
  try {
    const upload = await Upload.findByIdAndRemove(req.params.id);
    // res.redirect('/admin/products')

    res.status(200).json({
      message: "succesfully delete",
      editedProduct: {
        price: upload.price,
        address: upload.address,
        descrption: upload.descrption,
      },
    });
  } catch (err) {
    res.status(404).json({ message: "internal server error" });
  }
};

// const inspection_detail = async (req, res) => {
//   var insp= await inspection.findById(req.params.id);
//   if (!insp) {
//     res.status(401).json({
//       message: "there is no inspection in the store ",
//     });
//     return;
//   }
//   res.status(200).json(insp);
// };

const get_upload = async (req , res) =>{

  var  address  = req.headers["address"]; 
  console.log(name);
  
  var up = await Upload.find({address: address});
  if(!up){
    res.status(401).json({
      message: "no such data"
    });
    console.log("search failed");
    return ;
  }
  console.log(up);
  res.status(200).json(up);
}

module.exports = {
  get_upload,
  add_upload,
  all_upload,
  delete_upload,
  edit_upload,
  //inspection_detail,
};
