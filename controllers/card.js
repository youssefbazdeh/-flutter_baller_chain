import fs from 'fs';
import Stat from '../models/stats.js';
import user from '../models/User.js';
import user_card from '../models/user_card.js';
import Fixture from '../models/fixtures.js';
import team from '../models/team.js';
import card from '../models/card.js';
import player from '../models/player.js';


const cards = JSON.parse(fs.readFileSync('./public/players.json', 'utf-8'));


export function addFromFile(req, res) {
    cards.forEach(card => {
        const newStat = new Stat(card.stats[0]);
        newStat.save((error, stat) => {
            if (error) {
                console.error(error);
                return;
            }

            const newCard = new Card({
                name: card.name,
                image: card.image,
                rating: card.rating,
                stats: [stat._id]
            });
            newCard.save();
        });
    });
    res.status(200).json("success");
}

export async function generatePack(req, res) {
    const cards = await card.find();
    const cardIds = cards.map(p => p._id);
    const chances = cards.map(p => 10000000000 / (Math.pow(p.rating - 20, 7 - req.params.power) + 10000000000));
    const chancesSum = chances.reduce((sum, chance) => sum + chance, 0);
    const normalizedChances = chances.map(chance => chance / chancesSum);
    const selectedCards = new Set();
    const pack = [];
    for (let i = 0; i < 15; i++) {
        const randomNumber = Math.random();
        let sum = 0;
        for (let j = 0; j < cardIds.length; j++) {
            if (selectedCards.has(cardIds[j])) continue;
            sum += normalizedChances[j];
            if (sum >= randomNumber) {
                //console.log("chance:" + normalizedChances[j] + players[j].name);
                selectedCards.add(cardIds[j]);
                const p_p = await addToUser(req.params.user, cards[j]);
                pack.push(p_p);
                break;
            }
        }
    }
    res.status(200).json(pack);
}

export function register(req, res) {
    const newPlayer = new user({
        name: req.body.name
    });
    newPlayer.save();
}

async function addToUser(idUser, idCard) {
    const User = await user.findById(idUser);
    const Card = await card.findById(idCard);
    const old_card = await user_card.findOne({ user: User._id, card: Card._id });
    var card_to_return = null;
    if (old_card) {
        return new Promise((resolve, reject) => {
            user_card.findByIdAndUpdate(old_card._id, { $inc: { niveau: 1 } }, { new: true }, (err, doc) => {
                if (err) {
                    reject(err);
                } else {
                    console.log("aa");
                    console.log(doc);
                    resolve(doc);
                }
            });
        });
    }
    else {
        const newCard = new user_card({
            card: Card._id,
            user: User._id
        });
        newCard.save();
        card_to_return = newCard;
    }
    return card_to_return
}
export function getMyCards(req, res) {
    user_card.find({ user: req.params.user }).sort({ niveau: -1 }).exec((err, cards) => {
        if (err) {
            console.error(err);
            res.status(500).json({ error: err });
        } else {
            res.status(200).json(cards);
        }
    });
}

export function getMyTeam(req, res) {
    user_card.find({ 'user': req.params.user, position: { '$gt': -1 } })
        .exec((err, cards) => {
            if (err) {
                console.error(err);
                res.status(500).json({ error: err });
            } else {
                res.status(200).json(cards);
            }
        });
}

export function changePlayerPosition(req, res) {
    user_card.findOneAndUpdate(
        { user: req.params.user, position: req.params.position },
        { position: -1 },
        { new: true },
        async (err, old_card) => {
            if (err) {
                console.error(err);
                res.status(500).json({ error: err });
            } else {
                // Update the target user_card document
                user_card.findByIdAndUpdate(
                    req.params.card,
                    { position: req.params.position },
                    { new: true },
                    (err, doc) => {
                        if (err) {
                            console.error(err);
                            res.status(500).json({ error: err });
                        } else {
                            if (doc.position === parseInt(req.params.position)) {
                                res.status(200).json("success");
                            } else {
                                res.status(200).json("error");
                            }
                        }
                    }
                );
            }
        }
    );

}

export function getFixtures(req, res) {
    Fixture.find({}).exec((err, cards) => {
        if (err) {
            console.error(err);
            res.status(500).json({ error: err });
        } else {
            res.status(200).json(cards);
        }
    });
}


export function allPlayers(req, res) {
    player.find({}).exec((err, cards) => {
        if (err) {
            console.error(err);
            res.status(500).json({ error: err });
        } else {
            res.status(200).json(cards);
        }
    });
}


export function getTeams(req, res) {
    team.find({}).exec((err, cards) => {
        if (err) {
            console.error(err);
            res.status(500).json({ error: err });
        } else {
            res.status(200).json(cards);
        }
    });
}

export function getCardById(req, res) {
    card.find({}).exec((err, cards) => {
        if (err) {
            console.error(err);
            res.status(500).json({ error: err });
        } else {
            res.status(200).json(cards);
        }
    });
}