import { validationResult } from 'express-validator'; // Importer express-validator
import User from '../models/User.js';
import bcrypt from 'bcryptjs';
import jwt from "jsonwebtoken";
import { signAccessToken, signRefreshToken } from "../Middlewares/Auth.js";
import nodemailer from 'nodemailer';
import http from "http";
import crypto from "crypto";
import auth from "../Middlewares/Auth.js"
import { newAccount } from './token.js';

export async function convertToCoins(req, res) {
  // Update user and add steps to coins
  User.findOne({ _id: req.body.userid })
      .then((user) => {
          if (user) {
              const steps = user.steps;
              return User.findOneAndUpdate({ _id: req.body.userid }, { $inc: { coins: steps, steps: -steps } }, { new: true });
          } else {
              throw new Error("User not found");
          }
      })
      .then((updatedUser) => {
          res.status(200).json(updatedUser);
      })
      .catch((error) => {
          res.status(500).json({ error: error });
      });

}


export function getAllUsers(req, res) {
    User
    .find({})
    .then(docs => {
        res.status(200).json(docs);
    })
    .catch(err => {
        res.status(500).json({ error: err });
    });
}

export function getUsers(req, res) {
  User.find({ role: "user" })
    .then(users => {
      res.status(200).json(users);
    })
    .catch(err => {
      res.status(500).json({ error: err });
    });
}

export function getUserById(req, res) {
    User
    .findOne({ "_id": req.auth.userId })
    .then(docs => {
        res.status(200).json(docs);
    })
    .catch(err => {
        res.status(500).json({ error: err });
    });
}
export function getUserByIdAncien(req, res) {
  User
  .findOne({ "_id": req.params._id })
  .then(docs => {
      res.status(200).json(docs);
  })
  .catch(err => {
      res.status(500).json({ error: err });
  });
}

/*export function getUserByAccessToken(req, res) {
  const accessToken = req.headers.authorization;
  if (!accessToken) {
    res.status(401).json({ error: "Access token missing" });
    return;
}
jwt.verify(accessToken, "yourSecretKey", (err, decoded) => {
  if (err) {
      res.status(401).json({ error: "Invalid access token" });
      return;
  }
  User
  .findOne({ "accessToken": accessToken})
  .then(docs => {
    if (docs){
      res.status(200).json(docs);
   } else {
    res.status(404).json({ error: "User not found" });
   }
})
  .catch(err => {
      res.status(500).json({ error: err });
  });
});
}*/



export function DeleteUser(req, res) {
  User
  .findOneAndDelete({ "_id": req.params._id })
  .then(docs => {
      res.status(200).json(docs);
  })
  .catch(err => {
      res.status(500).json({ error: err });
  });
}

export function blockUser(req, res) {
  User.findOneAndUpdate(
    { "_id": req.params._id }, // Rechercher l'utilisateur par son ID
    { block: 1 }, // Mettre à jour l'attribut "block" à 1
    { new: true } // Renvoyer le document utilisateur mis à jour
  )
    .then(user => {
      if (!user) {
        return res.status(404).json({ error: 'Utilisateur non trouvé' });
      }
      res.status(200).json(user);
    })
    .catch(err => {
      res.status(500).json({ error: err });
    });
}

export function UnblockUser(req, res) {
  User.findOneAndUpdate(
    { "_id": req.params._id }, // Rechercher l'utilisateur par son ID
    { block: 0 }, // Mettre à jour l'attribut "block" à 1
    { new: true } // Renvoyer le document utilisateur mis à jour
  )
    .then(user => {
      if (!user) {
        return res.status(404).json({ error: 'Utilisateur non trouvé' });
      }
      res.status(200).json(user);
    })
    .catch(err => {
      res.status(500).json({ error: err });
    });
}



export async function addUser(req, res) {
    // Trouver les erreurs de validation dans cette requête et les envelopper dans un objet
    if(!validationResult(req).isEmpty()) {
        res.status(400).json({ errors: validationResult(req).array() });
    }
    const hashPass = await bcrypt.hash(req.body.password, 10);
    const account = await newAccount();

    
        // Invoquer la méthode create directement sur le modèle
        User
        .create({
            firstname: req.body.firstname,
            lastname: req.body.lastname,
            email: req.body.email,
            phonenumber: req.body.phonenumber,
            birthday:req.body.birthday,
            password:hashPass,
            // Récupérer l'URL de l'image pour l'insérer dans la BD
            image:`${req.protocol}://${req.get('host')}/img/${req.file.filename}`,
            coins:0,
            steps:0,
            publicAdress: account.address,
            privateAdress: account.privateKey,
            role:"user",
            block:0
        })
        .then(newUser=> {
            res.status(200).json(newUser);
        })
        .catch(err => {
          console.log(err)
            res.status(500).json({ error: err });
        });

    
}



export function updateUser(req, res) {
    User
    .updateOne({ "_id": req.params._id },  { $set: req.body })
    .then(doc => {
        res.status(200).json("Profile updated");
    })
    .catch(err => {
        res.status(500).json({ error: err });
    });
}




login: async (req, res, next) => {
    try {
      const result = await authSchema.validateAsync(req.body)
      const user = await User.findOne({ email: result.email })
      if (!user) throw createError.NotFound('User not registered')

      const isMatch = await user.isValidPassword(result.password)
      if (!isMatch)
        throw createError.Unauthorized('email/password not valid')

      const accessToken = await signAccessToken(user.id)
      const refreshToken = await signRefreshToken(user.id)

      res.send({ accessToken, refreshToken })
    } catch (error) {
      if (error.isJoi === true)
        return next(createError.BadRequest('Invalid email/Password'))
      next(error)
    }
  }

  export async function login(req, res, next) {
    try {
      const { email, password } = req.body;
  
     
      const user = await User.findOne({ email });
      if (!user) {
        return res.status(401).json({
          message: "No user found",
        });
      }
      
      if (user.block===1) {
        return res.status(202).json({
          message: "User blocked",
        });
      }
  
      const passwordMatches = await bcrypt.compare(password, user.password);
      if (!passwordMatches) {
        return res.status(401).json({
          message: "Password does not match",
        });
      }
  
      const accessToken = await signAccessToken(user.id);
      // const refreshToken = await signRefreshToken(user.id);
      res.status(200).json({
        message: "Login successful",
        accessToken,
        // refreshToken,
        user
      });
    } catch (error) {
        console.log(error)
      return res.status(500).json({
        message: "Error logging in",
        error,
      });
    }
  }

    export function forgotPassword(req, res) {
      const { email } = req.body;
      User.findOne({ email })
        .then((user) => {
          if (!user) {
            return res
              .status(401)
              .json({ message: "Aucun utilisateur trouvé avec cet email." });
          }
          const token = crypto.randomBytes(100).toString("hex");
          user.resetPasswordToken = token;
          user.resetPasswordExpires = Date.now() + 360000; // 1 hour
          user
            .save()
            .then((updatedUser) => {
              const transporter = nodemailer.createTransport({
                service: "gmail",
                auth: {
                  user: "ouerghi.bilel@esprit.tn",
                  pass: "doefbhtccfjdgjse",
                },
              });
              const mailOptions = {
                from: "Bilel",
                to: email,
                subject: "Mot de passe oublié",
                text: `Hello ${user.firstname} ${user.lastname}\nPour réinitialiser votre mot de passe,veuillez cliquer sur le lien suivant:\n\nhttp://localhost:9095/user/reset/${token}\n\nSi vous n'avez pas demandé une réinitialisation de mot de passe, veuillez ignorer ce message.`,
              };
              transporter.sendMail(mailOptions, (error) => {
                if (error) {
                  console.log(error)
                  return res.status(500).json({ error });
                }
                return res.status(200).json({
                  message:
                    "Un email de réinitialisation de mot de passe a été envoyé.",
                });
              });
            })
            .catch((error) => {
              console.log("error");
              return res.status(500).json({ error });
            });
        })
        .catch((error) => {
          console.log("error");
          return res.status(500).json({ error });
        });
    }
  ///////////////////reset password/////////////////////////////////////
  
  export async function resetPassword(req, res) {
    try {
      const user = await User.findOne({
        resetPasswordToken: req.body.token,
        resetPasswordExpires: { $gt: Date.now() },
      });
      if (!user) {
        return res.status(401).json({
          message: "Invalid or expired password reset token.",
        });
      }
      const hashPass = await bcrypt.hash(req.body.password, 10);
      user.password = hashPass;
      user.resetPasswordToken = undefined;
      user.resetPasswordExpires = undefined;
  
      await user.save();
  
      return res.status(200).json({ message: "Password reset successful." });
    } catch (error) {
      return res.status(500).json({ error });
    }
  }
  
  
  export async function generateview(req, res) {
    try {
      return res.render("reset-password.ejs", { token: req.params.token });
    } catch (error) {
      return res.status(400).json(error);
    }
  }
 

  

