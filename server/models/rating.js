const mongoose = require("mongoose");

ratingSchema = mongoose.Schema({
    userId:{
        type:String,
        required:true,
    },
    rating:{
        type:Number,
        required:true,
    },
});

module.exports =  ratingSchema;