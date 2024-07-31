const express = require("express");
const cors = require("cors");

const app = express();
// Routes
app.use(express.static("public"));
app.use(cors());

app.get("/", (req, res) => {
  res.sendFile("./app/src/calculette.html");
});
app.get("/app.js", (req, res) => {
  res.sendFile("./app/src/app.js");
});
app.get("/app.css", (req, res) => {
  res.sendFile("./app/src/app.css");
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
