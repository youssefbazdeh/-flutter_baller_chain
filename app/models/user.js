const mongoose = require('mongoose');

const user = new mongoose.Schema({
  firstName: {
    type: String
  },
  lastName: {
    type: String
  },
  email: {
    type: String
  },
  password: {
    type: String
  },
  phone: {
    type: String
  },
  verified: {
    type: Number
  },
  affiliate: {
    type: String
  },
},{timestamps:true})

const User = mongoose.model('users', user);
module.exports = User