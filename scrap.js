import fetch from "node-fetch";
import fs, { writeFile } from "fs";

fetch("https://rss.app/feeds/v1.1/tXjUKApbFSYBGFjF.json")
  .then((res) => res.json())
  .then((json) => {
    const articles = json.items.slice(0, 20); // extraire les 20 premiers articles
    fs.writeFile("news.json", JSON.stringify(articles), (err) => {
      if (err) {
        console.log("Erreur lors de l'écriture du fichier : ", err);
      } else {
        console.log("Le fichier a été enregistré avec succès !");
      }
    });
  })
  .catch((err) => console.log(err));
  
//const newsData = fs.readFile('news.json', 'utf-8');
/*
const readFileAsync = (file, encoding) => {
  return new Promise((resolve, reject) => {
    fs.readFile(file, encoding, (err, data) => {
      if (err) {
        reject(err);
      } else {
        resolve(data);
      }
    });
  });
};
const newsData = fs.readFileSync('news.json', 'utf-8');

readFileAsync('news.json', 'utf-8')
  .then((newsData) => {
    // Faire quelque chose avec les données lues depuis le fichier
    console.log(newsData);
  })
  .catch((err) => {
    // Gérer les erreurs
    console.error(err);
  });*/
//export default newsData;
