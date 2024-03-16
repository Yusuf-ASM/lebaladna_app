import { WebSocketJson, json } from "./schema";
import WebSocket from "ws";
import { Response, Request, NextFunction } from "express";
import * as db from "./db";
import * as utility from "./utility";
import Joi from "joi";

export let usersWs: WebSocketJson = {};

//okie
export async function loginBackend(req: Request, res: Response) {
  const body = req.body;

  const schema = Joi.object({
    password: utility.jString.required(),
    name: utility.jString.required(),
  });

  let validationResult = schema.validate(body);
  console.log("loginBackend:");

  if (validationResult.error === undefined) {
    let result = await db.login(body);
    if (result) {
      res.send(result);
    } else {
      res.status(401).send({ error: "Wrong username/password" });
    }
  } else {
    console.log(JSON.stringify(validationResult.error));
    res.status(400).send({ error: validationResult.error.message });
  }
}

//okie
export async function requestIngredientBackend(req: Request, res: Response) {
  const body = req.body;

  const schema = Joi.object({
    campaignId: utility.jObjectId.required(),
    stationId: utility.jObjectId.required(),
    numbers: utility.jNumber.required(),
    ingredient: utility.jString.required(),
  });

  let validationResult = schema.validate(body);
  console.log("requestIngredientBackend:");

  if (validationResult.error === undefined) {
    let result = await db.requestIngredient(body);
    console.log(result);
    res.send(result);
  } else {
    console.log(JSON.stringify(validationResult.error));
    res.status(400).send({ error: validationResult.error.message });
  }
}

// TODO continue the function + check rest of parameters

export async function getUserCampaignsBackend(req: Request, res: Response) {
  const body = req.body;

  const schema = Joi.object({
    _id: utility.jObjectId.required(),
    activated: Joi.boolean().required(),
  });

  let validationResult = schema.validate(body);
  console.log("getUserCampaignsBackend:");

  if (validationResult.error === undefined) {
    let result = await db.getUserCampaigns(body);
    console.log(result);
    res.send(result);
  } else {
    console.log(JSON.stringify(validationResult.error));
    res.status(400).send({ error: validationResult.error.message });
  }
}

export async function getCampaignBackend(req: Request, res: Response) {
  const query = req.query;

  const schema = Joi.object({
    _id: utility.jObjectId.required(),
  });

  let validationResult = schema.validate(query);
  console.log("getCampaignBackend:");

  if (validationResult.error === undefined) {
    let result = await db.getCampaign(query._id as string);
    console.log(result);
    res.send(result);
  } else {
    console.log(JSON.stringify(validationResult.error));
    res.status(400).send({ error: validationResult.error.message });
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

//   if (validationResult.error === undefined) {
//     let result = await db.addMeal(body);
//     console.log(result);
//     res.send(result);
//   } else {
//     console.log(JSON.stringify(validationResult.error));
// res.status(400).send({ error: validationResult.error.message });
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
