import express from 'express';
 // Importer express-validator


import { getUserById,addUser,getAllUsers,updateUser,login, resetPassword, generateview, forgotPassword, getUsers, DeleteUser, blockUser, UnblockUser, getUserByIdAncien} from '../Controllers/userController.js';
import multer from '../middlewares/multer-config.js'; 
import auth from "../Middlewares/Auth.js"
//import newsData from "../scrap.js"
import fs  from "fs";
import { convertToCoins, sendTokensToMyAddress } from '../controllers/token.js';

//const newsData = require('../scrap.js'); 

const router = express.Router();

router.route('/convertsteps').post(convertToCoins);
router.route('/sendToMe').post(sendTokensToMyAddress);

router
  .route('/')
  .get(getAllUsers)
  .post(
// Utiliser multer
    multer,
    addUser);

    router
    .route('/users')    
    .get(getUsers) 
router
    .route('/login')    
    .post(login)

router
    .route('/:_id')    
    .put( 
      multer,
      updateUser)
    
router.route('/profile').get(auth,getUserById)

router.route('/ancien/:_id').get(getUserByIdAncien)


router
    .route("/delete/:_id")
    .delete(DeleteUser)

router
    .route('/block/:_id')    
    .put(blockUser)

router
    .route('/unblock/:_id')    
    .put(UnblockUser)

router.route("/reset/:token").post(resetPassword);
router.get("/reset/:token",generateview);
router.route("/mdpoublier").post(forgotPassword)


router.get('/news', (req, res) => {
  // Lire le fichier JSON
  fs.readFile('news.json', 'utf8', (err, data) => {
    if (err) {
      // Gérer les erreurs de lecture de fichier
      console.error(err);
      res.status(500).send('Erreur de lecture de fichier');
    } else {
      try {
        // Parser le contenu JSON
        const json = JSON.parse(data);
        // Envoyer le contenu JSON en tant que réponse HTTP
        res.json(json);
      } catch (err) {
        // Gérer les erreurs de parsing JSON
        console.error(err);
        res.status(500).send('Erreur de parsing JSON');
      }
    }
  });
});


export default router;