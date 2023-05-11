import Chat from "../Models/Chat.js";
import { Server } from "socket.io";


export function getAll(req, res) {
  Chat
      .find({})
      .then(docs => {
          res.status(200).json(docs);
      })
      .catch(err => {
          res.status(500).json({ error: err });
      });
}


export function getAlllChatByIdUser(req, res) {
  Chat
  .find({"user_id": req.params.user_id })

  .then(Chat=> {
      res.status(200).json(Chat);
  })
  .catch(err => {
      res.status(500).json({ error: err });
  });
}





export function updateChat(req, res) {
  Chat.updateOne({ _id: req.params._id }, { $set: req.body })
    .then((doc) => {
      res.status(200).json("Chat updated");
    })
    .catch((err) => {
      res.status(500).json({ error: err });
    });
}

export function addChat(req, res) {
  Chat.create({
    user_id: req.params.user_id,    
    message: req.body.message,  })
    .then((newChat) => {
      res.status(201).json(newChat);
      console.log(newChat);
    })
    .catch((err) => {
      res.status(400).json(err);
    });
}



export function getChatById(req, res) {
  Chat.findOne({ _id: req.params.id })
    .then((docs) => {
      res.status(200).json(docs);
    })
    .catch((err) => {
      res.status(500).json({ error: err });
    });
}



export function deleteOnce(req, res) {
  Chat
      .findOneAndRemove({ "_id": req.params._id })
      .then(doc => {
          res.status(200).json(doc);
      })
      .catch(err => {
          res.status(500).json({ error: err });
      });
}



const users = [
  {
    userId: "",
    socketId: "",
  },
];
export default async function initSocketCommunication(io) {
  io.on("connection", (socket) => {
    console.log("Client Connected.");
    socket.on("register", (data) => {
      const indexUser = users.findIndex((object) => {
        return object.userId === data;
      });
      if (indexUser === -1) {
        users.push({
          userId: data,
          socketId: socket.id,
        });
      } else {
        users[indexUser] = {
          userId: data,
          socketId: socket.id,
        };
      }
      console.log(users);
    });
    socket.on("send_message", async (data) => {
      console.log(data);
      users.map(async (elt, index) => {
      
      });
      const sender = users.find((elt) => elt.socketId === socket.id)?.userId;
      if (!sender) {
        console.log("User not registered.");
        socket.emit("error", "User not registered.");
        return;
      }
      try {
        const chat = new Chat({
          user_id: sender,
          message: data.message,
        });
        await chat.save();
        console.log("Message saved successfully.");
        io.emit("receive_message", data);
      } catch (error) {
        console.log("Error while saving message:", error);
        socket.emit("error", "Error while saving message");
        return;
      }
    });
    socket.on("disconnect", function (data) {
      console.log("Client Disconnected.");
      socket.broadcast.emit("user_leave", data);
    });
  });
}