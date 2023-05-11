import mongoose from 'mongoose';
const { Schema, model } = mongoose;

const teamSchema = new mongoose.Schema({
    name: {
        type: String,
        required: true
    },
    link: {
        type: String,
        required: true
    },
    image: {
        type: String,
        required: true
    }
});

export default model('Team', teamSchema);