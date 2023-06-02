const joi = require('joi');



const uploadValidation = (value) => {
    const uploadSchema = joi.object({
        price: joi.string().required(),
        image: joi.required(),
        address: joi.string().required(),
        descrption: joi.string(),
        _id: joi.string()
    });
    return uploadSchema.validate(value);
}

module.exports.uploadValidation = uploadValidation;