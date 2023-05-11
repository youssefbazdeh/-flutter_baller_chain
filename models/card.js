import mongoose from 'mongoose';
const { Schema, model } = mongoose;

const cardSchema = new mongoose.Schema({
    team: {
        type: String,
        required: true
    },
    jersey_number: {
        type: String,
        required: true
    },
    country: {
        type: String,
        required: true
    },
    link: {
        type: String,
        required: true
    },
    name: {
        type: String,
        required: true
    },
    age: {
        type: String,
        required: true
    },
    matches_played: {
        type: String,
        required: true
    },
    goals: {
        type: String,
        required: true
    },
    yellow_cards: {
        type: String,
        required: true
    },
    red_cards: {
        type: String,
        required: true
    },
    rating: {
        type: Number,
        required: true
    },
    image: {
        type: String,
        required: true
    }

});

export default model('Card', cardSchema);
