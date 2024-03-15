import WebSocket from "ws";
import express from "express";
import { getDate } from "./helper/utility";
import * as backend from "./helper/backend";
import * as db from "./helper/db";
import cors from "cors";
import { admin } from "./routes/adminRouter";
import { facilitator } from "./routes/facilitatorRouter";
import { kitchen } from "./routes/kitchenRouter";
import { station } from "./routes/stationRouter";

require("dotenv").config();
const PORT = process.env.PORT || "8080";

const app = express();

const wss = new WebSocket.Server({ noServer: true, path: "/ws" });

// /*
// - station leader will add dish and it should be pushed to db
// - if facilitator accept any thing this thing should be pushed to database
// - my role function :)
// */

app.use(express.json());
app.use(cors());

app.use("/admin", admin);
app.use("/facilitator", facilitator);
app.use("/station", station);
app.use("/kitchen", kitchen);

//okie

app.get("/campaign", async (req, res) => {
  await backend.getCampaignBackend(req, res);
});

app.post("/user_campaign", async (req, res) => {
  await backend.getUserCampaignsBackend(req, res);
});

app.get("/test", async (req, res) => {
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
