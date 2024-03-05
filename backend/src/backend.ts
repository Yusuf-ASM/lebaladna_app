import { WebSocketJson } from "schema";
import { Response, Request, NextFunction } from "express";
import * as db from "./db";
import * as utility from "./utility";

export let usersWs: WebSocketJson = {};

export async function registerUserBackend(req: Request, res: Response) {
  const body = req.body;

  if (Object.keys(body).length == 0) {
    res.sendStatus(400);
    return;
  }

  let checkingResult = utility.checkParameter({
    body: body,
    strings: ["password", "name"],
  });

  if (checkingResult[0] == 200) {
    let result = await db.registerUser(body);
    if (result) {
      res.send(result);
    } else {
      res.sendStatus(401);
    }
  } else {
    res.status(checkingResult[0]).send({ error: checkingResult[1] });
  }
}

export async function LoginBackend(req: Request, res: Response) {
  const body = req.body;

  if (Object.keys(body).length == 0) {
    res.sendStatus(400);
    return;
  }

  let checkingResult = utility.checkParameter({
    body: body,
    strings: ["password", "name"],
  });

  if (checkingResult[0] == 200) {
    let result = await db.login(body);
    if (result) {
      res.send(result);
    } else {
      res.sendStatus(401);
    }
  } else {
    res.status(checkingResult[0]).send({ error: checkingResult[1] });
  }
}

async function ping() {
  for (const socket in usersWs) {
    if (usersWs[socket].readyState !== WebSocket.CLOSED) {
      usersWs[socket].send(0);
    } else {
      delete usersWs[socket];
    }
  }
}

setInterval(async () => await ping(), 60 * 1000);
