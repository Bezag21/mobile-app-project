const { findById } = require('../models/user');
const User = require('../models/user');


const admin = async ()=>{
    try {

        const adminList = await User.find({roles: "admin"});
        return adminList
        
    } catch (error) {
        console.log(error);  
    }
}

const role = async (id)=>{
    try {
        const user = await User.findById(id);
        const role = user.roles;
        return role;
    } catch (error) {
        console.log(error)
    }
}

module.exports = {admin, role};