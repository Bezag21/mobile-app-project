const Inspection = require("../models/inspection");
const { inspectionValidation } = require("../validation/inspectionValidation");

const add_inspection = async (req, res) => {
  
 
  var insp = await Inspection.findOne({ name: req.body.address });
  if (insp) {
    res.status(401).json({
      message: "inspection already exist",
    });
    return;
  }
  var inspection = await new Inspection({
    name: req.body.name,
    address: req.body.address,
    descrption: req.body.descrption,
  });

  await inspection.save(function (err, output) {
    if (err) {
      return console.log(err);
    }

    res.status(201).json({
      message: "Created inspection successfully",
      createdProduct: {
        name: inspection.name,
        address: inspection.address,
        descrption: inspection.descrption,
      },
    });
  });
};

const edit_inspection = async (req, res) => {
  const { error } = inspectionValidation(req.body);
  if (error) return res.status(400).send({ message: error.details[0].message });

  // var insp= await Inspection.findById(req.params.id);
  // if (!insp) {
  //   res.status(401).json({
  //     message: "no such inspection",
  //   });
  //   return;
  // }

  Inspection.findOne(
    { name: req.body.address },
    async function (err, insp) {
      if (insp) {
        console.log("ok");
        (existing_insp.name = req.body.name),
        (existing_insp.address = req.body.address),
        (existing_insp.descrption = req.body.descrption),
        await existing_insp.save(function (err) {
          if (err) {
            res.status(404).json({ message: "error occurred during saving" });
          }
        });
  
      res.status(200).json({
        message: "succesfully edit",
        editedProduct: {
          name: existing_insp.name,
          address: existing_insp.address,
          descrption: existing_insp.descrption,
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
 



const all_inspection = async (req, res) => {
  var insp= await Inspection.find();
  if (!insp) {
    res.status(401).json({
      message: "there is no inspection in the store ",
    });
    return;
  }

  res.status(200).json({inspections:insp});
};



const delete_inspection = async (req, res) => {
  try {
    const inspection = await Inspection.findByIdAndRemove(req.params.id);
    // res.redirect('/admin/products')

    res.status(200).json({
      message: "succesfully delete",
      editedProduct: {
        name: inspection.name,
        address: inspection.address,
        descrption: inspection.descrption,
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

const get_inspection = async (req , res) =>{

  var  name  = req.headers["name"]; 
  console.log(name);
  
  var insps = await Inspection.find({name: name});
  if(!insp){
    res.status(401).json({
      message: "no such inspection"
    });
    console.log("search failed");
    return ;
  }
  console.log(insps);
  res.status(200).json(insps);
}

module.exports = {
  get_inspection,
  add_inspection,
  all_inspection,
  delete_inspection,
  edit_inspection,
  //inspection_detail,
};
