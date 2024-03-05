import WebSocket from "ws";
import express from "express";
import { getDate } from "./utility";
import * as backend from "./backend";
import { createIndexes } from "./db";

require("dotenv").config();
const PORT = process.env.PORT || "8080";

const app = express();
const admin = express.Router();
const facilitator = express.Router();
const station = express.Router();

const wss = new WebSocket.Server({ noServer: true, path: "/ws" });
/*
- station leader will add dish and it should be pushed to db 
- if facilitator accept any thing this thing should be pushed to database
- my role function :)
*/
app.use(express.json());
app.use("/admin", admin);

admin.post("/register_user", async (req, res) => {
  await backend.registerUserBackend(req, res);
});

app.post("/login", async (req, res) => {
  await backend.LoginBackend(req, res);
});

facilitator.post("/request_response", (req, res) => {});
station.post("/request", (req, res) => {});
station.post("/add_meal", (req, res) => {});

app.all("*", (req, res) => {
  res.send({ potato: Date.now() });
});

const server = app.listen(PORT, async () => {
  await createIndexes();
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

