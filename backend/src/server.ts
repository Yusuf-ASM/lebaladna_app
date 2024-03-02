import express from "express";
import { getDate } from "./utility";

require("dotenv").config();
const PORT = process.env.PORT || "8080";

const app = express();


app.use(express.json());


app.all("*", (req, res) => {
  res.send({ potato: Date.now() });
});

app.listen(PORT, async () => {
  console.log("Running: 8080");
  console.log(getDate(true));
});
