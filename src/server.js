const express = require("express");
const path = require("path"); // Importez le module path
const cors = require("cors");

const app = express();
// Routes
app.use(express.static("public"));
app.use(cors());

app.get("/", (req, res) => {
  res.sendFile(path.join("app/src/calculette.html")); // Remplacez 'index.html' par votre fichier HTML principal
});
app.get("/app.js", (request, response) => {
  response.sendFile("app/src/app.js");
});
app.get("/app.css", (request, response) => {
  response.sendFile("app/src/app.css");
});

// app.get("/", (req, res) => {
//   res.sendFile("C:/xampp/php/www/DSP-projet/src/calculette.html"); // Remplacez 'index.html' par votre fichier HTML principal
// });
// app.get("/app.js", (request, response) => {
//   response.sendFile("C:/xampp/php/www/DSP-projet/src/app.js");
// });
// app.get("/app.css", (request, response) => {
//   response.sendFile("C:/xampp/php/www/DSP-projet/src/app.css");
// });

https: app.listen(3000, () => {
  console.log(`Server listening on port 3000`);
});
