let express = require("express");
let cors = require("cors");

const app = express();
let rootPath = "/app/src/";
app.get("/", (request, response) => {
  response.sendFile(rootPath + "calculette.html");
});
app.get("/app.js", (request, response) => {
  response.sendFile(rootPath + "app.js");
});
app.get("/app.css", (request, response) => {
  response.sendFile(rootPath + "app.css");
});

app.listen(8080, () => {
  console.log(`Server listening on port 8090`);
});
