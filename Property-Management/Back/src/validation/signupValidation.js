// Import validation module
const Joi = require('joi');

// Define validation for user signup
const pattern = new RegExp("^(((?=.*[a-z])(?=.*[A-Z]))|((?=.*[a-z])(?=.*[0-9]))|((?=.*[A-Z])(?=.*[0-9])))(?=.{6,})");
const signupValidation = (data) => {
    const signUpSchema = Joi.object({
        name : Joi.string().required().min(3),
        username: Joi.string().required().min(4),
       
        password: Joi.string().required().min(4),
        roles : Joi.string()
    });
    const pass = signUpSchema.validate(data);
    return pass;
}



module.exports.signupValidation = signupValidation;