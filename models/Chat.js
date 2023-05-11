import mongoose from 'mongoose';
const { Schema, model } = mongoose;

const chatSchema = new Schema(
    {
        user_id: { 
            type: Schema.Types.ObjectId, 
            ref: "users" 
          },
        message: {
            type: String,
            required: true
        },

    },
    {
        timestamps:true
        }
   
);

export default model('Chat', chatSchema);