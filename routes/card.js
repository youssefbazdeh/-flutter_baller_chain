import express from 'express';
import {  generatePack, getMyCards, getMyTeam, changePlayerPosition, getFixtures, allPlayers, getTeams, getCardById } from '../controllers/card.js';
import { update_cards2 } from '../controllers/scraper.js';
const router = express.Router();

/*router
    .route('').get(addFromFile);*/
router
    .route('/pack/:user/:power').get(generatePack);
/*router
    .route('/register').post(register);*/
router
    .route('/cards/:user').get(getMyCards);
router
    .route('/team/:user').get(getMyTeam);
router
    .route('/position/:user/:card/:position').get(changePlayerPosition);
/*router
    .route('/newList').get(get_cards_flashscore);*/
router
    .route('/updateCards').get(update_cards2);
router
    .route('/getFixtures').get(getFixtures);

router
    .route('/allPlayers').get(allPlayers);
router
    .route('/getTeams').get(getTeams);
router
    .route('/getCards').get(getCardById);
export default router;