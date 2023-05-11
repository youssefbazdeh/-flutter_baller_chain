import mongoose from 'mongoose';
const { Schema, model } = mongoose;

const fixtureSchema = new mongoose.Schema({
    time: {
        type: String,
        required: true
    },
    home_team: {
        type: String,
        required: true
    },
    away_team: {
        type: String,
        required: true
    }
});

export default model('Fixture', fixtureSchema);
