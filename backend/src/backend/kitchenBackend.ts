import { Request, Response } from "express";
import * as db from "../helper/db";
import * as utility from "../helper/utility";
import Joi from "joi";
import { notify } from "../helper/backend";

export async function addIngredientBackend(req: Request, res: Response) {
  const body = req.body;

  const schema = Joi.object({
    campaignId: utility.jObjectId.required(),
    quantity: utility.jNumber.required(),
    plate: utility.jNumber.required(),
    ingredient: utility.jString.required(),
  });

  let validationResult = schema.validate(body);
  console.log("addIngredientBackend:");

  if (validationResult.error === undefined) {
    let result = await db.addIngredient(body);
    await notify("kitchen");
    console.log(result);
    res.send(result);
  } else {
    console.log(JSON.stringify(validationResult.error));
    res.status(400).send({ error: validationResult.error.message });
  }
}

export async function getKitchenProgressBackend(req: Request, res: Response) {
  const body = req.params;

  const schema = Joi.object({
    campaignId: utility.jObjectId.required(),
  });

  let validationResult = schema.validate(body);
  console.log("getKitchenProgressBackend:");

  if (validationResult.error === undefined) {
    let result = await db.getKitchenProgress(body.campaignId);
    console.log(result);
    if (result != null) {
      res.send(result);
    } else {
      res.status(404).send({ error: "Not Found" });
    }
  } else {
    console.log(JSON.stringify(validationResult.error));
    res.status(400).send({ error: validationResult.error.message });
  }
}
