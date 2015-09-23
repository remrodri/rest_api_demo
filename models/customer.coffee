mongoose = require 'mongoose'
schema   = mongoose.Schema

customer = new schema(
  name:
    type: String
    required: true
  email:
    type: String
    required: true
    unique: true
  preferred_barber:
    type: String
    required: true)

module.exports = mongoose.model 'customer', customer