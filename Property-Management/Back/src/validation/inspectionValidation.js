const joi = require('joi');



const inspectionValidation = (value) => {
    const inspectionSchema = joi.object({
        name: joi.string().required(),
        address: joi.string().required(),
        descrption: joi.string(),
        _id: joi.string()
    });
    return inspectionSchema.validate(value);
}

module.exports.inspectionValidation = inspectionValidation;
