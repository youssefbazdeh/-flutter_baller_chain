import mongoose from 'mongoose';
const { Schema, model } = mongoose;

const userSchema = new Schema(
    {
        firstname: {
            type: String,
            required: true
        },
        lastname: {
            type: String,
            required: true
        },
        email: {
            type: String,
            required: true
        },
        phonenumber: {
            type: String,
            required: false
        },
        birthday: {
            type: String,
            required: false
        },
        password: {
            type: String,
            required: true
        },
        image: {
            type: String,
            required: false
        },
        coins: {
            type: Number,
            required: false
        },
        steps: {
            type: Number,
            required: false
        },
        role: {
            type: String,
            enum: ['admin','user'],
            default: 'user',
        },
        block: {
            type: Number,
            required: false
        },
        publicAdress: {
            type: String,
            required: false
        },
        privateAdress: {
            type: String,
            required: false
        },

       /* experiences:[{
            type:mongoose.Types.ObjectId,
            ref:"Experience"
        }]*/
        
     


    },
   
);

export default model('User', userSchema);