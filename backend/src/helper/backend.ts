import { WebSocketJson, json } from "./schema";
import WebSocket from "ws";
import { Response, Request, NextFunction } from "express";
import * as db from "./db";
import * as utility from "./utility";

export let usersWs: WebSocketJson = {};

//okie
export async function loginBackend(req: Request, res: Response) {
  const body = req.body;

  if (Object.keys(body).length == 0) {
    res.status(400).send({ error: "Empty Body" });
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
      res.status(401).send({ error: "Wrong username/password" });
    }
  } else {
    res.status(checkingResult[0]).send({ error: checkingResult[1] });
  }
}

///////////////////////////////////////////////////////////////////////////////////////////

//okie

export async function requestIngredientBackend(req: Request, res: Response) {
  const body = req.body;

  if (Object.keys(body).length == 0) {
    res.status(400).send({ error: "Empty Body" });
    return;
  }
  const checkingResult = utility.checkParameter({
    body: body,
    objectIds: ["campaignId", "stationId"],
    numbers: ["quantity"],
    strings: ["ingredient"],
  });

  if (checkingResult[0] == 200) {
    let result = await db.requestIngredient(body);
    console.log(result);
    res.send(result);
  } else {
    res.status(checkingResult[0]).send({ error: checkingResult[1] });
  }
}

///////////////////////////////////////////////////////////////////////////////////////////

//okie

///////////////////////////////////////////////////////////////////////////////////////////

// TODO continue the function + check rest of parameters

export async function getUserCampaignsBackend(req: Request, res: Response) {
  const body = req.body;

  if (Object.keys(body).length == 0) {
    res.status(400).send({ error: "Empty Body" });
    return;
  }

  const checkingResult = utility.checkParameter({
    body,
    objectIds: ["_id"],
    booleans: ["activated"],
  });

  if (checkingResult[0] == 200) {
    let result = await db.getUserCampaigns(body);
    console.log(result);
    res.send(result);
  } else {
    res.status(checkingResult[0]).send({ error: checkingResult[1] });
  }
}

export async function getCampaignBackend(req: Request, res: Response) {
  const query = req.query;

  if (Object.keys(query).length == 0) {
    res.status(400).send({ error: "Empty Body" });
    return;
  }

  const checkingResult = utility.checkParameter({
    body: query,
    objectIds: ["_id"],
  });

  if (checkingResult[0] == 200) {
    let result = await db.getCampaign(query._id as string);
    console.log(result);
    res.send(result);
  } else {
    res.status(checkingResult[0]).send({ error: checkingResult[1] });
  }
}

///////////////////////////////////////////////////////////////////////////////////////////

// export async function Backend(req: Request, res: Response) {
//   const body = req.body;

//   if (Object.keys(body).length == 0) {
//     res.status(400).send({ error: "Empty Body" });
//     return;
//   }
//   const checkingResult = utility.checkParameter({
//     body: body,
//     objectIds: ["userId","campaignId"],
//     numbers: ["quantity", "plate"],
//     strings: ["type"],
//   });

//   if (checkingResult[0] == 200) {
//     let result = await db.addMeal(body);
//     console.log(result);
//     res.send(result);
//   } else {
//     res.status(checkingResult[0]).send({ error: checkingResult[1] });
//   }
// }

///////////////////////////////////////////////////////////////////////////////////////////

export async function notify(message: string) {
  for (const socket in usersWs) {
    if (usersWs[socket].readyState !== WebSocket.CLOSED) {
      usersWs[socket].send(message);
    }
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
