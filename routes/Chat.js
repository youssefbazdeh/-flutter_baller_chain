import express from "express";

import { getAll } from "../Controllers/chatController.js";
import { getChatById } from "../Controllers/chatController.js";
import { updateChat } from "../Controllers/chatController.js";
import { deleteOnce } from "../Controllers/chatController.js";
import { getAlllChatByIdUser } from "../Controllers/chatController.js";
import { addChat } from "../Controllers/chatController.js";
const router = express.Router();

router
.route("/")
.get(getAll)

router
    .route('/:id')
    .get(getChatById)
router
  .route('/:_id')
  .put(updateChat)
  .delete(deleteOnce)
  
router
  .route('/user/:user_id')
  .get(getAlllChatByIdUser)
  .post(addChat)

  

 
  

export default router;