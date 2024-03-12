import WebSocket from "ws";
import express from "express";
import { getDate } from "./utility";
import * as backend from "./backend";
import * as db from "./db";
import cors from "cors";
require("dotenv").config();
const PORT = process.env.PORT || "8080";

const app = express();
const admin = express.Router();
const facilitator = express.Router();
const station = express.Router();
const kitchen = express.Router();

const wss = new WebSocket.Server({ noServer: true, path: "/ws" });

/*
- station leader will add dish and it should be pushed to db 
- if facilitator accept any thing this thing should be pushed to database
- my role function :)
*/

app.use(express.json());
app.use(cors());

app.use("/admin", admin);
app.use("/facilitator", facilitator);
app.use("/station", station);
app.use("/kitchen", kitchen);

//okie
admin.post("/register_user", async (req, res) => {
  await backend.registerUserBackend(req, res);
});

//okie
admin.post("/register_ingredient", async (req, res) => {
  await backend.registerIngredientBackend(req, res);
});

//okie
admin.post("/register_meal", async (req, res) => {
  await backend.registerMealBackend(req, res);
});

//okie
admin.post("/register_campaign", async (req, res) => {
  await backend.registerCampaignBackend(req, res);
});

admin.get("/get_ingredients", async (req, res) => {
  res.send(await db.getIngredients());
});

admin.get("/get_meals", async (req, res) => {
  res.send(await db.getMeals());
});

admin.get("/get_users", async (req, res) => {
  res.send(await db.getUsers());
});

app.post("/add_ingredient", async (req, res) => {
  await backend.addIngredientBackend(req, res);
});

app.post("/add_meal", async (req, res) => {
  await backend.addMealBackend(req, res);
});

app.get("/get_campaign", async (req, res) => {
  await backend.getCampaignBackend(req, res);
});

app.post("/get_user_campaign", async (req, res) => {
  await backend.getUserCampaignsBackend(req, res);
});

app.post("/get_station_progress", async (req, res) => {
  await backend.getStationProgressBackend(req, res);
});
app.post("/get_kitchen_progress", async (req, res) => {
  await backend.getKitchenProgressBackend(req, res);
});

app.get("/test", async (req, res) => {
  // await db.addMeal({
  //   campaignId: "65ecbbca43cf6bed9a2f0ddd",
  //   meal: "potato",
  //   quantity: 10,
  //   userId: "65ecbbca43cf6bed9a2f0ddd",
  // });
  res.send();
});

//okie
app.post("/login", async (req, res) => {
  await backend.loginBackend(req, res);
});

app.all("*", (req, res) => {
  res.send({ potato: Date.now() });
});

const server = app.listen(PORT, async () => {
  await db.createIndexes();
  await db.cache();
  console.log("Running: 8080");
  console.log(getDate(true));
});

server.on("upgrade", (req, socket, head) => {
  wss.handleUpgrade(req, socket, head, (ws) => {
    wss.emit("connection", ws, req);
  });
});

wss.on("connection", (ws, req) => {
  let name = req.headers.name as string;
  ws;
  backend.usersWs[name] = ws;
  ws.on("message", (msg, isBinary) => {
    const message = msg.toString();
    if (backend.usersWs.hasOwnProperty(message)) {
      backend.usersWs[message].send("hello " + name);
    } else {
      ws.send(message);
      console.log(backend.usersWs[message]);
    }
  });
});
