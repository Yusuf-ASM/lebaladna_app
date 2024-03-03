import WebSocket from "ws";
import express from "express";
import { getDate } from "./utility";
import { usersWs } from "./backend";

require("dotenv").config();
const PORT = process.env.PORT || "8080";

const app = express();

const wss = new WebSocket.Server({ noServer: true, path: "/ws" });

app.use(express.json());

app.all("*", (req, res) => {
  res.send({ potato: Date.now() });
});

const server = app.listen(PORT, async () => {
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
  ws
  usersWs[name] = ws;
  ws.on("message", (msg, isBinary) => {
    const message = msg.toString();
    if (usersWs.hasOwnProperty(message)) {
      usersWs[message].send("hello " + name);
    } else {
      ws.send(message);
      console.log(usersWs[message]);
    }
  });
});
