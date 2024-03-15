import { Request, Response } from "express";
import * as db from "../helper/db";
import * as utility from "../helper/utility";
import Joi from "joi";
import { notify } from "../helper/backend";

export async function addMealBackend(req: Request, res: Response) {
  const body = req.body;

  // TODO campaignId is missing
  const schema = Joi.object({
    password: Joi.string().trim().required(),
    name: Joi.string().trim().required(),
    meal: Joi.string().trim().required(),
    quantity: Joi.number().required(),
  });

  let validationResult = schema.validate(body);

  if (validationResult.error === undefined) {
    let result = await db.addMeal(body);
    await notify("station");
    console.log(result);
    res.send(result);
  } else {
    res.status(400).send({ error: validationResult.error.message });
  }
}

export async function getStationProgressBackend(req: Request, res: Response) {
  const body = req.body;

  // TODO campaignId validation is missing
  const schema = Joi.object({
    campaignId: Joi.string().required(),
    stationName: Joi.string().required(),
  });

  let validationResult = schema.validate(body);

  if (validationResult.error === undefined) {
    let result = await db.getStationProgress(body);
    console.log(result);
    if (result != null) {
      res.send(result);
    } else {
      res.status(404).send({ error: "Not Found" });
    }
  } else {
    res.status(400).send({ error: validationResult.error.message });
  }
}
